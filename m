Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82A62C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:07:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 54F782075A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:07:27 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="UEb5/483"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728620AbgFVUH0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:07:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728311AbgFVUHZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:07:25 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F415C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:07:25 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id m63so21228248ybc.13
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 13:07:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=It7WCF6NWrKCb1o5ESqK7iLOhdQgrtGmLe61alVmR2g=;
        b=UEb5/483PkOmcAISuyZiEKoIS2sTKiWdGS7v5XwnZPqL+4W/mlTtQ5dsTdsAyVnSqc
         iFYEyb8WoZeCD+2dF9umxv6lEs8j5/CMBNv8eFU2+67hQo90DV0H4s8MA2OaqoD/7KQA
         P7h/4EI0h7HaVREHrSPnj89Wvg9ONYLnKDlW3FFoAXVwEihCRnfqLic9KngVzI51Mp/7
         iz0ijx0jhB2GYI0T2yLdZR/orC2MKjj7MT+PdnyK83DfbOpiNVVrsl7204IHfyK22VZP
         sU3Cb//VqPvn/7GKibIY8vB23nWl5eKmVvB7sFFwlcUYyRi6niFGWMfvl9hgS3HldNOS
         JejA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=It7WCF6NWrKCb1o5ESqK7iLOhdQgrtGmLe61alVmR2g=;
        b=gKRHkzFyvIouANv47UNaobPhkxa1P4dXGljBfkFu1GhrA41OeK/sdAJ127Jgg4yYRx
         mOX3AhCsFWn1SUzIpEDL2XSxovY0YAirjM6JYeEO48tgZeBSIf9w0Tazx2367thBbk+X
         jKdVClPmLMEzlwD59nolbTIzmwrPGD5U/1EG7QV38Zi1aIrw/G/0E4iiZbnEdXlsJugS
         uMTq0nSeXN06gvt2TZq7KMby+2SFcd1qavaQE0CVU+I3j37PM68XZwzSTzGT++lxUU6v
         esHoXSJb+wxmiFKGhuy1ersfxqXG9pLYMfFG9dXhRtHJHsqOHMhz5qH7uRYszY/10Nzf
         UJHQ==
X-Gm-Message-State: AOAM530zPs8jRgY5e5cid3txqQgx05Y9mKrWPtdhATON7i1+slsUL4YP
        F+8z66YvDWKumqJ41n8ySjVtTRb+9A==
X-Google-Smtp-Source: ABdhPJx6ELeChahDdZ0u3OPPvd1qphCT9C4jSsP2Sv6Z0wKlHq8A1zfdhi/DqKl6nOvrNIZ8kLh9lOODXQ==
X-Received: by 2002:a25:400e:: with SMTP id n14mr27690222yba.424.1592856444249;
 Mon, 22 Jun 2020 13:07:24 -0700 (PDT)
Date:   Mon, 22 Jun 2020 13:07:15 -0700
Message-Id: <20200622200715.114382-1-tkjos@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.111.gc72c7da667-goog
Subject: [PATCH] binder: fix null deref of proc->context
From:   Todd Kjos <tkjos@google.com>
To:     tkjos@google.com, gregkh@linuxfoundation.org, christian@brauner.io,
        arve@android.com, devel@driverdev.osuosl.org,
        linux-kernel@vger.kernel.org, maco@google.com
Cc:     joel@joelfernandes.org, kernel-team@android.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The binder driver makes the assumption proc->context pointer is invariant after
initialization (as documented in the kerneldoc header for struct proc).
However, in commit f0fe2c0f050d ("binder: prevent UAF for binderfs devices II")
proc->context is set to NULL during binder_deferred_release().

Another proc was in the middle of setting up a transaction to the dying
process and crashed on a NULL pointer deref on "context" which is a local
set to &proc->context:

    new_ref->data.desc = (node == context->binder_context_mgr_node) ? 0 : 1;

Here's the stack:

[ 5237.855435] Call trace:
[ 5237.855441] binder_get_ref_for_node_olocked+0x100/0x2ec
[ 5237.855446] binder_inc_ref_for_node+0x140/0x280
[ 5237.855451] binder_translate_binder+0x1d0/0x388
[ 5237.855456] binder_transaction+0x2228/0x3730
[ 5237.855461] binder_thread_write+0x640/0x25bc
[ 5237.855466] binder_ioctl_write_read+0xb0/0x464
[ 5237.855471] binder_ioctl+0x30c/0x96c
[ 5237.855477] do_vfs_ioctl+0x3e0/0x700
[ 5237.855482] __arm64_sys_ioctl+0x78/0xa4
[ 5237.855488] el0_svc_common+0xb4/0x194
[ 5237.855493] el0_svc_handler+0x74/0x98
[ 5237.855497] el0_svc+0x8/0xc

The fix is to move the kfree of the binder_device to binder_free_proc()
so the binder_device is freed when we know there are no references
remaining on the binder_proc.

Fixes: f0fe2c0f050d ("binder: prevent UAF for binderfs devices II")
Signed-off-by: Todd Kjos <tkjos@google.com>
---
 drivers/android/binder.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/drivers/android/binder.c b/drivers/android/binder.c
index e47c8a4c83db..f50c5f182bb5 100644
--- a/drivers/android/binder.c
+++ b/drivers/android/binder.c
@@ -4686,8 +4686,15 @@ static struct binder_thread *binder_get_thread(struct binder_proc *proc)
 
 static void binder_free_proc(struct binder_proc *proc)
 {
+	struct binder_device *device;
+
 	BUG_ON(!list_empty(&proc->todo));
 	BUG_ON(!list_empty(&proc->delivered_death));
+	device = container_of(proc->context, struct binder_device, context);
+	if (refcount_dec_and_test(&device->ref)) {
+		kfree(proc->context->name);
+		kfree(device);
+	}
 	binder_alloc_deferred_release(&proc->alloc);
 	put_task_struct(proc->tsk);
 	binder_stats_deleted(BINDER_STAT_PROC);
@@ -5406,7 +5413,6 @@ static int binder_node_release(struct binder_node *node, int refs)
 static void binder_deferred_release(struct binder_proc *proc)
 {
 	struct binder_context *context = proc->context;
-	struct binder_device *device;
 	struct rb_node *n;
 	int threads, nodes, incoming_refs, outgoing_refs, active_transactions;
 
@@ -5423,12 +5429,6 @@ static void binder_deferred_release(struct binder_proc *proc)
 		context->binder_context_mgr_node = NULL;
 	}
 	mutex_unlock(&context->context_mgr_node_lock);
-	device = container_of(proc->context, struct binder_device, context);
-	if (refcount_dec_and_test(&device->ref)) {
-		kfree(context->name);
-		kfree(device);
-	}
-	proc->context = NULL;
 	binder_inner_proc_lock(proc);
 	/*
 	 * Make sure proc stays alive after we
-- 
2.27.0.111.gc72c7da667-goog

