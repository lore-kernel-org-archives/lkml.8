Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 51DBCC2D0EF
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2F13F2083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726409AbgDQQ1t (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:27:49 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:48572 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgDQQ1t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:27:49 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id E4F1A62257AA;
        Fri, 17 Apr 2020 18:27:46 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id YVCGKo5g5DOz; Fri, 17 Apr 2020 18:27:46 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 9476A6071984;
        Fri, 17 Apr 2020 18:27:46 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id HHZtM56eztDD; Fri, 17 Apr 2020 18:27:46 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 6D99D62257AA;
        Fri, 17 Apr 2020 18:27:46 +0200 (CEST)
Date:   Fri, 17 Apr 2020 18:27:46 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     Vignesh Raghavendra <vigneshr@ti.com>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
Message-ID: <58708601.124954.1587140866342.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] mtd: Fixes for v5.7-rc2
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Index: irTsH3FwllL7Ihdu9v+epoS5YJpdrg==
Thread-Topic: Fixes for v5.7-rc2
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit c0cc271173b2e1c2d8d0ceaef14e4dfa79eefc0d:

  Merge tag 'modules-for-v5.7' of git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux (2020-04-09 12:52:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git tags/mtd/fixes-for-5.7-rc2

for you to fetch changes up to 2098c564701c0dde76063dd9c5c00a7a1f173541:

  mtd: spi-nor: Compile files in controllers/ directory (2020-04-09 22:00:13 +0200)

----------------------------------------------------------------
SPI-NOR:

* Fix for missing directory after code refactoring

----------------------------------------------------------------
Guenter Roeck (1):
      mtd: spi-nor: Compile files in controllers/ directory

 drivers/mtd/spi-nor/Makefile | 2 ++
 1 file changed, 2 insertions(+)
