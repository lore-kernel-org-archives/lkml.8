Return-Path: <SRS0=5Khs=AX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E2BD0C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 16:57:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4E1A20702
	for <linux-kernel@archiver.kernel.org>; Sun, 12 Jul 2020 16:57:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bWC59/PI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729166AbgGLQ5y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 12 Jul 2020 12:57:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728844AbgGLQ5x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jul 2020 12:57:53 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 97DEDC08C5DB
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 09:57:53 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id e8so4943844pgc.5
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 09:57:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=V+29yKObV42dMQQ2dOZ0zPCpRtPFoPAyDYNr7LlSwdc=;
        b=bWC59/PIbucCBlrCBRATrsYAd7bKQMjD6gi64gyOjernEIBPyP0H6qFjMGOgdTiTyJ
         46QYtqIsCqqd+KhocNIehQgjuBMJwcyRbhBaltiH3l4e9nPYWm7wWYSHnoCKrx0R7abk
         ko4WmPRQeIP/2Fxa0jNGHpYUjYqqoVKrY2VRAhx51ru11qznd0zy7xnmkjVqVN2nvXlO
         L5sllayuiSYqUjD0TVrG8uF9ftRJ+kcS4AvJbIRYnAffg1pTitHX1RvLd90zLfb+ctdL
         LiGtRk87wy0cJhgS+q/Oo7WTUUYYYGvAh7hpyGbtdixpU+Pl5J8wU8MoDUpkYpZpN44x
         vJVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=V+29yKObV42dMQQ2dOZ0zPCpRtPFoPAyDYNr7LlSwdc=;
        b=hY0nxV+nczucDn+wr1HOx0zNiBi3RT+2UM3NAQwJyboLqYFfak4VZ6idk/apifFjdc
         v1l8Nvthva8sTUHzjKIxEMBvTw3I39aqC0bF4J0tj0AUV4m2Fc1XcKeB57tYRnRx6LJk
         2hGUNzTmlG6O4jbk/TOJb/2Rs/mG4l7qf97ZBMCY35kz1BgB3sjKJZ83kfAdmUb2BHJU
         RiT844YVpa9wnP0zuzl6GhW5Wk7fCg1z/nZLZmAMXzugRcOyiI1wHXDgnVgt6liuBJB6
         gcmz93N3PLgl0ZyBhIAu6PaBB1SbtUxKnHtknn5/pSiAB1IWmYxSjsAcB0VpSXJ+NH7z
         s/4A==
X-Gm-Message-State: AOAM532Rl0YXphh6i0QAv3dchL0Q/kkqWNjD+EjUU30/YyrF0mkMFH7F
        IZL0Hc3hz4vnsH07Pb63LLV4
X-Google-Smtp-Source: ABdhPJwComCFu5NW51NSCSx23R8m1BCRnSBdKKfbmpXV+SU6YXcuMzpA4LDByLSdD3nXUjU3b5S5uQ==
X-Received: by 2002:aa7:938c:: with SMTP id t12mr70387576pfe.37.1594573073104;
        Sun, 12 Jul 2020 09:57:53 -0700 (PDT)
Received: from Mani-XPS-13-9360 ([2409:4072:6c81:c187:70f5:3123:b5de:e77f])
        by smtp.gmail.com with ESMTPSA id v2sm11908986pje.19.2020.07.12.09.57.48
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 12 Jul 2020 09:57:52 -0700 (PDT)
Date:   Sun, 12 Jul 2020 22:27:46 +0530
From:   Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
To:     Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
Cc:     Stephen Boyd <sboyd@kernel.org>,
        Andreas =?iso-8859-1?Q?F=E4rber?= <afaerber@suse.de>,
        Rob Herring <robh+dt@kernel.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        linux-kernel@vger.kernel.org, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org,
        linux-actions@lists.infradead.org
Subject: Re: [PATCH v3 4/6] dt-bindings: reset: Add binding constants for
 Actions S500 RMU
Message-ID: <20200712165746.GC6110@Mani-XPS-13-9360>
References: <cover.1593788312.git.cristian.ciocaltea@gmail.com>
 <daf615160b3be9f38dcf7926cc82128c9c2d73e3.1593788312.git.cristian.ciocaltea@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <daf615160b3be9f38dcf7926cc82128c9c2d73e3.1593788312.git.cristian.ciocaltea@gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 03, 2020 at 08:05:10PM +0300, Cristian Ciocaltea wrote:
> Add device tree binding constants for Actions Semi S500 SoC Reset
> Management Unit (RMU).
> 
> Signed-off-by: Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> Acked-by: Philipp Zabel <p.zabel@pengutronix.de>

Reviewed-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>

Thanks,
Mani

> ---
> Changes in v3:
>  - Added Philipp's Acked-by tag
> 
> Changes in v2:
>  - None
> 
>  .../dt-bindings/reset/actions,s500-reset.h    | 67 +++++++++++++++++++
>  1 file changed, 67 insertions(+)
>  create mode 100644 include/dt-bindings/reset/actions,s500-reset.h
> 
> diff --git a/include/dt-bindings/reset/actions,s500-reset.h b/include/dt-bindings/reset/actions,s500-reset.h
> new file mode 100644
> index 000000000000..f5d94176d10b
> --- /dev/null
> +++ b/include/dt-bindings/reset/actions,s500-reset.h
> @@ -0,0 +1,67 @@
> +/* SPDX-License-Identifier: GPL-2.0+ */
> +/*
> + * Device Tree binding constants for Actions Semi S500 Reset Management Unit
> + *
> + * Copyright (c) 2014 Actions Semi Inc.
> + * Copyright (c) 2020 Cristian Ciocaltea <cristian.ciocaltea@gmail.com>
> + */
> +
> +#ifndef __DT_BINDINGS_ACTIONS_S500_RESET_H
> +#define __DT_BINDINGS_ACTIONS_S500_RESET_H
> +
> +#define RESET_DMAC				0
> +#define RESET_NORIF				1
> +#define RESET_DDR				2
> +#define RESET_NANDC				3
> +#define RESET_SD0				4
> +#define RESET_SD1				5
> +#define RESET_PCM1				6
> +#define RESET_DE				7
> +#define RESET_LCD				8
> +#define RESET_SD2				9
> +#define RESET_DSI				10
> +#define RESET_CSI				11
> +#define RESET_BISP				12
> +#define RESET_KEY				13
> +#define RESET_GPIO				14
> +#define RESET_AUDIO				15
> +#define RESET_PCM0				16
> +#define RESET_VDE				17
> +#define RESET_VCE				18
> +#define RESET_GPU3D				19
> +#define RESET_NIC301				20
> +#define RESET_LENS				21
> +#define RESET_PERIPHRESET			22
> +#define RESET_USB2_0				23
> +#define RESET_TVOUT				24
> +#define RESET_HDMI				25
> +#define RESET_HDCP2TX				26
> +#define RESET_UART6				27
> +#define RESET_UART0				28
> +#define RESET_UART1				29
> +#define RESET_UART2				30
> +#define RESET_SPI0				31
> +#define RESET_SPI1				32
> +#define RESET_SPI2				33
> +#define RESET_SPI3				34
> +#define RESET_I2C0				35
> +#define RESET_I2C1				36
> +#define RESET_USB3				37
> +#define RESET_UART3				38
> +#define RESET_UART4				39
> +#define RESET_UART5				40
> +#define RESET_I2C2				41
> +#define RESET_I2C3				42
> +#define RESET_ETHERNET				43
> +#define RESET_CHIPID				44
> +#define RESET_USB2_1				45
> +#define RESET_WD0RESET				46
> +#define RESET_WD1RESET				47
> +#define RESET_WD2RESET				48
> +#define RESET_WD3RESET				49
> +#define RESET_DBG0RESET				50
> +#define RESET_DBG1RESET				51
> +#define RESET_DBG2RESET				52
> +#define RESET_DBG3RESET				53
> +
> +#endif /* __DT_BINDINGS_ACTIONS_S500_RESET_H */
> -- 
> 2.27.0
> 
