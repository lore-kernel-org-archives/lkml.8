Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36198C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:44:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 063B32076A
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 14:44:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aw0P04YP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728130AbgCZOo2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 10:44:28 -0400
Received: from mail-qk1-f201.google.com ([209.85.222.201]:42502 "EHLO
        mail-qk1-f201.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728060AbgCZOoZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 10:44:25 -0400
Received: by mail-qk1-f201.google.com with SMTP id f206so4955603qke.9
        for <linux-kernel@vger.kernel.org>; Thu, 26 Mar 2020 07:44:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=uADEPLEkmZYfl7wsDudGbWabefvMuQ72zIel8QzC/WU=;
        b=aw0P04YP4yvA8GnGIM0IcXnPvtJDys1Gity150L+KCmm0IC/T5fGbPj9kC4kCEVNJ4
         9z8syQlUrww+G4voblWJf75Z6KRzu3d24JGR6TiMNBqStsOdio+mylrao3e92CrcY7LK
         QzGJpMPFaY45X6JLhgAw7rhDD+F0Jz0PwZW4ROIJm1pbACbd03E6sTciNdO6Xb2xvYY6
         IZSF2/47CDqMxYpMpTRNU0RubDpO+/S7+m5G//Uh2q+GRU58O9NWqPvP4lH4TsxRICYL
         ggJg3t9A9DyAAdsoXV3c1yfF6ts0TtxS3q+Q5j0mxGcUldYz06whBc5d1uUs/TmcGMxB
         GeZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=uADEPLEkmZYfl7wsDudGbWabefvMuQ72zIel8QzC/WU=;
        b=GEuMSHzSKtUFKWNniNAQUKy1yK7J9JFz4bx2UzItyynA6XkFhwAD+OcSNnMTRy2OYP
         81ZFofplsb1UNrkKmyd0VbUpysnCkhncUVkZ/MosVLkvRAWzrhCQyyctqmv77+SIHp8Y
         LAUQ3qX55AOpXMkvUzYyWPTbA0roeouynhlCwlzemF6FWd7u10R5vsblqL+vfqjs9Yq1
         PmGEj3UFosPuyuOI/NSh7ghFu2RI7We/Im5k7GgvL8eg33ybCjhVx34zsU1HAiBlWyQE
         /DOtYJa035F9rEPE09WIkwQiAFkIp8C3z7DzNawS131+7Qwp+gPjTPlkgvZWfa/lWc4c
         uSLQ==
X-Gm-Message-State: ANhLgQ3Ef9roKH8KIdHMhSN+fDvQ6KzuQWdv4m8Cn0M/8NoMEEsNOHzh
        HAtkV4gUleNQs7Mv2wBsye7bIHrH6/HGec/s
X-Google-Smtp-Source: ADFU+vs4gqRNBmQXkP6I3fFSrAC8BH3/Wz+XULZj0Pml6O/pA3hyTV2hkInmZiNHUchejwlpgz8UdPROVbbRnL5U
X-Received: by 2002:ac8:3565:: with SMTP id z34mr8683029qtb.168.1585233862532;
 Thu, 26 Mar 2020 07:44:22 -0700 (PDT)
Date:   Thu, 26 Mar 2020 15:44:02 +0100
In-Reply-To: <cover.1585233617.git.andreyknvl@google.com>
Message-Id: <6644839d3567df61ade3c4b246a46cacbe4f9e11.1585233617.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1585233617.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.26.0.rc2.310.g2932bb562d-goog
Subject: [PATCH v4 3/7] kcov: move t->kcov assignments into kcov_start/stop
From:   Andrey Konovalov <andreyknvl@google.com>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Alan Stern <stern@rowland.harvard.edu>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-usb@vger.kernel.org, linux-kernel@vger.kernel.org,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Andrey Konovalov <andreyknvl@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

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
2.26.0.rc2.310.g2932bb562d-goog

