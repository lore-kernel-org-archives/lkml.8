Return-Path: <SRS0=dqcu=6X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,USER_AGENT_GIT
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 89BB5C54E49
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 11:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6DAE024956
	for <linux-kernel@archiver.kernel.org>; Sat,  9 May 2020 11:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728420AbgEILPI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 9 May 2020 07:15:08 -0400
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:59372 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726951AbgEILPE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 May 2020 07:15:04 -0400
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.07436625|-1;CH=green;DM=|CONTINUE|false|;DS=CONTINUE|ham_system_inform|0.0365396-0.00253994-0.96092;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03297;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=20;RT=20;SR=0;TI=SMTPD_---.HVopGr-_1589022874;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.HVopGr-_1589022874)
          by smtp.aliyun-inc.com(10.147.44.129);
          Sat, 09 May 2020 19:14:39 +0800
From:   WeiXiong Liao <liaoweixiong@allwinnertech.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Petr Mladek <pmladek@suse.com>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Pavel Tatashin <pasha.tatashin@soleen.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>
Subject: [PATCH v5 00/12] pstore: mtd: support crash log to block and mtd device
Date:   Sat,  9 May 2020 19:14:02 +0800
Message-Id: <1589022854-19821-1-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a series to support crash log to block and mtd device,
base on v4 of Kees Cook's.

Changes since v4:
	patch 1: adapt pstore to kmsg_dump_reason_str().
	patch 2: fix bugs that decompress failed and rmmod failed.
			 use atomic_xchg() on psz_flush_dirty_zone() in case of reload.
	patch 3: fix build error
	patch 5: flush pmsg zone if it's dirty.
	patch 6: use delayed work to cache more data and reduce calling
			 dirty-flusher times
	patch 12: change dev_err() to pr_err() when initialize because it get
			  no pointer to mtd at that time.

v4: https://lore.kernel.org/lkml/20200508064004.57898-1-keescook@chromium.org/
v3: https://lore.kernel.org/lkml/1585126506-18635-1-git-send-email-liaoweixiong@allwinnertech.com/
v2: https://lore.kernel.org/lkml/1581078355-19647-1-git-send-email-liaoweixiong@allwinnertech.com/
v1: https://lore.kernel.org/lkml/1579482233-2672-1-git-send-email-liaoweixiong@allwinnertech.com/

Kees Cook (1):
  printk: pstore: Introduce kmsg_dump_reason_str()

WeiXiong Liao (11):
  pstore/zone: Introduce common layer to manage storage zones
  pstore/blk: Introduce backend for block devices
  pstore/blk: Provide way to choose pstore frontend support
  pstore/blk: Add support for pmsg frontend
  pstore/blk: Add console frontend support
  pstore/blk: Add ftrace frontend support
  Documentation: Add details for pstore/blk
  pstore/zone: Provide way to skip "broken" zone for MTD devices
  pstore/blk: Provide way to query pstore configuration
  pstore/blk: Support non-block storage devices
  mtd: Support kmsg dumper based on pstore/blk

 Documentation/admin-guide/pstore-blk.rst |  243 +++++
 MAINTAINERS                              |    1 +
 drivers/mtd/Kconfig                      |   10 +
 drivers/mtd/Makefile                     |    1 +
 drivers/mtd/mtdpstore.c                  |  563 +++++++++++
 fs/pstore/Kconfig                        |  109 +++
 fs/pstore/Makefile                       |    6 +
 fs/pstore/blk.c                          |  481 ++++++++++
 fs/pstore/platform.c                     |   22 +-
 fs/pstore/zone.c                         | 1508 ++++++++++++++++++++++++++++++
 include/linux/kmsg_dump.h                |    7 +
 include/linux/pstore_blk.h               |   77 ++
 include/linux/pstore_zone.h              |   60 ++
 kernel/printk/printk.c                   |   21 +
 14 files changed, 3088 insertions(+), 21 deletions(-)
 create mode 100644 Documentation/admin-guide/pstore-blk.rst
 create mode 100644 drivers/mtd/mtdpstore.c
 create mode 100644 fs/pstore/blk.c
 create mode 100644 fs/pstore/zone.c
 create mode 100644 include/linux/pstore_blk.h
 create mode 100644 include/linux/pstore_zone.h

-- 
1.9.1

