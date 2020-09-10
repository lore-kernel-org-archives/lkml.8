Return-Path: <SRS0=87nF=CT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.7 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CE0F3C43461
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:29:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 725BB21582
	for <linux-kernel@archiver.kernel.org>; Thu, 10 Sep 2020 09:29:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="eJYy6KcJ";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="4cOWEQB8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730541AbgIJJ25 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 10 Sep 2020 05:28:57 -0400
Received: from Galois.linutronix.de ([193.142.43.55]:38770 "EHLO
        galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726760AbgIJJYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Sep 2020 05:24:50 -0400
Date:   Thu, 10 Sep 2020 09:22:32 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1599729753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=waOhnApw4DEgx9hr87nH7NORcVbk0UNIN1hhdaafTEg=;
        b=eJYy6KcJrGBpLfL1+7SnHMEixSfUy1uYu6CfxPuWxTu5UrbtKUfTP1F9iNQN8T/ToIQE++
        02NdEkEY73J2pJWFAmfFjMlojU15zbb96XMwttdurlvJ4JwZN+Zuy2OiPZOm7QHDn4xST0
        7jpbHBcjw6rul9XGuik64MjCqP/4LXCJhc2OwfgL2gcWF+iwFvEhMyk3eLPKSXP6O16V1c
        MUL1cB3nbPl+LOj7kvbuUBWQjjVqS8RQiDB048TA/gTnpWBkEaPF+ZXhefJSROyUsCxc8W
        g6GjqjclmDu/iOXZ5Tl5iGsSIzL3tDzZurnf01mVItgUdHFA2VeY89B/MqFvBg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1599729753;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=waOhnApw4DEgx9hr87nH7NORcVbk0UNIN1hhdaafTEg=;
        b=4cOWEQB8fQ5YvBt4eku0bHJAy8pqYZ8j+N4edPCf4McfZMoUZ35hDD+MRuEHAWzYLR2lkj
        5FbinB7lZbcdMQBQ==
From:   "tip-bot2 for Joerg Roedel" <tip-bot2@linutronix.de>
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: x86/seves] KVM: SVM: nested: Don't allocate VMCB structures on stack
Cc:     Joerg Roedel <jroedel@suse.de>, Borislav Petkov <bp@suse.de>,
        x86 <x86@kernel.org>, LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <20200907131613.12703-2-joro@8bytes.org>
References: <20200907131613.12703-2-joro@8bytes.org>
MIME-Version: 1.0
Message-ID: <159972975236.20229.18110270119211940448.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2.linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the x86/seves branch of tip:

Commit-ID:     6ccbd29ade0d159ee1be398dc9defaae567c253d
Gitweb:        https://git.kernel.org/tip/6ccbd29ade0d159ee1be398dc9defaae567c253d
Author:        Joerg Roedel <jroedel@suse.de>
AuthorDate:    Mon, 07 Sep 2020 15:15:02 +02:00
Committer:     Borislav Petkov <bp@suse.de>
CommitterDate: Mon, 07 Sep 2020 19:45:24 +02:00

KVM: SVM: nested: Don't allocate VMCB structures on stack

Do not allocate a vmcb_control_area and a vmcb_save_area on the stack,
as these structures will become larger with future extenstions of
SVM and thus the svm_set_nested_state() function will become a too large
stack frame.

Signed-off-by: Joerg Roedel <jroedel@suse.de>
Signed-off-by: Borislav Petkov <bp@suse.de>
Link: https://lkml.kernel.org/r/20200907131613.12703-2-joro@8bytes.org
---
 arch/x86/kvm/svm/nested.c | 47 ++++++++++++++++++++++++++------------
 1 file changed, 33 insertions(+), 14 deletions(-)

diff --git a/arch/x86/kvm/svm/nested.c b/arch/x86/kvm/svm/nested.c
index fb68467..2803662 100644
--- a/arch/x86/kvm/svm/nested.c
+++ b/arch/x86/kvm/svm/nested.c
@@ -1060,10 +1060,14 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	struct vmcb *hsave = svm->nested.hsave;
 	struct vmcb __user *user_vmcb = (struct vmcb __user *)
 		&user_kvm_nested_state->data.svm[0];
-	struct vmcb_control_area ctl;
-	struct vmcb_save_area save;
+	struct vmcb_control_area *ctl;
+	struct vmcb_save_area *save;
+	int ret;
 	u32 cr0;
 
+	BUILD_BUG_ON(sizeof(struct vmcb_control_area) + sizeof(struct vmcb_save_area) >
+		     KVM_STATE_NESTED_SVM_VMCB_SIZE);
+
 	if (kvm_state->format != KVM_STATE_NESTED_FORMAT_SVM)
 		return -EINVAL;
 
@@ -1095,13 +1099,22 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 		return -EINVAL;
 	if (kvm_state->size < sizeof(*kvm_state) + KVM_STATE_NESTED_SVM_VMCB_SIZE)
 		return -EINVAL;
-	if (copy_from_user(&ctl, &user_vmcb->control, sizeof(ctl)))
-		return -EFAULT;
-	if (copy_from_user(&save, &user_vmcb->save, sizeof(save)))
-		return -EFAULT;
 
-	if (!nested_vmcb_check_controls(&ctl))
-		return -EINVAL;
+	ret  = -ENOMEM;
+	ctl  = kzalloc(sizeof(*ctl),  GFP_KERNEL);
+	save = kzalloc(sizeof(*save), GFP_KERNEL);
+	if (!ctl || !save)
+		goto out_free;
+
+	ret = -EFAULT;
+	if (copy_from_user(ctl, &user_vmcb->control, sizeof(*ctl)))
+		goto out_free;
+	if (copy_from_user(save, &user_vmcb->save, sizeof(*save)))
+		goto out_free;
+
+	ret = -EINVAL;
+	if (!nested_vmcb_check_controls(ctl))
+		goto out_free;
 
 	/*
 	 * Processor state contains L2 state.  Check that it is
@@ -1109,15 +1122,15 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	 */
 	cr0 = kvm_read_cr0(vcpu);
         if (((cr0 & X86_CR0_CD) == 0) && (cr0 & X86_CR0_NW))
-                return -EINVAL;
+		goto out_free;
 
 	/*
 	 * Validate host state saved from before VMRUN (see
 	 * nested_svm_check_permissions).
 	 * TODO: validate reserved bits for all saved state.
 	 */
-	if (!(save.cr0 & X86_CR0_PG))
-		return -EINVAL;
+	if (!(save->cr0 & X86_CR0_PG))
+		goto out_free;
 
 	/*
 	 * All checks done, we can enter guest mode.  L1 control fields
@@ -1126,15 +1139,21 @@ static int svm_set_nested_state(struct kvm_vcpu *vcpu,
 	 * contains saved L1 state.
 	 */
 	copy_vmcb_control_area(&hsave->control, &svm->vmcb->control);
-	hsave->save = save;
+	hsave->save = *save;
 
 	svm->nested.vmcb = kvm_state->hdr.svm.vmcb_pa;
-	load_nested_vmcb_control(svm, &ctl);
+	load_nested_vmcb_control(svm, ctl);
 	nested_prepare_vmcb_control(svm);
 
 out_set_gif:
 	svm_set_gif(svm, !!(kvm_state->flags & KVM_STATE_NESTED_GIF_SET));
-	return 0;
+
+	ret = 0;
+out_free:
+	kfree(save);
+	kfree(ctl);
+
+	return ret;
 }
 
 struct kvm_x86_nested_ops svm_nested_ops = {
