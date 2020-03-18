Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D23A3C10DCE
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id AACAB20753
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 17:18:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WpYlUaFn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727132AbgCRRSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 18 Mar 2020 13:18:04 -0400
Received: from us-smtp-delivery-74.mimecast.com ([216.205.24.74]:55630 "EHLO
        us-smtp-delivery-74.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727069AbgCRRSB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 Mar 2020 13:18:01 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1584551879;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CuFclgdlUZIfeKH6zTx3SlLSiEPACrqlHVtYi2J2TNQ=;
        b=WpYlUaFnlWylZ513qp5TgFMbdYwe99EwASrSJhPJnuBT8teUpUL1laW9Zuxl5VzCTr0SLZ
        ihIGcSCy/Ko3yqrhKduOdBC/i0WrklBNDTwArU7abYGoI4oCcTMw4cefCA57aHOrmqDwaK
        h2jN0eO/kTIagYpxcJVAY/tjTJJt5AA=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-169-mdFErFsAPR2d9o3kLb_gEQ-1; Wed, 18 Mar 2020 13:17:58 -0400
X-MC-Unique: mdFErFsAPR2d9o3kLb_gEQ-1
Received: by mail-wm1-f72.google.com with SMTP id s15so1344598wmc.0
        for <linux-kernel@vger.kernel.org>; Wed, 18 Mar 2020 10:17:57 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=CuFclgdlUZIfeKH6zTx3SlLSiEPACrqlHVtYi2J2TNQ=;
        b=rK3Kea/NnVJG9D3vddIOjRxiReSxcpuZPxdnuk2C8q9VEf7uiwWZqO309ef5gtzAWy
         eeSQMITIVIn9imrSEx1BPI5Uspo/zLYTWK8jaguj5ZeE5ryk436W6cWc4cBasPHvpsp4
         Y3Xou47EsLJVKpfbB/hCssLhTn9qbTuJNhNlEIhl/vAwA0QjqFxiF0hgzBJlNMhbC8sI
         LEfCp9szVX9hT/mXCfCoix3dt/7fXy+4DEIzzEnN5WG5k9MhWg/fHrIazL7FNdnFCMKR
         CiyqJ19nkRLOOa2JaBJ3oOyg5v7jUf05cS86schvxVH6TKerdkjiCWWfd7R/hXIrVgQe
         pMTQ==
X-Gm-Message-State: ANhLgQ2botdRDGM9f2/Ll/JD0csSLg6KiNwhaWfY/YWIkDbKRA6pfi2y
        juR77JyK3s45Vsv4gR9BtHESne5r6tZ6M3p7ONbCOl9zTGUdQvN+EYCdt1tw3c5yEJVO6Qt7NpF
        FoO0AeMJxwf59qHMFjMNxLTTL
X-Received: by 2002:a7b:c7d9:: with SMTP id z25mr6495673wmk.25.1584551876380;
        Wed, 18 Mar 2020 10:17:56 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vvLZDXsCkofLpkMC/8OH/AOs7wrSc1tcFIGLwrcu+GaQO7Kk/aiDF8sstgwLmu6SXzAqfxDMA==
X-Received: by 2002:a7b:c7d9:: with SMTP id z25mr6495646wmk.25.1584551876087;
        Wed, 18 Mar 2020 10:17:56 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id r3sm10531597wrw.76.2020.03.18.10.17.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 18 Mar 2020 10:17:55 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v4 1/2] KVM: VMX: rename 'kvm_area' to 'vmxon_region'
Date:   Wed, 18 Mar 2020 18:17:51 +0100
Message-Id: <20200318171752.173073-2-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20200318171752.173073-1-vkuznets@redhat.com>
References: <20200318171752.173073-1-vkuznets@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The name 'kvm_area' is misleading (as we have way too many areas which are
KVM related), what alloc_kvm_area()/free_kvm_area() functions really do is
allocate/free VMXON region for all CPUs. Rename accordingly.

No functional change intended.

Reviewed-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Krish Sadhukhan <krish.sadhukhan@oracle.com>
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index b447d66f44e6..f7ee7c31fe8c 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2622,7 +2622,7 @@ int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
 	return -ENOMEM;
 }
 
-static void free_kvm_area(void)
+static void free_vmxon_regions(void)
 {
 	int cpu;
 
@@ -2632,7 +2632,7 @@ static void free_kvm_area(void)
 	}
 }
 
-static __init int alloc_kvm_area(void)
+static __init int alloc_vmxon_regions(void)
 {
 	int cpu;
 
@@ -2641,7 +2641,7 @@ static __init int alloc_kvm_area(void)
 
 		vmcs = alloc_vmcs_cpu(false, cpu, GFP_KERNEL);
 		if (!vmcs) {
-			free_kvm_area();
+			free_vmxon_regions();
 			return -ENOMEM;
 		}
 
@@ -7804,7 +7804,7 @@ static __init int hardware_setup(void)
 
 	vmx_set_cpu_caps();
 
-	r = alloc_kvm_area();
+	r = alloc_vmxon_regions();
 	if (r)
 		nested_vmx_hardware_unsetup();
 	return r;
@@ -7815,7 +7815,7 @@ static __exit void hardware_unsetup(void)
 	if (nested)
 		nested_vmx_hardware_unsetup();
 
-	free_kvm_area();
+	free_vmxon_regions();
 }
 
 static bool vmx_check_apicv_inhibit_reasons(ulong bit)
-- 
2.25.1

