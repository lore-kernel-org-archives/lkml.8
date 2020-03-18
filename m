Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20798C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:37:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DFBC920752
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 16:37:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="VGclnibu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727138AbgCRQhi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 12:37:38 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:35778 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726780AbgCRQhi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 12:37:38 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584549457;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zL6sq31OFwBXF/RS7PK1GArrpq69jRR45bepTSw46TU=;
        b=VGclnibuEWZUb8162OgfKSdXwTEmqXc8nL8jgHk93DTnWH9Ozh3DcxL7e9ix6hwFIefQrm
        7IsqpBE0Hp3Nbc7kaFntiFECbUoWtuOvsYMau4Pwz6yleas0GT3Ek7MJ7a9za1VxHP//3a
        DbJyewtjWTL9zIAbWzUgYmIT0PehbVs=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-273-tynKiQiZMg2Cvqg_sAKSuA-1; Wed, 18 Mar 2020 12:37:36 -0400
X-MC-Unique: tynKiQiZMg2Cvqg_sAKSuA-1
Received: by mail-wr1-f71.google.com with SMTP id q18so12599773wrw.5
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 09:37:35 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zL6sq31OFwBXF/RS7PK1GArrpq69jRR45bepTSw46TU=;
        b=kTiQ+6VqGOksbmL0E0otg4t0GKSvjx0AhcHRJOnxulElQiwbV5j5NOmZDLstLrt3PH
         7U1OTfCeiuP3VMbB8K/cKKVCWOW5aQ8bLHz+jpFRgdsyr751Gm+mFqABCOURipUgS/kH
         r/7hAdaA7Gmn/uBnOCEaEmr0W1ykEw4Ps5M0GGHUH6E5ODArM0yVpJJEKFM4+ISKwtRS
         muDYnQ/g8WVdHkWWPd0ehTjHS+qlaZMLlsg73Mqqw8X5roB0I0uEs6myjl8tnzkCJJww
         1MgO4dXCY1M2Ey1DMlzyMeD6B9N+V3f1cYjVW1DMeZKwonWObyfvxyTSMTLv7xYCsNJB
         tMVQ==
X-Gm-Message-State: ANhLgQ0TgWyCtimur3MvzqoF+Nh2qekC7yDvREledIAdK5tFrFAl+qim
        XlnkaoULB/bXeJMdunS8otEwkzMP0WNIy+VF396Mn9tysBEkp+Nx1HLThD9icvdUad33eqzIg53
        fWiseb9mayZms+ZYfc6CRpov8
X-Received: by 2002:a7b:c159:: with SMTP id z25mr6176865wmi.102.1584549454926;
        Wed, 18 Mar 2020 09:37:34 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtaqPeKFAd0yJQbAvVJ4mrbLJ6/dwU/B+4yuG+/8bXFj+8dfwUAPMZMNYYT/9jRyaygaGLA2Q==
X-Received: by 2002:a7b:c159:: with SMTP id z25mr6176842wmi.102.1584549454675;
        Wed, 18 Mar 2020 09:37:34 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id t1sm10315662wrq.36.2020.03.18.09.37.30
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 09:37:33 -0700 (PDT)
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
Subject: [PATCH v7 01/14] KVM: X86: Change parameter for fast_page_fault tracepoint
Date:   Wed, 18 Mar 2020 12:37:07 -0400
Message-Id: <20200318163720.93929-2-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200318163720.93929-1-peterx@redhat.com>
References: <20200318163720.93929-1-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

It would be clearer to dump the return value to know easily on whether
did we go through the fast path for handling current page fault.
Remove the old two last parameters because after all the old/new sptes
were dumped in the same line.

Signed-off-by: Peter Xu <peterx@redhat.com>
---
 arch/x86/kvm/mmutrace.h | 9 ++-------
 1 file changed, 2 insertions(+), 7 deletions(-)

diff --git a/arch/x86/kvm/mmutrace.h b/arch/x86/kvm/mmutrace.h
index ffcd96fc02d0..ef523e760743 100644
--- a/arch/x86/kvm/mmutrace.h
+++ b/arch/x86/kvm/mmutrace.h
@@ -244,9 +244,6 @@ TRACE_EVENT(
 		  __entry->access)
 );
 
-#define __spte_satisfied(__spte)				\
-	(__entry->retry && is_writable_pte(__entry->__spte))
-
 TRACE_EVENT(
 	fast_page_fault,
 	TP_PROTO(struct kvm_vcpu *vcpu, gpa_t cr2_or_gpa, u32 error_code,
@@ -274,12 +271,10 @@ TRACE_EVENT(
 	),
 
 	TP_printk("vcpu %d gva %llx error_code %s sptep %p old %#llx"
-		  " new %llx spurious %d fixed %d", __entry->vcpu_id,
+		  " new %llx ret %d", __entry->vcpu_id,
 		  __entry->cr2_or_gpa, __print_flags(__entry->error_code, "|",
 		  kvm_mmu_trace_pferr_flags), __entry->sptep,
-		  __entry->old_spte, __entry->new_spte,
-		  __spte_satisfied(old_spte), __spte_satisfied(new_spte)
-	)
+		  __entry->old_spte, __entry->new_spte, __entry->retry)
 );
 
 TRACE_EVENT(
-- 
2.24.1

