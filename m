Return-Path: <SRS0=7UTg=7D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3CFEFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:22:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B46720829
	for <linux-kernel@archiver.kernel.org>; Thu, 21 May 2020 14:22:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b48sod3H"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729703AbgEUOWv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 21 May 2020 10:22:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729642AbgEUOWq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 May 2020 10:22:46 -0400
Received: from mail-qt1-x849.google.com (mail-qt1-x849.google.com [IPv6:2607:f8b0:4864:20::849])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAD5CC061A0E
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:22:45 -0700 (PDT)
Received: by mail-qt1-x849.google.com with SMTP id p31so7890322qte.1
        for <linux-kernel@vger.kernel.org>; Thu, 21 May 2020 07:22:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=LdWtxw6Vf28rU4H8/TQCyMB4NDqGcmdRqUmsRUyh1H4=;
        b=b48sod3HbCojcAZmoxv0Z0aZMP9yUixrODaXzldAdz8FeUPtp47mQ7BCJ1KpfW0wAy
         o8/CA7975VSpFt7cTFSzEvIneQ2GNaWzEG8WdSe9Mkq8bEG5WTc+tWWkmOYVN3a3z5Mm
         oeGV84IjafE6HwfqdxVc9WmQSWP1Xehk8+vVnGO7cQwZmCp3ttd90Ex82sJ4t9AaLGK6
         4VLzlR0QFv1lUEKx1YO3Ths1H9lVeUBfEMJvvtZtd+gKlBaMp+dPXIjYwzwzLR9FSdIq
         ac84Wt6ORNKj0wKASSXbc5KDHIG7mRR5a6n3A4BhTDTRZoq8q4sRPEQEztp0wQn1W6q5
         QxiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=LdWtxw6Vf28rU4H8/TQCyMB4NDqGcmdRqUmsRUyh1H4=;
        b=qzokkDybnoknNZP7LysaevtSJE812741xiWQ1X3aVgJr7cqwFSgCq7Qmf27CDoXg9X
         XYWzLGPbrAMW4Ns/0bGj+nQ5z5/1q3YB6N7jV185NUgFJMjizphenAzhBS+OupHhwC+V
         rGG7AgUysElAwOL8NCU60yRA5WvWcfgzQzTiXnbNm2xUr7WEHXnuoHf6xo4KsB++qsoK
         3CX7WCC/dC5KdjoebDtf2O3KoiMnxREvgVWESpjiMHDaF6g/E1/l5lpKePoPAMMRuGQZ
         pxGQPiYAsLZPB4YKKTAUO/l6EkerjLXky1V58XHcvHeQWJZi8MA/ADS1OhMNCbbfYXOw
         1EEw==
X-Gm-Message-State: AOAM533jhcfoODFz7VBgSaTBfmRfmE1RGxuf2LXtMaSzlnDnQdhLKzO7
        Y5CFulebRuqOqHJw2pxsZJCqzpRXzw==
X-Google-Smtp-Source: ABdhPJwZY+2KaSe7kVdMR9PNmwD17DVTAGherx2ae88TcoWo+ThCKZKIU3ko9V2RIzXipP7D74o0EPb8cg==
X-Received: by 2002:ad4:4a8b:: with SMTP id h11mr10542388qvx.232.1590070965164;
 Thu, 21 May 2020 07:22:45 -0700 (PDT)
Date:   Thu, 21 May 2020 16:20:47 +0200
In-Reply-To: <20200521142047.169334-1-elver@google.com>
Message-Id: <20200521142047.169334-12-elver@google.com>
Mime-Version: 1.0
References: <20200521142047.169334-1-elver@google.com>
X-Mailer: git-send-email 2.26.2.761.g0e0b3e54be-goog
Subject: [PATCH -tip v3 11/11] compiler_types.h, kasan: Use
 __SANITIZE_ADDRESS__ instead of CONFIG_KASAN to decide inlining
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

Like is done for KCSAN, for KASAN we should also use __always_inline in
compilation units that have instrumentation disabled
(KASAN_SANITIZE_foo.o := n). Adds common documentation for KASAN and
KCSAN explaining the attribute.

Acked-by: Will Deacon <will@kernel.org>
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

