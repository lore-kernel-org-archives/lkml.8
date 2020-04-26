Return-Path: <SRS0=PEot=6K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E49E6C2BA1A
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 06:53:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B89CF2071C
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Apr 2020 06:53:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1587884009;
	bh=ocyXOAlF5MJp6iFfXegqRFvhLRY7Eu71pUrCpQNg5aY=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=OxdkEXBd20bUfFdAsNSybObEoDVCYthfvLvkTAt4MOM+8TtjY7gd/t4sywo/GP6UY
	 NacaAgBuZq5USjN65e0VNCrH24YB3YmGCRSUsphFB+Y6PgRwgmLPsziwWz88n1Frnq
	 ruoi8lyxjLEnonKHKsj1KWsmKlCSBUdFuWmE40Ds=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgDZGx2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Apr 2020 02:53:28 -0400
Received: from mail.kernel.org ([198.145.29.99]:55456 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725864AbgDZGx2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Apr 2020 02:53:28 -0400
Received: from devnote2 (NE2965lan1.rev.em-net.ne.jp [210.141.244.193])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 2C0762070A;
        Sun, 26 Apr 2020 06:53:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1587884008;
        bh=ocyXOAlF5MJp6iFfXegqRFvhLRY7Eu71pUrCpQNg5aY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=0QGxkdtIZCC/7znYOukkDxqYTosWvgsXXWe3UJ1w+yUFCcfAkIyfFZPcM7Lx6U0Cl
         YQ3jQr3egOr8OYHWpmQ8pzVQTpJ1Bf3MxtX6SXSDuUc/X3uxCVUT4excETplpVrUhb
         Nu1DWfF5FsK5POAE/jExS6sANTYJHbrUzWNg73SQ=
Date:   Sun, 26 Apr 2020 15:53:23 +0900
From:   Masami Hiramatsu <mhiramat@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Borislav Petkov <bp@alien8.de>, Kees Cook <keescook@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [BUGFIX PATCH 1/1] bootconfig: Fix to remove bootconfig data
 from initrd while boot
Message-Id: <20200426155323.9c68b487ea7c289e12c22484@kernel.org>
In-Reply-To: <20200424195833.1487a1a0@oasis.local.home>
References: <158774604073.7423.11492815214537711118.stgit@devnote2>
        <158774605193.7423.573803007569761807.stgit@devnote2>
        <20200424195833.1487a1a0@oasis.local.home>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 24 Apr 2020 19:58:33 -0400
Steven Rostedt <rostedt@goodmis.org> wrote:

> On Sat, 25 Apr 2020 01:34:12 +0900
> Masami Hiramatsu <mhiramat@kernel.org> wrote:
> 
> > If there is a bootconfig data in the tail of initrd/initramfs,
> > initrd image sanity check caused an error while decompression
> > stage as follows.
> > 
> > [    0.883882] Unpacking initramfs...
> > [    2.696429] Initramfs unpacking failed: invalid magic at start of compressed archive
> > 
> > This error will be ignored if CONFIG_BLK_DEV_RAM=n,
> > but CONFIG_BLK_DEV_RAM=y the kernel failed to mount rootfs
> > and causes a panic.
> > 
> > To fix this issue, shrink down the initrd_end for removing
> > tailing bootconfig data while boot the kernel.
> > 
> > Fixes: 7684b8582c24 ("bootconfig: Load boot config from the tail of initrd")
> > Signed-off-by: Masami Hiramatsu <mhiramat@kernel.org>
> > Cc: stable@vger.kernel.org
> > ---
> >  init/main.c |   62 +++++++++++++++++++++++++++++++++++++++++++----------------
> >  1 file changed, 45 insertions(+), 17 deletions(-)
> > 
> > 
> 
> A build with
> 
>  $ make allnoconfig
> 
> Produces this:
> 
>   MODPOST vmlinux.o
>   MODINFO modules.builtin.modinfo
>   GEN     modules.builtin
>   LD      vmlinux
> ld: init/main.o: in function `start_kernel':
> main.c:(.init.text+0x37f): undefined reference to `initrd_end'
> ld: main.c:(.init.text+0x3a7): undefined reference to `initrd_start'
> ld: main.c:(.init.text+0x3ae): undefined reference to `initrd_end'
> make[1]: *** [/work/git/linux-trace.git/Makefile:1106: vmlinux] Error 1

Oops, that depends on initrd. OK, I'll fix it.

Thanks!

-- 
Masami Hiramatsu <mhiramat@kernel.org>
