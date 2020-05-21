Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B006C433E3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:10:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17849207D3
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 11:10:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aQ5u9oAY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729232AbgEULKv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 07:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729074AbgEULJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 07:09:57 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CCBBDC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 04:09:55 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id y64so6967018qkc.19
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 04:09:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=COp0SyeTFByf68VoAMfHccz/8jBHCco/jZeKm/gYFRA=;
        b=aQ5u9oAYI6gfKMpWzxJs3wceUj/S99J299ERHsuEXPNRKarnAdABxjyLU71gf3H1xw
         ZoC3iz7MAXNgMX9bNCU+5ypV7q75vsesrLnA7Sl6z0tNIb61lWZrS/OEZhi6n2SFdLVc
         3bgc0tbs1BCpIl6T3MtxzIYw9GSIzL7RTw5GFbOBNeHfnNng6TKunnNGnWg5O2PD/hPo
         YHXevu4xMyJygAf7f6X/OAMgNaiswb6B9RL0ICQpXy0ISaDK6ZG/AIXzPd7wxfqLAiiE
         txiZZb9Op2bWpvR1tYtaoTtIg6Gcs9b6Fe5jFWflb6wfFYebqVN9fUgntbNEMohG/6Bd
         G0Dw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=COp0SyeTFByf68VoAMfHccz/8jBHCco/jZeKm/gYFRA=;
        b=ZEUOo+RMRW75SwW2rftgw/O5WuH17WeDQvXAB3BwLQer6Q2I1qxMg4cgh1gg4VqkHz
         a/hvTITN+AHgDsBFeHscXesCZoDpALU8fBrkHiHfdNPRXM0P+pqRpb/BWw+Kb78irNFE
         W3PT5pwkSUHei63o78zsEYPzlcPP6Bn9mbtYBLF94VFZO7fvkgOoB9QfYafSixmlHRQk
         90fE51mYoiQbExPZs0OLQOTxOj9yi4+FahxODThSxqO181JXqb3JQ7TobzhLnSCpqgT3
         JauRVaDADp95I/KTA9Z2V+SHJOP6IFqNfEPhD9awTfsv+Y18atfvf3ZzV0pRiMous7xf
         Wiyg==
X-Gm-Message-State: AOAM5331ZMRF+5kOTKLxHN6uvIKJYDHIOJQdwvuzVoKwllOKIEEVW+A2
        btETjhlNE8Lt0okR5UFZwikwjo6d2w==
X-Google-Smtp-Source: ABdhPJwEW5cdhdqp56l7R0q8gopUm72VDGJ5VcGYLFn06OR+m5M2z+9wqaplK3JNSnAFI/omgcTejiPnYg==
X-Received: by 2002:a05:6214:1594:: with SMTP id m20mr693518qvw.110.1590059394941;
 Thu, 21 May 2020 04:09:54 -0700 (PDT)
Date:   Thu, 21 May 2020 13:08:45 +0200
In-Reply-To: <20200521110854.114437-1-elver@google.com>
Message-Id: <20200521110854.114437-3-elver@google.com>
Mime-Version: 1.0
References: <20200521110854.114437-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip v2 02/11] kcsan: Avoid inserting __tsan_func_entry/exit
 if possible
From:   Marco Elver <elver@google.com>
To:     elver@google.com
Cc:     paulmck@kernel.org, dvyukov@google.com, glider@google.com,
        andreyknvl@google.com, kasan-dev@googlegroups.com,
        linux-kernel@vger.kernel.org, tglx@linutronix.de, mingo@kernel.org,
        peterz@infradead.org, will@kernel.org,
        clang-built-linux@googlegroups.com, bp@alien8.de
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To avoid inserting  __tsan_func_{entry,exit}, add option if supported by
compiler. Currently only Clang can be told to not emit calls to these
functions. It is safe to not emit these, since KCSAN does not rely on
them.

Note that, if we disable __tsan_func_{entry,exit}(), we need to disable
tail-call optimization in sanitized compilation units, as otherwise we
may skip frames in the stack trace; in particular when the tail called
function is one of the KCSAN's runtime functions, and a report is
generated, might we miss the function where the actual access occurred.
Since __tsan_func_{entry,exit}() insertion effectively disabled
tail-call optimization, there should be no observable change. [This was
caught and confirmed with kcsan-test & UNWINDER_ORC.]

Signed-off-by: Marco Elver <elver@google.com>
---
 scripts/Makefile.kcsan | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/scripts/Makefile.kcsan b/scripts/Makefile.kcsan
index caf1111a28ae..20337a7ecf54 100644
--- a/scripts/Makefile.kcsan
+++ b/scripts/Makefile.kcsan
@@ -1,6 +1,15 @@
 # SPDX-License-Identifier: GPL-2.0
 ifdef CONFIG_KCSAN
 
-CFLAGS_KCSAN := -fsanitize=thread
+# GCC and Clang accept backend options differently. Do not wrap in cc-option,
+# because Clang accepts "--param" even if it is unused.
+ifdef CONFIG_CC_IS_CLANG
+cc-param = -mllvm -$(1)
+else
+cc-param = --param -$(1)
+endif
+
+CFLAGS_KCSAN := -fsanitize=thread \
+	$(call cc-option,$(call cc-param,tsan-instrument-func-entry-exit=0) -fno-optimize-sibling-calls)
 
 endif # CONFIG_KCSAN
-- 
2.26.2.761.g0e0b3e54be-goog

