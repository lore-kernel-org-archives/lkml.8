Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26E4AC433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E99B32098B
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:39:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="qqyvmuYi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727978AbgIAIj1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:39:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727784AbgIAIio (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:38:44 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7608EC061247
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 01:38:44 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id k15so513399wrn.10
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 01:38:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=QyuNgv+RVd1VIyxBoD/N8sD0qrYIVJos+n990uvu1UA=;
        b=qqyvmuYirbc/RZhn3fEijjtkQDEmGShM7dHDUfmvmTZhWLnfI/aos7mvjYr01g+8W3
         /D4Pdcv7cbnAbSXxo8IVjE0oF/0/OHb5c0hYpyPWdL527RHg2URvS9wnye0hF+Wk/98Z
         8itFBK2xdG3NM77B43KzOno7HrbnyaZVMdSb2VCxFFxMOLvnl7z2gBtic33oTQX8EvjO
         lmmx4fOP1e0jXYPXYMstMnzfSjT9VBZPeFqIoJpLgq1NF/207YH+DMS/mBjRy0jPybBc
         KK8E/p8yT46qTjywfaYbwrghO9Yt9nJMyqMM2NXQE+57Ah87ZLdRV74FCShq944OcD5B
         IAXQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=QyuNgv+RVd1VIyxBoD/N8sD0qrYIVJos+n990uvu1UA=;
        b=FGHchgvSUZ87D4zfzkN/ee4jhXohwHoxFZRYR6XVkIzTezjqOyuhxMv7M4SK3BV8ft
         xhBOE2RwuXwp/0OoMjD+g9XSWPqloT5JzlTfDwAeHIzVdrzebSlR2xkFSurnz8S31dgG
         diXvnfGAp8LV6F+MgKTLM8bLsq0s1VhwF8G/nsFc5theTjxprCkHYNw0ihsr3wN+gMD5
         V8qX+yQbTRBLhXTCFuoU4ZOrv7sFi5tKSuSlJv0zQ2nyQ0sHkTvZ/jgdkrucLQwxlySI
         Na7tuPcc5i14+nRr+dszdot3i/70aJ5HhlNNaKEuExQNIOTC3AlQHW9OtnTRpivhkU41
         a+VA==
X-Gm-Message-State: AOAM5320MiVQwXJr2pv2rUVF8tCkfopOMyl03SNJko2tkI78IfjHEg+h
        T8sNfwwEaa49NmsX6XTdzZdF0Q==
X-Google-Smtp-Source: ABdhPJxxBUlZrsak+qKciu1DXtZVvDt56EFaJdDH/thRp4Hrst4L/QxprGLfpttTKFEv3KvJYpxHyQ==
X-Received: by 2002:adf:b442:: with SMTP id v2mr688196wrd.213.1598949523124;
        Tue, 01 Sep 2020 01:38:43 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id d190sm911260wmd.23.2020.09.01.01.38.42
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 01:38:42 -0700 (PDT)
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
Subject: [PATCH v2 09/14] perf arm-spe: Save memory addresses in packet
Date:   Tue,  1 Sep 2020 09:38:10 +0100
Message-Id: <20200901083815.13755-10-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901083815.13755-1-leo.yan@linaro.org>
References: <20200901083815.13755-1-leo.yan@linaro.org>
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
index ae718e3419e3..1c430657939f 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.c
@@ -160,6 +160,10 @@ static int arm_spe_read_record(struct arm_spe_decoder *decoder)
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
index 24727b8ca7ff..31d1776785de 100644
--- a/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
+++ b/tools/perf/util/arm-spe-decoder/arm-spe-decoder.h
@@ -30,6 +30,8 @@ struct arm_spe_record {
 	u64 from_ip;
 	u64 to_ip;
 	u64 timestamp;
+	u64 addr;
+	u64 phys_addr;
 };
 
 struct arm_spe_insn;
-- 
2.20.1

