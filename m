Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_GIT autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 61535C433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:53:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 336D520897
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 19:53:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=digitalocean.com header.i=@digitalocean.com header.b="XVkXnkV3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgH1Txl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 15:53:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727015AbgH1TxC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 15:53:02 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E0C56C061235
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:53:01 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id 92so439924qtb.6
        for <linux-kernel@vger.kernel.org>; Fri, 28 Aug 2020 12:53:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=digitalocean.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :in-reply-to:references;
        bh=ME4QPmZUAN/d7At5LzRWk7EqLbP7sQEyOrKRmRo26fA=;
        b=XVkXnkV33bDSTsBFMdDrSLWtT0NMUQaVA3FRlyUr8SqDkS78RIgo3HaTGaHJN187bL
         xrmVSymKyEJGWvZF4lc6Im+RuLHZNiHtNHwpQ6IDnysZ5twIXUYlmay4kZRU8+UG8aRC
         YpQ8w6E5ZnaOQG1z427xzzkG5/bIUNGeewO1Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:in-reply-to:references;
        bh=ME4QPmZUAN/d7At5LzRWk7EqLbP7sQEyOrKRmRo26fA=;
        b=rA9YjQM1F5Ri2W24zE2TK4jGWFj4F7PpeI6W+lVp0BXnLsuo4bZ05AM2NP00TviCvB
         ZI4gzARmAhJ8NxteFhdk4EySYONJkrpVRV8QhnezTp+4YZMprETdbfqbHcZMrgR2FEHy
         A3ridQSAg/P+kGGI3LRHz73X0D0BOA5aC80jZLBrQ1wcRlMjt1DB2B9DQYYojoEhDntY
         8QaZwsHfVQAMBnH8xLWJSel5DLF6cQNDzP0cdqBsKowbL/ORNVrmeWOZOkMlLnk/Pmdp
         71+repdeahaSu2GZOOEGno8twDbDHwscXsvU8/fY6hCCRxpH5M0e59NP63q1XlwPUDLw
         cFVw==
X-Gm-Message-State: AOAM5330Rqv6hddt6Hg0vb4ZWM4uT8WdZ6ECZVdim5pJb5N17uMI/6KS
        zdC7NUJUazpR2vcTPFyJ6TGskA==
X-Google-Smtp-Source: ABdhPJyyuAG60Rolok6y9E3kNbh3A4M0cahTqbYIVWWWzBnJDe5V6JYxgx5tU8zyIuEsSiYPxpYf6w==
X-Received: by 2002:aed:2f84:: with SMTP id m4mr3048515qtd.61.1598644381105;
        Fri, 28 Aug 2020 12:53:01 -0700 (PDT)
Received: from [192.168.1.240] (192-222-189-155.qc.cable.ebox.net. [192.222.189.155])
        by smtp.gmail.com with ESMTPSA id r34sm150885qtr.18.2020.08.28.12.52.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Aug 2020 12:53:00 -0700 (PDT)
From:   Julien Desfossez <jdesfossez@digitalocean.com>
To:     Peter Zijlstra <peterz@infradead.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        Joel Fernandes <joelaf@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.intel@gmail.com>,
        Dhaval Giani <dhaval.giani@oracle.com>,
        Chris Hyser <chris.hyser@oracle.com>,
        Nishanth Aravamudan <naravamudan@digitalocean.com>
Cc:     mingo@kernel.org, tglx@linutronix.de, pjt@google.com,
        torvalds@linux-foundation.org, linux-kernel@vger.kernel.org,
        fweisbec@gmail.com, keescook@chromium.org, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Mel Gorman <mgorman@techsingularity.net>,
        Pawan Gupta <pawan.kumar.gupta@linux.intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>, joel@joelfernandes.org,
        vineeth@bitbyteword.org, Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Agata Gruza <agata.gruza@intel.com>,
        Antonio Gomez Iglesias <antonio.gomez.iglesias@intel.com>,
        graf@amazon.com, konrad.wilk@oracle.com, dfaggioli@suse.com,
        rostedt@goodmis.org, derkling@google.com, benbjiang@tencent.com
Subject: [RFC PATCH v7 19/23] entry/kvm: Protect the kernel when entering from guest
Date:   Fri, 28 Aug 2020 15:51:20 -0400
Message-Id: <19fb7e7a4f693b080f25b5e9b0b82de154cf4bd6.1598643276.git.jdesfossez@digitalocean.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
In-Reply-To: <cover.1598643276.git.jdesfossez@digitalocean.com>
References: <cover.1598643276.git.jdesfossez@digitalocean.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineeth Pillai <viremana@linux.microsoft.com>

Similar to how user to kernel mode transitions are protected in earlier
patches, protect the entry into kernel from guest mode as well.

Signed-off-by: Vineeth Pillai <viremana@linux.microsoft.com>
---
 arch/x86/kvm/x86.c        |  3 +++
 include/linux/entry-kvm.h | 12 ++++++++++++
 kernel/entry/kvm.c        | 12 ++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 33945283fe07..2c2f211a556a 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8526,6 +8526,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	 */
 	smp_mb__after_srcu_read_unlock();
 
+	kvm_exit_to_guest_mode(vcpu);
+
 	/*
 	 * This handles the case where a posted interrupt was
 	 * notified with kvm_vcpu_kick.
@@ -8619,6 +8621,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 		}
 	}
 
+	kvm_enter_from_guest_mode(vcpu);
 	local_irq_enable();
 	preempt_enable();
 
diff --git a/include/linux/entry-kvm.h b/include/linux/entry-kvm.h
index 0cef17afb41a..32aabb7f3e6d 100644
--- a/include/linux/entry-kvm.h
+++ b/include/linux/entry-kvm.h
@@ -77,4 +77,16 @@ static inline bool xfer_to_guest_mode_work_pending(void)
 }
 #endif /* CONFIG_KVM_XFER_TO_GUEST_WORK */
 
+/**
+ * kvm_enter_from_guest_mode - Hook called just after entering kernel from guest.
+ * @vcpu:   Pointer to the current VCPU data
+ */
+void kvm_enter_from_guest_mode(struct kvm_vcpu *vcpu);
+
+/**
+ * kvm_exit_to_guest_mode - Hook called just before entering guest from kernel.
+ * @vcpu:   Pointer to the current VCPU data
+ */
+void kvm_exit_to_guest_mode(struct kvm_vcpu *vcpu);
+
 #endif
diff --git a/kernel/entry/kvm.c b/kernel/entry/kvm.c
index eb1a8a4c867c..994af4241646 100644
--- a/kernel/entry/kvm.c
+++ b/kernel/entry/kvm.c
@@ -49,3 +49,15 @@ int xfer_to_guest_mode_handle_work(struct kvm_vcpu *vcpu)
 	return xfer_to_guest_mode_work(vcpu, ti_work);
 }
 EXPORT_SYMBOL_GPL(xfer_to_guest_mode_handle_work);
+
+void kvm_enter_from_guest_mode(struct kvm_vcpu *vcpu)
+{
+	sched_core_unsafe_enter();
+}
+EXPORT_SYMBOL_GPL(kvm_enter_from_guest_mode);
+
+void kvm_exit_to_guest_mode(struct kvm_vcpu *vcpu)
+{
+	sched_core_unsafe_exit_wait(XFER_TO_GUEST_MODE_WORK);
+}
+EXPORT_SYMBOL_GPL(kvm_exit_to_guest_mode);
-- 
2.17.1

