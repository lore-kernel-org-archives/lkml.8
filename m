Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBF6EC433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:39:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B20DE206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 08:39:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="crJ7lzkv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727941AbgIAIjY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 04:39:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726770AbgIAIin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 04:38:43 -0400
Received: from mail-wr1-x441.google.com (mail-wr1-x441.google.com [IPv6:2a00:1450:4864:20::441])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F7DC061246
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 01:38:43 -0700 (PDT)
Received: by mail-wr1-x441.google.com with SMTP id g4so39947wrs.5
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 01:38:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=coZL5I0y3Ctt0MBfhS+erSzZ28hOslQcbqpTnppMiiY=;
        b=crJ7lzkvbUc1efAT2RdF75v3LeUelVRU73CJ2Lc9FSAsbPJZbjRGxNg5pI6TsJA76L
         GCAkNt+PwQwAB/HHzGktw3sSU1YR4fMnfLD0H7pEMY04AV2ViFux5uH1iFt7HayrkNVC
         4bHqovb1v6MYA31OlTXgiuJizyb2FLvEAewRFISJW00KNlswCBHDmEBTxYdVNl0MGzQZ
         YbFNwaRyIUr0jM+z0X8O3O15y2Ce+yJSxWXo0N1TUkPoX9+YsXQ4RzWiEuX7j8vh6vgk
         V4FUeB4/p3kZWJiOJjfaQ/zhkdDV4ahkxiM4y6WTg0e5eQ1S3yoDO0lcx7oNx+3B4bTK
         uEVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=coZL5I0y3Ctt0MBfhS+erSzZ28hOslQcbqpTnppMiiY=;
        b=YG8Zy0I/wvWlJC3LzG9AoEHCnDj9H+R9lnYkTT3AbApneE1d6myCl9lF/z0k6ZUv77
         Tx2opoK8uSZPJgCOQbPr5zYPcN0vknt2O2UnMT1A/wkqSgo1jd5lcUG1Sd3HfWSo2EM2
         CyV2vAeNIOTdBhvRuV9d0t2sxXi/smphdy+f8dwIRnO7Awr32fRTaiWDvHq9fTSGPEYL
         seOHqYoCSXC5ksVOOwE/Lc+gMwksSTeN7E7o0dg+y5vnmtzVPsMztzECAnnCOAavR8WJ
         N+Tz243ykY5Tv7571QoB7hBc9/1S3D/fpibFM07fSF3U6hKJGViCLUWsPnxHmZGn1cYW
         smQQ==
X-Gm-Message-State: AOAM530OP6ujRQ9qj6kmi3O7Dvj+2GGrRt4VJgU88RnCLP9kTg755KHj
        njzDwolZscbDLHIfrf2Kb0XsVA==
X-Google-Smtp-Source: ABdhPJyZrKznRpDLdq1cDjuNPuaCSpzT0158l69oEXGReZ5LsVuDE9gDLlkk345lg8Lo0bjP1fc/CQ==
X-Received: by 2002:a5d:6685:: with SMTP id l5mr689074wru.264.1598949521987;
        Tue, 01 Sep 2020 01:38:41 -0700 (PDT)
Received: from hackbox2.linaro.org ([81.128.185.34])
        by smtp.gmail.com with ESMTPSA id d190sm911260wmd.23.2020.09.01.01.38.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 01 Sep 2020 01:38:41 -0700 (PDT)
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
Subject: [PATCH v2 08/14] perf arm-spe: Enable attribution PERF_SAMPLE_DATA_SRC
Date:   Tue,  1 Sep 2020 09:38:09 +0100
Message-Id: <20200901083815.13755-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200901083815.13755-1-leo.yan@linaro.org>
References: <20200901083815.13755-1-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch is to enable attribution PERF_SAMPLE_DATA_SRC for the perf
data, when decoding the tracing data, it will tells the tool it contains
memory data.

Signed-off-by: Leo Yan <leo.yan@linaro.org>
---
 tools/perf/util/arm-spe.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/perf/util/arm-spe.c b/tools/perf/util/arm-spe.c
index 07232664c927..305ab725b3ba 100644
--- a/tools/perf/util/arm-spe.c
+++ b/tools/perf/util/arm-spe.c
@@ -810,7 +810,7 @@ arm_spe_synth_events(struct arm_spe *spe, struct perf_session *session)
 	attr.type = PERF_TYPE_HARDWARE;
 	attr.sample_type = evsel->core.attr.sample_type & PERF_SAMPLE_MASK;
 	attr.sample_type |= PERF_SAMPLE_IP | PERF_SAMPLE_TID |
-		PERF_SAMPLE_PERIOD;
+			    PERF_SAMPLE_PERIOD | PERF_SAMPLE_DATA_SRC;
 	if (spe->timeless_decoding)
 		attr.sample_type &= ~(u64)PERF_SAMPLE_TIME;
 	else
-- 
2.20.1

