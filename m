Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE3A8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:38:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8575421531
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 21:38:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Dk979kDT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726227AbgGBViW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 17:38:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725994AbgGBViV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 17:38:21 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A80CCC08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 14:38:21 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id l9so30543803ybm.20
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 14:38:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=3jFVmOWTZ7tfbragSeisWuV593ZLuszzQyS3jGQXGNo=;
        b=Dk979kDTJeU8TS2UZalznCkhwAAk6oVDP7ehiHAWnidaRkcctFc1ICv1lZHft17wne
         l4FHMTIEX/Qv4t2ItkVRx0k/K4zpIs+Z97Y4aerzejJR/J4O4YnmNxURCmUxliI+kpag
         gEe98j4v1HfOuRViBx9LDs/PEVeK/0ex5Vd9Dkxk88L7LkSEV4UbjK3xo4bjS+qrLZHu
         ahE49X8pltTgTVCRAA/xfyPyLueBbXAH/o6cOBsXzJ2B0FTDBmfXvkbWXQRKNSqeivIy
         UtPqk0Fb9kMmzlTYNf9MYnUZIV+NtWNqc1XnvElkMjVqWlEsIA/c2FByVBxaRrVBJmL/
         UIoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=3jFVmOWTZ7tfbragSeisWuV593ZLuszzQyS3jGQXGNo=;
        b=IlndlgbhDsGSlX7tbK/l2VLSzrVv3JLXzM1VXDiKeSt3Z8eKLNjPWn0av66pLhky7d
         z++geGg90IJ4kgkvHXA21TwVLfStfm7pVgDj/Qi+KsAk9X+kAD3PZ4MhDxn21wZnv9r0
         JIjDvHNTKj99AkIHXpDyHVZ+pHJr9AN4iJQF5GI0h9xH2+IG6pL4577YL/iVB9wa4ryE
         ADsqfqfgwvMIJGR0vk+A0Jedyyjd1/ZdESmdwEG3QvTcL4/BGIs8b88fdJc9VhzDf8gf
         6Niyo9NwYkMeWo1dsdYBk5Fr6UtbK1UzTtQHAg9srqXtyNc3buWrehkb4axBlekn8R8V
         B+qw==
X-Gm-Message-State: AOAM5316WGTYrlVcHkycvj4Lf3mQlZETdlRvpqrEL9t4ytpeq+IidKwx
        BCuXteRfd8w2hjSpjrPei3o/b7FC7pUuPSnv54w/g186DJUb0Km21a9kFYAPIKjs5dT0VlDwcdv
        Hhq3X2lo5DTNQhN7UZC474eGU9gJ2wpVecjz3wTHhuYN8zyAEfB/2AuiacSyesXgtSVUdCfotgh
        HH48gT
X-Google-Smtp-Source: ABdhPJxAVfsuDW//QTW+DVgSQMyg8D5UHUYjhMGXNySyEZnJS+jNMSdZyoBRA5sXSiH6NQBqZANE7mFqyx25lBh7
X-Received: by 2002:a25:9904:: with SMTP id z4mr52596021ybn.146.1593725900728;
 Thu, 02 Jul 2020 14:38:20 -0700 (PDT)
Date:   Thu,  2 Jul 2020 14:38:07 -0700
Message-Id: <20200702213807.2511503-1-abhishekbh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v2] x86/speculation/l1tf: Add KConfig for setting the L1D
 cache flush mode
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

Changes in v2:
- Fix typo in the help of the new KConfig.

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
index b277a2db62676..d375dcedd447d 100644
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
+	 2 - Conditionally flush.
+	 3 - Always flush.
+
+# OK, it's a little counter-intuitive to do this, but it puts it neatly under
+# the virtualization menu.
+source "drivers/vhost/Kconfig"
+
 endif # VIRTUALIZATION
-- 
2.27.0.212.ge8ba1cc988-goog

