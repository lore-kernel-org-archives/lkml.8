Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.3 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	DKIM_INVALID,DKIM_SIGNED,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A93AC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:25:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CB86206ED
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:25:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="c/gKHOj8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728639AbgAJQZG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:25:06 -0500
Received: from mail-yb1-f196.google.com ([209.85.219.196]:38988 "EHLO
        mail-yb1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728443AbgAJQZF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:25:05 -0500
Received: by mail-yb1-f196.google.com with SMTP id x18so629873ybk.6
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 08:25:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fywdVa/UePIbtxiPU29/D3V4nZg1ZmpQqMJh0490dJU=;
        b=c/gKHOj8Lg8wERQLbPfmM2sXWMxQsVAGVkUd4Zqo14cZtbkoCbt0NfnSSbkw7yi/Dy
         D6BFWPQVipEUW8DJITjotQC+I8CMFhk7alF3rAup8PXMVuR1sOBmm9ZJ38DjM3ZMuy0l
         Lkl2wlkzroeqiXjpPGups/IdRBzRvhpKWvhB0bFmdfR/6kedQGB5W0nJZo3IhY+aFtiU
         EgfDc5jTSWsDsO2uVVD8IMZVr46uYPUZVcUgcY5hpy57jAtYckXxT3Ot3bpLDZQW2kcT
         Aa+yqefuDQFkDRu1ZCaJySaobmvXGZD7bt/wdpO/BDrGje0KI70aoxvhABqTYUyyOZnI
         2Rzw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fywdVa/UePIbtxiPU29/D3V4nZg1ZmpQqMJh0490dJU=;
        b=Hz9/dIhfQcFJLCEhH5eiGrpQKT+kF9vDlH+WEwQ3puR/ejekr/mgPvnUYUKyM5MiRp
         CsK/EKkneno/Gx5kjqkDf5Ipi1JKcmSvWU6q1ZlQTzTCwBJX6ARZDsLDfTFqKpB9hyZD
         MpiLqWutRTp/mANfmArb2NRGNC6N4Fvzp6gKBmGzmEkiXtGRCTGgBfkev07xRq1nMksB
         t+mILTgHZzY79se67gEuu440Mz6y8log3lSb7rmFhwIOr9HTw4v2oNt0OJY9jMOizK/X
         zsMCZfGh1wMTFPIw45t4UXdYtZo5rAvcVD8eGzX61hAwNXkA9/84dRAok7sDd1fIYRSM
         WTZQ==
X-Gm-Message-State: APjAAAX6ckIDt+3NsK9UNh9LwI/l9NXTqv37upCz/u6+vbr8RWl5y+Zd
        S99b/a2S4smA7KPqP56ffO8=
X-Google-Smtp-Source: APXvYqwBT9ugL5Mh7ahlKnNhNiPtP1u0I02Dxik/BsiORNkhTP71g2EvV14PcFRuRVpDJ7/RvYwegg==
X-Received: by 2002:a25:f209:: with SMTP id i9mr3235523ybe.93.1578673504726;
        Fri, 10 Jan 2020 08:25:04 -0800 (PST)
Received: from borg007.lpdev.prtdev.lexmark.com ([192.146.101.90])
        by smtp.gmail.com with ESMTPSA id f138sm1168780ywb.99.2020.01.10.08.25.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 10 Jan 2020 08:25:03 -0800 (PST)
From:   zdhays@gmail.com
Cc:     zhays@lexmark.com, Zak Hays <zdhays@gmail.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Piotr Sroka <piotrs@cadence.com>,
        Marco Felsch <m.felsch@pengutronix.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v1] mtd: rawnand: micron: don't error out if internal ECC is set
Date:   Fri, 10 Jan 2020 11:25:01 -0500
Message-Id: <20200110162503.7185-1-zdhays@gmail.com>
X-Mailer: git-send-email 2.17.1
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Zak Hays <zdhays@gmail.com>

Recent changes to the driver require use of on-die correction if
the internal ECC enable bit is set. On some Micron parts, this bit
is enabled by default and there is no method for disabling it.

This is a false assumption though as that bit being enabled does not
necessarily mean that the on-die ECC *has* to be used. It has been
verified with a Micron FAE that other methods of error correction are
still valid even if this bit is set.

HW ECC offers generally higher performance than on-die so it is
preferred in some situations. This also allows multiple NAND parts to
be supported on the same PCB as some parts may not support on-die
error correction.

With that in mind, only throw a warning that the on-die bit is set
and allow the init to continue.

Signed-off-by: Zak Hays <zdhays@gmail.com>
---
 drivers/mtd/nand/raw/nand_micron.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/drivers/mtd/nand/raw/nand_micron.c b/drivers/mtd/nand/raw/nand_micron.c
index 56654030ec7f..ec40c76443be 100644
--- a/drivers/mtd/nand/raw/nand_micron.c
+++ b/drivers/mtd/nand/raw/nand_micron.c
@@ -455,9 +455,7 @@ static int micron_nand_init(struct nand_chip *chip)
 
 	if (ondie == MICRON_ON_DIE_MANDATORY &&
 	    chip->ecc.mode != NAND_ECC_ON_DIE) {
-		pr_err("On-die ECC forcefully enabled, not supported\n");
-		ret = -EINVAL;
-		goto err_free_manuf_data;
+		pr_warn("WARNING: On-die ECC forcefully enabled, use caution with other methods\n");
 	}
 
 	if (chip->ecc.mode == NAND_ECC_ON_DIE) {
-- 
2.17.1

