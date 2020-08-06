Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7949DC433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:08:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 598D22245C
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 03:08:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="blAtE25X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgHFDIp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 23:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727078AbgHFDId (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 23:08:33 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63F90C061575
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 20:08:33 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id s15so14391113pgc.8
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 20:08:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LeGuejqiZKjogcIK6n2jDnenD7gfGOh4ncq9Lv6XsGw=;
        b=blAtE25XP3Tyx/AkTtJ/jtd+TQaBw40CgwevvROi4bbjiK9542g9kaQ+/yuRK99YgC
         vylstvC3NVKtUmtTIFmhc3GmGLtiSSxT7hXxpSErhQT3/dDf42keygrO78rQVnv3AkjO
         LUJ+B43qnAxVoI+2+2xiKWdOCh9bUVR3HivWY9ST1WDNu+DmOJ6fhlRWpqnXfK0jgycc
         GAMFKJMMNYSQhIha4YMtmsft36NzOMzWOgclglxwdvJyO/uiG4Q69yKZZlFp8A8mrtmi
         LFzPnqG2527zpzL1GBczCZ0cmyjo9jFiNsPiofA2HP4MEz+2Lv7qeiqR+ldhG1W5xUJv
         YcKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LeGuejqiZKjogcIK6n2jDnenD7gfGOh4ncq9Lv6XsGw=;
        b=uj0mPhG68anyiuklx+pg3HlPo+DMS/EYH8VZhXWk1ltAW3BVeiCas8aEIhJcMhBzDE
         SJgu7ILjW+jjWbFqJznDyB3iOMk+sv7TZDrGTbNTp6CX5YEbY8Uabr4t1KNN5LAP4P6Q
         qZQKa1tjn0/refVDJP6sd3QV3goznJqrW7WXm8Us4KPtgPfHodxqk2fAf7xGd41XqHth
         ArBgXnsk1kv+OIJ5+mZ4dUSPoyUJaTPdHOcDB9JMnE8EdwK/HV/G6XCyAb4WIS9jGMYe
         QXXELT+pDSXyuAXnhy4JulCTd3IJKvaA7f1ZorqIzXmVExfPBOWAa2gMuz+Ho/oVv5Yn
         CKPA==
X-Gm-Message-State: AOAM532uppJvOIYV5QuAUIXr2y8BrHZsDC1j2rXKUN0Teoic1H5kzqfw
        tonRP8JfayiqTc1NW7PEgVd+vA==
X-Google-Smtp-Source: ABdhPJzyghsU5N9v0iVhtVnD1wULUpwAzQtDUt+GaCmPo49GyFQAB379ZyYx+qf7zLgezOArKkEFSg==
X-Received: by 2002:aa7:942e:: with SMTP id y14mr6269638pfo.58.1596683312898;
        Wed, 05 Aug 2020 20:08:32 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id d13sm5553987pfq.118.2020.08.05.20.08.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Aug 2020 20:08:32 -0700 (PDT)
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
Subject: [PATCH RESEND v1 08/11] perf arm-spe: Save memory addresses in packet
Date:   Thu,  6 Aug 2020 11:07:24 +0800
Message-Id: <20200806030727.30267-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806030727.30267-1-leo.yan@linaro.org>
References: <20200806030727.30267-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to save virtual and physical memory addresses in packet,
the address info can be used for generating memory samples.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.c | 4 ++++
 tools/perf/util/arm-spe-decoder/arm-spe-decoder.h | 2 ++
 2 files changed, 6 insertions(+)

diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
index 93e063f22be5..373dc2d1cf06 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -162,6 +162,10 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
 				decoder->record.from_ip = ip;
 			else if (idx == SPE_ADDR_PKT_HDR_INDEX_BRANCH)
 				decoder->record.to_ip = ip;
+			else if (idx == SPE_ADDR_PKT_HDR_INDEX_DATA_VIRT)
+				decoder->record.addr = ip;
+			else if (idx == SPE_ADDR_PKT_HDR_INDEX_DATA_PHYS)
+				decoder->record.phys_addr = ip;
 			break;
 		case ARM_SPE_COUNTER:
 			break;
diff --git a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
index a5111a8d4360..5acddfcffbd1 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -47,6 +47,8 @@ struct arm_spe_record {
 	u64 from_ip;
 	u64 to_ip;
 	u64 timestamp;
+	u64 addr;
+	u64 phys_addr;
 };
 
 struct arm_spe_insn;
-- 
2.17.1

