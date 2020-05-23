Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A96F9C433E4
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 22:57:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 82F7420885
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 22:57:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="XHT0QdRX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388262AbgEWW5b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 18:57:31 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:26078 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388209AbgEWW52 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 18:57:28 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590274647;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MlUVdjeJ0J1hQ9k5pkbQKVuK1AkzVVvG+iv/Zueckg0=;
        b=XHT0QdRXh91eB04cbreFU2hJ8zC6dzjVR/MyW3yPNUEWfAYXlhxLVZKnIL/xzvRk0Q2wrg
        5f/nMb/7ZQ6intDRO4+aF1pcoMZZ8O9a6LuDLMYZkeIHQrbnEuD9W1pG+z7d4sI9G6Wyld
        jMgEol/ZxvVS+y8Yrs3bEnX0olIgKgg=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-485-CQKPzCN-Pj6aoRT4m6fzCg-1; Sat, 23 May 2020 18:57:25 -0400
X-MC-Unique: CQKPzCN-Pj6aoRT4m6fzCg-1
Received: by mail-qt1-f199.google.com with SMTP id z29so15959049qtj.5
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 15:57:24 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MlUVdjeJ0J1hQ9k5pkbQKVuK1AkzVVvG+iv/Zueckg0=;
        b=nWGNRzUcdhK9KINl7RyXBXGeuOWetEpkV1L0Ri++3z3xK7QjCvgFqEOSJRX5oVOd8T
         0Z1jRtf7ql9YYRWi5nt0jLQJ8fEzPgwDdp6KOE/Pp/bRU/6A+75amPFgLP98Q1srtCIi
         cavvYhM+y2mmFYWljI8spa7MjTlWW7Kr062I/K/QtMVayRCpNald6RBFunZW+oc9QNN7
         G8TfUBUtkIgiXA2Tzr5i2u6MB1rmSYTagWesvjSJ5nJIpCzHFwQMUUT8PGzihkjqZvUA
         W0Ngw4Eg/wa0txj14h+SR2qSxeXnZw86vdWEyPcsNt2VJNb8GTFqAibkMeIAlrzcLrXm
         +8zw==
X-Gm-Message-State: AOAM531qXz9jbss+W2ymZ0rhedtJyPigi+vcCUo7mLR8F4oABgYNxhJR
        VDegfW4lCuu9tp75yor2+LUv/GtXlu5e3zQDwL0B53c2kGcVR4MYsaI9RALJzJe7ooW7KtsyVRM
        Wpz8LV35ZpLXeRGA3jrOTXrZh
X-Received: by 2002:a0c:b60c:: with SMTP id f12mr9814669qve.244.1590274644156;
        Sat, 23 May 2020 15:57:24 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwEpr2rTp0JHKP5YqM2SA8N//ah+ThOYj9WbkHvw7lOkC/5fdIL+wNw3pRJyi7DmAx3q/SzRA==
X-Received: by 2002:a0c:b60c:: with SMTP id f12mr9814661qve.244.1590274643903;
        Sat, 23 May 2020 15:57:23 -0700 (PDT)
Received: from xz-x1.hitronhub.home (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
        by smtp.gmail.com with ESMTPSA id w14sm11630979qtt.82.2020.05.23.15.57.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 15:57:22 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>, peterx@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: [PATCH v9 07/14] KVM: Don't allocate dirty bitmap if dirty ring is enabled
Date:   Sat, 23 May 2020 18:56:52 -0400
Message-Id: <20200523225659.1027044-8-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523225659.1027044-1-peterx@redhat.com>
References: <20200523225659.1027044-1-peterx@redhat.com>
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
 virt/kvm/kvm_main.c      | 4 ++--
 3 files changed, 9 insertions(+), 4 deletions(-)

diff --git a/arch/x86/kvm/mmu/mmu.c b/arch/x86/kvm/mmu/mmu.c
index 94d84a383b80..ebc86f661db3 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1276,8 +1276,8 @@ gfn_to_memslot_dirty_bitmap(struct kvm_vcpu *vcpu, gfn_t gfn,
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
index a7eaef494f45..5081c6e2ae06 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -351,6 +351,11 @@ struct kvm_memory_slot {
 	u16 as_id;
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
index 9639cf8d8c9c..ae7ba67eab63 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1294,7 +1294,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	/* Allocate/free page dirty bitmap as needed */
 	if (!(new.flags & KVM_MEM_LOG_DIRTY_PAGES))
 		new.dirty_bitmap = NULL;
-	else if (!new.dirty_bitmap) {
+	else if (!new.dirty_bitmap && !kvm->dirty_ring_size) {
 		r = kvm_alloc_dirty_bitmap(&new);
 		if (r)
 			return r;
@@ -2581,7 +2581,7 @@ static void mark_page_dirty_in_slot(struct kvm *kvm,
 				    struct kvm_memory_slot *memslot,
 				    gfn_t gfn)
 {
-	if (memslot && memslot->dirty_bitmap) {
+	if (memslot && kvm_slot_dirty_track_enabled(memslot)) {
 		unsigned long rel_gfn = gfn - memslot->base_gfn;
 		u32 slot = (memslot->as_id << 16) | memslot->id;
 
-- 
2.26.2

