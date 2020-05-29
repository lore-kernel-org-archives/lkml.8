Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A01BC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:17:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2DA0C20897
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 19:17:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="e8bCMAyL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728089AbgE2TRB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 15:17:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57268 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726487AbgE2TQz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 15:16:55 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03DE3C03E969;
        Fri, 29 May 2020 12:16:55 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id j21so376967pgb.7;
        Fri, 29 May 2020 12:16:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rVJ4oym9rXNaA44QDrgvFNwDxvnSEboxykGaMiySkgs=;
        b=e8bCMAyLHpJLcqYLQqZZDht6uuebj1TuWkqtHigbjOtfuYf7r7e2Z2nuDzvmeYWye8
         ISLuDOIDYjYLgMr2fp1fS2EyCOkdolUyYJ0P4ayRk1lHPo4NbMvYUSIle6gYCWxMnrY5
         HizoyhEWEXujdeh84kihxqQOmxlox72Q4Mcb/NiNxh+UHn/Cxmr9MVW1vvprYdxFs6Jr
         zMKzecjD5RVozG5UQHC8FFquRl97KQj+3FDl/9aCV/wTQ/ordlwKbUCy3Fn22Q7rQuoy
         1W4joTFu/WZObaCZucseqLwJ/sEERl/KzykmRAq4PLNAbD0hL8CbiBMM3e3WL8U+Wvq6
         HnEQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rVJ4oym9rXNaA44QDrgvFNwDxvnSEboxykGaMiySkgs=;
        b=rlpihcSZauWOQT1jabhWd7X5RjCsi47BnLcbVSKxZTXiiM5ZtlL33KAMESUMyqyIJf
         7MlZBuDmw3q2s6vIrNagtp2Gjt7PVP2KAYNuYk6SCCfv2bS+b5715xfN0xx+9CWbrGUF
         cWQa85X424EVK5Bjdcm/vN4Wxs298ki1r8CwM3AOSgtjaGAUIEM8xWcPinbSsCMzgd4m
         +k2aRZIxwUk1Gn5AuHblyQWyiojN+JOAqsXsrD/jlBfu+jpVKziL+/Zior6IQM1xmqc+
         QSvVxodB9kaotJLpmNkGx1v4jegybgvmRf9/dpS9FgC1Q0wDIhET4P8PJcVoIVhBVt7R
         qoRg==
X-Gm-Message-State: AOAM532rBlSF8I6/k00ugbz2mmML0ksSqCsOfaf1+FnuNuI/eWdz9xvi
        J9duAE2K9qD+lCC2VJGNmwiK7cbX
X-Google-Smtp-Source: ABdhPJx7r38iIDo0qGEq+vFJYFEOCNcSDuK8YR7v1WEhbpUkyWY4kW5XuMX9Kn5N8uN+upi4P1k3zg==
X-Received: by 2002:a63:b10b:: with SMTP id r11mr9210726pgf.27.1590779814156;
        Fri, 29 May 2020 12:16:54 -0700 (PDT)
Received: from fainelli-desktop.igp.broadcom.net ([192.19.223.252])
        by smtp.gmail.com with ESMTPSA id g92sm202505pje.13.2020.05.29.12.16.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 29 May 2020 12:16:53 -0700 (PDT)
From:   Florian Fainelli <f.fainelli@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     Florian Fainelli <f.fainelli@gmail.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        Rob Herring <robh+dt@kernel.org>, Ray Jui <rjui@broadcom.com>,
        Scott Branden <sbranden@broadcom.com>,
        bcm-kernel-feedback-list@broadcom.com (maintainer:BROADCOM
        BCM281XX/BCM11XXX/BCM216XX ARM ARCHITE...),
        Nicolas Saenz Julienne <nsaenzjulienne@suse.de>,
        Stefan Wahren <stefan.wahren@i2se.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Matti Vaittinen <matti.vaittinen@fi.rohmeurope.com>,
        linux-gpio@vger.kernel.org (open list:PIN CONTROL SUBSYSTEM),
        devicetree@vger.kernel.org (open list:OPEN FIRMWARE AND FLATTENED
        DEVICE TREE BINDINGS),
        linux-rpi-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE),
        linux-arm-kernel@lists.infradead.org (moderated list:BROADCOM
        BCM2711/BCM2835 ARM ARCHITECTURE)
Subject: [PATCH v2 3/4] pinctrl: bcm2835: Match BCM7211 compatible string
Date:   Fri, 29 May 2020 12:15:21 -0700
Message-Id: <20200529191522.27938-4-f.fainelli@gmail.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200529191522.27938-1-f.fainelli@gmail.com>
References: <20200529191522.27938-1-f.fainelli@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The BCM7211 SoC uses the same pinconf_ops as the ones defined for the
BCM2711 SoC, match the compatible string and use the correct set of
options.

Signed-off-by: Florian Fainelli <f.fainelli@gmail.com>
---
 drivers/pinctrl/bcm/pinctrl-bcm2835.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/pinctrl/bcm/pinctrl-bcm2835.c b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
index 06bd2b70af3c..1b00d93aa66e 100644
--- a/drivers/pinctrl/bcm/pinctrl-bcm2835.c
+++ b/drivers/pinctrl/bcm/pinctrl-bcm2835.c
@@ -1137,6 +1137,10 @@ static const struct of_device_id bcm2835_pinctrl_match[] = {
 		.compatible = "brcm,bcm2711-gpio",
 		.data = &bcm2711_plat_data,
 	},
+	{
+		.compatible = "brcm,bcm7211-gpio",
+		.data = &bcm2711_plat_data,
+	},
 	{}
 };
 
-- 
2.17.1

