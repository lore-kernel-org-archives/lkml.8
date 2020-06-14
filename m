Return-Path: <SRS0=Atmy=73=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2228C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 03:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1E3720714
	for <linux-kernel@archiver.kernel.org>; Sun, 14 Jun 2020 03:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=umn.edu header.i=@umn.edu header.b="T4DAA+LZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgFNDnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 13 Jun 2020 23:43:06 -0400
Received: from mta-p6.oit.umn.edu ([134.84.196.206]:56506 "EHLO
        mta-p6.oit.umn.edu" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726460AbgFNDnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 13 Jun 2020 23:43:05 -0400
Received: from localhost (unknown [127.0.0.1])
        by mta-p6.oit.umn.edu (Postfix) with ESMTP id 49l0fc4LNBz9vYTt
        for <linux-kernel@vger.kernel.org>; Sun, 14 Jun 2020 03:43:04 +0000 (UTC)
X-Virus-Scanned: amavisd-new at umn.edu
Received: from mta-p6.oit.umn.edu ([127.0.0.1])
        by localhost (mta-p6.oit.umn.edu [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id mwT6qnP2XeP4 for <linux-kernel@vger.kernel.org>;
        Sat, 13 Jun 2020 22:43:04 -0500 (CDT)
Received: from mail-io1-f70.google.com (mail-io1-f70.google.com [209.85.166.70])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mta-p6.oit.umn.edu (Postfix) with ESMTPS id 49l0fc2b6Pz9vYTv
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 22:43:04 -0500 (CDT)
DMARC-Filter: OpenDMARC Filter v1.3.2 mta-p6.oit.umn.edu 49l0fc2b6Pz9vYTv
DKIM-Filter: OpenDKIM Filter v2.11.0 mta-p6.oit.umn.edu 49l0fc2b6Pz9vYTv
Received: by mail-io1-f70.google.com with SMTP id z12so9012764iow.15
        for <linux-kernel@vger.kernel.org>; Sat, 13 Jun 2020 20:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=umn.edu; s=google;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dsq6JbO1KTJtMtuBdfOmtg9IIO/0JLFGMvczoxyNm9E=;
        b=T4DAA+LZ5GvUJNBZqkmFvpNjZBqfkE7QhM4rWMXq/kmwrLYY0xDGVuET3GGxcTSj5Y
         0/01MOWxwMX01wgC4hG+mc89jDDMIG0WncLf7xawjYyTvfxHGFdZOUkwPLYI7Hfjtxo4
         J/N4R6w2AzdcTaUUsQWIz1wTR8ZbbeAZFdfqWMISBCas1Q1p0GskAv8WV7oNTJ+HEoLy
         hRFvMbtyMR97QTXbpi1C1POLR/aY3qIyPecTa3eq2SiyEzoqvzOrrOgbq/ObIfBmelzY
         tFQc54Sz8krFe14pdhodgigY+3BhrLx+nWjhOtmpoOq84RrubzP8/yTXZwKEPom+ofuM
         OkDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=Dsq6JbO1KTJtMtuBdfOmtg9IIO/0JLFGMvczoxyNm9E=;
        b=c4k4280cfnbtE/UVdqH7NwGQn6ejMC4/LGBB//BWKOKJzYOxxI9nI4UVBEo6wVeKPR
         MWtDDDxxnZSlpy1WReAgbREK8lPLdNelxa7DqDOxz5BB109JeKfgqPIynxcMBA57meDA
         n2902D3kdQ4K1fgjjATiMpi5oIunKKcfWSQ5ZtW7cZR/vIMqnLU0FoaBeCR0nZ9c/HKs
         1kD4zZPDhONy+VUEszuBc5Uh/Y41J52iv6Ow68huVblByYpMb/tmlB9w8IclhyXyWrHu
         u0W7oBCWWfXfV3xx6IhxEpb5ybYxdWJWpMVZEDT+gsx5nT+dgg9GdEJP6TrsNq+dVJMD
         1UpA==
X-Gm-Message-State: AOAM530ihRmXXSfGdWqajOZvI90GXMEQT9IKhadGQkCmBfLNdxOQ69Wh
        jD7UZxiE5N3L+RGeITcbhLwO3Aj3Ig0TWD0gUHVR8t152k6xt2nU0gUmfroq3f04LDQhQql2vvf
        I+DxSuf41i73u1mC1XwCUlbTzSJPL
X-Received: by 2002:a92:584a:: with SMTP id m71mr20962739ilb.242.1592106184008;
        Sat, 13 Jun 2020 20:43:04 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwoNop5k3uJVr4tvaCfJyJYvbOpD1zjbwHZv2iLs92oN14zJzdrBPq0kVVYB2M3oPSPKyxOFQ==
X-Received: by 2002:a92:584a:: with SMTP id m71mr20962733ilb.242.1592106183851;
        Sat, 13 Jun 2020 20:43:03 -0700 (PDT)
Received: from syssec1.cs.umn.edu ([2607:ea00:101:3c74:49fa:9c47:e40b:9c40])
        by smtp.gmail.com with ESMTPSA id m3sm5670202ioc.10.2020.06.13.20.43.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 13 Jun 2020 20:43:03 -0700 (PDT)
From:   Aditya Pakki <pakki001@umn.edu>
To:     pakki001@umn.edu
Cc:     kjlu@umn.edu, wu000273@umn.edu, Han Xu <han.xu@nxp.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH] mtd: rawnand: gpmi: fix reference count leak due to pm_runtime_get_sync
Date:   Sat, 13 Jun 2020 22:43:00 -0500
Message-Id: <20200614034300.130385-1-pakki001@umn.edu>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On calling pm_runtime_get_sync() the reference count of the device
is incremented. In case of failure, decrement the
reference count before returning the error.

Signed-off-by: Aditya Pakki <pakki001@umn.edu>
---
 drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
index 061a8ddda275..657c0be5c038 100644
--- a/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
+++ b/drivers/mtd/nand/raw/gpmi-nand/gpmi-nand.c
@@ -149,8 +149,10 @@ static int gpmi_init(struct gpmi_nand_data *this)
 	int ret;
 
 	ret = pm_runtime_get_sync(this->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(this->dev);
 		return ret;
+	}
 
 	ret = gpmi_reset_block(r->gpmi_regs, false);
 	if (ret)
@@ -2264,8 +2266,10 @@ static int gpmi_nfc_exec_op(struct nand_chip *chip,
 		this->transfers[i].direction = DMA_NONE;
 
 	ret = pm_runtime_get_sync(this->dev);
-	if (ret < 0)
+	if (ret < 0) {
+		pm_runtime_put_autosuspend(this->dev);
 		return ret;
+	}
 
 	/*
 	 * This driver currently supports only one NAND chip. Plus, dies share
-- 
2.25.1

