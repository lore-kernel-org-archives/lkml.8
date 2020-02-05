Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31310C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:58:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EB4DA214AF
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:58:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Zk8Pnsf2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727899AbgBEC6u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 21:58:50 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:34806 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727746AbgBEC6t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 21:58:49 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580871528;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=iMoyuUQG6mGTZVCTKYztmS6Hs0K242TSdWPEeOxZW6A=;
        b=Zk8Pnsf2ajJs2A8PU1TMYhlCMP3QCH+1zyGe7XH59GdobpRhqwsakGFtcWBX6ZKSjAdfAr
        z/SBWwrcX7HbYbeCfvmgUYLgzluBlxc3hEwf3Jpex99tjYbcLq982afc4JuLs5z52Scaou
        AK2HwdMUH1ycPgML81mtVr8bpsWuo24=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-241-8MDC-D-hOOuZOLfcA2gzBA-1; Tue, 04 Feb 2020 21:58:46 -0500
X-MC-Unique: 8MDC-D-hOOuZOLfcA2gzBA-1
Received: by mail-qv1-f69.google.com with SMTP id v3so642932qvm.2
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 18:58:46 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=iMoyuUQG6mGTZVCTKYztmS6Hs0K242TSdWPEeOxZW6A=;
        b=t+wtbenNOwrNyT5UFiSG68P1LIpK0gfR7r7KBAbf2c+3kr2wEhIM2iEsrTkBjDwvdv
         PbcjuWhDSGvnohOudBSi0+bQKovqjsHDv7yVUtOKFvx+x/hlnJYMhNn7Of2smfc/HJzL
         065mwHGqTruh5rvDeN7/Cdlzo69R7uZlHft+d581LWBnEF7zcUvyNEKoy8tgQXltq5J/
         QjXlP+18vJ0zETG3GVQ6mPemJDX8S8vJXplCFw7n3JZShj1ymWZEC6pYPVbPEjJXq37C
         cmDPCndRnOlT2HBHcDrI0KCll8zyO5xDmwRx9Sp4AKC4wrxZbGnNMY52ju1IS07qEkPV
         yCQQ==
X-Gm-Message-State: APjAAAXm0fwQngKDjVDRN3Ww3IKrjv2OibtmCy9pTfCeXN3Pkv6/k3xR
        jrX8/FF6gyvPR22yPxNrZAh7YQ9snzvMQ7BMf0ww/4tx2mawNyDDpRZPILTwOS8ubpjpbwHtHND
        m07jWjx39/yhsRD1mIrCWMrDQ
X-Received: by 2002:ac8:1415:: with SMTP id k21mr31821683qtj.300.1580871525713;
        Tue, 04 Feb 2020 18:58:45 -0800 (PST)
X-Google-Smtp-Source: APXvYqwcW1YtKLT8v5bd10IJa63sORuNDIe53LmsHkfWJo8kyUKgeShP1B4VamT5gnlv2wvLf68pxw==
X-Received: by 2002:ac8:1415:: with SMTP id k21mr31821664qtj.300.1580871525461;
        Tue, 04 Feb 2020 18:58:45 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id e64sm12961649qtd.45.2020.02.04.18.58.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 18:58:44 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     dinechin@redhat.com, sean.j.christopherson@intel.com,
        pbonzini@redhat.com, jasowang@redhat.com, yan.y.zhao@intel.com,
        mst@redhat.com, peterx@redhat.com, kevin.tian@intel.com,
        alex.williamson@redhat.com, dgilbert@redhat.com,
        vkuznets@redhat.com
Subject: [PATCH 04/14] KVM: Pass in kvm pointer into mark_page_dirty_in_slot()
Date:   Tue,  4 Feb 2020 21:58:32 -0500
Message-Id: <20200205025842.367575-1-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205025105.367213-1-peterx@redhat.com>
References: <20200205025105.367213-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The context will be needed to implement the kvm dirty ring.

Reviewed-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 virt/kvm/kvm_main.c | 22 +++++++++++++---------
 1 file changed, 13 insertions(+), 9 deletions(-)

diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 69190f9f7bd8..5307f6e33587 100644
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
@@ -2057,7 +2059,8 @@ int kvm_vcpu_read_guest_atomic(struct kvm_vcpu *vcpu, gpa_t gpa,
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_read_guest_atomic);
 
-static int __kvm_write_guest_page(struct kvm_memory_slot *memslot, gfn_t gfn,
+static int __kvm_write_guest_page(struct kvm *kvm,
+				  struct kvm_memory_slot *memslot, gfn_t gfn,
 			          const void *data, int offset, int len)
 {
 	int r;
@@ -2069,7 +2072,7 @@ static int __kvm_write_guest_page(struct kvm_memory_slot *memslot, gfn_t gfn,
 	r = __copy_to_user((void __user *)addr + offset, data, len);
 	if (r)
 		return -EFAULT;
-	mark_page_dirty_in_slot(memslot, gfn);
+	mark_page_dirty_in_slot(kvm, memslot, gfn);
 	return 0;
 }
 
@@ -2078,7 +2081,7 @@ int kvm_write_guest_page(struct kvm *kvm, gfn_t gfn,
 {
 	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
 
-	return __kvm_write_guest_page(slot, gfn, data, offset, len);
+	return __kvm_write_guest_page(kvm, slot, gfn, data, offset, len);
 }
 EXPORT_SYMBOL_GPL(kvm_write_guest_page);
 
@@ -2087,7 +2090,7 @@ int kvm_vcpu_write_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn,
 {
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 
-	return __kvm_write_guest_page(slot, gfn, data, offset, len);
+	return __kvm_write_guest_page(vcpu->kvm, slot, gfn, data, offset, len);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_write_guest_page);
 
@@ -2206,7 +2209,7 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	r = __copy_to_user((void __user *)ghc->hva + offset, data, len);
 	if (r)
 		return -EFAULT;
-	mark_page_dirty_in_slot(ghc->memslot, gpa >> PAGE_SHIFT);
+	mark_page_dirty_in_slot(kvm, ghc->memslot, gpa >> PAGE_SHIFT);
 
 	return 0;
 }
@@ -2273,7 +2276,8 @@ int kvm_clear_guest(struct kvm *kvm, gpa_t gpa, unsigned long len)
 }
 EXPORT_SYMBOL_GPL(kvm_clear_guest);
 
-static void mark_page_dirty_in_slot(struct kvm_memory_slot *memslot,
+static void mark_page_dirty_in_slot(struct kvm *kvm,
+				    struct kvm_memory_slot *memslot,
 				    gfn_t gfn)
 {
 	if (memslot && memslot->dirty_bitmap) {
@@ -2288,7 +2292,7 @@ void mark_page_dirty(struct kvm *kvm, gfn_t gfn)
 	struct kvm_memory_slot *memslot;
 
 	memslot = gfn_to_memslot(kvm, gfn);
-	mark_page_dirty_in_slot(memslot, gfn);
+	mark_page_dirty_in_slot(kvm, memslot, gfn);
 }
 EXPORT_SYMBOL_GPL(mark_page_dirty);
 
@@ -2297,7 +2301,7 @@ void kvm_vcpu_mark_page_dirty(struct kvm_vcpu *vcpu, gfn_t gfn)
 	struct kvm_memory_slot *memslot;
 
 	memslot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
-	mark_page_dirty_in_slot(memslot, gfn);
+	mark_page_dirty_in_slot(vcpu->kvm, memslot, gfn);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_mark_page_dirty);
 
-- 
2.24.1

