Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58320C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:51:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2A44621741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:51:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JPBdHM4L"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727714AbgBECvW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 21:51:22 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:59667 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727925AbgBECvT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 21:51:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580871077;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5Plaj5tCIvaG10j1wUs3FmUanZWkBG9z74VjeoL5zXQ=;
        b=JPBdHM4L0dcvqgry2wyZv0pZP3fR3sFNlYQLUO8lG0zJkRgFFIc9V7buakUqvFR2tAC34k
        cJjA+domOlctrXx14p6EoacukF6li5GMOMZz1b6UBM925tq503RAH2IIljHUe0d37ljQdq
        lWRK5+RdOrwrHL3fY+AHMhNB3iYzwA0=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-185-F4no8_iTOkWCqa4TJTvzVw-1; Tue, 04 Feb 2020 21:51:13 -0500
X-MC-Unique: F4no8_iTOkWCqa4TJTvzVw-1
Received: by mail-qk1-f199.google.com with SMTP id 12so378872qkf.20
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 18:51:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=5Plaj5tCIvaG10j1wUs3FmUanZWkBG9z74VjeoL5zXQ=;
        b=sLMkLwXWIkMKV8qkQwITbyFfvzj9dkWWOsJObnbC0SOL9DKYncGhjGLSMcezCQ2Uf+
         7Bk77ml1n4SwS5uzckD3b0NOUjXOS8bKtTXF7Zq/FW0/dOKZsmzmdvsvRUoizI14K4yc
         yon9llv/5zbdkvpUk82PhRZwEtGiRVR3Psjcls9uDGZQ/mdXIPDhJfAtV0aEt1XP2GSz
         TDKLve1eAizyi7vckPwfTrZLhYIdoFRKTTcTljXYKkOEplYgxoIJYNTy5GX3/5e+sarl
         6uy37TGrtMcnUA5dmn6AITaPLVwZ0c7aExDle3DOxcemHmJ+FLX3Z5gTdWdfFisRoDFt
         VKDQ==
X-Gm-Message-State: APjAAAV/XUFJdjAIM0+Y5JjNRrZE4lCsqWFv2KCtPOBvuab13nZ/NrlL
        mXerR6FDWxU1Y4JDM00OEDjtGjWmtdveR/H7r9APF0t7pMFtilCrCE35pvpWI9SelHcRwrY9lWc
        PziiG98TUPtNDBLZXYyQFo931
X-Received: by 2002:a37:b883:: with SMTP id i125mr32117827qkf.64.1580871073489;
        Tue, 04 Feb 2020 18:51:13 -0800 (PST)
X-Google-Smtp-Source: APXvYqzBej9VNfpaFC9AYibSNQqxHqKsfHwkxI7lciYbSIGQ7kQ3UunKMIE80komuW9A8u2g//rhrQ==
X-Received: by 2002:a37:b883:: with SMTP id i125mr32117807qkf.64.1580871073231;
        Tue, 04 Feb 2020 18:51:13 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id b141sm12380923qkg.33.2020.02.04.18.51.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 18:51:12 -0800 (PST)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Christophe de Dinechin <dinechin@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>, peterx@redhat.com,
        Kevin Tian <kevin.tian@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>
Subject: [PATCH v4 02/14] KVM: Cache as_id in kvm_memory_slot
Date:   Tue,  4 Feb 2020 21:50:53 -0500
Message-Id: <20200205025105.367213-3-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205025105.367213-1-peterx@redhat.com>
References: <20200205025105.367213-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cache the address space ID just like the slot ID.  It will be used in
order to fill in the dirty ring entries.

Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Peter Xu <peterx@redhat.com>
---
 include/linux/kvm_host.h | 1 +
 virt/kvm/kvm_main.c      | 2 ++
 2 files changed, 3 insertions(+)

diff --git a/include/linux/kvm_host.h b/include/linux/kvm_host.h
index 6d5331b0d937..62aad0a2707a 100644
--- a/include/linux/kvm_host.h
+++ b/include/linux/kvm_host.h
@@ -346,6 +346,7 @@ struct kvm_memory_slot {
 	unsigned long userspace_addr;
 	u32 flags;
 	short id;
+	u8 as_id;
 };
 
 static inline unsigned long kvm_dirty_bitmap_bytes(struct kvm_memory_slot *memslot)
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index eb3709d55139..69190f9f7bd8 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1035,6 +1035,8 @@ int __kvm_set_memory_region(struct kvm *kvm,
 
 	new = old = *slot;
 
+	BUILD_BUG_ON(U8_MAX < KVM_ADDRESS_SPACE_NUM);
+	new.as_id = as_id;
 	new.id = id;
 	new.base_gfn = base_gfn;
 	new.npages = npages;
-- 
2.24.1

