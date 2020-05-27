Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94F18C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 09:47:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F91B2088E
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 09:47:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="WeawMs02"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729349AbgE0Jre (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 05:47:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727800AbgE0Jre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 05:47:34 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 25D51C03E979
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 02:47:34 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id 185so3320759pgb.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 May 2020 02:47:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=mime-version:content-transfer-encoding:in-reply-to:references
         :subject:from:cc:to:date:message-id:user-agent;
        bh=OLF9lwE2e7f3o0945da1l86g58aoVITOUEe8pjdIEuE=;
        b=WeawMs02Jy51FJdzoYqEttg8/jkn4FfmUv5EVDbRCdQOjiOEcKeQirpE1wqrdNxcwC
         EEmb8GyzPBHsKwF9ew3PbKmO2LUc91/iwPVZbcCZip7ErnfaEN/GL7No/njB4E/BY9na
         U90MwcpoxJsQlD7v7aWP0PfWzgzHGTq8VURtk=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:content-transfer-encoding
         :in-reply-to:references:subject:from:cc:to:date:message-id
         :user-agent;
        bh=OLF9lwE2e7f3o0945da1l86g58aoVITOUEe8pjdIEuE=;
        b=dM/qFxtkFGwRSOIMk6fwijyjCUUvcFuheQMTpF52RE2doMCdfx6f0vY9muDzlOzomy
         GRYrP9cegU3L3IANr4cjVahbCw7VzbRFAOM0gIJC4TzbZN9DA1dSS96uf3gcAfy3K7y3
         btbEf5sFkVhTiCvweObjF4oNjaRlxmeDKLRs4xtI0f0sHM2EbQhkWh0vkkSLyH+lYHU5
         eBcY9bsxLgd8jRfWDNhnuDBH0YeARAR5zJST6oMIld7WH5qsONA3RUGrh1N06okoAYCO
         vfy+vZwu54zig6/amyV2DqlLkS+rVqgab/xk0OGN8ClF04pmnRGlO7RZm9rg8exd81Of
         8wDQ==
X-Gm-Message-State: AOAM533UpYsXgUxdwUJhdc5GeFBdicRX83qSeF/YxaSus+NuXEp9HpMd
        9AA+qFk93vKwGPypaPbibjlHsSgSsbg=
X-Google-Smtp-Source: ABdhPJwyjsJiyOwvaVNB+4wG3UIVuWYeMXY2/2AN1qH2vGamYlPhvf4//LLrFzBFd2CcXp/G4SbucA==
X-Received: by 2002:a62:e419:: with SMTP id r25mr3178210pfh.82.1590572853451;
        Wed, 27 May 2020 02:47:33 -0700 (PDT)
Received: from chromium.org ([2620:15c:202:1:fa53:7765:582b:82b9])
        by smtp.gmail.com with ESMTPSA id l25sm1731006pgn.19.2020.05.27.02.47.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 May 2020 02:47:32 -0700 (PDT)
Content-Type: text/plain; charset="utf-8"
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
In-Reply-To: <1590253873-11556-4-git-send-email-mkshah@codeaurora.org>
References: <1590253873-11556-1-git-send-email-mkshah@codeaurora.org> <1590253873-11556-4-git-send-email-mkshah@codeaurora.org>
Subject: Re: [PATCH v2 3/4] pinctrl: qcom: Add msmgpio irqchip flags
From:   Stephen Boyd <swboyd@chromium.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-gpio@vger.kernel.org, agross@kernel.org, tglx@linutronix.de,
        jason@lakedaemon.net, dianders@chromium.org, rnayak@codeaurora.org,
        ilina@codeaurora.org, lsrao@codeaurora.org,
        Maulik Shah <mkshah@codeaurora.org>
To:     Maulik Shah <mkshah@codeaurora.org>, bjorn.andersson@linaro.org,
        evgreen@chromium.org, linus.walleij@linaro.org, maz@kernel.org,
        mka@chromium.org
Date:   Wed, 27 May 2020 02:47:31 -0700
Message-ID: <159057285160.88029.12486371130122290394@swboyd.mtv.corp.google.com>
User-Agent: alot/0.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Quoting Maulik Shah (2020-05-23 10:11:12)
> Add irqchip specific flags for msmgpio irqchip to mask non wakeirqs
> during suspend and mask before setting irq type.

Why do we need to mask before setting irq type? Does something go wrong?
Can you explain in the commit text?

>=20
> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>

Does this need a Fixes tag?

> ---
>  drivers/pinctrl/qcom/pinctrl-msm.c | 2 ++
>  1 file changed, 2 insertions(+)
>=20
> diff --git a/drivers/pinctrl/qcom/pinctrl-msm.c b/drivers/pinctrl/qcom/pi=
nctrl-msm.c
> index 2419023..b909ffe 100644
> --- a/drivers/pinctrl/qcom/pinctrl-msm.c
> +++ b/drivers/pinctrl/qcom/pinctrl-msm.c
> @@ -1143,6 +1143,8 @@ static int msm_gpio_init(struct msm_pinctrl *pctrl)
>         pctrl->irq_chip.irq_release_resources =3D msm_gpio_irq_relres;
>         pctrl->irq_chip.irq_set_affinity =3D msm_gpio_irq_set_affinity;
>         pctrl->irq_chip.irq_set_vcpu_affinity =3D msm_gpio_irq_set_vcpu_a=
ffinity;
> +       pctrl->irq_chip.flags =3D IRQCHIP_MASK_ON_SUSPEND

This is sort of sad. We have to set the IRQCHIP_MASK_ON_SUSPEND flag
here so that genirq can call the mask op during suspend for the parent
irqchip (pdc)? Is there some way to not need to do that and instead let
genirq do mask on suspend at the chip level instead of the irq level?

> +                               | IRQCHIP_SET_TYPE_MASKED;
> =20
>         np =3D of_parse_phandle(pctrl->dev->of_node, "wakeup-parent", 0);
>         if (np) {
