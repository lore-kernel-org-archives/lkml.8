Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19D10C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:49:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DE868207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:49:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727830AbgETTtn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 15:49:43 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:42574 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726823AbgETTtl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 15:49:41 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 3F1E3623A7CB;
        Wed, 20 May 2020 21:49:39 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id FIdXJt4u6WJt; Wed, 20 May 2020 21:49:39 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id ED657623A7C5;
        Wed, 20 May 2020 21:49:38 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id q_X3_oYRrh_y; Wed, 20 May 2020 21:49:38 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id D9BCF623A7CB;
        Wed, 20 May 2020 21:49:38 +0200 (CEST)
Date:   Wed, 20 May 2020 21:49:38 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-mtd <linux-mtd@lists.infradead.org>
Message-ID: <294087931.249343.1590004178869.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UBI/UBIFS fixes for 5.7 final
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Index: IIwsIXTW2IYy/sC4AclDYRhuEBVl8Q==
Thread-Topic: UBI/UBIFS fixes for 5.7 final
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit c0cc271173b2e1c2d8d0ceaef14e4dfa79eefc0d:

  Merge tag 'modules-for-v5.7' of git://git.kernel.org/pub/scm/linux/kernel/git/jeyu/linux (2020-04-09 12:52:34 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/for-linus-5.7-rc6

for you to fetch changes up to 0e7572cffe442290c347e779bf8bd4306bb0aa7c:

  ubi: Fix seq_file usage in detailed_erase_block_info debugfs file (2020-05-17 23:38:21 +0200)

----------------------------------------------------------------
This pull request contains the following bug fixes for UBI and UBIFS:

- Correctly set next cursor for detailed_erase_block_info debugfs file
- Don't use crypto_shash_descsize() for digest size in UBIFS
- Remove broken lazytime support from UBIFS

----------------------------------------------------------------
Christoph Hellwig (1):
      ubifs: remove broken lazytime support

Eric Biggers (1):
      ubifs: fix wrong use of crypto_shash_descsize()

Richard Weinberger (1):
      ubi: Fix seq_file usage in detailed_erase_block_info debugfs file

 drivers/mtd/ubi/debug.c | 12 ++----------
 fs/ubifs/auth.c         | 17 ++++-------------
 fs/ubifs/file.c         |  6 +-----
 fs/ubifs/replay.c       | 13 ++-----------
 4 files changed, 9 insertions(+), 39 deletions(-)
