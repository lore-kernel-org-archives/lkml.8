Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 877D7C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:01:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4CECE20842
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 00:01:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586217717;
	bh=5tu6jgjQORBsXTyfqgjJ3eMKXV2UrGsH132oHEvwEcc=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=ssp4UnybrelplSC01iRNKXHTsknfcaoB0BaV7QHEPU1UQemVfFXnhSqnAsV47FTlB
	 e7j2C075fxCyleg4/ed5VAU3Tn0RxgfsHke2Pef3pSZmAPCZqDhDtEEY8xmqTaKWW+
	 V+zwfwbxoFO+9/aVwgdX3CzAQAD1Cn/BFEY0ck50=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727648AbgDGAB4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 20:01:56 -0400
Received: from mail.kernel.org ([198.145.29.99]:35562 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727421AbgDGABx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 20:01:53 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 49AE02083E;
        Tue,  7 Apr 2020 00:01:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586217713;
        bh=5tu6jgjQORBsXTyfqgjJ3eMKXV2UrGsH132oHEvwEcc=;
        h=From:To:Cc:Subject:Date:From;
        b=ilHvrIVeY8be5f6Uq2Tmel5tAM7qebUNj1c2VyO5V3/KUvOblJ0+F8yDsB/Dv5D5p
         MAhRLwPhPKM3VEn4nxjQfbtkJ8Fhr2p9egPi9P3Lh9MgAtVLiSSb4pyxuvLjY0BkfQ
         PFkojcywn/CYKFa+RZ1E9OLEr1e8dDzJvh6QyQIU=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Ondrej Jirman <megous@megous.com>,
        Maxime Ripard <maxime@cerno.tech>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 01/32] ARM: dts: sun8i-a83t-tbs-a711: HM5065 doesn't like such a high voltage
Date:   Mon,  6 Apr 2020 20:01:19 -0400
Message-Id: <20200407000151.16768-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Ondrej Jirman <megous@megous.com>

[ Upstream commit a40550952c000667b20082d58077bc647da6c890 ]

Lowering the voltage solves the quick image degradation over time
(minutes), that was probably caused by overheating.

Signed-off-by: Ondrej Jirman <megous@megous.com>
Signed-off-by: Maxime Ripard <maxime@cerno.tech>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
index 397140454132f..6bf93e5ed6817 100644
--- a/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
+++ b/arch/arm/boot/dts/sun8i-a83t-tbs-a711.dts
@@ -358,8 +358,8 @@
 };
 
 &reg_dldo3 {
-	regulator-min-microvolt = <2800000>;
-	regulator-max-microvolt = <2800000>;
+	regulator-min-microvolt = <1800000>;
+	regulator-max-microvolt = <1800000>;
 	regulator-name = "vdd-csi";
 };
 
-- 
2.20.1

