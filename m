Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88827C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:20:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6354C20720
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:20:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592947212;
	bh=TtD3ILuGuKCGxDNy2HlXXJ0aABPdLJ+td5SzO4EVlvA=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=uzyY3af9NqVOYhCy3DDqCKbFNkPtwUXs3ZZfiIGCYqjlhQIdHokbN2u/lvGhThOgB
	 zsRI3atUOeuZtjBvQYfyRPaK3XFFDuGa/w52Aw/D3t1w5/LMk1iBSuSWMTiXS/yBXc
	 nRYFx+mEOHd54RdvXW+fq6SXeR2nTnVo5SsHPtas=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390933AbgFWVUL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 17:20:11 -0400
Received: from mail.kernel.org ([198.145.29.99]:42004 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2390338AbgFWUXo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:23:44 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 0FEF52070E;
        Tue, 23 Jun 2020 20:23:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592943824;
        bh=TtD3ILuGuKCGxDNy2HlXXJ0aABPdLJ+td5SzO4EVlvA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=15WJ30WxCDYyxGbA54wu71k9l+KR5GUQKIIIL4QhwOFXnazAFcCDaNPDVSXB5tUQi
         y2u+Cd5tcMzqzn+UFY/yknjKFyfugqhF4kWC1jl5GXAiEmbKNvTP7wCGAh4s14oS0i
         1y02AsJM0SShfvA4JjYrmMnctHUknr1uXoeKZWLk=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.4 035/314] arm64: dts: armada-3720-turris-mox: forbid SDR104 on SDIO for FCC purposes
Date:   Tue, 23 Jun 2020 21:53:50 +0200
Message-Id: <20200623195340.483662169@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195338.770401005@linuxfoundation.org>
References: <20200623195338.770401005@linuxfoundation.org>
User-Agent: quilt/0.66
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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
index 5f350cc71a2fd..01f66056d7d51 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -171,6 +171,8 @@
 	marvell,pad-type = "sd";
 	vqmmc-supply = <&vsdio_reg>;
 	mmc-pwrseq = <&sdhci1_pwrseq>;
+	/* forbid SDR104 for FCC purposes */
+	sdhci-caps-mask = <0x2 0x0>;
 	status = "okay";
 };
 
-- 
2.25.1



