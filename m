Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C79A1C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:15:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 997BB207F7
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 15:15:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=yadro.com header.i=@yadro.com header.b="rfqINGjT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726697AbgHLPPg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 11:15:36 -0400
Received: from mta-02.yadro.com ([89.207.88.252]:37138 "EHLO mta-01.yadro.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726512AbgHLPPd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 11:15:33 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-01.yadro.com (Postfix) with ESMTP id D351F4C89B;
        Wed, 12 Aug 2020 15:15:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=yadro.com; h=
        content-type:content-type:content-transfer-encoding:mime-version
        :references:in-reply-to:x-mailer:message-id:date:date:subject
        :subject:from:from:received:received:received; s=mta-01; t=
        1597245330; x=1599059731; bh=ii5ADmQuzyNneIFBkHAT3wYiVuvXA+hEUPb
        eRSzRgzU=; b=rfqINGjT9icIxLFgFxT8cX/Thy5VZHXf5nEh4LesToTEK16IV0c
        0iBufZefntN4zeYmVgyQdKflEi6szQYsY+r0b/TQcIMF1qcgjKnQepM9zFaJ7AQB
        pVHKZ6fIvW6S7Wksr/zIqqGGoj7zzem6L4ZdBLl9PyECCUBjwX6MLZW4=
X-Virus-Scanned: amavisd-new at yadro.com
Received: from mta-01.yadro.com ([127.0.0.1])
        by localhost (mta-01.yadro.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id TuBAypmAdOG7; Wed, 12 Aug 2020 18:15:30 +0300 (MSK)
Received: from T-EXCH-02.corp.yadro.com (t-exch-02.corp.yadro.com [172.17.10.102])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-SHA384 (256/256 bits))
        (No client certificate requested)
        by mta-01.yadro.com (Postfix) with ESMTPS id 4FAC64C8AA;
        Wed, 12 Aug 2020 18:15:30 +0300 (MSK)
Received: from localhost.dev.yadro.com (10.199.2.34) by
 T-EXCH-02.corp.yadro.com (172.17.10.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384_P384) id
 15.1.669.32; Wed, 12 Aug 2020 18:15:29 +0300
From:   Ivan Mikhaylov <i.mikhaylov@yadro.com>
CC:     Ivan Mikhaylov <i.mikhaylov@yadro.com>,
        Tudor Ambarus <tudor.ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        <linux-mtd@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH 1/2] mtd: spi-nor: do not touch TB bit without SPI_NOR_HAS_TB
Date:   Wed, 12 Aug 2020 18:18:17 +0300
Message-ID: <20200812151818.16699-2-i.mikhaylov@yadro.com>
X-Mailer: git-send-email 2.21.1
In-Reply-To: <20200812151818.16699-1-i.mikhaylov@yadro.com>
References: <20200812151818.16699-1-i.mikhaylov@yadro.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-Originating-IP: [10.199.2.34]
X-ClientProxiedBy: T-EXCH-01.corp.yadro.com (172.17.10.101) To
 T-EXCH-02.corp.yadro.com (172.17.10.102)
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Some chips like macronix don't have TB(Top/Bottom protection)
bit in the status register. Do not write tb_mask inside status
register, unless SPI_NOR_HAS_TB is present for the chip.

Signed-off-by: Ivan Mikhaylov <i.mikhaylov@yadro.com>
---
 drivers/mtd/spi-nor/core.c | 22 ++++++++++++++++------
 1 file changed, 16 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/spi-nor/core.c b/drivers/mtd/spi-nor/core.c
index 0369d98b2d12..f9853dd566dc 100644
--- a/drivers/mtd/spi-nor/core.c
+++ b/drivers/mtd/spi-nor/core.c
@@ -1735,13 +1735,18 @@ static int spi_nor_sr_lock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 			return -EINVAL;
 	}
 
-	status_new = (status_old & ~mask & ~tb_mask) | val;
+	if (nor->flags & SNOR_F_HAS_SR_TB)
+		status_new = (status_old & ~mask & ~tb_mask) | val;
+	else
+		status_new = (status_old & ~mask) | val;
 
 	/* Disallow further writes if WP pin is asserted */
 	status_new |= SR_SRWD;
 
-	if (!use_top)
-		status_new |= tb_mask;
+	if (!use_top) {
+		if (nor->flags & SNOR_F_HAS_SR_TB)
+			status_new |= tb_mask;
+	}
 
 	/* Don't bother if they're the same */
 	if (status_new == status_old)
@@ -1817,14 +1822,19 @@ static int spi_nor_sr_unlock(struct spi_nor *nor, loff_t ofs, uint64_t len)
 			return -EINVAL;
 	}
 
-	status_new = (status_old & ~mask & ~tb_mask) | val;
+	if (nor->flags & SNOR_F_HAS_SR_TB)
+		status_new = (status_old & ~mask & ~tb_mask) | val;
+	else
+		status_new = (status_old & ~mask) | val;
 
 	/* Don't protect status register if we're fully unlocked */
 	if (lock_len == 0)
 		status_new &= ~SR_SRWD;
 
-	if (!use_top)
-		status_new |= tb_mask;
+	if (!use_top) {
+		if (nor->flags & SNOR_F_HAS_SR_TB)
+			status_new |= tb_mask;
+	}
 
 	/* Don't bother if they're the same */
 	if (status_new == status_old)
-- 
2.21.1

