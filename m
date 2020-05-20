Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64883C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:49:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 41CD2207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:49:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgETTto (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 15:49:44 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:42594 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgETTtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 15:49:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 2A69E609D2FA;
        Wed, 20 May 2020 21:49:40 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id B_oiLUskh1rM; Wed, 20 May 2020 21:49:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id DB8C0609D2CC;
        Wed, 20 May 2020 21:49:39 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HB01SdQYLnl2; Wed, 20 May 2020 21:49:39 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id BEA53623A7C5;
        Wed, 20 May 2020 21:49:39 +0200 (CEST)
Date:   Wed, 20 May 2020 21:49:39 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     miquel.raynal@bootlin.com, vigneshr@ti.com,
        linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <1270319593.249344.1590004179760.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] MTD fixes for 5.7 final
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Index: zzLpiIOUyD076SaYCqVKbuiKIraQlg==
Thread-Topic: MTD fixes for 5.7 final
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 9b1f2cbdb6d3062c468d3f9b579501f0f7ce330b:

  Merge tag 'clk-fixes-for-linus' of git://git.kernel.org/pub/scm/linux/kernel/git/clk/linux (2020-05-17 12:33:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/fixes-for-5.7-rc6

for you to fetch changes up to f3a6a6c5e0f5a303fd8ec84ea33c0da5869d715f:

  mtd:rawnand: brcmnand: Fix PM resume crash (2020-05-19 10:24:49 +0200)

----------------------------------------------------------------
This pull request contains the following bug fixes for MTD:

- Fix a PM regression in brcmnand driver
- Propagate ECC information correctly on SPI-NAND
- Make sure no MTD name is used multiple time in nvmem

----------------------------------------------------------------
Kamal Dasu (1):
      mtd:rawnand: brcmnand: Fix PM resume crash

Miquel Raynal (1):
      mtd: spinand: Propagate ECC information to the MTD structure

Ricardo Ribalda Delgado (1):
      mtd: Fix mtd not registered due to nvmem name collision

 drivers/mtd/mtdcore.c                    | 2 +-
 drivers/mtd/nand/raw/brcmnand/brcmnand.c | 3 +--
 drivers/mtd/nand/spi/core.c              | 4 ++++
 3 files changed, 6 insertions(+), 3 deletions(-)
