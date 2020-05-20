Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1FA5DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:49:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DCFF0207D8
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 19:49:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727040AbgETTtk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 15:49:40 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:42552 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726754AbgETTtj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 15:49:39 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 5B045623A7A4;
        Wed, 20 May 2020 21:49:37 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id TH9rs0QSko1X; Wed, 20 May 2020 21:49:37 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 07759623A7CB;
        Wed, 20 May 2020 21:49:37 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id 8HTSTKpM1ZAC; Wed, 20 May 2020 21:49:36 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id DD072623A7A4;
        Wed, 20 May 2020 21:49:36 +0200 (CEST)
Date:   Wed, 20 May 2020 21:49:36 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Message-ID: <1547930539.249342.1590004176796.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML fixes for 5.7 final
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Index: 7oeqR7ADUshtFLOz07bQL7e19w9UfQ==
Thread-Topic: UML fixes for 5.7 final
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 1d2cc5ac6f6668cc15216d51051103c61467d7e8:

  Merge tag 'riscv-for-linus-5.7-rc4' of git://git.kernel.org/pub/scm/linux/kernel/git/riscv/linux (2020-04-29 09:25:32 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.7-rc6

for you to fetch changes up to 2e27d33d22afa3d12746f854d6a4fad7ad7b86de:

  um: Fix typo in vector driver transport option definition (2020-04-29 21:22:15 +0200)

----------------------------------------------------------------
This pull request contains the following bug fixes for UML:

- Two missing includes which cause build issues on recent systems
- Correctly set TRANS_GRE_LEN in our vector network driver

----------------------------------------------------------------
Ignat Korchagin (1):
      um: Fix typo in vector driver transport option definition

Johannes Berg (2):
      um: Fix xor.h include
      um: syscall.c: include <asm/unistd.h>

 arch/um/drivers/vector_user.h | 2 +-
 arch/um/include/asm/xor.h     | 2 +-
 arch/um/kernel/skas/syscall.c | 1 +
 3 files changed, 3 insertions(+), 2 deletions(-)
