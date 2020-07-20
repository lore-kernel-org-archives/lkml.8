Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F80C433E3
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:33:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D1E4B2070A
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 16:33:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="vglMCEkJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="WpXgsBkD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388933AbgGTQdF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Jul 2020 12:33:05 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:58808 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731799AbgGTP40 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jul 2020 11:56:26 -0400
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1595260584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0LvtODdt/qpdhh8rPzhryXa7h9i3Brijmjrucqb9JZE=;
        b=vglMCEkJnKDV9C9gl5yiBKv0rsKn11X9rca8Uhpd3/JzUjkB47eLDwg6mZl97/X2A2NMnG
        V3ZDjFK4/lRiCusV+cMPKqzQOtUdVfXa374NtTVhr4TC7kdylQPMhRZvfcx3ao+ZmoGmjM
        tSNqPKvU16oVkHkVxg7PsrRsKb0J4KJUB+4M2pX2shxzzI9kgesqHEMJOtaCcBzDZTTbCB
        BBazox5RJdIF/VstuK9W8fGJbuIjb23AHo1fhai95H8qNCsH5tCz0W4P6VbWOSbDLvvFpb
        J8D8lB47W1gTIkkdxD/OGSXo4kmGYVEqmxxstrwZexLx4wyuH3AO4JupskwSGA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1595260584;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=0LvtODdt/qpdhh8rPzhryXa7h9i3Brijmjrucqb9JZE=;
        b=WpXgsBkD0uNt1Rx2RbQ3QwKmY4xJgRuU8KSbTtQiQUGfnAxseItKzSI6FvDBIRrtttKqbN
        PUR+FecPEzFoL8Dw==
To:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        "Sebastian A. Siewior" <bigeasy@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        LKML <linux-kernel@vger.kernel.org>,
        "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        Daniel Vetter <daniel@ffwll.ch>
Subject: [PATCH v4 11/24] dma-buf: Remove custom seqcount lockdep class key
Date:   Mon, 20 Jul 2020 17:55:17 +0200
Message-Id: <20200720155530.1173732-12-a.darwish@linutronix.de>
In-Reply-To: <20200720155530.1173732-1-a.darwish@linutronix.de>
References: <20200519214547.352050-1-a.darwish@linutronix.de>
 <20200720155530.1173732-1-a.darwish@linutronix.de>
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

