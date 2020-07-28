Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C80D8C433E5
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:03:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FC0120786
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 10:03:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=0x0f.com header.i=@0x0f.com header.b="JNqemohl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728652AbgG1KDz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 06:03:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728640AbgG1KDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 06:03:51 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9E1BC0619D2
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:03:51 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id k13so1813396plk.13
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 03:03:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=0x0f.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Qd3SyHWj5wy+W8DdCFH06h9CfnAMjEf8IGmL9iqvbmI=;
        b=JNqemohlMJJK5FleQBz+aU3vVrmawQdPE8A/kjFcY4rCS1jyRThCKrjyMmezbX/Udo
         79YOfWW4yOHB8iK2q/4aQxZLkZ3OHIc/brfET9yp0CSbstRl7E9UgsxbF3Rb4zrQpdKI
         ugqC/RXzxD1REr/Ul2d6x8ARlxHQr9PXo1cbc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Qd3SyHWj5wy+W8DdCFH06h9CfnAMjEf8IGmL9iqvbmI=;
        b=OX4PDyDIVVKneVL5IEK54CnKY5mLtE1m4VtH5PncCre1MqUrWzzk+6sn5VuN2huLng
         bmc7jPUTvLHLfbD9tG6q4ogX3n0k1N3Sr+NKdMQ2UrdYK6aOB0LtNdA+Z3C0TTNMmYXR
         9vxZtuqGToNpKV28TXI/npDtMtuZYgA0USyTAU1srtr86xXxFTg7wNQtblyn2n9e2Y9i
         RFLI7qVEmmzPM2BhIPvt0A9RbodgU5GxCt4N/457Nen3J8E0SxQRiSX/5TsXk1xxR5q1
         SFXVlvtuhwLyqre6edZlPDvFNIKmQHH94l2VMJ9Ug1Xa53rsjSCGqp8rtmsJF5zqDV2k
         bPPw==
X-Gm-Message-State: AOAM532iZdY9t0tjFXzTVorJR7ve7PSytEDUGl8mZJxGFOAM5eS+b85y
        IOdUMAewSamChUBnEENKbvWz5Q==
X-Google-Smtp-Source: ABdhPJyf6BDv8HyUNncV33oITZ34mKi/i8fDZdIPSKaIR+aI9rOAq3LYBrMn7SrO3dT0FGPzyiNLGg==
X-Received: by 2002:a17:90a:6e47:: with SMTP id s7mr3752498pjm.217.1595930631238;
        Tue, 28 Jul 2020 03:03:51 -0700 (PDT)
Received: from shiro.work (p532183-ipngn200506sizuokaden.shizuoka.ocn.ne.jp. [153.199.2.183])
        by smtp.googlemail.com with ESMTPSA id u66sm17779018pfb.191.2020.07.28.03.03.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 28 Jul 2020 03:03:50 -0700 (PDT)
From:   Daniel Palmer <daniel@0x0f.com>
List-Id: <soc.lore.kernel.org>
To:     soc@kernel.org
Cc:     devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, arnd@arndb.de, robh@kernel.org,
        Daniel Palmer <daniel@0x0f.com>
Subject: [PATCH v2 7/9] ARM: mstar: Add PMU
Date:   Tue, 28 Jul 2020 19:03:19 +0900
Message-Id: <20200728100321.1691745-8-daniel@0x0f.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200728100321.1691745-1-daniel@0x0f.com>
References: <20200728100321.1691745-1-daniel@0x0f.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Adds the ARM PMU to the base MStar v7 dtsi.

Signed-off-by: Daniel Palmer <daniel@0x0f.com>
---
 arch/arm/boot/dts/mstar-v7.dtsi | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/arch/arm/boot/dts/mstar-v7.dtsi b/arch/arm/boot/dts/mstar-v7.dtsi
index 1941f88a69a5..f787b8e4b67f 100644
--- a/arch/arm/boot/dts/mstar-v7.dtsi
+++ b/arch/arm/boot/dts/mstar-v7.dtsi
@@ -40,6 +40,12 @@ arch_timer {
 		clock-frequency = <6000000>;
 	};
 
+	pmu: pmu {
+		compatible = "arm,cortex-a7-pmu";
+		interrupts = <GIC_SPI 10 IRQ_TYPE_LEVEL_HIGH>;
+		interrupt-affinity = <&cpu0>;
+	};
+
 	soc: soc {
 		compatible = "simple-bus";
 		#address-cells = <1>;
-- 
2.27.0

