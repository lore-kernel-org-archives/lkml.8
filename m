Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1DDCBC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:04:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E82DD207BB
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:03:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="CglnwgQ4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726769AbgEOPD7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:03:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726720AbgEOPD5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:03:57 -0400
Received: from mail-qk1-x749.google.com (mail-qk1-x749.google.com [IPv6:2607:f8b0:4864:20::749])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16BF9C061A0C
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:03:56 -0700 (PDT)
Received: by mail-qk1-x749.google.com with SMTP id y64so2478949qkc.19
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:03:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=2TmNDvsOz0JxdxozHkAyPP+/TkRXJhNAPV4NJ14stug=;
        b=CglnwgQ45owCXDfNuG5fpjwb5+KoGYU6CDA52vUXRG6CkcUgOjJKJVguB97fCv/dsm
         LED5jdoM7IIGL1wgRFIjDkO2zsjRjeCvo6LH4QSaLqjlrzuCiQcHOuxmQX7tkWRsblyP
         0ZTyIIagaoFnUb3j40qvPkp4I3PvwzoKLLZyOzNN62xYP5a+kH2PcURIdJQqcSbTKf6M
         m9z9+zPbarvCZiUGPodVREh9XUxZVOLm6z8WB4Y7GMfye57lUH8GeAfT60Zvbt1M1tMn
         rC7dzWe9yVv+vUfEvn5iCR5UK/FTQdrtxm7ifa+ePoNtSFvN7d2VGLkxJD6KTUocOfZ+
         4n8A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=2TmNDvsOz0JxdxozHkAyPP+/TkRXJhNAPV4NJ14stug=;
        b=W/puGN1iBKTjkt6JSno0JHGAS7u1P53SMP3Oewinz8EemXP1u1OOLoR8Ayr6JiyGFw
         l1Uyptm4bRdMG9S8/j2JFfKSY7f4tsNWu39iVD0Z1uXhA0tNVXJPCOalFXsaC95LRtTh
         a8Fp1xyyK7HtckXQrdsrMgNn6YlXPFmQlhSH/d09IVUiozLjDgD6/tvcFdiRdZ3CF2x/
         th8WVMnUkJj3cZLMFaHXR/it2/jDxRSMn2RB2PND3y44d75qJ94iQwXiPfQ9LfkIMyeb
         qpLIpQui0n/5OoXpP5igLpTtFPog3Yrksq/Lvck/Oc9I7WT41fFNvE+XL3zohQNqfdDG
         q4pw==
X-Gm-Message-State: AOAM531l1xelPfSmCV0MjElaQonO/w04FdUKCGdxXX07S4c6crmUr4zj
        bqHLlxUoGmwaobyYfsaPASc6LT2+Bg==
X-Google-Smtp-Source: ABdhPJyy5iEO+R/1BRP4KHfXAiLBlpf/uT7hQ+viY65i8bSVXZ0r/Y6apEy0gj2QTIyZbtWEZiXbaY3Zkw==
X-Received: by 2002:a05:6214:3f0:: with SMTP id cf16mr4050654qvb.4.1589555035266;
 Fri, 15 May 2020 08:03:55 -0700 (PDT)
Date:   Fri, 15 May 2020 17:03:32 +0200
In-Reply-To: <20200515150338.190344-1-elver@google.com>
Message-Id: <20200515150338.190344-5-elver@google.com>
Mime-Version: 1.0
References: <20200515150338.190344-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip 04/10] kcsan: Pass option tsan-instrument-read-before-write
 to Clang
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, will@kernel.org,
        clang-built-linux@googlegroups.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Clang (unlike GCC) removes reads before writes with matching addresses
in the same basic block. This is an optimization for TSAN, since writes
will always cause conflict if the preceding read would have.

However, for KCSAN we cannot rely on this option, because we apply
several special rules to writes, in particular when the
KCSAN_ASSUME_PLAIN_WRITES_ATOMIC option is selected. To avoid missing
potential data races, pass the -tsan-instrument-read-before-write option
to Clang if it is available [1].

[1] https://github.com/llvm/llvm-project/commit/151ed6aa38a3ec6c01973b35f684586b6e1c0f7e

Signed-off-by: Marco Elver <elver@google.com>
---
 scripts/Makefile.kcsan | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/Makefile.kcsan b/scripts/Makefile.kcsan
index c02662b30a7c..ea4a6301633e 100644
--- a/scripts/Makefile.kcsan
+++ b/scripts/Makefile.kcsan
@@ -13,6 +13,7 @@ endif
 # if the absence of some options still allows us to use KCSAN in most cases.
 CFLAGS_KCSAN := -fsanitize=thread \
 	$(call cc-option,$(call cc-param,tsan-instrument-func-entry-exit=0) -fno-optimize-sibling-calls) \
+	$(call cc-option,$(call cc-param,tsan-instrument-read-before-write=1)) \
 	$(call cc-param,tsan-distinguish-volatile=1)
 
 endif # CONFIG_KCSAN
-- 
2.26.2.761.g0e0b3e54be-goog

