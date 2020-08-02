Return-Path: <SRS0=HA/2=BM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9A0FC433DF
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 19:17:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABA1420759
	for <linux-kernel@archiver.kernel.org>; Sun,  2 Aug 2020 19:17:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727109AbgHBTRY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 2 Aug 2020 15:17:24 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:58670 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726807AbgHBTRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 2 Aug 2020 15:17:24 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 1AC0561D8AB3;
        Sun,  2 Aug 2020 21:17:22 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id euIn5lnh-NeA; Sun,  2 Aug 2020 21:17:21 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id A674B61D8A8B;
        Sun,  2 Aug 2020 21:17:21 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id NR3dkTOCafhq; Sun,  2 Aug 2020 21:17:21 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id 7BDF96071A7C;
        Sun,  2 Aug 2020 21:17:21 +0200 (CEST)
Date:   Sun, 2 Aug 2020 21:17:21 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd <linux-mtd@lists.infradead.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        miquel.raynal@bootlin.com, vigneshr@ti.com
Message-ID: <1401520472.201470.1596395841386.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] MTD fixes for 5.8 final
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF78 (Linux)/8.8.12_GA_3809)
Thread-Index: YSIOvvqeeCjsUO5zcWYbwcKUq1Gp2w==
Thread-Topic: MTD fixes for 5.8 final
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

sorry for the late PR, feel free to postpone it into the merge window.

The following changes since commit d15be546031cf65a0fc34879beca02fd90fe7ac7:

  Merge tag 'media/v5.8-3' of git://git.kernel.org/pub/scm/linux/kernel/git/mchehab/linux-media into master (2020-07-22 11:56:00 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/mtd/linux.git mtd/fixes

for you to fetch changes up to f7e6b19bc76471ba03725fe58e0c218a3d6266c3:

  mtd: properly check all write ioctls for permissions (2020-07-24 23:03:11 +0200)

----------------------------------------------------------------
Greg Kroah-Hartman (1):
      mtd: properly check all write ioctls for permissions

 drivers/mtd/mtdchar.c | 56 ++++++++++++++++++++++++++++++++++++++++++---------
 1 file changed, 47 insertions(+), 9 deletions(-)
