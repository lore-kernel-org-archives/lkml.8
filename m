Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57144C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:21:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1B4402075F
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 17:21:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Nt1GIeMw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727044AbgETRVw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 13:21:52 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:33370 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726436AbgETRVv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 13:21:51 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1589995311;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:in-reply-to:in-reply-to:references:references;
        bh=WrBR4w78uBBs4VQ3VrdJAzQ/9ZZhP1UKmnG9BOpHw14=;
        b=Nt1GIeMwWsE/Gy86bi6nYa7LBGB/H8I58kZH6Nns5IXWAfOVi9ihX0m9V6nVYSCzHSWFyT
        Xj80PwQ5LoFAMkw9eEYA+1zA+cc/XqpUEatfHSXR7RcnEASZKc/lQWrvwWy9AyfZynI3wC
        yR46IusMGZWy/Rot9PDxaLX05djDsKs=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-78-Z5e_C_Z6Obud2Kubqpe_6Q-1; Wed, 20 May 2020 13:21:48 -0400
X-MC-Unique: Z5e_C_Z6Obud2Kubqpe_6Q-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.phx2.redhat.com [10.5.11.13])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 80443A0BE6;
        Wed, 20 May 2020 17:21:47 +0000 (UTC)
Received: from virtlab511.virt.lab.eng.bos.redhat.com (virtlab511.virt.lab.eng.bos.redhat.com [10.19.152.198])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 0434E60610;
        Wed, 20 May 2020 17:21:46 +0000 (UTC)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     vkuznets@redhat.com, Joerg Roedel <jroedel@suse.de>,
        stable@vger.kernel.org
Subject: [PATCH 01/24] KVM: nSVM: fix condition for filtering async PF
Date:   Wed, 20 May 2020 13:21:22 -0400
Message-Id: <20200520172145.23284-2-pbonzini@redhat.com>
In-Reply-To: <20200520172145.23284-1-pbonzini@redhat.com>
References: <20200520172145.23284-1-pbonzini@redhat.com>
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.13
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Async page faults have to be trapped in the host (L1 in this case),
since the APF reason was passed from L0 to L1 and stored in the L1 APF
data page.  This was completely reversed: the page faults were passed
to the guest, a L2 hypervisor.

Cc: stable@vger.kernel.org
Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index a89a166d1cb8..f4cd2d0cc360 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -880,8 +880,8 @@ int nested_svm_exit_special(struct vcpu_svm *svm)
 			return NESTED_EXIT_HOST;
 		break;
 	case SVM_EXIT_EXCP_BASE + PF_VECTOR:
-		/* When we're shadowing, trap PFs, but not async PF */
-		if (!npt_enabled && svm->vcpu.arch.apf.host_apf_reason == 0)
+		/* Trap async PF even if not shadowing */
+		if (!npt_enabled || svm->vcpu.arch.apf.host_apf_reason)
 			return NESTED_EXIT_HOST;
 		break;
 	default:
-- 
2.18.2


