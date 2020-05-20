Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC990C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D49020748
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 06:13:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726544AbgETGNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 02:13:11 -0400
Received: from mail-lj1-f194.google.com ([209.85.208.194]:36327 "EHLO
        mail-lj1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726224AbgETGNL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 02:13:11 -0400
Received: by mail-lj1-f194.google.com with SMTP id u15so2251381ljd.3
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 23:13:10 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=aGcDCuw1/vHuWXtJxwlKGVKRvi+XFd3+B50JgNQ/21k=;
        b=pCAg3qt9dOU/rvgIs+WHhRYSPwXP48vR//xD8fQoGYSgVSeUXcRtG4k2+W0vUIS4QX
         Lq9VV13lTVo1i1xGvW5FQdhuHA3zq6n5xh4IaMmv8dqKl/pSLiIWiod6ITZlxC5y3Zp3
         NM1Cy/jChaefTgeQH32i5YyBC+Gk3k8cFS7gRuv0C0iSh1mJq6Zl6uMA3xlYtjWL0LWK
         R6zx6KnWmR2cKdNG9GyrqfwPVlDIZrLkyw69/+K+gcW8eJZz5Hy9KbNINMG15d40jHXU
         MSSIOMm1c+i7965D0ii4qQUVB4ItjdqbjxWFvRGAnSFTo0jCL+vFbzyuiMKFq0FO2sbc
         /e0A==
X-Gm-Message-State: AOAM533amML8fjOjajy/gUeYZ6W3PqcCy6jqv/TCdMSXYDiY+NnqKF2w
        Jy8oFrgFFf7zUwjyTaVsdHc=
X-Google-Smtp-Source: ABdhPJyKInmpjz0/mIY4S2+ayr6zH/BxSFnBjr8W43iYaNaFga2JYy35moLGY70PxWpiA1S1Dq8Uuw==
X-Received: by 2002:a2e:9b48:: with SMTP id o8mr1800915ljj.130.1589955189467;
        Tue, 19 May 2020 23:13:09 -0700 (PDT)
Received: from localhost.localdomain (62-78-225-252.bb.dnainternet.fi. [62.78.225.252])
        by smtp.gmail.com with ESMTPSA id z8sm796976lfb.44.2020.05.19.23.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 23:13:08 -0700 (PDT)
Date:   Wed, 20 May 2020 09:12:30 +0300
From:   Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
To:     matti.vaittinen@fi.rohmeurope.com, mazziesaccount@gmail.com
Cc:     Michael Turquette <mturquette@baylibre.com>,
        SebastianReichel <sre@kernel.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
        Lee Jones <lee.jones@linaro.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>,
        Alessandro Zummo <a.zummo@towertech.it>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Rob Herring <robh+dt@kernel.org>, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] MAINTAINERS: Add maintainer entry for linear ranges
 helper
Message-ID: <fbbbee249c6b9df3ba63bb51ea53526b22921e84.1589866138.git.matti.vaittinen@fi.rohmeurope.com>
References: <cover.1589866137.git.matti.vaittinen@fi.rohmeurope.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <cover.1589866137.git.matti.vaittinen@fi.rohmeurope.com>
User-Agent: Mutt/1.12.1 (2019-06-15)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The linear ranges helpers were refactored out of regulator core
for other drivers to enjoy. Add regulator maintainer Mark Brown as
maintainer and myself as a reviewer.

Signed-off-by: Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
---
 MAINTAINERS | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/MAINTAINERS b/MAINTAINERS
index 63a2ca70540e..e103e7db1522 100644
--- a/MAINTAINERS
+++ b/MAINTAINERS
@@ -9720,6 +9720,13 @@ F:	drivers/lightnvm/
 F:	include/linux/lightnvm.h
 F:	include/uapi/linux/lightnvm.h
 
+LINEAR RANGES HELPERS
+M:	Mark Brown <broonie@kernel.org>
+R:	Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>
+F:	lib/linear_ranges.c
+F:	lib/test_linear_ranges.c
+F:	include/linux/linear_range.h
+
 LINUX FOR POWER MACINTOSH
 M:	Benjamin Herrenschmidt <benh@kernel.crashing.org>
 L:	linuxppc-dev@lists.ozlabs.org
-- 
2.21.0


-- 
Matti Vaittinen, Linux device drivers
ROHM Semiconductors, Finland SWDC
Kiviharjunlenkki 1E
90220 OULU
FINLAND

~~~ "I don't think so," said Rene Descartes. Just then he vanished ~~~
Simon says - in Latin please.
~~~ "non cogito me" dixit Rene Descarte, deinde evanescavit ~~~
Thanks to Simon Glass for the translation =] 
