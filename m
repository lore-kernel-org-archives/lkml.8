Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CC643C3F2D7
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:50:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9CD0C21D56
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 17:50:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VA2BnjJt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388314AbgCDRuJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 12:50:09 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32931 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388260AbgCDRuH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 12:50:07 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583344206;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=MHJVA+bplfbLjEo70yhJaI+LPocQVNmuKPJNinfoZdc=;
        b=VA2BnjJtgsgAYv7BemlZKFq4tNqpECq9dCxNeK9eKTlt1OLcoA5k7J1hLj72cUxZsXMuGH
        ubVhDXTp+hUfuqa/O60ch4ToOROzO6tB+UZMHYCr3v1uHI+KV9k9D2sN5kZjMvKmLBPwFs
        hK3No9BItVdhpfA7qkN5FZZdHcAIkwY=
Received: from mail-qt1-f200.google.com (mail-qt1-f200.google.com
 [209.85.160.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-371-QEvs3Z9vPXy30rbU-J1ltA-1; Wed, 04 Mar 2020 12:50:04 -0500
X-MC-Unique: QEvs3Z9vPXy30rbU-J1ltA-1
Received: by mail-qt1-f200.google.com with SMTP id d2so1980643qtr.9
        for <linux-kernel@vger.kernel.org>; Wed, 04 Mar 2020 09:50:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=MHJVA+bplfbLjEo70yhJaI+LPocQVNmuKPJNinfoZdc=;
        b=VUAxuPiyYEdPPa4emDb42sFA+baIpZiAZUhRJwIEbGxTp6/3XpY9NA6JkH4yn6JG+S
         MdCJyrfIqFb3gJ/9nFQlqLZuKmf+x3jq1AeTLtFu5j9+9Rhr3xqZJB4fHGdk4aqMhGFZ
         DNEIQO7/7b3FE9STXq0a8ggRziNKyLjp3pNHq5ue/T9qRp8dbAvFghkoYyg03ePKOSAG
         ae4k0Zggcrc0sQclWrp62Ho+LobBsj/8U3cu2FVMW57WX0k6/AjsMiufOHGAFaAEUjWV
         pCJ9fuma63mul65MgeAzz6UtgXO+paEXhmFVpSXCdNFzE5NTMRJeKgHZLP1JqUfgZ3z6
         vRNg==
X-Gm-Message-State: ANhLgQ0KoYlCXk3RJgA2nk39kemDX3TZSed+7Un+5ptQDs/dvOl0tFXu
        pyrFWnB9+abU9GWicQhDDY/x9dJxETwLydlgNxCQZMVmVaAtHtpEEzFwVn6WNy6oAfcI/+z5JEE
        Lz3COZZ+uCAVTmtjsbXP6ZgeB
X-Received: by 2002:ae9:f806:: with SMTP id x6mr3998752qkh.16.1583344203894;
        Wed, 04 Mar 2020 09:50:03 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvRk241b7KiPkJyvxLCm5KswBbkUOO7/TZ0hYcC6VSzMPLlDTjGN0XkG4XWMlwVgXSpmoQRgA==
X-Received: by 2002:ae9:f806:: with SMTP id x6mr3998725qkh.16.1583344203639;
        Wed, 04 Mar 2020 09:50:03 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id a23sm14242509qko.77.2020.03.04.09.50.02
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 04 Mar 2020 09:50:02 -0800 (PST)
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
Subject: [PATCH v5 04/14] KVM: Pass in kvm pointer into mark_page_dirty_in_slot()
Date:   Wed,  4 Mar 2020 12:49:37 -0500
Message-Id: <20200304174947.69595-5-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200304174947.69595-1-peterx@redhat.com>
References: <20200304174947.69595-1-peterx@redhat.com>
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
index e6484dabfc59..7280417d82f0 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -144,7 +144,9 @@ static void hardware_disable_all(void);
 
 static void kvm_io_bus_destroy(struct kvm_io_bus *bus);
 
-static void mark_page_dirty_in_slot(struct kvm_memory_slot *memslot, gfn_t gfn);
+static void mark_page_dirty_in_slot(struct kvm *kvm,
+				    struct kvm_memory_slot *memslot,
+				    gfn_t gfn);
 
 __visible bool kvm_rebooting;
 EXPORT_SYMBOL_GPL(kvm_rebooting);
@@ -1915,7 +1917,8 @@ int kvm_vcpu_map(struct kvm_vcpu *vcpu, gfn_t gfn, struct kvm_host_map *map)
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_map);
 
-static void __kvm_unmap_gfn(struct kvm_memory_slot *memslot,
+static void __kvm_unmap_gfn(struct kvm *kvm,
+			struct kvm_memory_slot *memslot,
 			struct kvm_host_map *map,
 			struct gfn_to_pfn_cache *cache,
 			bool dirty, bool atomic)
@@ -1940,7 +1943,7 @@ static void __kvm_unmap_gfn(struct kvm_memory_slot *memslot,
 #endif
 
 	if (dirty)
-		mark_page_dirty_in_slot(memslot, map->gfn);
+		mark_page_dirty_in_slot(kvm, memslot, map->gfn);
 
 	if (cache)
 		cache->dirty |= dirty;
@@ -1954,7 +1957,7 @@ static void __kvm_unmap_gfn(struct kvm_memory_slot *memslot,
 int kvm_unmap_gfn(struct kvm_vcpu *vcpu, struct kvm_host_map *map, 
 		  struct gfn_to_pfn_cache *cache, bool dirty, bool atomic)
 {
-	__kvm_unmap_gfn(gfn_to_memslot(vcpu->kvm, map->gfn), map,
+	__kvm_unmap_gfn(vcpu->kvm, gfn_to_memslot(vcpu->kvm, map->gfn), map,
 			cache, dirty, atomic);
 	return 0;
 }
@@ -1962,8 +1965,8 @@ EXPORT_SYMBOL_GPL(kvm_unmap_gfn);
 
 void kvm_vcpu_unmap(struct kvm_vcpu *vcpu, struct kvm_host_map *map, bool dirty)
 {
-	__kvm_unmap_gfn(kvm_vcpu_gfn_to_memslot(vcpu, map->gfn), map, NULL,
-			dirty, false);
+	__kvm_unmap_gfn(vcpu->kvm, kvm_vcpu_gfn_to_memslot(vcpu, map->gfn),
+			map, NULL, dirty, false);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_unmap);
 
@@ -2137,7 +2140,8 @@ int kvm_vcpu_read_guest_atomic(struct kvm_vcpu *vcpu, gpa_t gpa,
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_read_guest_atomic);
 
-static int __kvm_write_guest_page(struct kvm_memory_slot *memslot, gfn_t gfn,
+static int __kvm_write_guest_page(struct kvm *kvm,
+				  struct kvm_memory_slot *memslot, gfn_t gfn,
 			          const void *data, int offset, int len)
 {
 	int r;
@@ -2149,7 +2153,7 @@ static int __kvm_write_guest_page(struct kvm_memory_slot *memslot, gfn_t gfn,
 	r = __copy_to_user((void __user *)addr + offset, data, len);
 	if (r)
 		return -EFAULT;
-	mark_page_dirty_in_slot(memslot, gfn);
+	mark_page_dirty_in_slot(kvm, memslot, gfn);
 	return 0;
 }
 
@@ -2158,7 +2162,7 @@ int kvm_write_guest_page(struct kvm *kvm, gfn_t gfn,
 {
 	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
 
-	return __kvm_write_guest_page(slot, gfn, data, offset, len);
+	return __kvm_write_guest_page(kvm, slot, gfn, data, offset, len);
 }
 EXPORT_SYMBOL_GPL(kvm_write_guest_page);
 
@@ -2167,7 +2171,7 @@ int kvm_vcpu_write_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn,
 {
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 
-	return __kvm_write_guest_page(slot, gfn, data, offset, len);
+	return __kvm_write_guest_page(vcpu->kvm, slot, gfn, data, offset, len);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_write_guest_page);
 
@@ -2286,7 +2290,7 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	r = __copy_to_user((void __user *)ghc->hva + offset, data, len);
 	if (r)
 		return -EFAULT;
-	mark_page_dirty_in_slot(ghc->memslot, gpa >> PAGE_SHIFT);
+	mark_page_dirty_in_slot(kvm, ghc->memslot, gpa >> PAGE_SHIFT);
 
 	return 0;
 }
@@ -2353,7 +2357,8 @@ int kvm_clear_guest(struct kvm *kvm, gpa_t gpa, unsigned long len)
 }
 EXPORT_SYMBOL_GPL(kvm_clear_guest);
 
-static void mark_page_dirty_in_slot(struct kvm_memory_slot *memslot,
+static void mark_page_dirty_in_slot(struct kvm *kvm,
+				    struct kvm_memory_slot *memslot,
 				    gfn_t gfn)
 {
 	if (memslot && memslot->dirty_bitmap) {
@@ -2368,7 +2373,7 @@ void mark_page_dirty(struct kvm *kvm, gfn_t gfn)
 	struct kvm_memory_slot *memslot;
 
 	memslot = gfn_to_memslot(kvm, gfn);
-	mark_page_dirty_in_slot(memslot, gfn);
+	mark_page_dirty_in_slot(kvm, memslot, gfn);
 }
 EXPORT_SYMBOL_GPL(mark_page_dirty);
 
@@ -2377,7 +2382,7 @@ void kvm_vcpu_mark_page_dirty(struct kvm_vcpu *vcpu, gfn_t gfn)
 	struct kvm_memory_slot *memslot;
 
 	memslot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
-	mark_page_dirty_in_slot(memslot, gfn);
+	mark_page_dirty_in_slot(vcpu->kvm, memslot, gfn);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_mark_page_dirty);
 
-- 
2.24.1

