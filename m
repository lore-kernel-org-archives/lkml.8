Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5591EC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:05:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CC0E206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 10:05:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="IN2GdLWu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728565AbgESKFW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 06:05:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726466AbgESKFW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 06:05:22 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE468C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 03:05:21 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id z4so2424118wmi.2
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 03:05:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=ZDJEthhWgY5wAb8g4sO5kbhswhHVWOPQX9uJ2zkl5tU=;
        b=IN2GdLWuNUNLyyNTO3iaOpDYw5MKV1g3T1zBA8FqWfkLDL2e5D+hWE0vRzPzAzIT4g
         C7G/mNUBoetozevkStq0VqG7bg0HqpihDLSHd048ut/IqjkKh45u1JoDGX3yQ0drsCoF
         4qzBPZpexi311B3RwsNNQ55mti8t+p4rlSp4i3H9xFqRJ5s9lvEmPBq2EETCrcIKrcPw
         VOc+Z0mGn2jsFUH4WWbrcfzbAfWLJ71jmm7ljNTfV/Twr00rLi/vynryPEFTJd0UhU5Z
         sRnGKvAIWMSEfTRG2KEH7z/yyAhQKiytIE4PMiNoWFn1izpQYkrhFGtMcDSXTbJZcwX0
         Fm/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=ZDJEthhWgY5wAb8g4sO5kbhswhHVWOPQX9uJ2zkl5tU=;
        b=L1mVmcRXKRsmw7BUSL1QoQv8aVoTOzvLHRRcdkOz9el5KkABz0IsIukGxUy+UgvJG5
         3YGHx58BfJqFxpXKPzuRx/tv0kunsPnqYO+8genUbOxhAXjYazWdcegyOC9+cdDPRPph
         DmFXgwf+bBWfQsNGjyyAcy01ZX6VNjL1yVBE491qqPDWfN3+5iBwP1GpRKYRreDC2e3u
         IMRymHzWqHGut25ULOyUHK59aSNzmvn5l8ntqDXieEMzxXsFI9hW2ImAsTOLh5h8t9ib
         Xxp2IuWqXC7c52j7pma9EOMVzkfCaENtQ8Q80eiyJO5YeFLY2B4ID0K33h0/WEs/i8Ra
         CjJQ==
X-Gm-Message-State: AOAM532yKNzhlEgzp0xjAPOdUHD7ll7e8wXdXTvT/TOYf+Qu6rWk/t18
        2V9Y1pHtbNm74o74oars1yU=
X-Google-Smtp-Source: ABdhPJyTQM4/8f04kiQtCEUDxu72rmNzbKQRKo70umDUp4K1L0E0CogjFDWchr6GuEbTQid3KWXHrw==
X-Received: by 2002:a1c:7305:: with SMTP id d5mr4716773wmb.85.1589882720420;
        Tue, 19 May 2020 03:05:20 -0700 (PDT)
Received: from ubuntu-G3.micron.com ([165.225.86.140])
        by smtp.gmail.com with ESMTPSA id b18sm19968008wrn.82.2020.05.19.03.05.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 03:05:19 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        s.hauer@pengutronix.de, boris.brezillon@collabora.com,
        derosier@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        huobean@gmail.com, Bean Huo <beanhuo@micron.com>
Subject: [PATCH v5 0/5] Micron SLC NAND filling block
Date:   Tue, 19 May 2020 12:05:02 +0200
Message-Id: <20200519100507.19323-1-huobean@gmail.com>
X-Mailer: git-send-email 2.17.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Bean Huo <beanhuo@micron.com>

Hi,
On planar 2D Micron NAND devices when a block erase command is issued,
occasionally even though a block erase operation completes and returns a pass
status, the flash block may not be completely erased. Subsequent operations to
this block on very rare cases can result in subtle failures or corruption. These
extremely rare cases should nevertheless be considered. This patchset is to
address this potential issue.

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
v4 - v5:
    1. Add Miquel Raynal Authorship and SoB in 4/5 and 5/5 (Miquel Raynal)
    2. Change  commit message in 5/5. (Steve deRosier)
    3. Delete unused variable max_bitflips in 4/5

v3 - v4:
    1. In the patch 4/5, change to directly use ecc.strength to judge the page
       is a empty page or not, rather than max_bitflips < mtd->bitflip_threshold
    2. In the patch 5/5, for the powerloss case, from the next time boot up,
       lots of page will be programmed from >page15 address, if still using
       first_p as GENMASK() bitmask starting position, writtenp will be always 0

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

Bean Huo (3):
  mtd: rawnand: group all NAND specific ops into new nand_chip_ops
  mtd: rawnand: Add {pre,post}_erase hooks in nand_chip_ops
  mtd: rawnand: Introduce a new function nand_check_is_erased_page()
Miquel Raynal (2)
  mtd: rawnand: Add write_oob hook in nand_chip_ops
  mtd: rawnand: micron: Micron SLC NAND filling block

 drivers/mtd/nand/raw/internals.h     |   3 +-
 drivers/mtd/nand/raw/nand_base.c     |  87 ++++++++++++++++++----
 drivers/mtd/nand/raw/nand_hynix.c    |   2 +-
 drivers/mtd/nand/raw/nand_macronix.c |  10 +--
 drivers/mtd/nand/raw/nand_micron.c   | 104 ++++++++++++++++++++++++++-
 include/linux/mtd/rawnand.h          |  40 +++++++----
 6 files changed, 211 insertions(+), 35 deletions(-)

-- 
2.17.1

