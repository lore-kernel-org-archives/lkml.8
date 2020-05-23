Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5250EC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 22:57:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1CAB6207CB
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 22:57:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="APi2ovGc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388111AbgEWW5K (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 18:57:10 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:33013 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388034AbgEWW5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 18:57:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590274628;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ble7s/BrlGwUPRHQ34ii4/VsZgKqdI5xssnXt1KNNb0=;
        b=APi2ovGcRjqjG8invipb/xDS1MLzuVdObIhINsWp7OIDh4g3Ub9Ffv4mz0rQmhL4kDHW4t
        RSYiDXvme2VKjPLHiWMzJPMthuMT2TKphgfuIRaagr7RQtPQj3seDY24wTC8ixk4lKfmvT
        yK920OsdEc+CvndaHKDsIWvd11gOEl8=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-418-EJld0N2SOheB2XlZgQZSLw-1; Sat, 23 May 2020 18:57:06 -0400
X-MC-Unique: EJld0N2SOheB2XlZgQZSLw-1
Received: by mail-qt1-f199.google.com with SMTP id s65so15822384qtd.21
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 15:57:06 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ble7s/BrlGwUPRHQ34ii4/VsZgKqdI5xssnXt1KNNb0=;
        b=qiD9hktKHD+ET/Qz91EI9EOodoMjdcsCfWeKEyGorW0lzyZTUoOILbYFIve7cWyrMf
         0yCSQk/WlLwZol3qs1KFhmRVK/pm0WGnF6m8zc6BLsiqkdtqeGSq7BFAReH+7qERsU5G
         B/N6VKfeplz81zv1VGYmSb0P012ec4Y85zyZePDwb8xT9FeLLqdDakErVSR8RWayD8bY
         0DC+OAo9mL3BprsXXIFdozt4j4UqKcGVz4IU7gczTwKB9H2flsSyHoJekOXZhgSCqOGF
         SULx9nBvOSNg52ZnHShueBbtVXmI5SeHP7bN0rU6E3Z40BVol5hCRa6LCKOtVe8JW6Es
         eDHw==
X-Gm-Message-State: AOAM532n3LApVK79h4IxvUWeoFqBSW68CdqvfH33QOLqBN+51akolh5A
        ES03s4VyMQEozndwv4jnYWCqQA2UxAUIuYuFkuR8zL7DcmafngJtR8D3JBfWs9evgQN8Odx9Yk0
        uHxDxYw1nptDFYcsM0FDEwjw5
X-Received: by 2002:ac8:4a88:: with SMTP id l8mr21356370qtq.337.1590274625497;
        Sat, 23 May 2020 15:57:05 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzyfZidmD/ZSQV5cbmCS0RnT9AdYlS2aPMYmebfucXy9aWDUoU3As8I7YtAnly5gG9nM+kp4g==
X-Received: by 2002:ac8:4a88:: with SMTP id l8mr21356349qtq.337.1590274625276;
        Sat, 23 May 2020 15:57:05 -0700 (PDT)
Received: from xz-x1.hitronhub.home (CPEf81d0fb19163-CMf81d0fb19160.cpe.net.fido.ca. [72.137.123.47])
        by smtp.gmail.com with ESMTPSA id w14sm11630979qtt.82.2020.05.23.15.57.03
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 15:57:04 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>, peterx@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Yan Zhao <yan.y.zhao@intel.com>
Subject: [PATCH v9 01/14] KVM: X86: Change parameter for fast_page_fault tracepoint
Date:   Sat, 23 May 2020 18:56:46 -0400
Message-Id: <20200523225659.1027044-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200523225659.1027044-1-peterx@redhat.com>
References: <20200523225659.1027044-1-peterx@redhat.com>
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
2.26.2

