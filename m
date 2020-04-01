Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97B18C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 635CD2078B
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:13:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="JIfjUAga"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732079AbgDAINz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:13:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:34306 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1732052AbgDAINy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:13:54 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1585728834;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=cU+okLsMKSqHOKUW7pNlWD/YMAsYMmyQn6ZUscB8aaA=;
        b=JIfjUAgavdfZxV8lDnIxQGpcL30vF1IJ9UKRcvaoOKiemSt/2c/i8oyO3uknY9G9oagel5
        Kg9CMq5QYzHpP10hUHGuYfHA6x4chazxKSaY59OPZRse7EsNDQpCK1MHKI/wF35Y+vzEYD
        sq+r5Nh6E1SsV0+jMBXDV5FG1zT2WME=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-77-Xkn_VEFdMLqsvVN1Qz-59w-1; Wed, 01 Apr 2020 04:13:52 -0400
X-MC-Unique: Xkn_VEFdMLqsvVN1Qz-59w-1
Received: by mail-wr1-f71.google.com with SMTP id k11so1228434wrm.19
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 01:13:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=cU+okLsMKSqHOKUW7pNlWD/YMAsYMmyQn6ZUscB8aaA=;
        b=oP1CvHCpeDY5R+GtPtSVA+gtCK4sCQ38JJ5aki7Vy8YhrDNhs2a2im4c08+sTudLSe
         CSHDthQPoJrVQGwq2D3F3Vy30rPK7S+3ZPKu0w73zWXNX/svl3ab+zWRjfP1hrIeQzcl
         F9GQh1iqACwTinHqlNsENmvHeypGF8vdah36L5JkZzlxZ8+pdFVyQTHa0VRbhAXBrafV
         tjb/acRtlGC3m0jrzuv88ws3SpcBDV1WTz4rtweDVyQAckwB/Dgx1N8w/5uzWkaFh4j6
         EdX5tlVeEppXazjzbQ0PYSwcD1FHJA42P+nHHIECIgXvNb6qwTAlUfci1MGReB6eYY/R
         vI0g==
X-Gm-Message-State: ANhLgQ3uGhc/ZslkT3GgHye1+PUmjLtc4dCEuizf1UcNb2pIl38goKBp
        F/TJ2oH+OUVa4wylJsMjRLD0k8dTJXFGoYP5EU3JXc2k9cIf7/9heXxNqxScGUfmllJTJRKplh1
        n92HUCjfC6IQNBQERWDz/SO7J
X-Received: by 2002:adf:82c5:: with SMTP id 63mr24282613wrc.312.1585728831192;
        Wed, 01 Apr 2020 01:13:51 -0700 (PDT)
X-Google-Smtp-Source: ADFU+vulGMjI4Nsim53ni39KXrS3G3GMQJsPvuNJhEQA50Sov48kj3Pwv0cKCOqLAqS/Et+Hnnw+HQ==
X-Received: by 2002:adf:82c5:: with SMTP id 63mr24282595wrc.312.1585728830954;
        Wed, 01 Apr 2020 01:13:50 -0700 (PDT)
Received: from vitty.brq.redhat.com (g-server-2.ign.cz. [91.219.240.2])
        by smtp.gmail.com with ESMTPSA id x206sm1662492wmg.17.2020.04.01.01.13.49
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 01 Apr 2020 01:13:50 -0700 (PDT)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: [PATCH] KVM: VMX: fix crash cleanup when KVM wasn't used
Date:   Wed,  1 Apr 2020 10:13:48 +0200
Message-Id: <20200401081348.1345307-1-vkuznets@redhat.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If KVM wasn't used at all before we crash the cleanup procedure fails with
 BUG: unable to handle page fault for address: ffffffffffffffc8
 #PF: supervisor read access in kernel mode
 #PF: error_code(0x0000) - not-present page
 PGD 23215067 P4D 23215067 PUD 23217067 PMD 0
 Oops: 0000 [#8] SMP PTI
 CPU: 0 PID: 3542 Comm: bash Kdump: loaded Tainted: G      D           5.6.0-rc2+ #823
 RIP: 0010:crash_vmclear_local_loaded_vmcss.cold+0x19/0x51 [kvm_intel]

The root cause is that loaded_vmcss_on_cpu list is not yet initialized,
we initialize it in hardware_enable() but this only happens when we start
a VM.

Previously, we used to have a bitmap with enabled CPUs and that was
preventing [masking] the issue.

Initialized loaded_vmcss_on_cpu list earlier, right before we assign
crash_vmclear_loaded_vmcss pointer. blocked_vcpu_on_cpu list and
blocked_vcpu_on_cpu_lock are moved altogether for consistency.

Fixes: 31603d4fc2bb ("KVM: VMX: Always VMCLEAR in-use VMCSes during crash with kexec support")
Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
---
 arch/x86/kvm/vmx/vmx.c | 12 +++++++-----
 1 file changed, 7 insertions(+), 5 deletions(-)

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index 3aba51d782e2..39a5dde12b79 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -2257,10 +2257,6 @@ static int hardware_enable(void)
 	    !hv_get_vp_assist_page(cpu))
 		return -EFAULT;
 
-	INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
-	INIT_LIST_HEAD(&per_cpu(blocked_vcpu_on_cpu, cpu));
-	spin_lock_init(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
-
 	r = kvm_cpu_vmxon(phys_addr);
 	if (r)
 		return r;
@@ -8006,7 +8002,7 @@ module_exit(vmx_exit);
 
 static int __init vmx_init(void)
 {
-	int r;
+	int r, cpu;
 
 #if IS_ENABLED(CONFIG_HYPERV)
 	/*
@@ -8060,6 +8056,12 @@ static int __init vmx_init(void)
 		return r;
 	}
 
+	for_each_possible_cpu(cpu) {
+		INIT_LIST_HEAD(&per_cpu(loaded_vmcss_on_cpu, cpu));
+		INIT_LIST_HEAD(&per_cpu(blocked_vcpu_on_cpu, cpu));
+		spin_lock_init(&per_cpu(blocked_vcpu_on_cpu_lock, cpu));
+	}
+
 #ifdef CONFIG_KEXEC_CORE
 	rcu_assign_pointer(crash_vmclear_loaded_vmcss,
 			   crash_vmclear_local_loaded_vmcss);
-- 
2.25.1

