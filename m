Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36DC2C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 12:18:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D7A82073B
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 12:18:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MbVfr7Mr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390515AbgEYMSa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 08:18:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54052 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390196AbgEYMS3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 08:18:29 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DA51C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 05:18:29 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id u188so16482516wmu.1
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 05:18:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id;
        bh=7o+lBWeHtPJY1L0YtKPVz2MqPUZpsoWKhePxIs0CqiI=;
        b=MbVfr7MrXvBV5N80SFzd2eQYB/pkfICrxxEfMysOmJN67ykUDmZ6bpSUaHadGpBbdO
         19xNFQkfG0F/EriJO6/ry3wDRO5Ap5Y6AlmXAG49iNxedgS0Iz1+3gK8CY2XX/ppZUSz
         RgREvlnYzbQo/y6b4EK91m8RuTc1d80aTclU0sJfS0xmu200uSFXnCXciS7YUP9qtTbg
         Z/rQXJ3TTcY7vYWMLzf4jbHWssPTSJSD34O/YTrzTEEGNGE6ltH/aO6Ba6Vb6bO+eF/B
         A99tsG5gYs/zjqxc8rchS2FlbucZ2tdlwVQewQo970NtCn3QLWJ4xnrQbBaEzoIacWR1
         jaaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id;
        bh=7o+lBWeHtPJY1L0YtKPVz2MqPUZpsoWKhePxIs0CqiI=;
        b=oHANsRS6hyVwiruz586Lrd7hssdMJn/I/15F5NSQMxI6AKLFz3rAt+jjBWlIPmOC6I
         zaSKPfdLGJDF3tvKzJw3CoPRporyTkx4iNLxpee80bBQsNNhLR+0aWGL4/SMX2H71aHT
         88ERyD9PCAhPfi4TrCRJHY4bpstikLP1j+ojBbLotlTIXw8Tdt5rM85YA+rkzXdMJgPw
         vSX+U8q2yChJF/eBgNnGDpXuxsAGIpt5K26Oe4xPD3Hi2084hUAQoQ9JSt3B7wujKTND
         U6O+uOCBM1QpFWYfUzfN7SDvVySlnGOotvh5zOxP8ZLbCaG4aHTy96qh5LataEH/VCwg
         A3GQ==
X-Gm-Message-State: AOAM530kUapNOLLNZ5YnKFWjYPqY0fsrGzXHm8VvavAJENG5k73dLVDn
        rR8C+iLxyNP/LjJy9+Ud+gg=
X-Google-Smtp-Source: ABdhPJy7pbFO73FzMiOp6qJbFO6JT0WJYrjBOJQOBGLomMGz8xNQri52lKtcpDMPk8VFljekvgxxIw==
X-Received: by 2002:a05:600c:48e:: with SMTP id d14mr8876912wme.133.1590409107994;
        Mon, 25 May 2020 05:18:27 -0700 (PDT)
Received: from ubuntu-G3.micron.com ([165.225.203.62])
        by smtp.gmail.com with ESMTPSA id 10sm18136635wmw.26.2020.05.25.05.18.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 25 May 2020 05:18:27 -0700 (PDT)
From:   Bean Huo <huobean@gmail.com>
To:     miquel.raynal@bootlin.com, richard@nod.at, vigneshr@ti.com,
        s.hauer@pengutronix.de, boris.brezillon@collabora.com,
        derosier@gmail.com
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        huobean@gmail.com, Bean Huo <beanhuo@micron.com>
Subject: [PATCH v6 0/5] Micron SLC NAND filling block
Date:   Mon, 25 May 2020 14:18:08 +0200
Message-Id: <20200525121814.31934-1-huobean@gmail.com>
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

v5 - v6:
    1. Fix a misleading-indentation in patch 5/5
       (Reported-by: kbuild test robot <lkp@intel.com>)
    2. Rebase patch to
       git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git nand/next
v4 - v5:
    1. Add Miquel Raynal Authorship and SoB in 4/5 and 5/5 (Miquel Raynal)
    2. Change  commit message in 5/5. (Steve deRosier)
    3. delete unused variable max_bitflips in 4/5
v3 - v4:
    1. In the patch 4/5, change to directly use ecc.strength to judge the page
       is a empty page or not, rather than max_bitflips < mtd->bitflip_threshold
    2. In the patch 5/5, for the powerloss case, from the next time boot up,
       lots of page will be programmed from >page15 address, if still using
       first_p as GENMASK() bitmask starting position, writtenp will be always 0.
       fix it by changing its bitmask starting at bit position 0.
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

Bean Huo (3):
  mtd: rawnand: group all NAND specific ops into new nand_chip_ops
  mtd: rawnand: Add {pre,post}_erase hooks in nand_chip_ops
  mtd: rawnand: Introduce a new function nand_check_is_erased_page()

Miquel Raynal (2):
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

