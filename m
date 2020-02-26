Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AC42C4BA21
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:25:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D901824653
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 22:25:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=embeddedor.com header.i=@embeddedor.com header.b="j6tNkmTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgBZWZT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 17:25:19 -0500
Received: from gateway20.websitewelcome.com ([192.185.45.27]:29041 "EHLO
        gateway20.websitewelcome.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727709AbgBZWZT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 17:25:19 -0500
Received: from cm13.websitewelcome.com (cm13.websitewelcome.com [100.42.49.6])
        by gateway20.websitewelcome.com (Postfix) with ESMTP id 1C2F3400C6FC4
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 15:10:57 -0600 (CST)
Received: from gator4166.hostgator.com ([108.167.133.22])
        by cmsmtp with SMTP
        id 757FjaAOxRP4z757FjystX; Wed, 26 Feb 2020 16:25:17 -0600
X-Authority-Reason: nr=8
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=embeddedor.com; s=default; h=Content-Type:MIME-Version:Message-ID:Subject:
        Cc:To:From:Date:Sender:Reply-To:Content-Transfer-Encoding:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:In-Reply-To:References:List-Id:List-Help:List-Unsubscribe:
        List-Subscribe:List-Post:List-Owner:List-Archive;
        bh=RglIhNKe9o3UQdqr70qs4toIodilo8e4AyccNifDDhg=; b=j6tNkmTKdi+KNfcv3JQnjCHx31
        pe6sjGT5wtfo98lm/ZAeFDxsi4cjUK0uyRCxVLwy/ZpoQ8d6a1a1vlSJUh9/CEc8KucBQd1/rk+WZ
        zNtIGWedbmfjyUh0xyfgkQxrwgjxoO/9wHaGXAfZVJZTcVyQ6AU49O5xr/5hiuhhVgEJ3l1DOZ+zj
        wo6LzJISuM/Aj+yYP6MqCw5rSiDSxEuLD2MUCkajNLQorl27IeDOrvRhvwhXldAMgeo9020uiXCVK
        ioVRL6WUQLEVmmBQiqoRbib2R9a4ug8ou4/rCpsPON2Mjy5osCHcXDcu9fn0mAhjJHJmpaQ5LNpOZ
        Eenij2DQ==;
Received: from [200.39.29.168] (port=50390 helo=embeddedor)
        by gator4166.hostgator.com with esmtpa (Exim 4.92)
        (envelope-from <gustavo@embeddedor.com>)
        id 1j757C-001KJu-D2; Wed, 26 Feb 2020 16:25:15 -0600
Date:   Wed, 26 Feb 2020 16:27:22 -0600
From:   "Gustavo A. R. Silva" <gustavo@embeddedor.com>
To:     Masahiro Yamada <yamada.masahiro@socionext.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Liang Yang <liang.yang@amlogic.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Xiaolei Li <xiaolei.li@mediatek.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Maxime Ripard <mripard@kernel.org>,
        Chen-Yu Tsai <wens@csie.org>
Cc:     linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-amlogic@lists.infradead.org,
        linux-mediatek@lists.infradead.org,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>
Subject: [PATCH] mtd: rawnand: Replace zero-length array with flexible-array
 member
Message-ID: <20200226222722.GA18020@embeddedor>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
User-Agent: Mutt/1.9.4 (2018-02-28)
X-AntiAbuse: This header was added to track abuse, please include it with any abuse report
X-AntiAbuse: Primary Hostname - gator4166.hostgator.com
X-AntiAbuse: Original Domain - vger.kernel.org
X-AntiAbuse: Originator/Caller UID/GID - [47 12] / [47 12]
X-AntiAbuse: Sender Address Domain - embeddedor.com
X-BWhitelist: no
X-Source-IP: 200.39.29.168
X-Source-L: No
X-Exim-ID: 1j757C-001KJu-D2
X-Source: 
X-Source-Args: 
X-Source-Dir: 
X-Source-Sender: (embeddedor) [200.39.29.168]:50390
X-Source-Auth: gustavo@embeddedor.com
X-Email-Count: 22
X-Source-Cap: Z3V6aWRpbmU7Z3V6aWRpbmU7Z2F0b3I0MTY2Lmhvc3RnYXRvci5jb20=
X-Local-Domain: yes
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The current codebase makes use of the zero-length array language
extension to the C90 standard, but the preferred mechanism to declare
variable-length types such as these ones is a flexible array member[1][2],
introduced in C99:

struct foo {
        int stuff;
        struct boo array[];
};

By making use of the mechanism above, we will get a compiler warning
in case the flexible array does not occur last in the structure, which
will help us prevent some kind of undefined behavior bugs from being
inadvertently introduced[3] to the codebase from now on.

Also, notice that, dynamic memory allocations won't be affected by
this change:

"Flexible array members have incomplete type, and so the sizeof operator
may not be applied. As a quirk of the original implementation of
zero-length arrays, sizeof evaluates to zero."[1]

This issue was found with the help of Coccinelle.

[1] https://gcc.gnu.org/onlinedocs/gcc/Zero-Length.html
[2] https://github.com/KSPP/linux/issues/21
[3] commit 76497732932f ("cxgb3/l2t: Fix undefined behaviour")

Signed-off-by: Gustavo A. R. Silva <gustavo@embeddedor.com>
---
 drivers/mtd/nand/raw/denali.h       | 2 +-
 drivers/mtd/nand/raw/marvell_nand.c | 2 +-
 drivers/mtd/nand/raw/meson_nand.c   | 2 +-
 drivers/mtd/nand/raw/mtk_nand.c     | 2 +-
 drivers/mtd/nand/raw/nand_hynix.c   | 2 +-
 drivers/mtd/nand/raw/sunxi_nand.c   | 2 +-
 6 files changed, 6 insertions(+), 6 deletions(-)

diff --git a/drivers/mtd/nand/raw/denali.h b/drivers/mtd/nand/raw/denali.h
index e5cdcda56d14..ac46eb7956ce 100644
--- a/drivers/mtd/nand/raw/denali.h
+++ b/drivers/mtd/nand/raw/denali.h
@@ -328,7 +328,7 @@ struct denali_chip {
 	struct nand_chip chip;
 	struct list_head node;
 	unsigned int nsels;
-	struct denali_chip_sel sels[0];
+	struct denali_chip_sel sels[];
 };
 
 /**
diff --git a/drivers/mtd/nand/raw/marvell_nand.c b/drivers/mtd/nand/raw/marvell_nand.c
index fb5abdcfb007..7082bef1c8a7 100644
--- a/drivers/mtd/nand/raw/marvell_nand.c
+++ b/drivers/mtd/nand/raw/marvell_nand.c
@@ -334,7 +334,7 @@ struct marvell_nand_chip {
 	int addr_cyc;
 	int selected_die;
 	unsigned int nsels;
-	struct marvell_nand_chip_sel sels[0];
+	struct marvell_nand_chip_sel sels[];
 };
 
 static inline struct marvell_nand_chip *to_marvell_nand(struct nand_chip *chip)
diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index 9f17b5b8efbf..f6fb5c0e6255 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -118,7 +118,7 @@ struct meson_nfc_nand_chip {
 	u8 *data_buf;
 	__le64 *info_buf;
 	u32 nsels;
-	u8 sels[0];
+	u8 sels[];
 };
 
 struct meson_nand_ecc {
diff --git a/drivers/mtd/nand/raw/mtk_nand.c b/drivers/mtd/nand/raw/mtk_nand.c
index b8305e39ab51..ef149e8b26d0 100644
--- a/drivers/mtd/nand/raw/mtk_nand.c
+++ b/drivers/mtd/nand/raw/mtk_nand.c
@@ -131,7 +131,7 @@ struct mtk_nfc_nand_chip {
 	u32 spare_per_sector;
 
 	int nsels;
-	u8 sels[0];
+	u8 sels[];
 	/* nothing after this field */
 };
 
diff --git a/drivers/mtd/nand/raw/nand_hynix.c b/drivers/mtd/nand/raw/nand_hynix.c
index 194e4227aefe..7caedaa5b9e5 100644
--- a/drivers/mtd/nand/raw/nand_hynix.c
+++ b/drivers/mtd/nand/raw/nand_hynix.c
@@ -26,7 +26,7 @@
 struct hynix_read_retry {
 	int nregs;
 	const u8 *regs;
-	u8 values[0];
+	u8 values[];
 };
 
 /**
diff --git a/drivers/mtd/nand/raw/sunxi_nand.c b/drivers/mtd/nand/raw/sunxi_nand.c
index 37a4ac0dd85b..6ede3934a5f4 100644
--- a/drivers/mtd/nand/raw/sunxi_nand.c
+++ b/drivers/mtd/nand/raw/sunxi_nand.c
@@ -195,7 +195,7 @@ struct sunxi_nand_chip {
 	u32 timing_cfg;
 	u32 timing_ctl;
 	int nsels;
-	struct sunxi_nand_chip_sel sels[0];
+	struct sunxi_nand_chip_sel sels[];
 };
 
 static inline struct sunxi_nand_chip *to_sunxi_nand(struct nand_chip *nand)
-- 
2.25.0

