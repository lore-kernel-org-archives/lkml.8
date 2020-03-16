Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5038EC10F29
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:35:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2470A2072A
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:35:01 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584326101;
	bh=hjYzrSAG1T8NzDLvFDVc+oisTswRnN3vFWY0chwC3UY=;
	h=From:To:Cc:Subject:Date:In-Reply-To:References:List-ID:From;
	b=itjS9aVCIn/jIfCQ1on4ZPrKlm7PgtzTRtX2LBHTnXH+wYG2Ho4Frh6eramIN6ltg
	 xzKRQCKLmPrmkd6U04zstUW9yqGsNWtRkxtIRBv1Gl/sYRaPAIO27dCux3UWbxechw
	 SU9S8T0TVTf+kTXbYaX9kXvNXBCFuH1O5hW+n5XA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729557AbgCPCe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:34:59 -0400
Received: from mail.kernel.org ([198.145.29.99]:38888 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730024AbgCPCe5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:34:57 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 03E9F20736;
        Mon, 16 Mar 2020 02:34:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584326097;
        bh=hjYzrSAG1T8NzDLvFDVc+oisTswRnN3vFWY0chwC3UY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CabYTB5dPl6cBt5l0Slr0iuvv5wqz5PryqOLsy2/PXWEw1sQ/MrCg9o4qqTk8tUIJ
         M+vcPJxNw1BrEfQERq9x1+pIgmtcUeREi6ON8bFPXtZLqARnJM/Pa+2n5UNUk+9mh9
         iOQ2gRR+bYpie54bWVsTvjhueCdJ442xNXhnjjM0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.19 02/20] ARM: dts: imx6dl-colibri-eval-v3: fix sram compatible properties
Date:   Sun, 15 Mar 2020 22:34:35 -0400
Message-Id: <20200316023453.1800-2-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
In-Reply-To: <20200316023453.1800-1-sashal@kernel.org>
References: <20200316023453.1800-1-sashal@kernel.org>
MIME-Version: 1.0
X-stable: review
X-Patchwork-Hint: Ignore
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Johan Hovold <johan@kernel.org>

[ Upstream commit bcbf53a0dab50980867476994f6079c1ec5bb3a3 ]

The sram-node compatible properties have mistakingly combined the
model-specific string with the generic "mtd-ram" string.

Note that neither "cy7c1019dv33-10zsxi, mtd-ram" or
"cy7c1019dv33-10zsxi" are used by any in-kernel driver and they are
not present in any binding.

The physmap driver will however bind to platform devices that specify
"mtd-ram".

Fixes: fc48e76489fd ("ARM: dts: imx6: Add support for Toradex Colibri iMX6 module")
Cc: Sanchayan Maity <maitysanchayan@gmail.com>
Cc: Marcel Ziswiler <marcel.ziswiler@toradex.com>
Cc: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Johan Hovold <johan@kernel.org>
Reviewed-by: Oleksandr Suvorov <oleksandr.suvorov@toradex.com>
Signed-off-by: Shawn Guo <shawnguo@kernel.org>
Signed-off-by: Sasha Levin <sashal@kernel.org>
---
 arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
index 9de45a7173561..50a7ec0875535 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
@@ -234,7 +234,7 @@
 
 	/* SRAM on Colibri nEXT_CS0 */
 	sram@0,0 {
-		compatible = "cypress,cy7c1019dv33-10zsxi, mtd-ram";
+		compatible = "cypress,cy7c1019dv33-10zsxi", "mtd-ram";
 		reg = <0 0 0x00010000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -245,7 +245,7 @@
 
 	/* SRAM on Colibri nEXT_CS1 */
 	sram@1,0 {
-		compatible = "cypress,cy7c1019dv33-10zsxi, mtd-ram";
+		compatible = "cypress,cy7c1019dv33-10zsxi", "mtd-ram";
 		reg = <1 0 0x00010000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.20.1

