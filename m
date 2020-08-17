Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 597EDC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D0B12072E
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:55:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="YRHy6Ddk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729171AbgHQOzh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:55:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729092AbgHQOya (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:54:30 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D087C061389
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:54:29 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id p14so13473103wmg.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:54:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:subject:date:message-id:in-reply-to:references;
        bh=/J6XwtP+H4HpYFvHEI0FwKaKGsrsWXlEj5IBcsGoHk8=;
        b=YRHy6DdkOBrydyJjMgR/tIuZqPnHdhXI4rbPEwUh0BoaW4p//1RIH3SJ2ozRK59b29
         2ayzTb/MUSKZY8qxncecsYuce0C+DpTmKETrKJoZficx7SbMiyUwnnbdlQ3JabqvGHZU
         xjgpy+MuB/ItMuHXOuW5GGYhDcHat1b8XA1+4vsHKfcfIIgmc1WujUKHiOBkF1q8dres
         psFDVcupFPjKV6jnrtG2h0l6cHvZkHBZz0l/Xx425RvRdH2fq6DYvZo8aeU5HXO4TNHI
         fBh6XqdlQPKWS5pvo+vL9I2hxjKgewC3uKtfqvNqT6RfsQI87OpRV3XkCX0zFfnQH5SH
         vMeA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:subject:date:message-id:in-reply-to
         :references;
        bh=/J6XwtP+H4HpYFvHEI0FwKaKGsrsWXlEj5IBcsGoHk8=;
        b=ZsphUZP7UBgccgUVq1HmaoE3IizQpNtsn9bWJgNIirpgFMQS1qTTcEwNZqx6qKmMSp
         WrZHbbRF/VzufJldVMMZavoNvOMixwY9IUs76lpU28D2O8twWWqkpLoMZUQIEXdZbiyQ
         BYx1LhqN+J1ljMMdDWdKg2zI1/+F2bnfo9AVBoyB2Chjkmu/SgbUbF/pvrB3nN7h/u7R
         ahQLM8Zif6EX+PeTFlIzOaohwnWDoAQ9C9i/wKK/tP0c40kkLkPr/TDZML0cwyZv/BOA
         c3Mj9ma3iN/wxT8I8ga7efW89x97+GSOTyXYp69SEFQ+BdYx5YxMxAZ0SypNjwKZJuFS
         mx+Q==
X-Gm-Message-State: AOAM53172l7v6mM9pq8HMV6PiOUPUPSfpWKJwNjuvODZDNOnRrQNgWv/
        01ONRjyaLWF3+1+DHTxcxY25tqooRE/IxUFw
X-Google-Smtp-Source: ABdhPJwyZbUMf3XOfThCucSdueaWkX8qCd5VOvOTf4QgkYC/9M7Pj4fQtE9BEJqnoCFNRgkkWspoOA==
X-Received: by 2002:a1c:a553:: with SMTP id o80mr14735459wme.50.1597676068187;
        Mon, 17 Aug 2020 07:54:28 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id r16sm35005678wrr.13.2020.08.17.07.54.27
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 07:54:27 -0700 (PDT)
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
Subject: [PATCH RESEND v1 13/13] perf arm-spe: Add support for ARMv8.3-SPE
Date:   Mon, 17 Aug 2020 15:53:48 +0100
Message-Id: <20200817145348.14461-14-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817145348.14461-1-leo.yan@linaro.org>
References: <20200817145348.14461-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wei Li <liwei391@huawei.com>

This patch is to support Armv8.3 extension for SPE, it adds alignment
field in the Events packet and it supports the Scalable Vector Extension
(SVE) for Operation packet and Events packet with two additions:

  - The vector length for SVE operations in the Operation Type packet;
  - The incomplete predicate and empty predicate fields in the Events
    packet.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 95 ++++++++++++++++++-
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     |  6 ++
 2 files changed, 98 insertions(+), 3 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 095f344ee26c..637655e28b9f 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -346,14 +346,77 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 				blen -= ret;
 			}
 		}
+
+		if (idx > 2) {
+			if (payload & SPE_EVT_PKT_ALIGNMENT) {
+				ret = snprintf(buf, buf_len, " ALIGNMENT");
+				if (ret < 0)
+					return ret;
+				buf += ret;
+				blen -= ret;
+			}
+			if (payload & SPE_EVT_PKT_SVE_PARTIAL_PREDICATE) {
+				ret = snprintf(buf, buf_len, " SVE-PARTIAL-PRED");
+				if (ret < 0)
+					return ret;
+				buf += ret;
+				blen -= ret;
+			}
+			if (payload & SPE_EVT_PKT_SVE_EMPTY_PREDICATE) {
+				ret = snprintf(buf, buf_len, " SVE-EMPTY-PRED");
+				if (ret < 0)
+					return ret;
+				buf += ret;
+				blen -= ret;
+			}
+		}
+
 		return buf_len - blen;
 	}
 	case ARM_SPE_OP_TYPE:
 		switch (idx) {
 		case SPE_OP_PKT_HDR_CLASS_OTHER:
-			return snprintf(buf, buf_len, "%s",
-					payload & SPE_OP_PKT_OTHER_SUBCLASS_COND ?
-					"COND-SELECT" : "INSN-OTHER");
+			blen = buf_len;
+
+			if ((payload & SPE_OP_PKT_OTHER_SVE_SUBCLASS_MASK) ==
+					SPE_OP_PKT_OTHER_SUBCLASS_SVG_OP) {
+				ret = snprintf(buf, buf_len, "SVE-OTHER");
+				buf += ret;
+				blen -= ret;
+
+				/* Effective Venctor Length */
+				ret = snprintf(buf, buf_len, " EVL %d",
+					32 << ((payload & SPE_OP_PKT_SVE_EVL_MASK) >>
+						SPE_OP_PKT_SVE_EVL_SHIFT));
+				buf += ret;
+				blen -= ret;
+
+				if (payload & SPE_OP_PKT_SVE_FP) {
+					ret = snprintf(buf, buf_len, " FP");
+					buf += ret;
+					blen -= ret;
+				}
+				if (payload & SPE_OP_PKT_SVE_PRED) {
+					ret = snprintf(buf, buf_len, " PRED");
+					buf += ret;
+					blen -= ret;
+				}
+			} else {
+				ret = snprintf(buf, buf_len, "OTHER");
+				buf += ret;
+				blen -= ret;
+
+				ret = snprintf(buf, buf_len, " %s",
+					       payload & SPE_OP_PKT_OTHER_SUBCLASS_COND ?
+					       "COND-SELECT" : "UNCOND");
+				buf += ret;
+				blen -= ret;
+			}
+
+			if (ret < 0)
+				return ret;
+			return buf_len - blen;
+
 		case SPE_OP_PKT_HDR_CLASS_LD_ST_ATOMIC:
 			blen = buf_len;
 
@@ -416,6 +479,32 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 					return ret;
 				buf += ret;
 				blen -= ret;
+			} else if ((payload & SPE_OP_PKT_LDST_SUBCLASS_SVE_MASK) ==
+					SPE_OP_PKT_LDST_SUBCLASS_SVE) {
+				/* Effective Venctor Length */
+				ret = snprintf(buf, buf_len, " EVL %d",
+					32 << ((payload & SPE_OP_PKT_SVE_EVL_MASK) >>
+						SPE_OP_PKT_SVE_EVL_SHIFT));
+				if (ret < 0)
+					return ret;
+
+				buf += ret;
+				blen -= ret;
+
+				if (payload & SPE_OP_PKT_SVE_PRED) {
+					ret = snprintf(buf, buf_len, " PRED");
+					if (ret < 0)
+						return ret;
+					buf += ret;
+					blen -= ret;
+				}
+				if (payload & SPE_OP_PKT_SVE_SG) {
+					ret = snprintf(buf, buf_len, " SG");
+					if (ret < 0)
+						return ret;
+					buf += ret;
+					blen -= ret;
+				}
 			}
 			return buf_len - blen;
 		case SPE_OP_PKT_HDR_CLASS_BR_ERET:
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 295ff8779ce4..1a917a11b395 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -140,6 +140,12 @@ struct arm_spe_pkt {
 #define SPE_OP_PKT_LDST_SUBCLASS_SVE_MASK	(0xa)
 #define SPE_OP_PKT_LDST_SUBCLASS_SVE		(0x8)
 
+#define SPE_OP_PKT_SVE_SG			BIT(7)
+#define SPE_OP_PKT_SVE_EVL_MASK			(0x70)
+#define SPE_OP_PKT_SVE_EVL_SHIFT		(4)
+#define SPE_OP_PKT_SVE_PRED			BIT(2)
+#define SPE_OP_PKT_SVE_FP			BIT(1)
+
 #define SPE_OP_PKT_AR				BIT(4)
 #define SPE_OP_PKT_EXCL				BIT(3)
 #define SPE_OP_PKT_AT				BIT(2)
-- 
2.17.1

