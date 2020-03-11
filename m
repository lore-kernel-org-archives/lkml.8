Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CCEEC2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:54:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2EDE72074E
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 22:54:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731539AbgCKWys (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 18:54:48 -0400
Received: from inva020.nxp.com ([92.121.34.13]:37714 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731390AbgCKWyK (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 18:54:10 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id BA8821A0CB1;
        Wed, 11 Mar 2020 23:54:08 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id 8037D1A0CAE;
        Wed, 11 Mar 2020 23:54:08 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id BF3BF40A63;
        Wed, 11 Mar 2020 15:54:07 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     shawnguo@kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     linux-kernel@vger.kernel.org, Li Yang <leoyang.li@nxp.com>
Subject: [PATCH v2 05/15] arm64: defconfig: Enable ENETC Ethernet controller and FELIX switch
Date:   Wed, 11 Mar 2020 17:53:07 -0500
Message-Id: <20200311225317.11198-6-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20200311225317.11198-1-leoyang.li@nxp.com>
References: <20200311225317.11198-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Enables drivers for NXP ENETC Ethernet controller and FELIX Ethernet
switch used on QorIQ LS1028a SoC.

The ENETC ethernet drivers are enabled as built-in to boot from network
without an initramfs.

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 arch/arm64/configs/defconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/arch/arm64/configs/defconfig b/arch/arm64/configs/defconfig
index 9eaf0993cca5..7390c8f3838d 100644
--- a/arch/arm64/configs/defconfig
+++ b/arch/arm64/configs/defconfig
@@ -154,6 +154,7 @@ CONFIG_IP6_NF_NAT=m
 CONFIG_IP6_NF_TARGET_MASQUERADE=m
 CONFIG_BRIDGE=m
 CONFIG_BRIDGE_VLAN_FILTERING=y
+CONFIG_NET_DSA=m
 CONFIG_VLAN_8021Q=m
 CONFIG_VLAN_8021Q_GVRP=y
 CONFIG_VLAN_8021Q_MVRP=y
@@ -256,6 +257,7 @@ CONFIG_MACVTAP=m
 CONFIG_TUN=y
 CONFIG_VETH=m
 CONFIG_VIRTIO_NET=y
+CONFIG_NET_DSA_MSCC_FELIX=m
 CONFIG_AMD_XGBE=y
 CONFIG_NET_XGENE=y
 CONFIG_ATL1C=m
@@ -267,6 +269,8 @@ CONFIG_FEC=y
 CONFIG_FSL_FMAN=y
 CONFIG_FSL_DPAA_ETH=y
 CONFIG_FSL_DPAA2_ETH=y
+CONFIG_FSL_ENETC=y
+CONFIG_FSL_ENETC_VF=y
 CONFIG_HIX5HD2_GMAC=y
 CONFIG_HNS_DSAF=y
 CONFIG_HNS_ENET=y
-- 
2.17.1

