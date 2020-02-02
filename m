Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 835FFC35249
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58C6A20679
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:57:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oNt7SLDV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727169AbgBBV5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 16:57:30 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:37931 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgBBV53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 16:57:29 -0500
Received: by mail-wm1-f65.google.com with SMTP id a9so14795387wmj.3
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 13:57:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=jyEX43ZpUb0u2S3WQ5QnhN2Cyr6EL7YY0DzTdYAAonw=;
        b=oNt7SLDVRwnURZ4zpEhCp8aH3DEqqbet60GVVDBpCE5PqPeaWYaGz5mIiKP60eA9wb
         uXLjq++xtk4tbGNu7nopBBvzX0hpx/aJYE9gI3pSoPHHNrHskJLnh1OB4+BRF6N4chdT
         tX2VVskFUxPTiEfGk0hjsg0fwEaSXJvqJYP/BgIHpYhGqFC6R2Uo9CnxTTBWfuHIw4tN
         kla2u2aUTx7I4tmOxHDjzCuhy1trQiyIb8hGC7duQ5jZqT20OoYvfktAJjOY1rf8aYtg
         yDFcE3J+x1RYOtPZSN+uOEEGDKWvItr4s1Dke6MVqHDD397cQmqFSby5CL7t1YL1dMWZ
         5A0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=jyEX43ZpUb0u2S3WQ5QnhN2Cyr6EL7YY0DzTdYAAonw=;
        b=lCyy32ztF4pQa9eOQgkIhZK5xNhGHcLOOv3BC81JguVq6W4WJPJYa7P7U8GkzbUNZo
         QcLscUBXrbOp2NYBASxJ9wfCmBTvqGZ1vyvSsJjgR94XAIjEE6hPl8PQ7rf8jX97Cw4w
         iOBN0fuf/XNCM35jxYlxWbhz9Uwz1uBN2998gV5Ufzik5lYlUZqpiYScdziajggHygyC
         P+efySc86/J4scUhmBHnCpwoVbwk8l0Lle2EWcUdXAg1l/XeXXrJww2x81j7ct+FrFG5
         efINGU07457ycq0yNTznRrfMZr9dQsgM7RY9gYPtlkUjL1zNcwUwo8Eywo8FIfCYK1sF
         DUSQ==
X-Gm-Message-State: APjAAAXPG0zmQiKt1ScnaMUxNzB4HjCnvwf50MjsxQB3gU+tvdh3RyAs
        opV2jsf7Ncq5Tb/zpv/mq2ifNqQGGNVuzg==
X-Google-Smtp-Source: APXvYqxQiUZExxKdeKXdKMyeiKqxAeXS95EnstwHXKrf41XCZLhiC/oDqRYIDtqzVqGXmU5bMdgkTw==
X-Received: by 2002:a05:600c:2207:: with SMTP id z7mr25548604wml.138.1580680646753;
        Sun, 02 Feb 2020 13:57:26 -0800 (PST)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id c4sm20612488wml.7.2020.02.02.13.57.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 13:57:26 -0800 (PST)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v3 3/5] mtd: spinand: identfiy SPI NAND device with Continuous Read mode
Date:   Sun,  2 Feb 2020 22:55:06 +0100
Message-Id: <20200202215508.2928-4-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200202215508.2928-1-sshivamurthy@micron.com>
References: <20200202215508.2928-1-sshivamurthy@micron.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

Add SPINAND_HAS_CR_FEAT_BIT flag to identify the SPI NAND device with
the Continuous Read mode.

Currently, some of the Micron SPI NAND devices enable this feature by
default, and we need to identify them to disable while probing.

Signed-off-by: Shivamurthy Shastri <sshivamurthy@micron.com>
---
 include/linux/mtd/spinand.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/include/linux/mtd/spinand.h b/include/linux/mtd/spinand.h
index 4ea558bd3c46..333149b2855f 100644
--- a/include/linux/mtd/spinand.h
+++ b/include/linux/mtd/spinand.h
@@ -270,6 +270,7 @@ struct spinand_ecc_info {
 };
 
 #define SPINAND_HAS_QE_BIT		BIT(0)
+#define SPINAND_HAS_CR_FEAT_BIT		BIT(1)
 
 /**
  * struct spinand_info - Structure used to describe SPI NAND chips
-- 
2.17.1

