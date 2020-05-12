Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 77F40C2D0F7
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 20:05:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 540A120784
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 20:05:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731137AbgELUFL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 16:05:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731077AbgELUFK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 16:05:10 -0400
Received: from shards.monkeyblade.net (shards.monkeyblade.net [IPv6:2620:137:e000::1:9])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C101BC061A0C;
        Tue, 12 May 2020 13:04:58 -0700 (PDT)
Received: from localhost (unknown [IPv6:2601:601:9f00:477:9e51:a893:b0fe:602a])
        (using TLSv1 with cipher AES256-SHA (256/256 bits))
        (Client did not present a certificate)
        (Authenticated sender: davem-davemloft)
        by shards.monkeyblade.net (Postfix) with ESMTPSA id 2328412836EE4;
        Tue, 12 May 2020 13:04:58 -0700 (PDT)
Date:   Tue, 12 May 2020 13:04:57 -0700 (PDT)
Message-Id: <20200512.130457.1412393753257936462.davem@davemloft.net>
To:     christian.brauner@ubuntu.com
Cc:     arnd@arndb.de, guoren@kernel.org, linux-csky@vger.kernel.org,
        linux-kernel@vger.kernel.org, sparclinux@vger.kernel.org
Subject: Re: [PATCH 1/3] sparc64: enable HAVE_COPY_THREAD_TLS
From:   David Miller <davem@davemloft.net>
In-Reply-To: <20200512171527.570109-2-christian.brauner@ubuntu.com>
References: <20200512171527.570109-1-christian.brauner@ubuntu.com>
        <20200512171527.570109-2-christian.brauner@ubuntu.com>
X-Mailer: Mew version 6.8 on Emacs 26.3
Mime-Version: 1.0
Content-Type: Text/Plain; charset=us-ascii
Content-Transfer-Encoding: 7bit
X-Greylist: Sender succeeded SMTP AUTH, not delayed by milter-greylist-4.5.12 (shards.monkeyblade.net [149.20.54.216]); Tue, 12 May 2020 13:04:58 -0700 (PDT)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Christian Brauner <christian.brauner@ubuntu.com>
Date: Tue, 12 May 2020 19:15:25 +0200

> +sys_vfork:
> +	flushw
> +	ba,pt	%xcc, sparc_vfork
> +	add	%sp, PTREGS_OFF, %o0

Please follow the convention of indenting an extra space before
instructions in the delay slot of branch instructions.

> +	ba,pt	%xcc, sparc_fork
> +	add	%sp, PTREGS_OFF, %o0

Likewise.

>  sys_clone:
>  	flushw
> -	movrz	%o1, %fp, %o1
> -	mov	0, %o3
> -	ba,pt	%xcc, sparc_do_fork
> -	 add	%sp, PTREGS_OFF, %o2
> +	ba,pt	%xcc, sparc_clone
> +	add	%sp, PTREGS_OFF, %o0

Likewise.
