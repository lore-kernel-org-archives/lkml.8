Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C34EBC433E5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:17:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9D5802065F
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 06:17:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jCza9kOb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726076AbgGTGRq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 02:17:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725805AbgGTGRp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 02:17:45 -0400
Received: from mail-pl1-x64a.google.com (mail-pl1-x64a.google.com [IPv6:2607:f8b0:4864:20::64a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F5ABC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 23:17:45 -0700 (PDT)
Received: by mail-pl1-x64a.google.com with SMTP id k4so9804466pll.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 23:17:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=hrTZ3ILM0xAvfuFOaXWaqEFvmBYS4j5nhBs2MogC2d4=;
        b=jCza9kObWWd7hRrzAmTOlTIznNK5au/+obW9N2t3FEDENVbFaIuGNwvI+czZfkkjfj
         yz5Acv84a48iP3jdHNxPq9oYAQ3JsaCd43nn72tDwiAb0KzKjz0D1eRaxZPmSvNI3v5p
         14yBIbxUS2mz1cy/VgcYLfGAwLfyPgaeo6KCWa24lFD8fcp2A8oN/a5lernNHq87QTsg
         uJDXeoEKZy1wotyY285VjM6pvyZt7ZdO0ouJqrQBQpT/blmMz44W6ZUa2RD3iVc6yJ3b
         7Xl+rFZB34WWL6EpieqghLEjm+gNI2iCaVcFn7br2mXNH9ssLJR3SbfkLhib6q4xprWM
         isOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=hrTZ3ILM0xAvfuFOaXWaqEFvmBYS4j5nhBs2MogC2d4=;
        b=WhBqVFD9NzAe0jNh6bYoXzkOvEDukDDtYnDlhPbiO740ILcbEgnjZAHfEJTx5JZv7u
         vtflUIR9cdGf3r5CzwAsSih2q3Cn60If1ntgLwBcSMr5EagZjidYVJ2iBSqEbDNSMMG8
         c26lH5ICLZ8oyYzVXJGRCWoqv+3MXfm3+vUxjTmpLmqgmsYHoiKb92mk1Lt1cDfmQ9tR
         00JQv+WngCykusi50slhQqz16fnU6/jzIf264syZGsI+OgYNrRjrgMjSGnD3wsqtjMkk
         tHmo9eh74EzkKBjmZPPvzojOIbfHi5/NcZuQMjUztOA6ua0cjeswu7BSPPBx+Mp8Bgze
         yPbg==
X-Gm-Message-State: AOAM531xrxzRle3uOLKgBqA9Lk1dLXSEtiTjmAHvsD7GFj9VRwVxRF80
        dhMHLMIoErjbFyqXCF3sMt3sNdAkYVO3
X-Google-Smtp-Source: ABdhPJxZ8KghvpQ17ZJUvd8FHOaqBfl50iarL4t96zD8AY8mjE1sgffczbDNvDrTORIDxuIPH0nKQjc6wtWJ
X-Received: by 2002:a17:902:b78b:: with SMTP id e11mr16332011pls.204.1595225864907;
 Sun, 19 Jul 2020 23:17:44 -0700 (PDT)
Date:   Sun, 19 Jul 2020 23:17:41 -0700
Message-Id: <20200720061741.1514673-1-irogers@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.105.gf9edc3c819-goog
Subject: [PATCH v2] libbpf bpf_helpers: Use __builtin_offsetof for offsetof
From:   Ian Rogers <irogers@google.com>
To:     Alexei Starovoitov <ast@kernel.org>,
        Daniel Borkmann <daniel@iogearbox.net>,
        Martin KaFai Lau <kafai@fb.com>,
        Song Liu <songliubraving@fb.com>, Yonghong Song <yhs@fb.com>,
        Andrii Nakryiko <andriin@fb.com>,
        John Fastabend <john.fastabend@gmail.com>,
        KP Singh <kpsingh@chromium.org>, netdev@vger.kernel.org,
        bpf@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Stanislav Fomichev <sdf@google.com>,
        Ian Rogers <irogers@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The non-builtin route for offsetof has a dependency on size_t from
stdlib.h/stdint.h that is undeclared and may break targets.
The offsetof macro in bpf_helpers may disable the same macro in other
headers that have a #ifdef offsetof guard. Rather than add additional
dependencies improve the offsetof macro declared here to use the
builtin that is available since llvm 3.7 (the first with a BPF backend).

Signed-off-by: Ian Rogers <irogers@google.com>
---
 tools/lib/bpf/bpf_helpers.h | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/tools/lib/bpf/bpf_helpers.h b/tools/lib/bpf/bpf_helpers.h
index a510d8ed716f..bc14db706b88 100644
--- a/tools/lib/bpf/bpf_helpers.h
+++ b/tools/lib/bpf/bpf_helpers.h
@@ -40,7 +40,7 @@
  * Helper macro to manipulate data structures
  */
 #ifndef offsetof
-#define offsetof(TYPE, MEMBER)  ((size_t)&((TYPE *)0)->MEMBER)
+#define offsetof(TYPE, MEMBER)  __builtin_offsetof(TYPE, MEMBER)
 #endif
 #ifndef container_of
 #define container_of(ptr, type, member)				\
-- 
2.28.0.rc0.105.gf9edc3c819-goog

