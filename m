Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A39D8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:08:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6FF5421744
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:08:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="JuZRrtY/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727880AbgHFDIl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 23:08:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727039AbgHFDIj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 23:08:39 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92F60C061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 20:08:38 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id s15so14391198pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 20:08:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=L/eySvy1HGwNwSac5xNfh9Hh8Ftaq/NTk9ir+o8JPbs=;
        b=JuZRrtY/ZT3SkTf+Mdxqsk4GHmm+n9oKA9uNV4HMCBJ4BxpfMao+kt5tJXURvBqxCv
         KHmQ2X8z6mucF/ib0U7E/VsZwjlx6kIj7fDYcysrEy7aM5fpGVwJZozIYra9AKL4A9JA
         1JNF8JoVcY61HLdVPLshYXiVkhHxi+d9lqJ/B6WYE+Pru9Gkqtjoxx1EMvmYqNEQHdIz
         lq4r7eMMVPT24N0fqm3VVEusVyWsASD9085gIKJUKvZPORbpmOMuPVtugZKNPVQdPCIV
         hEUw/dfsrwi2CRCv11WYccxCtVIHTkd8xdeCW5ngy/jSFqljLBwJNnx7MJUxiIs945M+
         qOaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=L/eySvy1HGwNwSac5xNfh9Hh8Ftaq/NTk9ir+o8JPbs=;
        b=tGA3uuJh6G0YqnSNiCnwNsHEMucCEDaxX9sAVzSAlRMK2JFaAfbOlGrkycnUW+Dk+e
         YPdN3Pf9trYeLGXU7f4xMxXzmYNNzCSN5N9ie9brcoITOoPKkEV6Li324dp2QqOVJq3E
         xn8joqtXaevU6fRcUvjG/Vq6y0s5p/H4vzsc2OpXT3GH0Qr0WnWnSLUujgpz9GXFqO13
         JSsuAzbkyPles4t13htWk/KXW2NqLIQ0Aqy/FUfz0BW0qoW8miucw/RNV5jmTg4b0DU5
         iLuj8JLPOtVaQmIL67I/F5OjRFtYuoPoz0DIFV9wT+Z69kmyt5PdSjjTRB5k7uMOltJb
         3o2w==
X-Gm-Message-State: AOAM532F9L2iEoXgljSV3RdTXZlzwpW38qpZWNHD2k5ieL8urjg04JBD
        +wQ7WXpwgzya5z/LgCjHi0eLGg==
X-Google-Smtp-Source: ABdhPJzCmiqWGG06H+utfSQaXxWefY3gP/SKBYBy65WWTwRRol6eH37Xz/5EtSbycv7dnd7jQz5+yA==
X-Received: by 2002:a63:954c:: with SMTP id t12mr5333877pgn.387.1596683318094;
        Wed, 05 Aug 2020 20:08:38 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id r15sm5868745pfq.189.2020.08.05.20.08.37
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Aug 2020 20:08:37 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Jiri Olsa <jolsa@redhat.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Namhyung Kim <namhyung@kernel.org>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Ian Rogers <irogers@google.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Al Grant <Al.Grant@arm.com>, linux-kernel@vger.kernel.org,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH RESEND v1 09/11] perf arm-spe: Store operation types in packet
Date:   Thu,  6 Aug 2020 11:07:25 +0800
Message-Id: <20200806030727.30267-10-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806030727.30267-1-leo.yan@linaro.org>
References: <20200806030727.30267-1-leo.yan@linaro.org>
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

