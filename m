Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CB48C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:50:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 528772053B
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 14:50:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590159006;
	bh=GAE2D+tNYqHpOGEnIoN5nD5WiR4WK1GbglOK11YPR98=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=xxfS3Wn5aRtegK08TP1HaPyzOqpcPBrsxsIBrm4JbKApMrv8wB0Hri1+UT2xlSb8I
	 wryGPZUM/MPoW3v2Ak1nk3WYTUtyvZz2hi5K84oZgjOB54SvKRBtfwltlgkr3EOdtv
	 XlPQEO8WIg1vJrKMqzeE7s1TgYgzQvD5OhrpNri4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730345AbgEVOuF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 10:50:05 -0400
Received: from mail.kernel.org ([198.145.29.99]:50946 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730247AbgEVOuE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 10:50:04 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id A70AD223E0;
        Fri, 22 May 2020 14:50:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1590159003;
        bh=GAE2D+tNYqHpOGEnIoN5nD5WiR4WK1GbglOK11YPR98=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=kg2p2QpnhlPTeuLTDAkOaMc6jPqnQq/p3GxCQBPgsBWPrqzw73FVK2teOx7HLqXsD
         awdRcyCY1plXKp7ovxXFLtdtGZ1VXqJoSMXcAFe/2+qJj77fmuNL+tka8VXuFTB88R
         gOxcu6LdNjrRpsEUKITCsa6z2U2tkjBLjfOAYOao=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johan Jonker <jbx6244@gmail.com>, Heiko Stuebner <heiko@sntech.de>,
        Sasha Levin <sashal@kernel.org>,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org
Subject: [PATCH AUTOSEL 5.6 03/41] ARM: dts: rockchip: fix phy nodename for rk3229-xms6
Date:   Fri, 22 May 2020 10:49:20 -0400
Message-Id: <20200522144959.434379-3-sashal@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200522144959.434379-1-sashal@kernel.org>
References: <20200522144959.434379-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Jonker <jbx6244@gmail.com>

[ Upstream commit 621c8d0c233e260232278a4cfd3380caa3c1da29 ]

A test with the command below gives for example this error:

arch/arm/boot/dts/rk3229-xms6.dt.yaml: phy@0:
'#phy-cells' is a required property

The phy nodename is normally used by a phy-handle.
This node is however compatible with
"ethernet-phy-id1234.d400", "ethernet-phy-ieee802.3-c22"
which is just been added to 'ethernet-phy.yaml'.
So change nodename to 'ethernet-phy' for which '#phy-cells'
is not a required property

make ARCH=arm dtbs_check
DT_SCHEMA_FILES=~/.local/lib/python3.5/site-packages/dtschema/schemas/
phy/phy-provider.yaml

Signed-off-by: Johan Jonker <jbx6244@gmail.com>
Signed-off-by: Heiko Stuebner <heiko@sntech.de>
Link: https://lore.kernel.org/r/20200416170321.4216-2-jbx6244@gmail.com
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/rk3229-xms6.dts | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm/boot/dts/rk3229-xms6.dts b/arch/arm/boot/dts/rk3229-xms6.dts
index 679fc2b00e5a..933ef69da32a 100644
--- a/arch/arm/boot/dts/rk3229-xms6.dts
+++ b/arch/arm/boot/dts/rk3229-xms6.dts
@@ -150,7 +150,7 @@
 		#address-cells = <1>;
 		#size-cells = <0>;
 
-		phy: phy@0 {
+		phy: ethernet-phy@0 {
 			compatible = "ethernet-phy-id1234.d400",
 			             "ethernet-phy-ieee802.3-c22";
 			reg = <0>;
-- 
2.25.1

