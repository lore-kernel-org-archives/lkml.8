Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D532CC2BB1D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 03:47:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ABF1F20716
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 03:47:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nXJ2trjb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727549AbgCODrJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 23:47:09 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:39701 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727140AbgCODrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 23:47:09 -0400
Received: by mail-wm1-f67.google.com with SMTP id f7so14359595wml.4;
        Sat, 14 Mar 2020 20:47:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ug9BTgmJGi8NUr0tGrh5CaZInERxLeb5201yui/HpNQ=;
        b=nXJ2trjbMjeu8qK5jque7iej42Qy5Qc+uzWMP9G5JD4LmPtyrkqhzRKRWelKil+F9G
         pc0gFY9v5dU7F1snlQAxQN8O4qhl7w8GiWJU8HhGlz0PxLZMRgBQEbtW80eEPLk/qgph
         eTozSIXrOPVP/WimNOvbOzouDfbG6oJv0nWXBScx31AHdPhdv+C6zfSekffu+DnAiZbG
         jRMIux/juOs2HRXYSr+R1/wR4joKPSLMsNAePslZKA7rWCDzbSKhXWyM66JFJaaOsDa5
         DGaLKzmiL1yM7jrUKxRHnIlmp3FnC9hjHds13SquoaJPtmT7BV37imoK7uoL50XYQ9yW
         06uQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ug9BTgmJGi8NUr0tGrh5CaZInERxLeb5201yui/HpNQ=;
        b=dRS4HJqArxAEAIRD73x0GuIbyruCLnGnDeVGdLS5KqAmVtTzBGYlBX4VDJ7pNqfG++
         3u1zMhUErQedsgmDhSWiBNuqGqnXPsDr5o5zUJz/HEiuzdqXnofvYQMu3iskF2OiF+Qo
         HwMtE2ZIxkLblkm6ap26zDRIr7reKsZHIvQWv09yczQzeuBSk4F7/C9kZl3KjvgkxdZn
         iFmIR5/64ZGo+6SSJIV8kYIIu3cdRWGC1uiRuXyO7Xtgwi3sWbvTBF0IsIzdeSoxPiVi
         pb2EGrd0W/dFGqfYIbH+WSoCPAptDFWQkp5LOljPEQ8yj17Wj8k1hVTFPk3mytjC1szd
         63+g==
X-Gm-Message-State: ANhLgQ28kY77gQod1IOO9KUqXdsTP9XSQr2hkACk5U+mJazveeTt6HFr
        3txKYnWq1Nyx9UsBpN8HHg50uSz6
X-Google-Smtp-Source: ADFU+vtC0cnr1UOuwuED1RIpL0D0venxkMj2BASKPi20qZ7Y9Bh32wYkLHE1AtBQCqFZIEnXGRhWew==
X-Received: by 2002:a1c:b187:: with SMTP id a129mr13669908wmf.56.1584194882638;
        Sat, 14 Mar 2020 07:08:02 -0700 (PDT)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id v8sm81788051wrw.2.2020.03.14.07.08.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Sat, 14 Mar 2020 07:08:02 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: fix vref-supply for &saradc node rk3288 firefly reload
Date:   Sat, 14 Mar 2020 15:07:55 +0100
Message-Id: <20200314140755.4877-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives this error:

arch/arm/boot/dts/rk3288-firefly-reload.dt.yaml: saradc@ff100000:
'vref-supply' is a required property

PMIC Channel OUT11 with powername 'vcc_18'
(connected through R155 bridge with 'vccio_wl')
is used for the recovery key and ADC_AVDD_1V8.

Fix error by adding 'vcc_18' as vref for the saradc.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/iio/adc/
rockchip-saradc.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
Schematic:

http://www.t-firefly.com/download/Firefly-RK3288-Reload/hardware/MainBoard/
Schematic/FIREFLY-RK3288_RELOAD_V10_Schematic.pdf
---
 arch/arm/boot/dts/rk3288-firefly-reload.dts | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm/boot/dts/rk3288-firefly-reload.dts b/arch/arm/boot/dts/rk3288-firefly-reload.dts
index 1574383fd..8c38bda21 100644
--- a/arch/arm/boot/dts/rk3288-firefly-reload.dts
+++ b/arch/arm/boot/dts/rk3288-firefly-reload.dts
@@ -234,6 +234,7 @@
 };
 
 &saradc {
+	vref-supply = <&vcc_18>;
 	status = "okay";
 };
 
-- 
2.11.0

