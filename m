Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9C25CC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:56:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6A6A02072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:56:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="yYua5BbI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729157AbgHQOzf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:55:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729085AbgHQOyZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:54:25 -0400
Received: from mail-wr1-x42d.google.com (mail-wr1-x42d.google.com [IPv6:2a00:1450:4864:20::42d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 55C28C061347
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:54:25 -0700 (PDT)
Received: by mail-wr1-x42d.google.com with SMTP id a15so15288243wrh.10
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:54:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=qJhUjYD9pe9sbyMyKSKlcS+SdzILo1kQwat/pof/sCU=;
        b=yYua5BbI5qPvjuOFAm1a5cHjPY2qnsc8cWgFyPo/YK8mzHoVumQjSCoOcuNUxFTQpd
         8jnBJ2NBrqidUjdj/HyTwyv9B9e814KSgvQELwItilEBD8NL7NeVWp/qpN0wCLOpov3q
         QDRjVij9Giz3m2NzjNbUoljhXwd9Ej9IpRNqwdPmIVteiMQk8hGfVTeIk1Dg3hy1Ce5M
         pKMFp0YSBazPYlQACUX4zIO7ShnMUVUGVQHfWJeWWe5w9qKL/vODADph6dxcrup5jaSP
         zyo3lzrAO7jIJr1Jxf16oWOEk+VdTuvYZq7drRA+zN3H42cAG9OcY9hNuFtkr9gZ2nEi
         gdXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=qJhUjYD9pe9sbyMyKSKlcS+SdzILo1kQwat/pof/sCU=;
        b=mIkYJPzNBzl0PVmW8Vb30sje0hyUAY6qWiQpVy5Gh48TmtlN3LTIjKXGBuNPplH/Ji
         BmhOBFtITXU5TMdW1V9fCkN77jm6d5wJuHbqTHgdMos0ZEei1JLfZpG2LQkVQmmhbqpN
         oT8o1dFjdamD7bzvIUaOcYFegMpTU21t1rJvjYavS16u/UbmDs6g0aGy84QNaHqXrknn
         gQXCOUqtFAAeiUJjxaSFbNA9y5Q4n9fPANSb71LjIEkmMwowPURRbmyz2CuF1DqJnWm0
         b3tHYtdF3Ekf+OCbXDTa0+dCwMVgT5VSnpVnn/+lzN/V8aD4YvA1wzoWKEaWivYrtlV1
         U2bA==
X-Gm-Message-State: AOAM531H4SI8n80gX+UvjcFBjtkyxhThdPxEwGoIeDhUgkGW3vVykSsu
        50qxW9s/0z0jvfJauyUSCfVczQ==
X-Google-Smtp-Source: ABdhPJz6JSO9rpK9jOocHFumtQi/adlnWjslm2leEhx6/qjIcdJ16AOwpQ8Qdrsiv39yoREAdDddjQ==
X-Received: by 2002:a5d:414d:: with SMTP id c13mr10642133wrq.78.1597676063838;
        Mon, 17 Aug 2020 07:54:23 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id r16sm35005678wrr.13.2020.08.17.07.54.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 07:54:23 -0700 (PDT)
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
Subject: [PATCH RESEND v1 09/13] perf arm-spe: Refactor event type handling
Date:   Mon, 17 Aug 2020 15:53:44 +0100
Message-Id: <20200817145348.14461-10-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817145348.14461-1-leo.yan@linaro.org>
References: <20200817145348.14461-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use macros instead of the enum values for event types, this is more
directive and without bit shifting when parse packet.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../util/arm-spe-decoder/arm-spe-decoder.c    | 16 +++++++-------
 .../util/arm-spe-decoder/arm-spe-decoder.h    | 17 --------------
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 22 +++++++++----------
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 16 ++++++++++++++
 4 files changed, 35 insertions(+), 36 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index f7cda4a3cf1a..ae718e3419e3 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -168,31 +168,31 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 		case ARM_SPE_OP_TYPE:
 			break;
 		case ARM_SPE_EVENTS:
-			if (payload & BIT(EV_L1D_REFILL))
+			if (payload & SPE_EVT_PKT_L1D_REFILL)
 				decoder->record.type |= ARM_SPE_L1D_MISS;
 
-			if (payload & BIT(EV_L1D_ACCESS))
+			if (payload & SPE_EVT_PKT_L1D_ACCESS)
 				decoder->record.type |= ARM_SPE_L1D_ACCESS;
 
-			if (payload & BIT(EV_TLB_WALK))
+			if (payload & SPE_EVT_PKT_TLB_WALK)
 				decoder->record.type |= ARM_SPE_TLB_MISS;
 
-			if (payload & BIT(EV_TLB_ACCESS))
+			if (payload & SPE_EVT_PKT_TLB_ACCESS)
 				decoder->record.type |= ARM_SPE_TLB_ACCESS;
 
 			if ((idx == 2 || idx == 4 || idx == 8) &&
-			    (payload & BIT(EV_LLC_MISS)))
+			    (payload & SPE_EVT_PKT_LLC_MISS))
 				decoder->record.type |= ARM_SPE_LLC_MISS;
 
 			if ((idx == 2 || idx == 4 || idx == 8) &&
-			    (payload & BIT(EV_LLC_ACCESS)))
+			    (payload & SPE_EVT_PKT_LLC_ACCESS))
 				decoder->record.type |= ARM_SPE_LLC_ACCESS;
 
 			if ((idx == 2 || idx == 4 || idx == 8) &&
-			    (payload & BIT(EV_REMOTE_ACCESS)))
+			    (payload & SPE_EVT_PKT_REMOTE_ACCESS))
 				decoder->record.type |= ARM_SPE_REMOTE_ACCESS;
 
-			if (payload & BIT(EV_MISPRED))
+			if (payload & SPE_EVT_PKT_MISPREDICTED)
 				decoder->record.type |= ARM_SPE_BRANCH_MISS;
 
 			break;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index a5111a8d4360..24727b8ca7ff 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -13,23 +13,6 @@
 
 #include "arm-spe-pkt-decoder.h"
 
-enum arm_spe_events {
-	EV_EXCEPTION_GEN	= 0,
-	EV_RETIRED		= 1,
-	EV_L1D_ACCESS		= 2,
-	EV_L1D_REFILL		= 3,
-	EV_TLB_ACCESS		= 4,
-	EV_TLB_WALK		= 5,
-	EV_NOT_TAKEN		= 6,
-	EV_MISPRED		= 7,
-	EV_LLC_ACCESS		= 8,
-	EV_LLC_MISS		= 9,
-	EV_REMOTE_ACCESS	= 10,
-	EV_ALIGNMENT		= 11,
-	EV_PARTIAL_PREDICATE	= 17,
-	EV_EMPTY_PREDICATE	= 18,
-};
-
 enum arm_spe_sample_type {
 	ARM_SPE_L1D_ACCESS	= 1 << 0,
 	ARM_SPE_L1D_MISS	= 1 << 1,
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 6cb14a2141c4..78250c8d74ca 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -264,58 +264,58 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		ret = snprintf(buf, buf_len, "EV");
 		buf += ret;
 		blen -= ret;
-		if (payload & 0x1) {
+		if (payload & SPE_EVT_PKT_GEN_EXCEPTION) {
 			ret = snprintf(buf, buf_len, " EXCEPTION-GEN");
 			buf += ret;
 			blen -= ret;
 		}
-		if (payload & 0x2) {
+		if (payload & SPE_EVT_PKT_ARCH_RETIRED) {
 			ret = snprintf(buf, buf_len, " RETIRED");
 			buf += ret;
 			blen -= ret;
 		}
-		if (payload & 0x4) {
+		if (payload & SPE_EVT_PKT_L1D_ACCESS) {
 			ret = snprintf(buf, buf_len, " L1D-ACCESS");
 			buf += ret;
 			blen -= ret;
 		}
-		if (payload & 0x8) {
+		if (payload & SPE_EVT_PKT_L1D_REFILL) {
 			ret = snprintf(buf, buf_len, " L1D-REFILL");
 			buf += ret;
 			blen -= ret;
 		}
-		if (payload & 0x10) {
+		if (payload & SPE_EVT_PKT_TLB_ACCESS) {
 			ret = snprintf(buf, buf_len, " TLB-ACCESS");
 			buf += ret;
 			blen -= ret;
 		}
-		if (payload & 0x20) {
+		if (payload & SPE_EVT_PKT_TLB_WALK) {
 			ret = snprintf(buf, buf_len, " TLB-REFILL");
 			buf += ret;
 			blen -= ret;
 		}
-		if (payload & 0x40) {
+		if (payload & SPE_EVT_PKT_NOT_TAKEN) {
 			ret = snprintf(buf, buf_len, " NOT-TAKEN");
 			buf += ret;
 			blen -= ret;
 		}
-		if (payload & 0x80) {
+		if (payload & SPE_EVT_PKT_MISPREDICTED) {
 			ret = snprintf(buf, buf_len, " MISPRED");
 			buf += ret;
 			blen -= ret;
 		}
 		if (idx > 1) {
-			if (payload & 0x100) {
+			if (payload & SPE_EVT_PKT_LLC_ACCESS) {
 				ret = snprintf(buf, buf_len, " LLC-ACCESS");
 				buf += ret;
 				blen -= ret;
 			}
-			if (payload & 0x200) {
+			if (payload & SPE_EVT_PKT_LLC_MISS) {
 				ret = snprintf(buf, buf_len, " LLC-REFILL");
 				buf += ret;
 				blen -= ret;
 			}
-			if (payload & 0x400) {
+			if (payload & SPE_EVT_PKT_REMOTE_ACCESS) {
 				ret = snprintf(buf, buf_len, " REMOTE-ACCESS");
 				buf += ret;
 				blen -= ret;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index ee2c1d5054e8..16687abffab7 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -93,6 +93,22 @@ struct arm_spe_pkt {
 
 #define SPE_CNT_PKT_HDR_EXT_INDEX_MASK		(0x3)
 
+/* Event packet payload */
+#define SPE_EVT_PKT_SVE_EMPTY_PREDICATE		BIT(18)
+#define SPE_EVT_PKT_SVE_PARTIAL_PREDICATE	BIT(17)
+#define SPE_EVT_PKT_ALIGNMENT			BIT(11)
+#define SPE_EVT_PKT_REMOTE_ACCESS		BIT(10)
+#define SPE_EVT_PKT_LLC_MISS			BIT(9)
+#define SPE_EVT_PKT_LLC_ACCESS			BIT(8)
+#define SPE_EVT_PKT_MISPREDICTED		BIT(7)
+#define SPE_EVT_PKT_NOT_TAKEN			BIT(6)
+#define SPE_EVT_PKT_TLB_WALK			BIT(5)
+#define SPE_EVT_PKT_TLB_ACCESS			BIT(4)
+#define SPE_EVT_PKT_L1D_REFILL			BIT(3)
+#define SPE_EVT_PKT_L1D_ACCESS			BIT(2)
+#define SPE_EVT_PKT_ARCH_RETIRED		BIT(1)
+#define SPE_EVT_PKT_GEN_EXCEPTION		BIT(0)
+
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
 int arm_spe_get_packet(const unsigned char *buf, size_t len,
-- 
2.17.1

