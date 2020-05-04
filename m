Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0190EC3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:51:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCFCB206B9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:51:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729357AbgEDPve (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:51:34 -0400
Received: from mx2.suse.de ([195.135.220.15]:48040 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726509AbgEDPvd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:51:33 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 46BCEAFAC;
        Mon,  4 May 2020 15:51:34 +0000 (UTC)
Date:   Mon, 4 May 2020 17:51:30 +0200
From:   Joerg Roedel <jroedel@suse.de>
To:     Mathieu Desnoyers <mathieu.desnoyers@efficios.com>
Cc:     rostedt <rostedt@goodmis.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Borislav Petkov <bp@alien8.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Shile Zhang <shile.zhang@linux.alibaba.com>,
        Andy Lutomirski <luto@amacapital.net>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Tzvetomir Stoyanov <tz.stoyanov@gmail.com>
Subject: Re: [PATCH] percpu: Sync vmalloc mappings in pcpu_alloc() and
 free_percpu()
Message-ID: <20200504155130.GK8135@suse.de>
References: <20200429054857.66e8e333@oasis.local.home>
 <20200430191434.GC8135@suse.de>
 <20200430211308.74a994dc@oasis.local.home>
 <1902703609.78863.1588300015661.JavaMail.zimbra@efficios.com>
 <20200430223919.50861011@gandalf.local.home>
 <20200504151236.GI8135@suse.de>
 <99290786.82178.1588606126392.JavaMail.zimbra@efficios.com>
 <20200504153135.GJ8135@suse.de>
 <1533922227.82188.1588606723786.JavaMail.zimbra@efficios.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1533922227.82188.1588606723786.JavaMail.zimbra@efficios.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 11:38:43AM -0400, Mathieu Desnoyers wrote:
> ----- On May 4, 2020, at 11:31 AM, Joerg Roedel jroedel@suse.de wrote:
> > Tried this before, actually I put it into the caller of
> > pcpu_mem_zalloc(), but that didn't fix the problem for me. Stevens
> > test-case still hangs the machine.
> 
> That's unexpected.
> 
> Did you confirm that those hangs were also caused by percpu allocations ?

No, I didn't dig deeper on that hang. I can probably do tomorrow.


Regards,

	Joerg
