Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E418BC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:51:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BA60A2075D
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 07:51:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597045873;
	bh=q5CZW4ks9HjFyBVa9yMvpmOr3Z/RaA3V+mBOchHX15w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=W233DO3xJUKGwgQHmw9vNZ1ZGd2WJSLTxaMiJT3yWzCo/3IAe/pX+lOIAX5b+ultf
	 gemhSmfmWofsFXorQE9zpX1ZJZgu6BztqwRcxc38HpHRivVQ0Cvov2ZhcmjwUMq4Qo
	 MeqgV/q/I1sz0FR5S4C1TptXBa09bNirb+dAa11c=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726596AbgHJHvL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 03:51:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:56272 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725894AbgHJHvL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 03:51:11 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 4A8002065C;
        Mon, 10 Aug 2020 07:51:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597045870;
        bh=q5CZW4ks9HjFyBVa9yMvpmOr3Z/RaA3V+mBOchHX15w=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=eEYcELBkEOs0VxCvxZK8cQ6ytyGVHz8tULZJJedd3px8h0C/ObCYgwAK9w7rbZpa6
         vL20Gh+xgLPg5Jw0UHfDzcNZLHRnftV0UoJ3qar4e935tqe6snJgqPdDbz98RXlaQy
         BoRwH118dS3MOQ8wgmQKGnWTZKTdlpugwiBqET/g=
Date:   Mon, 10 Aug 2020 09:51:22 +0200
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     Jiri Slaby <jirislaby@kernel.org>,
        James Bond <jameslouisebond@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Kees Cook <keescook@chromium.org>,
        Michel Lespinasse <walken@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Denis Efremov <efremov@linux.com>,
        linux-kernel@vger.kernel.org, Ben Hutchings <ben@decadent.org.uk>
Subject: Re: [PATCH] tty/vt: fix a memory leak in con_insert_unipair
Message-ID: <20200810075122.GA1531406@kroah.com>
References: <20200809221453.10235-1-jameslouisebond@gmail.com>
 <dd4ac5db-9ae7-fbf7-535b-c0d3fa098942@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <dd4ac5db-9ae7-fbf7-535b-c0d3fa098942@kernel.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 07:16:48AM +0200, Jiri Slaby wrote:
> On 10. 08. 20, 0:14, James Bond wrote:
> > Syzkaller find a memory leak in con_insert_unipair:
> >     BUG: memory leak
> >     unreferenced object 0xffff88804893d100 (size 256):
> >     comm "syz-executor.3", pid 16154, jiffies 4295043307 (age 2392.340s)
> >     hex dump (first 32 bytes):
> >     80 af 88 4e 80 88 ff ff 00 a8 88 4e 80 88 ff ff  ...N.......N....
> >     80 ad 88 4e 80 88 ff ff 00 aa 88 4e 80 88 ff ff  ...N.......N....
> >     backtrace:
> >     [<00000000f76ff1de>] kmalloc include/linux/slab.h:555 [inline]
> >     [<00000000f76ff1de>] kmalloc_array include/linux/slab.h:596 [inline]
> >     [<00000000f76ff1de>] con_insert_unipair+0x9e/0x1a0 drivers/tty/vt/consolemap.c:482
> >     [<000000002f1ad7da>] con_set_unimap+0x244/0x2a0 drivers/tty/vt/consolemap.c:595
> >     [<0000000046ccb106>] do_unimap_ioctl drivers/tty/vt/vt_ioctl.c:297 [inline]
> >     [<0000000046ccb106>] vt_ioctl+0x863/0x12f0 drivers/tty/vt/vt_ioctl.c:1018
> >     [<00000000db1577ff>] tty_ioctl+0x4cd/0xa30 drivers/tty/tty_io.c:2656
> >     [<00000000e5cdf5ed>] vfs_ioctl fs/ioctl.c:48 [inline]
> >     [<00000000e5cdf5ed>] ksys_ioctl+0xa6/0xd0 fs/ioctl.c:753
> >     [<00000000fb4aa12c>] __do_sys_ioctl fs/ioctl.c:762 [inline]
> >     [<00000000fb4aa12c>] __se_sys_ioctl fs/ioctl.c:760 [inline]
> >     [<00000000fb4aa12c>] __x64_sys_ioctl+0x1a/0x20 fs/ioctl.c:760
> >     [<00000000f561f260>] do_syscall_64+0x4c/0xe0 arch/x86/entry/common.c:384
> >     [<0000000056206928>] entry_SYSCALL_64_after_hwframe+0x44/0xa9
> >     BUG: leak checking failed
> > 
> > To fix this issue, we need to release the pointer p1 when the call of
> > the function kmalloc_array fail.
> 
> This reminds me of:
> commit 15b3cd8ef46ad1b100e0d3c7e38774f330726820
> Author: Ben Hutchings <ben@decadent.org.uk>
> Date:   Tue Jun 4 19:00:39 2019 +0100
> 
>     Revert "consolemap: Fix a memory leaking bug in
> drivers/tty/vt/consolemap.c"
> 
>     This reverts commit 84ecc2f6eb1cb12e6d44818f94fa49b50f06e6ac.
> 
> 
> 
> So NACK.

I have a whole talk just about the "fun" involved with that change:
	https://kernel-recipes.org/en/2019/talks/cves-are-dead-long-live-the-cve/

> Do we have some annotations for this instead?

We need something there, a comment saying "this is fine, don't touch
it!" or something like that?  We need that in a few other places in the
vt code as well.

> > Signed-off-by: James Bond <jameslouisebond@gmail.com>

Nice name...

James, can you mark this syzbot report as "invalid" or something like
that please so that this does not come up again and again.

thanks,

greg k-h
