Return-Path: <SRS0=NZ9A=3W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F1A4C35249
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:57:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 40D472051A
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Feb 2020 21:57:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="W7GV6teh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgBBV5M (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Feb 2020 16:57:12 -0500
Received: from mail-wm1-f51.google.com ([209.85.128.51]:34075 "EHLO
        mail-wm1-f51.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726967AbgBBV5M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Feb 2020 16:57:12 -0500
Received: by mail-wm1-f51.google.com with SMTP id s144so12982399wme.1
        for <linux-kernel@vger.kernel.org>; Sun, 02 Feb 2020 13:57:10 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=fns2Ornju2WXVpySQuZ+PsDs1vo+7j/mk6LQDMuQm9A=;
        b=W7GV6tehArejuwu39wL1q5jCI5CaD+oWFnAUvHAxycAfjyGgu31RMxHB5f0hMdDJOZ
         cS16BCjvNMqPXMZ95bHMnqJGQuBCO2D3+DL2d/cJLz6y3m5gHV5SScaUUX4o+FvQIQAX
         D/0svRxcRrK0l/1c24JbwT2eNWNVJfSoX+jxj6gywhzS2/1EEuYwomhupjLTm0IERK3R
         jaH0Bn1r2EFShx/jNDOJIXfE/WdOUSCx7N85z/nlxbrXtSoR6QsvevY4HsZpPoGbRTJq
         MCw4fwa92NwbJJVFV8IojNQWWbz44JyjWr0qIDkqUNSULB/Ghdk5tu2b3xfc/FJ8A+sT
         bJZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=fns2Ornju2WXVpySQuZ+PsDs1vo+7j/mk6LQDMuQm9A=;
        b=NbGKi/KdmIaKKPRf1R19Cybt1FHCpqJX4A1BFIvCTBwRWDp23aKLmWCuLxuZAUK01V
         X13W7M+gx6LHjLM1TvN7aYqIiykrIsJ1h8WCgXEnS1FAYhlHZ2ENxEMMZMxu1d6+2Cai
         nR6dTvfhox3Q9awTIUNF+N6+rINxuFX9p/r5YEb3iPDGrrG/IcxzU4m16qO2ROlSBDrq
         Gi4jJ1xindQUmH8k6m/XWpFKZutQykdDl1KqK/s0tbh6cFl8ySI1jUsqgFA+lfZiOZGC
         Fvvc6e4x95dNvM/CPvfL2hmMNcm1knPjIFSm3AlYucOhyodA8gcXRU67bfXnPLXzW3Wb
         glLA==
X-Gm-Message-State: APjAAAWAKZYvK+Kl1fwTG/dlIE2mJ8TfgMnmj73HZBY3+s7p0NxdiAp6
        mW0yMcxzloy/WEV5yg7XBOQ=
X-Google-Smtp-Source: APXvYqx59dob6bQ6u27i6pYbjQ5bjx5FpleTfa+c/zmVpjmorV4xV2VxZpzHcxyRSa47BBf+qFzO5Q==
X-Received: by 2002:a1c:e388:: with SMTP id a130mr24739038wmh.176.1580680629854;
        Sun, 02 Feb 2020 13:57:09 -0800 (PST)
Received: from opensdev.fritz.box (business-178-015-117-054.static.arcor-ip.net. [178.15.117.54])
        by smtp.gmail.com with ESMTPSA id c4sm20612488wml.7.2020.02.02.13.57.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 02 Feb 2020 13:57:09 -0800 (PST)
From:   shiva.linuxworks@gmail.com
X-Google-Original-From: sshivamurthy@micron.com
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        Boris Brezillon <bbrezillon@kernel.org>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org
Cc:     Shivamurthy Shastri <sshivamurthy@micron.com>
Subject: [PATCH v3 0/5] Add new series Micron SPI NAND devices
Date:   Sun,  2 Feb 2020 22:55:03 +0100
Message-Id: <20200202215508.2928-1-sshivamurthy@micron.com>
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

Changes since v2:
-----------------

1. Modified the commit messages of the patches.
2. Handled devices with Continuous Read feature with vendor specific flag.
3. Reworked die selection function as per the comment.

Changes since v1:
-----------------

1. The patch split into multiple patches.
2. Added comments for selecting the die.

Shivamurthy Shastri (5):
  mtd: spinand: micron: Generalize the OOB layout structure and function
    names
  mtd: spinand: micron: Add new Micron SPI NAND devices
  mtd: spinand: identfiy SPI NAND device with Continuous Read mode
  mtd: spinand: micron: Add M70A series Micron SPI NAND devices
  mtd: spinand: micron: Add new Micron SPI NAND devices with multiple
    dies

 drivers/mtd/nand/spi/micron.c | 153 ++++++++++++++++++++++++++++++----
 include/linux/mtd/spinand.h   |   1 +
 2 files changed, 140 insertions(+), 14 deletions(-)

-- 
2.17.1

