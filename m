Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ECE19C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 22:18:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CDFEE20758
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 22:18:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="khy2QACt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727817AbgEOWRr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 18:17:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726226AbgEOWRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 18:17:41 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5AAA3C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 15:17:40 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id d7so4297501ybp.12
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 15:17:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=tvl7gLFsS/dAedcEqfrKtncclZsMityBUyr8g2OugcQ=;
        b=khy2QACtaVinG3BdhesOMwGEVHZD5fXUFL+zMVH9b6ElIEU80EBdBN84tv5aCDv6Gc
         AgBq6MO97+V442M3Aau9ckM0dpGxubrAcQpZVaF8eE5GWIAZHMuqcH7H95bZU6H+F5XZ
         eN9aRT/gOPQeYniiMOoiKMw+1Aq8wtpEDgGQrmKVze/WozLXDNyxENP41dKV3P19yYMA
         GS84iFzfMp7PQj5wDK8D95IcVRC9k+YQc7SetRDH0rz0MrdbYQ//2ySHkAyV9OVoclPG
         23Oxq661bQxntYB12xI9/yOI3ytZXjRi4GYPLZMSONZ8eyNn9FnrW6Jbt/xQ7j3jS0fB
         41GQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=tvl7gLFsS/dAedcEqfrKtncclZsMityBUyr8g2OugcQ=;
        b=tJ+gVDpzpgBXaq4H0vV3x0C7/+B22NyWVmU55HoQt4pKehJmA7hsdj8CQU/Dm8xtJr
         Hlgw6vqXUcn8F/hqyg1OxOWY9C1mV1BkB/0j8zh3vpn0AG4A4Ocg1SooBu8N+HJQmdR/
         +g0MO0fFS4U7G/n9mJEIReCskqf4++ouqmEkqjrYNGJDgIX0+0Rs6vQBSytPDeFqGHx0
         Qj/gAjvtKzbG7bYewsIPDOcn8J0Kr2b87glhNaq5k5y60LhA+TocBGPyXaPA22PH1iNv
         KnfS35j6vfWOxi2ZOg2nG4YEjSVmKBdc+I8f6hVLJf0vS5NERYnv4cDtDmTOmFFlrlBx
         m72g==
X-Gm-Message-State: AOAM532BvUvTTue/R5FcJxDrzKETM7AYpb29qv+opAaW+87CxkZ/UEGa
        Qt1rs8E0SvY1fntDEQXjWUCI67fZYKnD
X-Google-Smtp-Source: ABdhPJyH6TcQkNDu//jdJAWoFOmMjTiSO5lvLDKJlvfVqXDU6eIwN1SwheXG/VI8XXlaqXykh7TONnMaUXeR
X-Received: by 2002:a25:bc4b:: with SMTP id d11mr9847249ybk.71.1589581059496;
 Fri, 15 May 2020 15:17:39 -0700 (PDT)
Date:   Fri, 15 May 2020 15:17:26 -0700
In-Reply-To: <20200515221732.44078-1-irogers@google.com>
Message-Id: <20200515221732.44078-2-irogers@google.com>
Mime-Version: 1.0
References: <20200515221732.44078-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH v3 1/7] libbpf: Fix memory leak and possible double-free in hashmap__clear
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
        Alston Tang <alston64@fb.com>, Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrii Nakryiko <andriin@fb.com>

Fix memory leak in hashmap_clear() not freeing hashmap_entry structs for each
of the remaining entries. Also NULL-out bucket list to prevent possible
double-free between hashmap__clear() and hashmap__free().

Running test_progs-asan flavor clearly showed this problem.

Reported-by: Alston Tang <alston64@fb.com>
Signed-off-by: Andrii Nakryiko <andriin@fb.com>
Signed-off-by: Alexei Starovoitov <ast@kernel.org>
Link: https://lore.kernel.org/bpf/20200429012111.277390-5-andriin@fb.com
Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/hashmap.c | 7 +++++++
 1 file changed, 7 insertions(+)

diff --git a/tools/lib/bpf/hashmap.c b/tools/lib/bpf/hashmap.c
index 54c30c802070..cffb96202e0d 100644
--- a/tools/lib/bpf/hashmap.c
+++ b/tools/lib/bpf/hashmap.c
@@ -59,7 +59,14 @@ struct hashmap *hashmap__new(hashmap_hash_fn hash_fn,
 
 void hashmap__clear(struct hashmap *map)
 {
+	struct hashmap_entry *cur, *tmp;
+	int bkt;
+
+	hashmap__for_each_entry_safe(map, cur, tmp, bkt) {
+		free(cur);
+	}
 	free(map->buckets);
+	map->buckets = NULL;
 	map->cap = map->cap_bits = map->sz = 0;
 }
 
-- 
2.26.2.761.g0e0b3e54be-goog

