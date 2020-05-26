Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A02BAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:23:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7131120723
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 17:23:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="HHFrg6pa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388913AbgEZRXO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 13:23:14 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:50519 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S2388606AbgEZRXO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 13:23:14 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590513793;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zsEdUKbb64cuYor8Oe940GH4M856nl/MDSfp4PY7VdM=;
        b=HHFrg6pahuuMKDFSPKS1YAXWRNne20bpspXYICCjdWvwdoNBpNuV7tFN6ioPrhudeU+GJl
        heXEugvYHi8iNJGEXLZxqHfoxhbuiYD0Q4U71KetVRNh0Sa8tgYrFl9bWMTbyaS5OOASnE
        xHbc6t1Fg+swFzTYqK00Mi1cLt1VeYU=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-166-tDkVSMwVPNyrTROUAdq4iA-1; Tue, 26 May 2020 13:23:11 -0400
X-MC-Unique: tDkVSMwVPNyrTROUAdq4iA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 41CBB835B43;
        Tue, 26 May 2020 17:23:10 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 9F2441001B07;
        Tue, 26 May 2020 17:23:09 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com, mlevitsk@redhat.com,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Jim Mattson <jmattson@google.com>
Subject: [PATCH 01/28] KVM: x86: track manually whether an event has been injected
Date:   Tue, 26 May 2020 13:22:41 -0400
Message-Id: <20200526172308.111575-2-pbonzini@redhat.com>
In-Reply-To: <20200526172308.111575-1-pbonzini@redhat.com>
References: <20200526172308.111575-1-pbonzini@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Instead of calling kvm_event_needs_reinjection, track its
future return value in a variable.  This will be useful in
the next patch.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c | 17 ++++++++++++-----
 1 file changed, 12 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index b226fb8abe41..064a7ea0e671 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -7713,11 +7713,14 @@ static void update_cr8_intercept(struct kvm_vcpu *vcpu)
 static int inject_pending_event(struct kvm_vcpu *vcpu)
 {
 	int r;
+	bool can_inject = true;
 
 	/* try to reinject previous events if any */
 
-	if (vcpu->arch.exception.injected)
+	if (vcpu->arch.exception.injected) {
 		kvm_x86_ops.queue_exception(vcpu);
+		can_inject = false;
+	}
 	/*
 	 * Do not inject an NMI or interrupt if there is a pending
 	 * exception.  Exceptions and interrupts are recognized at
@@ -7733,10 +7736,13 @@ static int inject_pending_event(struct kvm_vcpu *vcpu)
 	 * fully complete the previous instruction.
 	 */
 	else if (!vcpu->arch.exception.pending) {
-		if (vcpu->arch.nmi_injected)
+		if (vcpu->arch.nmi_injected) {
 			kvm_x86_ops.set_nmi(vcpu);
-		else if (vcpu->arch.interrupt.injected)
+			can_inject = false;
+		} else if (vcpu->arch.interrupt.injected) {
 			kvm_x86_ops.set_irq(vcpu);
+			can_inject = false;
+		}
 	}
 
 	WARN_ON_ONCE(vcpu->arch.exception.injected &&
@@ -7786,10 +7792,11 @@ static int inject_pending_event(struct kvm_vcpu *vcpu)
 		}
 
 		kvm_x86_ops.queue_exception(vcpu);
+		can_inject = false;
 	}
 
-	/* Don't consider new event if we re-injected an event */
-	if (kvm_event_needs_reinjection(vcpu))
+	/* Finish re-injection before considering new events */
+	if (!can_inject)
 		return 0;
 
 	if (vcpu->arch.smi_pending &&
-- 
2.26.2


