Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 612A3C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2D567246AE
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 11:39:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Kqc24jvg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726897AbgB1Lje (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 06:39:34 -0500
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37630 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726857AbgB1Ljd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 06:39:33 -0500
Received: by mail-wm1-f67.google.com with SMTP id a141so2842709wme.2;
        Fri, 28 Feb 2020 03:39:31 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=1nT2rygpRjcW5Hc5nEx4+QR4Y0c2ZJTbeTcqfJuIxf8=;
        b=Kqc24jvgOU22EK6INyCirOks2OzBu06s3R229MgyxZlaO9KwA00EYavqHNtqMuhU37
         ZiGekBb6KP2Ovyu+ihydi+f0LrC/EjezkTbIzbAClYGMe+0/enh0qgPePsV6ybOBXbww
         0ILwtqR0otTE4mjqS0m7vd8Yjtr6PvVWIrMmavPdV8KJLRSu88YK3Q3wzK71tZffUftz
         w0vVxuoPAbgR1dYb7fmHNohJXdeRq2vAWCowCI3h7CjjwJ+xS8FxjvAjxTeg5iWzcole
         zB3TTxUX4tQcz6qFEE0QYfc2VtTYYmwLrqxeaFnX1I+L9l4UKP5npgDqKCaLSdvSrscf
         YZMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=1nT2rygpRjcW5Hc5nEx4+QR4Y0c2ZJTbeTcqfJuIxf8=;
        b=Ad7HyDwK1ap2f+7qIMeTNppCE46kT0vgL3ZpUzhjRjZAwTTbenP7+fhf616ux+obt7
         lLkJjy2YHcXJ8c8/e3eN3gHUAKOu75li3HW487DacXcg+kq3HfPmB05l+E1EGMrYybvg
         dGOdjMbacbSk68Au3xp0C4rHJjeTnuu0ZTzOoaCaTYisStzI2Oqv1vnHD8RuabOGdkt+
         0imMCmvL7MDPsW2VIvTS1DKUgc4zSGFA9jfGNdL/soY9ODQRcaS2rGWfZMf34R0VqUG4
         p8s+RIcEkmnmTTieAQchcz/NrzRqNjJg0di+FEsEuty0FthECNc+uChR8qz6G2eZL5LZ
         FO5Q==
X-Gm-Message-State: APjAAAVv+GHQ3oSKokvYAyg0hAslHeqSOwbeKDaJMb6mNSshsq69lCJ8
        yKlNyCYTLdtiKtz1TUPisogvaTR6
X-Google-Smtp-Source: APXvYqzl/ZY5TQUvn+/CB3/RaLjU8StBmIRt1iV97hCR5IEM+O1KSpKMioYZFHvB/LGdaLFAWtBYbg==
X-Received: by 2002:a1c:3204:: with SMTP id y4mr4362124wmy.166.1582889970418;
        Fri, 28 Feb 2020 03:39:30 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id q1sm11554294wrw.5.2020.02.28.03.39.29
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 28 Feb 2020 03:39:29 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: remove g-use-dma from rockchip usb nodes
Date:   Fri, 28 Feb 2020 12:39:21 +0100
Message-Id: <20200228113922.20266-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives these errors:

arch/arm/boot/dts/rv1108-elgin-r1.dt.yaml: usb@30180000:
'g-use-dma' does not match any of the regexes: 'pinctrl-[0-9]+'
arch/arm/boot/dts/rv1108-evb.dt.yaml: usb@30180000:
'g-use-dma' does not match any of the regexes: 'pinctrl-[0-9]+'
arch/arm/boot/dts/rk3228-evb.dt.yaml: usb@30040000:
'g-use-dma' does not match any of the regexes: 'pinctrl-[0-9]+'
arch/arm/boot/dts/rk3229-evb.dt.yaml: usb@30040000:
'g-use-dma' does not match any of the regexes: 'pinctrl-[0-9]+'
arch/arm/boot/dts/rk3229-xms6.dt.yaml: usb@30040000:
'g-use-dma' does not match any of the regexes: 'pinctrl-[0-9]+'

'g-use-dma' is not a valid option in dwc2.yaml, so remove it
from all Rockchip dtsi files.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=Documentation/devicetree/bindings/usb/dwc2.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk322x.dtsi | 1 -
 arch/arm/boot/dts/rv1108.dtsi | 1 -
 2 files changed, 2 deletions(-)

diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index 4e90efdc9..dac930be3 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -718,7 +718,6 @@
 		g-np-tx-fifo-size = <16>;
 		g-rx-fifo-size = <280>;
 		g-tx-fifo-size = <256 128 128 64 32 16>;
-		g-use-dma;
 		phys = <&u2phy0_otg>;
 		phy-names = "usb2-phy";
 		status = "disabled";
diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index 1fd06e7cb..9bb109d66 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -527,7 +527,6 @@
 		g-np-tx-fifo-size = <16>;
 		g-rx-fifo-size = <280>;
 		g-tx-fifo-size = <256 128 128 64 32 16>;
-		g-use-dma;
 		phys = <&u2phy_otg>;
 		phy-names = "usb2-phy";
 		status = "disabled";
-- 
2.11.0

