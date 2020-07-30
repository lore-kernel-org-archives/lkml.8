Return-Path: <SRS0=+W6S=BJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3521AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 19:37:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 09A4020809
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jul 2020 19:37:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="dPXuNrkZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730523AbgG3ThO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jul 2020 15:37:14 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41337 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726650AbgG3ThN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jul 2020 15:37:13 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1596137832;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding;
        bh=evGWKkVwKQbCUf877DPL3WNOIsuP9Jsv7c2BA2D1qwo=;
        b=dPXuNrkZ+uGOAyIG05LxNyc4ZB87r3mkZhAL0ZuCmtgQ40J3xxn3rNNXvjAqnWuH9LkzAH
        EfyGcM6o7StECF81BhJPGJs0wM70Y+cQcBVbm2DJhipfgxLbmr2iy5HPLHBywf2jiHCArC
        tqCQatdDEslQjm1bX5uKAmgHABSaYkI=
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-476-PkkDqE-UMYi3wYkWz6A3QQ-1; Thu, 30 Jul 2020 15:37:07 -0400
X-MC-Unique: PkkDqE-UMYi3wYkWz6A3QQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.phx2.redhat.com [10.5.11.22])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id DFC11102C7EE;
        Thu, 30 Jul 2020 19:37:05 +0000 (UTC)
Received: from localhost.localdomain.com (unknown [10.40.192.46])
        by smtp.corp.redhat.com (Postfix) with ESMTPS id 735A51002393;
        Thu, 30 Jul 2020 19:36:45 +0000 (UTC)
From:   Julia Suvorova <jusual@redhat.com>
To:     kvm@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, Bjorn Helgaas <helgaas@kernel.org>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Julia Suvorova <jusual@redhat.com>
Subject: [PATCH] KVM: x86: Use MMCONFIG for all PCI config space accesses
Date:   Thu, 30 Jul 2020 21:35:10 +0200
Message-Id: <20200730193510.578309-1-jusual@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.22
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Using MMCONFIG instead of I/O ports cuts the number of config space
accesses in half, which is faster on KVM and opens the door for
additional optimizations such as Vitaly's "[PATCH 0/3] KVM: x86: KVM
MEM_PCI_HOLE memory":
https://lore.kernel.org/kvm/20200728143741.2718593-1-vkuznets@redhat.com

However, this change will not bring significant performance improvement
unless it is running on x86 within a hypervisor. Moreover, allowing
MMCONFIG access for addresses < 256 can be dangerous for some devices:
see commit a0ca99096094 ("PCI x86: always use conf1 to access config
space below 256 bytes"). That is why a special feature flag is needed.

Introduce KVM_FEATURE_PCI_GO_MMCONFIG, which can be enabled when the
configuration is known to be safe (e.g. in QEMU).

Signed-off-by: Julia Suvorova <jusual@redhat.com>
---
 Documentation/virt/kvm/cpuid.rst     |  4 ++++
 arch/x86/include/uapi/asm/kvm_para.h |  1 +
 arch/x86/kernel/kvm.c                | 14 ++++++++++++++
 3 files changed, 19 insertions(+)

diff --git a/Documentation/virt/kvm/cpuid.rst b/Documentation/virt/kvm/cpuid.rst
index a7dff9186bed..711f2074877b 100644
--- a/Documentation/virt/kvm/cpuid.rst
+++ b/Documentation/virt/kvm/cpuid.rst
@@ -92,6 +92,10 @@ KVM_FEATURE_ASYNC_PF_INT          14          guest checks this feature bit
                                               async pf acknowledgment msr
                                               0x4b564d07.
 
+KVM_FEATURE_PCI_GO_MMCONFIG       15          guest checks this feature bit
+                                              before using MMCONFIG for all
+                                              PCI config accesses
+
 KVM_FEATURE_CLOCSOURCE_STABLE_BIT 24          host will warn if no guest-side
                                               per-cpu warps are expeced in
                                               kvmclock
diff --git a/arch/x86/include/uapi/asm/kvm_para.h b/arch/x86/include/uapi/asm/kvm_para.h
index 812e9b4c1114..5793f372cae0 100644
--- a/arch/x86/include/uapi/asm/kvm_para.h
+++ b/arch/x86/include/uapi/asm/kvm_para.h
@@ -32,6 +32,7 @@
 #define KVM_FEATURE_POLL_CONTROL	12
 #define KVM_FEATURE_PV_SCHED_YIELD	13
 #define KVM_FEATURE_ASYNC_PF_INT	14
+#define KVM_FEATURE_PCI_GO_MMCONFIG	15
 
 #define KVM_HINTS_REALTIME      0
 
diff --git a/arch/x86/kernel/kvm.c b/arch/x86/kernel/kvm.c
index df63786e7bfa..1ec73e6f25ce 100644
--- a/arch/x86/kernel/kvm.c
+++ b/arch/x86/kernel/kvm.c
@@ -33,6 +33,7 @@
 #include <asm/hypervisor.h>
 #include <asm/tlb.h>
 #include <asm/cpuidle_haltpoll.h>
+#include <asm/pci_x86.h>
 
 DEFINE_STATIC_KEY_FALSE(kvm_async_pf_enabled);
 
@@ -715,6 +716,18 @@ static uint32_t __init kvm_detect(void)
 	return kvm_cpuid_base();
 }
 
+static int __init kvm_pci_arch_init(void)
+{
+	if (raw_pci_ext_ops &&
+	    kvm_para_has_feature(KVM_FEATURE_PCI_GO_MMCONFIG)) {
+		pr_info("PCI: Using MMCONFIG for base access\n");
+		raw_pci_ops = raw_pci_ext_ops;
+		return 0;
+	}
+
+	return 1;
+}
+
 static void __init kvm_apic_init(void)
 {
 #if defined(CONFIG_SMP)
@@ -726,6 +739,7 @@ static void __init kvm_apic_init(void)
 static void __init kvm_init_platform(void)
 {
 	kvmclock_init();
+	x86_init.pci.arch_init = kvm_pci_arch_init;
 	x86_platform.apic_post_init = kvm_apic_init;
 }
 
-- 
2.25.4

