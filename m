Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.8 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0C153C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 21:02:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4CA720734
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 21:02:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726942AbgFIVB7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 9 Jun 2020 17:01:59 -0400
Received: from lithops.sigma-star.at ([195.201.40.130]:44168 "EHLO
        lithops.sigma-star.at" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726428AbgFIVBy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 9 Jun 2020 17:01:54 -0400
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 81B1F607400D;
        Tue,  9 Jun 2020 23:01:51 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10032)
        with ESMTP id SM50kajbXWN9; Tue,  9 Jun 2020 23:01:51 +0200 (CEST)
Received: from localhost (localhost [127.0.0.1])
        by lithops.sigma-star.at (Postfix) with ESMTP id 25BB36074010;
        Tue,  9 Jun 2020 23:01:51 +0200 (CEST)
Received: from lithops.sigma-star.at ([127.0.0.1])
        by localhost (lithops.sigma-star.at [127.0.0.1]) (amavisd-new, port 10026)
        with ESMTP id OZ7bmjqrn-kD; Tue,  9 Jun 2020 23:01:51 +0200 (CEST)
Received: from lithops.sigma-star.at (lithops.sigma-star.at [195.201.40.130])
        by lithops.sigma-star.at (Postfix) with ESMTP id EA2E4607400D;
        Tue,  9 Jun 2020 23:01:50 +0200 (CEST)
Date:   Tue, 9 Jun 2020 23:01:50 +0200 (CEST)
From:   Richard Weinberger <richard@nod.at>
To:     torvalds <torvalds@linux-foundation.org>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        linux-um <linux-um@lists.infradead.org>
Message-ID: <1858220125.350.1591736510906.JavaMail.zimbra@nod.at>
Subject: [GIT PULL] UML changes for v5.8
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 8BIT
X-Originating-IP: [195.201.40.130]
X-Mailer: Zimbra 8.8.12_GA_3807 (ZimbraWebClient - FF68 (Linux)/8.8.12_GA_3809)
Thread-Index: eBoFZpqVB3Ctbf548VMEVBglzkcn8A==
Thread-Topic: UML changes for v5.8
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Linus,

The following changes since commit 3d77e6a8804abcc0504c904bd6e5cdf3a5cf8162:

  Linux 5.7 (2020-05-31 16:49:15 -0700)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/uml.git tags/for-linus-5.8-rc1

for you to fetch changes up to f6e8c474390be2e6f5bd0b8966e19958214609ff:

  um: virtio: Replace zero-length array with flexible-array (2020-06-02 22:38:00 +0200)

----------------------------------------------------------------
This pull request contains the following changes for UML:

- Use fdatasync() in ubd
- Add a generic "fd" vector transport
- Minor cleanups and fixes

----------------------------------------------------------------
Anton Ivanov (1):
      um: Use fdatasync() when mapping the UBD FSYNC command

Gustavo A. R. Silva (1):
      um: virtio: Replace zero-length array with flexible-array

Joe Perches (1):
      um: Neaten vu_err macro definition

Marc-André Lureau (1):
      um: Add a generic "fd" vector transport

Masahiro Yamada (1):
      um: Do not evaluate compiler's library path when cleaning

Zach van Rijn (1):
      um: Add include: memset() and memcpy() are in <string.h>

 arch/um/drivers/Makefile      |  4 +--
 arch/um/drivers/vector_kern.h |  2 +-
 arch/um/drivers/vector_user.c | 59 +++++++++++++++++++++++++++++++++++++++++++
 arch/um/drivers/vhost_user.h  |  2 +-
 arch/um/drivers/virtio_uml.c  |  2 +-
 arch/um/os-Linux/file.c       |  3 ++-
 6 files changed, 66 insertions(+), 6 deletions(-)
