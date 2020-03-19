Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F36A4C4332D
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:12:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C9E2520782
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:12:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="K2+uoUuz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727521AbgCSWMJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 18:12:09 -0400
Received: from mail-qt1-f202.google.com ([209.85.160.202]:47436 "EHLO
        mail-qt1-f202.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727461AbgCSWMA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 18:12:00 -0400
Received: by mail-qt1-f202.google.com with SMTP id e21so4118872qts.14
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 15:12:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=fIqMwS00THjQL8QKegGCqQ7wHnAdSxWfj9DzW584Lig=;
        b=K2+uoUuzJ7qI2VyHeBWbmnAMRTedq8vu6UUh0qMuX/hX0rQCZrdcenzFPHyt/0UMXh
         c8vqUce2QA0jAZqHiJTEsbpd/sD9ihzGcL3DRauiNPXn3TDDZkDsocqbkoJ1JX2I0DrW
         HCYA9rphqPDkklXCWXisz84yxStV3Ovhxsqg+ep5NTvVU7EcRKcdT5a3vfFpMkN5GWtK
         b2BlK2fs5LSHotHrkB9QukzkrsIkWz7Xt1q+oMbes/nC7F/99p3ukZZ2h2eLgjEjB0Pn
         XOFAO3zxOqHR//HYKX0DmuvJjRm45OFp56Z0MLBuon4BZvPyjjZqDSuqNFVwavAqXk5t
         bCQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=fIqMwS00THjQL8QKegGCqQ7wHnAdSxWfj9DzW584Lig=;
        b=hRHvIEiMwjrlv0oDaD/PRwkHXN5gq94jifyn9Ej/qxDSG4JU2MLtTWG4aLyO99oEbn
         2dfBxBDlnKlCZnZMYs2Qil+tMQTpvhrYoYsBhwBJfPVQdHdkJ0H644JrIv7o+c59TVEm
         ZDobqpDQG77RS+V981rRlISN/x89nAi5yvFXjikrjKCaGghwu1iYiML2gm6RcNdHZ7xI
         Pn2ft0xlCSW5ZkR8nfLmuTVkvwP7snnuachQolb9987uEKuf4/z8NtWATlK9c3oZvaBl
         In5Pd2IFzVsYtN2JAyeohN0ST8PBcr3Hu9WmD10WtbmPa+Z20JRqAzn5hT0AtzKSQzx7
         SF/Q==
X-Gm-Message-State: ANhLgQ2JovIUFYfPZoWetzFlEUrl4PnY7ejr+3UeYUuIvp/Ty4qzu/gX
        7zIM5KAZb5fK209RoXkHg/SJiOVIUcKGEYOs
X-Google-Smtp-Source: ADFU+vtIWtDIAzLwtLZgt60qDzlAtH5D5+CqnrbWBsZPfua52L+P/AhW0RiO0jULC1lQ6jiz0Vs7L7bVGOSqhuAp
X-Received: by 2002:a05:6214:10e5:: with SMTP id q5mr447241qvt.245.1584655919958;
 Thu, 19 Mar 2020 15:11:59 -0700 (PDT)
Date:   Thu, 19 Mar 2020 23:11:37 +0100
In-Reply-To: <cover.1584655448.git.andreyknvl@google.com>
Message-Id: <82625ef3ff878f0b585763cc31d09d9b08ca37d6.1584655448.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1584655448.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v3 3/7] kcov: move t->kcov assignments into kcov_start/stop
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@gmail.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Andrey Konovalov <andreyknvl@gmail.com>

Every time kcov_start/stop() is called, t->kcov is also assigned, so
move the assignment into the functions.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 kernel/kcov.c | 16 +++++++---------
 1 file changed, 7 insertions(+), 9 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index cc5900ac2467..888d0a236b04 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -309,10 +309,12 @@ void notrace __sanitizer_cov_trace_switch(u64 val, u64 *cases)
 EXPORT_SYMBOL(__sanitizer_cov_trace_switch);
 #endif /* ifdef CONFIG_KCOV_ENABLE_COMPARISONS */
 
-static void kcov_start(struct task_struct *t, unsigned int size,
-			void *area, enum kcov_mode mode, int sequence)
+static void kcov_start(struct task_struct *t, struct kcov *kcov,
+			unsigned int size, void *area, enum kcov_mode mode,
+			int sequence)
 {
 	kcov_debug("t = %px, size = %u, area = %px\n", t, size, area);
+	t->kcov = kcov;
 	/* Cache in task struct for performance. */
 	t->kcov_size = size;
 	t->kcov_area = area;
@@ -326,6 +328,7 @@ static void kcov_stop(struct task_struct *t)
 {
 	WRITE_ONCE(t->kcov_mode, KCOV_MODE_DISABLED);
 	barrier();
+	t->kcov = NULL;
 	t->kcov_size = 0;
 	t->kcov_area = NULL;
 }
@@ -333,7 +336,6 @@ static void kcov_stop(struct task_struct *t)
 static void kcov_task_reset(struct task_struct *t)
 {
 	kcov_stop(t);
-	t->kcov = NULL;
 	t->kcov_sequence = 0;
 	t->kcov_handle = 0;
 }
@@ -584,9 +586,8 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 			return mode;
 		kcov_fault_in_area(kcov);
 		kcov->mode = mode;
-		kcov_start(t, kcov->size, kcov->area, kcov->mode,
+		kcov_start(t, kcov, kcov->size, kcov->area, kcov->mode,
 				kcov->sequence);
-		t->kcov = kcov;
 		kcov->t = t;
 		/* Put either in kcov_task_exit() or in KCOV_DISABLE. */
 		kcov_get(kcov);
@@ -778,7 +779,6 @@ void kcov_remote_start(u64 handle)
 	kcov = remote->kcov;
 	/* Put in kcov_remote_stop(). */
 	kcov_get(kcov);
-	t->kcov = kcov;
 	/*
 	 * Read kcov fields before unlock to prevent races with
 	 * KCOV_DISABLE / kcov_remote_reset().
@@ -792,7 +792,6 @@ void kcov_remote_start(u64 handle)
 	if (!area) {
 		area = vmalloc(size * sizeof(unsigned long));
 		if (!area) {
-			t->kcov = NULL;
 			kcov_put(kcov);
 			return;
 		}
@@ -800,7 +799,7 @@ void kcov_remote_start(u64 handle)
 	/* Reset coverage size. */
 	*(u64 *)area = 0;
 
-	kcov_start(t, size, area, mode, sequence);
+	kcov_start(t, kcov, size, area, mode, sequence);
 
 }
 EXPORT_SYMBOL(kcov_remote_start);
@@ -873,7 +872,6 @@ void kcov_remote_stop(void)
 		return;
 
 	kcov_stop(t);
-	t->kcov = NULL;
 
 	spin_lock(&kcov->lock);
 	/*
-- 
2.25.1.696.g5e7596f4ac-goog

