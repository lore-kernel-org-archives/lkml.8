Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3C753C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:00:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 16DD820738
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 12:00:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="exF4SfdS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726133AbgFAMAI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 08:00:08 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:40791 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725974AbgFAMAH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 08:00:07 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1591012805;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Ble7s/BrlGwUPRHQ34ii4/VsZgKqdI5xssnXt1KNNb0=;
        b=exF4SfdSq8NUWQ83LTtCdVb9np64EW8+TEyiE3V8aOWFTJowp8bBHYLBm9KcW3Nttq9eYh
        y1o9Q/NOieGE5UivGK4UnjIR6jNzZWQhfrpDUb5QuDAOHUsoGuEkFfzPs2gwiXIMxF5kVg
        R9FSfKxBjK7Gd+F8LNs+kEffjwuT0WU=
Received: from mail-qk1-f197.google.com (mail-qk1-f197.google.com
 [209.85.222.197]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-216-TE7IMeECOyKK7-olAGgZKQ-1; Mon, 01 Jun 2020 08:00:04 -0400
X-MC-Unique: TE7IMeECOyKK7-olAGgZKQ-1
Received: by mail-qk1-f197.google.com with SMTP id h18so6328449qkj.13
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 05:00:04 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Ble7s/BrlGwUPRHQ34ii4/VsZgKqdI5xssnXt1KNNb0=;
        b=KbWddccrpE5HMv/i3BFSHI7FBmeIcOAVojZJ4Vl+nPlTw7JfSGuoLizJ0V5JWev90t
         yIGIB5ICtw/AGjXFUY1+WsRyEpIECqgYGux9lVs62hOwu/wQKYQTqseGeg+dHGoMcQRW
         u/d8guw/iSOminIDQAvhI9+r7BVgPJ02ZNHuhj9RmoKc/YHbnmNmX4b1vhLM/hMa41FJ
         w0H137jO4isA/l4LgXMUCT6PvQ35Oz9SNyfFLejrmKvcMD3hQ4hUAS+9E0gVpfd23tQo
         z8rmPSLHSBPCez33V3ds07b5G47hFrjJls4pSFStspn2XGjkImdP+beCgqjKeeRUnz+U
         cWhw==
X-Gm-Message-State: AOAM531VMnts1Pbfeu0IwIBK4v575SyQ8gZeAJRAFZeCICv1YkbLUh9g
        4y/r+Iqo69jVc7pf0KavShRlBftUKySY8yKE71BB0/gqhWI62N726A+8netYIv+nuU5g1kdztcl
        MwlkmfG0QNlCcN4XMjkE8m8LC
X-Received: by 2002:a05:6214:1925:: with SMTP id es5mr6763765qvb.165.1591012803599;
        Mon, 01 Jun 2020 05:00:03 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx1IzJyVR4DX6Bk9zy7p1HwJtJsrkQD4MdK4Y0U0kfd9WqtIBE8ch0XnsLCcU23iyKC/g0N/Q==
X-Received: by 2002:a05:6214:1925:: with SMTP id es5mr6763743qvb.165.1591012803378;
        Mon, 01 Jun 2020 05:00:03 -0700 (PDT)
Received: from xz-x1.redhat.com ([2607:9880:19c0:32::2])
        by smtp.gmail.com with ESMTPSA id l9sm14474185qki.90.2020.06.01.05.00.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 01 Jun 2020 05:00:02 -0700 (PDT)
From:   Peter Xu <peterx@redhat.com>
To:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        Andrew Jones <drjones@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        "Michael S . Tsirkin" <mst@redhat.com>,
        Jason Wang <jasowang@redhat.com>, peterx@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Kevin Tian <kevin.tian@intel.com>
Subject: [PATCH v10 01/14] KVM: X86: Change parameter for fast_page_fault tracepoint
Date:   Mon,  1 Jun 2020 07:59:44 -0400
Message-Id: <20200601115957.1581250-2-peterx@redhat.com>
X-Mailer: git-send-email 2.26.2
In-Reply-To: <20200601115957.1581250-1-peterx@redhat.com>
References: <20200601115957.1581250-1-peterx@redhat.com>
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

