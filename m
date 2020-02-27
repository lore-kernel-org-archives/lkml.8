Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E58DC11D3D
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:49:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6069246A1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 16:49:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="JVDpoWt8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbgB0Qs5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 11:48:57 -0500
Received: from mail-ed1-f67.google.com ([209.85.208.67]:38492 "EHLO
        mail-ed1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730046AbgB0Qs4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 11:48:56 -0500
Received: by mail-ed1-f67.google.com with SMTP id e25so1126880edq.5;
        Thu, 27 Feb 2020 08:48:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mrSFqnVMYjr5LH7KLuZAMohOnpAE5KeOvpkhkgiQ7nk=;
        b=JVDpoWt82ZNIs+/qqmvzZDPiSMTl2h5jbMFhbT1lvA78u6JgDo/dQmrK2puPjwAwP3
         RkS1yzIAobGC6Zmksp/FkI13KFDvx6rOhLJsTEiOznd8okEEwbLrZ7TKOeC4AVlI/85A
         4YgEkMOOO9f0eqv2mPa20WMIhlM/T87kvHqFMejwMofu95Ny3EX/T74fOQw/4OLBT8a9
         oYrjVBmeSXAAKZR9mhpmORge6MUQ5UmmbuKjESPvb1u2vy4qhU7P4Z7o1p2PQHkdH7eZ
         SLqG8wqClsOh5gDJT/djL0FcL86FlywE8Lz7YsfAXqZCNDdHij8Xp87Bm7boS91gJsfb
         Buyw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=mrSFqnVMYjr5LH7KLuZAMohOnpAE5KeOvpkhkgiQ7nk=;
        b=AvTACVWtv1CLFIoa+v7Ox+dgYP9l83Z+E0NYawcenN8yuLbxpIHmuMzgjMtLreEsXD
         XufaNmqTIA311HUsjfKqsH2b/k5p/Vhlg7B1C4wenu2HLfhQ2WVdZS1+srVAps+qUVWl
         r5QLjtSIvZEM8TJRhnVbWN5dpqlcxicsT+qE+gJM/toNCenCe2LQNJOm09Ic8JgIeGt2
         gcYw6wFhSFgqWNpQ/mbMyqK28YyvnNyhV/rGl37EHndZivfpC1tUsvfqGnXWYUBio/+P
         N0vbRB6pq6JgqZ8Cd5kaL9GPfDryHE79U1waUzybHSJvzYE/D0Ngr6Paw+nNCZQ4kFVJ
         d/Xw==
X-Gm-Message-State: APjAAAU5ZX6izZ/HnCWkEavG6gt2NojUUyvgLRbQpT8ccj9+YTe1AB46
        Ek4EYRSS/YQB260mdFDibKuDxz6n7LX1lA==
X-Google-Smtp-Source: APXvYqwhUtkanpw68kBptPOsgl3fviBP3Wz8rAaJ0/w5+G9818Imde3cJkzN/sfPQtfcBSu8wsDZ5A==
X-Received: by 2002:a17:906:2acb:: with SMTP id m11mr13469eje.180.1582822133530;
        Thu, 27 Feb 2020 08:48:53 -0800 (PST)
Received: from localhost.localdomain ([5.2.67.190])
        by smtp.googlemail.com with ESMTPSA id d2sm107455edr.97.2020.02.27.08.48.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Feb 2020 08:48:52 -0800 (PST)
From:   Tomasz Maciej Nowak <tmn505@gmail.com>
To:     robh+dt@kernel.org, mark.rutland@arm.com,
        gregory.clement@bootlin.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] arm64: dts: marvell: espressobin: indicate dts version
Date:   Thu, 27 Feb 2020 17:48:41 +0100
Message-Id: <20200227164842.11116-1-tmn505@gmail.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The commit introducing ESPRESSObin variants didn't specify dts version,
and because of that they are treated by dtc as legacy ones. Fix that by
properly specifying version in each dts.

Fixes: 447b878935 ("arm64: dts: marvell: add ESPRESSObin variants")
Signed-off-by: Tomasz Maciej Nowak <tmn505@gmail.com>
---
 arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts    | 2 ++
 arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts | 2 ++
 arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts      | 2 ++
 arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi        | 2 --
 4 files changed, 6 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
index bd9ed9dc9c3e..ec72a11ed80f 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-emmc.dts
@@ -11,6 +11,8 @@
  * Schematic available at http://espressobin.net/wp-content/uploads/2017/08/ESPRESSObin_V5_Schematics.pdf
  */
 
+/dts-v1/;
+
 #include "armada-3720-espressobin.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
index 6e876a6d9532..03733fd92732 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7-emmc.dts
@@ -11,6 +11,8 @@
  * Schematic available at http://wiki.espressobin.net/tiki-download_file.php?fileId=200
  */
 
+/dts-v1/;
+
 #include "armada-3720-espressobin.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
index 0f8405d085fd..8570c5f47d7d 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin-v7.dts
@@ -11,6 +11,8 @@
  * Schematic available at http://wiki.espressobin.net/tiki-download_file.php?fileId=200
  */
 
+/dts-v1/;
+
 #include "armada-3720-espressobin.dtsi"
 
 / {
diff --git a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
index 53b8ac55a7f3..c8e2e993c69c 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
+++ b/arch/arm64/boot/dts/marvell/armada-3720-espressobin.dtsi
@@ -7,8 +7,6 @@
  *
  */
 
-/dts-v1/;
-
 #include <dt-bindings/gpio/gpio.h>
 #include "armada-372x.dtsi"
 
-- 
2.25.1

