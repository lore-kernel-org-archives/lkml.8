Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.5 required=3.0 tests=BAYES_00,
	DKIM_ADSP_CUSTOM_MED,DKIM_INVALID,DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5501C10DAA
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:35:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8375221D7F
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 02:35:29 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=google.com header.i=@google.com header.b="BOG+kNGE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730807AbgIJCfW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 9 Sep 2020 22:35:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57218 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730619AbgIJCcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Sep 2020 22:32:31 -0400
Received: from mail-pj1-x1049.google.com (mail-pj1-x1049.google.com [IPv6:2607:f8b0:4864:20::1049])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7957FC061386
        for <linux-kernel@vger.kernel.org>; Wed,  9 Sep 2020 16:44:37 -0700 (PDT)
Received: by mail-pj1-x1049.google.com with SMTP id fy7so2705608pjb.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Sep 2020 16:44:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=sender:date:in-reply-to:message-id:mime-version:references:subject
         :from:to:cc;
        bh=ebS6PiGWixaTBhYeaEc/zhiWarm78MJMQVZ5bZI+E3I=;
        b=BOG+kNGESKRaoSgVqWO2gB6H+qQyuA+/z1t1jG8ciNt94j4+5sMLPcpgQFoke0UJZI
         x801tPFdvaDo94tUeXboGCfKL++3yiTEg0yCJZhvbdSlfaweLFIylfFYFX+J5dVzjE2w
         eXjccl7NF4fgBv56mggpioFS9yeI1dMYxW4a1BkDOGhkXKeKTEPnbeJqeFTTfL0kdzr/
         FdV1mAIDvAJEjQYZy0zEx+/lalYwev3E6o3GTUExEmElGm1t8OLpJMBu5+/w4yWr6S0J
         HtYThjAfEIw6/JqR4w1CqhHrKiUbYcniYXlXCKLqUWMK06zD7tNG2IdfzPmqQXprCTYn
         xAsQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:in-reply-to:message-id:mime-version
         :references:subject:from:to:cc;
        bh=ebS6PiGWixaTBhYeaEc/zhiWarm78MJMQVZ5bZI+E3I=;
        b=cJ2etumafWDflUKDr32lUhCE+1GuCvECUuDUeyfbTxdTcRDN89mmpG93OmjLRlrusX
         s7QL3T76ZN2tTrchOfL/m7tiFfd29qPOkM06DIuDVKZ+N6JzoBNI/CpPrJRVDo0DWXYd
         NZC5fNSc3KtrqaZif6gHiFc9jWmovdglskVUZqlshnag4HhbHD52xSAbw+b2LXGYL+cj
         nierTm5zt2LDX1Qx8EPKsyyEmhe/0xmfHO/ybGKWrnEmDfT4Yz5ePGlPrQNVroTzMvGV
         7ZYRFjlQzjAg4z2gjtKHc6TRq9tnkTorANTsxbawWeWUBcUFwMkIdon5gkGEB/rNg0AP
         tH2w==
X-Gm-Message-State: AOAM531EOGR39tqhYvhs1aR9h0RggM/16yOuafnNQJZ8D+Ee8SFLmgvU
        eAXmReO+Vhg2DZ/foWWUswRe542iXKA=
X-Google-Smtp-Source: ABdhPJyvq63o4Wpeo+ZPZJ2bBhb/p13PzGAtNwmcUOtqEpVa/QtHf09RXOxv8op6je00ssBQbZ5Cej9m9nQ=
X-Received: from satyaprateek.c.googlers.com ([fda3:e722:ac3:10:24:72f4:c0a8:2d8e])
 (user=satyat job=sendgmr) by 2002:a17:90b:15c6:: with SMTP id
 lh6mr245816pjb.0.1599695070812; Wed, 09 Sep 2020 16:44:30 -0700 (PDT)
Date:   Wed,  9 Sep 2020 23:44:20 +0000
In-Reply-To: <20200909234422.76194-1-satyat@google.com>
Message-Id: <20200909234422.76194-2-satyat@google.com>
Mime-Version: 1.0
References: <20200909234422.76194-1-satyat@google.com>
X-Mailer: git-send-email 2.28.0.526.ge36021eeef-goog
Subject: [PATCH 1/3] block: keyslot-manager: Introduce passthrough keyslot manager
From:   Satya Tangirala <satyat@google.com>
To:     linux-block@vger.kernel.org, linux-kernel@vger.kernel.org,
        dm-devel@redhat.com
Cc:     Jens Axboe <axboe@kernel.dk>, Alasdair Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@redhat.com>,
        Eric Biggers <ebiggers@google.com>,
        Satya Tangirala <satyat@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The device mapper may map over devices that have inline encryption
capabilities, and to make use of those capabilities, the DM device must
itself advertise those inline encryption capabilities. One way to do this
would be to have the DM device set up a keyslot manager with a
"sufficiently large" number of keyslots, but that would use a lot of
memory. Also, the DM device itself has no "keyslots", and it doesn't make
much sense to talk about "programming a key into a DM device's keyslot
manager", so all that extra memory used to represent those keyslots is just
wasted. All a DM device really needs to be able to do is advertise the
crypto capabilities of the underlying devices in a coherent manner and
expose a way to evict keys from the underlying devices.

There are also devices with inline encryption hardware that do not
have a limited number of keyslots. One can send a raw encryption key along
with a bio to these devices (as opposed to typical inline encryption
hardware that require users to first program a raw encryption key into a
keyslot, and send the index of that keyslot along with the bio). These
devices also only need the same things from the keyslot manager that DM
devices need - a way to advertise crypto capabilities and potentially a way
to expose a function to evict keys from hardware.

So we introduce a "passthrough" keyslot manager that provides a way to
represent a keyslot manager that doesn't have just a limited number of
keyslots, and for which do not require keys to be programmed into keyslots.
DM devices can set up a passthrough keyslot manager in their request
queues, and advertise appropriate crypto capabilities based on those of the
underlying devices. Blk-crypto does not attempt to program keys into any
keyslots in the passthrough keyslot manager. Instead, if/when the bio is
resubmitted to the underlying device, blk-crypto will try to program the
key into the underlying device's keyslot manager.

Signed-off-by: Satya Tangirala <satyat@google.com>
---
 block/keyslot-manager.c         | 41 +++++++++++++++++++++++++++++++++
 include/linux/keyslot-manager.h |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/block/keyslot-manager.c b/block/keyslot-manager.c
index 35abcb1ec051..60ac406d54b9 100644
--- a/block/keyslot-manager.c
+++ b/block/keyslot-manager.c
@@ -62,6 +62,11 @@ static inline void blk_ksm_hw_exit(struct blk_keyslot_manager *ksm)
 		pm_runtime_put_sync(ksm->dev);
 }
 
+static inline bool blk_ksm_is_passthrough(struct blk_keyslot_manager *ksm)
+{
+	return ksm->num_slots == 0;
+}
+
 /**
  * blk_ksm_init() - Initialize a keyslot manager
  * @ksm: The keyslot_manager to initialize.
@@ -198,6 +203,10 @@ blk_status_t blk_ksm_get_slot_for_key(struct blk_keyslot_manager *ksm,
 	int err;
 
 	*slot_ptr = NULL;
+
+	if (blk_ksm_is_passthrough(ksm))
+		return BLK_STS_OK;
+
 	down_read(&ksm->lock);
 	slot = blk_ksm_find_and_grab_keyslot(ksm, key);
 	up_read(&ksm->lock);
@@ -318,6 +327,16 @@ int blk_ksm_evict_key(struct blk_keyslot_manager *ksm,
 	struct blk_ksm_keyslot *slot;
 	int err = 0;
 
+	if (blk_ksm_is_passthrough(ksm)) {
+		if (ksm->ksm_ll_ops.keyslot_evict) {
+			blk_ksm_hw_enter(ksm);
+			err = ksm->ksm_ll_ops.keyslot_evict(ksm, key, -1);
+			blk_ksm_hw_exit(ksm);
+			return err;
+		}
+		return 0;
+	}
+
 	blk_ksm_hw_enter(ksm);
 	slot = blk_ksm_find_keyslot(ksm, key);
 	if (!slot)
@@ -353,6 +372,9 @@ void blk_ksm_reprogram_all_keys(struct blk_keyslot_manager *ksm)
 {
 	unsigned int slot;
 
+	if (WARN_ON(blk_ksm_is_passthrough(ksm)))
+		return;
+
 	/* This is for device initialization, so don't resume the device */
 	down_write(&ksm->lock);
 	for (slot = 0; slot < ksm->num_slots; slot++) {
@@ -394,3 +416,22 @@ void blk_ksm_unregister(struct request_queue *q)
 {
 	q->ksm = NULL;
 }
+
+/**
+ * blk_ksm_init_passthrough() - Init a passthrough keyslot manager
+ * @ksm: The keyslot manager to init
+ *
+ * Initialize a passthrough keyslot manager.
+ * Called by e.g. storage drivers to set up a keyslot manager in their
+ * request_queue, when the storage driver wants to manage its keys by itself.
+ * This is useful for inline encryption hardware that don't have a small fixed
+ * number of keyslots, and for layered devices.
+ *
+ * See blk_ksm_init() for more details about the parameters.
+ */
+void blk_ksm_init_passthrough(struct blk_keyslot_manager *ksm)
+{
+	memset(ksm, 0, sizeof(*ksm));
+	init_rwsem(&ksm->lock);
+}
+EXPORT_SYMBOL_GPL(blk_ksm_init_passthrough);
diff --git a/include/linux/keyslot-manager.h b/include/linux/keyslot-manager.h
index 18f3f5346843..323e15dd6fa7 100644
--- a/include/linux/keyslot-manager.h
+++ b/include/linux/keyslot-manager.h
@@ -103,4 +103,6 @@ void blk_ksm_reprogram_all_keys(struct blk_keyslot_manager *ksm);
 
 void blk_ksm_destroy(struct blk_keyslot_manager *ksm);
 
+void blk_ksm_init_passthrough(struct blk_keyslot_manager *ksm);
+
 #endif /* __LINUX_KEYSLOT_MANAGER_H */
-- 
2.28.0.618.gf4bc123cb7-goog

