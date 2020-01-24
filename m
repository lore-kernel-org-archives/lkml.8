Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BE0BC32771
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:37:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 579AA2071A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:37:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579876661;
	bh=DQJTMTJ1h1GWsR0/XHAdmkje0pVuVeFEUGMSPLzpH3k=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=V4DKrdHQFB+7hsk9F/4Z6NafkHMvdjN/s4ZFYzneDeDZhzgl9mysaX7x41WqYYuA1
	 ZetLC4mHIpeZkIRoTwIsdepIolvfSg/N1yR9tZmMC9e3Qk5rbU4rv81ABsT8J05rK4
	 MGT/mZfSdCHO7Z8oT0Do9puT+zvfrSW5hAtLrD2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2403851AbgAXOTB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:19:01 -0500
Received: from mail.kernel.org ([198.145.29.99]:38878 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2403796AbgAXOSy (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:18:54 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 52F702467F;
        Fri, 24 Jan 2020 14:18:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875534;
        bh=DQJTMTJ1h1GWsR0/XHAdmkje0pVuVeFEUGMSPLzpH3k=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vfNjrm44AgHK1KpHY2ZIn6twjeT8/SUp2T1JFXIWfr9oRwXIyFbHqgvmmvA0JxJE4
         aj0AqwewlUfVupa3UJXxFEI/ol3kQ9MBKVxsSKZBvqyjs9ZmySFU0bwsIE6Q8AxGZD
         tNILNTD0cN3rjjkzct0EfeqJfzJgWIKZFXwfIYfc=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anson Huang <Anson.Huang@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 031/107] ARM: dts: imx6qdl-sabresd: Remove incorrect power supply assignment
Date:   Fri, 24 Jan 2020 09:17:01 -0500
Message-Id: <20200124141817.28793-31-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200124141817.28793-1-sashal@kernel.org>
References: <20200124141817.28793-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Anson Huang <Anson.Huang@nxp.com>

[ Upstream commit 4521de30fbb3f5be0db58de93582ebce72c9d44f ]

The vdd3p0 LDO's input should be from external USB VBUS directly, NOT
PMIC's power supply, the vdd3p0 LDO's target output voltage can be
controlled by SW, and it requires input voltage to be high enough, with
incorrect power supply assigned, if the power supply's voltage is lower
than the LDO target output voltage, it will return fail and skip the LDO
voltage adjustment, so remove the power supply assignment for vdd3p0 to
avoid such scenario.

Fixes: 93385546ba36 ("ARM: dts: imx6qdl-sabresd: Assign corresponding power supply for LDOs")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6qdl-sabresd.dtsi | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
index 71ca76a5e4a51..fe59dde41b649 100644
--- a/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
+++ b/arch/arm/boot/dts/imx6qdl-sabresd.dtsi
@@ -749,10 +749,6 @@
 	vin-supply = <&vgen5_reg>;
 };
 
-&reg_vdd3p0 {
-	vin-supply = <&sw2_reg>;
-};
-
 &reg_vdd2p5 {
 	vin-supply = <&vgen5_reg>;
 };
-- 
2.20.1

