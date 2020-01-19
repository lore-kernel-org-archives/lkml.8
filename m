Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99BD8C33CB1
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 14:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 634BF206D7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 14:56:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="VBfLw1NC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727060AbgASO4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 09:56:37 -0500
Received: from mail-wr1-f48.google.com ([209.85.221.48]:44332 "EHLO
        mail-wr1-f48.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726778AbgASO4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 09:56:37 -0500
Received: by mail-wr1-f48.google.com with SMTP id q10so26948705wrm.11
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jan 2020 06:56:35 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=cxLWjS9rw2dbUJ5Mao99KZZP4Ha2WG+mka8EA8GPkLQ=;
        b=VBfLw1NCTFrJxi1gTq1aUETO1U/+Ores0BJps6D6jQK+Wjo0MsA9T9VmgRo+IYOYE9
         zhhKiZvUZlw2p6CIL4x0TxBhLxyjWqje3Ybnohh+Y8S4BvOi2mt8SMXhd3VI39XFg0O6
         zk+oEje0Pij2DzvqdoIDh8VFNq+0hEoXvr5q4CzvFoDIm8q01Ty1Y7Yr0XOxmLf88dY6
         eMuSy8o+j0ABX5F2GLW6S0y4ml3GKGy7dy3rErWh9EzbyfB0x97W2uu6xVHds5rGbqJE
         Gwi/HNc4m7xAja8EWRhwyKpVXQvS3ELd3aP8nwuxHYIpsibf9XInfa3Es+I3XdEIFUJY
         TEOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=cxLWjS9rw2dbUJ5Mao99KZZP4Ha2WG+mka8EA8GPkLQ=;
        b=qtz021gRuIA+4DCEOxUzuiLLiE3H8MAxM5wBlkg5M6JatlWuR1m+oLWz3CyZKa5jPv
         Rwr/XDpCiTMqGLR+/2IWHnsUAnSf6DEXBMfVzl9Xpyaa7c2aA0RCEbxF003/KBXn65gV
         26OXyXz+HtLqKwQmdD3AguUlP40Bx3Xnr6I7NbhiBxY73EMBVhO+QGDYxC3Rjc/xcAWf
         vRoiD9nDk9Vog22l0lijTV1ERLxPYpMpuTUScw9kmtPuEyfpp4EKdC3e2+bbzPmP4EM9
         dCi8h3IAZJP6JjbKE4TawYYzI7XQ2eUvrc3Y1ovqWAInD569erqdQat2+9UFcRFayC1x
         6Pwg==
X-Gm-Message-State: APjAAAVORMozwkEyo/U8NHigsd3k6TFCe0r5BArEYQPm2c6vCG2Ngz7Z
        lpiP5bjyttfeqDnbizSkJiLDJFP4Kdo=
X-Google-Smtp-Source: APXvYqzZrBpwU32I2VMY6j+WyZGG/d2rirtJd6hXGlB0KQ84KULzBIzuxcsgbKhGZcuJiZPBfnqt0w==
X-Received: by 2002:a5d:558d:: with SMTP id i13mr13579849wrv.364.1579445794806;
        Sun, 19 Jan 2020 06:56:34 -0800 (PST)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id p17sm43347877wrx.20.2020.01.19.06.56.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 19 Jan 2020 06:56:34 -0800 (PST)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH 0/4] Add new series Micron SPI NAND devices
Date:   Sun, 19 Jan 2020 15:54:28 +0100
Message-Id: <20200119145432.10405-1-sshivamurthy@micron.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Shivamurthy Shastri <sshivamurthy@micron.com>

This patchset is for the new series of Micron SPI NAND devices, and the
following links are their datasheets.

M78A:
[1] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m78a_1gb_3v_nand_spi.pdf
[2] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m78a_1gb_1_8v_nand_spi.pdf

M79A:
[3] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m79a_2gb_1_8v_nand_spi.pdf
[4] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m79a_ddp_4gb_3v_nand_spi.pdf

M70A:
[5] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m70a_4gb_3v_nand_spi.pdf
[6] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m70a_4gb_1_8v_nand_spi.pdf
[7] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m70a_ddp_8gb_3v_nand_spi.pdf
[8] https://www.micron.com/~/media/documents/products/data-sheet/nand-flash/70-series/m70a_ddp_8gb_1_8v_nand_spi.pdf

Changes since v1:
-----------------

1. The patch split into multiple patches.
2. Added comments for selecting the die.

Shivamurthy Shastri (4):
  mtd: spinand: Generalize the OOB layout structure and function names
  mtd: spinand: Add new Micron SPI NAND devices
  mtd: spinand: Add M70A series Micron SPI NAND devices
  mtd: spinand: Add new Micron SPI NAND devices with multiple dies

 drivers/mtd/nand/spi/micron.c | 140 ++++++++++++++++++++++++++++++----
 1 file changed, 126 insertions(+), 14 deletions(-)

-- 
2.17.1

