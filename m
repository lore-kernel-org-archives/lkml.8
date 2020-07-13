Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EEC09C433E7
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:58:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D247120738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 11:58:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726586AbgGML6c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 07:58:32 -0400
Received: from out4436.biz.mail.alibaba.com ([47.88.44.36]:2937 "EHLO
        out4436.biz.mail.alibaba.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729733AbgGML6a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 07:58:30 -0400
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e07484;MF=alex.shi@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0U2bYiCk_1594641495;
Received: from localhost.localdomain(mailfrom:alex.shi@linux.alibaba.com fp:SMTPD_---0U2bYiCk_1594641495)
          by smtp.aliyun-inc.com(127.0.0.1);
          Mon, 13 Jul 2020 19:58:18 +0800
From:   Alex Shi <alex.shi@linux.alibaba.com>
Cc:     Alex Shi <alex.shi@linux.alibaba.com>,
        Harry Wei <harryxiyou@gmail.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/3] doc/zh_CN: add clearing-warn-once Chinese version
Date:   Mon, 13 Jul 2020 19:58:06 +0800
Message-Id: <20200713115807.56362-2-alex.shi@linux.alibaba.com>
X-Mailer: git-send-email 2.18.4
In-Reply-To: <20200713115807.56362-1-alex.shi@linux.alibaba.com>
References: <20200713115807.56362-1-alex.shi@linux.alibaba.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

and link it into admin-guide.

Signed-off-by: Alex Shi <alex.shi@linux.alibaba.com>
Cc: Harry Wei <harryxiyou@gmail.com>
Cc: Jonathan Corbet <corbet@lwn.net>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
---
 .../zh_CN/admin-guide/clearing-warn-once.rst      |  9 +++++++++
 .../translations/zh_CN/admin-guide/index.rst      | 15 ++++++++++++++-
 2 files changed, 23 insertions(+), 1 deletion(-)
 create mode 100644 Documentation/translations/zh_CN/admin-guide/clearing-warn-once.rst

diff --git a/Documentation/translations/zh_CN/admin-guide/clearing-warn-once.rst b/Documentation/translations/zh_CN/admin-guide/clearing-warn-once.rst
new file mode 100644
index 000000000000..659264d5f994
--- /dev/null
+++ b/Documentation/translations/zh_CN/admin-guide/clearing-warn-once.rst
@@ -0,0 +1,9 @@
+清除 WARN_ONCE
+--------------
+
+WARN_ONCE / WARN_ON_ONCE / printk_once 仅仅打印一次消息.
+
+echo 1 > /sys/kernel/debug/clear_warn_once
+
+可以清除这种状态并且再次允许打印一次告警信息，这对于运行测试集后重现问题
+很有用。
diff --git a/Documentation/translations/zh_CN/admin-guide/index.rst b/Documentation/translations/zh_CN/admin-guide/index.rst
index 0cb3f79f77cf..76637ff880c5 100644
--- a/Documentation/translations/zh_CN/admin-guide/index.rst
+++ b/Documentation/translations/zh_CN/admin-guide/index.rst
@@ -13,6 +13,7 @@ Linux 内核用户和管理员指南
 
 这个初始部分包含总体信息，包括描述内核的README， 关于内核参数的文档等。
 
+Todolist:
 
    README
    kernel-parameters
@@ -21,10 +22,13 @@ Linux 内核用户和管理员指南
 
 本节介绍CPU漏洞及其缓解措施。
 
+Todolist:
+
    hw-vuln/index
 
 下面的一组文档，针对的是试图跟踪问题和bug的用户。
 
+Todolist:
 
    reporting-bugs
    security-bugs
@@ -40,10 +44,20 @@ Linux 内核用户和管理员指南
 这是应用程序开发人员感兴趣的章节的开始。可以在这里找到涵盖内核ABI各个
 方面的文档。
 
+Todolist:
+
    sysfs-rules
 
 本手册的其余部分包括各种指南，介绍如何根据您的喜好配置内核的特定行为。
 
+
+.. toctree::
+   :maxdepth: 1
+
+   clearing-warn-once
+
+Todolist:
+
    acpi/index
    aoe/index
    auxdisplay/index
@@ -57,7 +71,6 @@ Linux 内核用户和管理员指南
    cgroup-v1/index
    cgroup-v2
    cifs/index
-   clearing-warn-once
    cpu-load
    cputopology
    dell_rbu
-- 
2.18.4

