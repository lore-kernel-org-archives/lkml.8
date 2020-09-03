Return-Path: <SRS0=vQOp=CM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 48243C43461
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:48:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FE5420709
	for <linux-kernel@archiver.kernel.org>; Thu,  3 Sep 2020 09:48:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728141AbgICJsm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 3 Sep 2020 05:48:42 -0400
Received: from mx2.suse.de ([195.135.220.15]:60320 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726047AbgICJsl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Sep 2020 05:48:41 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.221.27])
        by mx2.suse.de (Postfix) with ESMTP id C720BAB9F;
        Thu,  3 Sep 2020 09:48:39 +0000 (UTC)
Date:   Thu, 3 Sep 2020 11:48:37 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        John Ogness <john.ogness@linutronix.de>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>
Subject: Re: linux-next: Fixes tags need some work in the printk tree
Message-ID: <20200903091436.GA5012@alley>
References: <20200902072254.3054db47@canb.auug.org.au>
 <20200902072610.GA9496@alley>
 <20200903065547.0cc6f53b@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200903065547.0cc6f53b@canb.auug.org.au>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2020-09-03 06:55:47, Stephen Rothwell wrote:
> Hi Petr,
> 
> On Wed, 2 Sep 2020 09:26:11 +0200 Petr Mladek <pmladek@suse.com> wrote:
> > 
> > The problem is that this commit is not in mainline. It is living
> > only in printk/linux.git.
> > 
> > Could we use the SHA1 from the maintainer tree when it would not get rebased?
> > 
> > Or should we rather avoid Fixes: tag referencing commits that are not
> > in mainline?
> > 
> > I am sorry to bother you with this silly question. I do not see any
> > hint in Documentation/process/submitting-patches.rst.
> 
> Well, in theory, maintainers trees should not be rebased after they
> have been published (except in exceptional circumstances), so using
> SHA1s from them should be OK.  Especially if the fixing commit is in
> the same maintainers tree (which it should be, right).  It does mean
> that maintainers need to be a bit more careful if they do rebase their
> trees to update any Fixes tags (or other commit references) that are
> affected by the rebase.

Thanks a lot for info.

I have rebased the last 5 commits in the printk-rework branch and
added the missing SHAs there.

Best Regards,
Petr
