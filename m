Return-Path: <SRS0=4orP=BD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9FB71C433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:18:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8400C2063A
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jul 2020 09:18:08 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728163AbgGXJSH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jul 2020 05:18:07 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:56724 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726572AbgGXJSE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jul 2020 05:18:04 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id DAB427DECD0A04FB1572;
        Fri, 24 Jul 2020 17:18:02 +0800 (CST)
Received: from euler.huawei.com (10.175.124.27) by
 DGGEMS412-HUB.china.huawei.com (10.3.19.212) with Microsoft SMTP Server id
 14.3.487.0; Fri, 24 Jul 2020 17:17:53 +0800
From:   Wei Li <liwei391@huawei.com>
To:     Adrian Hunter <adrian.hunter@intel.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        James Clark <james.clark@arm.com>,
        Jiri Olsa <jolsa@redhat.com>, Leo Yan <leo.yan@linaro.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Will Deacon <will@kernel.org>, <zhangshaokun@hisilicon.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>, <guohanjun@huawei.com>
Subject: [PATCH 2/4] perf: arm-spe: Add support for ARMv8.3-SPE
Date:   Fri, 24 Jul 2020 17:16:05 +0800
Message-ID: <20200724091607.41903-3-liwei391@huawei.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200724091607.41903-1-liwei391@huawei.com>
References: <20200724091607.41903-1-liwei391@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.175.124.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Armv8.3 extends the SPE by adding:
- Alignment field in the Events packet, and filtering on this event
  using PMSEVFR_EL1.
- Support for the Scalable Vector Extension (SVE).

The main additions for SVE are:
- Recording the vector length for SVE operations in the Operation Type
  packet. It is not possible to filter on vector length.
- Incomplete predicate and empty predicate fields in the Events packet,
  and filtering on these events using PMSEVFR_EL1.

Add the corresponding decode process of Events packet and Operation Type
packet in perf tool.

Signed-off-by: Wei Li <liwei391@huawei.com>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 69 ++++++++++++++++++-
 1 file changed, 67 insertions(+), 2 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index b94001b756c7..10a3692839de 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -347,6 +347,24 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 				blen -= ret;
 			}
 		}
+		if (idx > 2) {
+			if (payload & 0x800) {
+				ret = snprintf(buf, buf_len, " ALIGNMENT");
+				buf += ret;
+				blen -= ret;
+			}
+			if (payload & 0x20000) {
+				ret = snprintf(buf, buf_len, " SVE-PRED-PARTIAL");
+				buf += ret;
+				blen -= ret;
+			}
+			if (payload & 0x40000) {
+				ret = snprintf(buf, buf_len, " SVE-PRED-EMPTY");
+				buf += ret;
+				blen -= ret;
+			}
+		}
+
 		if (ret < 0)
 			return ret;
 		blen -= ret;
@@ -354,8 +372,38 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 	}
 	case ARM_SPE_OP_TYPE:
 		switch (idx) {
-		case 0:	return snprintf(buf, buf_len, "%s", payload & 0x1 ?
-					"COND-SELECT" : "INSN-OTHER");
+		case 0:	{
+			if (payload & 0x8) {
+				size_t blen = buf_len;
+
+				ret = snprintf(buf, buf_len, "SVE-OTHER");
+				buf += ret;
+				blen -= ret;
+				if (payload & 0x2) {
+					ret = snprintf(buf, buf_len, " FP");
+					buf += ret;
+					blen -= ret;
+				}
+				if (payload & 0x4) {
+					ret = snprintf(buf, buf_len, " PRED");
+					buf += ret;
+					blen -= ret;
+				}
+				if (payload & 0x70) {
+					ret = snprintf(buf, buf_len, " EVL %d",
+						32 << ((payload & 0x70) >> 4));
+					buf += ret;
+					blen -= ret;
+				}
+				if (ret < 0)
+					return ret;
+				blen -= ret;
+				return buf_len - blen;
+			} else {
+				return snprintf(buf, buf_len, "%s", payload & 0x1 ?
+						"COND-SELECT" : "INSN-OTHER");
+			}
+		}
 		case 1:	{
 			size_t blen = buf_len;
 
@@ -385,6 +433,23 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 				ret = snprintf(buf, buf_len, " SIMD-FP");
 				buf += ret;
 				blen -= ret;
+			} else if (payload & 0x8) {
+				if (payload & 0x4) {
+					ret = snprintf(buf, buf_len, " PRED");
+					buf += ret;
+					blen -= ret;
+				}
+				if (payload & 0x70) {
+					ret = snprintf(buf, buf_len, " EVL %d",
+						32 << ((payload & 0x70) >> 4));
+					buf += ret;
+					blen -= ret;
+				}
+				if (payload & 0x80) {
+					ret = snprintf(buf, buf_len, " SG");
+					buf += ret;
+					blen -= ret;
+				}
 			}
 			if (ret < 0)
 				return ret;
-- 
2.17.1

