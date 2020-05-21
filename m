Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-22.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7036FC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CE2D2072C
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZKStJW0o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729771AbgEUOXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:23:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729572AbgEUOWb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:22:31 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38090C05BD43
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:22:30 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id y189so5500929ybc.14
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:22:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Brlwg7pmXrMxrU6QOfUVrfzRnJMhki/06xHbbYhdDQQ=;
        b=ZKStJW0oYpwxuBFtjn9/g4UjdwFx/2iHufjgLbOHsxJxbJyr2TjhwZtzb0Afdz6WrN
         0vw8L2kGgfPZhJRhl9LDdTPw8LbYFNmm1FP7J50zUxoKk3Rtr5LEz3PMOZ+ocmSAa7E6
         KEtQ56F4ZHI8D0pMjlZVocIjBpRRQFoXCfaPA9BAsv6mhMeUitonAGUzlv7tWz1d8r90
         vQUxc+7GF+Ylq21bnYvlJxZCLiwM9n5WwcM91ePHuRgCabBnm0RuU8ag1pVZpgGybZ+d
         9aWC1fus8SEts5QyAjsOcaeMwcvTWK3WMbprnugw+jUwpb6/KWQFYP1Sm1Irg4g2RP/q
         Yb9g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Brlwg7pmXrMxrU6QOfUVrfzRnJMhki/06xHbbYhdDQQ=;
        b=HyagyWfVxOkjrl8e/GPMSUJX7jbQVXmw/kGEuw7zHvqSczi3ZipQgdbv5ZJcABQyp8
         FplD+lc5+/KqIJS8oydnqVWkHFQcXzd2LoPpdOBtCKoczFyE3k0iSm8czJqS+LsUFSiS
         QUTJMeP6xNzqb8ZKIo8l7Z1tKUv+Jh1mVFPxbAEp3Id4Ar6Fv2yfUaSUHK3tvO5Ixo9h
         k98V1fqnu6r3FbHKAM8jxhQThLP0bjfkDNU9KfwwfPLDEdbitA35DYX41WF6biWE2iXF
         gRZCti/1gE2Lt4m7Pmm1EnqvIlxd5pBn6RiwtmDRPOqd2gRePZqriSwRqboe2KHvcbmI
         sFqg==
X-Gm-Message-State: AOAM531CzVU5+sLKbyTnP4xQLOf3Jg79K6ZXGKhsRe+oXB8hqmHz0u6T
        JNBgVOZ3BjEwMXQOx5miux6NSl3l5g==
X-Google-Smtp-Source: ABdhPJyyhH3M4bnzK4CiqrTGzPDYD/I+5WGFOnenD+idnQQYn5gpVQY6sG8w/KDS3IwQAprBeWpoxc2Hxg==
X-Received: by 2002:a25:3214:: with SMTP id y20mr5166798yby.362.1590070949416;
 Thu, 21 May 2020 07:22:29 -0700 (PDT)
Date:   Thu, 21 May 2020 16:20:40 +0200
In-Reply-To: <20200521142047.169334-1-elver@google.com>
Message-Id: <20200521142047.169334-5-elver@google.com>
Mime-Version: 1.0
References: <20200521142047.169334-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip v3 04/11] kcsan: Pass option tsan-instrument-read-before-write
 to Clang
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

Clang (unlike GCC) removes reads before writes with matching addresses
in the same basic block. This is an optimization for TSAN, since writes
will always cause conflict if the preceding read would have.

However, for KCSAN we cannot rely on this option, because we apply
several special rules to writes, in particular when the
KCSAN_ASSUME_PLAIN_WRITES_ATOMIC option is selected. To avoid missing
potential data races, pass the -tsan-instrument-read-before-write option
to Clang if it is available [1].

[1] https://github.com/llvm/llvm-project/commit/151ed6aa38a3ec6c01973b35f684586b6e1c0f7e

Acked-by: Will Deacon <will@kernel.org>
Signed-off-by: Marco Elver <elver@google.com>
---
 scripts/Makefile.kcsan | 1 +
 1 file changed, 1 insertion(+)

diff --git a/scripts/Makefile.kcsan b/scripts/Makefile.kcsan
index 75d2942b9437..bd4da1af5953 100644
--- a/scripts/Makefile.kcsan
+++ b/scripts/Makefile.kcsan
@@ -13,6 +13,7 @@ endif
 # of some options does not break KCSAN nor causes false positive reports.
 CFLAGS_KCSAN := -fsanitize=thread \
 	$(call cc-option,$(call cc-param,tsan-instrument-func-entry-exit=0) -fno-optimize-sibling-calls) \
+	$(call cc-option,$(call cc-param,tsan-instrument-read-before-write=1)) \
 	$(call cc-param,tsan-distinguish-volatile=1)
 
 endif # CONFIG_KCSAN
-- 
2.26.2.761.g0e0b3e54be-goog

