Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67F94C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:23:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 38DE92065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 21:23:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BA25v1ud"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727835AbgENVXs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 17:23:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726216AbgENVXr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 17:23:47 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 718FAC061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 14:23:47 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id k12so32317217wmj.3
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 14:23:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=TW3B/oY6lOWmiNP5IW02zTB9a0DCh41deR1YnQIWdpM=;
        b=BA25v1udkyuZZ5BtwgAxW6Pl4umsfLS9BoSrzmoWWtcH/x1MvJ9WlzogkOm8wfvzfv
         RRvtdQWtBTX6LupAQjebAcDnnizaRSSYr0bP1CVWUE2wJCz8deV8E4vtCod7Jo8mgKoE
         pF6hIoezucYa5IaitD0Lc0tnXYeBP3RQiUEVIMjJmCpi3dEvgMMMmg8fZj6P4BVpVAJY
         +K7NNq8KXvZHtY/gaQFr0wyMELqHIRewKmb1eabDcY1UfaC/Bq7l9Hy4/dpaOUZ3Zeqf
         dq0e+4xHb1wtMSuTD7l7ZKaPgK+bWGZYEvAy3AJp45T6JVovykTHfvcbjJ78294WG3QT
         rQ3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=TW3B/oY6lOWmiNP5IW02zTB9a0DCh41deR1YnQIWdpM=;
        b=Dg91TCc/w/sUKRdzyCzWi9J/bn/kYT7Z9rMHwFhjTgjhfHX8si+l1cdiZMoQl1pjsJ
         NUQrZOV3UsV3O0anb3xnJ/zvokR6AHB8YarApMwVupNWftT7ZgDbHxGPduoq44RitQRD
         dDpv/G2VMiFyf1C+ppGJ8vtAxQol9gUTvDMq6kjSqyGLdGQ6GOOihBDcbMBfc2YsNyZT
         C1qUKjIk38AKYquUEPmQjAwhpD260svjuM+e5pOv60GY5ikmOdwhiocyh8u8YCK++WH8
         n3OAXBl4EpdXaV4uttl0gv1xQ3C/38+nELr6xg6spvYehz0e1qeXnhxvWnGspFaH0Gms
         kEOQ==
X-Gm-Message-State: AOAM53373AaG/OIH7m7dagKsqCfQVSJSjvY1S9dNGvX1qdSecEM1EMjM
        OPlUQlxCvxUQom3B44px41Q=
X-Google-Smtp-Source: ABdhPJwXRFI0vIFI+l5oRrL5aNAk6L9ObEqDlYZ21qs6N7aRGVbNuLFpMICH5zH9O/DN2WqkGQHWqQ==
X-Received: by 2002:a05:600c:22d3:: with SMTP id 19mr298771wmg.161.1589491426069;
        Thu, 14 May 2020 14:23:46 -0700 (PDT)
Received: from localhost.localdomain (ip5f5bfcc8.dynamic.kabel-deutschland.de. [95.91.252.200])
        by smtp.gmail.com with ESMTPSA id 128sm491210wme.39.2020.05.14.14.23.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 14 May 2020 14:23:45 -0700 (PDT)
From:   huobean@gmail.com
X-Google-Original-From: beanhuo@micron.com
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        s.hauer@pengutronix.de, boris.brezillon@collabora.com,
        derosier@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        Bean Huo <beanhuo@micron.com>
Subject: [PATCH v3 0/5] Micron SLC NAND filling block
Date:   Thu, 14 May 2020 23:23:28 +0200
Message-Id: <20200514212333.28692-1-beanhuo@micron.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Hi,

on some legacy planar 2D Micron NAND devices when a block erase command is
issued, occasionally even though a block erase operation completes and returns
a pass status, the flash block may not be completely erased. Subsequent
operations to this block on very rare cases can result in subtle failures or
corruption. These extremely rare cases should nevertheless be considered. This
patchset is to address this potential issue.

After submission of patch V1 [1] and V2 [2], we stopped its update since we get
stuck in the solution on how to avoid the power-loss issue in case power-cut
hits the block filling. In the v1 and v2, to avoid this issue, we always damaged
page0, page1, this's based on the hypothesis that NAND FS is UBIFS. This
FS-specifical code is unacceptable in the MTD layer. Also, it cannot cover all
NAND based file system. Based on the current discussion, seems that re-write all
first 15 page from page0 is a satisfactory solution.

Meanwhile, I borrowed one idea from Miquel Raynal patchset [3], in which keeps
a recode of programmed pages, base on it, for most of the cases, we don't need
to read every page to see if current erasing block is a partially programmed
block.

Changelog:

v2 - v3:
    1. Rebase patch to the latest MTD git tree
    2. Add a record that keeps tracking the programmed pages in the first 16 pages
    3. Change from program odd pages, damage page 0 and page 1, to program all
       first 15 pages
    4. Address issues which exist in the V2.

v1 - v2:
    1. Rebased V1 to latest Linux kernel.
    2. Add erase preparation function pointer in nand_manufacturer_ops.

[1] https://www.spinics.net/lists/linux-mtd/msg04112.html
[2] https://www.spinics.net/lists/linux-mtd/msg04450.html
[3] https://www.spinics.net/lists/linux-mtd/msg13083.html

Bean Huo (5):
  mtd: rawnand: group all NAND specific ops into new nand_chip_ops
  mtd: rawnand: Add {pre,post}_erase hooks in nand_chip_ops
  mtd: rawnand: Add write_oob hook in nand_chip_ops
  mtd: rawnand: Introduce a new function nand_check_is_erased_page()
  mtd: rawnand: micron: Micron SLC NAND filling block

 drivers/mtd/nand/raw/internals.h     |   3 +-
 drivers/mtd/nand/raw/nand_base.c     |  96 +++++++++++++++++++++----
 drivers/mtd/nand/raw/nand_hynix.c    |   2 +-
 drivers/mtd/nand/raw/nand_macronix.c |  10 +--
 drivers/mtd/nand/raw/nand_micron.c   | 104 ++++++++++++++++++++++++++-
 include/linux/mtd/rawnand.h          |  40 +++++++----
 6 files changed, 220 insertions(+), 35 deletions(-)

-- 
2.17.1

