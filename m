Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE76AC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:04:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8CD4420873
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 09:04:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728613AbgCKJEa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 05:04:30 -0400
Received: from mx2.suse.de ([195.135.220.15]:39460 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726934AbgCKJEa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 05:04:30 -0400
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id 49B66AD08;
        Wed, 11 Mar 2020 09:04:28 +0000 (UTC)
From:   Takashi Iwai <tiwai@suse.de>
To:     Dominik Brodowski <linux@dominikbrodowski.net>
Cc:     linux-kernel@vger.kernel.org
Subject: [PATCH] pcmcia: Use scnprintf() for avoiding potential buffer overflow
Date:   Wed, 11 Mar 2020 10:04:26 +0100
Message-Id: <20200311090426.20161-1-tiwai@suse.de>
X-Mailer: git-send-email 2.16.4
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since snprintf() returns the would-be-output size instead of the
actual output size, the succeeding calls may go beyond the given
buffer limit.  Fix it by replacing with scnprintf().

Signed-off-by: Takashi Iwai <tiwai@suse.de>
---
 drivers/pcmcia/rsrc_nonstatic.c |  6 +++---
 drivers/pcmcia/yenta_socket.c   | 10 +++++-----
 2 files changed, 8 insertions(+), 8 deletions(-)

diff --git a/drivers/pcmcia/rsrc_nonstatic.c b/drivers/pcmcia/rsrc_nonstatic.c
index 9e6922c08ef6..3b05760e69d6 100644
--- a/drivers/pcmcia/rsrc_nonstatic.c
+++ b/drivers/pcmcia/rsrc_nonstatic.c
@@ -1076,7 +1076,7 @@ static ssize_t show_io_db(struct device *dev,
 	for (p = data->io_db.next; p != &data->io_db; p = p->next) {
 		if (ret > (PAGE_SIZE - 10))
 			continue;
-		ret += snprintf(&buf[ret], (PAGE_SIZE - ret - 1),
+		ret += scnprintf(&buf[ret], (PAGE_SIZE - ret - 1),
 				"0x%08lx - 0x%08lx\n",
 				((unsigned long) p->base),
 				((unsigned long) p->base + p->num - 1));
@@ -1133,7 +1133,7 @@ static ssize_t show_mem_db(struct device *dev,
 	     p = p->next) {
 		if (ret > (PAGE_SIZE - 10))
 			continue;
-		ret += snprintf(&buf[ret], (PAGE_SIZE - ret - 1),
+		ret += scnprintf(&buf[ret], (PAGE_SIZE - ret - 1),
 				"0x%08lx - 0x%08lx\n",
 				((unsigned long) p->base),
 				((unsigned long) p->base + p->num - 1));
@@ -1142,7 +1142,7 @@ static ssize_t show_mem_db(struct device *dev,
 	for (p = data->mem_db.next; p != &data->mem_db; p = p->next) {
 		if (ret > (PAGE_SIZE - 10))
 			continue;
-		ret += snprintf(&buf[ret], (PAGE_SIZE - ret - 1),
+		ret += scnprintf(&buf[ret], (PAGE_SIZE - ret - 1),
 				"0x%08lx - 0x%08lx\n",
 				((unsigned long) p->base),
 				((unsigned long) p->base + p->num - 1));
diff --git a/drivers/pcmcia/yenta_socket.c b/drivers/pcmcia/yenta_socket.c
index 49b1c6a1bdbe..bf6529b0b5b0 100644
--- a/drivers/pcmcia/yenta_socket.c
+++ b/drivers/pcmcia/yenta_socket.c
@@ -180,12 +180,12 @@ static ssize_t show_yenta_registers(struct device *yentadev, struct device_attri
 	for (i = 0; i < 0x24; i += 4) {
 		unsigned val;
 		if (!(i & 15))
-			offset += snprintf(buf + offset, PAGE_SIZE - offset, "\n%02x:", i);
+			offset += scnprintf(buf + offset, PAGE_SIZE - offset, "\n%02x:", i);
 		val = cb_readl(socket, i);
-		offset += snprintf(buf + offset, PAGE_SIZE - offset, " %08x", val);
+		offset += scnprintf(buf + offset, PAGE_SIZE - offset, " %08x", val);
 	}
 
-	offset += snprintf(buf + offset, PAGE_SIZE - offset, "\n\nExCA registers:");
+	offset += scnprintf(buf + offset, PAGE_SIZE - offset, "\n\nExCA registers:");
 	for (i = 0; i < 0x45; i++) {
 		unsigned char val;
 		if (!(i & 7)) {
@@ -193,10 +193,10 @@ static ssize_t show_yenta_registers(struct device *yentadev, struct device_attri
 				memcpy(buf + offset, " -", 2);
 				offset += 2;
 			} else
-				offset += snprintf(buf + offset, PAGE_SIZE - offset, "\n%02x:", i);
+				offset += scnprintf(buf + offset, PAGE_SIZE - offset, "\n%02x:", i);
 		}
 		val = exca_readb(socket, i);
-		offset += snprintf(buf + offset, PAGE_SIZE - offset, " %02x", val);
+		offset += scnprintf(buf + offset, PAGE_SIZE - offset, " %02x", val);
 	}
 	buf[offset++] = '\n';
 	return offset;
-- 
2.16.4

