Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B28BC2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:33:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5309C20767
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:33:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EtO6NHec"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636117AbgDONdM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:33:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58280 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1731696AbgDONdF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 09:33:05 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DE0D5C061A0C;
        Wed, 15 Apr 2020 06:33:04 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id r7so3621214ljg.13;
        Wed, 15 Apr 2020 06:33:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rweJjnMrX8DVOwJI978T4+zp/Dc4ldAeC6N/9wICZ1w=;
        b=EtO6NHecxgTrUGnMVlx7i3ATAgsdf3gtJ68v14xO88EpmFNAGg5igoHGOh8H+9iFnT
         U+aXfzs2UAcidoE88j2khBx/3IrLqn8AZ3NnVdzNEjcKn7bZKB+OcZtOdX4ff/KxDIXM
         SWEqmB3uZq2eqv2y9+ATuYiiBISQFQIdqWAMwk+ZKHtO23SE6prvYcSrAAXNrPbMXOdR
         m/c6Mesnr6DF343g2os+JR122TLWwd7rcOgRCbskoANzQ2v9sLEKLQhgON1xOTYh6mtk
         F71Ri+dIC9ZYwKcdNurMEVJuwKbo6aqZi9CutbZazhbkbNQhCrbz7ZNPaysnwr3o/ZoM
         bR5w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rweJjnMrX8DVOwJI978T4+zp/Dc4ldAeC6N/9wICZ1w=;
        b=U7tZMZnmFgfEIZHuqw6+PugcOhI4ipUVbzRaIO1mzGjBH5YLVmQAFTvp+E7s4j5eTd
         Ajk6FcUH1PdWulDZ4YPfDskBnjNlx3EmkCPhgrfKMYV6M3vQgXYZ2Mp7zBmKCYji493r
         T8i79JwC3JjjNxJuhXHMXIOFTwJtIUZKAyYI5JC4jQpMn/lMHSt5zsHPfUUw1W1pRBv0
         ZDFuOqwqY2QFCi3bCHRQ7m9x2Py7ON+r7TSkWwqASp3OMkwcZ4yHHeK79Iysp+KQGETn
         OR5onZ2aUhauWtEwmJjaslzmbS4JH2wmuIj/I1AsFE/DNbK9Yedx9oZ32MbrMrNM2s0W
         uqTA==
X-Gm-Message-State: AGi0PuaJOr3wbtsslPybx5UuGAtTHF0cYckJU3YnKkZXbgv1JADL1oAt
        gDdmAfQNUobzuQtBfKkmm9jOrAgbTMVb4MZHOPQ=
X-Google-Smtp-Source: APiQypKS3xz8rw5Jy7+JZAEVCjE7qNjWum5PB0iQLEBBPGJIPaZ4eDEcQCJaRQ98XaFHtdQO4V9Zs8EXEbzFYwJFXV4=
X-Received: by 2002:a2e:9b07:: with SMTP id u7mr3252420lji.110.1586957583245;
 Wed, 15 Apr 2020 06:33:03 -0700 (PDT)
MIME-Version: 1.0
References: <20200414220943.6203-1-ezequiel@collabora.com>
In-Reply-To: <20200414220943.6203-1-ezequiel@collabora.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Wed, 15 Apr 2020 21:32:52 +0800
Message-ID: <CADBw62oJj_x046piRbPP48A04ALo-w2J6jZXNspyN5eOGj-TEg@mail.gmail.com>
Subject: Re: [PATCH] hwspinlock: Simplify Kconfig
To:     Ezequiel Garcia <ezequiel@collabora.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-remoteproc@vger.kernel.org,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>, kernel@collabora.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Ezequiel,

On Wed, Apr 15, 2020 at 6:09 AM Ezequiel Garcia <ezequiel@collabora.com> wrote:
>
> Every hwspinlock driver is expected to depend on the
> hwspinlock core, so it's possible to simplify the
> Kconfig, factoring out the HWSPINLOCK dependency.
>
> Signed-off-by: Ezequiel Garcia <ezequiel@collabora.com>

Looks reasonable to me.
Reviewed-by: Baolin Wang <baolin.wang7@gmail.com>

> ---
>  drivers/hwspinlock/Kconfig | 10 ++++------
>  1 file changed, 4 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/hwspinlock/Kconfig b/drivers/hwspinlock/Kconfig
> index 826a1054100d..32cd26352f38 100644
> --- a/drivers/hwspinlock/Kconfig
> +++ b/drivers/hwspinlock/Kconfig
> @@ -6,9 +6,10 @@
>  menuconfig HWSPINLOCK
>         bool "Hardware Spinlock drivers"
>
> +if HWSPINLOCK
> +
>  config HWSPINLOCK_OMAP
>         tristate "OMAP Hardware Spinlock device"
> -       depends on HWSPINLOCK
>         depends on ARCH_OMAP4 || SOC_OMAP5 || SOC_DRA7XX || SOC_AM33XX || SOC_AM43XX || ARCH_K3 || COMPILE_TEST
>         help
>           Say y here to support the OMAP Hardware Spinlock device (firstly
> @@ -18,7 +19,6 @@ config HWSPINLOCK_OMAP
>
>  config HWSPINLOCK_QCOM
>         tristate "Qualcomm Hardware Spinlock device"
> -       depends on HWSPINLOCK
>         depends on ARCH_QCOM || COMPILE_TEST
>         select MFD_SYSCON
>         help
> @@ -30,7 +30,6 @@ config HWSPINLOCK_QCOM
>
>  config HWSPINLOCK_SIRF
>         tristate "SIRF Hardware Spinlock device"
> -       depends on HWSPINLOCK
>         depends on ARCH_SIRF || COMPILE_TEST
>         help
>           Say y here to support the SIRF Hardware Spinlock device, which
> @@ -43,7 +42,6 @@ config HWSPINLOCK_SIRF
>  config HWSPINLOCK_SPRD
>         tristate "SPRD Hardware Spinlock device"
>         depends on ARCH_SPRD || COMPILE_TEST
> -       depends on HWSPINLOCK
>         help
>           Say y here to support the SPRD Hardware Spinlock device.
>
> @@ -52,7 +50,6 @@ config HWSPINLOCK_SPRD
>  config HWSPINLOCK_STM32
>         tristate "STM32 Hardware Spinlock device"
>         depends on MACH_STM32MP157 || COMPILE_TEST
> -       depends on HWSPINLOCK
>         help
>           Say y here to support the STM32 Hardware Spinlock device.
>
> @@ -60,7 +57,6 @@ config HWSPINLOCK_STM32
>
>  config HSEM_U8500
>         tristate "STE Hardware Semaphore functionality"
> -       depends on HWSPINLOCK
>         depends on ARCH_U8500 || COMPILE_TEST
>         help
>           Say y here to support the STE Hardware Semaphore functionality, which
> @@ -68,3 +64,5 @@ config HSEM_U8500
>           SoC.
>
>           If unsure, say N.
> +
> +endif # HWSPINLOCK
> --
> 2.26.0.rc2
>


-- 
Baolin Wang
