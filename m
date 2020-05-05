Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70D9DC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:02:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5C15320661
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729281AbgEEOB7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:01:59 -0400
Received: from mout.kundenserver.de ([212.227.17.24]:57481 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729264AbgEEOB5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:01:57 -0400
Received: from localhost.localdomain ([149.172.19.189]) by
 mrelayeu.kundenserver.de (mreue106 [212.227.15.145]) with ESMTPA (Nemesis) id
 1MuDsZ-1jHTUl1QxZ-00uWRX; Tue, 05 May 2020 16:01:38 +0200
From:   Arnd Bergmann <arnd@arndb.de>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Vincenzo Aliberti <vincenzo.aliberti@gmail.com>,
        Brian Norris <computersforpeace@gmail.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Richard Fontana <rfontana@redhat.com>,
        linux-mtd@lists.infradead.org, linux-kernel@vger.kernel.org,
        clang-built-linux@googlegroups.com
Subject: [PATCH] mtd: lpddr: fix excessive stack usage with clang
Date:   Tue,  5 May 2020 16:01:16 +0200
Message-Id: <20200505140136.263461-1-arnd@arndb.de>
X-Mailer: git-send-email 2.26.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Provags-ID: V03:K1:iaIPMXhwT+Ozi6/EpaDCzPQ6tOZ0YRFJlPmWlpkMXIOGy4GtadE
 2Z+LvOLt48OWBL8tlphxtGjgLmEv5xt9TTGL54IbLKq9dBjrTyohtYUyJgkuQXyGFBJuxzc
 6osWPaVYP906+AjTqqJo7C8bulY+GI4nc8qQYAYy/TF4rtBahP77hmt5uWz15rbdppHrlZ1
 d2CaYJdcLUkSTeHBRS/3Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:ZKEdyWcVvbU=:zYkDpW+KkqOFvxVL4/YtNm
 9RlRgywDUlI6jWeDBe9CgT6v4zfsrTYQx9nUJBpcgMa1WwlbhNH+MYM8vGwR6zecGtm/xoqH2
 GsLnyQytBgbIyv6dibT0Un4WucwiF1kgU2Dw2cCbkBmHF2tjhxBI1lsyZZcEiBD09JW539gOy
 B2DwwiGt1ARK+9SXIGsEAEh/R4IhX9XWgvR3/35YJc0+0NiOXuEevJPbDmMS8WNwc0iKCO9C5
 6QhAnXFNVGfRuDv5FZGzYGq1d8Yf1MgAJpylYydDSflY3PSaUuIBavOTvq+0YJ+4Uhj/SO49J
 UBhgVHGa/th64j4rCrhZ2puCZZRSXmLFg1gurJYVTVUbMWxbdPeywDtaNPLrkjcuNRPCPbGDs
 vahrHJP9tGpIZDhp3cTatj9www2/VrSG9bezmcdCY3Y6Gjra81B5tzJi+z2tAejKO1bdoA3eI
 e1kEvWTFqJEkgRbRM3yBGP/J8iEEZH65eUbaVpoZk+AGWV4nGA6/ZWhMSlWD7yqcsssVz2ptK
 B7gazvUT31WlAJwYWPU9u7mwAGttdJvPMtZF7g0bblT46ydiDoBAVjVhqi7sZa7slRw+3fZsC
 WRAE6KxqjAB8rH2pGfvGJnmF7UWlfIQdNI1mjjmhWNhm7ICV+BONcVnpj9zM6Xc1kYGTTGl7x
 sJAk9yh9Fs1AaW+O1fOfFjnW2ApxftOdLkAAFVc8y0JbZUhaNykwjJcIwTo/dL10KVPoOT+pO
 shuX5bITpPs9W9S0y3YkJIJTkHW4N90ZNkF2DuTyr5DP1JtiKLCL85NbGDKIEN+S/a35DRqdA
 T2TdfwELWOQHqK+OeflGC5Bo4P0y9AgaidrVeSz5sZp+KV3yWk=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Building lpddr2_nvm with clang can result in a giant stack usage
in one function:

drivers/mtd/lpddr/lpddr2_nvm.c:399:12: error: stack frame size of 1144 bytes in function 'lpddr2_nvm_probe' [-Werror,-Wframe-larger-than=]

The problem is that clang decides to build a copy of the mtd_info
structure on the stack and then do a memcpy() into the actual version. It
shouldn't really do it that way, but it's not strictly a bug either.

As a workaround, use a static const version of the structure to assign
most of the members upfront and then only set the few members that
require runtime knowledge at probe time.

Fixes: 96ba9dd65788 ("mtd: lpddr: add driver for LPDDR2-NVM PCM memories")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 drivers/mtd/lpddr/lpddr2_nvm.c | 35 ++++++++++++++++++----------------
 1 file changed, 19 insertions(+), 16 deletions(-)

diff --git a/drivers/mtd/lpddr/lpddr2_nvm.c b/drivers/mtd/lpddr/lpddr2_nvm.c
index 0f1547f09d08..72f5c7b30079 100644
--- a/drivers/mtd/lpddr/lpddr2_nvm.c
+++ b/drivers/mtd/lpddr/lpddr2_nvm.c
@@ -393,6 +393,17 @@ static int lpddr2_nvm_lock(struct mtd_info *mtd, loff_t start_add,
 	return lpddr2_nvm_do_block_op(mtd, start_add, len, LPDDR2_NVM_LOCK);
 }
 
+static const struct mtd_info lpddr2_nvm_mtd_info = {
+	.type		= MTD_RAM,
+	.writesize	= 1,
+	.flags		= (MTD_CAP_NVRAM | MTD_POWERUP_LOCK),
+	._read		= lpddr2_nvm_read,
+	._write		= lpddr2_nvm_write,
+	._erase		= lpddr2_nvm_erase,
+	._unlock	= lpddr2_nvm_unlock,
+	._lock		= lpddr2_nvm_lock,
+};
+
 /*
  * lpddr2_nvm driver probe method
  */
@@ -433,6 +444,7 @@ static int lpddr2_nvm_probe(struct platform_device *pdev)
 		.pfow_base	= OW_BASE_ADDRESS,
 		.fldrv_priv	= pcm_data,
 	};
+
 	if (IS_ERR(map->virt))
 		return PTR_ERR(map->virt);
 
@@ -444,22 +456,13 @@ static int lpddr2_nvm_probe(struct platform_device *pdev)
 		return PTR_ERR(pcm_data->ctl_regs);
 
 	/* Populate mtd_info data structure */
-	*mtd = (struct mtd_info) {
-		.dev		= { .parent = &pdev->dev },
-		.name		= pdev->dev.init_name,
-		.type		= MTD_RAM,
-		.priv		= map,
-		.size		= resource_size(add_range),
-		.erasesize	= ERASE_BLOCKSIZE * pcm_data->bus_width,
-		.writesize	= 1,
-		.writebufsize	= WRITE_BUFFSIZE * pcm_data->bus_width,
-		.flags		= (MTD_CAP_NVRAM | MTD_POWERUP_LOCK),
-		._read		= lpddr2_nvm_read,
-		._write		= lpddr2_nvm_write,
-		._erase		= lpddr2_nvm_erase,
-		._unlock	= lpddr2_nvm_unlock,
-		._lock		= lpddr2_nvm_lock,
-	};
+	*mtd = lpddr2_nvm_mtd_info;
+	mtd->dev.parent		= &pdev->dev;
+	mtd->name		= pdev->dev.init_name;
+	mtd->priv		= map;
+	mtd->size		= resource_size(add_range);
+	mtd->erasesize		= ERASE_BLOCKSIZE * pcm_data->bus_width;
+	mtd->writebufsize	= WRITE_BUFFSIZE * pcm_data->bus_width;
 
 	/* Verify the presence of the device looking for PFOW string */
 	if (!lpddr2_nvm_pfow_present(map)) {
-- 
2.26.0

