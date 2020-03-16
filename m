Return-Path: <SRS0=ltrd=5B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C142BC10DCE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:37:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8C922206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 16 Mar 2020 02:37:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584326247;
	bh=wLKIETbo2pXOLJhya9oebISock9ggahRCIkYmPlnMOY=;
	h=From:To:Cc:Subject:Date:List-ID:From;
	b=mKd23n90mqCUDOsHFDUEW4fYSz1dtEnWywxIM5UM+dFPny5PBKOWuGS9Yr+OGdt+L
	 Ja9MTzMX5XpC4NseajU5+Dh3qE/HhhO6kJLLrPtYPjdt5P6cYm9J119wK3FWTX6t3B
	 IjXMBThl4mkq667kAE7DL6GpxApX/i7f7Yt2sCsc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730365AbgCPChZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 15 Mar 2020 22:37:25 -0400
Received: from mail.kernel.org ([198.145.29.99]:39746 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730093AbgCPCfW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 Mar 2020 22:35:22 -0400
Received: from sasha-vm.mshome.net (c-73-47-72-35.hsd1.nh.comcast.net [73.47.72.35])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 549CA206BE;
        Mon, 16 Mar 2020 02:35:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584326121;
        bh=wLKIETbo2pXOLJhya9oebISock9ggahRCIkYmPlnMOY=;
        h=From:To:Cc:Subject:Date:From;
        b=SBiqeDIOVI7cean7thLtFaPXGCLiNloOsYEMcUPKGCBXWWSa+2av+klUHRizCEBak
         rj/sZRg6jzj2I+olh4r0zLcjDAz0V5IaSLy3wo2pN5HErYILUMK6EDawW77i/8lPAe
         cBmNQizNC/6bvsRp9XStq307EtYVb/8e6yNDrGK0=
From:   Sasha Levin <sashal@kernel.org>
To:     linux-kernel@vger.kernel.org, stable@vger.kernel.org
Cc:     Johan Hovold <johan@kernel.org>,
        Sanchayan Maity <maitysanchayan@gmail.com>,
        Marcel Ziswiler <marcel.ziswiler@toradex.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Oleksandr Suvorov <oleksandr.suvorov@toradex.com>,
        Sasha Levin <sashal@kernel.org>, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org
Subject: [PATCH AUTOSEL 4.14 01/15] ARM: dts: imx6dl-colibri-eval-v3: fix sram compatible properties
Date:   Sun, 15 Mar 2020 22:35:05 -0400
Message-Id: <20200316023519.2050-1-sashal@kernel.org>
X-Mailer: git-send-email 2.20.1
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
index 26541538562c6..fd6b253a45a73 100644
--- a/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
+++ b/arch/arm/boot/dts/imx6dl-colibri-eval-v3.dts
@@ -231,7 +231,7 @@
 
 	/* SRAM on Colibri nEXT_CS0 */
 	sram@0,0 {
-		compatible = "cypress,cy7c1019dv33-10zsxi, mtd-ram";
+		compatible = "cypress,cy7c1019dv33-10zsxi", "mtd-ram";
 		reg = <0 0 0x00010000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
@@ -242,7 +242,7 @@
 
 	/* SRAM on Colibri nEXT_CS1 */
 	sram@1,0 {
-		compatible = "cypress,cy7c1019dv33-10zsxi, mtd-ram";
+		compatible = "cypress,cy7c1019dv33-10zsxi", "mtd-ram";
 		reg = <1 0 0x00010000>;
 		#address-cells = <1>;
 		#size-cells = <1>;
-- 
2.20.1

