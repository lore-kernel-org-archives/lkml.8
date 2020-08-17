Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FD46C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7F87F20729
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="KuVePcIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729129AbgHQOyx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:54:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729084AbgHQOyY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:54:24 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA24AC061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:54:23 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id c15so15284863wrs.11
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:54:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=IimkwTphS8r4/JbAVEFyEhdxAiYQLhWE6LZk07S8n0M=;
        b=KuVePcIxHIoIKal3CSA4rjljA5s+8Y+MFUm+goTkzr5b8RLGXOM7yhoBO7oZXJ0wdd
         ynN8e5w7muDPW4Yh8amc1otqyjh7eNI98uUmjsDHEWwSZER1mupTBYKE4K5Bf5ahrIKJ
         0JdiIhqwg9FbxhjUvSfOvns2H3PgweBdhuyHlnHtFUkZHPske/KQOYPdKg8uu3jLIxKH
         8U0/3gK79vx3o9WxwyzbByUkKjImpUd3vIxY23wpwdBgL6bUA2s13X2MEuZWjNMCRt9W
         cgur5JZn8YU4D4SLIetBIpL8DCTa9eU07drSxIIYeIwtj2uTPvh3Wf0szOqGaC9BwyfN
         ROfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=IimkwTphS8r4/JbAVEFyEhdxAiYQLhWE6LZk07S8n0M=;
        b=Guthz6t/fL1uM4U72NYcLGc/lAcv6nuR8UCiNnFL/2dNaUoznqmwDuci1Ht52L8pmy
         9ADKo+ooeSUJAy8WshV9W1myQXRizhL3MPEHFlxaAGDMI4Tl5EInU1Iqkr+IvEsAqUn7
         qgwe0HDnX/JgbCHlkMJ+xXtC2PlycVjEBuFwnfkxDCvmTDIbIMQPRnkX5mp2wo1R2HCI
         atMFb5UShK+65arSwPArLmX91ChcdFzbvTc9b37Lx21UZjmUjwxjriCWLNJxgBSveKBo
         8JwmJ9gZbN4eSyP1AIMCMcmojNRsJShz4yog0btmPlHLYO+rDD2ysrD0iKThe27DZHC1
         QXEA==
X-Gm-Message-State: AOAM530H4kijgq8i8be9IFiMuI8dgzLj33ZB0VIyd/1LFh8xKnG1HpS7
        u8PAq0fcOhLjgcGKC+kaZA89qQ==
X-Google-Smtp-Source: ABdhPJwm5ib43PcaD74e5kFQhhqM7SpAvAx5f684Jg705F011JkyNA9RyqtB4D+kIf8YaZeBzwsCfQ==
X-Received: by 2002:adf:e911:: with SMTP id f17mr15665978wrm.397.1597676062673;
        Mon, 17 Aug 2020 07:54:22 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id r16sm35005678wrr.13.2020.08.17.07.54.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 07:54:22 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        James Clark <james.clark@arm.com>,
        Will Deacon <will@kernel.org>, Al Grant <Al.Grant@arm.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Wei Li <liwei391@huawei.com>, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH RESEND v1 08/13] perf arm-spe: Refactor counter packet handling
Date:   Mon, 17 Aug 2020 15:53:43 +0100
Message-Id: <20200817145348.14461-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817145348.14461-1-leo.yan@linaro.org>
References: <20200817145348.14461-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch defines macros for counter packet header, and uses macro to
replace hard code values for packet parsing.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 21 +++++++++++++------
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     |  8 +++++++
 2 files changed, 23 insertions(+), 6 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index ad8797f12d36..6cb14a2141c4 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -150,9 +150,10 @@ static int arm_spe_get_counter(const unsigned char *buf, size_t len,
 {
 	packet->type = ARM_SPE_COUNTER;
 	if (ext_hdr)
-		packet->index = ((buf[0] & 0x3) << 3) | (buf[1] & 0x7);
+		packet->index = (((buf[0] & SPE_CNT_PKT_HDR_EXT_INDEX_MASK) << 3) |
+				  (buf[1] & SPE_CNT_PKT_HDR_INDEX_MASK));
 	else
-		packet->index = buf[0] & 0x7;
+		packet->index = buf[0] & SPE_CNT_PKT_HDR_INDEX_MASK;
 
 	return arm_spe_get_payload(buf, len, ext_hdr, packet);
 }
@@ -421,10 +422,18 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		buf += ret;
 		blen -= ret;
 		switch (idx) {
-		case 0:	ret = snprintf(buf, buf_len, "TOT"); break;
-		case 1:	ret = snprintf(buf, buf_len, "ISSUE"); break;
-		case 2:	ret = snprintf(buf, buf_len, "XLAT"); break;
-		default: ret = 0;
+		case SPE_CNT_PKT_HDR_INDEX_TOTAL_LAT:
+			ret = snprintf(buf, buf_len, "TOT");
+			break;
+		case SPE_CNT_PKT_HDR_INDEX_ISSUE_LAT:
+			ret = snprintf(buf, buf_len, "ISSUE");
+			break;
+		case SPE_CNT_PKT_HDR_INDEX_TRANS_LAT:
+			ret = snprintf(buf, buf_len, "XLAT");
+			break;
+		default:
+			ret = 0;
+			break;
 		}
 		if (ret < 0)
 			return ret;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index db9f124fb1f4..ee2c1d5054e8 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -85,6 +85,14 @@ struct arm_spe_pkt {
 /* Context packet header */
 #define SPE_CTX_PKT_HDR_INDEX_MASK		(0x3)
 
+/* Counter packet header */
+#define SPE_CNT_PKT_HDR_INDEX_MASK		(0x7)
+#define SPE_CNT_PKT_HDR_INDEX_TOTAL_LAT		(0x0)
+#define SPE_CNT_PKT_HDR_INDEX_ISSUE_LAT		(0x1)
+#define SPE_CNT_PKT_HDR_INDEX_TRANS_LAT		(0x2)
+
+#define SPE_CNT_PKT_HDR_EXT_INDEX_MASK		(0x3)
+
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
 int arm_spe_get_packet(const unsigned char *buf, size_t len,
-- 
2.17.1

