Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BEA09C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:54:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 93ACE204FD
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:54:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="zjBDryM5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729123AbgHQOyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:54:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729081AbgHQOyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:54:22 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB93AC061345
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:54:21 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id d190so13460958wmd.4
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=GtMcTuEWxw4WMYi3XtDif+GJinzgGSAvbSsonS0RpjY=;
        b=zjBDryM59RtrWXK2n+jmxXaGHgBWD/G9evTbCGYkhAIinV4u3UG4F0rLXbghkhNeWn
         MatZlGgsiQ1zDw2Qdle4L2OjBh68mvU3e9+tDO1NFI4by/5QJRtx1x2VOa2ijL1Ar7V3
         ww1ldVLWDm0M8NRNv77nPgU6nitSalVs4SbbMPeD9k8pz1k/AlO7Tw7zqqehZXu/dxm/
         94ZXxQDbcsC2IVNXqbTcluSu5cc/HrCWN1EolKnUBlhpebN9JJV+Mp9tg7lrrSUM18fT
         HqozQX7cW/wmQSmag1MkjvPxyWsKdkFwiAAw2uosLtC0KFeQqSzvhoChdP9EtmgWtIdT
         dFsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=GtMcTuEWxw4WMYi3XtDif+GJinzgGSAvbSsonS0RpjY=;
        b=Ao2BokhwdHCHHKXlxvCJOW/skKjX8G9ehvKjHvivwBhoilfloibjPmU39aBk/HtgCU
         z46NxI9TeqmUfuCy56Ysbu1wUiY8OUYyu2XcjWcLoWiqLsofx5ejGdwhcA71fRBHZDva
         CHbfLObFk+NqsyoXLGsy0mpYZ6Im4Q2CYMMr5LAEZyuIHnRpI5Ai7giaqEmETOhVbDJJ
         /u/p/N5M+CbHzZon1Q2nUGA7wDjXL6Xm1LJoi824onkgYJQK+iueia7ATaU7DwH6yTi4
         U3GEBBYUAMGJJ0n2/QKV/5mM7gJXngjlo/QQtmCHZdScDfSLNTyfVAsoulVZytARn7xz
         I6sQ==
X-Gm-Message-State: AOAM532EHOwvZ0WE+blkQydkgaHOktajf9aWyldP812/NtZJ80vPOrGG
        4bEqkBeiK2Jy6nLM3p2Ej/6phw==
X-Google-Smtp-Source: ABdhPJwNER+7oCBKYYRAE3gIZGqhMaMZOcoirL9bHIBH5QzpKQoGthec87ElCc9GZLOVrzDeDTnMVA==
X-Received: by 2002:a7b:cd09:: with SMTP id f9mr14214435wmj.184.1597676060489;
        Mon, 17 Aug 2020 07:54:20 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id r16sm35005678wrr.13.2020.08.17.07.54.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 07:54:19 -0700 (PDT)
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
Subject: [PATCH RESEND v1 06/13] perf arm-spe: Refactor address packet handling
Date:   Mon, 17 Aug 2020 15:53:41 +0100
Message-Id: <20200817145348.14461-7-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817145348.14461-1-leo.yan@linaro.org>
References: <20200817145348.14461-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to refactor address packet handling, it defines macros for
address packet's header and payload, these macros are used by decoder
and the dump flow.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../util/arm-spe-decoder/arm-spe-decoder.c    | 33 ++++++++++---------
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 31 +++++++++--------
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     | 28 +++++++++++-----
 3 files changed, 54 insertions(+), 38 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index cc18a1e8c212..f7cda4a3cf1a 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -24,36 +24,37 @@
 
 static u64 arm_spe_calc_ip(int index, u64 payload)
 {
-	u8 *addr = (u8 *)&payload;
-	int ns, el;
+	u64 ns, el;
 
 	/* Instruction virtual address or Branch target address */
 	if (index == SPE_ADDR_PKT_HDR_INDEX_INS ||
 	    index == SPE_ADDR_PKT_HDR_INDEX_BRANCH) {
-		ns = addr[7] & SPE_ADDR_PKT_NS;
-		el = (addr[7] & SPE_ADDR_PKT_EL_MASK) >> SPE_ADDR_PKT_EL_OFFSET;
+		ns = payload & SPE_ADDR_PKT_INST_VA_NS;
+		el = payload >> SPE_ADDR_PKT_INST_VA_EL_SHIFT;
+		el &= SPE_ADDR_PKT_INST_VA_EL_MASK;
+
+		/* Clean highest byte */
+		payload &= GENMASK(SPE_ADDR_PKT_ADDR_MSB, 0);
 
 		/* Fill highest byte for EL1 or EL2 (VHE) mode */
-		if (ns && (el == SPE_ADDR_PKT_EL1 || el == SPE_ADDR_PKT_EL2))
-			addr[7] = 0xff;
-		/* Clean highest byte for other cases */
-		else
-			addr[7] = 0x0;
+		if (ns && (el == SPE_ADDR_PKT_INST_VA_EL1 ||
+			   el == SPE_ADDR_PKT_INST_VA_EL2))
+			payload |= 0xffULL << (SPE_ADDR_PKT_ADDR_MSB + 1);
 
 	/* Data access virtual address */
 	} else if (index == SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT) {
 
+		/* Clean tags */
+		payload &= GENMASK(SPE_ADDR_PKT_ADDR_MSB, 0);
+
 		/* Fill highest byte if bits [48..55] is 0xff */
-		if (addr[6] == 0xff)
-			addr[7] = 0xff;
-		/* Otherwise, cleanup tags */
-		else
-			addr[7] = 0x0;
+		if ((payload & GENMASK(SPE_ADDR_PKT_ADDR_MSB, 48)) == (0xffULL << 48))
+			payload |= 0xffULL << (SPE_ADDR_PKT_ADDR_MSB + 1);
 
 	/* Data access physical address */
 	} else if (index == SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS) {
-		/* Cleanup byte 7 */
-		addr[7] = 0x0;
+		/* Clean highest byte */
+		payload &= GENMASK(SPE_ADDR_PKT_ADDR_MSB, 0);
 	} else {
 		pr_err("unsupported address packet index: 0x%x\n", index);
 	}
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 5f4f900a9980..bbc8b0178f67 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -12,9 +12,6 @@
 
 #include "arm-spe-pkt-decoder.h"
 
-#define NS_FLAG		BIT(63)
-#define EL_FLAG		(BIT(62) | BIT(61))
-
 #if __BYTE_ORDER == __BIG_ENDIAN
 #define le16_to_cpu bswap_16
 #define le32_to_cpu bswap_32
@@ -165,9 +162,10 @@ static int arm_spe_get_addr(const unsigned char *buf, size_t len,
 {
 	packet->type = ARM_SPE_ADDRESS;
 	if (ext_hdr)
-		packet->index = ((buf[0] & 0x3) << 3) | (buf[1] & 0x7);
+		packet->index = (((buf[0] & SPE_ADDR_PKT_HDR_EXT_INDEX_MASK) << 3) |
+				  (buf[1] & SPE_ADDR_PKT_HDR_INDEX_MASK));
 	else
-		packet->index = buf[0] & 0x7;
+		packet->index = buf[0] & SPE_ADDR_PKT_HDR_INDEX_MASK;
 
 	return arm_spe_get_payload(buf, len, ext_hdr, packet);
 }
@@ -394,18 +392,23 @@ int arm_spe_pkt_desc(const struct arm_spe_pkt *packet, char *buf,
 		return snprintf(buf, buf_len, "%s %lld", name, payload);
 	case ARM_SPE_ADDRESS:
 		switch (idx) {
-		case 0:
-		case 1: ns = !!(packet->payload & NS_FLAG);
-			el = (packet->payload & EL_FLAG) >> 61;
-			payload &= ~(0xffULL << 56);
+		case SPE_ADDR_PKT_HDR_INDEX_INS:
+		case SPE_ADDR_PKT_HDR_INDEX_BRANCH:
+			ns = !!(packet->payload & SPE_ADDR_PKT_INST_VA_NS);
+			el = packet->payload >> SPE_ADDR_PKT_INST_VA_EL_SHIFT;
+			el &= SPE_ADDR_PKT_INST_VA_EL_MASK;
+			payload &= GENMASK(SPE_ADDR_PKT_ADDR_MSB, 0);
 			return snprintf(buf, buf_len, "%s 0x%llx el%d ns=%d",
-				        (idx == 1) ? "TGT" : "PC", payload, el, ns);
-		case 2:	return snprintf(buf, buf_len, "VA 0x%llx", payload);
-		case 3:	ns = !!(packet->payload & NS_FLAG);
-			payload &= ~(0xffULL << 56);
+					(idx == 1) ? "TGT" : "PC", payload, el, ns);
+		case SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT:
+			return snprintf(buf, buf_len, "VA 0x%llx", payload);
+		case SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS:
+			ns = !!(packet->payload & SPE_ADDR_PKT_INST_VA_NS);
+			payload &= GENMASK(SPE_ADDR_PKT_ADDR_MSB, 0);
 			return snprintf(buf, buf_len, "PA 0x%llx ns=%d",
 					payload, ns);
-		default: return 0;
+		default:
+			return 0;
 		}
 	case ARM_SPE_CONTEXT:
 		return snprintf(buf, buf_len, "%s 0x%lx el%d", name,
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 9df5ebe02c5d..d09082fc9853 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -56,19 +56,31 @@ struct arm_spe_pkt {
 #define SPE_HEADER_SZ_SHIFT		(4)
 #define SPE_HEADER_SZ_MASK		(0x30)
 
+/* Address packet header */
+#define SPE_ADDR_PKT_HDR_INDEX_MASK		(0x7)
 #define SPE_ADDR_PKT_HDR_INDEX_INS		(0x0)
 #define SPE_ADDR_PKT_HDR_INDEX_BRANCH		(0x1)
 #define SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT	(0x2)
 #define SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS	(0x3)
 
-#define SPE_ADDR_PKT_NS				BIT(7)
-#define SPE_ADDR_PKT_CH				BIT(6)
-#define SPE_ADDR_PKT_EL_OFFSET			(5)
-#define SPE_ADDR_PKT_EL_MASK			(0x3 << SPE_ADDR_PKT_EL_OFFSET)
-#define SPE_ADDR_PKT_EL0			(0)
-#define SPE_ADDR_PKT_EL1			(1)
-#define SPE_ADDR_PKT_EL2			(2)
-#define SPE_ADDR_PKT_EL3			(3)
+#define SPE_ADDR_PKT_HDR_EXT_INDEX_MASK		(0x3)
+
+#define SPE_ADDR_PKT_ADDR_MSB			(55)
+
+/* Address packet payload for data access physical address */
+#define SPE_ADDR_PKT_DATA_PA_NS			BIT(63)
+#define SPE_ADDR_PKT_DATA_PA_CH			BIT(62)
+#define SPE_ADDR_PKT_DATA_PA_PAT_SHIFT		(56)
+#define SPE_ADDR_PKT_DATA_PA_PAT_MASK		(0xf)
+
+/* Address packet payload for instrcution virtual address */
+#define SPE_ADDR_PKT_INST_VA_NS			BIT(63)
+#define SPE_ADDR_PKT_INST_VA_EL_SHIFT		(61)
+#define SPE_ADDR_PKT_INST_VA_EL_MASK		(0x3)
+#define SPE_ADDR_PKT_INST_VA_EL0		(0)
+#define SPE_ADDR_PKT_INST_VA_EL1		(1)
+#define SPE_ADDR_PKT_INST_VA_EL2		(2)
+#define SPE_ADDR_PKT_INST_VA_EL3		(3)
 
 const char *arm_spe_pkt_name(enum arm_spe_pkt_type);
 
-- 
2.17.1

