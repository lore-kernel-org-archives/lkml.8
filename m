Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B673CC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:35:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 89D3F206A5
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 11:35:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="CHn4Sv/w"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728841AbgEELe7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 07:34:59 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:47971 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728233AbgEELe7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 07:34:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588678498;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc; bh=kf2bz/b6u5ATikbzlOoZD3Be2rrM+5Ro0erR1f3eNfM=;
        b=CHn4Sv/wqxmEiwMVmaxWj+9VDsDjKRvffZgQNr6fDxT38Y+NUjg7EyNyVMemtelNyZ90so
        QfnSDgPkOEJ7vPOANhdUJ9hmqrF3lJsgAt4fnEdYJmAiudRflQ61zJeWugipnMExtglU4R
        D/ncfVvkJOnDYQv/EeSvqQMq7Bx69Dc=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-339-TiiQpC0sMOaoVXL-Jk0a2Q-1; Tue, 05 May 2020 07:34:54 -0400
X-MC-Unique: TiiQpC0sMOaoVXL-Jk0a2Q-1
Received: from smtp.corp.redhat.com (int-mx06.intmail.prod.int.phx2.redhat.com [10.5.11.16])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 98682835B40;
        Tue,  5 May 2020 11:34:53 +0000 (UTC)
Received: from virtlab701.virt.lab.eng.bos.redhat.com (virtlab701.virt.lab.eng.bos.redhat.com [10.19.152.228])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5930A5C1B2;
        Tue,  5 May 2020 11:34:50 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     jmattson@google.com, peterx@redhat.com
Subject: [PATCH] KVM: x86: fix DR6 delivery for emulated hardware breakpoint
Date:   Tue,  5 May 2020 07:34:49 -0400
Message-Id: <20200505113449.18478-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.16
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Go through kvm_queue_exception_p so that the payload is correctly delivered
through the exit qualification, and add a kvm_update_dr6 call to
kvm_deliver_exception_payload that is needed on AMD.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/x86.c | 5 ++---
 1 file changed, 2 insertions(+), 3 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index c5835f9cb9ad..8f61cb15f147 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -473,6 +473,7 @@ void kvm_deliver_exception_payload(struct kvm_vcpu *vcpu)
 		 * breakpoint), it is reserved and must be zero in DR6.
 		 */
 		vcpu->arch.dr6 &= ~BIT(12);
+		kvm_update_dr6(vcpu);
 		break;
 	case PF_VECTOR:
 		vcpu->arch.cr2 = payload;
@@ -6731,9 +6732,7 @@ static bool kvm_vcpu_check_breakpoint(struct kvm_vcpu *vcpu, int *r)
 					   vcpu->arch.db);
 
 		if (dr6 != 0) {
-			vcpu->arch.dr6 &= ~DR_TRAP_BITS;
-			vcpu->arch.dr6 |= dr6 | DR6_RTM;
-			kvm_queue_exception(vcpu, DB_VECTOR);
+			kvm_queue_exception_p(vcpu, DB_VECTOR, dr6);
 			*r = 1;
 			return true;
 		}
-- 
2.18.2

