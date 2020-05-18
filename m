Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5FD27C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:59:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 39F2720674
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:59:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Vgb110JP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727815AbgERN76 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:59:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726989AbgERN76 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:59:58 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA93FC061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 06:59:57 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id k12so9403577wmj.3
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 06:59:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=vq51n84RcgHv+d8wqLYGOsdzlKQOGpPL5C5pKYyl18E=;
        b=Vgb110JPtOOtPYB2ns99Lh8QR7EaypmU/StfaF7Fs7LrDKz5zEPOzGEAO0yS8WtUrz
         eYOXSKM6zeCARBcoE9Hd4blN3SQG6KUBIjheyVjFPdO35HlFBV7Uw5ZQ2IwJ+V32kGRa
         7N2MAJtvp8b9sB41BjCuffu9Al3BJoKumbkm8tt3X6+3NDOfK9UBhyDyp1a+ftia9Xvk
         FLhLxALwNCFZfjYRl8gXIgfC2AZ5+RFxZdZc+Z23bsmoERexHV2GbpALGSBsIF59KaWk
         uVlQs8DbtdKUI5JScCOOTIzhyN02dfBpl1GyoEom8YR0wKT5TxntsvibOLR+n02atD9s
         srWg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=vq51n84RcgHv+d8wqLYGOsdzlKQOGpPL5C5pKYyl18E=;
        b=AuzpnKpjdBlK1pKd6bEnz1MAw6NzsgBM3Ynf02uLX26VEvRWYpbwO8064GQZ1pobt0
         BRnok76y8UbVar4eyLN4d7EZiE2wvzaK+hS8Xcdu9g+yF1exRxv7aSJ3yJaIKMaCNfsu
         GUBaTw/Bnx1nCRdQh2VtLF0GzXQY8MmMprZO+4ydUlWhmV5Zmk5KZ42sr5mV0LV2tGce
         n3ZeQcMgBirbQ6yUeBrE+Mg7tPpgvKmH2vePAlGv+Oyg1Fq0qpnco9iUMxknIwrIJMjT
         8pwCX8LwNcgu+ndDen+9rGpuUI4P8NWLfo1lZ+73QlHkfHcGCjgAdMH75QabomPqk4k7
         8QsQ==
X-Gm-Message-State: AOAM530Ly6AedEnCbT2PhjLXXfQ9HHn05eDYAexAuq9OyovFqrsIKyZT
        eS9GDLex0WlIj0+3bJbxCZE=
X-Google-Smtp-Source: ABdhPJzKKzuOZ953BF0u4QVx3G927Bzn2sz1T21uKit3CoAGs+d3hNub8IdCnSzu8tpDYL4lalNNnA==
X-Received: by 2002:a1c:7213:: with SMTP id n19mr19640599wmc.88.1589810396564;
        Mon, 18 May 2020 06:59:56 -0700 (PDT)
Received: from localhost.localdomain ([2a01:598:b884:8d4:84ab:c471:b6eb:fcab])
        by smtp.gmail.com with ESMTPSA id 81sm18114519wme.16.2020.05.18.06.59.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 18 May 2020 06:59:55 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        s.hauer@pengutronix.de, boris.brezillon@collabora.com,
        derosier@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        huobean@gmail.com, Bean Huo <beanhuo@micron.com>
Subject: [PATCH v4 0/5] Micron SLC NAND filling block
Date:   Mon, 18 May 2020 15:59:38 +0200
Message-Id: <20200518135943.11749-1-huobean@gmail.com>
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

v3 - v4:
    1. In the patch 4/5, change to directly use ecc.strength to judge the page
       is a empty page or not, rather than max_bitflips < mtd->bitflip_threshold
    2. In the patch 5/5, for the powerloss case, from the next time boot up,
       lots of page will be programmed from >page15 address, if still using
       first_p as GENMASK() bitmask starting position, writtenp will be always 0,
       fix it by changing its bitmask starting at bit position 0.

v2 - v3:
    1. Rebase patch to the latest MTD git tree
    2. Add a record that keeps tracking the programmed pages in the first 16
       pages
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
 drivers/mtd/nand/raw/nand_base.c     |  88 +++++++++++++++++++----
 drivers/mtd/nand/raw/nand_hynix.c    |   2 +-
 drivers/mtd/nand/raw/nand_macronix.c |  10 +--
 drivers/mtd/nand/raw/nand_micron.c   | 104 ++++++++++++++++++++++++++-
 include/linux/mtd/rawnand.h          |  40 +++++++----
 6 files changed, 212 insertions(+), 35 deletions(-)

-- 
2.17.1

