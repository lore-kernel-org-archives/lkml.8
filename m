Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4911C10F29
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:44:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ACD3D24649
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 21:44:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="PFqG5EoC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727111AbgCIVoe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 17:44:34 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:37488 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726536AbgCIVod (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 17:44:33 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583790272;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zL6sq31OFwBXF/RS7PK1GArrpq69jRR45bepTSw46TU=;
        b=PFqG5EoC0uX1BIn2GRxaiLxkhT7N6VDDbtmW3ZBB8oKdUuzLWEV7LCL1274UsMnBp5nllY
        gbtNWSB4FpLUbT9WMkCumjnUjHEdbWja2wXmg1pOxkGq+evza8+OMYXK+KBrOyqqj16e5G
        CiED/rp5ZoRIrGyR20LYj/2rcKczaYI=
Received: from mail-qv1-f69.google.com (mail-qv1-f69.google.com
 [209.85.219.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-X_uYKjuPM52V9W-Ybet6dg-1; Mon, 09 Mar 2020 17:44:31 -0400
X-MC-Unique: X_uYKjuPM52V9W-Ybet6dg-1
Received: by mail-qv1-f69.google.com with SMTP id z39so7686970qve.5
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 14:44:31 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zL6sq31OFwBXF/RS7PK1GArrpq69jRR45bepTSw46TU=;
        b=hI/vaeZUZNDgoxwcc4/Oq/F/2VfXW5kzt5GjvS++nJB7h/UPse+SH4MN66kDvb95Az
         nNiIBhXP6g7PK8RxYZwh5jl05ls/mlZ7eSaetpIVt+CYxN27TlS3oPKAkGNXZ/d9ulKW
         lIaY9HOtwERafcZSWS9Bk9nUY6a4B5qbVxkN5PxYagntAxw2q0SXOSrsL1AIUzO35lzC
         CXS+H1fDyvM7xNJtRpsuJJbHb20cy79XfusYUTkjui2ScGOIKZu4wNW/7SOdjRZKDOrP
         +70F30UK5Y9XPZdfFdsnyo2Z8nD2xBzjp7zMGUFD4Evg6e6fFdOzOEDlA0FMTTxh9P/P
         UqWQ==
X-Gm-Message-State: ANhLgQ1ErkSp8c8VbYUoDAA8zndAIolwSJWar3ZSkL75CPMv9uLKi4I1
        4mg4XWyC5+miQ1BItqov/nn/bTx7OZbtKXJDK5suaY3jrIkT1tRtEeLGKL9S/D+YHZv9cjuoTXm
        9HS1Hw3ccvpNvHHu+yBYFWYJ0
X-Received: by 2002:ac8:7613:: with SMTP id t19mr15821443qtq.203.1583790270264;
        Mon, 09 Mar 2020 14:44:30 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vtNsKwrUcoUekUZLm7aMwtJB3yh7uevNGAMIN8cX3luE4VyH2NbSx/AJmszLvjz/oRxyaNn7A==
X-Received: by 2002:ac8:7613:: with SMTP id t19mr15821436qtq.203.1583790270038;
        Mon, 09 Mar 2020 14:44:30 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id 65sm22758686qtc.4.2020.03.09.14.44.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 09 Mar 2020 14:44:29 -0700 (PDT)
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
Subject: [PATCH v6 01/14] KVM: X86: Change parameter for fast_page_fault tracepoint
Date:   Mon,  9 Mar 2020 17:44:11 -0400
Message-Id: <20200309214424.330363-2-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200309214424.330363-1-peterx@redhat.com>
References: <20200309214424.330363-1-peterx@redhat.com>
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

