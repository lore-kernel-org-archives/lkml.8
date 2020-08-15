Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 22988C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:58:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 00A71206B6
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:58:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="M7SN9QXE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729403AbgHOV6y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:58:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728939AbgHOVvz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:51:55 -0400
Received: from mail-qv1-xf41.google.com (mail-qv1-xf41.google.com [IPv6:2607:f8b0:4864:20::f41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F330C061377
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:19:30 -0700 (PDT)
Received: by mail-qv1-xf41.google.com with SMTP id v1so3395950qvn.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 20:19:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=zVYStP8+ibwbqyIQ2zbXfm7VFGu9IZW9KttMNpQmwsw=;
        b=M7SN9QXEpZ0pMqf7l4vEUZjZHoM/g9N1QgHoJp4uTYXBOF5gRS+d5JsuBgrlzrcnt/
         A/hroQnoXTErRxjDwCkm+B+iU1js2wn/Y8MUQ3TGv7FERboBvpQfkmNA+XJZkLAuG7Ti
         B7G4YbLgqeZ1T/UMobf+VgcrF5ZcTC/gHgOXE=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=zVYStP8+ibwbqyIQ2zbXfm7VFGu9IZW9KttMNpQmwsw=;
        b=IdP5FzPTcesQFI0V+MKX3ZMuVDjKkC8y0AG+bTok6L78LicULCdctdhDvwa5Ui37h4
         rYX6GEvIAjrBlmoV8C7byv6exxf5hrPWP+c45y8CymWTltHpKLpkvnoLF62/FsXyqymy
         6dznWvth2bm53BD/UplRhVfoX46HGhYVw9C8V/Kv6M9MC/Y+CZ8lbCJEr69DF0AsTTQp
         7YLrPeZ0Y2P73Q3kCtdMCf8J3utzVXdlo9D4NpKMULL6/sVVNk6svFRaKDtyc6avC0Ei
         XNnNxlh3n6qtJ6cGERyFn+W3AoN9ctJJ9RKwTc8rrDnXS4oLY8QO95XNTaeOX2ZUBNeU
         M04A==
X-Gm-Message-State: AOAM532oUJRaBA9Fxm00GibX7poNwxzgIuP5Fo0nr0SxPpZSrlVCPUV2
        078lHmle9btBmNB09Ps8LrpDnw4dY51Qaw==
X-Google-Smtp-Source: ABdhPJy8s7GD9havgZRK8iUuvUPOxoTROteizuqKfQMEE7tjFZly7i1OS4UWxnTsqh8939XguDVAhQ==
X-Received: by 2002:a0c:f849:: with SMTP id g9mr5618787qvo.80.1597461569265;
        Fri, 14 Aug 2020 20:19:29 -0700 (PDT)
Received: from joelaf.cam.corp.google.com ([2620:15c:6:12:cad3:ffff:feb3:bd59])
        by smtp.gmail.com with ESMTPSA id p12sm10055199qkk.118.2020.08.14.20.19.28
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Aug 2020 20:19:28 -0700 (PDT)
From:   "Joel Fernandes (Google)" <joel@joelfernandes.org>
To:     linux-kernel@vger.kernel.org
Cc:     Vineeth Pillai <vineethrp@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Aaron Lu <aaron.lwe@gmail.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Julien Desfossez <jdesfossez@digitalocean.com>,
        Kees Cook <keescook@chromium.org>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Paul Turner <pjt@google.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Tim Chen <tim.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Vineeth Pillai <viremana@linux.microsoft.com>,
        x86@kernel.org (maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)),
        fweisbec@gmail.com, kerrnel@google.com,
        Phil Auld <pauld@redhat.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Chen Yu <yu.c.chen@intel.com>,
        Christian Brauner <christian.brauner@ubuntu.com>
Subject: [PATCH RFC 06/12] entry/kvm: Protect the kernel when entering from guest
Date:   Fri, 14 Aug 2020 23:19:02 -0400
Message-Id: <20200815031908.1015049-7-joel@joelfernandes.org>
X-Mailer: git-send-email 2.28.0.220.ged08abb693-goog
In-Reply-To: <20200815031908.1015049-1-joel@joelfernandes.org>
References: <20200815031908.1015049-1-joel@joelfernandes.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Vineeth Pillai <vineethrp@gmail.com>

Similar to how user to kernel mode transitions are protected in earlier
patches, protect the entry into kernel from guest mode as well.

Signed-off-by: Joel Fernandes (Google) <joel@joelfernandes.org>
---
 arch/x86/kvm/x86.c        |  3 +++
 include/linux/entry-kvm.h | 12 ++++++++++++
 kernel/entry/kvm.c        | 12 ++++++++++++
 3 files changed, 27 insertions(+)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 82d4a9e88908..b8a6faf78dc6 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -8484,6 +8484,8 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
 	 */
 	smp_mb__after_srcu_read_unlock();
 
+	kvm_exit_to_guest_mode(vcpu);
+
 	/*
 	 * This handles the case where a posted interrupt was
 	 * notified with kvm_vcpu_kick.
@@ -8578,6 +8580,7 @@ static int vcpu_enter_guest(struct kvm_vcpu *vcpu)
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
2.28.0.220.ged08abb693-goog

