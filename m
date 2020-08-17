Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A77E7C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:55:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7BB24204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:55:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="nMCBPi8C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729146AbgHQOzD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:55:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729088AbgHQOy2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:54:28 -0400
Received: from mail-wm1-x331.google.com (mail-wm1-x331.google.com [IPv6:2a00:1450:4864:20::331])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BEE6C061343
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:54:27 -0700 (PDT)
Received: by mail-wm1-x331.google.com with SMTP id x5so13469442wmi.2
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:54:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=F1rQC8InrizybEEB/4Emq04/44LaOPA48rxi067P9h0=;
        b=nMCBPi8C+XuQxWVFnCovzNafNtlmsMIQ/3+dl4qkFuWvZV0XhIDiYZ+BtwqrlgWlOM
         l3ZsfI5eL908culqS6rkvQH90uwqYzm9iW9qHGzYAdj+rdI8dcQl6xD0gG0b8GHMrRWC
         am6Fve746TwNrklLeLCFcCd/CuYOJBQ9hkNAEOOcirJPbrbrVxDEfaR1vF13awDO3vpm
         Rjy7dJprH1/pZyZnKiboEe4ggcmCgli/ONsrbH/IqFz3FBvJM+jI+OzrTYf2exN3FvKK
         ybpDsVZZoUUrxItVK22GMuo850g7rRgKxxsvEcGBATR9/kavPyI2SfIyT/35tXmTAThZ
         4DzQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=F1rQC8InrizybEEB/4Emq04/44LaOPA48rxi067P9h0=;
        b=CQKZT4BiJ9wcnw2nI2qDUz/LBqMgui8i6EbDL6si4YrQKHwTbQJzrMShKaoKMyAJ0K
         urw0Wbi0vC4ooZNiJhvaQhoHuub33E0NdrZXSF0ilOxdvWFePg74YJkb9YYRmgfvTSC0
         nk38c59q2yLLmIMOxQOJOa8UiDGjbU5HMNsV3+zNjwRuOk65/L/KO/SCDxd3wFoqZv5t
         2f+aoDBqm7tq8Myuxnhl+FHNryTlpcEGw7vFNksOZhTffhcP3Bcqka1N6qREZiqbPYLp
         6R8jvMjxa6J2ClFuC3gSwk7wALswtIxXSoO95GMTujfaHEKRVpxbltFL8S0qNUt+RZh4
         m+JQ==
X-Gm-Message-State: AOAM533vIcdYhZC09IzA4lxuVEekQ8vOSNhdhOLCvC1KhsqKPVJKBqxq
        OqmVAL7rh66VH0k18FC60Ry1Uw==
X-Google-Smtp-Source: ABdhPJwLVcEfZ0/2b+bjqfO1y0nb+ETULYYhqmlsoIievdJbW0fOJPIlKQFFR03hmLLacB1cRU/kQg==
X-Received: by 2002:a1c:e912:: with SMTP id q18mr14827519wmc.130.1597676065910;
        Mon, 17 Aug 2020 07:54:25 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id r16sm35005678wrr.13.2020.08.17.07.54.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 07:54:25 -0700 (PDT)
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
Subject: [PATCH RESEND v1 11/13] perf arm-spe: Refactor operation packet handling
Date:   Mon, 17 Aug 2020 15:53:46 +0100
Message-Id: <20200817145348.14461-12-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817145348.14461-1-leo.yan@linaro.org>
References: <20200817145348.14461-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defines macros for operation packet header and formats (support sub
classes for 'other', 'branch', 'load and store', etc).  Uses these
macros for operation packet decoding and dumping.

This patch checks the return value from snprintf(), will bail out if
detects any failure for operation packet handling.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 65 ++++++++++++-------
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 36 ++++++++++
 2 files changed, 76 insertions(+), 25 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 121414e4ae23..ab966885e892 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -141,7 +141,7 @@ static int arm_spe_get_op_type(const unsigned char *buf, size_t len,
 			       struct arm_spe_pkt *packet)
 {
 	packet->type = ARM_SPE_OP_TYPE;
-	packet->index = buf[0] & 0x3;
+	packet->index = buf[0] & SPE_OP_PKT_HDR_CLASS_MASK;
 	return arm_spe_get_payload(buf, len, 0, packet);
 }
 
@@ -251,6 +251,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 	int ret, ns, el, idx = packet->index;
 	unsigned long long payload = packet->payload;
 	const char *name = arm_spe_pkt_name(packet->type);
+	size_t blen;
 
 	switch (packet->type) {
 	case ARM_SPE_BAD:
@@ -258,7 +259,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 	case ARM_SPE_END:
 		return snprintf(buf, buf_len, "%s", name);
 	case ARM_SPE_EVENTS: {
-		size_t blen = buf_len;
+		blen = buf_len;
 
 		ret = 0;
 		ret = snprintf(buf, buf_len, "EV");
@@ -349,65 +350,79 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 	}
 	case ARM_SPE_OP_TYPE:
 		switch (idx) {
-		case 0:	return snprintf(buf, buf_len, "%s", payload & 0x1 ?
+		case SPE_OP_PKT_HDR_CLASS_OTHER:
+			return snprintf(buf, buf_len, "%s",
+					payload & SPE_OP_PKT_OTHER_SUBCLASS_COND ?
 					"COND-SELECT" : "INSN-OTHER");
-		case 1:	{
-			size_t blen = buf_len;
+		case SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC:
+			blen = buf_len;
 
-			if (payload & 0x1)
+			if (payload & SPE_OP_PKT_LDST)
 				ret = snprintf(buf, buf_len, "ST");
 			else
 				ret = snprintf(buf, buf_len, "LD");
+			if (ret < 0)
+				return ret;
 			buf += ret;
 			blen -= ret;
-			if (payload & 0x2) {
-				if (payload & 0x4) {
+			if ((payload & SPE_OP_PKT_LDST_SUBCLASS_ATOMIC_MASK) ==
+					SPE_OP_PKT_LDST_SUBCLASS_ATOMIC) {
+				if (payload & SPE_OP_PKT_AT) {
 					ret = snprintf(buf, buf_len, " AT");
+					if (ret < 0)
+						return ret;
 					buf += ret;
 					blen -= ret;
 				}
-				if (payload & 0x8) {
+				if (payload & SPE_OP_PKT_EXCL) {
 					ret = snprintf(buf, buf_len, " EXCL");
+					if (ret < 0)
+						return ret;
 					buf += ret;
 					blen -= ret;
 				}
-				if (payload & 0x10) {
+				if (payload & SPE_OP_PKT_AR) {
 					ret = snprintf(buf, buf_len, " AR");
+					if (ret < 0)
+						return ret;
 					buf += ret;
 					blen -= ret;
 				}
-			} else if (payload & 0x4) {
+			} else if ((payload & SPE_OP_PKT_LDST_SUBCLASS_MASK) ==
+					SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP) {
 				ret = snprintf(buf, buf_len, " SIMD-FP");
+				if (ret < 0)
+					return ret;
 				buf += ret;
 				blen -= ret;
 			}
-			if (ret < 0)
-				return ret;
-			blen -= ret;
 			return buf_len - blen;
-		}
-		case 2:	{
-			size_t blen = buf_len;
+		case SPE_OP_PKT_HDR_CLASS_BR_ERET:
+			blen = buf_len;
 
 			ret = snprintf(buf, buf_len, "B");
+			if (ret < 0)
+				return ret;
 			buf += ret;
 			blen -= ret;
-			if (payload & 0x1) {
+			if (payload & SPE_OP_PKT_BRANCH_SUBCLASS_COND) {
 				ret = snprintf(buf, buf_len, " COND");
+				if (ret < 0)
+					return ret;
 				buf += ret;
 				blen -= ret;
 			}
-			if (payload & 0x2) {
+			if ((payload & SPE_OP_PKT_BRANCH_SUBCLASS_MASK) ==
+					SPE_OP_PKT_BRANCH_SUBCLASS_INDIRECT) {
 				ret = snprintf(buf, buf_len, " IND");
+				if (ret < 0)
+					return ret;
 				buf += ret;
 				blen -= ret;
 			}
-			if (ret < 0)
-				return ret;
-			blen -= ret;
 			return buf_len - blen;
-			}
-		default: return 0;
+		default:
+			return 0;
 		}
 	case ARM_SPE_DATA_SOURCE:
 	case ARM_SPE_TIMESTAMP:
@@ -436,7 +451,7 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		return snprintf(buf, buf_len, "%s 0x%lx el%d", name,
 				(unsigned long)payload, idx + 1);
 	case ARM_SPE_COUNTER: {
-		size_t blen = buf_len;
+		blen = buf_len;
 
 		ret = snprintf(buf, buf_len, "%s %d ", name,
 			       (unsigned short)payload);
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 16687abffab7..295ff8779ce4 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -109,6 +109,42 @@ struct arm_spe_pkt {
 #define SPE_EVT_PKT_ARCH_RETIRED		BIT(1)
 #define SPE_EVT_PKT_GEN_EXCEPTION		BIT(0)
 
+/* Operation packet header */
+#define SPE_OP_PKT_HDR_CLASS_MASK		(0x7)
+#define SPE_OP_PKT_HDR_CLASS_OTHER		(0x0)
+#define SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC	(0x1)
+#define SPE_OP_PKT_HDR_CLASS_BR_ERET		(0x2)
+
+#define SPE_OP_PKT_OTHER_SUBCLASS_MASK		(0xfe)
+#define SPE_OP_PKT_OTHER_SUBCLASS_OTHER_OP	(0x0)
+#define SPE_OP_PKT_OTHER_SVE_SUBCLASS_MASK	(0x89)
+#define SPE_OP_PKT_OTHER_SUBCLASS_SVG_OP	(0x8)
+
+#define SPE_OP_PKT_OTHER_SUBCLASS_COND		BIT(0)
+
+#define SPE_OP_PKT_BRANCH_SUBCLASS_MASK		(0xfe)
+#define SPE_OP_PKT_BRANCH_SUBCLASS_DIRECT	(0x0)
+#define SPE_OP_PKT_BRANCH_SUBCLASS_INDIRECT	(0x2)
+
+#define SPE_OP_PKT_BRANCH_SUBCLASS_COND		BIT(0)
+
+#define SPE_OP_PKT_LDST_SUBCLASS_MASK		(0xfe)
+#define SPE_OP_PKT_LDST_SUBCLASS_GP_REG		(0x0)
+#define SPE_OP_PKT_LDST_SUBCLASS_SIMD_FP	(0x4)
+#define SPE_OP_PKT_LDST_SUBCLASS_UNSPEC_REG	(0x10)
+#define SPE_OP_PKT_LDST_SUBCLASS_MRS_MSR	(0x30)
+
+#define SPE_OP_PKT_LDST_SUBCLASS_ATOMIC_MASK	(0xe2)
+#define SPE_OP_PKT_LDST_SUBCLASS_ATOMIC		(0x2)
+
+#define SPE_OP_PKT_LDST_SUBCLASS_SVE_MASK	(0xa)
+#define SPE_OP_PKT_LDST_SUBCLASS_SVE		(0x8)
+
+#define SPE_OP_PKT_AR				BIT(4)
+#define SPE_OP_PKT_EXCL				BIT(3)
+#define SPE_OP_PKT_AT				BIT(2)
+#define SPE_OP_PKT_LDST				BIT(0)
+
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
 int arm_spe_get_packet(const unsigned char *buf, size_t len,
-- 
2.17.1

