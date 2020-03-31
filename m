Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2FD63C2D0EE
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:00:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 05E2B207FF
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 19:00:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TQun+8Nh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgCaTAP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 15:00:15 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:32381 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726315AbgCaTAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 15:00:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585681213;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zL6sq31OFwBXF/RS7PK1GArrpq69jRR45bepTSw46TU=;
        b=TQun+8NhAq1PpIPEU53hEp6FWw2VJubHMGffXBLPsY660keNZS0Gf61vCObo2GSFzru+eA
        Tnb1hmazv9matW0QMrHj/E3BHroE+ow48K8BVaSssH6GH5cAZ4jnb5Ib3Df7aAJ1qr/xOp
        jqbuXkdixeEA1ygeyk947GjcJKYDoec=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-206-QtQk7B1SOQuKhOUygkqzEA-1; Tue, 31 Mar 2020 15:00:11 -0400
X-MC-Unique: QtQk7B1SOQuKhOUygkqzEA-1
Received: by mail-wr1-f72.google.com with SMTP id h14so13345508wrr.12
        for <linux-kernel@vger.kernel.org>; Tue, 31 Mar 2020 12:00:11 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zL6sq31OFwBXF/RS7PK1GArrpq69jRR45bepTSw46TU=;
        b=BI9fNvfJgrbUN5Yes4oycbSa96Qxmj1H0FxmxHXf8XcCkC4SvEjC2MctTk3k+HcqGf
         QLCmoy4+npyh3f3EY0qwbViqTr+EoOUwrfzDeqGKGfRFW5Tx7Knq6nKEnJQBND4sEn5r
         9HH2o7RN55wo20Clvla3YhHwdAp1UNYIu3dvl2WIYRJLTsee95NTY9v3lCJsAQmhMH6q
         qNz1G7FY+ST0IwBDzNFpRGrmDOtF3tE7Rs4oHBI1NPXs886c6Dlu2bcLg/S2b0e6sXHE
         ym/UXrISDBjoTsWYH1M5nO91p/Xi+n197zfJ4DtwpqJZXS4uxDgR7UnyuETMo/5sUT9w
         8/xQ==
X-Gm-Message-State: ANhLgQ3Zx6n9TfmM9ezu+h3iy8CslQxeIqUPBnGGiUOqKTqsGQyDYBvc
        EPh5lTVjPwmUBN1MVF0/fZU9TQpa90R4sC2Fj07UOEdE8crcW6uAFXSMHnIClLKkP6OUqMd5+k/
        oGZ4pHuNd807G6b+bM8kIISI6
X-Received: by 2002:adf:b186:: with SMTP id q6mr21784786wra.253.1585681209646;
        Tue, 31 Mar 2020 12:00:09 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vuw1mD28p3JHof9YrDOHCb6+VgxgT119t2q54QLWIHZ0l4+T/QIDJWlvKoTTEJJxE9mpkLKdQ==
X-Received: by 2002:adf:b186:: with SMTP id q6mr21784753wra.253.1585681209403;
        Tue, 31 Mar 2020 12:00:09 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id h10sm29018467wrq.33.2020.03.31.12.00.07
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 31 Mar 2020 12:00:08 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Kevin Tian <kevin.tian@intel.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Christophe de Dinechin <dinechin@redhat.com>,
        Yan Zhao <yan.y.zhao@intel.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>, peterx@redhat.com
Subject: [PATCH v8 01/14] KVM: X86: Change parameter for fast_page_fault tracepoint
Date:   Tue, 31 Mar 2020 14:59:47 -0400
Message-Id: <20200331190000.659614-2-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200331190000.659614-1-peterx@redhat.com>
References: <20200331190000.659614-1-peterx@redhat.com>
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

