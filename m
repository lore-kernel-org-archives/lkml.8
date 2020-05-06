Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99D1EC47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7AEC32075A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Xr+iZOjv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729416AbgEFUxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 16:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729199AbgEFUxG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 16:53:06 -0400
Received: from mail-yb1-xb4a.google.com (mail-yb1-xb4a.google.com [IPv6:2607:f8b0:4864:20::b4a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12D34C061BD3
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 13:53:05 -0700 (PDT)
Received: by mail-yb1-xb4a.google.com with SMTP id 186so4181441ybq.1
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 13:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=SB+0qR8XBn8IFJQ/MG0Miycx8pxpjR3L5u9CDE0na6s=;
        b=Xr+iZOjvxcNqSpKCGofVocwfNYahKeswTd3EUNRVcV6W1+/yk6KkvpVOHowLJgRnTQ
         +bm+jG/e2f0TpEX6VaspQ3/LKIOohlS4DZ++8/cjk/v9az6hCTs3spdYcclANMkZiUJu
         btxV+qnCtPj1EJlGIMCYVCcebOTMKbdwOxAthGT/iJXib711W+dOlmFgR/63Q4KCMH9e
         oCcVtnM8qQd0qqRA4Oq5laRGzDKX2NFtzoUOjys9BfzK3a2DXZpH9C1YgZ7XebptGl6x
         Wl1uyB+UjheCRiRevb5m+IiXrOQv1LUxb7q8yiRFdFPCFwyFKgmoxpZKS90b9TYrDPiN
         Ae+Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=SB+0qR8XBn8IFJQ/MG0Miycx8pxpjR3L5u9CDE0na6s=;
        b=S5SQuTbSTEWPXWZ7a5YCW8ahANOXegylKpSnyUJRuMcQCQLmGyTupPvk0lofypV9Jl
         EhA7N7HLsrUy92Ywmh01hBDLrQY1UorSx0MOmKpc/MJjEhN4hfB6DCnMMxymN3Q935nj
         Fek+WhAeiUMjTmVJ5rB15gRnfLXE91t+boRWMSWGHzYshbnh4c6eeisr1eeZSOraLqSG
         RW+oStHfEVcAoF4MYMpBRUF7tIMz84NSgKkpmce46+ke3i3MXGr4JbY4PfzK6VfT/mU+
         47E9SpnmNGxERDiApGYgiv+CzE07pmjNYZ9H5cVxmflMkbhzj6WPSNwRmydVc/WqQYIN
         8+3w==
X-Gm-Message-State: AGi0PuZWgaClTS83LSV2h/skGuAwj3L2hFpn1rVwUVp5bynBOALv1zZ2
        OFss9BY8+JAg0JVdOiVsVb88N5N/VbBo
X-Google-Smtp-Source: APiQypIK8JSaVfoCzIrg6e3WCCDvIPqs+/RQUmEbxLMoi1zTKYaJYw7eV7fYGNtJKA8UWjfLwBNT6BzkrEvd
X-Received: by 2002:a25:9384:: with SMTP id a4mr16176208ybm.79.1588798384256;
 Wed, 06 May 2020 13:53:04 -0700 (PDT)
Date:   Wed,  6 May 2020 13:52:57 -0700
In-Reply-To: <20200506205257.8964-1-irogers@google.com>
Message-Id: <20200506205257.8964-3-irogers@google.com>
Mime-Version: 1.0
References: <20200506205257.8964-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 2/2] lib/bpf hashmap: fixes to hashmap__clear
From:   Ian Rogers <irogers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

hashmap_find_entry assumes that if buckets is NULL then there are no
entries. NULL the buckets in clear to ensure this.
Free hashmap entries and not just the bucket array.

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/hashmap.c | 6 ++++++
 1 file changed, 6 insertions(+)

diff --git a/tools/lib/bpf/hashmap.c b/tools/lib/bpf/hashmap.c
index 54c30c802070..1a1bca1ff5cd 100644
--- a/tools/lib/bpf/hashmap.c
+++ b/tools/lib/bpf/hashmap.c
@@ -59,7 +59,13 @@ struct hashmap *hashmap__new(hashmap_hash_fn hash_fn,
 
 void hashmap__clear(struct hashmap *map)
 {
+	struct hashmap_entry *cur, *tmp;
+	size_t bkt;
+
+	hashmap__for_each_entry_safe(map, cur, tmp, bkt)
+		free(cur);
 	free(map->buckets);
+	map->buckets = NULL;
 	map->cap = map->cap_bits = map->sz = 0;
 }
 
-- 
2.26.2.526.g744177e7f7-goog

