Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 01FC2C33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:52:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0A8A214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 16:52:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579193534;
	bh=pRlV5oNVWX8GqhN93rvkBDk1mjHuyakoApPmpzrrcC4=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=yp4Uwlm7JFpU/QdQwyQrtx5RL5a5poK0FIRXfUMUSm7iNvDYbraVTMu/zFi9Nasfr
	 m2YqjdUFWR5DRq5a9s2fXbDfA8a7w3Gm1ZHkXO42gaq0J89yKpaE/UEFmhEHzJWNxA
	 DrB3NAEGqBejxD9LVKMRxg7o4zdehrKD0kZ8o5Hw=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729887AbgAPQwO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 11:52:14 -0500
Received: from mail.kernel.org ([198.145.29.99]:35126 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727030AbgAPQwL (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 11:52:11 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 87D882073A;
        Thu, 16 Jan 2020 16:52:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1579193531;
        bh=pRlV5oNVWX8GqhN93rvkBDk1mjHuyakoApPmpzrrcC4=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=StCYH1Z4CtMv3I5C7W4h6B7zQ4crXSisTOMZxHIJ8UHNynQFJfsoR2r/Mp464ILA3
         55fPe211eIINbZ6puqegbD/WqkkZgsCMABflGW+xwymXLSEYRZolztq0eDmilZXCsD
         8uP+OrYDz5ht+vwRPLOEGYuWSY/RfiDuPH0v7tcY=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Frieder Schrempf <frieder.schrempf@kontron.de>,
        Shawn Guo <shawnguo@kernel.org>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 5.4 097/205] ARM: dts: imx6ul-kontron-n6310-s: Disable the snvs-poweroff driver
Date:   Thu, 16 Jan 2020 11:41:12 -0500
Message-Id: <20200116164300.6705-97-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200116164300.6705-1-sashal@kernel.org>
References: <20200116164300.6705-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Frieder Schrempf <frieder.schrempf@kontron.de>

[ Upstream commit 0ccafdf3e81bb40fe415ea13e1f42b19c585f0a0 ]

The snvs-poweroff driver can power off the system by pulling the
PMIC_ON_REQ signal low, to let the PMIC disable the power.
The Kontron SoMs do not have this signal connected, so let's remove
the node.

This fixes a real issue when the signal is asserted at poweroff,
but not actually causing the power to turn off. It was observed,
that in this case the system would not shut down properly.

Signed-off-by: Frieder Schrempf <frieder.schrempf@kontron.de>
Fixes: 1ea4b76cdfde ("ARM: dts: imx6ul-kontron-n6310: Add Kontron i.MX6UL N6310 SoM and boards")
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts b/arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts
index 0205fd56d975..4e99e6c79a68 100644
--- a/arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts
+++ b/arch/arm/boot/dts/imx6ul-kontron-n6310-s.dts
@@ -157,10 +157,6 @@
 	status = "okay";
 };
 
-&snvs_poweroff {
-	status = "okay";
-};
-
 &uart1 {
 	pinctrl-names = "default";
 	pinctrl-0 = <&pinctrl_uart1>;
-- 
2.20.1

