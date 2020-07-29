Return-Path: <SRS0=g5yc=BI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85869C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:34:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B111207E8
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jul 2020 14:34:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="clhY5Xfs";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Fj9eLbBn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727983AbgG2Oef (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jul 2020 10:34:35 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:42998 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727022AbgG2Odi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jul 2020 10:33:38 -0400
Date:   Wed, 29 Jul 2020 14:33:35 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1596033216;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i3kZYEXD09ZkAvbgWwq9AHUVj6gmkSIz2Tqokc9cvaQ=;
        b=clhY5XfsMV2DtOM02605cuD2eamuKR1z/v3VnoYsVVmT/VTRvHJmBSgpo2Ca+NIVDiTj9n
        UzRiIIEya/8CBHVms/RG6covjfwJ7dLpzbJI3aQtrp88IarS+W5yVOWqg7tilZc7dAYm/O
        D53B5fglxXNF/1CoF2Bb2nY9tgKYWZ4p4cIGoLc2/32HLPB8DyDvUBOXVUsxpNLKQO/Gc4
        jsyUDSVmMKTtRk6qLGib/UBEu3pvs+vDE3UyeQyv9bbcLUTgH7tmGWt/7+a5rFvwpQLZ4k
        x9M4b1cKwJWHXyZaZYmYG49kx5AfF5Moz4qA9EJhHlw/KjzMQS0/VLkuo4i3Nw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1596033216;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=i3kZYEXD09ZkAvbgWwq9AHUVj6gmkSIz2Tqokc9cvaQ=;
        b=Fj9eLbBnf9J+CHn2EvM1lsYxHMbweFL50TKjY4tZYt21K4cZ+kyqQpiR8AXOKuonDibkjb
        EprNpcAKPMvWFHCQ==
From:   "tip-bot2 for Ahmed S. Darwish" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: locking/core] dma-buf: Remove custom seqcount lockdep class key
Cc:     "Ahmed S. Darwish" <a.darwish@linutronix.de>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Daniel Vetter <daniel.vetter@ffwll.ch>, x86 <x86@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200720155530.1173732-12-a.darwish@linutronix.de>
References: <20200720155530.1173732-12-a.darwish@linutronix.de>
MIME-Version: 1.0
Message-ID: <159603321587.4006.6439425506446476952.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the locking/core branch of tip:

Commit-ID:     318ce71f3e3ae4108c1665f3860afa8a2a4c9f02
Gitweb:        https://git.kernel.org/tip/318ce71f3e3ae4108c1665f3860afa8a2a4c9f02
Author:        Ahmed S. Darwish <a.darwish@linutronix.de>
AuthorDate:    Mon, 20 Jul 2020 17:55:17 +02:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Wed, 29 Jul 2020 16:14:25 +02:00

dma-buf: Remove custom seqcount lockdep class key

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
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>
Link: https://lkml.kernel.org/r/20200720155530.1173732-12-a.darwish@linutronix.de
---
 drivers/dma-buf/dma-resv.c |  9 +--------
 include/linux/dma-resv.h   |  2 --
 2 files changed, 1 insertion(+), 10 deletions(-)

diff --git a/drivers/dma-buf/dma-resv.c b/drivers/dma-buf/dma-resv.c
index b45f851..15efa0c 100644
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
index ee50d10..a6538ae 100644
--- a/include/linux/dma-resv.h
+++ b/include/linux/dma-resv.h
@@ -46,8 +46,6 @@
 #include <linux/rcupdate.h>
 
 extern struct ww_class reservation_ww_class;
-extern struct lock_class_key reservation_seqcount_class;
-extern const char reservation_seqcount_string[];
 
 /**
  * struct dma_resv_list - a list of shared fences
