Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67BE2C10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:25:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32DDB24649
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 22:25:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Y6Pj9Wtq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727272AbgCIWZJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 18:25:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47649 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726838AbgCIWZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 18:25:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583792708;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=nyrDInEJang5FtswEWWF8Cqby5BmYpTki559+lPfEAA=;
        b=Y6Pj9WtqW1XpUzbZgXZimXQJi9/PQz3aVlEqiajYk0S2fY69ackhYYCwSRjC4usTBSfTTS
        UeSUOoA7IgCE1BCaUxKNcWUDvGX2m/tpGrpY8jLcOU2GolCrEBeeaN6A2dJKIG0tqZWUwq
        /xGfKwYJ4wbOnu4CW7HMAuTjW4nWRSI=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-113-UXZPBhB9NSiCsmF4EWhrrQ-1; Mon, 09 Mar 2020 18:25:07 -0400
X-MC-Unique: UXZPBhB9NSiCsmF4EWhrrQ-1
Received: by mail-qt1-f199.google.com with SMTP id k20so7809484qtm.11
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 15:25:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nyrDInEJang5FtswEWWF8Cqby5BmYpTki559+lPfEAA=;
        b=bJOAjcaoGKj8tktIgeLIQZOPGT+d3AyuB2kyXNaClqGxkRFy6rKpMKVE3YcmXUX/ei
         amDgoxvakG2rwBRf5v5/kns6cZKqkwhMCTYoaJ/RLZ8ZT1tHnHO+vtzkgEp0Vap5N2wE
         wpxatbnc6qysektZ6u1thQHRy8bKXDlXjhs1H2ga5K3cya9GcXQLjqLHI0g5vS2jmyj+
         L+Zlb0tqDHjtfDxIrWpxVCu1p1jV+Sh7c4OTA/El1ExWIp42ffYNzLfaAtkx1BuJ75Pk
         LkoiiGYeWaUXBHJ1qPqMpxw4pJ/nnYDTLY6x1OkHUGlZ1plx74ngQPjsgcY2/AqI1jD3
         ma4w==
X-Gm-Message-State: ANhLgQ3qWF4hUUmkXGBBYSq6rKSHRmT+NVq7NsO8nPAgRVhfQvIBitV+
        gEul+kehOrbT9hMMn4uaH2ZiUKbJTmziioneHsl02BXByCbWNiWsCK899hO21drfE5td2hzBT5O
        7pNi4JnDs986xEW+9tkfp/u9o
X-Received: by 2002:a05:6214:1583:: with SMTP id m3mr3723456qvw.215.1583792706050;
        Mon, 09 Mar 2020 15:25:06 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtjUAto5eTjA77zcu9I6ibufJ7MrPoPuXfurKB93iRAgbYocJhpSf9/yPvOuU1hl1tdvaQ0Rw==
X-Received: by 2002:a05:6214:1583:: with SMTP id m3mr3723431qvw.215.1583792705798;
        Mon, 09 Mar 2020 15:25:05 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id j193sm4815486qke.22.2020.03.09.15.25.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 15:25:05 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Peter Xu <peterx@redhat.com>, Yan Zhao <yan.y.zhao@intel.com>,
        Jason Wang <jasowang@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v6 07/14] KVM: Don't allocate dirty bitmap if dirty ring is enabled
Date:   Mon,  9 Mar 2020 18:25:03 -0400
Message-Id: <20200309222503.345450-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309214424.330363-1-peterx@redhat.com>
References: 
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
index f0993dec3b77..711ed191f663 100644
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
index e51a14d24619..1839d5c15a0f 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1100,7 +1100,8 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	}
 
 	/* Allocate page dirty bitmap if needed */
-	if ((new.flags & KVM_MEM_LOG_DIRTY_PAGES) && !new.dirty_bitmap) {
+	if ((new.flags & KVM_MEM_LOG_DIRTY_PAGES) && !new.dirty_bitmap &&
+	    !kvm->dirty_ring_size) {
 		if (kvm_create_dirty_bitmap(&new) < 0)
 			goto out_free;
 	}
@@ -2376,7 +2377,7 @@ static void mark_page_dirty_in_slot(struct kvm *kvm,
 				    struct kvm_memory_slot *memslot,
 				    gfn_t gfn)
 {
-	if (memslot && memslot->dirty_bitmap) {
+	if (memslot && kvm_slot_dirty_track_enabled(memslot)) {
 		unsigned long rel_gfn = gfn - memslot->base_gfn;
 		u32 slot = (memslot->as_id << 16) | memslot->id;
 
-- 
2.24.1

