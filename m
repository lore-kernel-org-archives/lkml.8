Return-Path: <SRS0=CUu6=46=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E818EC10DCE
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:12:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C99CF206EB
	for <linux-kernel@archiver.kernel.org>; Fri, 13 Mar 2020 01:12:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727428AbgCMBMB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 21:12:01 -0400
Received: from 97-93-29-23.dhcp.snlo.ca.charter.com ([97.93.29.23]:54474 "EHLO
        skomatineni-linux.nvidia.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727179AbgCMBL1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 21:11:27 -0400
X-Greylist: delayed 91210 seconds by postgrey-1.27 at vger.kernel.org; Thu, 12 Mar 2020 21:11:26 EDT
Received: by skomatineni-linux.nvidia.com (Postfix, from userid 1000)
        id 070701040081; Tue, 10 Mar 2020 21:02:53 -0700 (PDT)
From:   Sowjanya Komatineni <skomatineni@nvidia.com>
To:     skomatineni@nvidia.com, thierry.reding@gmail.com,
        jonathanh@nvidia.com, robh+dt@kernel.org, josephl@nvidia.com,
        daniel.lezcano@linaro.org, mmaddireddy@nvidia.com,
        nkristam@nvidia.com
Cc:     devicetree@vger.kernel.org, linux-tegra@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v1] arm64: tegra: Add reset-cells to mc
Date:   Tue, 10 Mar 2020 21:02:46 -0700
Message-Id: <1583899366-1588-1-git-send-email-skomatineni@nvidia.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Tegra210 device tree is missing reset-cells property for mc node.

This patch fixes it.

Signed-off-by: Sowjanya Komatineni <skomatineni@nvidia.com>
---
 arch/arm64/boot/dts/nvidia/tegra210.dtsi | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/arm64/boot/dts/nvidia/tegra210.dtsi b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
index 66dd1df..9241163 100644
--- a/arch/arm64/boot/dts/nvidia/tegra210.dtsi
+++ b/arch/arm64/boot/dts/nvidia/tegra210.dtsi
@@ -935,6 +935,7 @@
 		interrupts = <GIC_SPI 77 IRQ_TYPE_LEVEL_HIGH>;
 
 		#iommu-cells = <1>;
+		#reset-cells = <1>;
 	};
 
 	sata@70020000 {
-- 
2.7.4

