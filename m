Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 009A2C43461
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:41:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DA4EC207EA
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 15:41:06 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726312AbgIBNon (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 09:44:43 -0400
Received: from verein.lst.de ([213.95.11.211]:60096 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726293AbgIBNcj (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 09:32:39 -0400
Received: by verein.lst.de (Postfix, from userid 2407)
        id 5CF9468B05; Wed,  2 Sep 2020 15:32:31 +0200 (CEST)
Date:   Wed, 2 Sep 2020 15:32:31 +0200
From:   Christoph Hellwig <hch@lst.de>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Christoph Hellwig <hch@lst.de>,
        Josh Poimboeuf <jpoimboe@redhat.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@zeniv.linux.org.uk>,
        Will Deacon <will@kernel.org>,
        Dan Williams <dan.j.williams@intel.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        Andy Lutomirski <luto@kernel.org>
Subject: Re: [PATCH] x86/uaccess: Use pointer masking to limit uaccess
 speculation
Message-ID: <20200902133231.GA32133@lst.de>
References: <f12e7d3cecf41b2c29734ea45a393be21d4a8058.1597848273.git.jpoimboe@redhat.com> <20200901140208.GA95447@C02TD0UTHF1T.local> <20200901144641.GA28580@lst.de> <20200901145442.GC95447@C02TD0UTHF1T.local> <20200901150553.GA30034@lst.de> <20200901154629.GA882@lst.de> <20200902114348.GA1002@C02TD0UTHF1T.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902114348.GA1002@C02TD0UTHF1T.local>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 02, 2020 at 12:43:48PM +0100, Mark Rutland wrote:
> I'll see what I can do.
> 
> At first glance it looks like we might need to flesh out or refactor the
> arm64 kernel maccess routines first (since we want the user maccess
> routines to use LDTR/STTR instructions that can't access kernel memory),
> but after that I think the rest is largely mechanical.

Yes, the first thing is to implement __get_kernel_nofaul and
__put_kernel_nofault.  I think they should mostly look like the existing
non-UAO versions of get_user and put_user with a fixed address space
limit.
