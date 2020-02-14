Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE1E4C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:05:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B892D2067D
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 16:05:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581696352;
	bh=P6ka74hq+S9cWlwpKuE4fkuQlUl5IcnNTOP1eCnSy9s=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=0c4vIw7x8tGsCI3dP+Tv3yySfCW19SvRzuMsvVoYcb5rp4Ta+PXOHgnKzoIi1KkjE
	 FC9nC07jRU8L7hE30UIgzW7Pf9it0mmivPVD3lAMF/rdFYMOUTu33VXVndTVYhNSV5
	 2TOBs79O6qqcrlcolyFhCOOWMiguhroXEGRNgFvI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389690AbgBNQFv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 11:05:51 -0500
Received: from mail.kernel.org ([198.145.29.99]:54322 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2389171AbgBNQFH (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 11:05:07 -0500
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6BA224676;
        Fri, 14 Feb 2020 16:05:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1581696306;
        bh=P6ka74hq+S9cWlwpKuE4fkuQlUl5IcnNTOP1eCnSy9s=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Eb+Ff3wQgUGP5N42xGIwwpD0vUqzOJGilk1xMCHIEzhR9lW9TjUX7BTV+iUNkBYvE
         ShE9q5WZ5ylKj/UWMU/ZS45KzgebjzibH2JcDjTAUKmTQG5Bz6TGAadkD6gAVe7lgj
         hOutLUc8FUQTkv4F5j/wpJthnkItInhj73UY8Md4=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Russell King <rmk+kernel@armlinux.org.uk>,
        Gregory CLEMENT <gregory.clement@bootlin.com>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.4 150/459] arm64: dts: uDPU: fix broken ethernet
Date:   Fri, 14 Feb 2020 10:56:40 -0500
Message-Id: <20200214160149.11681-150-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200214160149.11681-1-sashal@kernel.org>
References: <20200214160149.11681-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Russell King <rmk+kernel@armlinux.org.uk>

[ Upstream commit 1eebac0240580b531954b02c05068051df41142a ]

The uDPU uses both ethernet controllers, which ties up COMPHY 0 for
eth1 and COMPHY 1 for eth0, with no USB3 comphy.  The addition of
COMPHY support made the kernel override the setup by the boot loader
breaking this platform by assuming that COMPHY 0 was always used for
USB3.  Delete the USB3 COMPHY definition at platform level, and add
phy specifications for the ethernet channels.

Fixes: bd3d25b07342 ("arm64: dts: marvell: armada-37xx: link USB hosts with their PHYs")
Signed-off-by: Russell King <rmk+kernel@armlinux.org.uk>
Signed-off-by: Gregory CLEMENT <gregory.clement@bootlin.com>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
index bd4aab6092e0f..e31813a4f9722 100644
--- a/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
+++ b/arch/arm64/boot/dts/marvell/armada-3720-uDPU.dts
@@ -143,6 +143,7 @@
 	phy-mode = "sgmii";
 	status = "okay";
 	managed = "in-band-status";
+	phys = <&comphy1 0>;
 	sfp = <&sfp_eth0>;
 };
 
@@ -150,11 +151,14 @@
 	phy-mode = "sgmii";
 	status = "okay";
 	managed = "in-band-status";
+	phys = <&comphy0 1>;
 	sfp = <&sfp_eth1>;
 };
 
 &usb3 {
 	status = "okay";
+	phys = <&usb2_utmi_otg_phy>;
+	phy-names = "usb2-utmi-otg-phy";
 };
 
 &uart0 {
-- 
2.20.1

