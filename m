Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9701FC3F2CE
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6EA3220838
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MXaQqons"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388366AbgCDRuU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:50:20 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:39460 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388329AbgCDRuS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:50:18 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583344216;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aPhWJqv+4wzEiT3LFbcYSbxVKlkBrz5Pq1CzcIRJ0kE=;
        b=MXaQqonsUaaSlAMXEwGYIDT+hkq9DtcNghaWKTe1XD0ZEBi7cZKe7JfaypilTsoqXwr8Aq
        JqujCx8afULXLQfem17Ni0tHtrVTtu8BsUjz7gxQbPt/xASV7Y2D9ImUNNu3FdR5S73rw+
        b3JOfdy2sMprNCumjX+fCU4hYpUdZHg=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-370-sjzxRyewPQuN3NuC0AeIEA-1; Wed, 04 Mar 2020 12:50:15 -0500
X-MC-Unique: sjzxRyewPQuN3NuC0AeIEA-1
Received: by mail-qv1-f69.google.com with SMTP id d7so1427096qvq.12
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:50:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aPhWJqv+4wzEiT3LFbcYSbxVKlkBrz5Pq1CzcIRJ0kE=;
        b=A+U238/x80uSRDMFlUtepifkUSeM07q5CCjTUQXx+D1pfQyOwTfGZpLi54BgAgFfYE
         ro0OStlR45Uu45/JTaykHoqOmMyqFbAyqbgjk9EmzebCp1cugaiKTlNi9MaV3iZ+gr8m
         aelVnieaD6QLovmA82byl+8griZX2VRmRGb901FlqtMp31xVFFNiUCR2fS8WQ2oTHl+S
         hPqM6+wxBv36+GvQalvKubL/hhQpgy6aNDA/wBJEHdFkqnn0o2eUQi+ghjzwFGzSawX6
         3WCt+OyUPEiot1ndtAHIazidKeVVYY/XiagbLzDDWlDHIXN03mCmHyo03LSQHTbaXOA0
         krVQ==
X-Gm-Message-State: ANhLgQ18sZBY2R21JHX+GbbjIUGgI5aem2N+PWxjj4/ozt1YQCXcs3zK
        4ulgoa4gAHagCFYyQHZfybFukaTKhzkB3LiRh3cZlw3gbDkMBIAiN66Sne8qj9qtxDs+Bz8p77N
        pFnLWUteuXeCcnJXrMmqM5dal
X-Received: by 2002:a0c:c389:: with SMTP id o9mr3138124qvi.232.1583344214248;
        Wed, 04 Mar 2020 09:50:14 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtq/beW3jj6OOypWe1gnWlD8BohLtxbBMiKHW9tcNSjrLXt9y0PqCqKQBMSsDlWebjpAVUrBQ==
X-Received: by 2002:a0c:c389:: with SMTP id o9mr3138100qvi.232.1583344213957;
        Wed, 04 Mar 2020 09:50:13 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j17sm5252341qki.123.2020.03.04.09.50.12
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:50:13 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Yan Zhao <yan.y.zhao@intel.com>, peterx@redhat.com,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>
Subject: [PATCH v5 07/14] KVM: Don't allocate dirty bitmap if dirty ring is enabled
Date:   Wed,  4 Mar 2020 12:49:40 -0500
Message-Id: <20200304174947.69595-8-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200304174947.69595-1-peterx@redhat.com>
References: <20200304174947.69595-1-peterx@redhat.com>
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
index 0147f20f31f9..d2c6bd27053f 100644
--- a/arch/x86/kvm/mmu/mmu.c
+++ b/arch/x86/kvm/mmu/mmu.c
@@ -1284,8 +1284,8 @@ gfn_to_memslot_dirty_bitmap(struct kvm_vcpu *vcpu, gfn_t gfn,
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
index 1d887cce323b..4253cc5665c4 100644
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
index 72dfb84a08a4..00e09a0c013f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1153,7 +1153,8 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	}
 
 	/* Allocate page dirty bitmap if needed */
-	if ((new.flags & KVM_MEM_LOG_DIRTY_PAGES) && !new.dirty_bitmap) {
+	if ((new.flags & KVM_MEM_LOG_DIRTY_PAGES) && !new.dirty_bitmap &&
+	    !kvm->dirty_ring_size) {
 		if (kvm_create_dirty_bitmap(&new) < 0)
 			goto out_free;
 	}
@@ -2429,7 +2430,7 @@ static void mark_page_dirty_in_slot(struct kvm *kvm,
 				    struct kvm_memory_slot *memslot,
 				    gfn_t gfn)
 {
-	if (memslot && memslot->dirty_bitmap) {
+	if (memslot && kvm_slot_dirty_track_enabled(memslot)) {
 		unsigned long rel_gfn = gfn - memslot->base_gfn;
 		u32 slot = (memslot->as_id << 16) | memslot->id;
 
-- 
2.24.1

