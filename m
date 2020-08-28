Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B36C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 01:12:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D3322080C
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 01:12:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=alliedtelesis.co.nz header.i=@alliedtelesis.co.nz header.b="Do8Emqvx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728446AbgH1BMt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 21:12:49 -0400
Received: from gate2.alliedtelesis.co.nz ([202.36.163.20]:34256 "EHLO
        gate2.alliedtelesis.co.nz" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728292AbgH1BMp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 21:12:45 -0400
Received: from mmarshal3.atlnz.lc (mmarshal3.atlnz.lc [10.32.18.43])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by gate2.alliedtelesis.co.nz (Postfix) with ESMTPS id 18D8684487;
        Fri, 28 Aug 2020 13:12:41 +1200 (NZST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alliedtelesis.co.nz;
        s=mail181024; t=1598577161;
        bh=HzQ2JRxwOvIbNaDzkQVH6yxpHLoPkEl245xKkJP6A9M=;
        h=From:To:Cc:Subject:Date;
        b=Do8EmqvxJfgCyQE0o10P41/CO4lNjrQXyh50aXrRRFV3eROqfbuPK+ToRTX2Gl0ZC
         qTeWHMUfOf5QTEolYcOxZKUYeLJT+sfO8N+pfyrKf4dgvTDUsYuVvguvlbf9MMbdTH
         bBA67naUZo/Q9z7zjS4w70BRqESTrdlf//pz2I+noV8jx9rvc5Jc1eW2l0gObJKWSO
         xoI0g8m3xIqn5M6JSfOjDOWNkqCxRs4jStJj+tT5gB9re062FXNoUlTk3cDd4Sod92
         Y1qy7rliZogberCYDOKHeTK5b6nSUurIjNQrCS+tznWyNbDaBD1xbHHDmngemd7nwq
         Qu2Q1gomvNq7g==
Received: from smtp (Not Verified[10.32.16.33]) by mmarshal3.atlnz.lc with Trustwave SEG (v7,5,8,10121)
        id <B5f485a080000>; Fri, 28 Aug 2020 13:12:40 +1200
Received: from chrisp-dl.ws.atlnz.lc (chrisp-dl.ws.atlnz.lc [10.33.22.20])
        by smtp (Postfix) with ESMTP id B0E2713EEB7;
        Fri, 28 Aug 2020 13:12:40 +1200 (NZST)
Received: by chrisp-dl.ws.atlnz.lc (Postfix, from userid 1030)
        id BF23B280060; Fri, 28 Aug 2020 13:12:40 +1200 (NZST)
From:   Chris Packham <chris.packham@alliedtelesis.co.nz>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Chris Packham <chris.packham@alliedtelesis.co.nz>
Subject: [PATCH] mtd: rawnand: marvell: Support panic_write for mtdoops
Date:   Fri, 28 Aug 2020 13:12:37 +1200
Message-Id: <20200828011237.22066-1-chris.packham@alliedtelesis.co.nz>
X-Mailer: git-send-email 2.28.0
MIME-Version: 1.0
Content-Transfer-Encoding: quoted-printable
x-atlnz-ls: pat
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Under a panic context we can't get an interrupt. Actively poll for the
RB status when performing a panic_write.

Signed-off-by: Chris Packham <chris.packham@alliedtelesis.co.nz>
---
 drivers/mtd/nand/raw/marvell_nand.c | 38 +++++++++++++++++++++++++----
 1 file changed, 33 insertions(+), 5 deletions(-)

diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/m=
arvell_nand.c
index 8482d3bd8b1f..a81bc50f5ec8 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -685,9 +685,31 @@ static int marvell_nfc_wait_cmdd(struct nand_chip *c=
hip)
 	return marvell_nfc_end_cmd(chip, cs_flag, "CMDD");
 }
=20
+static int marvell_nfc_poll_status(struct marvell_nfc *nfc, u32 mask,
+				   u32 expected_val, unsigned long timeout_ms)
+{
+	unsigned long limit;
+	u32 st;
+
+	limit =3D jiffies + msecs_to_jiffies(timeout_ms);
+	do {
+		st =3D readl_relaxed(nfc->regs + NDSR);
+		if (st & NDSR_RDY(1))
+			st |=3D NDSR_RDY(0);
+
+		if ((st & mask) =3D=3D expected_val)
+			return 0;
+
+		cpu_relax();
+	} while (time_after(limit, jiffies));
+
+	return -ETIMEDOUT;
+}
+
 static int marvell_nfc_wait_op(struct nand_chip *chip, unsigned int time=
out_ms)
 {
 	struct marvell_nfc *nfc =3D to_marvell_nfc(chip->controller);
+	struct mtd_info *mtd =3D nand_to_mtd(chip);
 	u32 pending;
 	int ret;
=20
@@ -695,12 +717,18 @@ static int marvell_nfc_wait_op(struct nand_chip *ch=
ip, unsigned int timeout_ms)
 	if (!timeout_ms)
 		timeout_ms =3D IRQ_TIMEOUT;
=20
-	init_completion(&nfc->complete);
+	if (mtd->oops_panic_write) {
+		ret =3D marvell_nfc_poll_status(nfc, NDSR_RDY(0),
+					      NDSR_RDY(0),
+					      timeout_ms);
+	} else {
+		init_completion(&nfc->complete);
=20
-	marvell_nfc_enable_int(nfc, NDCR_RDYM);
-	ret =3D wait_for_completion_timeout(&nfc->complete,
-					  msecs_to_jiffies(timeout_ms));
-	marvell_nfc_disable_int(nfc, NDCR_RDYM);
+		marvell_nfc_enable_int(nfc, NDCR_RDYM);
+		ret =3D wait_for_completion_timeout(&nfc->complete,
+						  msecs_to_jiffies(timeout_ms));
+		marvell_nfc_disable_int(nfc, NDCR_RDYM);
+	}
 	pending =3D marvell_nfc_clear_int(nfc, NDSR_RDY(0) | NDSR_RDY(1));
=20
 	/*
--=20
2.28.0

