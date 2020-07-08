Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D494DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:25:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9D672065D
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 19:25:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="M8YyI1cO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726162AbgGHTZw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 15:25:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725903AbgGHTZv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 15:25:51 -0400
Received: from mail-yb1-xb49.google.com (mail-yb1-xb49.google.com [IPv6:2607:f8b0:4864:20::b49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39144C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 12:25:51 -0700 (PDT)
Received: by mail-yb1-xb49.google.com with SMTP id n11so52650080ybg.15
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 12:25:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=M9lyp9aB5g7rtu5MiUgfbjfYjZdXTeZw0fg1xRRWYVs=;
        b=M8YyI1cOHmEenNKeoDViXyo+AQX0kE3jm3iwIVLWA4P4XH0qdh5ysQ43fTzbQyPFO1
         MnbGya77iRrx6CFhaFI3kZJIVnTEX7bBL294rMqemb+dfKhEnHxAR8WMFhwGJmReM7kB
         ji00aDP4DTe7S5vq/p4kxMEV2m5CnVJx5xZ/25UBgFp3w4ISZyGMhTIftqZRMS1lRnnY
         1CRtpf3JVllxgJcU1jTYPxlTTXNn/OiHaFA+KoY13oBNKKA6mx0OlLrLayW/DKVYPNf3
         wpknbzNy1pWoLwNKWIOH2IaHKLgOF3R6o5cxD6j9tfA7ZJQOnzcgQKGxfufUl0B8rGAx
         FDkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=M9lyp9aB5g7rtu5MiUgfbjfYjZdXTeZw0fg1xRRWYVs=;
        b=CAXhOQJ6I6COlyNZnSUaqkq/P4Jm/p3dJndW3GfT82RV5kTlDy3rRQ4FNUpXxKb5mc
         7wrnCjOlmWAodCw0//EyZk9YwSofGwPs6qAsfukbr1UYyJgP+RyM1nGPjfc7TwWjJgpR
         n+HKY0bEMIFclYOSUCsoZy8akiUr/0fCgH1Hy1cZ2TTiQy70HT+KpgcjhvL/2a6KTjbp
         eqxJCBUKLso55f+Teq/FyFVKQlRlVndXz9rD3YhIz5UCI2Pgzps0OHoDgA/Vl/NVMdpy
         9Gjp8NZuBUg+ENtpvzvEvSrZkj/iHRDYpHtRwNi3TT3MXx5J0/l94xk5be8tQlWETF/1
         pXJA==
X-Gm-Message-State: AOAM531J+SeMWUKngQfdJEs+nmSTNthh0ofTW5+AlqJfgDpA1cqCb9KZ
        trYk6hx5irh4qVNEmASbFE7cy3a1okGLU7kLsVtBmVKGYo3fXo4svKNnFCW8oooe/Sycu5bKtV0
        NBks7HI7uCEuhk8/l9gK5Ltzkvwrunlx7fvP8Z55lxHw68sKwvcsNkkoBIdr3LPizSBP1+rQxaD
        xzyptM
X-Google-Smtp-Source: ABdhPJyazEsJdyohKqw0P5UhxeRdYkv49fC19GKY5MKzNLPXDWzWA5Q0Qo9y8EnnTzNN13bmHta9B5nyV4WATkYT
X-Received: by 2002:a25:aaf1:: with SMTP id t104mr101753518ybi.163.1594236350296;
 Wed, 08 Jul 2020 12:25:50 -0700 (PDT)
Date:   Wed,  8 Jul 2020 12:25:46 -0700
Message-Id: <20200708192546.4068026-1-abhishekbh@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.27.0.383.g050319c2ae-goog
Subject: [PATCH v4] x86/speculation/l1tf: Add KConfig for setting the L1D
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
2.27.0.383.g050319c2ae-goog

