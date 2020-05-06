Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8683BC47256
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:11:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6361D208DB
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 16:11:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DneIpyOl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbgEFQLH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 12:11:07 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:26104 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730141AbgEFQLB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 12:11:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588781460;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=r4rhVilOhruX4XKG1ij307CAZ6f9s9Do/ND2GQqMS9Y=;
        b=DneIpyOlwc2b74RFAtueUpTMwytsRVUQpbG3ndMhZJkMkyXArWATtm+9NPQiqNkPETSK8Q
        moFdzxyZdUJPS7qajWDtMtPZDooUhM55fTxC4oDhcthCl20k+00WHlRRCTIufeGoG8fpGm
        TGz3M8avJZOBau+qUOKCTMEd4hiwVcM=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-bBD4DxCrOTqO_mJt42tz8Q-1; Wed, 06 May 2020 12:10:56 -0400
X-MC-Unique: bBD4DxCrOTqO_mJt42tz8Q-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id BA65145F;
        Wed,  6 May 2020 16:10:54 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id F0A27165F6;
        Wed,  6 May 2020 16:10:53 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     wanpengli@tencent.com, linxl3@wangsu.com,
        Haiwei Li <lihaiwei@tencent.com>
Subject: [PATCH 4/7] KVM: VMX: Optimize posted-interrupt delivery for timer fastpath
Date:   Wed,  6 May 2020 12:10:45 -0400
Message-Id: <20200506161048.28840-5-pbonzini@redhat.com>
In-Reply-To: <20200506161048.28840-1-pbonzini@redhat.com>
References: <20200506161048.28840-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

While optimizing posted-interrupt delivery especially for the timer
fastpath scenario, I measured kvm_x86_ops.deliver_posted_interrupt()
to introduce substantial latency because the processor has to perform
all vmentry tasks, ack the posted interrupt notification vector,
read the posted-interrupt descriptor etc.

This is not only slow, it is also unnecessary when delivering an
interrupt to the current CPU (as is the case for the LAPIC timer) because
PIR->IRR and IRR->RVI synchronization is already performed on vmentry
Therefore skip kvm_vcpu_trigger_posted_interrupt in this case, and
instead do vmx_sync_pir_to_irr() on the EXIT_FASTPATH_REENTER_GUEST
fastpath as well.

Tested-by: Haiwei Li <lihaiwei@tencent.com>
Cc: Haiwei Li <lihaiwei@tencent.com>
Suggested-by: Paolo Bonzini <pbonzini@redhat.com>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
Message-Id: <1588055009-12677-6-git-send-email-wanpengli@tencent.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 4 +++-
 virt/kvm/kvm_main.c    | 1 +
 2 files changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 215ae9682da1..b980481436e9 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -3928,7 +3928,8 @@ static int vmx_deliver_posted_interrupt(struct kvm_vcpu *vcpu, int vector)
 	if (pi_test_and_set_on(&vmx->pi_desc))
 		return 0;
 
-	if (!kvm_vcpu_trigger_posted_interrupt(vcpu, false))
+	if (vcpu != kvm_get_running_vcpu() &&
+	    !kvm_vcpu_trigger_posted_interrupt(vcpu, false))
 		kvm_vcpu_kick(vcpu);
 
 	return 0;
@@ -6803,6 +6804,7 @@ static fastpath_t vmx_vcpu_run(struct kvm_vcpu *vcpu)
 			 * but it would incur the cost of a retpoline for now.
 			 * Revisit once static calls are available.
 			 */
+			vmx_sync_pir_to_irr(vcpu);
 			goto reenter_guest;
 		}
 		exit_fastpath = EXIT_FASTPATH_EXIT_HANDLED;
diff --git a/virt/kvm/kvm_main.c b/virt/kvm/kvm_main.c
index 825d501df158..7f675d525981 100644
--- a/virt/kvm/kvm_main.c
+++ b/virt/kvm/kvm_main.c
@@ -4638,6 +4638,7 @@ struct kvm_vcpu *kvm_get_running_vcpu(void)
 
 	return vcpu;
 }
+EXPORT_SYMBOL_GPL(kvm_get_running_vcpu);
 
 /**
  * kvm_get_running_vcpus - get the per-CPU array of currently running vcpus.
-- 
2.18.2


