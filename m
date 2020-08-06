Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DD96C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:42:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 57BAB21744
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:42:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="IftBre+E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727794AbgHFCmF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 22:42:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726360AbgHFCmC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 22:42:02 -0400
Received: from mail-pl1-x630.google.com (mail-pl1-x630.google.com [IPv6:2607:f8b0:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E3054C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 19:42:01 -0700 (PDT)
Received: by mail-pl1-x630.google.com with SMTP id bh1so13654432plb.12
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 19:42:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L/eySvy1HGwNwSac5xNfh9Hh8Ftaq/NTk9ir+o8JPbs=;
        b=IftBre+EILJ8e6GpNXcykCpp+8gaW9NngY/YPgW0wzDt39aFMNKTE2iIjI9SOpEH5L
         eVZSbJ71eaADiTPYn2hvWdXSZWRtNLBjaxBnIjsRpnY1D/YQBCCnVkHld+BmK8fXPvst
         x2dxUmS0lF9fJwyiKp9EOprldG7NrKKTOl0wlQLbUxWXdGDfn6o6FRfX3fQxeFC+kJDX
         uPdLZstHZMUQkieobFuo8LTQTnIjmcXxy06N03tIufiluT8RGyWZu2yHMWvgn7sRDT+X
         Y/uuclxgCT22cX+EmUG506MMLuqakHN4cb0us1vJtx+XrMcKT6SrQ8HDfsIa2tu3J7ZN
         OC6Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L/eySvy1HGwNwSac5xNfh9Hh8Ftaq/NTk9ir+o8JPbs=;
        b=dseY5svEJhy84CQUytr9X6RQFDlUypix04itNxUClxqHBgrdokpb55TjTsw5y7MdKj
         nTRMHQOfiW1r8OR/1DmkI7+66U67ushmIyg5ndvVyKiq4lc1ykwZaguG4+2wszlMrQYr
         ZaHSRaviQELSGwzDZvoMMATD4x5Hbm3brMvkaSpm6wCibNupVmFkP1fdesyEH1a6m88s
         ewgK5D5DWYhnr7+4VcKprhOxFeJ8EkuWOXaudxUguH8ixL58zJO3EVmICc+oKGASoEaE
         uIu+vOnH3gINcXY2kRdLNl/WPR1V4zj9+FU950I4+GK0oC+h864qUpX6cTd7PEozKf9A
         dtTw==
X-Gm-Message-State: AOAM531BMPJHwOac3fi3GrefoZvkRYE/Bn7W+GMbV79k/8AS+qm/hIVO
        0igHIzWCiZHc/1UmtM3sb/VePA==
X-Google-Smtp-Source: ABdhPJzsMIoT//6did/+zTPUxQlZG/Q5g3vYb7HJks0P3IXm8FT2qMnGOh8vHXC3/yBPgIer1ghXYg==
X-Received: by 2002:a17:902:a513:: with SMTP id s19mr5908520plq.152.1596681720612;
        Wed, 05 Aug 2020 19:42:00 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id t13sm4897621pgm.32.2020.08.05.19.41.59
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Aug 2020 19:42:00 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Grant <Al.Grant@arm.com>, linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v1 09/11] perf arm-spe: Store operation types in packet
Date:   Thu,  6 Aug 2020 10:40:39 +0800
Message-Id: <20200806024041.27475-10-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806024041.27475-1-leo.yan@linaro.org>
References: <20200806024041.27475-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to store operation types into packet structure, this can
be used by frontend to generate memory accessing info for samples.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 11 +++++++++++
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h |  6 ++++++
 2 files changed, 17 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 373dc2d1cf06..cba394784b0d 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -172,6 +172,17 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 		case ARM_SPE_CONTEXT:
 			break;
 		case ARM_SPE_OP_TYPE:
+			/*
+			 * When operation type packet header's class equals 1,
+			 * the payload's least significant bit (LSB) indicates
+			 * the operation type: load/swap or store.
+			 */
+			if (idx == 1) {
+				if (payload & 0x1)
+					decoder->record.op = ARM_SPE_ST;
+				else
+					decoder->record.op = ARM_SPE_LD;
+			}
 			break;
 		case ARM_SPE_EVENTS:
 			if (payload & BIT(EV_L1D_REFILL))
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 5acddfcffbd1..f23188282ef0 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -41,9 +41,15 @@ enum arm_spe_sample_type {
 	ARM_SPE_REMOTE_ACCESS	= 1 << 7,
 };
 
+enum arm_spe_op_type {
+	ARM_SPE_LD		= 1 << 0,
+	ARM_SPE_ST		= 1 << 1,
+};
+
 struct arm_spe_record {
 	enum arm_spe_sample_type type;
 	int err;
+	u32 op;
 	u64 from_ip;
 	u64 to_ip;
 	u64 timestamp;
-- 
2.17.1

