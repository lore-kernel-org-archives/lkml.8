Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B526C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:31:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6208F2084E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:31:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="J76VcCPb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727154AbgCBPbF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:31:05 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:50918 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726969AbgCBPbE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:31:04 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so11712806wmb.0;
        Mon, 02 Mar 2020 07:31:03 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cDxTJ3U/zVDbQifHojY/+GljrxTfGRmptXZLeP80vjk=;
        b=J76VcCPby95I5ByDSiHe6gQn9iBMMgDjDXFvtmOQHiEmrNEFsAX4WbLPkQ7jJyNIju
         UkPpaEvzk93UzUpO11yPZBwQDdZITEMIgOlogKyWpAfDXOCoDvV3TM+pKSgJtbQzBdSY
         pIiKNU8qHgwGq6sON1xxHabxz/WgfjRtGF/d9uTMWgyfgdbsPQTiVMa00OJf08PN+kN2
         fhGEqlYm574HF98X/M9LB0pQ6NSVYoXxTsfJRZSLy97GLgxCDljJtJ1xjzdTbGBiU1+o
         EJZZlGby6OapdZ0o1uAg6aa4jiJrYH8rB2H5UQI/Fq6ZSrqg1W+XjflDBa2vgx/BnrD9
         VTbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cDxTJ3U/zVDbQifHojY/+GljrxTfGRmptXZLeP80vjk=;
        b=Lal+hqNn8AkC5xKg47ZIP1mNydwWxgzkli+YtJd/LdBvG+Un8Jac6kuUUa9+7wVe8n
         gRO0dSEAISvow8NA616AQXbQffjUFNDjf2MfQn2DDusvu7MosiUBNBWKCPS8Vo0ALHXM
         kwx9zqw4pA7dQ+HWeZ1KlT+UQWDCNnmyVD5xBVWF0XKmnnteDJ+Okurk1XS3t8Ot7dbp
         N13HzLLalJZJmXwMNkpVnZJs4wDbHPpgbWcOZ+8iwIWxMNZ3pCRNw8+QxSFA12sj28/W
         4jOWTZLnNp+72aaRjlhoLq2NL7BUzS0EACExEVgXCP/2W2oDFSINhZCdqZ7lrIujC6xv
         4TLg==
X-Gm-Message-State: ANhLgQ3Gxw0UkOIXFSwNPtoFwUeqpXa777If4+nDMcNjZ6VuA+g+86ds
        sXJcsH222mzWwlxrVzaY7Ef4XU2c
X-Google-Smtp-Source: ADFU+vvYp2Usg0GZFt1juRtRwKLL1LOLUPzV4bbQ9j6TD9wIYfWqOEC6l8LldndvuXDMif/X6Ebskw==
X-Received: by 2002:a1c:9d85:: with SMTP id g127mr7459wme.75.1583163062535;
        Mon, 02 Mar 2020 07:31:02 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g7sm23967540wrm.72.2020.03.02.07.31.01
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 07:31:01 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] ARM: dts: add bus to rockchip amba nodenames
Date:   Mon,  2 Mar 2020 16:30:46 +0100
Message-Id: <20200302153047.17101-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example this error:

arch/arm/boot/dts/rk3188-bqedison2qc.dt.yaml: amba: $nodename:0:
'amba' does not match '^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'

AMBA is a open standard for the connection and
management of functional blocks in a SoC.
It's compatible with 'simple-bus', so fix this error
by adding 'bus' to all Rockchip 'amba' nodes.

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/
schemas/simple-bus.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3036.dtsi | 2 +-
 arch/arm/boot/dts/rk322x.dtsi | 2 +-
 arch/arm/boot/dts/rk3288.dtsi | 2 +-
 arch/arm/boot/dts/rk3xxx.dtsi | 2 +-
 arch/arm/boot/dts/rv1108.dtsi | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm/boot/dts/rk3036.dtsi b/arch/arm/boot/dts/rk3036.dtsi
index b62138563..c28d293df 100644
--- a/arch/arm/boot/dts/rk3036.dtsi
+++ b/arch/arm/boot/dts/rk3036.dtsi
@@ -54,7 +54,7 @@
 		};
 	};
 
-	amba {
+	amba: bus {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/rk322x.dtsi b/arch/arm/boot/dts/rk322x.dtsi
index dac930be3..b98579035 100644
--- a/arch/arm/boot/dts/rk322x.dtsi
+++ b/arch/arm/boot/dts/rk322x.dtsi
@@ -95,7 +95,7 @@
 		};
 	};
 
-	amba {
+	amba: bus {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/rk3288.dtsi b/arch/arm/boot/dts/rk3288.dtsi
index 039e8aa70..8bcb4a516 100644
--- a/arch/arm/boot/dts/rk3288.dtsi
+++ b/arch/arm/boot/dts/rk3288.dtsi
@@ -155,7 +155,7 @@
 		};
 	};
 
-	amba {
+	amba: bus {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
diff --git a/arch/arm/boot/dts/rk3xxx.dtsi b/arch/arm/boot/dts/rk3xxx.dtsi
index 241f43e29..9438332b8 100644
--- a/arch/arm/boot/dts/rk3xxx.dtsi
+++ b/arch/arm/boot/dts/rk3xxx.dtsi
@@ -32,7 +32,7 @@
 		spi1 = &spi1;
 	};
 
-	amba {
+	amba: bus {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
diff --git a/arch/arm/boot/dts/rv1108.dtsi b/arch/arm/boot/dts/rv1108.dtsi
index c3621b3e6..59295babd 100644
--- a/arch/arm/boot/dts/rv1108.dtsi
+++ b/arch/arm/boot/dts/rv1108.dtsi
@@ -85,7 +85,7 @@
 		#clock-cells = <0>;
 	};
 
-	amba {
+	amba: bus {
 		compatible = "simple-bus";
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.11.0

