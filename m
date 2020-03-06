Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6774AC10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:02:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3FA1B2166E
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 13:02:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="FqTk4Kcg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727141AbgCFNC0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 08:02:26 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:22480 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726368AbgCFNCY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 08:02:24 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583499743;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=y2yWNaYqjJ/RvKkVVduCbhM3C1I4Zkz6logIvpDXjRI=;
        b=FqTk4KcgaF/inbDOp0MXx0zQXRCTKhPGnUhOnJv/yKjOsZ9u2eRBqS2A3hZ8dMGj7G4kGe
        kq7e5RyoDwlwYyUddbgkT4rrZT4SXWB8KaKiMIYXW5MwMADSr0aRXIOd9rsm1zyGA6gDSo
        loi8MAEbh26qTKdy3GRdKVwXfSJF2Rg=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-314-QXQp5iNiO-6za3SwQgJ_MQ-1; Fri, 06 Mar 2020 08:02:22 -0500
X-MC-Unique: QXQp5iNiO-6za3SwQgJ_MQ-1
Received: by mail-wm1-f71.google.com with SMTP id r19so864418wmh.1
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 05:02:20 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=y2yWNaYqjJ/RvKkVVduCbhM3C1I4Zkz6logIvpDXjRI=;
        b=lTOGf+0v59LV/UfdX5JhYAe+QYuXr5YS2FnrnFCW08Hhptr9cZZhL2njesQymCsOZ2
         XjugyLW3eCa/MAbP1OGRYUhkg6XExVi61bKZ6TwZ+YzHpkjhhzOXfkoKHRqFNfYLr0aZ
         k0Cv9s83/0Iq8lIcNOuc+1DgTIrUhteoYIWLu7vu/odp87VdSbGLfX3ydrapWgoH4G8X
         aVys9YITAg6l1UwX/ArNw+7rM5VxZBBRlAzdtAzXy3SjPDjLDSo0l1j6cWaFjRoRjJEq
         hz54fpDt31ogIZgV8+MAaw3Go3z10GoKFsIjScWT78sSrEXy+qPQloLraz1pvGwAf+6U
         /PhA==
X-Gm-Message-State: ANhLgQ2Q9IqHMLfvEnq6XKBrZyVS/bNXVR3Llmqh5dn16Z48D7uZsKKD
        Cekb3Pi62GdBkiAQiSm4ey9pkkRCQicrnp4pU/0G0gjXmJE0bsswSbiEItJluk9Q6ZQXgrfk7xS
        YdcII7snKFllPZi6RokXvlE6+
X-Received: by 2002:a5d:6690:: with SMTP id l16mr4193876wru.251.1583499739787;
        Fri, 06 Mar 2020 05:02:19 -0800 (PST)
X-Google-Smtp-Source: ADFU+vt1OXPzlEbyvBAvceW/RbmClBEpZeiagwVFOODbocvqNKeEiZjWeqYhWm0qnk58uiEN6mYnZw==
X-Received: by 2002:a5d:6690:: with SMTP id l16mr4193848wru.251.1583499739540;
        Fri, 06 Mar 2020 05:02:19 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id i67sm26613243wri.50.2020.03.06.05.02.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 05:02:18 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH v3 1/2] KVM: VMX: rename 'kvm_area' to 'vmxon_region'
Date:   Fri,  6 Mar 2020 14:02:14 +0100
Message-Id: <20200306130215.150686-2-vkuznets@redhat.com>
X-Mailer: git-send-email 2.24.1
In-Reply-To: <20200306130215.150686-1-vkuznets@redhat.com>
References: <20200306130215.150686-1-vkuznets@redhat.com>
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

