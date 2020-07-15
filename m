Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 42F07C433EA
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 03:11:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 20F8520729
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 03:11:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=massaru-org.20150623.gappssmtp.com header.i=@massaru-org.20150623.gappssmtp.com header.b="ovEc7xb3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728329AbgGODLg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 23:11:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59768 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726769AbgGODLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 23:11:32 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5276EC061794
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 20:11:32 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id g13so609955qtv.8
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 20:11:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=massaru-org.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=f7B6nRu17D4hLq2dpnNEqUTozGMt7UQuNjvdNS+jJbU=;
        b=ovEc7xb3UBenViTIJEoNSptb30ZAYlKnZjOp5qED9m/e22xilVePTic9UoGc55lE+k
         kC75wEyvi6w6pCgu/7TfFf2BIdHVuuDsGmXyvFz9fC9+5JtIQq6aV36WN4hGo1nutneB
         M9rFUvpemCWKnKmOs+654u/Kc2/LoSZ57OddYNwJjsIETuOai/i7G3NkkMeJE/rbRzPU
         Di41NNl8yWr84/KYvGxbzQBO6utP/n7V+ikzI1FL7c53G3cMP+Fm5EdHaegqgxy3pHV7
         YufZu+DIVy9Iw2ZFfMyfHo4iluz1F1H7RTgQ9JcEdL/Hm8aLPhaCSGysnx1gQVJolQ/C
         EtVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=f7B6nRu17D4hLq2dpnNEqUTozGMt7UQuNjvdNS+jJbU=;
        b=G833W3Vv1DwmKWcvXxypF5OyOOfp9Ew01RKr5yau2yc+Qzszhy00KX/YYKuJaNqHex
         fRAivSg6hmob4HVSMW5dz7jhSh1wbLtfihhxbTC5rcVbysNTW3vo+FL8YSymR0SWF5p0
         rYngaCz2wiLDunNTvAHgpxtsJBZUuN+nMXrFghMnpk0+zsiU+GUfBOb4Noamj/NUluBq
         lUxturl+0ByQUmNc3kBig5uHk0YZ0HrdIndSp1hedoto7SZQ+LoC5eNho9XoBCIzSHGx
         KmzQEr/ZCi6gNOcl+SeYVDXNvIZCug9UrUK1uwlrWhJYclsS1Z1wInoXEmbrFDOFZIF8
         Y0Sg==
X-Gm-Message-State: AOAM531QGc6syhJJUIiH+qwga5F8unfF/bleeJtCJECBbs360bpjjvCM
        8SOw8UhMKH74XGIiQGtMhCxqnA==
X-Google-Smtp-Source: ABdhPJxA8gzAAxGa3RZYJ9BLUMX1vyYZ+/mghOsWxHg2iON1/daKdrj6Rb3bTwDGFcNnKyMHc6PpYw==
X-Received: by 2002:aed:20e5:: with SMTP id 92mr8045746qtb.388.1594782691550;
        Tue, 14 Jul 2020 20:11:31 -0700 (PDT)
Received: from bbking.lan ([2804:14c:4a5:36c::cd2])
        by smtp.gmail.com with ESMTPSA id x29sm1269229qtx.74.2020.07.14.20.11.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 20:11:31 -0700 (PDT)
From:   Vitor Massaru Iha <vitor@massaru.org>
To:     kunit-dev@googlegroups.com
Cc:     linux-kselftest@vger.kernel.org, linux-kernel@vger.kernel.org,
        brendanhiggins@google.com, keescook@chromium.org,
        davidgow@google.com, skhan@linuxfoundation.org,
        linux-kernel-mentees@lists.linuxfoundation.org
Subject: [RFC 2/3] lib: Allows to borrow mm in userspace on KUnit
Date:   Wed, 15 Jul 2020 00:11:19 -0300
Message-Id: <20200715031120.1002016-3-vitor@massaru.org>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200715031120.1002016-1-vitor@massaru.org>
References: <20200715031120.1002016-1-vitor@massaru.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Vitor Massaru Iha <vitor@massaru.org>
---
 include/kunit/test.h  |  1 +
 lib/kunit/try-catch.c | 15 ++++++++++++++-
 2 files changed, 15 insertions(+), 1 deletion(-)

diff --git a/include/kunit/test.h b/include/kunit/test.h
index 59f3144f009a..49c38bdcb93e 100644
--- a/include/kunit/test.h
+++ b/include/kunit/test.h
@@ -222,6 +222,7 @@ struct kunit {
 	 * protect it with some type of lock.
 	 */
 	struct list_head resources; /* Protected by lock. */
+	struct mm_struct *mm;
 };
 
 void kunit_init_test(struct kunit *test, const char *name, char *log);
diff --git a/lib/kunit/try-catch.c b/lib/kunit/try-catch.c
index 0dd434e40487..f677c2f2a51a 100644
--- a/lib/kunit/try-catch.c
+++ b/lib/kunit/try-catch.c
@@ -11,7 +11,8 @@
 #include <linux/completion.h>
 #include <linux/kernel.h>
 #include <linux/kthread.h>
-
+#include <linux/sched/mm.h>
+#include <linux/sched/task.h>
 #include "try-catch-impl.h"
 
 void __noreturn kunit_try_catch_throw(struct kunit_try_catch *try_catch)
@@ -24,8 +25,17 @@ EXPORT_SYMBOL_GPL(kunit_try_catch_throw);
 static int kunit_generic_run_threadfn_adapter(void *data)
 {
 	struct kunit_try_catch *try_catch = data;
+	struct kunit *test = try_catch->test;
+	
+	if (test->mm != NULL)
+		kthread_use_mm(try_catch->test->mm);
 
 	try_catch->try(try_catch->context);
+	if (try_catch->test->mm) {
+		if (test->mm != NULL)
+			kthread_unuse_mm(try_catch->test->mm);
+		try_catch->test->mm = NULL;
+	}
 
 	complete_and_exit(try_catch->try_completion, 0);
 }
@@ -65,6 +75,9 @@ void kunit_try_catch_run(struct kunit_try_catch *try_catch, void *context)
 	try_catch->context = context;
 	try_catch->try_completion = &try_completion;
 	try_catch->try_result = 0;
+
+	test->mm = get_task_mm(current);
+
 	task_struct = kthread_run(kunit_generic_run_threadfn_adapter,
 				  try_catch,
 				  "kunit_try_catch_thread");
-- 
2.26.2

