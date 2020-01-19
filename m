Return-Path: <SRS0=pPEE=3I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.5 required=3.0 tests=DKIM_ADSP_CUSTOM_MED,
	FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNPARSEABLE_RELAY,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 32347C33CB7
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 08:26:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 134382073A
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jan 2020 08:26:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726894AbgASI0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jan 2020 03:26:37 -0500
Received: from out30-44.freemail.mail.aliyun.com ([115.124.30.44]:53959 "EHLO
        out30-44.freemail.mail.aliyun.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726444AbgASI0h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jan 2020 03:26:37 -0500
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01f04397;MF=teawaterz@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0To4g3HH_1579422389;
Received: from localhost(mailfrom:teawaterz@linux.alibaba.com fp:SMTPD_---0To4g3HH_1579422389)
          by smtp.aliyun-inc.com(127.0.0.1);
          Sun, 19 Jan 2020 16:26:34 +0800
From:   Hui Zhu <teawater@gmail.com>
To:     fengguang.wu@intel.com, linux-kernel@vger.kernel.org
Cc:     Hui Zhu <teawater@gmail.com>, Hui Zhu <teawaterz@linux.alibaba.com>
Subject: [PATCH for vm-scalability] Makefile: Add static build option
Date:   Sun, 19 Jan 2020 16:26:27 +0800
Message-Id: <1579422387-30552-1-git-send-email-teawater@gmail.com>
X-Mailer: git-send-email 2.7.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sometimes vm-scalability needs to work in an environment without an
libraries.  Supporting static build is helpful.

This commit add static build option:
make STATIC=1

Signed-off-by: Hui Zhu <teawaterz@linux.alibaba.com>
---
 Makefile | 27 +++++++++++++++++----------
 1 file changed, 17 insertions(+), 10 deletions(-)

diff --git a/Makefile b/Makefile
index 73b2ff3..eadc090 100644
--- a/Makefile
+++ b/Makefile
@@ -6,6 +6,13 @@ EXECUTABLES :=	usemem \
 		usemem_direct_write \
 		usemem_mbind
 
+ifdef STATIC
+	EXTRA_LDFLAGS := -static
+else
+	EXTRA_LDFLAGS :=
+endif
+
+
 all:	$(EXECUTABLES)
 
 clean:
@@ -15,31 +22,31 @@ distclean: clean
 	rm -f $(EXECUTABLES)
 
 usemem: usemem.o usemem_hugepages.o usemem_mincore.o
-	gcc -pthread -Wall -O -g usemem_mincore.o usemem_hugepages.o usemem.o -o usemem
+	gcc -pthread -Wall -O -g $(EXTRA_LDFLAGS) usemem_mincore.o usemem_hugepages.o usemem.o -o usemem
 
 usemem.o: usemem.c
-	gcc -O -c -Wall -g  usemem.c -o usemem.o
+	gcc -O -c -Wall -g $(EXTRA_LDFLAGS) usemem.c -o usemem.o
 
 usemem_hugepages.o: usemem_hugepages.c
-	gcc -Wall -O -c -g usemem_hugepages.c -o usemem_hugepages.o
+	gcc -Wall -O -c -g $(EXTRA_LDFLAGS) usemem_hugepages.c -o usemem_hugepages.o
 
 usemem_mincore.o: usemem_mincore.c
-	gcc -Wall -O -c -g usemem_mincore.c -o usemem_mincore.o
+	gcc -Wall -O -c -g $(EXTRA_LDFLAGS) usemem_mincore.c -o usemem_mincore.o
 
 usemem_migrate: usemem_migrate.c
-	gcc -Wall -O -g -o usemem_migrate usemem_migrate.c -lnuma
+	gcc -Wall -O -g $(EXTRA_LDFLAGS) -o usemem_migrate usemem_migrate.c -lnuma
 
 usemem_ksm: usemem_ksm.c usemem_hugepages.c
-	gcc -Wall -g -o usemem_ksm usemem_ksm.c usemem_hugepages.c
+	gcc -Wall -g $(EXTRA_LDFLAGS) -o usemem_ksm usemem_ksm.c usemem_hugepages.c
 
 usemem_mbind: usemem_mbind.c
-	gcc -Wall -g -o usemem_mbind usemem_mbind.c -lnuma
+	gcc -Wall -g $(EXTRA_LDFLAGS) -o usemem_mbind usemem_mbind.c -lnuma
 
 usemem_ksm_hugepages: usemem_ksm_hugepages.c
-	gcc -Wall -g -o usemem_ksm_hugepages usemem_ksm_hugepages.c
+	gcc -Wall -g $(EXTRA_LDFLAGS) -o usemem_ksm_hugepages usemem_ksm_hugepages.c
 
 usemem_direct_write: usemem_direct_write.c
-	gcc -Wall -g -o usemem_direct_write usemem_direct_write.c
+	gcc -Wall -g $(EXTRA_LDFLAGS) -o usemem_direct_write usemem_direct_write.c
 
 usemem_remap: usemem_remap.c
-	gcc -Wall -g -o usemem_remap usemem_remap.c
+	gcc -Wall -g $(EXTRA_LDFLAGS) -o usemem_remap usemem_remap.c
-- 
2.7.4

