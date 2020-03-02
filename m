Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CEE8DC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:31:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A6F1C2084E
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 15:31:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="NSQIFwJD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727210AbgCBPbH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 10:31:07 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:38682 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726751AbgCBPbF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 10:31:05 -0500
Received: by mail-wr1-f68.google.com with SMTP id t11so193562wrw.5;
        Mon, 02 Mar 2020 07:31:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=eFDMzvNJhb9C/gjmO5CDDLNllKw2BwatUidg0r9OWqc=;
        b=NSQIFwJD1hXMDRKHfbPuIpu/mXLa55KLrT5j9PkX2LU2p6fhyD5ya9mMjqqi9hYXns
         ojy+Xua5CGm/m0RBQPSaq2h6039qAft3JpLhUHEFvmilxIJM7zps6og557U91v93+M/S
         lYz1C1YMUA8gKmbKd5PDDp3nHPW1kJbvQ/Rvsj2NwajiE5d/5dgwslqDIJ+QV+ubL921
         e+kmE0tuiwM4jTR2vUUVzi3J9iWRp4xpFRhiGTgKquBIqWqb2PGCj5L+xNvLw+K32d/C
         xvSrsD/d3RvqeiYWxUDCMW8XtKGORklwjwOIbe3l6XJ3F1dDSyoeUEP3x7jAPBEL0DPy
         V4YA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=eFDMzvNJhb9C/gjmO5CDDLNllKw2BwatUidg0r9OWqc=;
        b=ZF3ZhB65LRZSRkJbjZBs/XU50hPrw5AovugVsyM5l828UfH6AQUDYtK7UMV4iO4tXJ
         aF4OkdsbxwRe5MmOY5N2YaJ7j3MN/Jxd8b8Sn2HEMStfKkKqDsPoyDNCeOjmrMot7VB5
         swsA9npbdpd9NpqPvz+MjhsxLKuXpJrpoho7wB0XkAJI+xO0QcLdz0cTz92v2OzEPyOX
         g2xyq67xL+eM7GSP0CKbWftdsdjS2YWDTp8tthJfb69bHU70wtspZjTtqKxJJorm34rq
         CSkpATcCWwLQdpkiWC2lNk3la6kJ3vSXxlYUJQHDXZDoXnlsYyzKikM6vAXy3Vvc5JSh
         DSqw==
X-Gm-Message-State: ANhLgQ1rWBQNkITB1+/u3ZOZfxkei/vtE8EWJS9Q9umGNclC39bY+5mU
        1c3XSF0Q97hQTDenNiCUm/I=
X-Google-Smtp-Source: ADFU+vvbIMHFtMOd/nNEBuz9Sck5/PZWnPzOs6+fSxM1d70yAvo48rCFI0OCKH6irEXdAFZNLy9kgw==
X-Received: by 2002:adf:dfcc:: with SMTP id q12mr140710wrn.171.1583163063985;
        Mon, 02 Mar 2020 07:31:03 -0800 (PST)
Received: from debian.home (ip51ccf9cd.speed.planet.nl. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id g7sm23967540wrm.72.2020.03.02.07.31.02
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 02 Mar 2020 07:31:03 -0800 (PST)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] arm64: dts: add bus to rockchip amba nodenames
Date:   Mon,  2 Mar 2020 16:30:47 +0100
Message-Id: <20200302153047.17101-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200302153047.17101-1-jbx6244@gmail.com>
References: <20200302153047.17101-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

A test with the command below gives for example this error:

arch/arm64/boot/dts/rockchip/rk3399-evb.dt.yaml: amba: $nodename:0:
'amba' does not match
'^(bus|soc|axi|ahb|apb)(@[0-9a-f]+)?$'

AMBA is a open standard for the connection and
management of functional blocks in a SoC.
It's compatible with 'simple-bus', so fix this error
by adding 'bus' to all Rockchip 'amba' nodes.

make ARCH=arm64 dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/
schemas/simple-bus.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm64/boot/dts/rockchip/px30.dtsi   | 2 +-
 arch/arm64/boot/dts/rockchip/rk3308.dtsi | 2 +-
 arch/arm64/boot/dts/rockchip/rk3328.dtsi | 2 +-
 arch/arm64/boot/dts/rockchip/rk3368.dtsi | 2 +-
 arch/arm64/boot/dts/rockchip/rk3399.dtsi | 2 +-
 5 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/boot/dts/rockchip/px30.dtsi b/arch/arm64/boot/dts/rockchip/px30.dtsi
index 4f484119f..215515ccb 100644
--- a/arch/arm64/boot/dts/rockchip/px30.dtsi
+++ b/arch/arm64/boot/dts/rockchip/px30.dtsi
@@ -700,7 +700,7 @@
 		clock-names = "pclk", "timer";
 	};
 
-	amba {
+	amba: bus {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3308.dtsi b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
index 3bd5bc860..ac43bc3f7 100644
--- a/arch/arm64/boot/dts/rockchip/rk3308.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3308.dtsi
@@ -513,7 +513,7 @@
 		status = "disabled";
 	};
 
-	amba {
+	amba: bus {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3328.dtsi b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
index bad41bc6f..d9490f417 100644
--- a/arch/arm64/boot/dts/rockchip/rk3328.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3328.dtsi
@@ -142,7 +142,7 @@
 		};
 	};
 
-	amba {
+	amba: bus {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3368.dtsi b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
index a0df61c61..2079e877a 100644
--- a/arch/arm64/boot/dts/rockchip/rk3368.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3368.dtsi
@@ -136,7 +136,7 @@
 		};
 	};
 
-	amba {
+	amba: bus {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
diff --git a/arch/arm64/boot/dts/rockchip/rk3399.dtsi b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
index 33cc21fcf..63355ba7c 100644
--- a/arch/arm64/boot/dts/rockchip/rk3399.dtsi
+++ b/arch/arm64/boot/dts/rockchip/rk3399.dtsi
@@ -197,7 +197,7 @@
 		#clock-cells = <0>;
 	};
 
-	amba {
+	amba: bus {
 		compatible = "simple-bus";
 		#address-cells = <2>;
 		#size-cells = <2>;
-- 
2.11.0

