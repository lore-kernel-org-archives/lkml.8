Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BA08C10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:55:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D102220409
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 11:55:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ECV2TITw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726469AbgCILzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 07:55:35 -0400
Received: from mail-wr1-f47.google.com ([209.85.221.47]:45842 "EHLO
        mail-wr1-f47.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgCILzf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 07:55:35 -0400
Received: by mail-wr1-f47.google.com with SMTP id m9so1700097wro.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 04:55:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=x3njD6+9rCh2R4ZtyRt9jkAQWO2ArwtXcsjyqU2Z3iM=;
        b=ECV2TITwkXMm4zdIP2BzU2I+37Ph6om2K6g/pWjT8D7iGL22STIRcf1Qu+YhmyiYBT
         LvPaIqyhIuL74OlMtJCFO8J70Ne7G3A9DwA0V/2W4/zb6GgWtTkINr4JnMfRzPRsXoYt
         3s9MXzvkDUC80Qzbt4oxIN194VzZ6k+hMP1HHqWlcw1p9QDx+RrO6szBd5HwZgpAudw9
         gcXMDOt1m6JRp3QAVLCD7536GdW6lyoC36fgLP9LhiIP07K4U1Zz0f+Pi+YZ5Gm9uiyF
         RgvsmavCQjgiTvxtyvUNknpps6s/w75TRhpg9N3I/y+7Hnfz10ixObBl9YiEkIpFpRKG
         a2Gw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=x3njD6+9rCh2R4ZtyRt9jkAQWO2ArwtXcsjyqU2Z3iM=;
        b=CTq962+kqV3Nk6T5BlHOp9FB21GOw2cWUBdRC24UMQrRR/XJW2FhbS1vJJOhceGtrK
         0wB6/cOB0qUrDf383mww5WNr8b9BJU8sEbyhoVn4MNBqzF/ihNBDxWzbZK/5HaErvYEG
         eDla7kVmTnkYg5LX3q/UErahsoycW2kgRMWCD6cppy6TbrrAJGvWRdN1SeuaouGUZoJx
         ZJZB3Y8vwEwnnvEfbjtYkqjrmL6WV5tdkM39+Nb0Kn9i8eqN+t33piN0jw48el9uaXwM
         D/7+SOC88YJZVExPEUyy6CaNk+eISL4pBok1TDCs0QM6tEO712IlVdeLo/goc6wK3Z7J
         MwKQ==
X-Gm-Message-State: ANhLgQ0lq9ofxNdBKrAkgbaHve6X1vlDdLIv+pdMerIk5OrCauESQReF
        T1cy+5XogTcAnwjtQ5Nt+YA=
X-Google-Smtp-Source: ADFU+vtqAReD2EwH8fWWOIFACtOM1XV1H+C3VqllXEMUrnrrFkk9SUU8nXY5zaTNBoY3XQIYQuk73Q==
X-Received: by 2002:adf:94c2:: with SMTP id 60mr13568774wrr.396.1583754933357;
        Mon, 09 Mar 2020 04:55:33 -0700 (PDT)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id m21sm25035226wmi.27.2020.03.09.04.55.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 04:55:32 -0700 (PDT)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Boris Brezillon <boris.brezillon@collabora.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v6 0/6] Add new series Micron SPI NAND devices
Date:   Mon,  9 Mar 2020 12:52:24 +0100
Message-Id: <20200309115230.7207-1-sshivamurthy@micron.com>
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

 drivers/mtd/nand/spi/micron.c | 150 ++++++++++++++++++++++++++++++----
 include/linux/mtd/spinand.h   |   1 +
 2 files changed, 137 insertions(+), 14 deletions(-)

-- 
2.17.1

