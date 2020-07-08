Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1A9EC433E1
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:35:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C05AF206E9
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:35:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ei9nC5DI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726600AbgGHTfm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 15:35:42 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:44054 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726750AbgGHTeV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 15:34:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594236859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=yvZK9uv5QyXXzmNMfX41d3B1M6YDkKUtugCxsG8LxZo=;
        b=ei9nC5DIqGe8fuo85K1wAnMWAvX6Eney2vOMsQIdPekztexEAXpGXp6/5v2xGJP+GC6K6w
        YvUrz+xOz5EXbC8k8ZtGWbO4Z+whfsw4QUbVZadrClchyGGzWKR6Xn+PMw3HbbkOXEqDEv
        UftvDa4HGEeJaz4X3oXWZPko1ecUc2s=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-1ud-al1RNEKvr6WVvYGWOg-1; Wed, 08 Jul 2020 15:34:18 -0400
X-MC-Unique: 1ud-al1RNEKvr6WVvYGWOg-1
Received: by mail-qv1-f69.google.com with SMTP id j4so29934885qvt.20
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 12:34:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=yvZK9uv5QyXXzmNMfX41d3B1M6YDkKUtugCxsG8LxZo=;
        b=d7dYE42AqpdGnRMefaJpBzKn3d9c6qkf9MUgFzbwh8+veeEkEIuUkNi+saBHMPcz41
         VC7JYAb1KXAJ2pH9Rr63tsIjO7+nDsUe67QEkCtgKtK2cburugNXHF1hRm4DlIYQB2gp
         qkYGVaQS0T2knao02IlV3GeGMuv+ckrZTpj0PjEzILg8CJzjOavQP6hYcmibtSpzS2Ly
         6q5kMq31oZTOX9uOWS5xS/rTfYiwyGUk2EaK7QR3AHwriw0paGPqT4fq32dEhO7bXU4r
         j4OhU4QIC43Ry94YAMRvjhIXt4P3hMZiLgB1N73Qm+9WZLX4yjEZLHQh/UgqI2GhkT+y
         KiDQ==
X-Gm-Message-State: AOAM533nDHMCu4W+KnNhlIJ0arpf8EH5QDm7HN00XQ1aCLkceGlzNe+0
        91Zl2NB8+h8x51nz15Fuy3d7KGjqPrQm/RJrz3eDVlqlNBJSPwgVMWrGc2WKR6ci3D372jSeBxe
        GrafrDacY2e4+gYxT4t4892m5
X-Received: by 2002:a37:4d8:: with SMTP id 207mr58825719qke.298.1594236857566;
        Wed, 08 Jul 2020 12:34:17 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzNobPOf4+HEKQGLQyEitv4TsWw+1KwTEFMraibWFlA555Vy/tp5ZnJpYjBgfiaclNucSffHg==
X-Received: by 2002:a37:4d8:: with SMTP id 207mr58825697qke.298.1594236857266;
        Wed, 08 Jul 2020 12:34:17 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c8:6f::1f4f])
        by smtp.gmail.com with ESMTPSA id f18sm664884qtc.28.2020.07.08.12.34.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jul 2020 12:34:16 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     peterx@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: [PATCH v11 03/13] KVM: Pass in kvm pointer into mark_page_dirty_in_slot()
Date:   Wed,  8 Jul 2020 15:33:58 -0400
Message-Id: <20200708193408.242909-4-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200708193408.242909-1-peterx@redhat.com>
References: <20200708193408.242909-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The context will be needed to implement the kvm dirty ring.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 virt/kvm/kvm_main.c | 33 +++++++++++++++++++--------------
 1 file changed, 19 insertions(+), 14 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 62b7d537e179..32ff377dd019 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -143,7 +143,9 @@ static void hardware_disable_all(void);
 
 static void kvm_io_bus_destroy(struct kvm_io_bus *bus);
 
-static void mark_page_dirty_in_slot(struct kvm_memory_slot *memslot, gfn_t gfn);
+static void mark_page_dirty_in_slot(struct kvm *kvm,
+				    struct kvm_memory_slot *memslot,
+				    gfn_t gfn);
 
 __visible bool kvm_rebooting;
 EXPORT_SYMBOL_GPL(kvm_rebooting);
@@ -2134,7 +2136,8 @@ int kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map)
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_map);
 
-static void __kvm_unmap_gfn(struct kvm_memory_slot *memslot,
+static void __kvm_unmap_gfn(struct kvm *kvm,
+			struct kvm_memory_slot *memslot,
 			struct kvm_host_map *map,
 			struct gfn_to_pfn_cache *cache,
 			bool dirty, bool atomic)
@@ -2159,7 +2162,7 @@ static void __kvm_unmap_gfn(struct kvm_memory_slot *memslot,
 #endif
 
 	if (dirty)
-		mark_page_dirty_in_slot(memslot, map->gfn);
+		mark_page_dirty_in_slot(kvm, memslot, map->gfn);
 
 	if (cache)
 		cache->dirty |= dirty;
@@ -2173,7 +2176,7 @@ static void __kvm_unmap_gfn(struct kvm_memory_slot *memslot,
 int kvm_unmap_gfn(struct kvm_vcpu *vcpu, struct kvm_host_map *map, 
 		  struct gfn_to_pfn_cache *cache, bool dirty, bool atomic)
 {
-	__kvm_unmap_gfn(gfn_to_memslot(vcpu->kvm, map->gfn), map,
+	__kvm_unmap_gfn(vcpu->kvm, gfn_to_memslot(vcpu->kvm, map->gfn), map,
 			cache, dirty, atomic);
 	return 0;
 }
@@ -2181,8 +2184,8 @@ EXPORT_SYMBOL_GPL(kvm_unmap_gfn);
 
 void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct kvm_host_map *map, bool dirty)
 {
-	__kvm_unmap_gfn(kvm_vcpu_gfn_to_memslot(vcpu, map->gfn), map, NULL,
-			dirty, false);
+	__kvm_unmap_gfn(vcpu->kvm, kvm_vcpu_gfn_to_memslot(vcpu, map->gfn),
+			map, NULL, dirty, false);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_unmap);
 
@@ -2356,7 +2359,8 @@ int kvm_vcpu_read_guest_atomic(struct kvm_vcpu *vcpu, gpa_t gpa,
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_read_guest_atomic);
 
-static int __kvm_write_guest_page(struct kvm_memory_slot *memslot, gfn_t gfn,
+static int __kvm_write_guest_page(struct kvm *kvm,
+				  struct kvm_memory_slot *memslot, gfn_t gfn,
 			          const void *data, int offset, int len)
 {
 	int r;
@@ -2368,7 +2372,7 @@ static int __kvm_write_guest_page(struct kvm_memory_slot *memslot, gfn_t gfn,
 	r = __copy_to_user((void __user *)addr + offset, data, len);
 	if (r)
 		return -EFAULT;
-	mark_page_dirty_in_slot(memslot, gfn);
+	mark_page_dirty_in_slot(kvm, memslot, gfn);
 	return 0;
 }
 
@@ -2377,7 +2381,7 @@ int kvm_write_guest_page(struct kvm *kvm, gfn_t gfn,
 {
 	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
 
-	return __kvm_write_guest_page(slot, gfn, data, offset, len);
+	return __kvm_write_guest_page(kvm, slot, gfn, data, offset, len);
 }
 EXPORT_SYMBOL_GPL(kvm_write_guest_page);
 
@@ -2386,7 +2390,7 @@ int kvm_vcpu_write_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn,
 {
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 
-	return __kvm_write_guest_page(slot, gfn, data, offset, len);
+	return __kvm_write_guest_page(vcpu->kvm, slot, gfn, data, offset, len);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_write_guest_page);
 
@@ -2505,7 +2509,7 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	r = __copy_to_user((void __user *)ghc->hva + offset, data, len);
 	if (r)
 		return -EFAULT;
-	mark_page_dirty_in_slot(ghc->memslot, gpa >> PAGE_SHIFT);
+	mark_page_dirty_in_slot(kvm, ghc->memslot, gpa >> PAGE_SHIFT);
 
 	return 0;
 }
@@ -2581,7 +2585,8 @@ int kvm_clear_guest(struct kvm *kvm, gpa_t gpa, unsigned long len)
 }
 EXPORT_SYMBOL_GPL(kvm_clear_guest);
 
-static void mark_page_dirty_in_slot(struct kvm_memory_slot *memslot,
+static void mark_page_dirty_in_slot(struct kvm *kvm,
+				    struct kvm_memory_slot *memslot,
 				    gfn_t gfn)
 {
 	if (memslot && memslot->dirty_bitmap) {
@@ -2596,7 +2601,7 @@ void mark_page_dirty(struct kvm *kvm, gfn_t gfn)
 	struct kvm_memory_slot *memslot;
 
 	memslot = gfn_to_memslot(kvm, gfn);
-	mark_page_dirty_in_slot(memslot, gfn);
+	mark_page_dirty_in_slot(kvm, memslot, gfn);
 }
 EXPORT_SYMBOL_GPL(mark_page_dirty);
 
@@ -2605,7 +2610,7 @@ void kvm_vcpu_mark_page_dirty(struct kvm_vcpu *vcpu, gfn_t gfn)
 	struct kvm_memory_slot *memslot;
 
 	memslot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
-	mark_page_dirty_in_slot(memslot, gfn);
+	mark_page_dirty_in_slot(vcpu->kvm, memslot, gfn);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_mark_page_dirty);
 
-- 
2.26.2

