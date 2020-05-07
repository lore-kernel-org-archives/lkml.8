Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91613C38A2A
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:50:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 733FD20735
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 11:50:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="eJqf8CTe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726884AbgEGLuW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 07:50:22 -0400
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:42880 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726627AbgEGLuU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 07:50:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588852219;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=mr9x5PJcF7Hzoh5oRRsXaOLTGqKm4KfDRv0S4QUsVzI=;
        b=eJqf8CTeHlVUZ58xbdhGFmortIGfVjZkeU8I04Mompla3Ecqd5ZmfIrcsFo0aTLkq3OA5P
        Ufz8B7lY+m0im70Th9ICLDvqvO/W2GEM5bA+wx4osWLoxzr7kdv/Hhqm1z7xcnP0JeTkDp
        gY7+K/kc5a/vl4TPRlyXU4DNm+T15V8=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-245-ggF9kNepNlSWuSdOI7IL8A-1; Thu, 07 May 2020 07:50:17 -0400
X-MC-Unique: ggF9kNepNlSWuSdOI7IL8A-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 7CE481895A28;
        Thu,  7 May 2020 11:50:16 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 205221C933;
        Thu,  7 May 2020 11:50:16 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     peterx@redhat.com
Subject: [PATCH v2 3/9] KVM: X86: Set RTM for DB_VECTOR too for KVM_EXIT_DEBUG
Date:   Thu,  7 May 2020 07:50:05 -0400
Message-Id: <20200507115011.494562-4-pbonzini@redhat.com>
In-Reply-To: <20200507115011.494562-1-pbonzini@redhat.com>
References: <20200507115011.494562-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Peter Xu <peterx@redhat.com>

RTM should always been set even with KVM_EXIT_DEBUG on #DB.

Signed-off-by: Peter Xu <peterx@redhat.com>
Message-Id: <20200505205000.188252-2-peterx@redhat.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index bb5a527e49d9..2384a2dbec44 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -4683,7 +4683,7 @@ static int handle_exception_nmi(struct kvm_vcpu *vcpu)
 			kvm_queue_exception_p(vcpu, DB_VECTOR, dr6);
 			return 1;
 		}
-		kvm_run->debug.arch.dr6 = dr6 | DR6_FIXED_1;
+		kvm_run->debug.arch.dr6 = dr6 | DR6_FIXED_1 | DR6_RTM;
 		kvm_run->debug.arch.dr7 = vmcs_readl(GUEST_DR7);
 		/* fall through */
 	case BP_VECTOR:
-- 
2.18.2


