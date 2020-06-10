Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8AAC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:17:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8AB22072F
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 17:17:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="qPqpqjpw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729688AbgFJRRD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 13:17:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729619AbgFJRQn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 13:16:43 -0400
Received: from mail-wm1-x32f.google.com (mail-wm1-x32f.google.com [IPv6:2a00:1450:4864:20::32f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 271ADC08C5C1;
        Wed, 10 Jun 2020 10:16:43 -0700 (PDT)
Received: by mail-wm1-x32f.google.com with SMTP id u13so2551824wml.1;
        Wed, 10 Jun 2020 10:16:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oc6ktgX8Hx1cWwHwmmgN5zr23tPp1hphnIShDzaEIqk=;
        b=qPqpqjpwymwsSlaFodOqNxT4Me6+jFBmt076xKMY/4iuuaF0KJTs7ieHgBbwSXL7BX
         3nYH2YZgmIRxUCOMwmDRHqRCdN7ev44cx7oGBnYEbCXvamvgB3NY1kRo+vzKsVVu0SKP
         g11sAu9eG72SWh8HmeM6CNikd7GBSNtxsdCRyzXKAiYcjph841BuRQGpfEpMn4D8Clu7
         fri4IlKiulgfZcwUrat6iIpEiY0+KeggpDTvzsjEjXlVKd1pB2ORX/0/Rt4Wj6IfumpZ
         4RBf2UIVTbDrI3BREwYcP/hZtEPi9ZMrCIuV1mZPcyNpE/o4KNtXa5NJrHID9Bzl0BC4
         w9PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oc6ktgX8Hx1cWwHwmmgN5zr23tPp1hphnIShDzaEIqk=;
        b=lOF2/gbgtCkVStjSM7vErs4aAXfEgQea7s01Ao/O48A/rbObfHNk9m4PYeKtkZMgYk
         xG2GAo1lDlQSWdjGDWKIr36ULmCun3g/Ka8e+jkePdUlPQYBhUOpVGXBHFQxrTgV///y
         HS1ldSVZ7MZCE1v0cS5cAtHKe6wdXgGccifvYB9J+9fZ6oLN7HXHvqU+npEhaGM1ye3E
         w2+M622c+jccjiNeJ7KmUkdFgT17d/JrlARp0rpn7Fcu/wdkJfISmOkZQV8lyz0Byryo
         llLZU+FSqjgTeG74b6QUTMhVD6ITK6LNa1h1WdECCdE2iofrjchbRKmZg4ccHZkPGheZ
         YgEA==
X-Gm-Message-State: AOAM533HHpWKbAMfKziSA3CbaztN06ssQtvBKjo1KBCsOoEJGiLvpmbk
        jAE/vp44cj+b1/ixKLvx094=
X-Google-Smtp-Source: ABdhPJwoK+sQLQLvaRBB8r+8Dnj8Y2TUrOsYyjhQNtsLGboeqdhyorDA8qIpo74xVSkAPSfqe6+IQQ==
X-Received: by 2002:a7b:c5c7:: with SMTP id n7mr4171594wmk.77.1591809400863;
        Wed, 10 Jun 2020 10:16:40 -0700 (PDT)
Received: from skynet.lan (28.red-83-49-61.dynamicip.rima-tde.net. [83.49.61.28])
        by smtp.gmail.com with ESMTPSA id f11sm589048wrm.13.2020.06.10.10.16.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 10:16:40 -0700 (PDT)
From:   =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
To:     hauke@hauke-m.de, zajec5@gmail.com, tsbogend@alpha.franken.de,
        robh+dt@kernel.org, f.fainelli@gmail.com, jonas.gorski@gmail.com,
        bcm-kernel-feedback-list@broadcom.com, linux-mips@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Cc:     =?UTF-8?q?=C3=81lvaro=20Fern=C3=A1ndez=20Rojas?= 
        <noltari@gmail.com>
Subject: [PATCH v3 8/9] mips: bmips: dts: add BCM6362 power domain support
Date:   Wed, 10 Jun 2020 19:16:29 +0200
Message-Id: <20200610171630.465579-9-noltari@gmail.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200610171630.465579-1-noltari@gmail.com>
References: <20200610163301.461160-1-noltari@gmail.com>
 <20200610171630.465579-1-noltari@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

BCM6362 SoCs have a power domain controller to enable/disable certain
components in order to save power.

Signed-off-by: Álvaro Fernández Rojas <noltari@gmail.com>
Acked-by: Florian Fainelli <f.fainelli@gmail.com>
---
 v3: Separate dt-bindings definitions from power domain .dtsi support.
 v2: Add dt-bindings header files.

 arch/mips/boot/dts/brcm/bcm6362.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/mips/boot/dts/brcm/bcm6362.dtsi b/arch/mips/boot/dts/brcm/bcm6362.dtsi
index 8ae6981735b8..c98f9111e3c8 100644
--- a/arch/mips/boot/dts/brcm/bcm6362.dtsi
+++ b/arch/mips/boot/dts/brcm/bcm6362.dtsi
@@ -108,6 +108,12 @@ uart1: serial@10000120 {
 			status = "disabled";
 		};
 
+		periph_pwr: power-controller@10001848 {
+			compatible = "brcm,bcm6362-power-controller";
+			reg = <0x10001848 0x4>;
+			#power-domain-cells = <1>;
+		};
+
 		leds0: led-controller@10001900 {
 			#address-cells = <1>;
 			#size-cells = <0>;
-- 
2.26.2

