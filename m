Return-Path: <SRS0=mvbx=AL=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B6553C433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:45:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9479620672
	for <linux-kernel@archiver.kernel.org>; Tue, 30 Jun 2020 05:45:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="ieapcwO9";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="EACQwdMu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729850AbgF3Fpc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 30 Jun 2020 01:45:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729615AbgF3Fp3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Jun 2020 01:45:29 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72068C061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 22:45:29 -0700 (PDT)
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1593495925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0LvtODdt/qpdhh8rPzhryXa7h9i3Brijmjrucqb9JZE=;
        b=ieapcwO9vL9rn9zROuyYxUPIJUiRC6AjkM7xmqQebae80orrHUFdbI8WS6Uh4hieCsDSTz
        gTFYKAThZZbPkFld1x/495ZO4J6TbJjFrM4RQtw8IBphmYUA5P59pcZL2PCo3kdMCb9Jwd
        zJq4ejF6DJ22Q6YuAnruBK+a0DrYgzl/9z1b2vpFbg9K/Vnfs8qu+z7ueINmkbj3xmAYz/
        SGl7U0jR53Useq/1f5Qw3o2FhiaRk6bSY6bXtumtsC0lCsDRpmP8ojvgNuSN94weQHLD7V
        z5G0a2Nc1x5lBW5SAZKhRcWpXbroZDMnu0OlP/3m4bAAaAsrWQCcEciLWM/wQA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1593495925;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0LvtODdt/qpdhh8rPzhryXa7h9i3Brijmjrucqb9JZE=;
        b=EACQwdMuBBvXQvar78kldgLcsIwIwnqUulR+VSBpsEYu0AiFsbeiBA1LdxldGUP/k8sE0l
        h6TUfcFB0yEdVhAg==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>,
        David Airlie <airlied@linux.ie>,
        dri-devel@lists.freedesktop.org
Subject: [PATCH v3 07/20] dma-buf: Remove custom seqcount lockdep class key
Date:   Tue, 30 Jun 2020 07:44:39 +0200
Message-Id: <20200630054452.3675847-8-a.darwish@linutronix.de>
In-Reply-To: <20200630054452.3675847-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200630054452.3675847-1-a.darwish@linutronix.de>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Commit 3c3b177a9369 ("reservation: add support for read-only access
using rcu") introduced a sequence counter to manage updates to
reservations. Back then, the reservation object initializer
reservation_object_init() was always inlined.

Having the sequence counter initialization inlined meant that each of
the call sites would have a different lockdep class key, which would've
broken lockdep's deadlock detection. The aforementioned commit thus
introduced, and exported, a custom seqcount lockdep class key and name.

The commit 8735f16803f00 ("dma-buf: cleanup reservation_object_init...")
transformed the reservation object initializer to a normal non-inlined C
function. seqcount_init(), which automatically defines the seqcount
lockdep class key and must be called non-inlined, can now be safely used.

Remove the seqcount custom lockdep class key, name, and export. Use
seqcount_init() inside the dma reservation object initializer.

Signed-off-by: Ahmed S. Darwish <a.darwish@linutronix.de>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
---
 drivers/dma-buf/dma-resv.c | 9 +--------
 include/linux/dma-resv.h   | 2 --
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index b45f8514dc82..15efa0c2dacb 100644
--- a/drivers/dma-buf/dma-resv.c
+++ b/drivers/dma-buf/dma-resv.c
@@ -51,12 +51,6 @@
 DEFINE_WD_CLASS(reservation_ww_class);
 EXPORT_SYMBOL(reservation_ww_class);
 
-struct lock_class_key reservation_seqcount_class;
-EXPORT_SYMBOL(reservation_seqcount_class);
-
-const char reservation_seqcount_string[] = "reservation_seqcount";
-EXPORT_SYMBOL(reservation_seqcount_string);
-
 /**
  * dma_resv_list_alloc - allocate fence list
  * @shared_max: number of fences we need space for
@@ -135,9 +129,8 @@ subsys_initcall(dma_resv_lockdep);
 void dma_resv_init(struct dma_resv *obj)
 {
 	ww_mutex_init(&obj->lock, &reservation_ww_class);
+	seqcount_init(&obj->seq);
 
-	__seqcount_init(&obj->seq, reservation_seqcount_string,
-			&reservation_seqcount_class);
 	RCU_INIT_POINTER(obj->fence, NULL);
 	RCU_INIT_POINTER(obj->fence_excl, NULL);
 }
diff --git a/include/linux/dma-resv.h b/include/linux/dma-resv.h
index ee50d10f052b..a6538ae7d93f 100644
--- a/include/linux/dma-resv.h
+++ b/include/linux/dma-resv.h
@@ -46,8 +46,6 @@
 #include <linux/rcupdate.h>
 
 extern struct ww_class reservation_ww_class;
-extern struct lock_class_key reservation_seqcount_class;
-extern const char reservation_seqcount_string[];
 
 /**
  * struct dma_resv_list - a list of shared fences
-- 
2.20.1

