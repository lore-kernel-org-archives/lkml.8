Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF42AC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98F3520720
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="suMZCdb6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgGBQTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:19:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726300AbgGBQTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:19:22 -0400
Received: from mail-qt1-x84a.google.com (mail-qt1-x84a.google.com [IPv6:2607:f8b0:4864:20::84a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2191BC08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 09:19:22 -0700 (PDT)
Received: by mail-qt1-x84a.google.com with SMTP id m25so15108590qtk.1
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 09:19:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=CXTe1dgoIkziCoFVfYKeWk3MqTpTpSjmG77p0bE6NoA=;
        b=suMZCdb64YsbSOryl020BrcFDQ3UYPbRVImF5H5v6pc9aBeBZtiSXm2zZ/33mPrnrb
         WxErBfDhtBLdxno5VWInb25pAdsvuAPINvWptBxml477CQfyEGDM3UfI6YJU3GkUxAce
         dD2tKHU0hLlD3swE/sXOkvX4FezCBbL2CLT77TSj6dWGSLou78WiYYmFPRjE0KnZZCS9
         m8R9XTNuKGncmUoCWNwAEnGp/RmNxWEICtYd5aEeoZB+zc0m1WR4/9SF/rdlNDw43VeA
         eJvJ4i9pIQ/aVIbIIRz0oZ+uoGCA/KjIwzJPxFewdN5NdyBvSRAONvVOOUamk+z9Sm6d
         cC7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=CXTe1dgoIkziCoFVfYKeWk3MqTpTpSjmG77p0bE6NoA=;
        b=d6FYA1Z5QjkOZznSSHDDcMefktwP9BPl2tC3AXy0Chje31fmfC1uXJGx8rm7lUFBMi
         VwRI3K+iDq1UUN0D9DIK09zEExBe1CTEiGgThn+KGON4iA/J2VJP1MyAuy1so+GztJHm
         sQvGU1ypiWsulPiJ/CqHMGDj4p78UN1BuhQ21iPKFdG9ZEZF55JGfv17gbRQ4ksrRjgw
         X7gODPd9yU3KVRu6UQLf1R4icSIFZjk3CcWHbCqczLFtbtA1RYU27w8wtSAvWp8QHvLX
         A2yT96Lz1Y6Dq98VPIxJz+Pb54mpBFw/rH7236UMPbNIakKxd54R8zvldXiwckI2SorW
         QYeg==
X-Gm-Message-State: AOAM5305D67RomloGL6q+EOC9i/At2ppZNTcGvW7c6IpY7FAHZP2k/l+
        r7lD3b4FtIKVsFxrOKZ5gQLfAvZdm4/I+U7w88ObBZShoGMuA4hriC5FPOzU23m7hv7lbBZ1wZH
        FWZfaOdggzracUBY7x5PisR+Fkh85S4kA03KNladQN6F7hlkxLoEtxGdXjYHtpGwrNBv9mMuCDT
        0D311p
X-Google-Smtp-Source: ABdhPJyMIMas8tgBt7VQOheH8xigvokD2vo4KZ/A/aw4GacYLB8/fzAlrqaYDQevZIT7u27IzMfwRvfLL/vjfnRF
X-Received: by 2002:ad4:4d83:: with SMTP id cv3mr31515092qvb.236.1593706761146;
 Thu, 02 Jul 2020 09:19:21 -0700 (PDT)
Date:   Thu,  2 Jul 2020 09:19:16 -0700
Message-Id: <20200702161916.2456342-1-abhishekbh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH] x86/speculation/l1tf: Add KConfig for setting the L1D cache
 flush mode
From:   Abhishek Bhardwaj <abhishekbh@google.com>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Abhishek Bhardwaj <abhishekbh@google.com>,
        Anthony Steinhauser <asteinhauser@google.com>,
        Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, Ingo Molnar <mingo@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Mark Gross <mgross@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tony Luck <tony.luck@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Waiman Long <longman@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
        x86@kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This change adds a new kernel configuration that sets the l1d cache
flush setting at compile time rather than at run time.

Signed-off-by: Abhishek Bhardwaj <abhishekbh@google.com>
---

 arch/x86/kernel/cpu/bugs.c |  8 ++++++++
 arch/x86/kvm/Kconfig       | 17 +++++++++++++++++
 2 files changed, 25 insertions(+)

diff --git a/arch/x86/kernel/cpu/bugs.c b/arch/x86/kernel/cpu/bugs.c
index 0b71970d2d3d2..1dcc875cf5547 100644
--- a/arch/x86/kernel/cpu/bugs.c
+++ b/arch/x86/kernel/cpu/bugs.c
@@ -1406,7 +1406,15 @@ enum l1tf_mitigations l1tf_mitigation __ro_after_init = L1TF_MITIGATION_FLUSH;
 #if IS_ENABLED(CONFIG_KVM_INTEL)
 EXPORT_SYMBOL_GPL(l1tf_mitigation);
 #endif
+#if (CONFIG_KVM_VMENTRY_L1D_FLUSH == 1)
+enum vmx_l1d_flush_state l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_NEVER;
+#elif (CONFIG_KVM_VMENTRY_L1D_FLUSH == 2)
+enum vmx_l1d_flush_state l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_COND;
+#elif (CONFIG_KVM_VMENTRY_L1D_FLUSH == 3)
+enum vmx_l1d_flush_state l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_ALWAYS;
+#else
 enum vmx_l1d_flush_state l1tf_vmx_mitigation = VMENTER_L1D_FLUSH_AUTO;
+#endif
 EXPORT_SYMBOL_GPL(l1tf_vmx_mitigation);
 
 /*
diff --git a/arch/x86/kvm/Kconfig b/arch/x86/kvm/Kconfig
index b277a2db62676..f82a0c564e931 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -107,4 +107,21 @@ config KVM_MMU_AUDIT
 	 This option adds a R/W kVM module parameter 'mmu_audit', which allows
 	 auditing of KVM MMU events at runtime.
 
+config KVM_VMENTRY_L1D_FLUSH
+	int "L1D cache flush settings (1-3)"
+	range 1 3
+	default "2"
+	depends on KVM && X86 && X86_64
+	help
+	 This setting determines the L1D cache flush behavior before a VMENTER.
+	 This is similar to setting the option / parameter to
+	 kvm-intel.vmentry_l1d_flush.
+	 1 - Never flush.
+	 2 - Conditinally flush.
+	 3 - Always flush.
+
+# OK, it's a little counter-intuitive to do this, but it puts it neatly under
+# the virtualization menu.
+source "drivers/vhost/Kconfig"
+
 endif # VIRTUALIZATION
-- 
2.27.0.212.ge8ba1cc988-goog

