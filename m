Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94B43C3F2D7
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:13:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E59320848
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:13:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OafLWsUn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727174AbgCEKN5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 05:13:57 -0500
Received: from mail-wr1-f68.google.com ([209.85.221.68]:42477 "EHLO
        mail-wr1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727067AbgCEKN4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 05:13:56 -0500
Received: by mail-wr1-f68.google.com with SMTP id v11so4294300wrm.9;
        Thu, 05 Mar 2020 02:13:55 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:to:cc:subject:date:message-id:in-reply-to:references;
        bh=4cPtlreV3CL6qZiIeDzuws4IJav/mV5BaDJqKCbYawY=;
        b=OafLWsUnM/1kmPD7KtLMTHejoDLDAvnms9/3ZbzBlWKee3Zicmg1F73LefZ7elPMlq
         Z8x04BrZcjpbZz9DUK/q9OgvNsLvhCsFRCzzWQEw9bc2rDXXchnxYwrOFzYtWm4HZ4uo
         C+MGtkCjmRUTxzwFfqA3Ta5mq6zV23DX3faEbbdKBXJpdf3Gwq585c9w/HEWAgDXA7oO
         5D1N0DkvMZdIcXi9RyFqHJLgQVxBOWGq/ImVGaMmmH5p6bWdK0JNJCWP2dVG0sWBAkYx
         79r8lbDslttu4ojkE5tYJMzi2b1Za7eV6JH3xWavBpn1w7c8nAEbc9aDUwLl8Pw7Ra1l
         PRlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:to:cc:subject:date:message-id
         :in-reply-to:references;
        bh=4cPtlreV3CL6qZiIeDzuws4IJav/mV5BaDJqKCbYawY=;
        b=R4GBxXIYMis/1XdAgK4ylSxwrwA4TwQssHUPDos5+es4XH9KkBnanxGh9hlv+BkWvj
         CCakUhuZO720mhUxDflTnYtdnco1RgGx+ZY5kPmTtP8ojua4/vaL9cbdGrzNguZlt9Bd
         M9jT/iP+Hjg5RFm5vqaQeuT5iKOKUqlWXcquux5FEb2UveCycyjpFQ2dojRb69MIFSHe
         mdqX4hXKErvDXbjrkRC5f+bFKsRqa9+7vJL0SP0f+ilR/Yq/4+tDf/SPyrm+VgL/ERBj
         gSYgZM/mQxd6vcCX55lntbu4f4fjEFOAy1cpnh/M6wd8JX/JnnsUODX8MQUanmpi39VR
         5PSg==
X-Gm-Message-State: ANhLgQ0rFYT0GxKymdpP3LI+ucHcBFzANyephwaZENjFJeQdJQrNBrRM
        a5Lw/gKXD1uS7zvcjNlETIrQ+BfC
X-Google-Smtp-Source: ADFU+vtBqAdjgrLdjZSQ1LmtNj/Y8C3TvswtEHlbg8pHuojHh8FqT20A+MXnh+tXxQKDYNku+ouoRQ==
X-Received: by 2002:adf:fcc2:: with SMTP id f2mr9342392wrs.199.1583403234220;
        Thu, 05 Mar 2020 02:13:54 -0800 (PST)
Received: from 640k.localdomain.com ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id p15sm8331066wma.40.2020.03.05.02.13.53
        (version=TLS1_2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 05 Mar 2020 02:13:53 -0800 (PST)
From:   Paolo Bonzini <pbonzini@redhat.com>
To:     linux-kernel@vger.kernel.org, kvm@vger.kernel.org
Cc:     cavery@redhat.com, vkuznets@redhat.com, jan.kiszka@siemens.com,
        wei.huang2@amd.com
Subject: [PATCH 4/4] KVM: nSVM: avoid loss of pending IRQ/NMI before entering L2
Date:   Thu,  5 Mar 2020 11:13:47 +0100
Message-Id: <1583403227-11432-5-git-send-email-pbonzini@redhat.com>
X-Mailer: git-send-email 1.8.3.1
In-Reply-To: <1583403227-11432-1-git-send-email-pbonzini@redhat.com>
References: <1583403227-11432-1-git-send-email-pbonzini@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch reproduces for nSVM the change that was made for nVMX in
commit b5861e5cf2fc ("KVM: nVMX: Fix loss of pending IRQ/NMI before
entering L2").  While I do not have a test that breaks without it, I
cannot see why it would not be necessary since all events are unblocked
by VMRUN's setting of GIF back to 1.

Signed-off-by: Paolo Bonzini <pbonzini@redhat.com>
---
 arch/x86/kvm/svm.c | 18 ++++++++++++++++++
 1 file changed, 18 insertions(+)

diff --git a/arch/x86/kvm/svm.c b/arch/x86/kvm/svm.c
index 0d773406f7ac..3df62257889a 100644
--- a/arch/x86/kvm/svm.c
+++ b/arch/x86/kvm/svm.c
@@ -3574,6 +3574,10 @@ static bool nested_vmcb_checks(struct vmcb *vmcb)
 static void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
 				 struct vmcb *nested_vmcb, struct kvm_host_map *map)
 {
+	bool evaluate_pending_interrupts =
+		is_intercept(svm, INTERCEPT_VINTR) ||
+		is_intercept(svm, INTERCEPT_IRET);
+
 	if (kvm_get_rflags(&svm->vcpu) & X86_EFLAGS_IF)
 		svm->vcpu.arch.hflags |= HF_HIF_MASK;
 	else
@@ -3660,7 +3664,21 @@ static void enter_svm_guest_mode(struct vcpu_svm *svm, u64 vmcb_gpa,
 
 	svm->nested.vmcb = vmcb_gpa;
 
+	/*
+	 * If L1 had a pending IRQ/NMI before executing VMRUN,
+	 * which wasn't delivered because it was disallowed (e.g.
+	 * interrupts disabled), L0 needs to evaluate if this pending
+	 * event should cause an exit from L2 to L1 or be delivered
+	 * directly to L2.
+	 *
+	 * Usually this would be handled by the processor noticing an
+	 * IRQ/NMI window request.  However, VMRUN can unblock interrupts
+	 * by implicitly setting GIF, so force L0 to perform pending event
+	 * evaluation by requesting a KVM_REQ_EVENT.
+	 */
 	enable_gif(svm);
+	if (unlikely(evaluate_pending_interrupts))
+		kvm_make_request(KVM_REQ_EVENT, &svm->vcpu);
 
 	mark_all_dirty(svm->vmcb);
 }
-- 
1.8.3.1

