Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AFFA9C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:58:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D27920882
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 19:58:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=amarulasolutions.com header.i=@amarulasolutions.com header.b="hXR1vMBG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726792AbgIJT6M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 15:58:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730261AbgIJPDb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 11:03:31 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79974C061795
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:03:27 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id q13so9185448ejo.9
        for <linux-kernel@vger.kernel.org>; Thu, 10 Sep 2020 08:03:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amarulasolutions.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=64bErnrxP6141PPO+iBi7bI0Jax7pIFKoQlwFvD435o=;
        b=hXR1vMBGzCG2exEz0wPgoYVdXGmLobgTooWR5FS7eYdzhraeNtWSn0jqofTs/GBh8K
         cskQNKv3eN2KKv4zn7hsWelW7cWkQg8hLNnQXAHi5wIt+DZiPEjJE7Y6vCcNNdYPFL6x
         ANUlLQYRpAEFpIz4V76FU/ecov7vR6UvXHpfE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=64bErnrxP6141PPO+iBi7bI0Jax7pIFKoQlwFvD435o=;
        b=MSFawRwf2lsfOrzPByicEtSd6AIKfcV31/YB5Sx6n/NQEH94iY5XtrwqB7VJar4+dq
         /iGbNWTBwXBaNpv8yRLuwMGdtAEl07BupDxrVCds86qBYhN9zwL6GkRAoYlqgg7ACFkO
         sDnZlBRyzA/2CfkBtxsQHUkoM/QgtPRl7UJYnXVNiYohPy543Y/3O/cnL610QAEQEqA+
         BLbAocxr3/d4xds8zILCocmmV1w/2yaBk3HsOhUDUe/eHRzORK1CGUfyYO679jmtoof4
         N7G9QTNnny1eLEwOhNnirA61+eXgTnZWln3uiF/qdbpqLEomV/yPT0xW3puImDEjaHXt
         y9wg==
X-Gm-Message-State: AOAM533AoyKd4j1vAqi8OUN+/WU/ci4aa/S+FNkGcG7pF1j2uqLstayl
        YZ2Lwqsc4QI4l0P3Jq3QO3tiVF9Ghk/+3dU+sYMtug==
X-Google-Smtp-Source: ABdhPJyEEwhVKJjxjsFjKDv+BExQkzADJBSk0rheBv1Vwh51yrN2C934wVW5yl/yhDjnhsVQV3FdbpwKyKk3eqBoYDY=
X-Received: by 2002:a17:906:46d5:: with SMTP id k21mr8986027ejs.247.1599750206137;
 Thu, 10 Sep 2020 08:03:26 -0700 (PDT)
MIME-Version: 1.0
References: <20200731160324.142097-1-jagan@amarulasolutions.com>
In-Reply-To: <20200731160324.142097-1-jagan@amarulasolutions.com>
From:   Jagan Teki <jagan@amarulasolutions.com>
Date:   Thu, 10 Sep 2020 20:33:14 +0530
Message-ID: <CAMty3ZCO5iY6g4uRp7xuCquQNEMiwbeiy=sN9y0dR1TX+0AGzw@mail.gmail.com>
Subject: Re: [PATCH v2] arm64: defconfig: Enable REGULATOR_MP8859
To:     Heiko Stuebner <heiko@sntech.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel <linux-arm-kernel@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Markus Reichl <m.reichl@fivetechno.de>,
        Suniel Mahesh <sunil@amarulasolutions.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Heiko,

On Fri, Jul 31, 2020 at 9:33 PM Jagan Teki <jagan@amarulasolutions.com> wrote:
>
> RK3399 boards like ROC-RK3399-PC is using MP8859 DC/DC converter
> for 12V supply.
>
> roc-rk3399-pc initially used 12V fixed regulator for this supply,
> but the below commit has switched to use MP8859.
>
> commit <1fc61ed04d309b0b8b3562acf701ab988eee12de> "arm64: dts: rockchip:
> Enable mp8859 regulator on rk3399-roc-pc"
>
> So, enable bydefault on the defconfig.
>
> Signed-off-by: Jagan Teki <jagan@amarulasolutions.com>
> Tested-by: Suniel Mahesh <sunil@amarulasolutions.com>
> ---
> Changes for v2:
> - none
>
>  arch/arm64/configs/defconfig | 1 +
>  1 file changed, 1 insertion(+)
>
> diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
> index 883e8bace3ed..62bcbf987a70 100644
> --- a/arch/arm64/configs/defconfig
> +++ b/arch/arm64/configs/defconfig
> @@ -556,6 +556,7 @@ CONFIG_REGULATOR_HI6421V530=y
>  CONFIG_REGULATOR_HI655X=y
>  CONFIG_REGULATOR_MAX77620=y
>  CONFIG_REGULATOR_MAX8973=y
> +CONFIG_REGULATOR_MP8859=y
>  CONFIG_REGULATOR_PFUZE100=y
>  CONFIG_REGULATOR_PWM=y
>  CONFIG_REGULATOR_QCOM_RPMH=y

Can you apply this patch? w/o this regulator the default defconfig is
unable to boot the Linux.

Jagan.
