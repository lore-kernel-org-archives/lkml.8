Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4128CC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:27:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 12F62205F4
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 18:27:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="k0mnC82E"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgCIS1Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 14:27:16 -0400
Received: from mail-vs1-f73.google.com ([209.85.217.73]:34777 "EHLO
        mail-vs1-f73.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727350AbgCIS1P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 14:27:15 -0400
Received: by mail-vs1-f73.google.com with SMTP id o125so945607vso.1
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 11:27:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:in-reply-to:message-id:mime-version:references:subject:from:to
         :cc;
        bh=V/S5AKIJvKiSrpagse0M8LVn3gjInQdj5+INVxyxn2I=;
        b=k0mnC82EVoH+i6x5fWR7SRHrL2Gvy4xjTm2XciyDH5A5DAnvNsuo3L5PuIuj7KqKke
         +bupQozYWVbgQJxfmBxDQEgBVkXNfPy3niXh6peyBlNl7Z/l9q1qI9nHVLzCWX36IJJ9
         8yLfxmwLlcQOfDLnoGkpOVcZtYmwDxS9pcJM+qk+iM44v/DlHuYT/vzXeGJBbS3EbyVl
         vo3tnaycop/Hkk62+e6MWuUIsLYl5L1q+HfTSr+dq4XgXyP+xO3sSff+VssFI2s4hTrM
         40wKHVxNlCJQNbjBJjn2kOF6O2+V5n8XKrVesQyYYbHOSCItm5jiJZZ9z9i9HF2yLmNj
         J+LQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=V/S5AKIJvKiSrpagse0M8LVn3gjInQdj5+INVxyxn2I=;
        b=PI3c1iouDyGusfUgJ7B5ux5pVzbX4T42SGO8Jgr625mJfA93iVh3R+QRzFPTvhj6Y6
         aduMcK0POTZzbVmHKkYQuEnYI4LIDXwJKRlwQJKCRmtzJ+oTxbQlwOiVyWbwXLMLS/7Q
         x67o5W3UXkwEwHQXJ+0kBKo3FbQxAM0PF80afoALNCrDn+HM4wofOO2B6Pq5ee0DN2AC
         WA+x2/y+m7rkQkzPRJFpkXbxn4AmwvxnPFX4n6Ih5PBOnGEgCnZxnczOvjFodgKzciPG
         ViZp7JTeggpyeD85buzK4tBCviW/zT+KDMiozZbnAcTT6mNBp/z3QK7Di1ih3WuyYmrO
         KKgw==
X-Gm-Message-State: ANhLgQ0hf/8W3esVE9WZtinTeyXDiwCfT2TqxCd4ob9KxpZZn9Yobkos
        Ni1Asl5wTSeaCfym9bx8tCPxppdfhqaXs8Js
X-Google-Smtp-Source: ADFU+vsw1LRkv9SbqulZgMkkOO3i9Bz2V6l2VBFRAjv86nTfa7sDXBD2LCEd37RD4oP1Op2pa7aPEZMQCE0VyJS5
X-Received: by 2002:a9f:3b08:: with SMTP id i8mr5224190uah.68.1583778433124;
 Mon, 09 Mar 2020 11:27:13 -0700 (PDT)
Date:   Mon,  9 Mar 2020 19:27:04 +0100
In-Reply-To: <cover.1583778264.git.andreyknvl@google.com>
Message-Id: <b9ec058ef7895cc699a2ddd9b6987e0a3f62cc91.1583778264.git.andreyknvl@google.com>
Mime-Version: 1.0
References: <cover.1583778264.git.andreyknvl@google.com>
X-Mailer: git-send-email 2.25.1.481.gfbce0eb801-goog
Subject: [PATCH v2 1/3] kcov: cleanup debug messages
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

Previous commit left a lot of excessive debug messages, clean them up.

Signed-off-by: Andrey Konovalov <andreyknvl@google.com>
---
 kernel/kcov.c | 22 ++--------------------
 1 file changed, 2 insertions(+), 20 deletions(-)

diff --git a/kernel/kcov.c b/kernel/kcov.c
index f50354202dbe..f6bd119c9419 100644
--- a/kernel/kcov.c
+++ b/kernel/kcov.c
@@ -98,6 +98,7 @@ static struct kcov_remote *kcov_remote_find(u64 handle)
 	return NULL;
 }
 
+/* Must be called with kcov_remote_lock locked. */
 static struct kcov_remote *kcov_remote_add(struct kcov *kcov, u64 handle)
 {
 	struct kcov_remote *remote;
@@ -119,16 +120,13 @@ static struct kcov_remote_area *kcov_remote_area_get(unsigned int size)
 	struct kcov_remote_area *area;
 	struct list_head *pos;
 
-	kcov_debug("size = %u\n", size);
 	list_for_each(pos, &kcov_remote_areas) {
 		area = list_entry(pos, struct kcov_remote_area, list);
 		if (area->size == size) {
 			list_del(&area->list);
-			kcov_debug("rv = %px\n", area);
 			return area;
 		}
 	}
-	kcov_debug("rv = NULL\n");
 	return NULL;
 }
 
@@ -136,7 +134,6 @@ static struct kcov_remote_area *kcov_remote_area_get(unsigned int size)
 static void kcov_remote_area_put(struct kcov_remote_area *area,
 					unsigned int size)
 {
-	kcov_debug("area = %px, size = %u\n", area, size);
 	INIT_LIST_HEAD(&area->list);
 	area->size = size;
 	list_add(&area->list, &kcov_remote_areas);
@@ -366,7 +363,6 @@ static void kcov_remote_reset(struct kcov *kcov)
 	hash_for_each_safe(kcov_remote_map, bkt, tmp, remote, hnode) {
 		if (remote->kcov != kcov)
 			continue;
-		kcov_debug("removing handle %llx\n", remote->handle);
 		hash_del(&remote->hnode);
 		kfree(remote);
 	}
@@ -553,7 +549,6 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 
 	switch (cmd) {
 	case KCOV_INIT_TRACE:
-		kcov_debug("KCOV_INIT_TRACE\n");
 		/*
 		 * Enable kcov in trace mode and setup buffer size.
 		 * Must happen before anything else.
@@ -572,7 +567,6 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 		kcov->mode = KCOV_MODE_INIT;
 		return 0;
 	case KCOV_ENABLE:
-		kcov_debug("KCOV_ENABLE\n");
 		/*
 		 * Enable coverage for the current task.
 		 * At this point user must have been enabled trace mode,
@@ -598,7 +592,6 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 		kcov_get(kcov);
 		return 0;
 	case KCOV_DISABLE:
-		kcov_debug("KCOV_DISABLE\n");
 		/* Disable coverage for the current task. */
 		unused = arg;
 		if (unused != 0 || current->kcov != kcov)
@@ -610,7 +603,6 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 		kcov_put(kcov);
 		return 0;
 	case KCOV_REMOTE_ENABLE:
-		kcov_debug("KCOV_REMOTE_ENABLE\n");
 		if (kcov->mode != KCOV_MODE_INIT || !kcov->area)
 			return -EINVAL;
 		t = current;
@@ -629,7 +621,6 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 		kcov->remote_size = remote_arg->area_size;
 		spin_lock(&kcov_remote_lock);
 		for (i = 0; i < remote_arg->num_handles; i++) {
-			kcov_debug("handle %llx\n", remote_arg->handles[i]);
 			if (!kcov_check_handle(remote_arg->handles[i],
 						false, true, false)) {
 				spin_unlock(&kcov_remote_lock);
@@ -644,8 +635,6 @@ static int kcov_ioctl_locked(struct kcov *kcov, unsigned int cmd,
 			}
 		}
 		if (remote_arg->common_handle) {
-			kcov_debug("common handle %llx\n",
-					remote_arg->common_handle);
 			if (!kcov_check_handle(remote_arg->common_handle,
 						true, false, false)) {
 				spin_unlock(&kcov_remote_lock);
@@ -782,7 +771,6 @@ void kcov_remote_start(u64 handle)
 	spin_lock(&kcov_remote_lock);
 	remote = kcov_remote_find(handle);
 	if (!remote) {
-		kcov_debug("no remote found");
 		spin_unlock(&kcov_remote_lock);
 		return;
 	}
@@ -810,8 +798,6 @@ void kcov_remote_start(u64 handle)
 	/* Reset coverage size. */
 	*(u64 *)area = 0;
 
-	kcov_debug("area = %px, size = %u", area, size);
-
 	kcov_start(t, size, area, mode, sequence);
 
 }
@@ -881,10 +867,8 @@ void kcov_remote_stop(void)
 	unsigned int size = t->kcov_size;
 	int sequence = t->kcov_sequence;
 
-	if (!kcov) {
-		kcov_debug("no kcov found\n");
+	if (!kcov)
 		return;
-	}
 
 	kcov_stop(t);
 	t->kcov = NULL;
@@ -894,8 +878,6 @@ void kcov_remote_stop(void)
 	 * KCOV_DISABLE could have been called between kcov_remote_start()
 	 * and kcov_remote_stop(), hence the check.
 	 */
-	kcov_debug("move if: %d == %d && %d\n",
-		sequence, kcov->sequence, (int)kcov->remote);
 	if (sequence == kcov->sequence && kcov->remote)
 		kcov_move_area(kcov->mode, kcov->area, kcov->size, area);
 	spin_unlock(&kcov->lock);
-- 
2.25.1.481.gfbce0eb801-goog

