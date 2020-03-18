Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B69F3C5ACD6
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:38:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 8B81120768
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:38:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RCdCYDq6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727280AbgCRQiQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 12:38:16 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:25069 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727281AbgCRQiO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 12:38:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584549493;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=1E3B0Yz5VXpRt1UuenEaP/bTgdad88wWSBx4HAVaGCs=;
        b=RCdCYDq6rgc7+SpW1tMA5Mm8HzuJ+4xqo06Momccu94zxs2ep1gh9vAhEGsvya4uyZBzBe
        +lCngcQdYvxrYPkt7Oiwt7pxxf/nyKyMIUIl4rk6f3anJzNcs9t8Dymli5ujzISGgScL35
        6I93M8NBDWqp8bSjyUDj0oQtGJ/Q2x8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-471-_7UF0PqhPBqDVPHO9OWzKg-1; Wed, 18 Mar 2020 12:38:11 -0400
X-MC-Unique: _7UF0PqhPBqDVPHO9OWzKg-1
Received: by mail-wm1-f70.google.com with SMTP id i24so1343622wml.1
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 09:38:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1E3B0Yz5VXpRt1UuenEaP/bTgdad88wWSBx4HAVaGCs=;
        b=pwm1MSAZL879qiddVf+97XdSD/fsKLGvMnlbg5K3GR441S91CiuZbu2aJTf9v7Bj1t
         5itIH+iMi+GN/7tcGp7zv6Wd0909ywv8xfKo+ZrVzGZTGvHv36CwerjRcu3y54sTLs6R
         MN1LZKNP9Ads9ypUUNYcLTpd/XUJRMbqglkSP/6poSZzlS21S6EV1MZvZ38xQca52xYO
         /kD4IW9uJmbK46Z46YLrnRdzGoBnlaQ7+3yh5KkDqLL2A/bsVfduiJhKgqMPY79rSnXZ
         tbHkyfK76FYMA601EMFs783LF+xr9ZtnywdcdFzeaWafveDCujbbdT4Rf5DCIfW64Xzw
         h76Q==
X-Gm-Message-State: ANhLgQ3rXwQE4zrJ3owNqf5QuryxDlIYG5EwT1COqeD1rQTrkT/msgLx
        htlLFru4HpDroWeKvUDKdH5wF878k1mNMn4EcFQ4Gk9sEPzvYb3ycFJUv7F32mcpRS6rq4fUnXT
        JRc+fzOHqmHku+7+PVk7iEM6x
X-Received: by 2002:a1c:ab07:: with SMTP id u7mr5800988wme.23.1584549490271;
        Wed, 18 Mar 2020 09:38:10 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvBH67l19GmOd+dDI63U07D1B3BV+JVxiTOrHvUGW1RXFZ5/syTtTZL4G1T7y0DmeS0RZUzdw==
X-Received: by 2002:a1c:ab07:: with SMTP id u7mr5800964wme.23.1584549490040;
        Wed, 18 Mar 2020 09:38:10 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id f207sm4797977wme.9.2020.03.18.09.38.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 09:38:09 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Michael S . Tsirkin" <mst@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Yan Zhao <yan.y.zhao@intel.com>, peterx@redhat.com,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v7 07/14] KVM: Don't allocate dirty bitmap if dirty ring is enabled
Date:   Wed, 18 Mar 2020 12:37:13 -0400
Message-Id: <20200318163720.93929-8-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200318163720.93929-1-peterx@redhat.com>
References: <20200318163720.93929-1-peterx@redhat.com>
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
index e770a5dd0c30..970025875abc 100644
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
index 9bcfb7109aec..455ac8d3840d 100644
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
index b289d3bddd5c..0040b8dfa7ac 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1291,7 +1291,7 @@ int __kvm_set_memory_region(struct kvm *kvm,
 	/* Allocate/free page dirty bitmap as needed */
 	if (!(new.flags & KVM_MEM_LOG_DIRTY_PAGES))
 		new.dirty_bitmap = NULL;
-	else if (!new.dirty_bitmap) {
+	else if (!new.dirty_bitmap && !kvm->dirty_ring_size) {
 		r = kvm_alloc_dirty_bitmap(&new);
 		if (r)
 			return r;
@@ -2578,7 +2578,7 @@ static void mark_page_dirty_in_slot(struct kvm *kvm,
 				    struct kvm_memory_slot *memslot,
 				    gfn_t gfn)
 {
-	if (memslot && memslot->dirty_bitmap) {
+	if (memslot && kvm_slot_dirty_track_enabled(memslot)) {
 		unsigned long rel_gfn = gfn - memslot->base_gfn;
 		u32 slot = (memslot->as_id << 16) | memslot->id;
 
-- 
2.24.1

