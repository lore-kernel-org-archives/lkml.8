Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E396DC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:10:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C4C1020716
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 16:10:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727796AbgC0QKc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 12:10:32 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:12202 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727354AbgC0QKc (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 12:10:32 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id A77CC2A81FACFF6757F8;
        Sat, 28 Mar 2020 00:10:23 +0800 (CST)
Received: from localhost.localdomain (10.69.192.58) by
 DGGEMS410-HUB.china.huawei.com (10.3.19.210) with Microsoft SMTP Server id
 14.3.487.0; Sat, 28 Mar 2020 00:10:17 +0800
From:   John Garry <john.garry@huawei.com>
To:     <xuwei5@huawei.com>, <arnd@arndb.de>
CC:     <okaya@kernel.org>, <bhelgaas@google.com>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <linuxarm@huawei.com>,
        <olof@lixom.net>, <jiaxun.yang@flygoat.com>,
        "John Garry" <john.garry@huawei.com>
Subject: [PATCH v2 2/3] logic_pio: Improve macro argument name
Date:   Sat, 28 Mar 2020 00:06:13 +0800
Message-ID: <1585325174-195915-3-git-send-email-john.garry@huawei.com>
X-Mailer: git-send-email 2.8.1
In-Reply-To: <1585325174-195915-1-git-send-email-john.garry@huawei.com>
References: <1585325174-195915-1-git-send-email-john.garry@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.69.192.58]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Macro argument "bw" is used for building byte, word, and long-based
functions. Use "bwl" instead, to include long.

Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: John Garry <john.garry@huawei.com>
---
 lib/logic_pio.c | 22 +++++++++++-----------
 1 file changed, 11 insertions(+), 11 deletions(-)

diff --git a/lib/logic_pio.c b/lib/logic_pio.c
index f511a99bb389..21dc731bec88 100644
--- a/lib/logic_pio.c
+++ b/lib/logic_pio.c
@@ -229,13 +229,13 @@ unsigned long logic_pio_trans_cpuaddr(resource_size_t addr)
 }
 
 #if defined(CONFIG_INDIRECT_PIO) && defined(PCI_IOBASE)
-#define BUILD_LOGIC_IO(bw, type)					\
-type logic_in##bw(unsigned long addr)					\
+#define BUILD_LOGIC_IO(bwl, type)					\
+type logic_in##bwl(unsigned long addr)					\
 {									\
 	type ret = (type)~0;						\
 									\
 	if (addr < MMIO_UPPER_LIMIT) {					\
-		ret = read##bw(PCI_IOBASE + addr);			\
+		ret = read##bwl(PCI_IOBASE + addr);			\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) { \
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
 									\
@@ -248,10 +248,10 @@ type logic_in##bw(unsigned long addr)					\
 	return ret;							\
 }									\
 									\
-void logic_out##bw(type value, unsigned long addr)			\
+void logic_out##bwl(type value, unsigned long addr)			\
 {									\
 	if (addr < MMIO_UPPER_LIMIT) {					\
-		write##bw(value, PCI_IOBASE + addr);			\
+		write##bwl(value, PCI_IOBASE + addr);			\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
 									\
@@ -263,11 +263,11 @@ void logic_out##bw(type value, unsigned long addr)			\
 	}								\
 }									\
 									\
-void logic_ins##bw(unsigned long addr, void *buffer,			\
-		   unsigned int count)					\
+void logic_ins##bwl(unsigned long addr, void *buffer,			\
+		    unsigned int count)					\
 {									\
 	if (addr < MMIO_UPPER_LIMIT) {					\
-		reads##bw(PCI_IOBASE + addr, buffer, count);		\
+		reads##bwl(PCI_IOBASE + addr, buffer, count);		\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
 									\
@@ -280,11 +280,11 @@ void logic_ins##bw(unsigned long addr, void *buffer,			\
 									\
 }									\
 									\
-void logic_outs##bw(unsigned long addr, const void *buffer,		\
-		    unsigned int count)					\
+void logic_outs##bwl(unsigned long addr, const void *buffer,		\
+		     unsigned int count)				\
 {									\
 	if (addr < MMIO_UPPER_LIMIT) {					\
-		writes##bw(PCI_IOBASE + addr, buffer, count);		\
+		writes##bwl(PCI_IOBASE + addr, buffer, count);		\
 	} else if (addr >= MMIO_UPPER_LIMIT && addr < IO_SPACE_LIMIT) {	\
 		struct logic_pio_hwaddr *entry = find_io_range(addr);	\
 									\
-- 
2.16.4

