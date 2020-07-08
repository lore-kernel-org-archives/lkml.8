Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70919C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:47:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5451820720
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:47:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QOUjGeLt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726144AbgGHTrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 15:47:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43016 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725787AbgGHTrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 15:47:20 -0400
Received: from mail-pl1-x649.google.com (mail-pl1-x649.google.com [IPv6:2607:f8b0:4864:20::649])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9DDF2C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 12:47:20 -0700 (PDT)
Received: by mail-pl1-x649.google.com with SMTP id x1so5918517pla.10
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 12:47:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=pljlg3yHFHSvTFF5i62V0f3vLeabEmCDDf596zZbJM8=;
        b=QOUjGeLtOAJD7kgc4YCP+sBsOWR5DJaZmc58t58h2EH8HPeOhHgvihOeBoBz41z+h7
         lk1O16q6sWuFZvb1Kv6sHeJthkBqfgF2qsd/qhvyKS/S5WAaflpfrbqSIBn1+0fa9lyX
         iS4S1CC2nll4cumNd3QhC7BkOedqQRBAgAicF545XYfTjAxsUBUvpBQbUeLyJAsr2f3q
         r270qhAGqPIkeOxlgCn5Wz5tZjJdREM6VuKAjngTgE0lu0qPpnksRkKcwzVtoUrk6sJ5
         5SUR+2PKD8qz79BJ2zuoJ7zlEHWPLVIlUzY8S8GdZPG77LadBr9xaUq0u6Ql9FOwH27X
         TEnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=pljlg3yHFHSvTFF5i62V0f3vLeabEmCDDf596zZbJM8=;
        b=Kh8vYINHstmaOQEhCnbXuz1zQtB3Gi5blEe88viAGy+gQscS1wz7GTrFUUIxjpKX4K
         dUCzygexPfW0TQSRALT6gQ+K2tg+m6e79+faWtDD07etbb2IrTkw5VC0q9zGS0blGqUK
         fgFTM5WQsfjrrVFhSJbinpa6opjNXawQJrpEfM1TNTEfTRSc98+KRIb4fbF/3e+aOs4+
         NbkoKlDwhuaNhgwbXhfqcSNXn9P+iId5SpbUTGYbpV8sdspk1QGs2xPhGjj0B4FI6QPb
         mk4dongNOkK7TgpW3C4OkHkL+5AcqVK6AmNyHVnocsRln6R/BM2JVhtaSKocYSKbaZek
         zNew==
X-Gm-Message-State: AOAM53102Mz00maInhmFFbErx349XkcVGfTrWFG2gXTHqeXSesRA4KLy
        Tui1gpjKEnrggWFZaxQqV2scDzMIzhYpyiQWPnweXzZPrNARaUtPAUCupLlq1FHaFsjXxA3GtNz
        OfNCnCtJnyVuN19/GVL9I0xga7merNx/uwH3lMMLIRtEG5BMVPOQZv/gdMFoPfqfh+4JjhMhf3E
        XVAJEi
X-Google-Smtp-Source: ABdhPJwu+cqA7SFopH7sDGho/uhjflNJjwTBWDtSPL4H1srwzxx+pUWfCqcSwPaH9Fom19mDm0ylxD8+2+ZFHvKK
X-Received: by 2002:a17:902:a60d:: with SMTP id u13mr52502800plq.46.1594237639483;
 Wed, 08 Jul 2020 12:47:19 -0700 (PDT)
Date:   Wed,  8 Jul 2020 12:47:15 -0700
Message-Id: <20200708194715.4073300-1-abhishekbh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH v5] x86/speculation/l1tf: Add KConfig for setting the L1D
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

The reasons for this change are as follows -

 - Kernel command line arguments are getting unwieldy. These parameters
 are not a scalable way to set the kernel config. They're intended as a
 super limited way for the bootloader to pass info to the kernel and
 also as a way for end users who are not compiling the kernel themselves
 to tweak the kernel behavior.

 - Also, if a user wants this setting from the start. It's a definite
 smell that it deserves to be a compile time thing rather than adding
 extra code plus whatever miniscule time at runtime to pass an
 extra argument.

 - Finally, it doesn't preclude the runtime / kernel command line way.
 Users are free to use those as well.

Signed-off-by: Abhishek Bhardwaj <abhishekbh@google.com>

---

Changes in v5:
- Fix indentation of the help text in the KConfig.

Changes in v4:
- Add motivation for the change in the commit message.

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
index b277a2db62676..cb2639dfb6da1 100644
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
+	  This setting determines the L1D cache flush behavior before a VMENTER.
+	  This is similar to setting the option / parameter to
+	  kvm-intel.vmentry_l1d_flush.
+	  1 - Never flush.
+	  2 - Conditionally flush.
+	  3 - Always flush.
+
 endif # VIRTUALIZATION
-- 
2.27.0.383.g050319c2ae-goog

