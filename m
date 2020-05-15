Return-Path: <SRS0=BsgQ=65=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55B8EC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:04:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 32C2F207CB
	for <linux-kernel@archiver.kernel.org>; Fri, 15 May 2020 15:04:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="e24SsoWQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727125AbgEOPEO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 15 May 2020 11:04:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39904 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727050AbgEOPEL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 May 2020 11:04:11 -0400
Received: from mail-qk1-x74a.google.com (mail-qk1-x74a.google.com [IPv6:2607:f8b0:4864:20::74a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C70EC05BD09
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:04:10 -0700 (PDT)
Received: by mail-qk1-x74a.google.com with SMTP id v6so2495453qkd.9
        for <linux-kernel@vger.kernel.org>; Fri, 15 May 2020 08:04:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=Mg9xxMrsMAxLq6dAWJl0xfMkvPwKVEQaVFcZauCDO10=;
        b=e24SsoWQSUj2uB2CQgR9qlqwlX343goXb7MFhkh3wVuVdWSC4G4hgGc3jHtJOG8PIA
         3j/H/8sSd1mRn7nCanFkFnrmSxUZ/bWbG7la/WbOvyIJ1qDJX39fN0VE1h+QdfXbqR91
         GYdk/GDVBhK8gJ/6D7baYnhm4iETZW1cKw2pwvarOxt+YpZfHMfxFjAiaESUOHnp0o8D
         Zijr6JJR2u4aD7wpElLMvaQc7IswOF43xWkvsDNCgaDoNs8xhm9WIheMu6XBv9fiUTCz
         6kPhVILjrL9ykNprZixSWXp3705aH3wlX5ZXxX7oJwxwfhXt6cUgG7AItaWDByPrNasS
         h85Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=Mg9xxMrsMAxLq6dAWJl0xfMkvPwKVEQaVFcZauCDO10=;
        b=FyprO6liFP2D/8qpF3QttGdWQF+4xt5LzNret893avon9XgzdnZc0OiYBvhENTWoE2
         nmQnMVThR9sVV2m9KNTRaKtDl989WsBD5w+YEe0wEIabay2P0oz7iMu0OW3y9MPGfBef
         Uh0QGpAGusk3LtYt7RSULQ7tg8ADYdT+tSfTuXGES78bDFeg1wjHbp8rj3VGuNrDnsV5
         OdVURbjUcrc49RoMGPg5ZdmrsE2jAt4kLrepJrwSJMk4pC3kGYgcp72ucC8MbEAK3SO5
         z7bxU0qWufV5qzcnVRuZ56gPxaiUVxhYJZNrsbzJiONdt6CBI/kMV1LZWzQEruAoyWJA
         HghQ==
X-Gm-Message-State: AOAM531i/3HJ6E1zfiyzqJTDl/pSmCeedQ/QSfzO0VWOswqOqc53EJ+S
        uz30vcPHR9xfyqOuSYqe7lZAzyyyWg==
X-Google-Smtp-Source: ABdhPJxMdMx6ULlN85hcEPGXCxW1oJsdcs5tbbuQVLMbb+X9aQRhS0L79oQF1XqPk0KG9pCMXUkzM6/UbA==
X-Received: by 2002:a05:6214:8e1:: with SMTP id dr1mr3588892qvb.193.1589555049514;
 Fri, 15 May 2020 08:04:09 -0700 (PDT)
Date:   Fri, 15 May 2020 17:03:38 +0200
In-Reply-To: <20200515150338.190344-1-elver@google.com>
Message-Id: <20200515150338.190344-11-elver@google.com>
Mime-Version: 1.0
References: <20200515150338.190344-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip 10/10] compiler_types.h, kasan: Use __SANITIZE_ADDRESS__
 instead of CONFIG_KASAN to decide inlining
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

Like is done for KCSAN, for KASAN we should also use __always_inline in
compilation units that have instrumentation disabled
(KASAN_SANITIZE_foo.o := n). Adds common documentation for KASAN and
KCSAN explaining the attribute.

Signed-off-by: Marco Elver <elver@google.com>
---
 include/linux/compiler_types.h | 13 ++++++++-----
 1 file changed, 8 insertions(+), 5 deletions(-)

diff --git a/include/linux/compiler_types.h b/include/linux/compiler_types.h
index b190a12e7089..5faf68eae204 100644
--- a/include/linux/compiler_types.h
+++ b/include/linux/compiler_types.h
@@ -167,7 +167,14 @@ struct ftrace_likely_data {
  */
 #define noinline_for_stack noinline
 
-#ifdef CONFIG_KASAN
+/*
+ * Sanitizer helper attributes: Because using __always_inline and
+ * __no_sanitize_* conflict, provide helper attributes that will either expand
+ * to __no_sanitize_* in compilation units where instrumentation is enabled
+ * (__SANITIZE_*__), or __always_inline in compilation units without
+ * instrumentation (__SANITIZE_*__ undefined).
+ */
+#ifdef __SANITIZE_ADDRESS__
 /*
  * We can't declare function 'inline' because __no_sanitize_address conflicts
  * with inlining. Attempt to inline it may cause a build failure.
@@ -182,10 +189,6 @@ struct ftrace_likely_data {
 
 #define __no_kcsan __no_sanitize_thread
 #ifdef __SANITIZE_THREAD__
-/*
- * Rely on __SANITIZE_THREAD__ instead of CONFIG_KCSAN, to avoid not inlining in
- * compilation units where instrumentation is disabled.
- */
 # define __no_kcsan_or_inline __no_kcsan notrace __maybe_unused
 # define __no_sanitize_or_inline __no_kcsan_or_inline
 #else
-- 
2.26.2.761.g0e0b3e54be-goog

