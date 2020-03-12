Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7E3DAC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:28:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5CF7820736
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 22:28:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726946AbgCLW2q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 18:28:46 -0400
Received: from inva020.nxp.com ([92.121.34.13]:38500 "EHLO inva020.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726621AbgCLW2l (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 18:28:41 -0400
Received: from inva020.nxp.com (localhost [127.0.0.1])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id EC2341A11B8;
        Thu, 12 Mar 2020 23:28:39 +0100 (CET)
Received: from smtp.na-rdc02.nxp.com (usphx01srsp001v.us-phx01.nxp.com [134.27.49.11])
        by inva020.eu-rdc02.nxp.com (Postfix) with ESMTP id AE43D1A11C9;
        Thu, 12 Mar 2020 23:28:39 +0100 (CET)
Received: from right.am.freescale.net (right.am.freescale.net [10.81.116.70])
        by usphx01srsp001v.us-phx01.nxp.com (Postfix) with ESMTP id 28EBB40AB2;
        Thu, 12 Mar 2020 15:28:39 -0700 (MST)
From:   Li Yang <leoyang.li@nxp.com>
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Timur Tabi <timur@kernel.org>, Zhao Qiang <qiang.zhao@nxp.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        linuxppc-dev@lists.ozlabs.org, linux-kernel@vger.kernel.org,
        Li Yang <leoyang.li@nxp.com>
Subject: [PATCH 1/6] soc: fsl: qe: fix sparse warnings for qe.c
Date:   Thu, 12 Mar 2020 17:28:22 -0500
Message-Id: <20200312222827.17409-2-leoyang.li@nxp.com>
X-Mailer: git-send-email 2.25.1.377.g2d2118b
In-Reply-To: <20200312222827.17409-1-leoyang.li@nxp.com>
References: <20200312222827.17409-1-leoyang.li@nxp.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Fixes the following sparse warnings:
drivers/soc/fsl/qe/qe.c:426:9: warning: cast to restricted __be32
drivers/soc/fsl/qe/qe.c:528:41: warning: incorrect type in assignment (different base types)
drivers/soc/fsl/qe/qe.c:528:41:    expected unsigned long long static [addressable] [toplevel] [usertype] extended_modes
drivers/soc/fsl/qe/qe.c:528:41:    got restricted __be64 const [usertype] extended_modes

Signed-off-by: Li Yang <leoyang.li@nxp.com>
---
 drivers/soc/fsl/qe/qe.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/drivers/soc/fsl/qe/qe.c b/drivers/soc/fsl/qe/qe.c
index 96c2057d8d8e..447146861c2c 100644
--- a/drivers/soc/fsl/qe/qe.c
+++ b/drivers/soc/fsl/qe/qe.c
@@ -423,7 +423,7 @@ static void qe_upload_microcode(const void *base,
 		qe_iowrite32be(be32_to_cpu(code[i]), &qe_immr->iram.idata);
 	
 	/* Set I-RAM Ready Register */
-	qe_iowrite32be(be32_to_cpu(QE_IRAM_READY), &qe_immr->iram.iready);
+	qe_iowrite32be(QE_IRAM_READY, &qe_immr->iram.iready);
 }
 
 /*
@@ -525,7 +525,7 @@ int qe_upload_firmware(const struct qe_firmware *firmware)
 	 */
 	memset(&qe_firmware_info, 0, sizeof(qe_firmware_info));
 	strlcpy(qe_firmware_info.id, firmware->id, sizeof(qe_firmware_info.id));
-	qe_firmware_info.extended_modes = firmware->extended_modes;
+	qe_firmware_info.extended_modes = be64_to_cpu(firmware->extended_modes);
 	memcpy(qe_firmware_info.vtraps, firmware->vtraps,
 		sizeof(firmware->vtraps));
 
-- 
2.17.1

