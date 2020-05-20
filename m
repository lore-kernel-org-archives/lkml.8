Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB438C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:35:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A333A205CB
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:35:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="AYS4bewK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726486AbgETGfp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 02:35:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38508 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgETGfp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 02:35:45 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEFF4C061A0E
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 23:35:44 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id w7so1853348wre.13
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 23:35:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=X8e9+DdqYV+SAdIqeyzfnGYQqxV8nXFtA/jeVBvV+D4=;
        b=AYS4bewKPm0mXoBuf+pBAPc7dmsvaMZWt/V1+Q5A0Gc2jRr1/wc0eMIVbUpZNHs1jS
         k+37g9h8eY3pYida9l/PsgC0VzMztl3zMAHof0QoWJDeDeRscU60FOtTpS+4rlliL9os
         VaREazbMlarRQvr2/SFnSVfq/duNXRUPuaEk+ojNyOxKxo7Br8cSjPWKGLG/nR5dijWz
         Wco6fhXLkWeX+l5myNfny3YcKLE71/qnKW6kDlPwd/u9rDzNBABmxCV+PMO9oQQHp5qt
         GSk5vnFC1iNUjPaGCnnMP314959PtvPSENjIwAdmq5U87ILFQmqkNqtpbmF4/3j/oJwZ
         gzhQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=X8e9+DdqYV+SAdIqeyzfnGYQqxV8nXFtA/jeVBvV+D4=;
        b=Syq5lBgx93ZjwBoxJ8xcy/BIPuuQDhNWTygqdYupa5VAj2OcXhcL4j/EGL/er7Ps1X
         TxUa5iJFGoAZ+sU+DDPFwKb5cMQ0xUhIgJAsIm/qKJfGXcZduWbQs4wOxPUe75dotH3d
         qDhnApq6mvB1K4RvIVeJlSn0sLUe/le/pAwjjINLvF4sQS5vCjJGeQ+dLLFssmCXaHLC
         HkcBOhz0sEoASyiKrd+79wm+pzOn7f6LChIxTx/mro/AgqDKhLNtGYSSwa/tYglNsM2t
         JBtKK8oVVSxFEh+jXSaHmwTk8aZ/dCQmnD86LGk+vsUweJtSdcn9qUptSBJCo29oel+O
         tKWg==
X-Gm-Message-State: AOAM5302XQX5Raxk58ulwTwF5NVGTLQYYuTfPJclACPSWvtoW+NUqTij
        kIh/WCk3FqgcmJuSAdptW4KXcg==
X-Google-Smtp-Source: ABdhPJxf344ZmHtA6JB9WdkeSNBwygkGnCLFlWrzLLk8B5m5VmX0apfiHldrEWDu6+z2qclVKUGUbw==
X-Received: by 2002:adf:f642:: with SMTP id x2mr1208640wrp.315.1589956543719;
        Tue, 19 May 2020 23:35:43 -0700 (PDT)
Received: from dell ([95.149.164.102])
        by smtp.gmail.com with ESMTPSA id q2sm2141900wmq.23.2020.05.19.23.35.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 23:35:43 -0700 (PDT)
Date:   Wed, 20 May 2020 07:35:41 +0100
From:   Lee Jones <lee.jones@linaro.org>
To:     Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
Cc:     mazziesaccount@gmail.com,
        Michael Turquette <mturquette@baylibre.com>,
        SebastianReichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH 1/2] MAINTAINERS: Add entry for ROHM power management ICs
Message-ID: <20200520063541.GY271301@dell>
References: <cover.1589866137.git.matti.vaittinen@fi.rohmeurope.com>
 <e11366fd280736844ae63791b6193bb84d6205bf.1589866138.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <e11366fd280736844ae63791b6193bb84d6205bf.1589866138.git.matti.vaittinen@fi.rohmeurope.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 20 May 2020, Matti Vaittinen wrote:

> Add entry for maintaining power management IC drivers for ROHM
> BD71837, BD71847, BD71850, BD71828, BD71878, BD70528 and BD99954.
> 
> Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> ---
>  MAINTAINERS | 30 ++++++++++++++++++++++++++++++
>  1 file changed, 30 insertions(+)
> 
> diff --git a/MAINTAINERS b/MAINTAINERS
> index ecc0749810b0..63a2ca70540e 100644
> --- a/MAINTAINERS
> +++ b/MAINTAINERS
> @@ -14490,6 +14490,12 @@ L:	linux-serial@vger.kernel.org
>  S:	Odd Fixes
>  F:	drivers/tty/serial/rp2.*
>  
> +ROHM BD99954 CHARGER IC
> +R:	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> +S:	Supported
> +F:	drivers/power/supply/bd99954-charger.c
> +F:	drivers/power/supply/bd99954-charger.h
> +
>  ROHM BH1750 AMBIENT LIGHT SENSOR DRIVER
>  M:	Tomasz Duszynski <tduszyns@gmail.com>
>  S:	Maintained
> @@ -14507,6 +14513,30 @@ F:	drivers/mfd/bd9571mwv.c
>  F:	drivers/regulator/bd9571mwv-regulator.c
>  F:	include/linux/mfd/bd9571mwv.h
>  
> +ROHM POWER MANAGEMENT IC DEVICE DRIVERS
> +R:	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
> +S:	Supported
> +F:	Documentation/devicetree/bindings/mfd/rohm,bd70528-pmic.txt
> +F:	Documentation/devicetree/bindings/regulator/rohm,bd70528-regulator.txt
> +F:	drivers/clk/clk-bd718x7.c
> +F:	drivers/gpio/gpio-bd70528.c
> +F:	drivers/gpio/gpio-bd71828.c
> +F:	drivers/mfd/rohm-bd70528.c
> +F:	drivers/mfd/rohm-bd71828.c
> +F:	drivers/mfd/rohm-bd718x7.c
> +F:	drivers/power/supply/bd70528-charger.c
> +F:	drivers/regulator/bd70528-regulator.c
> +F:	drivers/regulator/bd71828-regulator.c
> +F:	drivers/regulator/bd718x7-regulator.c
> +F:	drivers/regulator/rohm-regulator.c
> +F:	drivers/rtc/rtc-bd70528.c
> +F:	drivers/watchdog/bd70528_wdt.c
> +F:	include/linux/mfd/rohm-shared.h
> +F:	include/linux/mfd/rohm-bd71828.h
> +F:	include/linux/mfd/rohm-bd70528.h
> +F:	include/linux/mfd/rohm-generic.h
> +F:	include/linux/mfd/rohm-bd718x7.h

How small can you get this list using wildcards?

+F:	drivers/clk/clk-bd718x7.c
+F:	drivers/gpio/gpio-bd7*
+F:	drivers/mfd/rohm-bd7*
+F:	drivers/power/supply/bd7*
+F:	drivers/regulator/bd7*
+F:	drivers/regulator/rohm-regulator.c
+F:	drivers/rtc/rtc-bd7*
+F:	drivers/watchdog/bd7*
+F:	include/linux/mfd/rohm-*

Or

+F:	drivers/*/bd7*
+F:	drivers/*/*-bd7*
+F:	drivers/*/rohm-*
+F:	drivers/*/*rohm-*
+F:	include/linux/*/rohm-*
+F:	include/linux/*/*rohm-*

Not checked either of these.  They are just an example.

>  ROSE NETWORK LAYER
>  M:	Ralf Baechle <ralf@linux-mips.org>
>  L:	linux-hams@vger.kernel.org

-- 
Lee Jones [李琼斯]
Linaro Services Technical Lead
Linaro.org │ Open source software for ARM SoCs
Follow Linaro: Facebook | Twitter | Blog
