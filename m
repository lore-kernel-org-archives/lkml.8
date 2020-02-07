Return-Path: <SRS0=bYqs=33=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9261BC352A4
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:26:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 66F2620720
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Feb 2020 12:26:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727032AbgBGM0C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Feb 2020 07:26:02 -0500
Received: from smtp2207-205.mail.aliyun.com ([121.197.207.205]:44680 "EHLO
        smtp2207-205.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726954AbgBGM0C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Feb 2020 07:26:02 -0500
X-Alimail-AntiSpam: AC=CONTINUE;BC=0.06713034|-1;CH=green;DM=CONTINUE|CONTINUE|true|0.243597-0.0807567-0.675647;DS=CONTINUE|ham_system_inform|0.0554339-0.00117818-0.943388;FP=0|0|0|0|0|-1|-1|-1;HT=e02c03299;MF=liaoweixiong@allwinnertech.com;NM=1;PH=DS;RN=17;RT=17;SR=0;TI=SMTPD_---.GlaQplc_1581078351;
Received: from PC-liaoweixiong.allwinnertech.com(mailfrom:liaoweixiong@allwinnertech.com fp:SMTPD_---.GlaQplc_1581078351)
          by smtp.aliyun-inc.com(10.147.41.137);
          Fri, 07 Feb 2020 20:25:57 +0800
From:   WeiXiong Liao <liaoweixiong@allwinnertech.com>
To:     Kees Cook <keescook@chromium.org>,
        Anton Vorontsov <anton@enomsg.org>,
        Colin Cross <ccross@android.com>,
        Tony Luck <tony.luck@intel.com>,
        Jonathan Corbet <corbet@lwn.net>,
        Miquel Raynal <miquel.raynal@bootlin.com>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        WeiXiong Liao <liaoweixiong@allwinnertech.com>
Cc:     linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-mtd@lists.infradead.org
Subject: [PATCH v2 00/11] pstore: mtd: support crash log to block and mtd device
Date:   Fri,  7 Feb 2020 20:25:44 +0800
Message-Id: <1581078355-19647-1-git-send-email-liaoweixiong@allwinnertech.com>
X-Mailer: git-send-email 1.9.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Why do we need to log to block (mtd) device?
1. Most embedded intelligent equipment have no persistent ram, which
   increases costs. We perfer to cheaper solutions, like block devices.
2. Do not any equipment have battery, which means that it lost all data
   on general ram if power failure. Pstore has little to do for these
   equipments.

Why do we need mtdpstore instead of mtdoops?
1. repetitive jobs between pstore and mtdoops
   Both of pstore and mtdoops do the same jobs that store panic/oops log.
2. do what a driver should do
   To me, a driver should provide methods instead of policies. What MTD
   should do is to provide read/write/erase operations, geting rid of codes
   about chunk management, kmsg dumper and configuration.
3. enhanced feature
   Not only store log, but also show it as files.
   Not only log, but also trigger time and trigger count.
   Not only panic/oops log, but also log recorder for pmsg, console and
   ftrace in the future.

Before upstream submission, pstore/blk is tested on arch ARM and x84_64,
block device and mtd device, built as modules and in kernel. Here are the
details:

	https://github.com/gmpy/articles/blob/master/pstore/Test-Pstore-Block.md

[PATCH v2]:
1. fix syntax error in documents. Thank Randy Dunlap <rdunlap@infradead.org>
2. replace pr_* with dev_* for mtdpstore.
   Thank Vignesh Raghavendra <vigneshr@ti.com>
3. improve mtdpstore. Thank Miquel Raynal <mraynal@kernel.org>
[PATCH v1]:
1. fix errors and warnings reported by kbuild test robot.

WeiXiong Liao (11):
  pstore/blk: new support logger for block devices
  blkoops: add blkoops, a warpper for pstore/blk
  pstore/blk: blkoops: support pmsg recorder
  pstore/blk: blkoops: support console recorder
  pstore/blk: blkoops: support ftrace recorder
  Documentation: pstore/blk: blkoops: create document for pstore_blk
  pstore/blk: skip broken zone for mtd device
  blkoops: respect for device to pick recorders
  pstore/blk: blkoops: support special removing jobs for dmesg.
  blkoops: add interface for dirver to get information of blkoops
  mtd: new support oops logger based on pstore/blk

 Documentation/admin-guide/pstore-block.rst |  306 +++++++
 MAINTAINERS                                |    3 +-
 drivers/mtd/Kconfig                        |   10 +
 drivers/mtd/Makefile                       |    1 +
 drivers/mtd/mtdpstore.c                    |  564 ++++++++++++
 fs/pstore/Kconfig                          |  109 +++
 fs/pstore/Makefile                         |    5 +
 fs/pstore/blkoops.c                        |  475 ++++++++++
 fs/pstore/blkzone.c                        | 1328 ++++++++++++++++++++++++++++
 include/linux/blkoops.h                    |   94 ++
 include/linux/pstore_blk.h                 |   91 ++
 11 files changed, 2985 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/admin-guide/pstore-block.rst
 create mode 100644 drivers/mtd/mtdpstore.c
 create mode 100644 fs/pstore/blkoops.c
 create mode 100644 fs/pstore/blkzone.c
 create mode 100644 include/linux/blkoops.h
 create mode 100644 include/linux/pstore_blk.h

-- 
1.9.1

