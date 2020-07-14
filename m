Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=BAYES_00,
	BUG6152_INVALID_DATE_TZ_ABSURD,DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,INVALID_DATE_TZ_ABSURD,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FE74C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:09:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CCFF22224
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 12:09:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="RUqv8y8s";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="FCR/1Lnl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728109AbgGNMJs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 08:09:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60462 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727867AbgGNMJs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 08:09:48 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09A43C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 05:09:48 -0700 (PDT)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594728586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sd6FY7HyKBhACYNltviUNZjUxd7/V5m5zWZgt4T/m9Q=;
        b=RUqv8y8sPePXSkyq+Rn4hmSWmuiz+TQvQasZ1VMTEj/noj7LQpgIhkjXzjHwHulWrGpAN1
        HCV/kg+18Uv9n+r6pw8L3x286QT3LOIP/ysGaV/c08dZe7iPTRAZ1HdzHfP/jN4a3wUZNw
        tiEd8ahMAN1mMU0ZmJLSy5wTrWAFFz7lED9i7cs9VxZLRAbhaDEbvxCj3gGPwFN+DMulg4
        gmuaytAh91WHqNu1b1LS1c3EwSiCuoaFZhXlXUZwKR5b+soo00IIdICDWm+a78kHlc92GA
        7MXGKlSqOqL875MumHSNA3Uw1382LWHYcJOLLKejgfe545Nf10kpPPqE9lGAbQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594728586;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Sd6FY7HyKBhACYNltviUNZjUxd7/V5m5zWZgt4T/m9Q=;
        b=FCR/1LnlZFw9wBBdwn7/QZ1PiZSb98DEKIeGUs1qiUOvAh4HZDr6ffCO37QnRT0wDgCTPm
        0lflNyFrC50WhVDg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] MAINTAIERS: Add John Ogness as printk reviewer
In-Reply-To: <20200714072337.GE20226@alley>
References: <20200710094432.19655-1-pmladek@suse.com> <20200714072337.GE20226@alley>
Date:   Tue, 14 Jul 2020 14:15:45 +0206
Message-ID: <87v9iqmh6e.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-10, Petr Mladek <pmladek@suse.com> wrote:
> John Ogness has started major rework of the printk code. Add him
> as reviewer so that he is aware of all other coming changes and
> could influence their integration.
> 
> Signed-off-by: Petr Mladek <pmladek@suse.com>

The rework still has a long road ahead of it, but I am happy to formerly
assist with future printk work. It is an honor to work together with you
guys.

Acked-by: John Ogness <john.ogness@linutronix.de>

> ---
>  MAINTAINERS | 1 +
>  1 file changed, 1 insertion(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 1d4aa7f942de..8e82d9db2a21 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -13770,6 +13770,7 @@ PRINTK
>  M:	Petr Mladek <pmladek@suse.com>
>  M:	Sergey Senozhatsky <sergey.senozhatsky@gmail.com>
>  R:	Steven Rostedt <rostedt@goodmis.org>
> +R:	John Ogness <john.ogness@linutronix.de>
>  S:	Maintained
>  F:	include/linux/printk.h
>  F:	kernel/printk/
> -- 
> 2.26.2
