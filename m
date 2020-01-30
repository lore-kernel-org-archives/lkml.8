Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.2 required=3.0
	tests=HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8B24EC2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:14:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 56EC8214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 20:14:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727620AbgA3UOj convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 15:14:39 -0500
Received: from relay3-d.mail.gandi.net ([217.70.183.195]:48921 "EHLO
        relay3-d.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727564AbgA3UOj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 15:14:39 -0500
X-Originating-IP: 93.23.196.10
Received: from xps13 (10.196.23.93.rev.sfr.net [93.23.196.10])
        (Authenticated sender: miquel.raynal@bootlin.com)
        by relay3-d.mail.gandi.net (Postfix) with ESMTPSA id 4F9D460007;
        Thu, 30 Jan 2020 20:14:35 +0000 (UTC)
Date:   Thu, 30 Jan 2020 21:14:33 +0100
From:   Miquel Raynal <miquel.raynal@bootlin.com>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     linux-mtd@lists.infradead.org, Richard Weinberger <richard@nod.at>,
        Tudor Ambarus <Tudor.Ambarus@microchip.com>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Frieder Schrempf <frieder.schrempf@kontron.de>,
        linux-kernel@vger.kernel.org
Subject: [GIT PULL] UBIFS changes for 5.6-rc1
Message-ID: <20200130211433.46abdf90@xps13>
Organization: Bootlin
X-Mailer: Claws Mail 3.17.4 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Linus,

This is the UBI/UBIFS PR for 5.6, sent on behalf of Richard.

Thanks,
Miquèl

The following changes since commit b3a987b0264d3ddbb24293ebff10eddfc472f653:

  Linux 5.5-rc6 (2020-01-12 16:55:08 -0800)

are available in the Git repository at:

  git://git.kernel.org/pub/scm/linux/kernel/git/rw/ubifs.git tags/upstream-5.6-rc1

for you to fetch changes up to 5d3805af279c93ef49a64701f35254676d709622:

  ubi: Fix an error pointer dereference in error handling code (2020-01-19 23:23:28 +0100)

----------------------------------------------------------------
This pull request contains mostly fixes for UBI and UBIFS:

UBI:
 - Fixes for memory leaks in error paths
 - Fix for an logic error in a fastmap selfcheck

UBIFS:
 - Fix for FS_IOC_SETFLAGS related to fscrypt flag
 - Support for FS_ENCRYPT_FL
 - Fix for a dead lock in bulk-read mode

----------------------------------------------------------------
Dan Carpenter (1):
      ubi: Fix an error pointer dereference in error handling code

Eric Biggers (2):
      ubifs: Fix FS_IOC_SETFLAGS unexpectedly clearing encrypt flag
      ubifs: Add support for FS_ENCRYPT_FL

Geert Uytterhoeven (1):
      ubifs: Fix ino_t format warnings in orphan_delete()

Hou Tao (2):
      ubi: Check the presence of volume before call ubi_fastmap_destroy_checkmap()
      ubi: Free the normal volumes in error paths of ubi_attach_mtd_dev()

Quanyang Wang (1):
      ubifs: Fix memory leak from c->sup_node

Sascha Hauer (2):
      ubi: fastmap: Fix inverted logic in seen selfcheck
      ubifs: Fix wrong memory allocation

YueHaibing (1):
      ubi: wl: Remove set but not used variable 'prev_e'

Zhihao Cheng (1):
      ubifs: Fix deadlock in concurrent bulk-read and writepage

 drivers/mtd/ubi/attach.c  |  2 +-
 drivers/mtd/ubi/build.c   | 31 ++++++++++++++++++++++++++-----
 drivers/mtd/ubi/fastmap.c | 23 +++++++++++++----------
 drivers/mtd/ubi/ubi.h     |  1 +
 drivers/mtd/ubi/vtbl.c    |  8 ++------
 drivers/mtd/ubi/wl.c      |  3 +--
 fs/ubifs/file.c           |  4 +++-
 fs/ubifs/ioctl.c          | 14 +++++++++++---
 fs/ubifs/orphan.c         |  4 ++--
 fs/ubifs/sb.c             |  2 +-
 fs/ubifs/super.c          |  2 ++
 11 files changed, 63 insertions(+), 31 deletions(-)
