Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E7C7C38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:08:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1FD942083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:08:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f2yVzmCH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgEGOIg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:08:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726558AbgEGOIc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:08:32 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9B64AC05BD0E
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 07:08:30 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id x24so7309488qta.4
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 07:08:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=T1oY202fZuRBk7edtCBgt9wERwBLTlqKZ66WoSf5lZY=;
        b=f2yVzmCHXRdeuATp6UNXLsr9j3vzi+Fv2Pc89/g7pt6XFIZ6WPUU4+XdZMsW7DVnF4
         n2yZWIQNIU5uqr+QnGNi+54MDJHMCWmbz2aEHJzBHDHNSpzBjA+CBfwG7Z59S/rpdkPG
         LRP5O+hDySUXieGDfzzT//qs6ihTwulTSUtefd8x5FObJPRVzJXVd4QcN330/hjd5ClY
         NhpLete2Rc2Yo/B6a+rGhWPckBE91Xb8xmV8Mire4qGR+afiBQH4cNzelPKX1KAbaf4j
         NTdOMBmo0exMGpP1rC3C3K3g3ZQSEcEPqXl443gJphFVGOQ9u1D//QClKbOKVbY7+eLV
         JByQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=T1oY202fZuRBk7edtCBgt9wERwBLTlqKZ66WoSf5lZY=;
        b=p0EdkP2yvKCQ3EYjSqyT/OJ8Uii1mi+tnRuzjlDAnXpIpRfK/IcwejRalIo/h5SYRU
         p1mPsesRfnw5Lw3YSqyUVOM35b343IyOLGpeFBrUjR0NvAhPXM2WHa2C3QqybLuJD5/6
         U7m3wy76WNHhQVLKV1oZdyK05IUuItEfWdQBERsBJRhP81SiEu8eSFBOBIQ7uMqCu5Hc
         kiXcgkbmqe6tVs6ly88kFsTgJwXE1TVBZFds8OQvnHtjYiK51Vv32GI+aIirIUnE714M
         88lD+R+f2HMcK906qalzQicQ5iGONtV9dpEpP126nELcriwndZFE58TtI5SPUff4ZkLf
         uPoA==
X-Gm-Message-State: AGi0PuYMuIa5dvnKmGkA9P8StUAfFGOG7ud7rIIY81lz2VUTF9VO0Q4C
        QPHyUlCaKujjRPuIryBOuatfTTCjP/9F
X-Google-Smtp-Source: APiQypKv4Wz5aiAH7yNT+t1Ra+WCZoSjlEFRIBMgUe/3Qo7oXj9ACmTXXXNfvkVwVq5B54XWjvc0IQzGw+4b
X-Received: by 2002:a05:6214:1262:: with SMTP id r2mr13718869qvv.126.1588860509690;
 Thu, 07 May 2020 07:08:29 -0700 (PDT)
Date:   Thu,  7 May 2020 07:07:59 -0700
In-Reply-To: <20200507140819.126960-1-irogers@google.com>
Message-Id: <20200507140819.126960-4-irogers@google.com>
Mime-Version: 1.0
References: <20200507140819.126960-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH v2 03/23] perf metrics: fix parse errors in skylake metrics
From:   Ian Rogers <irogers@google.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>,
        Kajol Jain <kjain@linux.ibm.com>,
        Andi Kleen <ak@linux.intel.com>,
        John Garry <john.garry@huawei.com>,
        Jin Yao <yao.jin@linux.intel.com>,
        Kan Liang <kan.liang@linux.intel.com>,
        Cong Wang <xiyou.wangcong@gmail.com>,
        Kim Phillips <kim.phillips@amd.com>,
        linux-kernel@vger.kernel.org
Cc:     netdev@vger.kernel.org, bpf@vger.kernel.org,
        linux-perf-users@vger.kernel.org,
        Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove over escaping with \\.

Fixes: fd5500989c8f (perf vendor events intel: Update metrics from TMAM 3.5)
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
index b4f91137f40c..390bdab1be9d 100644
--- a/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
+++ b/tools/perf/pmu-events/arch/x86/skylakex/skx-metrics.json
@@ -328,13 +328,13 @@
     },
     {
         "BriefDescription": "Average latency of data read request to external memory (in nanoseconds). Accounts for demand loads and L1/L2 prefetches",
-        "MetricExpr": "1000000000 * ( cha@event\\=0x36\\\\\\,umask\\=0x21@ / cha@event\\=0x35\\\\\\,umask\\=0x21@ ) / ( cha_0@event\\=0x0@ / duration_time )",
+        "MetricExpr": "1000000000 * ( cha@event\\=0x36\\,umask\\=0x21@ / cha@event\\=0x35\\,umask\\=0x21@ ) / ( cha_0@event\\=0x0@ / duration_time )",
         "MetricGroup": "Memory_Lat",
         "MetricName": "DRAM_Read_Latency"
     },
     {
         "BriefDescription": "Average number of parallel data read requests to external memory. Accounts for demand loads and L1/L2 prefetches",
-        "MetricExpr": "cha@event\\=0x36\\\\\\,umask\\=0x21@ / cha@event\\=0x36\\\\\\,umask\\=0x21\\\\\\,thresh\\=1@",
+        "MetricExpr": "cha@event\\=0x36\\,umask\\=0x21@ / cha@event\\=0x36\\,umask\\=0x21\\,thresh\\=1@",
         "MetricGroup": "Memory_BW",
         "MetricName": "DRAM_Parallel_Reads"
     },
-- 
2.26.2.526.g744177e7f7-goog

