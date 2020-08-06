Return-Path: <SRS0=vN1y=BQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 50154C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2D55D20823
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Aug 2020 02:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="bTbml5ml"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727768AbgHFClu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Aug 2020 22:41:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726524AbgHFCls (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Aug 2020 22:41:48 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED37DC061574
        for <linux-kernel@vger.kernel.org>; Wed,  5 Aug 2020 19:41:47 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id o5so7912409pgb.2
        for <linux-kernel@vger.kernel.org>; Wed, 05 Aug 2020 19:41:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=LeGuejqiZKjogcIK6n2jDnenD7gfGOh4ncq9Lv6XsGw=;
        b=bTbml5mlDlF7ad39p1q0TOdpvapyxQIrNuLDgLpUzSKiKqe6VrmTkfuVnT5OdJqGgG
         BxvMJwWViRd+Chy1UPh++OzeNGa6UxWq93YVJ8VPE+djNMG9OPDaYcW/UnvnFtYNcbq2
         ZOzIQaFSb7TZoc0TfAHtq0bkIRpS42O8zQTKwQk0LarfYCrpUrTAvTSzbBEirGFkRgMu
         wwkx3qBvzgY5+z82nPZZdTUH3KoXSuwv7GP5uATpSEYar9qgQ8wBjdoKr1MiONjGNtVm
         CBCZSI3A4FaD01pFAdM1XCy+kD6fO9E8zc+D6sc2lQQzpauCtanadHvyup3H6H4tTVYs
         1XuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=LeGuejqiZKjogcIK6n2jDnenD7gfGOh4ncq9Lv6XsGw=;
        b=XVNmGv8nZpoeb3NMtpimP0itf9m5DBNSe6xDlUDUNDqJ5ySuaaLWryr8xdl3Kk8pkC
         QZRe/xpMUQGiUxeAK+ZI+iPk4QMsLOR7nGI3lGfgM752UCC38cozcgLg3wGMwkjONvhz
         vpIFu5a7TcNRo6g0MVFx3nIk3IXN8tPHJ7iCyGR8TSFv3MNczigm+q9il5ZDBI64EUrw
         PWqwMZN79DwiJgmLNYdXV6CBgezfeMoDFPC7ivtlScCMv37T0yAESvd1/0cGgBw6p+Js
         vndWrIrTvH14K40AfacGXqGrbQP2HwiAcN9iZFXdjvDA9MuegX8kYCum+HDv1pZMeH1N
         qB/A==
X-Gm-Message-State: AOAM5338v5Pzl3Gq+FEu2bSHWXu4bVr9jNFPHYwPyjjDQwcsBTFA6oPN
        M7kV0HFwEyhr2GJsM1kyUCixjA==
X-Google-Smtp-Source: ABdhPJyk8zbHwKP+Ggu4JZBXvxEIDBB+vzBvwcmOBzHz2ScLwrf/sNrNskpltlyq4Iem0/zCVZXD6A==
X-Received: by 2002:a63:2223:: with SMTP id i35mr5710273pgi.64.1596681707408;
        Wed, 05 Aug 2020 19:41:47 -0700 (PDT)
Received: from localhost ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id c207sm5310766pfc.64.2020.08.05.19.41.46
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Wed, 05 Aug 2020 19:41:46 -0700 (PDT)
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
Subject: [PATCH v1 08/11] perf arm-spe: Save memory addresses in packet
Date:   Thu,  6 Aug 2020 10:40:38 +0800
Message-Id: <20200806024041.27475-9-leo.yan@linaro.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20200806024041.27475-1-leo.yan@linaro.org>
References: <20200806024041.27475-1-leo.yan@linaro.org>
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

