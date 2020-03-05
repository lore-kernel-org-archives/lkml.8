Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A050C3F2D2
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:57:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E52D02072D
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 15:57:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="No1VK0Js"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727167AbgCEP5V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 10:57:21 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47751 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726184AbgCEP5U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 10:57:20 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583423839;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BKhoQxKzVdv0hd1Nmd+yV7hKjeG+Y4sbHF1K+C0InG0=;
        b=No1VK0Jsb+nIocMcR2Idv9eWZ+dU69bLU0tsrH1ZgdSqSc1Z3oFam29usjXcExoaWRL9j+
        CJkD4YADUjwGsRUhTeSAuwrkQSTxPG10Kh+I0Ry3oU7vvZvcyqsvMzzKwnHbOPfWwPeFiK
        Z1jhe6D/5sdgd733y8AuHxEY+McZsnQ=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-25-plA_70yAM6Oa0ROicP3veg-1; Thu, 05 Mar 2020 10:57:18 -0500
X-MC-Unique: plA_70yAM6Oa0ROicP3veg-1
Received: by mail-qt1-f197.google.com with SMTP id o9so4107671qtt.8
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 07:57:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=BKhoQxKzVdv0hd1Nmd+yV7hKjeG+Y4sbHF1K+C0InG0=;
        b=KD/swwufV1p+8LNjbPdQdXBHJXJNgUfJVn8CbGDtz12Y3qecZHOkLaUyPOBZBx80Iq
         eikPKCr6sWP5y8pVuNLHLsTVbi5uLPcnz62ECCrnLW8/EXgN/hv+9st5AB+9YEhWCXd4
         pj1z10Kk6eATBbBRA4pWRGTqa+CRavgabzG6Fc74BDok4/07fQ1zsgR3e+602syq9gaj
         hQyFkCFwC1jb5tJosktw5fBJYGxicDTx5PNY42Bgahc7naIS32RPKorol+HzzJvE9snu
         yn2wgykXOwGZM7fufq7DhaZJGL6AGkpC8y9OJATPhek7DWdLvZW6J9cy0Nxr5eaob7Lc
         qx2w==
X-Gm-Message-State: ANhLgQ1Cr4x79T7fiOfCHLMAX48udRkvPBSj76KSocT8/zPJ1e2eQnxd
        Wt+S1Hz/FCLqE7f/HsIsVg00s8jrUylvLyoJIJW9STA6+plM8bL9imFtult1lKojGViuCHeIY8I
        E7HYRFJs2L15k+qesFmqkDOc9
X-Received: by 2002:a0c:f64e:: with SMTP id s14mr6990172qvm.129.1583423837882;
        Thu, 05 Mar 2020 07:57:17 -0800 (PST)
X-Google-Smtp-Source: ADFU+vtbWhnXso6DibXEzx0MPB5VJm2bB4SiaCiuUwt486jy6wWRPqTydJKvfB1ptF3rG84ssICm/Q==
X-Received: by 2002:a0c:f64e:: with SMTP id s14mr6990149qvm.129.1583423837566;
        Thu, 05 Mar 2020 07:57:17 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id x93sm8030727qte.60.2020.03.05.07.57.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 07:57:16 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     linmiaohe@huawei.com, Paolo Bonzini <pbonzini@redhat.com>,
        peterx@redhat.com
Subject: [PATCH v2 2/2] KVM: Drop gfn_to_pfn_atomic()
Date:   Thu,  5 Mar 2020 10:57:09 -0500
Message-Id: <20200305155709.118503-3-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305155709.118503-1-peterx@redhat.com>
References: <20200305155709.118503-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It's never used anywhere now.

Reviewed-by: linmiaohe <linmiaohe@huawei.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/kvm_host.h | 1 -
 virt/kvm/kvm_main.c      | 6 ------
 2 files changed, 7 deletions(-)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index bcb9b2ac0791..3faa062ea108 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -704,7 +704,6 @@ void kvm_release_page_clean(struct page *page);
 void kvm_release_page_dirty(struct page *page);
 void kvm_set_page_accessed(struct page *page);
 
-kvm_pfn_t gfn_to_pfn_atomic(struct kvm *kvm, gfn_t gfn);
 kvm_pfn_t gfn_to_pfn(struct kvm *kvm, gfn_t gfn);
 kvm_pfn_t gfn_to_pfn_prot(struct kvm *kvm, gfn_t gfn, bool write_fault,
 		      bool *writable);
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 70f03ce0e5c1..d29718c7017c 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1754,12 +1754,6 @@ kvm_pfn_t gfn_to_pfn_memslot_atomic(struct kvm_memory_slot *slot, gfn_t gfn)
 }
 EXPORT_SYMBOL_GPL(gfn_to_pfn_memslot_atomic);
 
-kvm_pfn_t gfn_to_pfn_atomic(struct kvm *kvm, gfn_t gfn)
-{
-	return gfn_to_pfn_memslot_atomic(gfn_to_memslot(kvm, gfn), gfn);
-}
-EXPORT_SYMBOL_GPL(gfn_to_pfn_atomic);
-
 kvm_pfn_t kvm_vcpu_gfn_to_pfn_atomic(struct kvm_vcpu *vcpu, gfn_t gfn)
 {
 	return gfn_to_pfn_memslot_atomic(kvm_vcpu_gfn_to_memslot(vcpu, gfn), gfn);
-- 
2.24.1

