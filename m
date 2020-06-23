Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 000DFC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:44:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D24812078A
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 21:44:08 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1592948648;
	bh=7giNc4RL+tyolJNpeqfAlCZa1bACIvCrMJf5vTXKKPM=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=Ig3jDsn97ugPEkUDKJqPE2C9bLLRKp5TIIibCVt+lB9FeREvdK7UjJ4H9ZtFB5hpG
	 0lsULMvKxIK1yeo5LcD8uZIM5wnK3YOefi/Vm2Qr0V8LX5f/pCSpjFayuBQs5yl4xS
	 jgADfLJzwdm8e4HdBaQtg6Gb0+IiLyMqcEBYMPcA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387899AbgFWUCo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 16:02:44 -0400
Received: from mail.kernel.org ([198.145.29.99]:40072 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2387888AbgFWUCl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 16:02:41 -0400
Received: from localhost (83-86-89-107.cable.dynamic.v4.ziggo.nl [83.86.89.107])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 868C120CC7;
        Tue, 23 Jun 2020 20:02:40 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1592942561;
        bh=7giNc4RL+tyolJNpeqfAlCZa1bACIvCrMJf5vTXKKPM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=LpuS64RHKtjp/d8iAoVLbCWLZVHaE0lf0sqzGva1y0R2ZJN3OqfHGH01qvUEkrExR
         6j5dWzx1P2K/l01WhjSUspUHid/Toq2g3h5kl4GunmMTQCjax96b8tAgjGKER8weLm
         OX4c7ErJ+N9rt6yfgRA2T8+sgg4msTewRe4TV2O4=
From:   Greg Kroah-Hartman <gregkh@linuxfoundation.org>
To:     linux-kernel@vger.kernel.org
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        stable@vger.kernel.org,
        =?UTF-8?q?Marek=20Beh=C3=BAn?= <marek.behun@nic.cz>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <sashal@kernel.org>
Subject: [PATCH 5.7 047/477] arm64: dts: armada-3720-turris-mox: forbid SDR104 on SDIO for FCC purposes
Date:   Tue, 23 Jun 2020 21:50:44 +0200
Message-Id: <20200623195409.833314572@linuxfoundation.org>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20200623195407.572062007@linuxfoundation.org>
References: <20200623195407.572062007@linuxfoundation.org>
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
index bb42d1e6a4e92..47fee66c70cbc 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-turris-mox.dts
@@ -179,6 +179,8 @@
 	marvell,pad-type = "sd";
 	vqmmc-supply = <&vsdio_reg>;
 	mmc-pwrseq = <&sdhci1_pwrseq>;
+	/* forbid SDR104 for FCC purposes */
+	sdhci-caps-mask = <0x2 0x0>;
 	status = "okay";
 };
 
-- 
2.25.1



