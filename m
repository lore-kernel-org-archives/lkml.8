Return-Path: <SRS0=BMk7=4P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8A46CC34022
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:55:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BF1224650
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Feb 2020 14:55:59 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732776AbgB0Oz5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Feb 2020 09:55:57 -0500
Received: from bhuna.collabora.co.uk ([46.235.227.227]:38204 "EHLO
        bhuna.collabora.co.uk" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729930AbgB0Ozw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Feb 2020 09:55:52 -0500
Received: from localhost.localdomain (p200300CB87166A00F93543D7CC014A8D.dip0.t-ipconnect.de [IPv6:2003:cb:8716:6a00:f935:43d7:cc01:4a8d])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: dafna)
        by bhuna.collabora.co.uk (Postfix) with ESMTPSA id 5A9772787E1;
        Thu, 27 Feb 2020 14:55:50 +0000 (GMT)
From:   Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
To:     devicetree@vger.kernel.org
Cc:     robh+dt@kernel.org, mark.rutland@arm.com, bleung@chromium.org,
        enric.balletbo@collabora.com, groeck@chromium.org,
        dafna.hirschfeld@collabora.com, linux-kernel@vger.kernel.org,
        helen.koike@collabora.com, ezequiel@collabora.com,
        kernel@collabora.com, dafna3@gmail.com,
        sebastian.reichel@collabora.com
Subject: [PATCH v5 2/2] arm64: tegra: fix nodes names under i2c-tunnel
Date:   Thu, 27 Feb 2020 15:55:28 +0100
Message-Id: <20200227145528.8940-2-dafna.hirschfeld@collabora.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200227145528.8940-1-dafna.hirschfeld@collabora.com>
References: <20200227145528.8940-1-dafna.hirschfeld@collabora.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Change the node names so that they match the class
of the device and have a unit address.
The changes are:
bq24735 -> charger@9
smart-battery -> battery@b

This also fixes the warning:
'bq24735', 'smart-battery' do not match any of the
regexes: '^.*@[0-9a-f]+$', 'pinctrl-[0-9]+'

Signed-off-by: Dafna Hirschfeld <dafna.hirschfeld@collabora.com>
---
 arch/arm64/boot/dts/nvidia/tegra132-norrin.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
index a0385a386a3f..4cd99dac541b 100644
--- a/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
+++ b/arch/arm64/boot/dts/nvidia/tegra132-norrin.dts
@@ -767,7 +767,7 @@
 
 				google,remote-bus = <0>;
 
-				charger: bq24735 {
+				charger: charger@9 {
 					compatible = "ti,bq24735";
 					reg = <0x9>;
 					interrupt-parent = <&gpio>;
@@ -778,7 +778,7 @@
 							GPIO_ACTIVE_HIGH>;
 				};
 
-				battery: smart-battery {
+				battery: battery@b {
 					compatible = "sbs,sbs-battery";
 					reg = <0xb>;
 					battery-name = "battery";
-- 
2.17.1

