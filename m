Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84449C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:28:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 53CB020758
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 08:28:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DLU84uJd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729211AbgGMI2c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 04:28:32 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:35906 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725969AbgGMI2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 04:28:31 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594628910;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cIVJYQhIpifvTCGZmpKQQdeFjrTfPoBTFkOF8KrjRCM=;
        b=DLU84uJd1fi7UvCrIuinp9rDBNCTyTk/BF+6oR2WM8JviCXFGYCNYRh5an/naTbmPXEtHS
        Orr0dBVlqqReSvKj+9Hl7J1YSfHYptd8xc4jTrkGpsYvXorTIdqbYBPp81fEVCrjM8vTn6
        q6TNT3aYi00XKR5VyHTy+vbOb7Yi0EY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-505-IKgZPjexM-WDI03LeWkHQg-1; Mon, 13 Jul 2020 04:28:28 -0400
X-MC-Unique: IKgZPjexM-WDI03LeWkHQg-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 88EE01902EA8;
        Mon, 13 Jul 2020 08:28:27 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.194.161])
        by smtp.corp.redhat.com (Postfix) with ESMTP id A991D60C84;
        Mon, 13 Jul 2020 08:28:25 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: nVMX: properly pad struct kvm_vmx_nested_state_hdr
Date:   Mon, 13 Jul 2020 10:28:24 +0200
Message-Id: <20200713082824.1728868-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Holes in structs which are userspace ABI are undesireable.

Fixes: 83d31e5271ac ("KVM: nVMX: fixes for preemption timer migration")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 Documentation/virt/kvm/api.rst  | 2 +-
 arch/x86/include/uapi/asm/kvm.h | 2 +-
 2 files changed, 2 insertions(+), 2 deletions(-)

diff --git a/Documentation/virt/kvm/api.rst b/Documentation/virt/kvm/api.rst
index 320788f81a05..7beccda11978 100644
--- a/Documentation/virt/kvm/api.rst
+++ b/Documentation/virt/kvm/api.rst
@@ -4345,7 +4345,7 @@ Errors:
 	struct {
 		__u16 flags;
 	} smm;
-
+	__u16 pad;
 	__u32 flags;
 	__u64 preemption_timer_deadline;
   };
diff --git a/arch/x86/include/uapi/asm/kvm.h b/arch/x86/include/uapi/asm/kvm.h
index 0780f97c1850..aae3df1cbd01 100644
--- a/arch/x86/include/uapi/asm/kvm.h
+++ b/arch/x86/include/uapi/asm/kvm.h
@@ -414,7 +414,7 @@ struct kvm_vmx_nested_state_hdr {
 	struct {
 		__u16 flags;
 	} smm;
-
+	__u16 pad;
 	__u32 flags;
 	__u64 preemption_timer_deadline;
 };
-- 
2.25.4

