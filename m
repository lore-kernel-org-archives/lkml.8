Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E4AD4C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 06:56:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B96C9206F4
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 06:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="l3OKb9/P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgEOG4i (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 02:56:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726656AbgEOG4f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 02:56:35 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CD9CC05BD09
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 23:56:35 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id t11so418097qvv.11
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 23:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6zJdeczCxXIR05ROPjfL5M3I5d1ozekeF2WaxmhUPXo=;
        b=l3OKb9/Pu0/xrbfvi4lE2TdFagJPZ+BcPCVUsNj1x3y0yxGzAHd4rZFb5smd6fBjNj
         E5sWXxqdr81LqYGmCrXKMXD26Kg4w64KQ4PrQb0AMH475KRgrmYJgqfinUUapGN7Kz0+
         JomMgqVpcsgelaft2fGQcqHV65twgmBNwO6YywGIvz5fFPrQKjW4r2P9MSpe+MLL9z0V
         RQOYhDIkOX8dkiQyqL8tEyMl+XCpKwT8/zrxBEQJE6gVIki9Z/7z27Q3MngZfJG4k6yh
         uyC+MInwMKFZubfIYfNfwhotQRMCL9SLOigBr4GX5+3V5evNYARi8ESBmeBfvf2faHMy
         31Jw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6zJdeczCxXIR05ROPjfL5M3I5d1ozekeF2WaxmhUPXo=;
        b=FU12GVyZ4i9BTLx2NLyIkD5vBpIuNv7cSH2niHCfVEH7/YphDFyxzNO2IGFzRoOvUp
         WwNCBWw/liQb4EzNSRJSlqN0mxkElq/4hb2poRJ9BQ+6RM1GlFmCYm3Qf+15Fo0R9gel
         O+3CaA0ELPDnx3PJ5I6kvDgB+T/XPaZ2YnnGKqpTE5BDb3McLkQzUkNaiuyZeVSrjuI6
         Tfx2cPNQQoUGLifVLNfTargo0RIKVno7/3T+RfzH2zGAxXVHOk+0eAc0VJh+Biu1DLCw
         8KEBmQ8j1HSFbz1VJM/Gv574Rx+UEgWF4GEyOxw6jxOwN7woSWH4rz3nkvzciYOj8gde
         GDmQ==
X-Gm-Message-State: AOAM532uIbCzRrFN+s6LDS9DS/1mZXnbIcpqwZvonR5KbPfPvLJPMunn
        IIvT0Nd1Ru+o2Ov5baFreaXWis1Wefv6
X-Google-Smtp-Source: ABdhPJxgP3QPfqhrDHlYbZvoBePrEE1LeamWczkyl3CHCs2p0Alr5VTy1rx2TlK6084IIR4Gb7TzZvSscmhG
X-Received: by 2002:ad4:5584:: with SMTP id e4mr2000014qvx.191.1589525794216;
 Thu, 14 May 2020 23:56:34 -0700 (PDT)
Date:   Thu, 14 May 2020 23:56:18 -0700
In-Reply-To: <20200515065624.21658-1-irogers@google.com>
Message-Id: <20200515065624.21658-3-irogers@google.com>
Mime-Version: 1.0
References: <20200515065624.21658-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH 2/8] libbpf hashmap: Remove unused #include
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
        Adrian Hunter <adrian.hunter@intel.com>,
        Leo Yan <leo.yan@linaro.org>, linux-kernel@vger.kernel.org,
        netdev@vger.kernel.org, bpf@vger.kernel.org
Cc:     Stephane Eranian <eranian@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove #include of libbpf_internal.h that is unused.
Discussed in this thread:
https://lore.kernel.org/lkml/CAEf4BzZRmiEds_8R8g4vaAeWvJzPb4xYLnpF0X2VNY8oTzkphQ@mail.gmail.com/

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/hashmap.h | 1 -
 1 file changed, 1 deletion(-)

diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
index bae8879cdf58..e823b35e7371 100644
--- a/tools/lib/bpf/hashmap.h
+++ b/tools/lib/bpf/hashmap.h
@@ -15,7 +15,6 @@
 #else
 #include <bits/reg.h>
 #endif
-#include "libbpf_internal.h"
 
 static inline size_t hash_bits(size_t h, int bits)
 {
-- 
2.26.2.761.g0e0b3e54be-goog

