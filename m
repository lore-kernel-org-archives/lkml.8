Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A860CC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:03:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 83A3720728
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 21:03:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388455AbgAPVC6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 16:02:58 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:53384 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388271AbgAPVCn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 16:02:43 -0500
Received: from [5.158.153.53] (helo=tip-bot2.lab.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tip-bot2@linutronix.de>)
        id 1isCHj-00013M-W1; Thu, 16 Jan 2020 22:02:36 +0100
Received: from [127.0.1.1] (localhost [IPv6:::1])
        by tip-bot2.lab.linutronix.de (Postfix) with ESMTP id 849ED1C0EA3;
        Thu, 16 Jan 2020 22:02:35 +0100 (CET)
Date:   Thu, 16 Jan 2020 21:02:35 -0000
From:   "tip-bot2 for Yazen Ghannam" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: ras/core] EDAC/amd64: Drop some family checks for newer systems
Cc:     Yazen Ghannam <yazen.ghannam@amd.com>,
        Borislav Petkov <bp@suse.de>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200110015651.14887-6-Yazen.Ghannam@amd.com>
References: <20200110015651.14887-6-Yazen.Ghannam@amd.com>
MIME-Version: 1.0
Message-ID: <157920855537.396.336310673693730601.tip-bot2@tip-bot2>
X-Mailer: tip-git-log-daemon
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the ras/core branch of tip:

Commit-ID:     dcd01394ce7cd7d25bb15c81ad2e804d8090611f
Gitweb:        https://git.kernel.org/tip/dcd01394ce7cd7d25bb15c81ad2e804d8090611f
Author:        Yazen Ghannam <yazen.ghannam@amd.com>
AuthorDate:    Fri, 10 Jan 2020 01:56:51 
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Thu, 16 Jan 2020 17:09:29 +01:00

EDAC/amd64: Drop some family checks for newer systems

In general, "pvt->umc != NULL" is used to check if the system is Family
17h+. However, there are a few places that are using direct family
checks.

Replace the remaining family checks with a check for "pvt->umc != NULL".

Signed-off-by: Yazen Ghannam <yazen.ghannam@amd.com>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200110015651.14887-6-Yazen.Ghannam@amd.com
---
 drivers/edac/amd64_edac.c | 45 ++++++++++++++++----------------------
 1 file changed, 19 insertions(+), 26 deletions(-)

diff --git a/drivers/edac/amd64_edac.c b/drivers/edac/amd64_edac.c
index 2488cbf..4fc9f0b 100644
--- a/drivers/edac/amd64_edac.c
+++ b/drivers/edac/amd64_edac.c
@@ -214,7 +214,7 @@ static int __set_scrub_rate(struct amd64_pvt *pvt, u32 new_bw, u32 min_rate)
 
 	scrubval = scrubrates[i].scrubval;
 
-	if (pvt->fam == 0x17 || pvt->fam == 0x18) {
+	if (pvt->umc) {
 		__f17h_set_scrubval(pvt, scrubval);
 	} else if (pvt->fam == 0x15 && pvt->model == 0x60) {
 		f15h_select_dct(pvt, 0);
@@ -256,18 +256,7 @@ static int get_scrub_rate(struct mem_ctl_info *mci)
 	int i, retval = -EINVAL;
 	u32 scrubval = 0;
 
-	switch (pvt->fam) {
-	case 0x15:
-		/* Erratum #505 */
-		if (pvt->model < 0x10)
-			f15h_select_dct(pvt, 0);
-
-		if (pvt->model == 0x60)
-			amd64_read_pci_cfg(pvt->F2, F15H_M60H_SCRCTRL, &scrubval);
-		break;
-
-	case 0x17:
-	case 0x18:
+	if (pvt->umc) {
 		amd64_read_pci_cfg(pvt->F6, F17H_SCR_BASE_ADDR, &scrubval);
 		if (scrubval & BIT(0)) {
 			amd64_read_pci_cfg(pvt->F6, F17H_SCR_LIMIT_ADDR, &scrubval);
@@ -276,11 +265,15 @@ static int get_scrub_rate(struct mem_ctl_info *mci)
 		} else {
 			scrubval = 0;
 		}
-		break;
+	} else if (pvt->fam == 0x15) {
+		/* Erratum #505 */
+		if (pvt->model < 0x10)
+			f15h_select_dct(pvt, 0);
 
-	default:
+		if (pvt->model == 0x60)
+			amd64_read_pci_cfg(pvt->F2, F15H_M60H_SCRCTRL, &scrubval);
+	} else {
 		amd64_read_pci_cfg(pvt->F3, SCRCTRL, &scrubval);
-		break;
 	}
 
 	scrubval = scrubval & 0x001F;
@@ -1055,6 +1048,16 @@ static void determine_memory_type(struct amd64_pvt *pvt)
 {
 	u32 dram_ctrl, dcsm;
 
+	if (pvt->umc) {
+		if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
+			pvt->dram_type = MEM_LRDDR4;
+		else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
+			pvt->dram_type = MEM_RDDR4;
+		else
+			pvt->dram_type = MEM_DDR4;
+		return;
+	}
+
 	switch (pvt->fam) {
 	case 0xf:
 		if (pvt->ext_model >= K8_REV_F)
@@ -1100,16 +1103,6 @@ static void determine_memory_type(struct amd64_pvt *pvt)
 	case 0x16:
 		goto ddr3;
 
-	case 0x17:
-	case 0x18:
-		if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(5))
-			pvt->dram_type = MEM_LRDDR4;
-		else if ((pvt->umc[0].dimm_cfg | pvt->umc[1].dimm_cfg) & BIT(4))
-			pvt->dram_type = MEM_RDDR4;
-		else
-			pvt->dram_type = MEM_DDR4;
-		return;
-
 	default:
 		WARN(1, KERN_ERR "%s: Family??? 0x%x\n", __func__, pvt->fam);
 		pvt->dram_type = MEM_EMPTY;
