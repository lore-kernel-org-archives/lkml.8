Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BC511C433E4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:54:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 847BA20729
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:54:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="xyslXvTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729101AbgHQOyg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:54:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729067AbgHQOyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:54:19 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A051C061342
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:54:18 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id a5so15315040wrm.6
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:54:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=OwsMjUaTUP52fMtuuAp8fFPopnM8bE8kRelKQymHpk0=;
        b=xyslXvTeX+mzpY7c0PVaPtPKatqhG6eYBDGmpCmZkPhGNGYlKhbVPgxlrcBn8E56RT
         2kwm1DUBPQrFqWYtd+gyw2bRXby4AP0/QKPQA29akJsIT3iZGOaf8iu/kaxd2rxJPRhJ
         UUR3ZN4BAeSj+nRkMDKzTQRK6YRds7PmRkOMGVNYNp3e94XrN/xenAii8D5D2zFNwAOk
         GutqWLP8CXId6isyhkTtCi2wggzABNocGh7ixuRXbSmYoylUXPOYtBu9GwGa/ruw0VxC
         LTOnK76thtm+75OlxHkqIRmL5OowiIxOtO+0/ZPv0HLO2Z0Hwy7Hx+XuU7EFCu3Rq28C
         xeKA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=OwsMjUaTUP52fMtuuAp8fFPopnM8bE8kRelKQymHpk0=;
        b=UuI2u1cSWTSmf478wLSfdLVRVRTHcIQMU1k0qpLF16TDLzixAFBrakbaUGkg26r0g2
         K3tTyYxQQEP5qLBT1GmCM07dLLT8ay10Gf4+ktTsZifvJDro50BnK3zM9nxuIjMpKXo8
         V9qbiAB/5oyG5axsQaj4EXNiLPGOAfhX1qdLdSTBxe7TUTwpd5/pSYk/XqhksHbi89R6
         Yfa0+QATeDh//s5XyVYhk3Wfu3uFMMPgOYvGwCzVOrU3JRzdmtiHWqsxH513M12/c3JE
         aHvvr253UHbrm8x4HmU1LIH3lpT4yTIN+GzHwNwjRrSijDvf2DkFnKheBh47GMEDzUFv
         z78w==
X-Gm-Message-State: AOAM530tE3ZQleValIWyonmOCWA/rh3c/XB2XYboiA8c2uJr9KdB1BxN
        BW/X4gtam+i5EgnMIrEmBy5tUQ==
X-Google-Smtp-Source: ABdhPJw2nPDri3ipePNc3remvFHrIuo9+ku+1xnsWDEnWqNnW3cmGEJ/chdxUKgd9e7327Vt4qbYMw==
X-Received: by 2002:a5d:4407:: with SMTP id z7mr15718884wrq.404.1597676056904;
        Mon, 17 Aug 2020 07:54:16 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id r16sm35005678wrr.13.2020.08.17.07.54.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 07:54:16 -0700 (PDT)
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
Subject: [PATCH RESEND v1 03/13] perf arm-spe: Refactor payload length calculation
Date:   Mon, 17 Aug 2020 15:53:38 +0100
Message-Id: <20200817145348.14461-4-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817145348.14461-1-leo.yan@linaro.org>
References: <20200817145348.14461-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Defines macro for payload length calculation instead of static function.

Currently the event packet's 'index' is assigned as payload length, but
the flow is not directive: it firstly gets the packet length (includes
header length and payload length) and then reduces header length from
packet length, so finally get the payload length; to simplify the code,
this patch directly assigns payload length to event packet's index.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 26 ++++++++-----------
 .../arm-spe-decoder/arm-spe-pkt-decoder.h     |  3 +++
 2 files changed, 14 insertions(+), 15 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 7c7b5eb09fba..5a8696031e16 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -69,22 +69,20 @@ const char *arm_spe_pkt_name(enum arm_spe_pkt_type type)
 	return arm_spe_packet_name[type];
 }
 
-/* return ARM SPE payload size from its encoding,
- * which is in bits 5:4 of the byte.
- * 00 : byte
- * 01 : halfword (2)
- * 10 : word (4)
- * 11 : doubleword (8)
+/*
+ * Return ARM SPE payload size from header bits 5:4
+ *   00 : byte
+ *   01 : halfword (2)
+ *   10 : word (4)
+ *   11 : doubleword (8)
  */
-static int payloadlen(unsigned char byte)
-{
-	return 1 << ((byte & 0x30) >> 4);
-}
+#define PAYLOAD_LEN(val)	\
+	(1 << (((val) & SPE_HEADER_SZ_MASK) >> SPE_HEADER_SZ_SHIFT))
 
 static int arm_spe_get_payload(const unsigned char *buf, size_t len,
 			       struct arm_spe_pkt *packet)
 {
-	size_t payload_len = payloadlen(buf[0]);
+	size_t payload_len = PAYLOAD_LEN(buf[0]);
 
 	if (len < 1 + payload_len)
 		return ARM_SPE_NEED_MORE_BYTES;
@@ -136,8 +134,6 @@ static int arm_spe_get_timestamp(const unsigned char *buf, size_t len,
 static int arm_spe_get_events(const unsigned char *buf, size_t len,
 			      struct arm_spe_pkt *packet)
 {
-	int ret = arm_spe_get_payload(buf, len, packet);
-
 	packet->type = ARM_SPE_EVENTS;
 
 	/* we use index to identify Events with a less number of
@@ -145,9 +141,9 @@ static int arm_spe_get_events(const unsigned char *buf, size_t len,
 	 * LLC-REFILL, and REMOTE-ACCESS events are identified if
 	 * index > 1.
 	 */
-	packet->index = ret - 1;
+	packet->index = PAYLOAD_LEN(buf[0]);
 
-	return ret;
+	return arm_spe_get_payload(buf, len, packet);
 }
 
 static int arm_spe_get_data_source(const unsigned char *buf, size_t len,
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
index 4c870521b8eb..aca919159cad 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.h
@@ -36,6 +36,9 @@ struct arm_spe_pkt {
 	uint64_t		payload;
 };
 
+#define SPE_HEADER_SZ_SHIFT		(4)
+#define SPE_HEADER_SZ_MASK		(0x30)
+
 #define SPE_ADDR_PKT_HDR_INDEX_INS		(0x0)
 #define SPE_ADDR_PKT_HDR_INDEX_BRANCH		(0x1)
 #define SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT	(0x2)
-- 
2.17.1

