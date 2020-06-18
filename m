Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1CD36C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:20:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE9D721974
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 01:20:46 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592443247;
	bh=f+TFBHjvg1aZ9AskKDipNue4l9sLDewX4dGhaH9jGPo=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=dcXZY1X8FOTrc11KUdcJ8JfY6WnxMzwQaiyx7MC3TZoe8dDoFsvi/y2YuWl2sg1wW
	 ZDHgSu6d6IBwd53n7heGebI3+zznkJDuOI16UwFbO9x4MxXrl9HdaqUuAqBSV7ZuL1
	 d+ZwiolzJfTZ+7PC8enitqPnWa7YuSCPD8RuIKh0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730349AbgFRBUo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 21:20:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:48502 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729782AbgFRBRV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 21:17:21 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 8EE9721D7E;
        Thu, 18 Jun 2020 01:17:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592443040;
        bh=f+TFBHjvg1aZ9AskKDipNue4l9sLDewX4dGhaH9jGPo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=gAmS7WcNueaAWUxEeCEEQuLOx1iDVqai7VQeLzaDWN+v/OS9ZAI23GI09T1nEZ51F
         YJCfPDeCdnI+RDqvjuSkMjR1gHXEF/RR+sVW+DLWUmeasdVXcTpBHoHvGdRrGQVuIT
         HDrg0QWPzcVQwSsfqvnD22ALluzn+Kwe3RQlTd+E=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 036/266] arm64: dts: armada-3720-turris-mox: forbid SDR104 on SDIO for FCC purposes
Date:   Wed, 17 Jun 2020 21:12:41 -0400
Message-Id: <20200618011631.604574-36-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200618011631.604574-1-sashal@kernel.org>
References: <20200618011631.604574-1-sashal@kernel.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Marek Behún <marek.behun@nic.cz>

[ Upstream commit 7a2c36b039d2343cc29fec6102da839477b8dc60 ]

Use sdhci-caps-mask to forbid SDR104 mode on the SDIO capable SDHCI
controller. Without this the device cannot pass electromagnetic
interference certifications.

Fixes: 7109d817db2e ("arm64: dts: marvell: add DTS for Turris Mox")
Signed-off-by: Marek Behún <marek.behun@nic.cz>
Cc: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
index 5f350cc71a2f..01f66056d7d5 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -171,6 +171,8 @@ &sdhci1 {
 	marvell,pad-type = "sd";
 	vqmmc-supply = <&vsdio_reg>;
 	mmc-pwrseq = <&sdhci1_pwrseq>;
+	/* forbid SDR104 for FCC purposes */
+	sdhci-caps-mask = <0x2 0x0>;
 	status = "okay";
 };
 
-- 
2.25.1

