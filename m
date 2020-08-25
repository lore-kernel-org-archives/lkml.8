Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E47EC433E3
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:12:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 593072068E
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 10:12:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="lPmqMD62"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729695AbgHYKM5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 06:12:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728117AbgHYKMx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 06:12:53 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CEA82C061755
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 03:12:52 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id i13so1005828pjv.0
        for <linux-kernel@vger.kernel.org>; Tue, 25 Aug 2020 03:12:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=xX92bPOZbt3/grqwTKQZiCyjmq/ugCoByLBgnfdVMK8=;
        b=lPmqMD62bB1Et2NxkmsOc1EqYJlMVHNWvAEVBzcQm65gRI7GM5R46BGVsZI38rmiUV
         mQbj8fl/c7J5NjdD1LouPoCgMvGoYMWR0LHBE1y3yF2D6oeP/jIqGXgBHSekwFbvA6DH
         tmIoMtqz5McC5FiU2nAFmb08gCOrNsr0oKNqw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=xX92bPOZbt3/grqwTKQZiCyjmq/ugCoByLBgnfdVMK8=;
        b=SwqQLqf1mkRuOr0+PIdDuXsZR5g5EOLhR6+f9sGCnKNYBZmpLjJzsjxRg5NIbl3w9X
         T6KeGUiWAdQ0/q3IdpyRsJbdUCgpXJdcfy6U6ub5N6eIUBdUwEW9orSF6JZf3sDlS2DE
         ThcTKSZ9sMZ0Z/zdnZyJDC8mW0FvptDK0J3sKP52CY/HNexlQNNecoVk7cDRrWw8QbcG
         kxF5pnvX1kuMwaWotKdcn7DcLaDBax8KvROKIcG80EKHBf/jzGhOLLyM7hqZY/cA1J+T
         NBdkHlTh0Bt+KdTnIv40E5rQI4J5bEMZTvmV8lVNgFKYDXt+AQmfesxaDOYCUdPRu7wL
         x8Gg==
X-Gm-Message-State: AOAM530DnLKEk0CxFyC7F67bKKjXLaXCWdO7Rj+rWj1aDLjrAiBq+0xI
        SJdbfsAVTBxqlfIyJ4I2i8Zv/kneQq3iHw==
X-Google-Smtp-Source: ABdhPJyg9MRRE/KTmNzcehHxAuIdSqEP6EHaiy2FfEv0vFEPLIHznTGG3PbB6dlvh6g/ERU1vFrAog==
X-Received: by 2002:a17:90a:b904:: with SMTP id p4mr736867pjr.130.1598350372001;
        Tue, 25 Aug 2020 03:12:52 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:3e52:82ff:fe6c:83ab])
        by smtp.gmail.com with ESMTPSA id r16sm2511206pfq.173.2020.08.25.03.12.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 25 Aug 2020 03:12:51 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1598113021-4149-4-git-send-email-mkshah@codeaurora.org>
References: <1598113021-4149-1-git-send-email-mkshah@codeaurora.org> <1598113021-4149-4-git-send-email-mkshah@codeaurora.org>
Subject: Re: [PATCH v5 3/6] genirq/PM: Introduce IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND flag
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, agross@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        evgreen@chromium.org, linus.walleij@linaro.org, maz@kernel.org,
        mka@chromium.org
Date:   Tue, 25 Aug 2020 03:12:49 -0700
Message-ID: <159835036999.334488.14725849347753031927@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-08-22 09:16:58)
> diff --git a/kernel/irq/pm.c b/kernel/irq/pm.c
> index c6c7e18..2cc800b 100644
> --- a/kernel/irq/pm.c
> +++ b/kernel/irq/pm.c
> @@ -69,12 +69,17 @@ void irq_pm_remove_action(struct irq_desc *desc, stru=
ct irqaction *action)
> =20
>  static bool suspend_device_irq(struct irq_desc *desc)
>  {
> +       unsigned long chipflags =3D irq_desc_get_chip(desc)->flags;
> +
>         if (!desc->action || irq_desc_is_chained(desc) ||
>             desc->no_suspend_depth)
>                 return false;
> =20
>         if (irqd_is_wakeup_set(&desc->irq_data)) {
>                 irqd_set(&desc->irq_data, IRQD_WAKEUP_ARMED);
> +
> +               if (chipflags & IRQCHIP_ENABLE_WAKEUP_ON_SUSPEND)
> +                       irq_enable(desc);

Where is the corresponding change to resume_irq()? Don't we need to
disable an irq if it was disabled on suspend and forcibly enabled here?

>                 /*
>                  * We return true here to force the caller to issue
>                  * synchronize_irq(). We need to make sure that the
> @@ -93,7 +98,7 @@ static bool suspend_device_irq(struct irq_desc *desc)
>          * chip level. The chip implementation indicates that with
>          * IRQCHIP_MASK_ON_SUSPEND.
>          */
> -       if (irq_desc_get_chip(desc)->flags & IRQCHIP_MASK_ON_SUSPEND)
> +       if (chipflags & IRQCHIP_MASK_ON_SUSPEND)
>                 mask_irq(desc);
>         return true;
>  }
