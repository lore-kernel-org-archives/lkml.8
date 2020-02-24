Return-Path: <SRS0=7TUr=4M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE8D6C11D2A
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0EC2187F
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Feb 2020 09:49:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727319AbgBXJtV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Feb 2020 04:49:21 -0500
Received: from inva021.nxp.com ([92.121.34.21]:52776 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726628AbgBXJtV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Feb 2020 04:49:21 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id ED8F320DC1A;
        Mon, 24 Feb 2020 10:49:18 +0100 (CET)
Received: from invc005.ap-rdc01.nxp.com (invc005.ap-rdc01.nxp.com [165.114.16.14])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 3335B20DC2E;
        Mon, 24 Feb 2020 10:49:13 +0100 (CET)
Received: from localhost.localdomain (shlinux2.ap.freescale.net [10.192.224.44])
        by invc005.ap-rdc01.nxp.com (Postfix) with ESMTP id 4BAF2402CA;
        Mon, 24 Feb 2020 17:49:06 +0800 (SGT)
From:   Sherry Sun <sherry.sun@nxp.com>
To:     bp@alien8.de, mchehab@kernel.org, tony.luck@intel.com,
        james.morse@arm.com, rrichter@marvell.com, michal.simek@xilinx.com
Cc:     linux-edac@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-imx@nxp.com, frank.li@nxp.com
Subject: [PATCH 1/3] EDAC: synopsys: Remove pinf->col parameter for ZynqMP and i.MX8MP
Date:   Mon, 24 Feb 2020 17:42:35 +0800
Message-Id: <1582537357-10339-2-git-send-email-sherry.sun@nxp.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1582537357-10339-1-git-send-email-sherry.sun@nxp.com>
References: <1582537357-10339-1-git-send-email-sherry.sun@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since ZynqMP and i.MX8MP platform both call zynqmp_get_error_info()
function to get ce/ue information. In this function, pinf->col parameter
is not used, this parameter is only used by Zynq platforme. So here
pinf->col should not be called and printed for ZynqMP and i.MX8MP.

Signed-off-by: Sherry Sun <sherry.sun@nxp.com>
---
 drivers/edac/synopsys_edac.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/edac/synopsys_edac.c b/drivers/edac/synopsys_edac.c
index 66c801502212..7046b8929522 100644
--- a/drivers/edac/synopsys_edac.c
+++ b/drivers/edac/synopsys_edac.c
@@ -492,8 +492,8 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 				 pinf->bitpos, pinf->data);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type:%s Row %d Bank %d Col %d ",
-				  "CE", pinf->row, pinf->bank, pinf->col);
+				 "DDR ECC error type:%s Row %d Bank %d ",
+				  "CE", pinf->row, pinf->bank);
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
 				 "BankGroup Number %d Block Number %d ",
 				 pinf->bankgrpnr, pinf->blknr);
@@ -515,8 +515,8 @@ static void handle_error(struct mem_ctl_info *mci, struct synps_ecc_status *p)
 				"UE", pinf->row, pinf->bank, pinf->col);
 		} else {
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
-				 "DDR ECC error type :%s Row %d Bank %d Col %d ",
-				 "UE", pinf->row, pinf->bank, pinf->col);
+				 "DDR ECC error type :%s Row %d Bank %d ",
+				 "UE", pinf->row, pinf->bank);
 			snprintf(priv->message, SYNPS_EDAC_MSG_SIZE,
 				 "BankGroup Number %d Block Number %d",
 				 pinf->bankgrpnr, pinf->blknr);
-- 
2.17.1

