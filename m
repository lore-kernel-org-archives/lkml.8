Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 730F3C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:09:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4D15C2088E
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 11:09:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=sargun.me header.i=@sargun.me header.b="K/pq77Jv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388189AbgE1LJ3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 07:09:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388111AbgE1LJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 07:09:25 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C57DAC08C5C5
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 04:09:24 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id n15so2980606pjt.4
        for <linux-kernel@vger.kernel.org>; Thu, 28 May 2020 04:09:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sargun.me; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=BQVnG714Kn4j7kGsUMAy9Ya/MWVCVOEAKJXkZw2BpyE=;
        b=K/pq77Jvp7GPjybsFJjhftJfXp6Vy4i0MOjKAb7BXQP8k4eWloz5D2uq7aMoUCnB74
         Esm2Q4yy/m4zB9nQ1BrVLqLEGjE7MS3mBXqJnCbRZ/3AVRhjiEjmLFhA4CNAJlW0NLGX
         HqR9XTswsQ72zmQ/mgbNn4FhO4SWKRP0nOPPM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BQVnG714Kn4j7kGsUMAy9Ya/MWVCVOEAKJXkZw2BpyE=;
        b=SgbvNSyEXW1PdYgcSXgpooIAouITfcisAf9uhUsEPvvlmBKxstqun+ywfLAZXcMEKC
         jo3X65Q4LhTJAsAUgQRepqK/rgbNVYcn+MbUsgAr0Wmfn3aMMdoMz6BNvTyDl2kc1p3z
         Q2p3aEi2Ovd60LKLKCwVRto04TbQJdaYkAAvKG6ORrBp1j9vZG0ehRxP1IPy190ucmM5
         WOCNqByVl04d/n/DVqBuhB9xaS5tHBKnS/BN4vZ1I5Q130RXtSqD6eBbuTPMACAE22ZE
         tFwsw4S29Gd+lhNuyV/Dxkip2GeqeK74JBjSF2Oy/dmqEVzM0REe5+yOQdYE5xWwCv0t
         eFjg==
X-Gm-Message-State: AOAM530Kx0W0vMwJOunRbhAhdckPebyEhBopLaMmX9MEoTuG10vbMg2z
        RCTVy/m4aC8yvEkQDng2ilcJjg==
X-Google-Smtp-Source: ABdhPJwvd+KUD4/bdIO+gFQvdQ+DmhDI+JXnViWKDFnoFyqSaXcgEp81OuYcxXKQTfSBB/eIqPsbdw==
X-Received: by 2002:a17:902:d711:: with SMTP id w17mr3092593ply.122.1590664164095;
        Thu, 28 May 2020 04:09:24 -0700 (PDT)
Received: from ubuntu.netflix.com (203.20.25.136.in-addr.arpa. [136.25.20.203])
        by smtp.gmail.com with ESMTPSA id j26sm4565759pfr.215.2020.05.28.04.09.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 28 May 2020 04:09:23 -0700 (PDT)
From:   Sargun Dhillon <sargun@sargun.me>
To:     keescook@chromium.org
Cc:     Sargun Dhillon <sargun@sargun.me>, christian.brauner@ubuntu.com,
        containers@lists.linux-foundation.org, cyphar@cyphar.com,
        jannh@google.com, jeffv@google.com, linux-api@vger.kernel.org,
        linux-kernel@vger.kernel.org, palmer@google.com, rsesek@google.com,
        tycho@tycho.ws, Matt Denton <mpdenton@google.com>,
        Kees Cook <keescook@google.com>
Subject: [PATCH v2 1/3] seccomp: Add find_notification helper
Date:   Thu, 28 May 2020 04:08:56 -0700
Message-Id: <20200528110858.3265-2-sargun@sargun.me>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200528110858.3265-1-sargun@sargun.me>
References: <20200528110858.3265-1-sargun@sargun.me>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This adds a helper which can iterate through a seccomp_filter to
find a notification matching an ID. It removes several replicated
chunks of code.

Signed-off-by: Sargun Dhillon <sargun@sargun.me>
Cc: Matt Denton <mpdenton@google.com>
Cc: Kees Cook <keescook@google.com>,
Cc: Jann Horn <jannh@google.com>,
Cc: Robert Sesek <rsesek@google.com>,
Cc: Chris Palmer <palmer@google.com>
Cc: Christian Brauner <christian.brauner@ubuntu.com>
Cc: Tycho Andersen <tycho@tycho.ws>
---
 kernel/seccomp.c | 51 ++++++++++++++++++++++++------------------------
 1 file changed, 25 insertions(+), 26 deletions(-)

diff --git a/kernel/seccomp.c b/kernel/seccomp.c
index 55a6184f5990..94ae4c7502cc 100644
--- a/kernel/seccomp.c
+++ b/kernel/seccomp.c
@@ -1021,10 +1021,25 @@ static int seccomp_notify_release(struct inode *inode, struct file *file)
 	return 0;
 }
 
+/* must be called with notif_lock held */
+static inline struct seccomp_knotif *
+find_notification(struct seccomp_filter *filter, u64 id)
+{
+	struct seccomp_knotif *cur;
+
+	list_for_each_entry(cur, &filter->notif->notifications, list) {
+		if (cur->id == id)
+			return cur;
+	}
+
+	return NULL;
+}
+
+
 static long seccomp_notify_recv(struct seccomp_filter *filter,
 				void __user *buf)
 {
-	struct seccomp_knotif *knotif = NULL, *cur;
+	struct seccomp_knotif *knotif, *cur;
 	struct seccomp_notif unotif;
 	ssize_t ret;
 
@@ -1078,14 +1093,8 @@ static long seccomp_notify_recv(struct seccomp_filter *filter,
 		 * may have died when we released the lock, so we need to make
 		 * sure it's still around.
 		 */
-		knotif = NULL;
 		mutex_lock(&filter->notify_lock);
-		list_for_each_entry(cur, &filter->notif->notifications, list) {
-			if (cur->id == unotif.id) {
-				knotif = cur;
-				break;
-			}
-		}
+		knotif = find_notification(filter, unotif.id);
 
 		if (knotif) {
 			knotif->state = SECCOMP_NOTIFY_INIT;
@@ -1101,7 +1110,7 @@ static long seccomp_notify_send(struct seccomp_filter *filter,
 				void __user *buf)
 {
 	struct seccomp_notif_resp resp = {};
-	struct seccomp_knotif *knotif = NULL, *cur;
+	struct seccomp_knotif *knotif;
 	long ret;
 
 	if (copy_from_user(&resp, buf, sizeof(resp)))
@@ -1118,13 +1127,7 @@ static long seccomp_notify_send(struct seccomp_filter *filter,
 	if (ret < 0)
 		return ret;
 
-	list_for_each_entry(cur, &filter->notif->notifications, list) {
-		if (cur->id == resp.id) {
-			knotif = cur;
-			break;
-		}
-	}
-
+	knotif = find_notification(filter, resp.id);
 	if (!knotif) {
 		ret = -ENOENT;
 		goto out;
@@ -1150,7 +1153,7 @@ static long seccomp_notify_send(struct seccomp_filter *filter,
 static long seccomp_notify_id_valid(struct seccomp_filter *filter,
 				    void __user *buf)
 {
-	struct seccomp_knotif *knotif = NULL;
+	struct seccomp_knotif *knotif;
 	u64 id;
 	long ret;
 
@@ -1161,16 +1164,12 @@ static long seccomp_notify_id_valid(struct seccomp_filter *filter,
 	if (ret < 0)
 		return ret;
 
-	ret = -ENOENT;
-	list_for_each_entry(knotif, &filter->notif->notifications, list) {
-		if (knotif->id == id) {
-			if (knotif->state == SECCOMP_NOTIFY_SENT)
-				ret = 0;
-			goto out;
-		}
-	}
+	knotif = find_notification(filter, id);
+	if (knotif && knotif->state == SECCOMP_NOTIFY_SENT)
+		ret = 0;
+	else
+		ret = -ENOENT;
 
-out:
 	mutex_unlock(&filter->notify_lock);
 	return ret;
 }
-- 
2.25.1

