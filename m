Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90E54C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:51:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6188C21741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 02:51:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="I2AXZZfo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727917AbgBECvP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 21:51:15 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40237 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1727879AbgBECvO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 21:51:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580871073;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=aRATN7sKWcZdWDij4U02uLG0iob0fByx2e0Dt2ueT/w=;
        b=I2AXZZfoX99vnHiHcHtN3l+ViG872DF16LzVWjiHBjYlwedKj4TIy5cH0gNfX9DrMOVahB
        bR94Lvp33FLtvy9WSwqTh7WrTt3SNn2cu7HRhuyab/xKsjX8Ao1UAh4haht7KUPNoL1Yk7
        lsM0FQnhdvXxBpddckCL+iUHBYSNzUI=
Received: from mail-qk1-f199.google.com (mail-qk1-f199.google.com
 [209.85.222.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-200-2u4ua9vKNOyW0udBtgJRRA-1; Tue, 04 Feb 2020 21:51:12 -0500
X-MC-Unique: 2u4ua9vKNOyW0udBtgJRRA-1
Received: by mail-qk1-f199.google.com with SMTP id z21so382765qki.18
        for <linux-kernel@vger.kernel.org>; Tue, 04 Feb 2020 18:51:12 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=aRATN7sKWcZdWDij4U02uLG0iob0fByx2e0Dt2ueT/w=;
        b=luZ+lFnwKw4jBOzPZ3hoTQ1aAJ94Oyb2CPIyby8tPQXmvFJVU6LUIrAAA0fHHq+nti
         rgLRilhNBd4Ah4BpscrSjxmIpmz/48keSSMQn2aUEah0CbucB0vKD7wefBp53RG0d3Ne
         BRfBngRDC+9d3UBzZHjqr+wxdiH/A7rbpP+jDuusAT5DQ7fj6J9FasU4vdKoAOnnyz9M
         SRsj0nHD8kdcQHF7fupC4kITiNbIhrBqskkr0BG+gAHM1IZH/V3dR0QO957o7UeZOor1
         f7GqtIHj7dce2udVhj/pUD8H8+iAHrAPbvOacNd9FGOJ/W49SbrvDz29bwWZl32kx3a2
         hbyw==
X-Gm-Message-State: APjAAAVg92lEfLCa7IEBlBmAxoXOcNx9JGYQ9UPik03Gwwj65EBBSbPd
        Kgiq153NfATnnKJ0ShG27RH5vURbRA8CgelFjqu6895nTxPmGDy8OCK0/CW0VqmHBFj3gPAR5V6
        nkNpDc+29aRtgEhOpkzpe6568
X-Received: by 2002:a05:6214:1428:: with SMTP id o8mr31031711qvx.87.1580871071592;
        Tue, 04 Feb 2020 18:51:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqwXJBNvuIFypmIVFhWk564W4B95sKGIgajPPJbgokUyyK+XPEQ6Y2igS687dPfdxxOzpb45IA==
X-Received: by 2002:a05:6214:1428:: with SMTP id o8mr31031696qvx.87.1580871071387;
        Tue, 04 Feb 2020 18:51:11 -0800 (PST)
Received: from xz-x1.redhat.com ([2607:9880:19c8:32::2])
        by smtp.gmail.com with ESMTPSA id b141sm12380923qkg.33.2020.02.04.18.51.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Feb 2020 18:51:10 -0800 (PST)
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
Subject: [PATCH v4 01/14] KVM: X86: Change parameter for fast_page_fault tracepoint
Date:   Tue,  4 Feb 2020 21:50:52 -0500
Message-Id: <20200205025105.367213-2-peterx@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200205025105.367213-1-peterx@redhat.com>
References: <20200205025105.367213-1-peterx@redhat.com>
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
index 3c6522b84ff1..456371406d2a 100644
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

