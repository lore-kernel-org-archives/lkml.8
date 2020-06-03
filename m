Return-Path: <SRS0=boYM=7Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E305BC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 20:53:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C536C2067B
	for <linux-kernel@archiver.kernel.org>; Wed,  3 Jun 2020 20:53:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726287AbgFCUxh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 3 Jun 2020 16:53:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59414 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725922AbgFCUxg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Jun 2020 16:53:36 -0400
Received: from ZenIV.linux.org.uk (zeniv.linux.org.uk [IPv6:2002:c35c:fd02::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59775C08C5C0
        for <linux-kernel@vger.kernel.org>; Wed,  3 Jun 2020 13:53:36 -0700 (PDT)
Received: from viro by ZenIV.linux.org.uk with local (Exim 4.93 #3 (Red Hat Linux))
        id 1jgaOC-002fGO-7d; Wed, 03 Jun 2020 20:53:32 +0000
Date:   Wed, 3 Jun 2020 21:53:32 +0100
From:   Al Viro <viro@zeniv.linux.org.uk>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [git pull] misc uaccess stuff
Message-ID: <20200603205332.GC23230@ZenIV.linux.org.uk>
References: <20200603192306.GX23230@ZenIV.linux.org.uk>
 <20200603204439.GA2649647@ubuntu-n2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200603204439.GA2649647@ubuntu-n2-xlarge-x86>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 01:44:39PM -0700, Nathan Chancellor wrote:
> > ----------------------------------------------------------------
> > Al Viro (9):
> >       pselect6() and friends: take handling the combined 6th/7th args into helper
> >       binfmt_elf: don't bother with __{put,copy_to}_user()
> >       binfmt_elf_fdpic: don't use __... uaccess primitives
> 
> This patch breaks arm32:
> 
> $ make -sj"$(nproc)" ARCH=arm CROSS_COMPILE=arm-linux-gnueabi- allyesconfig fs/binfmt_elf_fdpic.o
> ...
> In file included from ./include/linux/sched/task.h:11,
>                  from ./include/linux/sched/signal.h:9,
>                  from ./include/linux/rcuwait.h:6,
>                  from ./include/linux/percpu-rwsem.h:7,
>                  from ./include/linux/fs.h:34,
>                  from fs/binfmt_elf_fdpic.c:11:
> ./include/linux/uaccess.h:149:1: note: declared here
>   149 | copy_to_user(void __user *to, const void *from, unsigned long n)
>       | ^~~~~~~~~~~~
> fs/binfmt_elf_fdpic.c:612:7: error: too few arguments to function 'copy_to_user'
>   612 |   if (copy_to_user(ent + nr, &v))    \
>       |       ^~~~~~~~~~~~
> fs/binfmt_elf_fdpic.c:659:2: note: in expansion of macro 'NEW_AUX_ENT'
>   659 |  NEW_AUX_ENT(AT_EXECFN, bprm->exec);
>       |  ^~~~~~~~~~~

Linus, consider that pull request withdrawn for now, please.  My apologies -
I'll push a fixed variant and resend after a week of having it sit in -next.
