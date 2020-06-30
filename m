Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21175C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:30:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2AF620768
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 20:30:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="etZ7q+p4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729515AbgF3Ua4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 16:30:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52914 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726919AbgF3Uaz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 16:30:55 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45466C061755;
        Tue, 30 Jun 2020 13:30:55 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id rk21so21963256ejb.2;
        Tue, 30 Jun 2020 13:30:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=K3IWd4UOczfyNkWWyUS87fNAOE77K5rHLOtlJQ7STrg=;
        b=etZ7q+p4B2JFHM3KgC5RB2LKoUpfAVWQDOfoXe5kfFnF3sWFTpdsPYELXT8nRbRB8V
         5c31y2BRn1+HmCNdo1tmp3MfuAEy4DbPFs4TATQyhUTLx/qbfnjtDxgdEbovPSeSkVd3
         HCON9M+7BVdC606lmFGthsXOEIyJ1OCEqJh/TYsKGzxmQbVQJbQdMDwWp+75c4oitJu9
         e0AAGXCgi2g9MI7I5S5SYIcwD28Um6LlUd2sUgAbg3N87yQ/ufYEtsbVwedargaRYob/
         35RyETkHIdLM/27llnpBYTq0XeGhtpSfFmP/V0K8VzsYJIZa1aNjZT5FQm97TaOkQT8H
         B34g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=K3IWd4UOczfyNkWWyUS87fNAOE77K5rHLOtlJQ7STrg=;
        b=To+A9qiTANMzPNFiudLXaCLs9xT1DD1oZfeVRlk2NtN/oJuYHGSysG6SxFgQZrsJYt
         +kPPbXoSDwYVuqOannx3dv6awuRJ5YkYn8/iHvUHoZVFLg1bXp7UunBQdeRNx4BbS1XO
         wQi69tBiPAfWpWvhbkLofqu/EiZyHfZ1StPLLvFH1CNI+pnFgMF4fWR6/MO9eC/skGEC
         /L3hafRE+VcOQIjhaPOm5f9suZ/HFKrMth2EiuSIY87mJqUK9f9YlwZcDOyluxulMmOp
         V14W7lh5k6w2pVbEmBpWyFF0cOLCz+4ZHeOCma48Nmzaa85OhIE+ViVu6IXPppXKgxqV
         1JPg==
X-Gm-Message-State: AOAM530fXId8P7SUt+wES+sJoLZK1nxPvd+AUVszNW3AuPldjuoMFBOk
        RhQzaAVfDGkWIyT8OkFq1FM=
X-Google-Smtp-Source: ABdhPJxSukwxBOIw9LOnc/r5bA5e2YJNHfx7DSS/vLi6YTJhehVxo3tDqN9KmjRn0mC68Sho61Xt2Q==
X-Received: by 2002:a17:906:f298:: with SMTP id gu24mr19537400ejb.302.1593549051139;
        Tue, 30 Jun 2020 13:30:51 -0700 (PDT)
Received: from felia ([2001:16b8:2d31:bc00:cc6f:aee9:d326:7bf7])
        by smtp.gmail.com with ESMTPSA id w15sm2902179ejk.103.2020.06.30.13.30.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 30 Jun 2020 13:30:50 -0700 (PDT)
From:   Lukas Bulwahn <lukas.bulwahn@gmail.com>
X-Google-Original-From: Lukas Bulwahn <lukas@gmail.com>
Date:   Tue, 30 Jun 2020 22:30:39 +0200 (CEST)
X-X-Sender: lukas@felia
To:     Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>
cc:     Hans Verkuil <hverkuil-cisco@xs4all.nl>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        Guenter Roeck <groeck@chromium.org>,
        Kevin Hilman <khilman@baylibre.com>,
        Kukjin Kim <kgene@kernel.org>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@st.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        Ettore Chimenti <ek5.chimenti@gmail.com>,
        Benjamin Gaignard <benjamin.gaignard@linaro.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org,
        linux-stm32@st-md-mailman.stormreply.com,
        linux-tegra@vger.kernel.org, Joe Perches <joe@perches.com>,
        kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH SECOND RESEND] MAINTAINERS: adjust entries to moving CEC
 platform drivers
In-Reply-To: <20200525142946.8268-1-lukas.bulwahn@gmail.com>
Message-ID: <alpine.DEB.2.21.2006302228320.4753@felia>
References: <20200525142946.8268-1-lukas.bulwahn@gmail.com>
User-Agent: Alpine 2.21 (DEB 202 2017-01-01)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On Mon, 25 May 2020, Lukas Bulwahn wrote:

> Commit 4be5e8648b0c ("media: move CEC platform drivers to a separate
> directory") moved various files into a new directory structure, but did
> not adjust the entries in MAINTAINERS.
> 
> Since then, ./scripts/get_maintainer.pl --self-test=patterns complains:
> 
>   warning: no file matches F: drivers/media/platform/s5p-cec/
>   warning: no file matches F: drivers/media/platform/tegra-cec/
>   warning: no file matches F: drivers/media/platform/cec-gpio/
>   warning: no file matches F: drivers/media/platform/meson/ao-cec-g12a.c
>   warning: no file matches F: drivers/media/platform/meson/ao-cec.c
>   warning: no file matches F: drivers/media/platform/seco-cec/seco-cec.c
>   warning: no file matches F: drivers/media/platform/seco-cec/seco-cec.h
>   warning: no file matches F: drivers/media/platform/sti/cec/
> 
> Update the MAINTAINERS entries to the new file locations.
> 
> Signed-off-by: Lukas Bulwahn <lukas.bulwahn@gmail.com>
> ---
> Mauro, please pick this non-urgent minor clean-up patch on top of the
> CEC platform driver moves.
>  

Just a short ping for you, Mauro. Can you pick up this minor clean-up 
patch?

Lukas

> applies cleanly on next-20200417, next-20200505 and still on next-20200525
> for this second resend.
> 
> v1 send here:
> https://lore.kernel.org/lkml/20200418093630.6149-1-lukas.bulwahn@gmail.com/
> 
> v1 first resend here:
> https://lore.kernel.org/lkml/20200506050744.4779-1-lukas.bulwahn@gmail.com/
> 
>  MAINTAINERS | 14 ++++++--------
>  1 file changed, 6 insertions(+), 8 deletions(-)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index 7a442b48f24b..bf5cb149101b 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -2403,7 +2403,7 @@ L:	linux-samsung-soc@vger.kernel.org (moderated for non-subscribers)
>  L:	linux-media@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/media/s5p-cec.txt
> -F:	drivers/media/platform/s5p-cec/
> +F:	drivers/media/cec/platform/s5p/
>  
>  ARM/SAMSUNG S5P SERIES JPEG CODEC SUPPORT
>  M:	Andrzej Pietrasiewicz <andrzejtp2010@gmail.com>
> @@ -2548,7 +2548,7 @@ L:	linux-tegra@vger.kernel.org
>  L:	linux-media@vger.kernel.org
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/media/tegra-cec.txt
> -F:	drivers/media/platform/tegra-cec/
> +F:	drivers/media/cec/platform/tegra/
>  
>  ARM/TETON BGA MACHINE SUPPORT
>  M:	"Mark F. Brown" <mark.brown314@gmail.com>
> @@ -3969,7 +3969,7 @@ S:	Supported
>  W:	http://linuxtv.org
>  T:	git git://linuxtv.org/media_tree.git
>  F:	Documentation/devicetree/bindings/media/cec-gpio.txt
> -F:	drivers/media/platform/cec-gpio/
> +F:	drivers/media/cec/platform/cec-gpio/
>  
>  CELL BROADBAND ENGINE ARCHITECTURE
>  M:	Arnd Bergmann <arnd@arndb.de>
> @@ -11146,8 +11146,7 @@ S:	Supported
>  W:	http://linux-meson.com/
>  T:	git git://linuxtv.org/media_tree.git
>  F:	Documentation/devicetree/bindings/media/amlogic,meson-gx-ao-cec.yaml
> -F:	drivers/media/platform/meson/ao-cec-g12a.c
> -F:	drivers/media/platform/meson/ao-cec.c
> +F:	drivers/media/cec/platform/meson/
>  
>  MESON NAND CONTROLLER DRIVER FOR AMLOGIC SOCS
>  M:	Liang Yang <liang.yang@amlogic.com>
> @@ -15212,8 +15211,7 @@ F:	drivers/mmc/host/sdricoh_cs.c
>  SECO BOARDS CEC DRIVER
>  M:	Ettore Chimenti <ek5.chimenti@gmail.com>
>  S:	Maintained
> -F:	drivers/media/platform/seco-cec/seco-cec.c
> -F:	drivers/media/platform/seco-cec/seco-cec.h
> +F:	drivers/media/cec/platform/seco/
>  
>  SECURE COMPUTING
>  M:	Kees Cook <keescook@chromium.org>
> @@ -16249,7 +16247,7 @@ STI CEC DRIVER
>  M:	Benjamin Gaignard <benjamin.gaignard@linaro.org>
>  S:	Maintained
>  F:	Documentation/devicetree/bindings/media/stih-cec.txt
> -F:	drivers/media/platform/sti/cec/
> +F:	drivers/media/cec/platform/sti/
>  
>  STK1160 USB VIDEO CAPTURE DRIVER
>  M:	Ezequiel Garcia <ezequiel@vanguardiasur.com.ar>
> -- 
> 2.17.1
> 
> 
