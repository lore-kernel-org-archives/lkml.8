Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3129AC54E49
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:10:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0FC382083B
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 14:10:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="MbcHpI1S"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728258AbgEGOKR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 10:10:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46096 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728256AbgEGOIu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 10:08:50 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 13368C05BD09
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 07:08:50 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id w6so6849601qtt.21
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 07:08:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dJgmTX+e/XhBfHBE3JA0uHT0QwjnDN/7PIiY44zE/Pk=;
        b=MbcHpI1S5OxMmKRIL8TmEwAjmGUuXiQUNWFjjN/YpqFTRBD28jHsEegJVELa5W2k/9
         agkiEFw7uakxlx7LIOatx3eUukVnVn0MX1SdDkQwJzXM+Y6M2N3zKYZAyCDMwWCJgy2M
         JBlNzYMrEduwie1OvQrSwG8YaMYQii6XclidLVgaYWWMD3ddbi39V5bC3xMmWl3cV8oZ
         GvAUZw/74ADf8w/0A+sA97fiDE+T8g8zgMq8TDE6prBfrYqLthp7JHLjFbszGMXNXuca
         WT59CP91C8yIadGORdXB7PvIbWHaO45YbqSSxU5QDB6+oiQmCHFasvhmPsBfbgtxxVqm
         x4WQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dJgmTX+e/XhBfHBE3JA0uHT0QwjnDN/7PIiY44zE/Pk=;
        b=D2FP7QMfIvtgUdFKxCZfJEsHo5FqdPkLMjR2QaIqbuwgJmrK2DFNZ401dAChhcn8ER
         vCyZXekbvLpu0pyG6VPr2V94kEjAXZXNVFo+GDWS47tNLkJEVPwgfnMWsw/YWTjvxkUM
         iiQSpdsm/G2XqZWl91GmO019vf9db/AKGn7XhL1JHBbNOa820NRrDYUgzK27B1vtfHQE
         5qZILbE08hRTxa+crplvOqftyN8ejq2zDIDuXsesJsGoJGo2vhxw2NGmW1SAs1p8oCr8
         o8pZ1WtrsC3bEsS21Lg3hycxD7djefmsNAGrOv2ms0gOB1NnidggbBN4mCuzGsqj/Mwq
         +57A==
X-Gm-Message-State: AGi0PubuMt/7ZoXHAFPZ9RM/QRAMXpEtl1U0vwG90lY/oYeWBupDXxWN
        xzxuanem3V3SEQHaZ46XOkD8WKTDDTjI
X-Google-Smtp-Source: APiQypLCl/Z5EIdl/XTfe2GJCrqiaYwhgjj4RK37r3mcFcJW50Dz8UgEcRa3XlIlulU2fheTegM9wZXLkQPa
X-Received: by 2002:ad4:4105:: with SMTP id i5mr13742509qvp.205.1588860529184;
 Thu, 07 May 2020 07:08:49 -0700 (PDT)
Date:   Thu,  7 May 2020 07:08:09 -0700
In-Reply-To: <20200507140819.126960-1-irogers@google.com>
Message-Id: <20200507140819.126960-14-irogers@google.com>
Mime-Version: 1.0
References: <20200507140819.126960-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [RFC PATCH v2 13/23] lib/bpf hashmap: increase portability
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

Don't include libbpf_internal.h as it is unused and has conflicting
definitions, for example, with tools/perf/util/debug.h.
Fix a non-glibc include path.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/hashmap.h | 3 +--
 1 file changed, 1 insertion(+), 2 deletions(-)

diff --git a/tools/lib/bpf/hashmap.h b/tools/lib/bpf/hashmap.h
index bae8879cdf58..d5ef212a55ba 100644
--- a/tools/lib/bpf/hashmap.h
+++ b/tools/lib/bpf/hashmap.h
@@ -13,9 +13,8 @@
 #ifdef __GLIBC__
 #include <bits/wordsize.h>
 #else
-#include <bits/reg.h>
+#include <linux/bitops.h>
 #endif
-#include "libbpf_internal.h"
 
 static inline size_t hash_bits(size_t h, int bits)
 {
-- 
2.26.2.526.g744177e7f7-goog

