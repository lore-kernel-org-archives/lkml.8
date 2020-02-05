Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ED633C3524B
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:58:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C13A62082E
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:58:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="M+RsxE+Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727982AbgBEC65 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 21:58:57 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:56311 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727789AbgBEC6z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 21:58:55 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580871534;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FDwDto3hXPczPquqfclgMLW72/UWKwUFYUker/I93cA=;
        b=M+RsxE+Z4uLJZjLH2HnMk4DRJKIbLQikBOlVFOS1ktwJ0Rumr+yVF0Bwr+p2Ozz1e2edR8
        YWcOTHnSaIr3gzDfCff+umydDiYGsxI3pqiIeoOp8wG1V9Lqa/qzdKbRcj3e9FXcAp/Bdm
        8IGxB+2ChCusvCmFV+2XDktI9W/TurA=
Received: from mail-qv1-f71.google.com (mail-qv1-f71.google.com
 [209.85.219.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-288-clFmEQwzNW-_rI6au_hCQw-1; Tue, 04 Feb 2020 21:58:52 -0500
X-MC-Unique: clFmEQwzNW-_rI6au_hCQw-1
Received: by mail-qv1-f71.google.com with SMTP id k2so599434qvu.22
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 18:58:52 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FDwDto3hXPczPquqfclgMLW72/UWKwUFYUker/I93cA=;
        b=oqUyqxtQVg+rFLV2ADgMqKeSBuPcBe1eYn3Mf7UAnNfmzlDPKCx5vTdjy2eaAC+q+Z
         MMpFdjliigo4Ej878yQQxFS+x/vcO9iHmhUdgkF2+TZPQdKhh0QodcWFzet7NSd5vcQ/
         tbZC+fhT10nmw6VV8UPsaO1fIFjYgKiLa0czYkGgF0AHPSiIRo3A8PiggrOAXgyRsvdC
         5Q3WHDE01goKksnnogj1NjCjRMAoRKFcf0cO0oFfQU6xSCsNSypJTzRIvyMRukVcua7g
         4HmRpFYGXi4HumRuKpzty4HxhBY4QZmHKQ1W0AvSH4VpsatT8Y7B/vcZbdvAmsLt9CQA
         4pZg==
X-Gm-Message-State: APjAAAXMVOVLQDH29bwbhiYdyhHWWwfYDLXN5WLCMI5WaV/v22ZEX+Pn
        Pza3A9JcFp9ip+8hWPOeOcflPdV61I6xkF0ac/CQhEq7HsiMkZVHjr9pCloSkqYSmhyYuecOdHI
        /xYu47Fnys7wY0YUFE7IO2nz7
X-Received: by 2002:ac8:1a19:: with SMTP id v25mr31897233qtj.146.1580871532265;
        Tue, 04 Feb 2020 18:58:52 -0800 (PST)
X-Google-Smtp-Source: APXvYqy668FfAXq+R1N+S7y8JoV5xEv9AZL3pJHQVt+dfDh0K4BFDgeoMXGuKkNpqPRLfsJVQKtMaw==
X-Received: by 2002:ac8:1a19:: with SMTP id v25mr31897220qtj.146.1580871532024;
        Tue, 04 Feb 2020 18:58:52 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id e64sm12961649qtd.45.2020.02.04.18.58.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 18:58:51 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinechin@redhat.com, sean.j.christopherson@intel.com,
        pbonzini@redhat.com, jasowang@redhat.com, yan.y.zhao@intel.com,
        mst@redhat.com, peterx@redhat.com, kevin.tian@intel.com,
        alex.williamson@redhat.com, dgilbert@redhat.com,
        vkuznets@redhat.com
Subject: [PATCH 07/14] KVM: Don't allocate dirty bitmap if dirty ring is enabled
Date:   Tue,  4 Feb 2020 21:58:35 -0500
Message-Id: <20200205025842.367575-4-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205025842.367575-1-peterx@redhat.com>
References: <20200205025105.367213-1-peterx@redhat.com>
 <20200205025842.367575-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because kvm dirty rings and kvm dirty log is used in an exclusive way,
Let's avoid creating the dirty_bitmap when kvm dirty ring is enabled.
At the meantime, since the dirty_bitmap will be conditionally created
now, we can't use it as a sign of "whether this memory slot enabled
dirty tracking".  Change users like that to check against the kvm
memory slot flags.

Note that there still can be chances where the kvm memory slot got its
dirty_bitmap allocated, _if_ the memory slots are created before
enabling of the dirty rings and at the same time with the dirty
tracking capability enabled, they'll still with the dirty_bitmap.
However it should not hurt much (e.g., the bitmaps will always be
freed if they are there), and the real users normally won't trigger
this because dirty bit tracking flag should in most cases only be
applied to kvm slots only before migration starts, that should be far
latter than kvm initializes (VM starts).

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/mmu/mmu.c   | 4 ++--
 include/linux/kvm_host.h | 5 +++++
 virt/kvm/kvm_main.c      | 5 +++--
 3 files changed, 10 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 92c250e26823..039d20043ca3 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1273,8 +1273,8 @@ gfn_to_memslot_dirty_bitmap(struct kvm_vcpu *vcpu, gfn_t gfn,
 	slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 	if (!slot || slot->flags & KVM_MEMSLOT_INVALID)
 		return NULL;
-	if (no_dirty_log && slot->dirty_bitmap)
-		return NULL;
+	if (no_dirty_log && kvm_slot_dirty_track_enabled(slot))
+		return false;
 
 	return slot;
 }
diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index e9d6e96a47be..a49e6846afe6 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -351,6 +351,11 @@ struct kvm_memory_slot {
 	u8 as_id;
 };
 
+static inline bool kvm_slot_dirty_track_enabled(struct kvm_memory_slot *slot)
+{
+	return slot->flags & KVM_MEM_LOG_DIRTY_PAGES;
+}
+
 static inline unsigned long kvm_dirty_bitmap_bytes(struct kvm_memory_slot *memslot)
 {
 	return ALIGN(memslot->npages, BITS_PER_LONG) / 8;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 5a6f83b7270f..72b45f491692 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1152,7 +1152,8 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	}
 
 	/* Allocate page dirty bitmap if needed */
-	if ((new.flags & KVM_MEM_LOG_DIRTY_PAGES) && !new.dirty_bitmap) {
+	if ((new.flags & KVM_MEM_LOG_DIRTY_PAGES) && !new.dirty_bitmap &&
+	    !kvm->dirty_ring_size) {
 		if (kvm_create_dirty_bitmap(&new) < 0)
 			goto out_free;
 	}
@@ -2348,7 +2349,7 @@ static void mark_page_dirty_in_slot(struct kvm *kvm,
 				    struct kvm_memory_slot *memslot,
 				    gfn_t gfn)
 {
-	if (memslot && memslot->dirty_bitmap) {
+	if (memslot && kvm_slot_dirty_track_enabled(memslot)) {
 		unsigned long rel_gfn = gfn - memslot->base_gfn;
 		u32 slot = (memslot->as_id << 16) | memslot->id;
 
-- 
2.24.1

