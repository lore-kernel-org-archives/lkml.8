Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFF3CC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 22:12:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C961E20780
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 22:12:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="miWQau21"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726281AbgGBWMo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 18:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34358 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726028AbgGBWMo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 18:12:44 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C45DBC08C5DD
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 15:12:43 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id j3so31610143yba.14
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 15:12:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=PswgYOjFLHR50otlPxE8b2oGJ3kDUK3h2XTdWa425M0=;
        b=miWQau211dDj1fe/9wWIj67CDW+WofqWHYP6On71PKk8qGABIWIZgsg6QaVQF6200z
         2HekYUpa8CR/8ZH0IXD751av4uDRNbhIdcY+G8Phl/p+3Ou/pfeWlUvJIgpUw6vNbPJg
         LxXCichKPhMD8l+s3+ilWXjoveWcdwpx0o6QwAYWJPoH19aeUDoNCx4srH8TcWuUmzbN
         fYmAJzSvKt/ujCua/IZfLJDHYuK1Xv568YfbiYgddoviuLdQNfo+a9eRDZ0tdhsrYygC
         guLIit+pK9pvWkFfP5DnA3Lng+PSZWCC4j/lTxqrdiuUGwgxuonF2SjkKQZoO7u+xJ/j
         XPUw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=PswgYOjFLHR50otlPxE8b2oGJ3kDUK3h2XTdWa425M0=;
        b=CsGdPeWdHgNjGk2ZYw1yjWI5sr1GogdEmEIhzF+VpGtnKVFDlhNV6yxQw1/QZPUuE6
         7JDI8ywmFMvXZY+1fMRVPMe1ShtSZALVRC6tds8GtiIalFbgP8oJ66tqcnSg+cyL0TG9
         LH1kwR/BI2sJH8S2hKI0gZ2hufcfZbXu0BZTMqxro7CCeppMOMqaZUybR39VOVIoWy0Z
         UFUjZGpYxWPMycTlqcUscvSwTetmzfp6xbG5fx+AI30YlNHFX/5DrSjBm92ZDnHpcJV2
         buR28j7N+5TRZjpQDn8WW76fvVLR9IfIohBHNtqfn7ZlqZSmm38v7YbtB0YADuyv6xHk
         1ZIg==
X-Gm-Message-State: AOAM531xDU3r/lympozlfyAXk4aDk4l3eniFSMZVbDurcZreCs1oTqPQ
        R7grjwtNEfOdd6lNm9B3i2i/nQoV5RHJkPdSd19uLRS/qxo3na2PY5lUChpvZiLkiTfr/lZ/iHx
        o/kH6iNIIJ65LXkKecVy0e5UIfI3HIK99h7fNxB9Y9XGuxStRtPWH59Im36PFubeexgUuNgjIzb
        /E1rea
X-Google-Smtp-Source: ABdhPJxMgLnACwCz65RBY/9qPnP80m0LmIZzQopaUlX4E3h+C8yL6JDA7+Y5Ako8csmqguYSuHXJQYdGnP1puQAi
X-Received: by 2002:a25:38c5:: with SMTP id f188mr54720332yba.332.1593727962818;
 Thu, 02 Jul 2020 15:12:42 -0700 (PDT)
Date:   Thu,  2 Jul 2020 15:12:37 -0700
Message-Id: <20200702221237.2517080-1-abhishekbh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.212.ge8ba1cc988-goog
Subject: [PATCH v3] x86/speculation/l1tf: Add KConfig for setting the L1D
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
        Mike Rapoport <rppt@linux.ibm.com>,
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

Changes in v3:
- Change depends on to only x86_64.
- Remove copy paste errors at the end of the KConfig.

Changes in v2:
- Fix typo in the help of the new KConfig.

 arch/x86/kernel/cpu/bugs.c |  8 ++++++++
 arch/x86/kvm/Kconfig       | 13 +++++++++++++
 2 files changed, 21 insertions(+)

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
index b277a2db62676..1f85374a0b812 100644
--- a/arch/x86/kvm/Kconfig
+++ b/arch/x86/kvm/Kconfig
@@ -107,4 +107,17 @@ config KVM_MMU_AUDIT
 	 This option adds a R/W kVM module parameter 'mmu_audit', which allows
 	 auditing of KVM MMU events at runtime.
 
+config KVM_VMENTRY_L1D_FLUSH
+	int "L1D cache flush settings (1-3)"
+	range 1 3
+	default "2"
+	depends on KVM && X86_64
+	help
+	 This setting determines the L1D cache flush behavior before a VMENTER.
+	 This is similar to setting the option / parameter to
+	 kvm-intel.vmentry_l1d_flush.
+	 1 - Never flush.
+	 2 - Conditionally flush.
+	 3 - Always flush.
+
 endif # VIRTUALIZATION
-- 
2.27.0.212.ge8ba1cc988-goog

