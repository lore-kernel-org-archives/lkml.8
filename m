Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F2ECC433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 18:02:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7231020774
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 18:02:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="scDYOzoz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726518AbgHMSCv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 14:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726167AbgHMSCu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 14:02:50 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 80D61C061757;
        Thu, 13 Aug 2020 11:02:50 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id g19so7131350ejc.9;
        Thu, 13 Aug 2020 11:02:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=k+X7I3Dm91g0VsSZVIvYnQK6r71BRXtlbeCFbFsrk64=;
        b=scDYOzozLAVzFpo2tbfIot2rR9/9IltAD0tuAFuZ7Q71nxeQbbQNCj22+aLiCqCYPQ
         InGoDHYkp1iGqDUMlAuLtnqGrF2877ip1R9rbaQtVY7ZEHNotMQOeppIeqM/PtfskRMU
         KvVpOm/lImRYi24xXHTpTqfuFjxCnrXVmFy36Hxa5+6bg5DIFQn4EIKo2SFkDYS3cFR0
         IlgXGiudJyvnzZqs9lkCGMFd2GHvaVbMNAzKHXl7FxW5q1b5y5IH+w2iRy3ZVWO+xnx4
         nm6tNRw9wlSmmNKr1mgK7BhWW7ucPcSE5m2hYkdNbbQ+i6zy5zNkZ6zEhSyYA2YD0fhe
         BoHg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=k+X7I3Dm91g0VsSZVIvYnQK6r71BRXtlbeCFbFsrk64=;
        b=cz4Agg23y1egc/4VYvSCljm7v2PzW5ebxhZbLCPKwHxmwRoMPN6q6A8KhzUj54UJpj
         q91ZD4kpzYnfiD8Bj7fLF97/mWfWTdEUa9aijmchyeWWgZdUn+7x7+dRgNtqq6OLMY66
         2RyQnV2hr02H8/u7OFuHKlW8xoRcWLY00hrhD7m8pegxGlOcTDETMIed+1dcLESILdii
         X55wO8MDJv3g2oObO35Zud4l/vHXNQfSoyfUtMlCSKRgAY11vqlUFosl8rwmFWn4GO2c
         aROPsJ3vzIhDY7tKefCdcrpIvjSMAK/AJ2EKQiS3Z22g6dU9N9gCGjvFGNHROojM/MJX
         erKA==
X-Gm-Message-State: AOAM533gUpEm55gVwg4+HWmsyUjn/pxitYnUYjYFUTMQnMHlepSsaPAC
        7ccBxjRih+qUelJQGzi2q30=
X-Google-Smtp-Source: ABdhPJxM58xedodB7DOsuuj57AwE9aKU+sUl+gC9XA4qMAErBNxt/zB0UcR4VAT9G/tRXl9btm+U4Q==
X-Received: by 2002:a17:906:7f0e:: with SMTP id d14mr5917864ejr.400.1597341768898;
        Thu, 13 Aug 2020 11:02:48 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id ci27sm5131051ejc.23.2020.08.13.11.02.47
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2020 11:02:48 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] ARM: dts: rockchip: update cpu supplies on rk3288
Date:   Thu, 13 Aug 2020 20:02:41 +0200
Message-Id: <20200813180241.14660-1-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of cpu0-supply for cpu0 alone is deprecated,
so add cpu-supply to each cpu separately and
update all existing rk3288 boards that use this property.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3288-miqi.dts     | 14 +++++++++++++-
 arch/arm/boot/dts/rk3288-popmetal.dts | 14 +++++++++++++-
 arch/arm/boot/dts/rk3288-r89.dts      | 14 +++++++++++++-
 arch/arm/boot/dts/rk3288-vyasa.dts    | 14 +++++++++++++-
 4 files changed, 52 insertions(+), 4 deletions(-)

diff --git a/arch/arm/boot/dts/rk3288-miqi.dts b/arch/arm/boot/dts/rk3288-miqi.dts
index 213c9eb84..8a3992105 100644
--- a/arch/arm/boot/dts/rk3288-miqi.dts
+++ b/arch/arm/boot/dts/rk3288-miqi.dts
@@ -81,7 +81,19 @@
 };
 
 &cpu0 {
-	cpu0-supply = <&vdd_cpu>;
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_cpu>;
 };
 
 &emmc {
diff --git a/arch/arm/boot/dts/rk3288-popmetal.dts b/arch/arm/boot/dts/rk3288-popmetal.dts
index 6a5194039..160ed8b93 100644
--- a/arch/arm/boot/dts/rk3288-popmetal.dts
+++ b/arch/arm/boot/dts/rk3288-popmetal.dts
@@ -103,7 +103,19 @@
 };
 
 &cpu0 {
-	cpu0-supply = <&vdd_cpu>;
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_cpu>;
 };
 
 &emmc {
diff --git a/arch/arm/boot/dts/rk3288-r89.dts b/arch/arm/boot/dts/rk3288-r89.dts
index a258c7ae5..e5ba901c7 100644
--- a/arch/arm/boot/dts/rk3288-r89.dts
+++ b/arch/arm/boot/dts/rk3288-r89.dts
@@ -91,7 +91,19 @@
 };
 
 &cpu0 {
-	cpu0-supply = <&vdd_cpu>;
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_cpu>;
 };
 
 &gmac {
diff --git a/arch/arm/boot/dts/rk3288-vyasa.dts b/arch/arm/boot/dts/rk3288-vyasa.dts
index 1a20854a1..aa50f8ed4 100644
--- a/arch/arm/boot/dts/rk3288-vyasa.dts
+++ b/arch/arm/boot/dts/rk3288-vyasa.dts
@@ -125,7 +125,19 @@
 };
 
 &cpu0 {
-	cpu0-supply = <&vdd_cpu>;
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu2 {
+	cpu-supply = <&vdd_cpu>;
+};
+
+&cpu3 {
+	cpu-supply = <&vdd_cpu>;
 };
 
 &emmc {
-- 
2.11.0

