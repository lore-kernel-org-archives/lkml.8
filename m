Return-Path: <SRS0=N8G3=3G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47032C33CB1
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:39:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 248ED2073A
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Jan 2020 14:39:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729213AbgAQOjf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Jan 2020 09:39:35 -0500
Received: from mx2.suse.de ([195.135.220.15]:57492 "EHLO mx2.suse.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729037AbgAQOjI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Jan 2020 09:39:08 -0500
X-Virus-Scanned: by amavisd-new at test-mx.suse.de
Received: from relay2.suse.de (unknown [195.135.220.254])
        by mx2.suse.de (Postfix) with ESMTP id D97EBABE9;
        Fri, 17 Jan 2020 14:39:06 +0000 (UTC)
From:   Mian Yousaf Kaukab <ykaukab@suse.de>
To:     linux-arm-kernel@lists.infradead.org, mathieu.poirier@linaro.org
Cc:     linux-kernel@vger.kernel.org, paul.gortmaker@windriver.com,
        suzuki.poulose@arm.com, alexander.shishkin@linux.intel.com,
        Mian Yousaf Kaukab <ykaukab@suse.de>
Subject: [PATCH RFC 11/15] coresight: add coresight prefix to barrier_pkt
Date:   Fri, 17 Jan 2020 15:40:06 +0100
Message-Id: <20200117144010.11149-12-ykaukab@suse.de>
X-Mailer: git-send-email 2.16.4
In-Reply-To: <20200117144010.11149-1-ykaukab@suse.de>
References: <20200117144010.11149-1-ykaukab@suse.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

barrier_pkt is an exported symbol. Add coresight prefix to
make it specific.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
---
 drivers/hwtracing/coresight/coresight-bus.c     | 5 +++--
 drivers/hwtracing/coresight/coresight-etb10.c   | 2 +-
 drivers/hwtracing/coresight/coresight-priv.h    | 8 ++++----
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
 4 files changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-bus.c b/drivers/hwtracing/coresight/coresight-bus.c
index aef99c3f7362..7bbe824436ce 100644
--- a/drivers/hwtracing/coresight/coresight-bus.c
+++ b/drivers/hwtracing/coresight/coresight-bus.c
@@ -53,8 +53,9 @@ static struct list_head *stm_path;
  * beginning of the data collected in a buffer.  That way the decoder knows that
  * it needs to look for another sync sequence.
  */
-const u32 barrier_pkt[4] = {0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff};
-EXPORT_SYMBOL_GPL(barrier_pkt);
+const u32 coresight_barrier_pkt[4] = {
+		0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff};
+EXPORT_SYMBOL_GPL(coresight_barrier_pkt);
 
 static int coresight_id_match(struct device *dev, void *data)
 {
diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 2d5a542e5464..fdd6ce865dc8 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -526,7 +526,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 
 	cur = buf->cur;
 	offset = buf->offset;
-	barrier = barrier_pkt;
+	barrier = coresight_barrier_pkt;
 
 	for (i = 0; i < to_read; i += 4) {
 		buf_ptr = buf->data_pages[cur] + offset;
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index e6eec9f46e13..9212bc8a20c8 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -65,8 +65,8 @@ static DEVICE_ATTR_RO(name)
 #define coresight_simple_reg64(type, name, lo_off, hi_off)		\
 	__coresight_simple_func(type, NULL, name, lo_off, hi_off)
 
-extern const u32 barrier_pkt[4];
-#define CORESIGHT_BARRIER_PKT_SIZE (sizeof(barrier_pkt))
+extern const u32 coresight_barrier_pkt[4];
+#define CORESIGHT_BARRIER_PKT_SIZE (sizeof(coresight_barrier_pkt))
 
 enum etm_addr_type {
 	ETM_ADDR_TYPE_NONE,
@@ -103,10 +103,10 @@ struct cs_buffers {
 static inline void coresight_insert_barrier_packet(void *buf)
 {
 	if (buf)
-		memcpy(buf, barrier_pkt, CORESIGHT_BARRIER_PKT_SIZE);
+		memcpy(buf, coresight_barrier_pkt,
+				CORESIGHT_BARRIER_PKT_SIZE);
 }
 
-
 static inline void CS_LOCK(void __iomem *addr)
 {
 	do {
diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index d0cc3985b72a..52b287481b8b 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -519,7 +519,7 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 
 	cur = buf->cur;
 	offset = buf->offset;
-	barrier = barrier_pkt;
+	barrier = coresight_barrier_pkt;
 
 	/* for every byte to read */
 	for (i = 0; i < to_read; i += 4) {
-- 
2.16.4

