Return-Path: <SRS0=NmTw=4N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00471C35DF5
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:54:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A15A72082F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Feb 2020 07:54:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YTYL8An1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729649AbgBYHyo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Feb 2020 02:54:44 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:33025 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729124AbgBYHyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Feb 2020 02:54:44 -0500
Received: by mail-wr1-f66.google.com with SMTP id u6so13493643wrt.0;
        Mon, 24 Feb 2020 23:54:41 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id;
        bh=glUb0AVNqIpQp8+EfyRlMJSV0T1LLIsDxr1f5R3n23U=;
        b=YTYL8An11i8aSQf4sKTgmdrYyR/dfGa7Qb4DGS30HCSWAGdmP6sqwYbaY5w4pUZX+F
         Ec6ikdtNmWhcTq/N+bmYyyZ1WRW+zzp78RFs4b8G+Lz2KRhAfbPwzHLmXVf1FaWsrEtT
         VJEV4OS4ufJtYQxfy8IPaOiu5Ip2GnUCa1YNWQav4ACHz87iO0fKZFRF5O5w2k1Dd87C
         Rxq0y7dJazr6QECY9uHJPnHVzVgevDcTR6tFVW6q3cjXO/YoVhf97gmx9gvb4RcvWjrQ
         lZL2Ucet2AtaBLUOowGCvamH6V3o4qa5dsfI27WVZLDRw+XZH/EoUzWVRk+ucD8IN54F
         AgGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id;
        bh=glUb0AVNqIpQp8+EfyRlMJSV0T1LLIsDxr1f5R3n23U=;
        b=Nq6MFql861USCwm4Se+vLaLNhFTVDy6QoQ6HTyO42dELahXQoQu3fjg4qpuHzB1Blh
         jqHrfF8PKot07bntHZQYBhn9kd6BsBsgp+GGHe6TocmfUNU4q/hswlwhl9u4VZp+KPEG
         nn9k17z8Q5/lkWFUW+ewnkVMjHYIZrWqEt9t3ahYKzcbb/J1/bBM2s0xsQNVccU+olzX
         MksbG27gS59BeUO4q5Cd9WmDOku1a/9yUhk8tATBozLD3S5DEy7dFhzQl7GQDjIXKQAd
         6hSiW/E56qDVRrNqZltXk8Daud61IUp121ORtn9WzBOVdPvcx1upbFY+KRcZm8bamiIC
         ynDQ==
X-Gm-Message-State: APjAAAWEKjMFK6u1sCKmxE3Lwiny6xzGi7rUsOSdxlahgCaRZF1JAiub
        zcga6L3Ra+G1sXaaKBXkqqL73AhK
X-Google-Smtp-Source: APXvYqxYAvZdflOr+QOEBUCYEa0kDK0vl0sue/gFMGZ5Lf7uq4GAJAyhiCqUv9BjOM94QloItSr80w==
X-Received: by 2002:adf:fcc4:: with SMTP id f4mr75000995wrs.247.1582617280595;
        Mon, 24 Feb 2020 23:54:40 -0800 (PST)
Received: from 640k.lan ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id x7sm22177786wrq.41.2020.02.24.23.54.39
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 24 Feb 2020 23:54:39 -0800 (PST)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     rmuncrief@humanavance.com
Subject: [PATCH] KVM: SVM: allocate AVIC data structures based on kvm_amd moduleparameter
Date:   Tue, 25 Feb 2020 08:54:38 +0100
Message-Id: <1582617278-50338-1-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Even if APICv is disabled at startup, the backing page and ir_list need
to be initialized in case they are needed later.  The only case in
which this can be skipped is for userspace irqchip, and that must be
done because avic_init_backing_page dereferences vcpu->arch.apic
(which is NULL for userspace irqchip).

Tested-by: rmuncrief@humanavance.com
Fixes: https://bugzilla.kernel.org/show_bug.cgi?id=206579
Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm.c | 3 ++-
 1 file changed, 2 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index ad3f5b178a03..bd02526300ab 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -2194,8 +2194,9 @@ static void svm_vcpu_reset(struct kvm_vcpu *vcpu, bool init_event)
 static int avic_init_vcpu(struct vcpu_svm *svm)
 {
 	int ret;
+	struct kvm_vcpu *vcpu = &svm->vcpu;
 
-	if (!kvm_vcpu_apicv_active(&svm->vcpu))
+	if (!avic || !irqchip_in_kernel(vcpu->kvm))
 		return 0;
 
 	ret = avic_init_backing_page(&svm->vcpu);
-- 
1.8.3.1

