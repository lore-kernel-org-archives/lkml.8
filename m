Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B58CAC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:58:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 939892072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:58:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729671AbgGML6U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 07:58:20 -0400
Received: from out30-42.freemail.mail.aliyun.com ([115.124.30.42]:57201 "EHLO
        out30-42.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726586AbgGML6T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 07:58:19 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e01358;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U2bYiCk_1594641495;
Received: from localhost.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U2bYiCk_1594641495)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 13 Jul 2020 19:58:16 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Harry Wei <harryxiyou@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 1/3] doc/zh_CN: add admin-guide index
Date:   Mon, 13 Jul 2020 19:58:05 +0800
Message-Id: <20200713115807.56362-1-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.18.4
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Translate the admin-guide index.rst file into Chinese. and link it into
Chinese top index file.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../translations/zh_CN/admin-guide/index.rst  | 112 ++++++++++++++++++
 Documentation/translations/zh_CN/index.rst    |   1 +
 2 files changed, 113 insertions(+)
 create mode 100644 Documentation/translations/zh_CN/admin-guide/index.rst

diff --git a/Documentation/translations/zh_CN/admin-guide/index.rst b/Documentation/translations/zh_CN/admin-guide/index.rst
new file mode 100644
index 000000000000..0cb3f79f77cf
--- /dev/null
+++ b/Documentation/translations/zh_CN/admin-guide/index.rst
@@ -0,0 +1,112 @@
+.. include:: ../disclaimer-zh_CN.rst
+
+:Original: :ref:`Documentation/admin-guide/index.rst`
+:Translator: Alex Shi <alex.shi@linux.alibaba.com>
+
+
+Linux 内核用户和管理员指南
+==========================
+
+下面是一组随时间添加到内核中的面向用户的文档的集合。到目前为止，还没有一个
+整体的顺序或组织 - 这些材料不是一个单一的，连贯的文件！幸运的话，情况会随着
+时间的推移而迅速改善。
+
+这个初始部分包含总体信息，包括描述内核的README， 关于内核参数的文档等。
+
+
+   README
+   kernel-parameters
+   devices
+   sysctl/index
+
+本节介绍CPU漏洞及其缓解措施。
+
+   hw-vuln/index
+
+下面的一组文档，针对的是试图跟踪问题和bug的用户。
+
+
+   reporting-bugs
+   security-bugs
+   bug-hunting
+   bug-bisect
+   tainted-kernels
+   ramoops
+   dynamic-debug-howto
+   init
+   kdump/index
+   perf/index
+
+这是应用程序开发人员感兴趣的章节的开始。可以在这里找到涵盖内核ABI各个
+方面的文档。
+
+   sysfs-rules
+
+本手册的其余部分包括各种指南，介绍如何根据您的喜好配置内核的特定行为。
+
+   acpi/index
+   aoe/index
+   auxdisplay/index
+   bcache
+   binderfs
+   binfmt-misc
+   blockdev/index
+   bootconfig
+   braille-console
+   btmrvl
+   cgroup-v1/index
+   cgroup-v2
+   cifs/index
+   clearing-warn-once
+   cpu-load
+   cputopology
+   dell_rbu
+   device-mapper/index
+   edid
+   efi-stub
+   ext4
+   nfs/index
+   gpio/index
+   highuid
+   hw_random
+   initrd
+   iostats
+   java
+   jfs
+   kernel-per-CPU-kthreads
+   laptops/index
+   lcd-panel-cgram
+   ldm
+   lockup-watchdogs
+   LSM/index
+   md
+   media/index
+   mm/index
+   module-signing
+   mono
+   namespaces/index
+   numastat
+   parport
+   perf-security
+   pm/index
+   pnp
+   rapidio
+   ras
+   rtc
+   serial-console
+   svga
+   sysrq
+   thunderbolt
+   ufs
+   unicode
+   vga-softcursor
+   video-output
+   wimax/index
+   xfs
+
+.. only::  subproject and html
+
+   Indices
+   =======
+
+   * :ref:`genindex`
diff --git a/Documentation/translations/zh_CN/index.rst b/Documentation/translations/zh_CN/index.rst
index 76850a5dd982..301e50a64dc6 100644
--- a/Documentation/translations/zh_CN/index.rst
+++ b/Documentation/translations/zh_CN/index.rst
@@ -13,6 +13,7 @@
 .. toctree::
    :maxdepth: 2
 
+   admin-guide/index
    process/index
    filesystems/index
 
-- 
2.18.4

