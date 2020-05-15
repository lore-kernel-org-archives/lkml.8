Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9EEBC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 06:56:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C800220728
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 06:56:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KLdZkd7h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726821AbgEOG4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 02:56:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48370 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726722AbgEOG4j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 02:56:39 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FB55C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 23:56:39 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id d7so1566686ybp.12
        for <linux-kernel@vger.kernel.org>; Thu, 14 May 2020 23:56:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=rDN5X6ee0p3DPWcQJnEO6bz3ZGrQ0VwuHJwyeJb8UjA=;
        b=KLdZkd7htipcJURCMR14vvzpQP9A0y+OVxW6HSLzZHzFBZJHTKwz9IVBBxRF4GvUEm
         FSMZk7uKRPn2mlBTMmDdAt4esd/0s/s2wgWy5aAXz7LuQtGXRB+iIyTXNziR2p53QKE3
         T5PtllNVjRZJj4jCsHWttYebRTmUjfvvmRoDZtP0cJ7NI9MB3S+RPaCwNn8KeFIkYLI8
         0cJto9KU6HcZEH+wKsu4HJgbFDpQ5jMfV2/lsGTVbKVcr1J9sClqOkTc/McfHP0SuS/F
         XhDi9KXz9PRd5yRyXKq2SgvSHeLXQ916hTUQ41QXQgXuFNTFyzU/fLuAraZvRzw69afs
         DX7w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=rDN5X6ee0p3DPWcQJnEO6bz3ZGrQ0VwuHJwyeJb8UjA=;
        b=VAEWSVo5J+XAiI9qEHzpBN7b87yGTx94nf2OdKV/E/+GBcqWMwpPQ/z2AhSUwSx+3Z
         mFYA6pDW+Z/1sn+KjjPGGjbATGK/JJpUf+Dhg3RX2zTQZVOG38CDhdkC6fUvQCPzdIES
         XZjx7RYyD2zS1R5CQ3xFBndfHGCS5mDOc7yAVps0x8NIsskTowZQ2U0Zd0uIMxRJyGHg
         /ruS0ckGaFJ0utfxwDHo65gb8JXvoEAx5i0f3qTMbuWd/z1v/SkD4pt0jEFL1gPIukAA
         d/Gw0sA6XrWYB3datApYO5nukcFd24rEUzUimrtQAXC5F6YI8LNImUa4lNstokl+0znB
         L9kQ==
X-Gm-Message-State: AOAM530w94H3BbGTMvnaXQvJTZ18ta4RoLo8jqHEEOqYwU/08u4Tzv5c
        titWkFIw84bJJrWGgTpqbOzU2RrdaxDS
X-Google-Smtp-Source: ABdhPJyAKrEhG9hP88436bqQfTqIsJLRSZBZRWxiUsuHq6Q11uRmf18lQUT127u8JrDy04si5qc0Uj/kFk74
X-Received: by 2002:a25:a184:: with SMTP id a4mr3068042ybi.255.1589525797993;
 Thu, 14 May 2020 23:56:37 -0700 (PDT)
Date:   Thu, 14 May 2020 23:56:20 -0700
In-Reply-To: <20200515065624.21658-1-irogers@google.com>
Message-Id: <20200515065624.21658-5-irogers@google.com>
Mime-Version: 1.0
References: <20200515065624.21658-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH 4/8] libbpf hashmap: Localize static hashmap__* symbols
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

Localize the hashmap__* symbols in libbpf.a. To allow for a version in
libapi.

Before:
$ nm libbpf.a
...
000000000002088a t hashmap_add_entry
000000000001712a t hashmap__append
0000000000020aa3 T hashmap__capacity
000000000002099c T hashmap__clear
00000000000208b3 t hashmap_del_entry
0000000000020fc1 T hashmap__delete
0000000000020f29 T hashmap__find
0000000000020c6c t hashmap_find_entry
0000000000020a61 T hashmap__free
0000000000020b08 t hashmap_grow
00000000000208dd T hashmap__init
0000000000020d35 T hashmap__insert
0000000000020ab5 t hashmap_needs_to_grow
0000000000020947 T hashmap__new
0000000000000775 t hashmap__set
00000000000212f8 t hashmap__set
0000000000020a91 T hashmap__size
...

After:
$ nm libbpf.a
...
000000000002088a t hashmap_add_entry
000000000001712a t hashmap__append
0000000000020aa3 t hashmap__capacity
000000000002099c t hashmap__clear
00000000000208b3 t hashmap_del_entry
0000000000020fc1 t hashmap__delete
0000000000020f29 t hashmap__find
0000000000020c6c t hashmap_find_entry
0000000000020a61 t hashmap__free
0000000000020b08 t hashmap_grow
00000000000208dd t hashmap__init
0000000000020d35 t hashmap__insert
0000000000020ab5 t hashmap_needs_to_grow
0000000000020947 t hashmap__new
0000000000000775 t hashmap__set
00000000000212f8 t hashmap__set
0000000000020a91 t hashmap__size
...

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/Makefile | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/tools/lib/bpf/Makefile b/tools/lib/bpf/Makefile
index aee7f1a83c77..4a1cdbceb04e 100644
--- a/tools/lib/bpf/Makefile
+++ b/tools/lib/bpf/Makefile
@@ -20,6 +20,7 @@ srctree := $(patsubst %/,%,$(dir $(srctree)))
 endif
 
 INSTALL = install
+OBJCOPY ?= objcopy
 
 # Use DESTDIR for installing into a different root directory.
 # This is useful for building a package. The program will be
@@ -181,6 +182,7 @@ $(BPF_IN_SHARED): force elfdep zdep bpfdep $(BPF_HELPER_DEFS)
 
 $(BPF_IN_STATIC): force elfdep zdep bpfdep $(BPF_HELPER_DEFS)
 	$(Q)$(MAKE) $(build)=libbpf OUTPUT=$(STATIC_OBJDIR)
+	$(Q)$(OBJCOPY) -w -L hashmap__\* $@
 
 $(BPF_HELPER_DEFS): $(srctree)/tools/include/uapi/linux/bpf.h
 	$(QUIET_GEN)$(srctree)/scripts/bpf_helpers_doc.py --header \
-- 
2.26.2.761.g0e0b3e54be-goog

