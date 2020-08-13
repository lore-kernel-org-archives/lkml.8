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
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CC87C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 17:25:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 31DE120716
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 17:25:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="K94gyUdQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726564AbgHMRZD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 13:25:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41308 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgHMRZD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 13:25:03 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FEF5C061383;
        Thu, 13 Aug 2020 10:25:01 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id qc22so7039417ejb.4;
        Thu, 13 Aug 2020 10:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=JSziVWRJLj99fs/o9jvqTmAPB4w60TkQsdXXf0rek18=;
        b=K94gyUdQRZPmB05+3k9Z1PSC0eQHaDF9c/bZGoTac1j0890sqK8Vt9xySvufBvy52n
         E5eAM8x2Uz2LCkFpQ8MWR7lluDTuYrjrMZUSqN9qpOLvifamb1PsR/5acusPJQBN+XXB
         7hwbeLXdiuy4aK7Scou98e6zLc/VBDJw+dQmaPageVPlRd62c8bzwL4OXqgXCfgjs1VJ
         BL5k8c7Yjpm+CvVUbtd9rDA59CUdU0VgLkT++gs9YnYBCq40VEox65WzfkeLhQwHm8rk
         2/nbfH8NHV1DSvw1NeIQM4iC83kbyEHjvWJGo59qqBF+g4WZ0Was9WhRLZ3PvevYyTp8
         2vVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=JSziVWRJLj99fs/o9jvqTmAPB4w60TkQsdXXf0rek18=;
        b=JV0BC7+7nK+9rV2qASX5coqOR/oOcGjNyPFh145lbeFav22Y/b/bj5OqzvIjWvTs2f
         VbqNTslkxp/EoQwU83CNTCyLRLuSGbtzsm8t9efR60+KKIaYHy+HMefhksD1L+lWSoDB
         YNCLqAmh6s45AU6eti38F03B/T+1cKZhsTwPTMuL3OhthNynutdobh98ysvPIwxe+PgC
         kf1Puek2KBNz8mFNK2lGXNO0mwSThBcrHui0lQQvdX7Xl1awuvEfK+olx4XefY2s7kah
         LtP+tYHofI7ocBD6Hy9U+AEhUu2fgdAy/CNY2LO75S9mnUqW5lJSWrlWpXn4wpvweFwO
         ZM3A==
X-Gm-Message-State: AOAM531lWJd4AdwNVOVa0N6i6W7uJeW5DCz2cKMC2Js0L62I1q3iKQw6
        kAXa/lTws7ShE1n5qlXL2PU=
X-Google-Smtp-Source: ABdhPJz8ON0Jv1CjEw96HVcM4iHk0E1Oa/AAFcWQGJr05GyftdwWS0GRU2210nrlt3Aw7v7LJMTgsQ==
X-Received: by 2002:a17:906:60d5:: with SMTP id f21mr5777833ejk.94.1597339500199;
        Thu, 13 Aug 2020 10:25:00 -0700 (PDT)
Received: from debian.home (81-204-249-205.fixed.kpn.net. [81.204.249.205])
        by smtp.gmail.com with ESMTPSA id u4sm4369408edy.18.2020.08.13.10.24.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 13 Aug 2020 10:24:59 -0700 (PDT)
From:   Johan Jonker <jbx6244@gmail.com>
To:     heiko@sntech.de
Cc:     robh+dt@kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] ARM: dts: rockchip: update cpu supplies on rk3066a
Date:   Thu, 13 Aug 2020 19:24:51 +0200
Message-Id: <20200813172451.13754-2-jbx6244@gmail.com>
X-Mailer: git-send-email 2.11.0
In-Reply-To: <20200813172451.13754-1-jbx6244@gmail.com>
References: <20200813172451.13754-1-jbx6244@gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The use of cpu0-supply for cpu0 alone is deprecated,
so add cpu-supply to each cpu separately and
update all existing rk3066a boards.

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
---
 arch/arm/boot/dts/rk3066a-bqcurie2.dts  | 6 +++++-
 arch/arm/boot/dts/rk3066a-marsboard.dts | 6 +++++-
 arch/arm/boot/dts/rk3066a-rayeager.dts  | 6 +++++-
 3 files changed, 15 insertions(+), 3 deletions(-)

diff --git a/arch/arm/boot/dts/rk3066a-bqcurie2.dts b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
index 0a56a2f1b..eba7a1344 100644
--- a/arch/arm/boot/dts/rk3066a-bqcurie2.dts
+++ b/arch/arm/boot/dts/rk3066a-bqcurie2.dts
@@ -63,7 +63,11 @@
 };
 
 &cpu0 {
-	cpu0-supply = <&vdd_arm>;
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_arm>;
 };
 
 &i2c1 {
diff --git a/arch/arm/boot/dts/rk3066a-marsboard.dts b/arch/arm/boot/dts/rk3066a-marsboard.dts
index 7e01f6406..6b121658d 100644
--- a/arch/arm/boot/dts/rk3066a-marsboard.dts
+++ b/arch/arm/boot/dts/rk3066a-marsboard.dts
@@ -47,7 +47,11 @@
 };
 
 &cpu0 {
-	cpu0-supply = <&vdd_arm>;
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_arm>;
 };
 
 &i2c1 {
diff --git a/arch/arm/boot/dts/rk3066a-rayeager.dts b/arch/arm/boot/dts/rk3066a-rayeager.dts
index f9db6bb9f..309518403 100644
--- a/arch/arm/boot/dts/rk3066a-rayeager.dts
+++ b/arch/arm/boot/dts/rk3066a-rayeager.dts
@@ -128,7 +128,11 @@
 };
 
 &cpu0 {
-	cpu0-supply = <&vdd_arm>;
+	cpu-supply = <&vdd_arm>;
+};
+
+&cpu1 {
+	cpu-supply = <&vdd_arm>;
 };
 
 &emac {
-- 
2.11.0

