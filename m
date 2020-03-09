Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCBBFC10F25
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:45:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 963CD24649
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:45:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="ZQCP9nQ/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727249AbgCIVpG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:45:06 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:37858 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726974AbgCIVoj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 17:44:39 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583790278;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=mfTkC/PY7xB+DvD3BXQd6wkmojeJ73JPJ868luIW5QI=;
        b=ZQCP9nQ/9xzOj/FdWSo1DwsXTnb/8pswGXCENeo2zEwXGfziEp8O+T9RkC5QbB79jHi09X
        /WrIbDXqc54Iy6DbyZhzTDGtYi18EHLSVQmdQ0O7AurHVGqoiliefvfSISRxdWlcQcP+1i
        XWhdBXfCiurrrysK+jEt55CkScVBMho=
Received: from mail-qt1-f197.google.com (mail-qt1-f197.google.com
 [209.85.160.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-161-2xznUvRpNU6TtC0jHENvpA-1; Mon, 09 Mar 2020 17:44:34 -0400
X-MC-Unique: 2xznUvRpNU6TtC0jHENvpA-1
Received: by mail-qt1-f197.google.com with SMTP id r16so7773036qtt.13
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 14:44:34 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=mfTkC/PY7xB+DvD3BXQd6wkmojeJ73JPJ868luIW5QI=;
        b=Vf+FINGvjOgkYAG6qabsARkyl655E0edBcoeIyrciCo1kfYKBOrxYqqclT0VIHluD6
         qsO66MRN2D8PI2+3mASSmwsuLD0fWfoieSGGp+OiayyupSHt56lNi+jM9tBIkyUnUPTJ
         i3ksi83yJLf87DFH1ptxalfWxrb6h5rITF0ZeFoPiW56EbD0fQHHMbte45q0VbbISDzP
         LLdHE1jNyJMX/NPjfw/PAk4/bZqRgOZ2uD2oqnIDnZuwggcVDZN1ty4ABK9bily6T4Wt
         eHHS81+PonHe80u1+wKsM+NXxdDJ+drHVn14AG8IO3oXBEp/Ts+wxoCfwy+3B7cUHRL7
         MXCw==
X-Gm-Message-State: ANhLgQ1TxE1WCph09j0gRTHItiOXpBhsCNqYIt7jt7+6/HxztOsfIjTh
        BQNUB64o7IWS4oJmCGo2kkPLhZYDZk8v9iyW5wpPfU64eh9u8IqrFtvJMok85lcO5iQ2rlNvhIr
        FmcASmrRfVZnxkICguYkQ007w
X-Received: by 2002:a05:620a:10b3:: with SMTP id h19mr17258501qkk.440.1583790273660;
        Mon, 09 Mar 2020 14:44:33 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvsM+A/HXt2SdA20F9/F6ZEZxnI2TYHMgtduNetNttyjBPSSVebBrYy4uvOhyP6E4shJ1zt5A==
X-Received: by 2002:a05:620a:10b3:: with SMTP id h19mr17258480qkk.440.1583790273430;
        Mon, 09 Mar 2020 14:44:33 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id m11sm19777447qkh.31.2020.03.09.14.44.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:44:32 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Yan Zhao <yan.y.zhao@intel.com>, Jason Wang <jasowang@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        peterx@redhat.com, Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Subject: [PATCH v6 02/14] KVM: Cache as_id in kvm_memory_slot
Date:   Mon,  9 Mar 2020 17:44:12 -0400
Message-Id: <20200309214424.330363-3-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309214424.330363-1-peterx@redhat.com>
References: <20200309214424.330363-1-peterx@redhat.com>
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
index bcb9b2ac0791..afa0e9034881 100644
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
index 70f03ce0e5c1..e6484dabfc59 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -1036,6 +1036,8 @@ int __kvm_set_memory_region(struct kvm *kvm,
 
 	new = old = *slot;
 
+	BUILD_BUG_ON(U8_MAX < KVM_ADDRESS_SPACE_NUM);
+	new.as_id = as_id;
 	new.id = id;
 	new.base_gfn = base_gfn;
 	new.npages = npages;
-- 
2.24.1

