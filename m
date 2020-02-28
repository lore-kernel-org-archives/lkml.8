Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0CCD5C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:03:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8580E246AC
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 15:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Z4ryQdcc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727027AbgB1PDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 10:03:23 -0500
Received: from mail-wr1-f43.google.com ([209.85.221.43]:36963 "EHLO
        mail-wr1-f43.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726720AbgB1PDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 10:03:23 -0500
Received: by mail-wr1-f43.google.com with SMTP id l5so3313552wrx.4
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 07:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=rqRsY3IWGJs9c2oqjoPbTBhi2h3Tjt34hwIqWxHRNh4=;
        b=Z4ryQdcckQ0xnuIbqH6ezo1dgI+d92xbhITxcZlGRdkNhMq7T/VjW0ymLUJd6QCm8u
         pXPIg/qm1YoaRQtzwGIYLQotkCsN9jqqsNWcZcNboUgZ409ZT/f5FHcPoTqGC83GJb4Y
         dUQA6I8HJyFInC/w2j/XSZ8oxEG9ilIPAAEEkW+gYbQZp7lJLpZ8yD88FqiCQsrA6vLv
         3sUGGxhRAb2gz8sWsZATKrZIjRnHyAIkuLvIaYdmKhRncGNCfPoStzF/DCR7I/iPKJs8
         aReL0KjdbYTN/nU0+Tl7twe7mWeXtWMdy+70kqzXdA+GZRgVdKJVN1TI8TURHnDpPgfK
         CN3g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=rqRsY3IWGJs9c2oqjoPbTBhi2h3Tjt34hwIqWxHRNh4=;
        b=t7ID1l9F3UgoNm/L/T0rSZyKUwcZSldycdN2MMjTy89GpyqFwfD86pvJcR7A1DfmfD
         /sAE/1gdUeAETup32Rp+4mIjqaA5sqZms2QRvGlC9lX/SZW1KI+Ht6hbE7eTD2ka9rJh
         29aafxRvZOGzi/YT+zke7qZck1Mk7LDfxb7hAS14P45T9EKqaSFUivBFYZDkU4zSjp/k
         2bu9JPobF/AJ1IA/HxVe9Eg1V0dIfqUtc5chRA/gBWgv/4M665jM3UWlUzkodhUZFAeH
         4czV2h1N2a33HD2M2OnKwBFToQM5fIyl6XHf5DEeDis0eBq+M61neiwgAbybo/Lb6ser
         MHjw==
X-Gm-Message-State: APjAAAX66D/InnR9DRldJDcdv2q5ZZPlxR1UmjgnR9V3QRkiMQc4Y3Mp
        d703RZ7W31PJhRRJyAIW70kfOgnfTcw=
X-Google-Smtp-Source: APXvYqwJ3fwO0JpCT6Gv71plFAALDnHST5fzOxWtUvbW9WOWp6lAXxvCBYf8VT/XP6IZgVqupcdjhQ==
X-Received: by 2002:a5d:6692:: with SMTP id l18mr5040421wru.382.1582902200928;
        Fri, 28 Feb 2020 07:03:20 -0800 (PST)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id m125sm2540235wmf.8.2020.02.28.07.03.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Feb 2020 07:03:19 -0800 (PST)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <bbrezillon@kernel.org>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v5 0/6] Add new series Micron SPI NAND devices
Date:   Fri, 28 Feb 2020 16:03:05 +0100
Message-Id: <20200228150311.12184-1-sshivamurthy@micron.com>
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

Changes since v4:
-----------------

1. Patch 2 is separated into two as per the comment by Boris.
2. Renamed MICRON_CFG_CONTI_READ into MICRON_CFG_CR.
3. Reworked die selection function as per the comment by Boris.

Changes since v3:
-----------------

1. Patch 3 and 4 reworked as follows
   - Patch 3 introducing the Continuous read feature
   - Patch 4 adding devices with the feature

Changes since v2:
-----------------

1. Patch commit messages have been modified.
2. Handled devices with Continuous Read feature with vendor specific flag.
3. Reworked die selection function as per the comment.

Changes since v1:
-----------------

1. The patch split into multiple patches.
2. Added comments for selecting the die.

Shivamurthy Shastri (6):
  mtd: spinand: micron: Generalize the OOB layout structure and function
    names
  mtd: spinand: micron: Describe the SPI NAND device MT29F2G01ABAGD
  mtd: spinand: micron: Add new Micron SPI NAND devices
  mtd: spinand: micron: identify SPI NAND device with Continuous Read
    mode
  mtd: spinand: micron: Add M70A series Micron SPI NAND devices
  mtd: spinand: micron: Add new Micron SPI NAND devices with multiple
    dies

 drivers/mtd/nand/spi/micron.c | 150 ++++++++++++++++++++++++++++++----
 include/linux/mtd/spinand.h   |   1 +
 2 files changed, 137 insertions(+), 14 deletions(-)

-- 
2.17.1

