Return-Path: <SRS0=Q7wL=5E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE035C4332E
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:12:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B50A120772
	for <linux-kernel@archiver.kernel.org>; Thu, 19 Mar 2020 22:12:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="vi4yd//X"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727473AbgCSWMC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 19 Mar 2020 18:12:02 -0400
Received: from mail-ua1-f74.google.com ([209.85.222.74]:46739 "EHLO
        mail-ua1-f74.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727414AbgCSWL7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 Mar 2020 18:11:59 -0400
Received: by mail-ua1-f74.google.com with SMTP id 16so1137878uag.13
        for <linux-kernel@vger.kernel.org>; Thu, 19 Mar 2020 15:11:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=ld+R5siiu+UwqEtDb2zf/maAwFxPn7jOV9EKhch9NhQ=;
        b=vi4yd//XT/ycSMaTNHQqhaOLWRGn33ZoH4GU+cE7Gp4hJydy8CkIKJ71fjfYqHiaoq
         3qyUHWxlOqDPc4jUzTgEvVFzYwBbk6sKcVhdkQVm8rP07jXijGRrptyfiDB5E0CLEg3J
         NGYp7tysmwQ3rGZWUTBaAn7OUHk+SgQ6WnUMN+F/qZG30yBCuQghffizGGc+rOo7s5SG
         3LQnqDXks6FYQspWrcYVuSZZNjULqkxKrR8/FgnnNjZwm0BzxrQvrHXc3oZDSybxhttw
         0LIuSRGeri1Et75dEh4xe6YlRaZoLSPuhZTR+aNNvKzLU+mMQ1yHzHsbsAdsPodMOK/O
         m9Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ld+R5siiu+UwqEtDb2zf/maAwFxPn7jOV9EKhch9NhQ=;
        b=QhUZw0TLdO/hOqnJVPjj/+PRn9UrYUPU8veWLvNKD87XRI+ex/3MWyeBMPPEom+zor
         eWH8BiBxjk3cfGO/RVYaW1PwjQng1NsL2LLzQD4wiHX2Zo766uAuxTyFinajI7hZnw8+
         O9mjrMDiqADi9psoeJTgtXhP65MCCONQ9cw6owVo6xygg3EriYA9GgwS+3+9x9/vF2fR
         SNTaxj/CAgq0AvfgIOxhIc8eSlX4Xzqe24U0BRjQD0EUVWl61rGocArJBQ2VWinLgKHq
         S9su/POP5ZcExRIuxs7TuimKJ0n9vQNvgqVHMzfT4UIK1lmd+WCIl1NDfQFYrjd7ZF+9
         POLg==
X-Gm-Message-State: ANhLgQ1tZ9Iuo66aD0KchoLHo6I3Qv3SpucENS6FBRN586aDYzRMnmjh
        zcAX4o1aT/7+KBildsyV/50f7ii8E1q1sSnc
X-Google-Smtp-Source: ADFU+vv1mUpuq5PW/oJ6gSyaoeZD4m+C1EOIoJQygnrtzOhMLarXysTNKxk6+S5zvGfSBgotQugAPT6j//2vkVh3
X-Received: by 2002:a1f:640c:: with SMTP id y12mr4359974vkb.73.1584655916275;
 Thu, 19 Mar 2020 15:11:56 -0700 (PDT)
Date:   Thu, 19 Mar 2020 23:11:36 +0100
In-Reply-To: <cover.1584655448.git.andreyknvl@google.com>
Message-Id: <de0d3d30ff90776a2a509cc34c7c1c7521bda125.1584655448.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1584655448.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.25.1.696.g5e7596f4ac-goog
Subject: [PATCH v3 2/7] kcov: fix potential use-after-free in kcov_remote_start
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

If vmalloc() fails in kcov_remote_start() we'll access remote->kcov
without holding kcov_remote_lock, so remote might potentially be freed
at that point. Cache kcov pointer in a local variable.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 kernel/kcov.c | 14 ++++++++------
 1 file changed, 8 insertions(+), 6 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index f6bd119c9419..cc5900ac2467 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -748,6 +748,7 @@ static const struct file_operations kcov_fops = {
 void kcov_remote_start(u64 handle)
 {
 	struct kcov_remote *remote;
+	struct kcov *kcov;
 	void *area;
 	struct task_struct *t;
 	unsigned int size;
@@ -774,16 +775,17 @@ void kcov_remote_start(u64 handle)
 		spin_unlock(&kcov_remote_lock);
 		return;
 	}
+	kcov = remote->kcov;
 	/* Put in kcov_remote_stop(). */
-	kcov_get(remote->kcov);
-	t->kcov = remote->kcov;
+	kcov_get(kcov);
+	t->kcov = kcov;
 	/*
 	 * Read kcov fields before unlock to prevent races with
 	 * KCOV_DISABLE / kcov_remote_reset().
 	 */
-	size = remote->kcov->remote_size;
-	mode = remote->kcov->mode;
-	sequence = remote->kcov->sequence;
+	size = kcov->remote_size;
+	mode = kcov->mode;
+	sequence = kcov->sequence;
 	area = kcov_remote_area_get(size);
 	spin_unlock(&kcov_remote_lock);
 
@@ -791,7 +793,7 @@ void kcov_remote_start(u64 handle)
 		area = vmalloc(size * sizeof(unsigned long));
 		if (!area) {
 			t->kcov = NULL;
-			kcov_put(remote->kcov);
+			kcov_put(kcov);
 			return;
 		}
 	}
-- 
2.25.1.696.g5e7596f4ac-goog

