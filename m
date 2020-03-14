Return-Path: <SRS0=iqK9=5A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84640C0044D
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 639C2206D5
	for <linux-kernel@archiver.kernel.org>; Sun, 15 Mar 2020 01:46:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727432AbgCOBqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 14 Mar 2020 21:46:11 -0400
Received: from m17617.mail.qiye.163.com ([59.111.176.17]:12052 "EHLO
        m17617.mail.qiye.163.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726556AbgCOBqI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 Mar 2020 21:46:08 -0400
Received: from ubuntu.localdomain (unknown [58.251.74.227])
        by m17617.mail.qiye.163.com (Hmail) with ESMTPA id C1204260FF6;
        Sat, 14 Mar 2020 23:07:12 +0800 (CST)
From:   Wang Wenhu <wenhu.wang@vivo.com>
To:     Harry Wei <harryxiyou@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Jonathan Corbet <corbet@lwn.net>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     linux-kernel@zh-kernel.org, kernel@vivo.com,
        Wang Wenhu <wenhu.wang@vivo.com>
Subject: [PATCH] doc: zh_CN: fix style problems for io_ordering.txt
Date:   Sat, 14 Mar 2020 08:07:05 -0700
Message-Id: <20200314150706.73955-1-wenhu.wang@vivo.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-HM-Spam-Status: e1kfGhgUHx5ZQUtXWQgYFAkeWUFZTlVIQ01CQkJNS0xLQ01KQ1lXWShZQU
        hPN1dZLVlBSVdZCQ4XHghZQVk1NCk2OjckKS43PlkG
X-HM-Sender-Digest: e1kMHhlZQR0aFwgeV1kSHx4VD1lBWUc6PFE6DRw6Fjg3NDdCAyMfTDMy
        MitPCjNVSlVKTkNPSkJDT0hNSUtNVTMWGhIXVQweFRMOVQwaFRw7DRINFFUYFBZFWVdZEgtZQVlO
        Q1VJTkpVTE9VSUlMWVdZCAFZQU9NTkI3Bg++
X-HM-Tid: 0a70d995b9439375kuwsc1204260ff6
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Problems exist in the Chinese translation of io_ordering.txt.
Partly for the difference between Chinese and English character
encoding format, and the others are of the failure to comply
with the ReST markups.

Signed-off-by: Wang Wenhu <wenhu.wang@vivo.com>
---
 .../translations/zh_CN/io_ordering.txt        | 72 ++++++++++++-------
 1 file changed, 46 insertions(+), 26 deletions(-)

diff --git a/Documentation/translations/zh_CN/io_ordering.txt b/Documentation/translations/zh_CN/io_ordering.txt
index 1f8127bdd415..080ed2911db0 100644
--- a/Documentation/translations/zh_CN/io_ordering.txt
+++ b/Documentation/translations/zh_CN/io_ordering.txt
@@ -29,39 +29,59 @@ Documentation/io_ordering.txt 的中文翻译
 这也可以保证后面的写操作只在前面的写操作之后到达设备（这非常类似于内存
 屏障操作，mb()，不过仅适用于I/O）。
 
+A more concrete example from a hypothetical device driver::
+
+		...
+	CPU A:  spin_lock_irqsave(&dev_lock, flags)
+	CPU A:  val = readl(my_status);
+	CPU A:  ...
+	CPU A:  writel(newval, ring_ptr);
+	CPU A:  spin_unlock_irqrestore(&dev_lock, flags)
+		...
+	CPU B:  spin_lock_irqsave(&dev_lock, flags)
+	CPU B:  val = readl(my_status);
+	CPU B:  ...
+	CPU B:  writel(newval2, ring_ptr);
+	CPU B:  spin_unlock_irqrestore(&dev_lock, flags)
+		...
+
+
 假设一个设备驱动程的具体例子：
+::
 
+		...
+	CPU A:  spin_lock_irqsave(&dev_lock, flags)
+	CPU A:  val = readl(my_status);
+	CPU A:  ...
+	CPU A:  writel(newval, ring_ptr);
+	CPU A:  spin_unlock_irqrestore(&dev_lock, flags)
+		...
+	CPU B:  spin_lock_irqsave(&dev_lock, flags)
+	CPU B:  val = readl(my_status);
+	CPU B:  ...
+	CPU B:  writel(newval2, ring_ptr);
+	CPU B:  spin_unlock_irqrestore(&dev_lock, flags)
         ...
-CPU A:  spin_lock_irqsave(&dev_lock, flags)
-CPU A:  val = readl(my_status);
-CPU A:  ...
-CPU A:  writel(newval, ring_ptr);
-CPU A:  spin_unlock_irqrestore(&dev_lock, flags)
-        ...
-CPU B:  spin_lock_irqsave(&dev_lock, flags)
-CPU B:  val = readl(my_status);
-CPU B:  ...
-CPU B:  writel(newval2, ring_ptr);
-CPU B:  spin_unlock_irqrestore(&dev_lock, flags)
-        ...
+
 
 上述例子中，设备可能会先接收到newval2的值，然后接收到newval的值，问题就
 发生了。不过很容易通过下面方法来修复：
+::
 
-        ...
-CPU A:  spin_lock_irqsave(&dev_lock, flags)
-CPU A:  val = readl(my_status);
-CPU A:  ...
-CPU A:  writel(newval, ring_ptr);
-CPU A:  (void)readl(safe_register); /* 配置寄存器？*/
-CPU A:  spin_unlock_irqrestore(&dev_lock, flags)
-        ...
-CPU B:  spin_lock_irqsave(&dev_lock, flags)
-CPU B:  val = readl(my_status);
-CPU B:  ...
-CPU B:  writel(newval2, ring_ptr);
-CPU B:  (void)readl(safe_register); /* 配置寄存器？*/
-CPU B:  spin_unlock_irqrestore(&dev_lock, flags)
+		...
+	CPU A:  spin_lock_irqsave(&dev_lock, flags)
+	CPU A:  val = readl(my_status);
+	CPU A:  ...
+	CPU A:  writel(newval, ring_ptr);
+	CPU A:  (void)readl(safe_register); /* 配置寄存器？*/
+	CPU A:  spin_unlock_irqrestore(&dev_lock, flags)
+		...
+	CPU B:  spin_lock_irqsave(&dev_lock, flags)
+	CPU B:  val = readl(my_status);
+	CPU B:  ...
+	CPU B:  writel(newval2, ring_ptr);
+	CPU B:  (void)readl(safe_register); /* 配置寄存器？*/
+	CPU B:  spin_unlock_irqrestore(&dev_lock, flags)
 
 在解决方案中，读取safe_register寄存器，触发IO芯片清刷未处理的写操作，
 再处理后面的读操作，防止引发数据不一致问题。
-- 
2.17.1

