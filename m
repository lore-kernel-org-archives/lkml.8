Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DA15EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:54:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B64DC206D5
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 12:54:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=shutemov-name.20150623.gappssmtp.com header.i=@shutemov-name.20150623.gappssmtp.com header.b="0fINIB2q"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730358AbgEVMyA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 08:54:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728853AbgEVMwW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 08:52:22 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16CE6C08C5C2
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 05:52:22 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id m18so12478347ljo.5
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 05:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=shutemov-name.20150623.gappssmtp.com; s=20150623;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YfqDw99wlD4f4u2TbTJ6qHze4NSI0wbOg8F4/7GJtp0=;
        b=0fINIB2q2FFPAT+xSTZ65uNII/27pj5fJVYLosTwProbYATdYgQuDBG3a2I8I3nFzi
         LWQCOlA7QXSD6k9T6ZSf+p2nLXjsX7MhLfwOiouiIs8DzcihJv8k0oB8V6USr19PlxaN
         9TP2nKUTAvfDOhaMkXa6cbW3bC25fYtZje89nBuKcTfHA1uwShTP7dn/JbwrieClk6Oj
         lDRid2YBwhyiKH3rY0plHD3x66DuxS2/uPUjrPP3CQ9ZguxuqBjXuiQYHPK/JRVHrItW
         Mptrk8PiJhWHrslmXiyyTVgpNiU4biVgczasRq833LYThCovuhuF9lwnSNRieapCjAaN
         P7HQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YfqDw99wlD4f4u2TbTJ6qHze4NSI0wbOg8F4/7GJtp0=;
        b=aWaKKgFe5msw8pjNFlqV95MdKK/gRHg/7pMy1woRmloWTDKYC/xJWfE3JGZuZCfN9y
         RnIBFZMjV0nDViYOB3RdblQHTF5etIrW+RtdZ89A//sDtQ62XQf4O4PHj+V6Xd9oMz1u
         8qj6Rxalk5H5QganSdDGtXYPQqbgonO8TY4SX30qM5nTPEm4ITJLig7/GPhBuW183OME
         FQEOEW4V/G80BSjPAoIg+nJaZH9IyL9PEUYY9HN3ElXARJ5GHfoi4jPoGCmvKgHViDL5
         hnTW42MHlfqmlAw4NUMULO5LFc2pA7B5+z0x5zJTEZI2R+RtRhNDd7Fce2YY6k3HNPa7
         bbkg==
X-Gm-Message-State: AOAM5334ydqP4XRWmVUgedMK1OrTj/Ccxk6SaRUYd3piaY8uT5185EvE
        lUFf5NOgyw6S9ce6rOl5vfDp5w==
X-Google-Smtp-Source: ABdhPJzUQtdSq+up9u40Vs7gZXaMufhhVUg0JUUDOWbSlD4zO7U6sTxMHmCVlgCqI/FGQiCPCeitTw==
X-Received: by 2002:a2e:97c3:: with SMTP id m3mr6974669ljj.23.1590151940561;
        Fri, 22 May 2020 05:52:20 -0700 (PDT)
Received: from box.localdomain ([86.57.175.117])
        by smtp.gmail.com with ESMTPSA id s8sm2406642lfd.61.2020.05.22.05.52.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 22 May 2020 05:52:20 -0700 (PDT)
From:   "Kirill A. Shutemov" <kirill@shutemov.name>
X-Google-Original-From: "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Received: by box.localdomain (Postfix, from userid 1000)
        id C8F18102054; Fri, 22 May 2020 15:52:19 +0300 (+03)
To:     Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>
Cc:     David Rientjes <rientjes@google.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        Will Drewry <wad@chromium.org>,
        "Edgecombe, Rick P" <rick.p.edgecombe@intel.com>,
        "Kleen, Andi" <andi.kleen@intel.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        "Kirill A. Shutemov" <kirill.shutemov@linux.intel.com>
Subject: [RFC 06/16] KVM: Use GUP instead of copy_from/to_user() to access guest memory
Date:   Fri, 22 May 2020 15:52:04 +0300
Message-Id: <20200522125214.31348-7-kirill.shutemov@linux.intel.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200522125214.31348-1-kirill.shutemov@linux.intel.com>
References: <20200522125214.31348-1-kirill.shutemov@linux.intel.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

New helpers copy_from_guest()/copy_to_guest() to be used if KVM memory
protection feature is enabled.

Signed-off-by: Kirill A. Shutemov <kirill.shutemov@linux.intel.com>
---
 include/linux/kvm_host.h |  4 +++
 virt/kvm/kvm_main.c      | 78 ++++++++++++++++++++++++++++++++++------
 2 files changed, 72 insertions(+), 10 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 131cc1527d68..bd0bb600f610 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -503,6 +503,7 @@ struct kvm {
 	struct srcu_struct srcu;
 	struct srcu_struct irq_srcu;
 	pid_t userspace_pid;
+	bool mem_protected;
 };
 
 #define kvm_err(fmt, ...) \
@@ -727,6 +728,9 @@ void kvm_set_pfn_dirty(kvm_pfn_t pfn);
 void kvm_set_pfn_accessed(kvm_pfn_t pfn);
 void kvm_get_pfn(kvm_pfn_t pfn);
 
+int copy_from_guest(void *data, unsigned long hva, int len);
+int copy_to_guest(unsigned long hva, const void *data, int len);
+
 void kvm_release_pfn(kvm_pfn_t pfn, bool dirty, struct gfn_to_pfn_cache *cache);
 int kvm_read_guest_page(struct kvm *kvm, gfn_t gfn, void *data, int offset,
 			int len);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 731c1e517716..033471f71dae 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -2248,8 +2248,48 @@ static int next_segment(unsigned long len, int offset)
 		return len;
 }
 
+int copy_from_guest(void *data, unsigned long hva, int len)
+{
+	int offset = offset_in_page(hva);
+	struct page *page;
+	int npages, seg;
+
+	while ((seg = next_segment(len, offset)) != 0) {
+		npages = get_user_pages_unlocked(hva, 1, &page, 0);
+		if (npages != 1)
+			return -EFAULT;
+		memcpy(data, page_address(page) + offset, seg);
+		put_page(page);
+		len -= seg;
+		hva += seg;
+		offset = 0;
+	}
+
+	return 0;
+}
+
+int copy_to_guest(unsigned long hva, const void *data, int len)
+{
+	int offset = offset_in_page(hva);
+	struct page *page;
+	int npages, seg;
+
+	while ((seg = next_segment(len, offset)) != 0) {
+		npages = get_user_pages_unlocked(hva, 1, &page, FOLL_WRITE);
+		if (npages != 1)
+			return -EFAULT;
+		memcpy(page_address(page) + offset, data, seg);
+		put_page(page);
+		len -= seg;
+		hva += seg;
+		offset = 0;
+	}
+	return 0;
+}
+
 static int __kvm_read_guest_page(struct kvm_memory_slot *slot, gfn_t gfn,
-				 void *data, int offset, int len)
+				 void *data, int offset, int len,
+				 bool protected)
 {
 	int r;
 	unsigned long addr;
@@ -2257,7 +2297,10 @@ static int __kvm_read_guest_page(struct kvm_memory_slot *slot, gfn_t gfn,
 	addr = gfn_to_hva_memslot_prot(slot, gfn, NULL);
 	if (kvm_is_error_hva(addr))
 		return -EFAULT;
-	r = __copy_from_user(data, (void __user *)addr + offset, len);
+	if (protected)
+		r = copy_from_guest(data, addr + offset, len);
+	else
+		r = __copy_from_user(data, (void __user *)addr + offset, len);
 	if (r)
 		return -EFAULT;
 	return 0;
@@ -2268,7 +2311,8 @@ int kvm_read_guest_page(struct kvm *kvm, gfn_t gfn, void *data, int offset,
 {
 	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
 
-	return __kvm_read_guest_page(slot, gfn, data, offset, len);
+	return __kvm_read_guest_page(slot, gfn, data, offset, len,
+				     kvm->mem_protected);
 }
 EXPORT_SYMBOL_GPL(kvm_read_guest_page);
 
@@ -2277,7 +2321,8 @@ int kvm_vcpu_read_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn, void *data,
 {
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 
-	return __kvm_read_guest_page(slot, gfn, data, offset, len);
+	return __kvm_read_guest_page(slot, gfn, data, offset, len,
+				     vcpu->kvm->mem_protected);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_read_guest_page);
 
@@ -2350,7 +2395,8 @@ int kvm_vcpu_read_guest_atomic(struct kvm_vcpu *vcpu, gpa_t gpa,
 EXPORT_SYMBOL_GPL(kvm_vcpu_read_guest_atomic);
 
 static int __kvm_write_guest_page(struct kvm_memory_slot *memslot, gfn_t gfn,
-			          const void *data, int offset, int len)
+			          const void *data, int offset, int len,
+				  bool protected)
 {
 	int r;
 	unsigned long addr;
@@ -2358,7 +2404,11 @@ static int __kvm_write_guest_page(struct kvm_memory_slot *memslot, gfn_t gfn,
 	addr = gfn_to_hva_memslot(memslot, gfn);
 	if (kvm_is_error_hva(addr))
 		return -EFAULT;
-	r = __copy_to_user((void __user *)addr + offset, data, len);
+
+	if (protected)
+		r = copy_to_guest(addr + offset, data, len);
+	else
+		r = __copy_to_user((void __user *)addr + offset, data, len);
 	if (r)
 		return -EFAULT;
 	mark_page_dirty_in_slot(memslot, gfn);
@@ -2370,7 +2420,8 @@ int kvm_write_guest_page(struct kvm *kvm, gfn_t gfn,
 {
 	struct kvm_memory_slot *slot = gfn_to_memslot(kvm, gfn);
 
-	return __kvm_write_guest_page(slot, gfn, data, offset, len);
+	return __kvm_write_guest_page(slot, gfn, data, offset, len,
+				      kvm->mem_protected);
 }
 EXPORT_SYMBOL_GPL(kvm_write_guest_page);
 
@@ -2379,7 +2430,8 @@ int kvm_vcpu_write_guest_page(struct kvm_vcpu *vcpu, gfn_t gfn,
 {
 	struct kvm_memory_slot *slot = kvm_vcpu_gfn_to_memslot(vcpu, gfn);
 
-	return __kvm_write_guest_page(slot, gfn, data, offset, len);
+	return __kvm_write_guest_page(slot, gfn, data, offset, len,
+				      vcpu->kvm->mem_protected);
 }
 EXPORT_SYMBOL_GPL(kvm_vcpu_write_guest_page);
 
@@ -2495,7 +2547,10 @@ int kvm_write_guest_offset_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	if (unlikely(!ghc->memslot))
 		return kvm_write_guest(kvm, gpa, data, len);
 
-	r = __copy_to_user((void __user *)ghc->hva + offset, data, len);
+	if (kvm->mem_protected)
+		r = copy_to_guest(ghc->hva + offset, data, len);
+	else
+		r = __copy_to_user((void __user *)ghc->hva + offset, data, len);
 	if (r)
 		return -EFAULT;
 	mark_page_dirty_in_slot(ghc->memslot, gpa >> PAGE_SHIFT);
@@ -2530,7 +2585,10 @@ int kvm_read_guest_cached(struct kvm *kvm, struct gfn_to_hva_cache *ghc,
 	if (unlikely(!ghc->memslot))
 		return kvm_read_guest(kvm, ghc->gpa, data, len);
 
-	r = __copy_from_user(data, (void __user *)ghc->hva, len);
+	if (kvm->mem_protected)
+		r = copy_from_guest(data, ghc->hva, len);
+	else
+		r = __copy_from_user(data, (void __user *)ghc->hva, len);
 	if (r)
 		return -EFAULT;
 
-- 
2.26.2

