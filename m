Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71352C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:12:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4C9F22075A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 09:12:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=st.com header.i=@st.com header.b="uTeUw30h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729039AbgEFJM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 05:12:28 -0400
Received: from mx07-00178001.pphosted.com ([62.209.51.94]:13728 "EHLO
        mx07-00178001.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728573AbgEFJM0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 05:12:26 -0400
Received: from pps.filterd (m0046668.ppops.net [127.0.0.1])
        by mx07-00178001.pphosted.com (8.16.0.42/8.16.0.42) with SMTP id 04697Gwj001991;
        Wed, 6 May 2020 11:12:08 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=st.com; h=from : to : cc : subject
 : date : message-id : in-reply-to : references : mime-version :
 content-type; s=STMicroelectronics;
 bh=pnpgGCLDzbYjOqrS/P3hhQHU+UxQX4sOTv//aAKe5PU=;
 b=uTeUw30h5GuhfVUIXp6QyHMhecy4sBX+hUjUMUyXbfKpVkZSdqkTRjOZUl7FLWMCiomJ
 7fUj+CVptkJTp+C8+qf/rT+ZKlDmZhEgPpCVHTkJgbcyhnu38a0g4IvQtLh/Y1g53Js3
 2r07BlcS5aHEOpEx+aNgAWYGxWo7P1gBePrpUUhUQM097fjwUcHQgmMmIS1Og2GrTfya
 z2p7kK3yXZXk2aY4Mc8h2pNTA2u5wGV/yrdsXTWfMzj6rdHWEbPGtuFm8p/rLPuBS/On
 ULwyvSSn9vo/B6Z8oYijPqkFlLTN8ATXEMnmLNfFOkrgiEJq06TWDiW/4R5L10DBYdQV 7w== 
Received: from beta.dmz-eu.st.com (beta.dmz-eu.st.com [164.129.1.35])
        by mx07-00178001.pphosted.com with ESMTP id 30rxb254xc-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Wed, 06 May 2020 11:12:08 +0200
Received: from euls16034.sgp.st.com (euls16034.sgp.st.com [10.75.44.20])
        by beta.dmz-eu.st.com (STMicroelectronics) with ESMTP id 203CB100039;
        Wed,  6 May 2020 11:12:08 +0200 (CEST)
Received: from Webmail-eu.st.com (sfhdag6node2.st.com [10.75.127.17])
        by euls16034.sgp.st.com (STMicroelectronics) with ESMTP id 02C8B2AB475;
        Wed,  6 May 2020 11:12:08 +0200 (CEST)
Received: from localhost (10.75.127.48) by SFHDAG6NODE2.st.com (10.75.127.17)
 with Microsoft SMTP Server (TLS) id 15.0.1347.2; Wed, 6 May 2020 11:12:07
 +0200
From:   Christophe Kerello <christophe.kerello@st.com>
To:     <miquel.raynal@bootlin.com>, <richard@nod.at>, <vigneshr@ti.com>,
        <robh+dt@kernel.org>, <mark.rutland@arm.com>,
        <gregkh@linuxfoundation.org>, <boris.brezillon@collabora.com>
CC:     <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-stm32@st-md-mailman.stormreply.com>,
        <devicetree@vger.kernel.org>, <marex@denx.de>,
        Christophe Kerello <christophe.kerello@st.com>
Subject: [PATCH v4 03/10] mtd: rawnand: stm32_fmc2: use FMC2_TIMEOUT_MS for timeouts
Date:   Wed, 6 May 2020 11:11:12 +0200
Message-ID: <1588756279-17289-4-git-send-email-christophe.kerello@st.com>
X-Mailer: git-send-email 1.9.1
In-Reply-To: <1588756279-17289-1-git-send-email-christophe.kerello@st.com>
References: <1588756279-17289-1-git-send-email-christophe.kerello@st.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.75.127.48]
X-ClientProxiedBy: SFHDAG6NODE1.st.com (10.75.127.16) To SFHDAG6NODE2.st.com
 (10.75.127.17)
X-Proofpoint-Virus-Version: vendor=fsecure engine=2.50.10434:6.0.138,18.0.676
 definitions=2020-05-06_03:2020-05-04,2020-05-06 signatures=0
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch removes the constant FMC2_TIMEOUT_US.
FMC2_TIMEOUT_MS will be used each time that we need to wait (except
when the timeout value is set by the framework).

It was seen, during stress tests with the sequencer in an overloaded
system, that we could be close to 1 second, even if we never met this
value. To be safe, FMC2_TIMEOUT_MS is set to 5 seconds.

Signed-off-by: Christophe Kerello <christophe.kerello@st.com>
---
Changes in v3:
 - add in the commit log the reason to increase FMC2_TIMEOUT_MS

 drivers/mtd/nand/raw/stm32_fmc2_nand.c | 9 ++++-----
 1 file changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/stm32_fmc2_nand.c b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
index 3377fbe..5778a95 100644
--- a/drivers/mtd/nand/raw/stm32_fmc2_nand.c
+++ b/drivers/mtd/nand/raw/stm32_fmc2_nand.c
@@ -37,8 +37,7 @@
 /* Max ECC buffer length */
 #define FMC2_MAX_ECC_BUF_LEN		(FMC2_BCHDSRS_LEN * FMC2_MAX_SG)
 
-#define FMC2_TIMEOUT_US			1000
-#define FMC2_TIMEOUT_MS			1000
+#define FMC2_TIMEOUT_MS			5000
 
 /* Timings */
 #define FMC2_THIZ			1
@@ -526,8 +525,8 @@ static int stm32_fmc2_ham_calculate(struct nand_chip *chip, const u8 *data,
 	int ret;
 
 	ret = readl_relaxed_poll_timeout(fmc2->io_base + FMC2_SR,
-					 sr, sr & FMC2_SR_NWRF, 10,
-					 FMC2_TIMEOUT_MS);
+					 sr, sr & FMC2_SR_NWRF, 1,
+					 1000 * FMC2_TIMEOUT_MS);
 	if (ret) {
 		dev_err(fmc2->dev, "ham timeout\n");
 		return ret;
@@ -1315,7 +1314,7 @@ static int stm32_fmc2_waitrdy(struct nand_chip *chip, unsigned long timeout_ms)
 	/* Check if there is no pending requests to the NAND flash */
 	if (readl_relaxed_poll_timeout_atomic(fmc2->io_base + FMC2_SR, sr,
 					      sr & FMC2_SR_NWRF, 1,
-					      FMC2_TIMEOUT_US))
+					      1000 * FMC2_TIMEOUT_MS))
 		dev_warn(fmc2->dev, "Waitrdy timeout\n");
 
 	/* Wait tWB before R/B# signal is low */
-- 
1.9.1

