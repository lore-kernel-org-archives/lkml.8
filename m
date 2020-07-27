Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-20.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT,USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EABFAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:04:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C24CB20714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 12:04:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lBKpYkHX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728124AbgG0MEs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 08:04:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726555AbgG0MEr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 08:04:47 -0400
Received: from mail-ed1-x54a.google.com (mail-ed1-x54a.google.com [IPv6:2a00:1450:4864:20::54a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 86C9FC061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 05:04:47 -0700 (PDT)
Received: by mail-ed1-x54a.google.com with SMTP id r18so4212595edi.2
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 05:04:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3aunXEclUEnw9zzoqAt4B/Xd758KEGTBYGAew0JhOfI=;
        b=lBKpYkHXL9cr1MK5UhiU+WFNjkuT1DDsRrEWm/IjXB3rn7019pFX5OJ/MrKrZn293A
         lRpSS+pEpvHVYQW55rkeFnjRllBkf4WDcIyDNaPqLB2g/OrqGRwxBR/lLKm4/yl50jL6
         2hV1wL3ijYQMq/E1wK46J2bsmvKeZHkqMNYNEmda8UV4UzlHb3UrPhXkktNHfxZJBiKC
         6UYj4hI4vYvAbJ4D1El5WLNm+XGXsm1Jk1Z7TFb+/1uoTggHxQ+Nt7/gNhZTBFzZybCx
         n0lPdfmhHLEkMP1C5reJQKbRIhIWkIw2AN7RYW1KOEz3wvucSg8CxXUz4J91XgxCOKKr
         vwhg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3aunXEclUEnw9zzoqAt4B/Xd758KEGTBYGAew0JhOfI=;
        b=AqEWXXs1iKufbC1kSFFH/AS9gPjtRi3b9JXV94MQVVhR+mQmBvNYlxM35pudvHZU1m
         vEYrBaA3WEi4UA5XvTnU/iR9Bjs7t8wWEiZz2ov4Dmam22Yr9L2YfPt7MAMQ3VXcAtkb
         0jg2Ja2f5fkuVC9+rOJzNiNSWuOzwr/sn25T91ST2E7L1PCtyCo0d6c0mjIsRFBhgOdi
         ac+CNfDj6peK8ML0y3kdf2Uyvbb5yla2t50GPAR+84WgGyyNXVLCQK481orRx0pasYxI
         Vgc+XxNWcg0zJT2YPuCrb0Vv4FD7RUGM5BK/uafp8gQqneySQapliwFR0rApbRoL0itf
         EIVw==
X-Gm-Message-State: AOAM531YGtL7IXJhs2HV7e3+78byKITkoXPM8iMvsFlgZ4VWvLB1Bv5A
        qPeZfmUAmY1BbY/eArrY+Rwq+ZWlIA==
X-Google-Smtp-Source: ABdhPJxrpqCKrJECkR7sfWmBqjKOzGM9Av+BVYwV5eq55kxVIULvn4Ac35Kxre6lCbi6EpmQr7IR2bJqKg==
X-Received: by 2002:a17:907:7204:: with SMTP id dr4mr5894350ejc.258.1595851478002;
 Mon, 27 Jul 2020 05:04:38 -0700 (PDT)
Date:   Mon, 27 Jul 2020 14:04:24 +0200
Message-Id: <20200727120424.1627555-1-jannh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.28.0.rc0.142.g3c755180ce-goog
Subject: [PATCH v2] binder: Prevent context manager from incrementing ref 0
From:   Jann Horn <jannh@google.com>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "=?UTF-8?q?Arve=20Hj=C3=B8nnev=C3=A5g?=" <arve@android.com>,
        Todd Kjos <tkjos@android.com>,
        Martijn Coenen <maco@android.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Christian Brauner <christian@brauner.io>
Cc:     devel@driverdev.osuosl.org, Mattias Nissler <mnissler@google.com>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Binder is designed such that a binder_proc never has references to
itself. If this rule is violated, memory corruption can occur when a
process sends a transaction to itself; see e.g.
<https://syzkaller.appspot.com/bug?extid=09e05aba06723a94d43d>.

There is a remaining edgecase through which such a transaction-to-self
can still occur from the context of a task with BINDER_SET_CONTEXT_MGR
access:

 - task A opens /dev/binder twice, creating binder_proc instances P1
   and P2
 - P1 becomes context manager
 - P2 calls ACQUIRE on the magic handle 0, allocating index 0 in its
   handle table
 - P1 dies (by closing the /dev/binder fd and waiting a bit)
 - P2 becomes context manager
 - P2 calls ACQUIRE on the magic handle 0, allocating index 1 in its
   handle table
   [this triggers a warning: "binder: 1974:1974 tried to acquire
   reference to desc 0, got 1 instead"]
 - task B opens /dev/binder once, creating binder_proc instance P3
 - P3 calls P2 (via magic handle 0) with (void*)1 as argument (two-way
   transaction)
 - P2 receives the handle and uses it to call P3 (two-way transaction)
 - P3 calls P2 (via magic handle 0) (two-way transaction)
 - P2 calls P2 (via handle 1) (two-way transaction)

And then, if P2 does *NOT* accept the incoming transaction work, but
instead closes the binder fd, we get a crash.

Solve it by preventing the context manager from using ACQUIRE on ref 0.
There shouldn't be any legitimate reason for the context manager to do
that.

Additionally, print a warning if someone manages to find another way to
trigger a transaction-to-self bug in the future.

Cc: stable@vger.kernel.org
Fixes: 457b9a6f09f0 ("Staging: android: add binder driver")
Acked-by: Todd Kjos <tkjos@google.com>
Signed-off-by: Jann Horn <jannh@google.com>
---
fixed that broken binder_user_error() from the first version...
I sent v1 while I had a dirty tree containing the missing fix. whoops.

 drivers/android/binder.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index f50c5f182bb5..5b310eea9e52 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -2982,6 +2982,12 @@ static void binder_transaction(struct binder_proc *proc,
 			goto err_dead_binder;
 		}
 		e->to_node = target_node->debug_id;
+		if (WARN_ON(proc == target_proc)) {
+			return_error = BR_FAILED_REPLY;
+			return_error_param = -EINVAL;
+			return_error_line = __LINE__;
+			goto err_invalid_target_handle;
+		}
 		if (security_binder_transaction(proc->tsk,
 						target_proc->tsk) < 0) {
 			return_error = BR_FAILED_REPLY;
@@ -3635,10 +3641,17 @@ static int binder_thread_write(struct binder_proc *proc,
 				struct binder_node *ctx_mgr_node;
 				mutex_lock(&context->context_mgr_node_lock);
 				ctx_mgr_node = context->binder_context_mgr_node;
-				if (ctx_mgr_node)
+				if (ctx_mgr_node) {
+					if (ctx_mgr_node->proc == proc) {
+						binder_user_error("%d:%d context manager tried to acquire desc 0\n",
+								  proc->pid, thread->pid);
+						mutex_unlock(&context->context_mgr_node_lock);
+						return -EINVAL;
+					}
 					ret = binder_inc_ref_for_node(
 							proc, ctx_mgr_node,
 							strong, NULL, &rdata);
+				}
 				mutex_unlock(&context->context_mgr_node_lock);
 			}
 			if (ret)

base-commit: 2a89b99f580371b86ae9bafd6cbeccd3bfab524a
-- 
2.28.0.rc0.142.g3c755180ce-goog

