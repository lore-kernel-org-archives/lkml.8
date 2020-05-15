Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 471BAC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:50:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2116620727
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 16:50:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lWDuCPSE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727001AbgEOQuw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 12:50:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726525AbgEOQuR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 12:50:17 -0400
Received: from mail-qv1-xf4a.google.com (mail-qv1-xf4a.google.com [IPv6:2607:f8b0:4864:20::f4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 122CCC05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 09:50:17 -0700 (PDT)
Received: by mail-qv1-xf4a.google.com with SMTP id g15so3191246qvx.6
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 09:50:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=6zJdeczCxXIR05ROPjfL5M3I5d1ozekeF2WaxmhUPXo=;
        b=lWDuCPSEHnSqfmNmK7U6zSigGtw2pUvPEmqBm3E79EfmUdhRFZKr9rmmlG8SLtiTLY
         8HCqoaQuGDPxignnWBj97QPYO0GwwkgCH1z0wTKLYpS7vxYkxdK21eAfNqBq1eACYnKW
         X/07rqk/NxKbF66ALRKpmYyVR/Wyx+OYTCq24+o2G2V49wg3xHyYb7VUXnnmYcp+gEQF
         nL2XDaWLaYS/Je45LXoeJJMo6D2hMR2jOfXa7nomoK6/lPSR11Brli1vClEnVFZqT/pv
         2sIB00W6zEXOfVYKy1WDxw2k2tj56W5+R3oq9j7OmEXIeXAyCBwW0+ZP4ExwI5AK0m5d
         F/Eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=6zJdeczCxXIR05ROPjfL5M3I5d1ozekeF2WaxmhUPXo=;
        b=mY01iszEBny8ZJqJRK9Y0AeXhYH2k9KlL7Zab2jBeTaAlx9Lvx+8tjq+E3xFtXEisb
         N42ZLrxzIEw78pLe6NCokLvlqe7GQzSPpwEyNLSNwF0JG6CHWzZjIgbj0LbbeWJHx1iq
         6VDSX4M1C2GnSky+/TinVyQnfnqGJYZFumJbLJvWEyZKPAEyGcZCtrRf/dlxx6g0vR0A
         40x3D6gEqjq+LBSJe7bSv5sy9KfMS/EBDaRh0Tfc5ajNb+p1qeJm//QW5osPpNxU2HXO
         4eheP0CYfndP61HZf1jtgQTUDrO2ukCqEvrL1yX7hL8s450L+GAYApxUhqldCPAZbHKk
         S/Lg==
X-Gm-Message-State: AOAM532ddkBdhMUN4wsfsDIxF8VVrSUtyWXk39bIJqrdLONBfoYG967x
        5mJKNOJyllk2hmc5nJSQ/O9eKVfVYeZ0
X-Google-Smtp-Source: ABdhPJzJeU3KJoEKMsk2E7nrlFXgcd2WBQbWwlr2cF809BRrmVmF2HWm35q7vDzY8rUFv8F6tFzwUDUNfz/I
X-Received: by 2002:a0c:b58a:: with SMTP id g10mr4291860qve.225.1589561416205;
 Fri, 15 May 2020 09:50:16 -0700 (PDT)
Date:   Fri, 15 May 2020 09:50:02 -0700
In-Reply-To: <20200515165007.217120-1-irogers@google.com>
Message-Id: <20200515165007.217120-3-irogers@google.com>
Mime-Version: 1.0
References: <20200515165007.217120-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v2 2/7] libbpf hashmap: Remove unused #include
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

