Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96EA3C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 03:35:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7D2FA20780
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 03:35:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731356AbgFWDfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 23:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728526AbgFWDfV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 23:35:21 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 864D2C061573;
        Mon, 22 Jun 2020 20:35:21 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477::3d5])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 7AD43120F93F8;
        Mon, 22 Jun 2020 20:35:19 -0700 (PDT)
Date:   Mon, 22 Jun 2020 20:35:16 -0700 (PDT)
Message-Id: <20200622.203516.1857672250009821997.davem@davemloft.net>
To:     christian.brauner@ubuntu.com
Cc:     linux-kernel@vger.kernel.org, torvalds@linux-foundation.org,
        arnd@arndb.de, guoren@kernel.org, linux-csky@vger.kernel.org,
        sparclinux@vger.kernel.org
Subject: Re: [PATCH 02/17] sparc64: enable HAVE_COPY_THREAD_TLS
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200622234326.906346-3-christian.brauner@ubuntu.com>
References: <20200622234326.906346-1-christian.brauner@ubuntu.com>
        <20200622234326.906346-3-christian.brauner@ubuntu.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Mon, 22 Jun 2020 20:35:19 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Tue, 23 Jun 2020 01:43:11 +0200

> diff --git a/arch/sparc/kernel/syscalls.S b/arch/sparc/kernel/syscalls.S
> index db42b4fb3708..192f3a28a2b7 100644
> --- a/arch/sparc/kernel/syscalls.S
> +++ b/arch/sparc/kernel/syscalls.S
> @@ -86,19 +86,22 @@ sys32_rt_sigreturn:
>  	 * during system calls...
>  	 */
>  	.align	32
> -sys_vfork: /* Under Linux, vfork and fork are just special cases of clone. */
> -	sethi	%hi(0x4000 | 0x0100 | SIGCHLD), %o0
> -	or	%o0, %lo(0x4000 | 0x0100 | SIGCHLD), %o0
> -	ba,pt	%xcc, sys_clone
> +sys_vfork:
> +	flushw
> +	ba,pt	%xcc, sparc_vfork
> +	add	%sp, PTREGS_OFF, %o0

Please indent branch delay slot instructions with one extra space, as
was done in the code you are changing.

> +	ba,pt	%xcc, sparc_fork
> +	add	%sp, PTREGS_OFF, %o0

Likewise.

> +	ba,pt	%xcc, sparc_clone
> +	add	%sp, PTREGS_OFF, %o0

Likewise.
