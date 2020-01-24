Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,TVD_SUBJ_WIPE_DEBT,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8F5DCC2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:19:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56AF2214AF
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 14:19:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579875545;
	bh=6Epxpc7tl8HXEJ7/ssKcZMb59aAWu7qJwPZuYnk8YMI=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=EeDlNSsPob67QW+nRJ817AAq2d9Se7O2jXfWV1Cne7lTvntK2K1ScrT0RbLey+gZl
	 87YwQFckZT/wSZ59yCzDshWixZrf+HPghPvWTfCO+RWjJhswLvPvzfeO3eV5eSwLZs
	 V3RTbt37jxXA7G4Pm7HOSK6+MdzJSqPqpcsOwnpE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2391286AbgAXOTE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 09:19:04 -0500
Received: from mail.kernel.org ([198.145.29.99]:38974 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2391184AbgAXOS6 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 09:18:58 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B61922077C;
        Fri, 24 Jan 2020 14:18:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579875537;
        bh=6Epxpc7tl8HXEJ7/ssKcZMb59aAWu7qJwPZuYnk8YMI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=FKepulQ4B95LRtUJdmcu4vr54pPTHvWkjvaVIidoG5GKAuQl8ELNUAdU38FahU9e4
         fcqVvrdOI7b5MyMkZlcifhabEGQ2SpS406rlnXjTiPnBIxedtfRJuaa6lvaZ4mN74S
         UNbXg7gY+WKx3nPFRYQWqnYix407T5HQqcjaSwwQ=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Anson Huang <Anson.Huang@nxp.com>, Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 034/107] ARM: dts: imx6sll-evk: Remove incorrect power supply assignment
Date:   Fri, 24 Jan 2020 09:17:04 -0500
Message-Id: <20200124141817.28793-34-sashal@kernel.org>
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

[ Upstream commit 3479b2843c78ffb60247f522226ba68f93aee355 ]

The vdd3p0 LDO's input should be from external USB VBUS directly, NOT
PMIC's power supply, the vdd3p0 LDO's target output voltage can be
controlled by SW, and it requires input voltage to be high enough, with
incorrect power supply assigned, if the power supply's voltage is lower
than the LDO target output voltage, it will return fail and skip the LDO
voltage adjustment, so remove the power supply assignment for vdd3p0 to
avoid such scenario.

Fixes: 96a9169cf621 ("ARM: dts: imx6sll-evk: Assign corresponding power supply for vdd3p0")
Signed-off-by: Anson Huang <Anson.Huang@nxp.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6sll-evk.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6sll-evk.dts b/arch/arm/boot/dts/imx6sll-evk.dts
index 3e1d32fdf4b85..5ace9e6acf85c 100644
--- a/arch/arm/boot/dts/imx6sll-evk.dts
+++ b/arch/arm/boot/dts/imx6sll-evk.dts
@@ -265,10 +265,6 @@
 	status = "okay";
 };
 
-&reg_3p0 {
-	vin-supply = <&sw2_reg>;
-};
-
 &snvs_poweroff {
 	status = "okay";
 };
-- 
2.20.1

