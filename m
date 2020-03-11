Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B7A49C2BAEE
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:58:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4C52C20738
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 17:58:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KfhjLI+1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730667AbgCKR6w (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 13:58:52 -0400
Received: from mail-wm1-f47.google.com ([209.85.128.47]:39790 "EHLO
        mail-wm1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730450AbgCKR6v (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 13:58:51 -0400
Received: by mail-wm1-f47.google.com with SMTP id f7so3153153wml.4
        for <linux-kernel@vger.kernel.org>; Wed, 11 Mar 2020 10:58:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=D0MmJxY6JdQ6gZeoOlIDmYiScwpgWMOLFKV0aKt57H0=;
        b=KfhjLI+11lfhCg/ocC5rckfQmrjWJic2uNKWFfImfjqyRwZLXIDBgsDNrtjljyRynH
         GdURhYfMl5lUtixt0hF66fG5ie8/CZQ9TwvV14k60xkaKNTepFbbcr973/zys4k1Nrs9
         3fLLRTmnOxomYLegaGsox085+SbGpG+ufgRJJBvHAkcLWyA3vl2dVPF8jNdKtkyuepDj
         yMWSvbtopBCWYA9sDUgRxWjF8BYWgAkL8+dk+6FBPkJNjLexq7E7aOb+LUDOlxl3xK1a
         8MZ8g19bz3o6fdrQrtbyvMDgr3oJKQ/tIxYBhkYtTKARST421XYhh11bi5YDhF3Fuda5
         obWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=D0MmJxY6JdQ6gZeoOlIDmYiScwpgWMOLFKV0aKt57H0=;
        b=ZfZ4yeChVNHlzDlN9CgClDb3OD3sVQSe1485VTQ8RYvjKzT7jQZaSf+YyjVUpBZYVG
         ZZlZqwYHgQlx3wcKp1v3ApvBLxYP9p9w5G4Xa9uYdMJhdani6L1Lx50w9+08HGtg3RJc
         JPHoIbWcUX+fhmxtancasEKBV00MlrLiryx7CQwokzS0JUSsz645X7DMl7JBeuBUiDDw
         oAEo3J+l3Ry7NQJaBDYIQ8vXnhLOUcD/wbqo68frauzQM9xzM8HHhsVQ4+KUoEEKpTIn
         T5sQNqg22VM7M3VEiZBI5Pc5WJm09a3aiVcztoPuqJGdvvLfbnkjRqN2iL9hYy3GXq0d
         b4+Q==
X-Gm-Message-State: ANhLgQ2en9h+sThtcq5GguOYbA3KQe1U7rvRmEg32hoUowp4GQqNEn1O
        rfr46PVzYF3gGj3gyiRRoLI=
X-Google-Smtp-Source: ADFU+vva0oWNwwcrUmHlZ4NWdzEHtYTEf73OgVui5Nkk1uBnR1wtjMNBg1BPy56FUaXPkyV0VToN5g==
X-Received: by 2002:a1c:9690:: with SMTP id y138mr985818wmd.65.1583949527159;
        Wed, 11 Mar 2020 10:58:47 -0700 (PDT)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id l18sm1502107wrr.17.2020.03.11.10.58.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 11 Mar 2020 10:58:46 -0700 (PDT)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Chuanhong Guo <gch981213@gmail.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v7 0/6] Add new series Micron SPI NAND devices
Date:   Wed, 11 Mar 2020 18:57:29 +0100
Message-Id: <20200311175735.2007-1-sshivamurthy@micron.com>
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

Changes since v6:
-----------------

1. Rebased series to nand/next.
2. Added Reviewed-by from Boris.

Changes since v5:
-----------------

1. Rebased series to v5.6-rc1.

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

 drivers/mtd/nand/spi/micron.c | 158 +++++++++++++++++++++++++++++++---
 include/linux/mtd/spinand.h   |   1 +
 2 files changed, 145 insertions(+), 14 deletions(-)

-- 
2.17.1

