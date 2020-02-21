Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 739F4C35646
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:14:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 52EA52073A
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 14:14:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728803AbgBUOOh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 09:14:37 -0500
Received: from verein.lst.de ([213.95.11.211]:55653 "EHLO verein.lst.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727851AbgBUOOg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 09:14:36 -0500
Received: by verein.lst.de (Postfix, from userid 2407)
        id 3716C68C4E; Fri, 21 Feb 2020 15:14:34 +0100 (CET)
Date:   Fri, 21 Feb 2020 15:14:33 +0100
From:   Christoph Hellwig <hch@lst.de>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, kernel-team@android.com,
        akpm@linux-foundation.org,
        "K . Prasad" <prasad@linux.vnet.ibm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Christoph Hellwig <hch@lst.de>,
        Quentin Perret <qperret@google.com>,
        Alexei Starovoitov <ast@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: Re: [PATCH 3/3] kallsyms: Unexport kallsyms_lookup_name() and
 kallsyms_on_each_symbol()
Message-ID: <20200221141433.GD6968@lst.de>
References: <20200221114404.14641-1-will@kernel.org> <20200221114404.14641-4-will@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200221114404.14641-4-will@kernel.org>
User-Agent: Mutt/1.5.17 (2007-11-01)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 21, 2020 at 11:44:04AM +0000, Will Deacon wrote:
> kallsyms_lookup_name() and kallsyms_on_each_symbol() are exported to
> modules despite having no in-tree users and being wide open to abuse by
> out-of-tree modules that can use them as a method to invoke arbitrary
> non-exported kernel functions.
> 
> Unexport kallsyms_lookup_name() and kallsyms_on_each_symbol().

Looks good,

Reviewed-by: Christoph Hellwig <hch@lst.de>
