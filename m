Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D75E9C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:39:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AB4E12071B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:39:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="Wa90BOim"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727939AbgIAIjR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:39:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727061AbgIAIiq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:38:46 -0400
Received: from mail-wr1-x435.google.com (mail-wr1-x435.google.com [IPv6:2a00:1450:4864:20::435])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5ED8C061244
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 01:38:45 -0700 (PDT)
Received: by mail-wr1-x435.google.com with SMTP id k15so513473wrn.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 01:38:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=sBRnYjU064gEYAlNNyys3pbyfTYht326JQtzigEYeSY=;
        b=Wa90BOimC+g5VzhDsBajpTWJUp6jgoHAbgz0lEBFy6wfs3RPSZ+P413Xi4NmvdkWd1
         OEZtiyXb5O8f/XFO+kMC7LtwrCHJhq1/gHav2qhaqQ/5EjL6f6/sqZw0T5ckiSzSdNU/
         nFfZDGlZLWo7lAyzDhgpYQY9r89oxkjrPAfb8QR/fa0Sd5mltnIh4+wYG1KsQQmEcMG9
         zkOO12+POPOHagYpfXPxvPIoSRdrHDJk+OXNQUloHqSn/vKXZVtAScyXK8US/3dyyy6M
         CtODS+30iXNmzeM9dJD56N1zs4PYsKfLVdm6H3MRfNGIVwAu3BeTn1Jovk5706db4vGg
         Borw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=sBRnYjU064gEYAlNNyys3pbyfTYht326JQtzigEYeSY=;
        b=Od6DhrA69edO27VAtTpVl8tMAli0uOcr+4BX9LQdUlJ2QWxTKzMARPSs99bijKoqu/
         sDhi3W4vWo0ajAaG1eEpzHu5VW2mmn2XeDg1GVld9w4BJ32Mi+Ni9A3/x7F7ofutg40w
         vFKZHLyh8tsMSTThSgEfat8IzlnerjeIiq6ToXPUkrPxlSJTdKd2AX4GtNPpfPYuW6IZ
         wPZp2oEN8gBSOaDf77YkDppM82Llr+HAwn4woDtX2/+XJx/KUaZTAgjlZGVCtx6R7VXs
         eVgy4+Rjm4yQxapd6WFK9eTl8/5UPEF2uSy74WmX+BbZz3DjXmvkDrHlDxqepzoGMNmD
         iFCQ==
X-Gm-Message-State: AOAM532+5/D9qzEzItVJyW9L3a4/+pwzjjFzU6rHQuSgm6dFvj+xX57l
        hLWwQA6NmchQxCpO33zti1HFGA==
X-Google-Smtp-Source: ABdhPJxBHmyilpVCg56qL3/ZzIkl0024GckLEOpApFd0ZEUktkH38mkC6WYKNCEdAISK5DSZF9Kdeg==
X-Received: by 2002:adf:9d44:: with SMTP id o4mr621874wre.361.1598949524317;
        Tue, 01 Sep 2020 01:38:44 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id d190sm911260wmd.23.2020.09.01.01.38.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 01:38:43 -0700 (PDT)
From:   Leo Yan <leo.yan@linaro.org>
To:     Arnaldo Carvalho de Melo <acme@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Andi Kleen <ak@linux.intel.com>,
        Ian Rogers <irogers@google.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kemeng Shi <shikemeng@huawei.com>,
        James Clark <james.clark@arm.com>,
        Wei Li <liwei391@huawei.com>, Al Grant <Al.Grant@arm.com>,
        Will Deacon <will@kernel.org>,
        Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>,
        linux-kernel@vger.kernel.org
Cc:     Leo Yan <leo.yan@linaro.org>
Subject: [PATCH v2 10/14] perf arm-spe: Store operation types in packet
Date:   Tue,  1 Sep 2020 09:38:11 +0100
Message-Id: <20200901083815.13755-11-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901083815.13755-1-leo.yan@linaro.org>
References: <20200901083815.13755-1-leo.yan@linaro.org>
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
index 1c430657939f..7bf787c47f5b 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -170,6 +170,17 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
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
 			if (payload & SPE_EVT_PKT_L1D_REFILL)
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index 31d1776785de..3273cee95ea1 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -24,9 +24,15 @@ enum arm_spe_sample_type {
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
2.20.1

