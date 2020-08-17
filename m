Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0E4EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:55:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 972F620748
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:55:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="g+iq+KRS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729184AbgHQOzk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:55:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729072AbgHQOyU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:54:20 -0400
Received: from mail-wm1-x342.google.com (mail-wm1-x342.google.com [IPv6:2a00:1450:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C3D9AC061344
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:54:19 -0700 (PDT)
Received: by mail-wm1-x342.google.com with SMTP id c19so13367110wmd.1
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 07:54:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=rP4szUXJvfYTvxUeVM7AVSTLCdSWwY5XZ+xFqvnQB/A=;
        b=g+iq+KRSVdn3IqbRBT93xFqRdSEbPayULPc8QQxuwLQRWgPYDDmR/ahg2H/BPOgnrW
         dSyQE40Cso6nylXUI3KRWx6NfCbroN/XG5JaPFSMdQLnb80fJhOctSP++I9EmmvBWCmV
         myCHMlbnIMwy+d1YLducvdC9CcWROmweGNd/+CrcfwapexKVWTC2uzrkkgCFLJOvRm07
         K4lWovb0lCgpA1mUrhoPb8bWIA6xsg82xGLohFuoa9W2dgXyAwf3H9fg11+gzUe0S/YF
         N21P5rKgKnmwPFoAT7IGDNhx85hkizzTWvMZyTShINmRfGBsYIk81Y16U3bOsIn8Q4lZ
         +3cw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=rP4szUXJvfYTvxUeVM7AVSTLCdSWwY5XZ+xFqvnQB/A=;
        b=XAiNfXTDHfPYt1adAWqK2GoEKPJCvMUM7FgTf5r+BvcLXqOYYBTB7ZuanKlO0LKD0h
         GYccIc7fjKPsS1yVL+auCJo6e3OKhr9gXgyaw8/X/uzeysJwggopWcVJJJ29rms3WQHX
         X/P67Kx/nS8iaW77XiQIuFc70VTEFTNXUFMjGdw3UdREj+bDBqQMm6mA3xJDrq0hZ3mJ
         mSmzvNjwyknm5Nrk8lB6AhWkkREOECkXpxQHRQ6EKQfIj3xsHt7lNxVKXBKkus/fXLUz
         6CWLIZuCtdtFa5JJpz/G/rOHT6/O7NXxlJvQA9myh+UqH5JZa4JXxw2sW1RKcYNzXZ7V
         pvLw==
X-Gm-Message-State: AOAM532LJHjGKrIQsGuKLLMqWuTK51/Mt41hECq86SWt0jihq8kCSHqk
        z8uLQ6n3J8wznenh+yTFB2ENyg==
X-Google-Smtp-Source: ABdhPJwvTETI/jkSPzdj8CKJpcQ/FMV+ueWsTXYREJfeIfwcq6AHAifbAJpWJQuQKLuGABB2R5ZFxA==
X-Received: by 2002:a1c:19c2:: with SMTP id 185mr14758349wmz.8.1597676058315;
        Mon, 17 Aug 2020 07:54:18 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id r16sm35005678wrr.13.2020.08.17.07.54.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 17 Aug 2020 07:54:17 -0700 (PDT)
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
Subject: [PATCH RESEND v1 04/13] perf arm-spe: Fix packet length handling
Date:   Mon, 17 Aug 2020 15:53:39 +0100
Message-Id: <20200817145348.14461-5-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200817145348.14461-1-leo.yan@linaro.org>
References: <20200817145348.14461-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When process address packet and counter packet, if the packet contains
extended header, it misses to account the extra one byte for header
length calculation, thus returns the wrong packet length.

To correct the packet length calculation, one possible fixing is simply
to plus extra 1 for extended header, but will spread some duplicate code
in the flows for processing address packet and counter packet.
Alternatively, we can refine the function arm_spe_get_payload() to not
only support short header and allow it to support extended header, and
rely on it for the packet length calculation.

So this patch refactors function arm_spe_get_payload() with a new
argument 'ext_hdr' for support extended header; the packet processing
flows can invoke this function to unify the packet length calculation.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 .../arm-spe-decoder/arm-spe-pkt-decoder.c     | 34 +++++++------------
 1 file changed, 12 insertions(+), 22 deletions(-)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
index 5a8696031e16..4f0aeb62e97b 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-pkt-decoder.c
@@ -80,14 +80,15 @@ const char *arm_spe_pkt_name(enum arm_spe_pkt_type type)
 	(1 << (((val) & SPE_HEADER_SZ_MASK) >> SPE_HEADER_SZ_SHIFT))
 
 static int arm_spe_get_payload(const unsigned char *buf, size_t len,
+			       unsigned char ext_hdr,
 			       struct arm_spe_pkt *packet)
 {
-	size_t payload_len = PAYLOAD_LEN(buf[0]);
+	size_t payload_len = PAYLOAD_LEN(buf[ext_hdr]);
 
-	if (len < 1 + payload_len)
+	if (len < 1 + ext_hdr + payload_len)
 		return ARM_SPE_NEED_MORE_BYTES;
 
-	buf++;
+	buf += 1 + ext_hdr;
 
 	switch (payload_len) {
 	case 1: packet->payload = *(uint8_t *)buf; break;
@@ -97,7 +98,7 @@ static int arm_spe_get_payload(const unsigned char *buf, size_t len,
 	default: return ARM_SPE_BAD_PACKET;
 	}
 
-	return 1 + payload_len;
+	return 1 + ext_hdr + payload_len;
 }
 
 static int arm_spe_get_pad(struct arm_spe_pkt *packet)
@@ -128,7 +129,7 @@ static int arm_spe_get_timestamp(const unsigned char *buf, size_t len,
 				 struct arm_spe_pkt *packet)
 {
 	packet->type = ARM_SPE_TIMESTAMP;
-	return arm_spe_get_payload(buf, len, packet);
+	return arm_spe_get_payload(buf, len, 0, packet);
 }
 
 static int arm_spe_get_events(const unsigned char *buf, size_t len,
@@ -143,14 +144,14 @@ static int arm_spe_get_events(const unsigned char *buf, size_t len,
 	 */
 	packet->index = PAYLOAD_LEN(buf[0]);
 
-	return arm_spe_get_payload(buf, len, packet);
+	return arm_spe_get_payload(buf, len, 0, packet);
 }
 
 static int arm_spe_get_data_source(const unsigned char *buf, size_t len,
 				   struct arm_spe_pkt *packet)
 {
 	packet->type = ARM_SPE_DATA_SOURCE;
-	return arm_spe_get_payload(buf, len, packet);
+	return arm_spe_get_payload(buf, len, 0, packet);
 }
 
 static int arm_spe_get_context(const unsigned char *buf, size_t len,
@@ -158,8 +159,7 @@ static int arm_spe_get_context(const unsigned char *buf, size_t len,
 {
 	packet->type = ARM_SPE_CONTEXT;
 	packet->index = buf[0] & 0x3;
-
-	return arm_spe_get_payload(buf, len, packet);
+	return arm_spe_get_payload(buf, len, 0, packet);
 }
 
 static int arm_spe_get_op_type(const unsigned char *buf, size_t len,
@@ -167,41 +167,31 @@ static int arm_spe_get_op_type(const unsigned char *buf, size_t len,
 {
 	packet->type = ARM_SPE_OP_TYPE;
 	packet->index = buf[0] & 0x3;
-	return arm_spe_get_payload(buf, len, packet);
+	return arm_spe_get_payload(buf, len, 0, packet);
 }
 
 static int arm_spe_get_counter(const unsigned char *buf, size_t len,
 			       const unsigned char ext_hdr, struct arm_spe_pkt *packet)
 {
-	if (len < 2)
-		return ARM_SPE_NEED_MORE_BYTES;
-
 	packet->type = ARM_SPE_COUNTER;
 	if (ext_hdr)
 		packet->index = ((buf[0] & 0x3) << 3) | (buf[1] & 0x7);
 	else
 		packet->index = buf[0] & 0x7;
 
-	packet->payload = le16_to_cpu(*(uint16_t *)(buf + 1));
-
-	return 1 + ext_hdr + 2;
+	return arm_spe_get_payload(buf, len, ext_hdr, packet);
 }
 
 static int arm_spe_get_addr(const unsigned char *buf, size_t len,
 			    const unsigned char ext_hdr, struct arm_spe_pkt *packet)
 {
-	if (len < 8)
-		return ARM_SPE_NEED_MORE_BYTES;
-
 	packet->type = ARM_SPE_ADDRESS;
 	if (ext_hdr)
 		packet->index = ((buf[0] & 0x3) << 3) | (buf[1] & 0x7);
 	else
 		packet->index = buf[0] & 0x7;
 
-	memcpy_le64(&packet->payload, buf + 1, 8);
-
-	return 1 + ext_hdr + 8;
+	return arm_spe_get_payload(buf, len, ext_hdr, packet);
 }
 
 static int arm_spe_do_get_packet(const unsigned char *buf, size_t len,
-- 
2.17.1

