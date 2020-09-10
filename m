Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_GIT autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7774FC43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:54:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1189E20882
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:54:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g4OTNybu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730521AbgIJJyD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:54:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730493AbgIJJvX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:51:23 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 59C69C061757;
        Thu, 10 Sep 2020 02:51:23 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id d16so643743pll.13;
        Thu, 10 Sep 2020 02:51:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=j7htwJAeNCUvO4S5RlNc3DOtl4dol2zJUiU0SUBRc+I=;
        b=g4OTNybujZoa7EfwmXbgUf10fX2yhnMBDkP8tJ5tNWEG9sjZ5epA/K3eLzMxz1tbCc
         eK7ZwnexxYAOUkQU5ImT2eBA9xTip3+TuhGkeZRL92U65cpTF4lGQDy/n3AD0mHCds3p
         YPPOMZhZmbm21D+itxzUDBs21JkNXl/SUTjrS18rlK/s5YeMZaTZosXCBhFZ6baXMfGI
         v1T8YtnbuWyD6F3qNEhCvpnIPOKWWeRKofKSjxmGLN+eZ5Q4rRye/RL4kihEZ/e5e+Fb
         fQBzo6IkB0d5KC7wdHd1wizK7rtpj5K81KZePnxjZ0H1pCmH+94E83weAfwQdVHgTbvE
         Si/A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references;
        bh=j7htwJAeNCUvO4S5RlNc3DOtl4dol2zJUiU0SUBRc+I=;
        b=BK6lmQHIdjH/TY0au8/GKSIIA0oGum+3+6wOci5/NI2bXO2Jn+p6QLrjzaQS/+4/mL
         GC66yjzB2Or1ix8psDuHcDDM4IbIDfXvS0EP2a8OxpHxzFh8V2Y/48vfqOEQhdmjMQJg
         8mGt/DuvFIOf1HETNHXYEw6foISqq0PIHY8qAdp+Gflbn3ysL+iFjV8SU9Vjhqnuclwu
         8d+Vd5BOKbu/qcIu1p3jEZJYpsxS2Af4R7MjWUZUbPzIceOGmgNWWwmAMftl3HSDVcMJ
         rnlLFdhHuPxPv+8R/axdC3GvLY5A25ZVrf2J7gM0uvJPMZhQfEF3sZwFBxflzb8mq1YK
         9PKg==
X-Gm-Message-State: AOAM531irvgYX1gK2DOqCZezSKBA5z/vxD4MipaiQZrz5VhOjuy+bWa7
        6Jpun/UQgwyQDnHCixTK2kXQ2JVLh6s=
X-Google-Smtp-Source: ABdhPJy4Ec5AtTKMudbwxwexym3/hbq7B0Y99oDBkr+P3nbMIpcYhmxvpIYlbBI23hq8NAJ/xNL2+w==
X-Received: by 2002:a17:902:10f:: with SMTP id 15mr4779290plb.121.1599731482578;
        Thu, 10 Sep 2020 02:51:22 -0700 (PDT)
Received: from localhost.localdomain ([103.7.29.6])
        by smtp.googlemail.com with ESMTPSA id e1sm2576534pfl.162.2020.09.10.02.51.19
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 10 Sep 2020 02:51:22 -0700 (PDT)
From:   Wanpeng Li <kernellwp@gmail.com>
X-Google-Original-From: Wanpeng Li <wanpengli@tencent.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        "Paul K ." <kronenpj@kronenpj.dyndns.org>
Subject: [PATCH v2 9/9] KVM: SVM: Reenable handle_fastpath_set_msr_irqoff() after complete_interrupts()
Date:   Thu, 10 Sep 2020 17:50:44 +0800
Message-Id: <1599731444-3525-10-git-send-email-wanpengli@tencent.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1599731444-3525-1-git-send-email-wanpengli@tencent.com>
References: <1599731444-3525-1-git-send-email-wanpengli@tencent.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Wanpeng Li <wanpengli@tencent.com>

Moving the call to svm_exit_handlers_fastpath() after svm_complete_interrupts()
since svm_complete_interrupts() consumes rip and reenable the function
handle_fastpath_set_msr_irqoff() call in svm_exit_handlers_fastpath().

Suggested-by: Sean Christopherson <sean.j.christopherson@intel.com>
Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
Cc: Paul K. <kronenpj@kronenpj.dyndns.org>
Signed-off-by: Wanpeng Li <wanpengli@tencent.com>
---
 arch/x86/kvm/svm/svm.c | 11 ++++++++++-
 1 file changed, 10 insertions(+), 1 deletion(-)

diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index dafc14d..b3e3429 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3347,6 +3347,10 @@ static void svm_cancel_injection(struct kvm_vcpu *vcpu)
 
 static fastpath_t svm_exit_handlers_fastpath(struct kvm_vcpu *vcpu)
 {
+	if (to_svm(vcpu)->vmcb->control.exit_code == SVM_EXIT_MSR &&
+	    to_svm(vcpu)->vmcb->control.exit_info_1)
+		return handle_fastpath_set_msr_irqoff(vcpu);
+
 	return EXIT_FASTPATH_NONE;
 }
 
@@ -3495,7 +3499,6 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
 	stgi();
 
 	/* Any pending NMI will happen here */
-	exit_fastpath = svm_exit_handlers_fastpath(vcpu);
 
 	if (unlikely(svm->vmcb->control.exit_code == SVM_EXIT_NMI))
 		kvm_after_interrupt(&svm->vcpu);
@@ -3530,6 +3533,12 @@ static __no_kcsan fastpath_t svm_vcpu_run(struct kvm_vcpu *vcpu)
 
 	svm_complete_interrupts(svm);
 	vmcb_mark_all_clean(svm->vmcb);
+
+	if (is_guest_mode(vcpu))
+		return EXIT_FASTPATH_NONE;
+
+	exit_fastpath = svm_exit_handlers_fastpath(vcpu);
+
 	return exit_fastpath;
 }
 
-- 
2.7.4

