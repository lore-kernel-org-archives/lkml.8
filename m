Return-Path: <SRS0=728o=CL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70517C433E6
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:26:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 565002072A
	for <linux-kernel@archiver.kernel.org>; Wed,  2 Sep 2020 07:26:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726882AbgIBH0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 2 Sep 2020 03:26:14 -0400
Received: from mx2.suse.de ([195.135.220.15]:59688 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726140AbgIBH0N (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Sep 2020 03:26:13 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id ECBC8AD52;
        Wed,  2 Sep 2020 07:26:12 +0000 (UTC)
Date:   Wed, 2 Sep 2020 09:26:11 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>
Subject: Re: linux-next: Fixes tags need some work in the printk tree
Message-ID: <20200902072610.GA9496@alley>
References: <20200902072254.3054db47@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200902072254.3054db47@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Stephen,

On Wed 2020-09-02 07:22:54, Stephen Rothwell wrote:
> Hi all,
> 
> In commits
> 
>   e5e4c07d9233 ("docs: vmcoreinfo: add lockless printk ringbuffer vmcoreinfo")
>   0cfdacd74ad5 ("scripts/gdb: update for lockless printk ringbuffer")
> 
> Fixes tag
> 
>   Fixes: ("printk: use the lockless ringbuffer")

The problem is that this commit is not in mainline. It is living
only in printk/linux.git.

> 
> has these problem(s):
> 
>   - No SHA1 recognised

Could we use the SHA1 from the maintainer tree when it would not get rebased?

Or should we rather avoid Fixes: tag referencing commits that are not
in mainline?

I am sorry to bother you with this silly question. I do not see any
hint in Documentation/process/submitting-patches.rst.

Best Regards,
Petr
