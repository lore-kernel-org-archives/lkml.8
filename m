Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FEDCC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:32:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4FBAC20706
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:32:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="avt6c0ad"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727961AbgFVKcs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 06:32:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727051AbgFVKcr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 06:32:47 -0400
Received: from mail-wr1-x444.google.com (mail-wr1-x444.google.com [IPv6:2a00:1450:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89E46C061794
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 03:32:47 -0700 (PDT)
Received: by mail-wr1-x444.google.com with SMTP id b6so16099654wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 03:32:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Fa4dCMlEWKxhwtDN8DZa0EBzcvxNGKcUrvu6R1FLLEY=;
        b=avt6c0ad9r5XtZvoCZsUT9m85JMd/pwM+nH7ld0naOBpha7Jkf6u2MGebUC3u2YD7V
         BDMYT+W6hKu/qxgMRTn8CHo4T/t/p+Q2j01eq0Y9+DFvdvgJESLEr2x8xDLexqabk2ir
         +nJJ3xS2rK0L4H/btmt7xfl/v8d/xT/Ehyl6qt6PI75AxA5zoQuH4BxNZi9cajCv9N8Q
         IZNJM4mQnHI3shXQNuuv2UAuIO0mocUXa1lpdH3nQh4ZlwjVC6/JjrDHP455EuaAAx5I
         A4/2mDw8nJMH3QcaFeNdsNrZIuyFYh+mUzdkNEDU05xhWWV3wTzZvIyFtvOXZx1igV3j
         Ow5Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Fa4dCMlEWKxhwtDN8DZa0EBzcvxNGKcUrvu6R1FLLEY=;
        b=m/iCq/6UHBmf2XfRQxbWeYtoq7GHF1hgIaP60b+GFjKUphUqLmep+tkS+tlgpjgUtv
         edybN4fe5wW13ndmRhg9l9t6efeyjbD8cAoWMTQTb4JMvkK9vti4EYDyV+1XL5vF1wWv
         5I6dBKPDsoJZW2tjrNUtpmDUnf0dhlSyV/Tpm3zRUru9KBvcx7llPMD25X1vTa1N8Th3
         yKqf6+bFA6on9XG+R5V9d9mPlvTMgObQ7OaX/4X/DB2ZiOyrECdWzhq9O3cph2ohc/SV
         Oqux0tisX5YCmgIbOp6IkcpAMpb9K2ujKYjebl/0f00Bz9lTsYdaWdbLOQmOJnG8E+vJ
         ThGg==
X-Gm-Message-State: AOAM531USXZwVoOV6vsm5NcOYTgAcGM8e4IzFvHZwsSWLCMbFq0DyIQp
        wNAZ2jQqpCOtR3ayjBqtQEup8A==
X-Google-Smtp-Source: ABdhPJwX0G/3q4eO7PMMGrf3/EarwYht0K/sahtWaIUqU5krFYZCMH4KP6m8xJqZ1qD6hZbalCZVPQ==
X-Received: by 2002:adf:e4d0:: with SMTP id v16mr5666137wrm.193.1592821966276;
        Mon, 22 Jun 2020 03:32:46 -0700 (PDT)
Received: from dell ([2.27.35.144])
        by smtp.gmail.com with ESMTPSA id j6sm15810066wmb.3.2020.06.22.03.32.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 22 Jun 2020 03:32:45 -0700 (PDT)
Date:   Mon, 22 Jun 2020 11:32:43 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>
Cc:     linux-kernel@vger.kernel.org, Rob Herring <robh+dt@kernel.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Heiko Stuebner <heiko.stuebner@theobroma-systems.com>,
        Stephan Gerhold <stephan@gerhold.net>,
        Lubomir Rintel <lkundrak@v3.sk>,
        Mark Brown <broonie@kernel.org>, allen <allen.chen@ite.com.tw>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        devicetree@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-rtc@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Heiko Stuebner <heiko@sntech.de>,
        Josua Mayer <josua.mayer@jm0.eu>,
        Andreas Kemnade <andreas@kemnade.info>
Subject: Re: [RFC PATCH 01/10] DT bindings in plain text format
Message-ID: <20200622103243.GT954398@dell>
References: <20200620223915.1311485-1-j.neuschaefer@gmx.net>
 <20200620223915.1311485-2-j.neuschaefer@gmx.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200620223915.1311485-2-j.neuschaefer@gmx.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 21 Jun 2020, Jonathan Neuschäfer wrote:

> For reference, here are the devicetree bindings in plaintext format.
> (Not for merge.)

This would be better placed inside the relevant patch(es), rather than
in a separate non-mergeable extra/superfluous patch.

> Signed-off-by: Jonathan Neuschäfer <j.neuschaefer@gmx.net>
> ---
>  .../bindings/mfd/netronix,ntxec.txt           | 58 +++++++++++++++++++
>  .../bindings/pwm/netronix,ntxec-pwm.txt       | 27 +++++++++
>  .../bindings/rtc/netronix,ntxec-rtc.txt       | 17 ++++++
>  3 files changed, 102 insertions(+)
>  create mode 100644 Documentation/devicetree/bindings/mfd/netronix,ntxec.txt
>  create mode 100644 Documentation/devicetree/bindings/pwm/netronix,ntxec-pwm.txt
>  create mode 100644 Documentation/devicetree/bindings/rtc/netronix,ntxec-rtc.txt

-- 
Lee Jones [李琼斯]
Senior Technical Lead - Developer Services
Linaro.org │ Open source software for Arm SoCs
Follow Linaro: Facebook | Twitter | Blog
