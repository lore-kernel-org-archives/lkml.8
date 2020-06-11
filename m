Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	FAKE_REPLY_C,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E443C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:23:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 64AA22078D
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 13:23:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ONIadxni"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728054AbgFKNX0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 09:23:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49816 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726249AbgFKNXZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 09:23:25 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13974C03E96F;
        Thu, 11 Jun 2020 06:23:24 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id u5so2541420pgn.5;
        Thu, 11 Jun 2020 06:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:mime-version
         :content-disposition:user-agent;
        bh=RliHtgH5GDZJdW6O7rVVUMcVWe1UZPdPGel4Uc/IOKA=;
        b=ONIadxniVwOEeGtZIyrvAdqpL/WumnU/TUOG0bhC3ydZsb4LKNC7NtBgOlP4EjuhGh
         WOF7UX1gFinqhibJ602iAs7NCiag5HrOBFDEokwWKN7er/SEtABwh17I93Ltt9VfsE0f
         MYBDAqfiSmIDe0g/B2qzR6WazeETN2ZYGJr04TXj2YVxTK2HOwErd4wRWgJbqLafuxC1
         bL1q5luzmET2we4GWr1MhjdLGbxgmqlclX/MwTX8xIxuXDrf+Q1N15tAJQtcttX1m7rm
         cVtbtuX2HzRHc202uZkLAlmEB7zlkYW1Jfvlil3tymZpXcRDW53X0JbcNVZ77i8plind
         uSOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :mime-version:content-disposition:user-agent;
        bh=RliHtgH5GDZJdW6O7rVVUMcVWe1UZPdPGel4Uc/IOKA=;
        b=blQ0qAULeaUtbFhKDI9uuoOiL3RU3LQFgCMOibV9n9kibRpZaANchAjhgH6Gw7hace
         69lLwmQxYUUq+eXogYR5FZc50RIvUxJ1L/IFckJ7JgUxSqpBSr9hyOjVh6lOSzXSogzq
         5hYHJUa/92XLBLszK8FEjTGDESsjHlJG/9VChHFiOtJsJQRcm8hnFmqBI4chFRUy95Ue
         tymEcfDek+5VVsFWfg2wlaAxFVlKDZzG4PyligrYufSVY4c0IMY6RcE9VhnYxiJPi23N
         gRtFJHcFhyxQxd3C7cD+QP1gi7QB8C9W/q5ex1l2Xdd3mK9imJEFro81SuReacZfLwb5
         UKgA==
X-Gm-Message-State: AOAM530arwOqmTElKcKX86JsXfEg4FuZ89kRWOZ60VnSNFtjZA1yBPnx
        4KYmTJSxrLNfvyw5PM3TaUA8B+qW
X-Google-Smtp-Source: ABdhPJxGwYOIO1nfvyor3U6z8NNHsYpEqXyWoT67kq18oE1pT6HzlqCM8FiU0HldPv7przQH38jVWQ==
X-Received: by 2002:a62:1681:: with SMTP id 123mr6839795pfw.306.1591881804319;
        Thu, 11 Jun 2020 06:23:24 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id i37sm2842473pgl.68.2020.06.11.06.23.22
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 11 Jun 2020 06:23:23 -0700 (PDT)
Date:   Thu, 11 Jun 2020 06:23:22 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     Joerg Roedel <joro@8bytes.org>
Cc:     Richard Henderson <rth@twiddle.net>,
        Ivan Kokshaysky <ink@jurassic.park.msu.ru>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-alpha@vger.kernel.org, linux-kernel@vger.kernel.org,
        Joerg Roedel <jroedel@suse.de>,
        Emil Velikov <emil.l.velikov@gmail.com>
Subject: Re: [PATCH] alpha: Fix build around srm_sysrq_reboot_op
Message-ID: <20200611132322.GA52797@roeck-us.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 11, 2020 at 11:11:39AM +0200, Joerg Roedel wrote:
> From: Joerg Roedel <jroedel@suse.de>
> 
> The patch introducing the struct was probably never compile tested,
> because it sets a handler with a wrong function signature. Wrap the
> handler into a functions with the correct signature to fix the build.
> 
> Fixes: 0f1c9688a194 ("tty/sysrq: alpha: export and use __sysrq_get_key_op()")
> Cc: Emil Velikov <emil.l.velikov@gmail.com>
> Cc: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Joerg Roedel <jroedel@suse.de>

Reviewed-by: Guenter Roeck <linux@roeck-us.net>
Tested-by: Guenter Roeck <linux@roeck-us.net>

> ---
>  arch/alpha/kernel/setup.c | 7 ++++++-
>  1 file changed, 6 insertions(+), 1 deletion(-)
> 
> diff --git a/arch/alpha/kernel/setup.c b/arch/alpha/kernel/setup.c
> index f5c42a8fcf9c..53520f8cb904 100644
> --- a/arch/alpha/kernel/setup.c
> +++ b/arch/alpha/kernel/setup.c
> @@ -430,8 +430,13 @@ register_cpus(void)
>  arch_initcall(register_cpus);
>  
>  #ifdef CONFIG_MAGIC_SYSRQ
> +static void sysrq_reboot_handler(int unused)
> +{
> +	machine_halt();
> +}
> +
>  static const struct sysrq_key_op srm_sysrq_reboot_op = {
> -	.handler	= machine_halt,
> +	.handler	= sysrq_reboot_handler,
>  	.help_msg       = "reboot(b)",
>  	.action_msg     = "Resetting",
>  	.enable_mask    = SYSRQ_ENABLE_BOOT,
> -- 
> 2.26.2
> 
