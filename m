Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96356C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:48:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 710C9207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 05:48:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="focr8WY1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727076AbgHTFsY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 01:48:24 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:29803 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727040AbgHTFsP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 01:48:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1597902493; h=Content-Transfer-Encoding: MIME-Version:
 References: In-Reply-To: Message-Id: Date: Subject: Cc: To: From:
 Sender; bh=MZNhX62GC5mduYw1hv3vNaxsR+pcnDEzoaKSap/G7+w=; b=focr8WY1SjXbBzfAupoQrz/ZZdUizODTkk7pdrlEWY+S1BL352jsLkvdHdVvbvk2uLpqRUDl
 BSlqJIzwhmSakM6Sof6vni0M5YQKioTozFyiM8HsLVkgrQSzR5FeiLOJiu59MqH8sLgo5F1G
 EnwzCI3BjyRlw/7f9mmNmZFvVqk=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5f3e0e97949572eafb67dcda (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 20 Aug 2020 05:48:07
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 95A59C43450; Thu, 20 Aug 2020 05:48:05 +0000 (UTC)
Received: from tingweiz-gv.qualcomm.com (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: tingwei)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 76E84C433B2;
        Thu, 20 Aug 2020 05:47:57 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 76E84C433B2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=tingwei@codeaurora.org
From:   Tingwei Zhang <tingwei@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Tingwei Zhang <tingwei@codeaurora.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Leo Yan <leo.yan@linaro.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Russell King <linux@armlinux.org.uk>,
        Kim Phillips <kim.phillips@arm.com>,
        Mian Yousaf Kaukab <ykaukab@suse.de>, tsoni@codeaurora.org,
        Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>,
        Mao Jinlong <jinlmao@codeaurora.org>,
        coresight@lists.linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v9 04/24] coresight: add coresight prefix to barrier_pkt
Date:   Thu, 20 Aug 2020 13:46:58 +0800
Message-Id: <20200820054718.20115-5-tingwei@codeaurora.org>
X-Mailer: git-send-email 2.20.0
In-Reply-To: <20200820054718.20115-1-tingwei@codeaurora.org>
References: <20200820054718.20115-1-tingwei@codeaurora.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add coresight prefix to make it specific. It will be a export symbol.

Signed-off-by: Mian Yousaf Kaukab <ykaukab@suse.de>
Signed-off-by: Tingwei Zhang <tingwei@codeaurora.org>
Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
Reviewed-by: Mathieu Poirier <mathieu.poirier@linaro.org>
---
 drivers/hwtracing/coresight/coresight-etb10.c   | 2 +-
 drivers/hwtracing/coresight/coresight-priv.h    | 8 ++++----
 drivers/hwtracing/coresight/coresight-tmc-etf.c | 2 +-
 drivers/hwtracing/coresight/coresight.c         | 2 +-
 4 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/hwtracing/coresight/coresight-etb10.c b/drivers/hwtracing/coresight/coresight-etb10.c
index 03e3f2590191..04ee9cda988d 100644
--- a/drivers/hwtracing/coresight/coresight-etb10.c
+++ b/drivers/hwtracing/coresight/coresight-etb10.c
@@ -525,7 +525,7 @@ static unsigned long etb_update_buffer(struct coresight_device *csdev,
 
 	cur = buf->cur;
 	offset = buf->offset;
-	barrier = barrier_pkt;
+	barrier = coresight_barrier_pkt;
 
 	for (i = 0; i < to_read; i += 4) {
 		buf_ptr = buf->data_pages[cur] + offset;
diff --git a/drivers/hwtracing/coresight/coresight-priv.h b/drivers/hwtracing/coresight/coresight-priv.h
index d801a2755432..dcb8aeb6af62 100644
--- a/drivers/hwtracing/coresight/coresight-priv.h
+++ b/drivers/hwtracing/coresight/coresight-priv.h
@@ -66,8 +66,8 @@ static DEVICE_ATTR_RO(name)
 #define coresight_simple_reg64(type, name, lo_off, hi_off)		\
 	__coresight_simple_func(type, NULL, name, lo_off, hi_off)
 
-extern const u32 barrier_pkt[4];
-#define CORESIGHT_BARRIER_PKT_SIZE (sizeof(barrier_pkt))
+extern const u32 coresight_barrier_pkt[4];
+#define CORESIGHT_BARRIER_PKT_SIZE (sizeof(coresight_barrier_pkt))
 
 enum etm_addr_type {
 	ETM_ADDR_TYPE_NONE,
@@ -104,10 +104,10 @@ struct cs_buffers {
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
index 6375504ba8b0..44402d413ebb 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -519,7 +519,7 @@ static unsigned long tmc_update_etf_buffer(struct coresight_device *csdev,
 
 	cur = buf->cur;
 	offset = buf->offset;
-	barrier = barrier_pkt;
+	barrier = coresight_barrier_pkt;
 
 	/* for every byte to read */
 	for (i = 0; i < to_read; i += 4) {
diff --git a/drivers/hwtracing/coresight/coresight.c b/drivers/hwtracing/coresight/coresight.c
index e9c90f2de34a..d515088cc47d 100644
--- a/drivers/hwtracing/coresight/coresight.c
+++ b/drivers/hwtracing/coresight/coresight.c
@@ -53,7 +53,7 @@ static struct list_head *stm_path;
  * beginning of the data collected in a buffer.  That way the decoder knows that
  * it needs to look for another sync sequence.
  */
-const u32 barrier_pkt[4] = {0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff};
+const u32 coresight_barrier_pkt[4] = {0x7fffffff, 0x7fffffff, 0x7fffffff, 0x7fffffff};
 
 static int coresight_id_match(struct device *dev, void *data)
 {
-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project

