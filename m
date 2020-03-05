Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57DB0C3F2D8
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:01:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 30CA921556
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:01:35 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="EsYGBEqY"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727071AbgCEKBe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 05:01:34 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:53130 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725816AbgCEKBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 05:01:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583402491;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oswt/Kc8n1kZsUQ8QoQ1RiwQKyVHquWO2Ji98TMP3xg=;
        b=EsYGBEqYyVf499C/tgUyjCMd3+8a3HGAP7PQAj+sbSU+3SL3T+W/sJiSyLbasBuSKvJNsp
        eE2AKeXr0qHejbtV+/k7qloJWGVSSvUX1c5Rh8nPE1osRpkHIxd3pQf5Cx/eFQwJyg20fy
        tW/t/ZQTlwcNCeAUkuCyPkAvY4fAJ1s=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-298-tMadjH2gOu6jXfy2plFEqQ-1; Thu, 05 Mar 2020 05:01:28 -0500
X-MC-Unique: tMadjH2gOu6jXfy2plFEqQ-1
Received: by mail-wr1-f69.google.com with SMTP id w11so2074708wrp.20
        for <linux-kernel@vger.kernel.org>; Thu, 05 Mar 2020 02:01:27 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oswt/Kc8n1kZsUQ8QoQ1RiwQKyVHquWO2Ji98TMP3xg=;
        b=hD8G4+FJH0TD02qYA2969hrjsqaMYTcDXXql5v7k9ee/2wLhWZ1H3TJsJFihwv+U96
         gFxlwxGjJ8GyAvNjdHV37r6LRQKLKplOj8D2hp/bR84Nvjw19eUBPGPweX5LRGW1N2fD
         1VfhUwZ009Mr7BeHYGIhAxTEXDir5hbOMXXilGFFar20CHGSOb9EO8PoW0ng3sMH7BmY
         WXCzfplQRr7mdNo1Rr3JoSXaLDO+510bDDSAdqmVwuZfXyB6/ffACMrXseqCaPR9hOIa
         C699CDSDHgyHBt5CDaJEg101dvPWep38RuadyKYLrmsBlvUgh9YtbjhvqbDYxlOiDlzL
         f7XA==
X-Gm-Message-State: ANhLgQ3p6a6iAMCSYCGIHi48FoxWrvjvk5jT+CIUmokPfw2ZcdmcGHQ4
        fURm7pGQRAQMtJmFrpnw0PpeAhp8x5kD8H3zzqgKiKRwalozxz+5Ocqckn5rSGvmNLoddhv7W81
        Fp2z3eljxMBjwymh6S1FeERiA
X-Received: by 2002:a1c:ab07:: with SMTP id u7mr8242970wme.23.1583402486905;
        Thu, 05 Mar 2020 02:01:26 -0800 (PST)
X-Google-Smtp-Source: ADFU+vuBnaABVorkSgwKmJdmaxfU2FtG7PnSy504t3kXi28pQPtb3RflQXkq36d2TuSjUNI9iAwShg==
X-Received: by 2002:a1c:ab07:: with SMTP id u7mr8242950wme.23.1583402486722;
        Thu, 05 Mar 2020 02:01:26 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id f207sm10440025wme.9.2020.03.05.02.01.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 05 Mar 2020 02:01:25 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH 1/2] KVM: x86: VMX: rename 'kvm_area' to 'vmxon_region'
Date:   Thu,  5 Mar 2020 11:01:22 +0100
Message-Id: <20200305100123.1013667-2-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200305100123.1013667-1-vkuznets@redhat.com>
References: <20200305100123.1013667-1-vkuznets@redhat.com>
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

Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 40b1e6138cd5..dab19e4e5f2b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2635,7 +2635,7 @@ int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
 	return -ENOMEM;
 }
 
-static void free_kvm_area(void)
+static void free_vmxon_regions(void)
 {
 	int cpu;
 
@@ -2645,7 +2645,7 @@ static void free_kvm_area(void)
 	}
 }
 
-static __init int alloc_kvm_area(void)
+static __init int alloc_vmxon_regions(void)
 {
 	int cpu;
 
@@ -2654,7 +2654,7 @@ static __init int alloc_kvm_area(void)
 
 		vmcs = alloc_vmcs_cpu(false, cpu, GFP_KERNEL);
 		if (!vmcs) {
-			free_kvm_area();
+			free_vmxon_regions();
 			return -ENOMEM;
 		}
 
@@ -7815,7 +7815,7 @@ static __init int hardware_setup(void)
 			return r;
 	}
 
-	r = alloc_kvm_area();
+	r = alloc_vmxon_regions();
 	if (r)
 		nested_vmx_hardware_unsetup();
 	return r;
@@ -7826,7 +7826,7 @@ static __exit void hardware_unsetup(void)
 	if (nested)
 		nested_vmx_hardware_unsetup();
 
-	free_kvm_area();
+	free_vmxon_regions();
 }
 
 static bool vmx_check_apicv_inhibit_reasons(ulong bit)
-- 
2.24.1

