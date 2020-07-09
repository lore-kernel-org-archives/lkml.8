Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6608BC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:54:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33F5A20767
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:54:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SCKTlYrb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728059AbgGIOyV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 10:54:21 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:51040 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728042AbgGIOyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:54:17 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594306456;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=+OkhWN9XI/HC21/2OiJMRv96UCzqp2quwlazUkUpR+k=;
        b=SCKTlYrb8V9KlfwMHt/4ccuWUYbAKa2/YOulhF/eywjdg+/VUqkNQVxnEHAv3HT3rXjf+G
        vFJdVLSwCjbsbzskVDH/Ks5ZmGTcJ0F7xpiUE2bg+F7kpNU1SIZen1mFqs9Ag+Pa37UmH2
        4qDhWksVCiEQBOyDMhWXDqwxVbeCcCY=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-213-vqZ6nCWiO-62dSg3pNlpWQ-1; Thu, 09 Jul 2020 10:54:15 -0400
X-MC-Unique: vqZ6nCWiO-62dSg3pNlpWQ-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.phx2.redhat.com [10.5.11.12])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id A0B95100A8EB;
        Thu,  9 Jul 2020 14:54:13 +0000 (UTC)
Received: from vitty.brq.redhat.com (unknown [10.40.195.35])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 5B65E60E1C;
        Thu,  9 Jul 2020 14:54:10 +0000 (UTC)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     kvm@vger.kernel.org, Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Junaid Shahid <junaids@google.com>,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/9] KVM: nSVM: reset nested_run_pending upon nested_svm_vmrun_msrpm() failure
Date:   Thu,  9 Jul 2020 16:53:52 +0200
Message-Id: <20200709145358.1560330-4-vkuznets@redhat.com>
In-Reply-To: <20200709145358.1560330-1-vkuznets@redhat.com>
References: <20200709145358.1560330-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.79 on 10.5.11.12
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

WARN_ON_ONCE(svm->nested.nested_run_pending) in nested_svm_vmexit()
will fire if nested_run_pending remains '1' but it doesn't really
need to, we are already failing and not going to run nested guest.

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/svm/nested.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index e424bce13e6c..1cc8592b1820 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -468,6 +468,8 @@ int nested_svm_vmrun(struct vcpu_svm *svm)
 	enter_svm_guest_mode(svm, vmcb_gpa, nested_vmcb);
 
 	if (!nested_svm_vmrun_msrpm(svm)) {
+		svm->nested.nested_run_pending = 0;
+
 		svm->vmcb->control.exit_code    = SVM_EXIT_ERR;
 		svm->vmcb->control.exit_code_hi = 0;
 		svm->vmcb->control.exit_info_1  = 0;
-- 
2.25.4

