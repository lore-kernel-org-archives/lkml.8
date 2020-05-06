Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 78E99C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:53:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5936F2070B
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 20:53:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="gGVy3gtn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729372AbgEFUxI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 16:53:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729165AbgEFUxE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 16:53:04 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E97AC061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 13:53:03 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id o196so1078271ybg.8
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 13:53:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=dJgmTX+e/XhBfHBE3JA0uHT0QwjnDN/7PIiY44zE/Pk=;
        b=gGVy3gtntk0Uc7UCwP+FmllS0TJ0vTX+9b59y1mwtzGaZ5J6BH4aFo62Nffy6GZiem
         kHmIq/nTHs7zbLxFgy9Vx+DJMIYoErhptmmadYveT83LL5Lf/A/2Awy/UjMTMM7sQZ/1
         M/35LWinZoz7iI8wHnRADpxYlDoCVRXD5FXpOjF5isTLqy/XmLhv/EUAhLve+SD7G4M+
         4dhykzxKlX4xmMGMj2lWZ/Rh08rY4eAfsd31rbAwWcx3xRIj4D+hVSGUh0TuYC4Q4Qli
         nZgdeAn8IcaMkrb0SMirMY/RnxpE2y45cDdNEbXGiwEPh0GCotYQAfeaYQzvbJFVPI2q
         htcQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=dJgmTX+e/XhBfHBE3JA0uHT0QwjnDN/7PIiY44zE/Pk=;
        b=Mqpkk6GfMqQeGQ8boqM4roeBjUxyeDMkIfXQOFwC0ykO6XFAO7kBf0aSu4KExabzdy
         qGMeG3IbqrLJC36lTAKf4qyITAHd1LgwY3skk7+DR9EJd5XP3x52tiNec9A5DqjFGD2/
         2Tm4f1Myd3hW+hi4L/dzx27RHohgjfCh+KA+1BWLClGqNgzbewzKEFzJoAZ1XJ2ee2RA
         YZXYmQDxi/tkUcjekqgZaVUOavwL90wSLAFP5z7hpRzzmHZ+P0TADyeqqI+XoyLtJI67
         /LW/Fywa3DswaLDLKZdhoMVcRezJ5vePrLmgv0P6vYpZ7D+qZ6Q+zPsrPOT97pC2JGpZ
         7eAg==
X-Gm-Message-State: AGi0PuYieUOTIWGtsvcumpHgi8UZBevyzsmLFYxtdP8bDlK0XKgGALsq
        q4e06HcVAJCcAsDJV/PwL9b89T0Euuze
X-Google-Smtp-Source: APiQypL+xl7cKR+jywmrDx0uv/1rQsbpSkPAK2E6PJ105uDYGQnhvEVqq0Hg8bS+5A725HwfyFHlpE/UUIeV
X-Received: by 2002:a25:60d6:: with SMTP id u205mr17106071ybb.440.1588798382336;
 Wed, 06 May 2020 13:53:02 -0700 (PDT)
Date:   Wed,  6 May 2020 13:52:56 -0700
In-Reply-To: <20200506205257.8964-1-irogers@google.com>
Message-Id: <20200506205257.8964-2-irogers@google.com>
Mime-Version: 1.0
References: <20200506205257.8964-1-irogers@google.com>
X-Mailer: git-send-email 2.26.2.526.g744177e7f7-goog
Subject: [PATCH 1/2] lib/bpf hashmap: increase portability
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

