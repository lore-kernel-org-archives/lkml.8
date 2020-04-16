Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_GIT,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84F57C352BE
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 19:12:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 630D520786
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 19:12:23 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="do1iupJT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730864AbgDPTMW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 15:12:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727989AbgDPTMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 15:12:19 -0400
Received: from mail-qv1-xf49.google.com (mail-qv1-xf49.google.com [IPv6:2607:f8b0:4864:20::f49])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 79226C061A0F
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 12:12:19 -0700 (PDT)
Received: by mail-qv1-xf49.google.com with SMTP id t16so4222203qve.22
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 12:12:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:message-id:mime-version:subject:from:to:cc;
        bh=akfUqnFcHbR4ypUK0waDS6vSsDmt70xk58DkBEhixQg=;
        b=do1iupJTFmsxaH3hlHdr4r/sVdtkohH+o2zKk5OnjDlNtdtq3IgMnNQa8oe9bE9tZk
         T7mxam+uL1lKWTS8eclSdD7tNmxvzRuDzLNZvuzmBY2aoNC1RfGeZKXD/EBeuzFzfWIr
         WJZHHWVuGV/SQF4RzrES/bJXAM4lLssSGx4Ijqqa7pY431PrVSte603yTzBazwmOOy53
         Dg9NPpvOUyl+7bSOHXZSLJKN9qN0YpEVLIZrVCuHHAipr+4tm5tVqHqFuiUbpTofL1cE
         +92D4EfDi2Egn+PC7ABAi7lUqTDDkEKceV3jg+kju8Mw+tV08GZ10XV89Fi9XWU7/tHb
         prQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:message-id:mime-version:subject:from:to:cc;
        bh=akfUqnFcHbR4ypUK0waDS6vSsDmt70xk58DkBEhixQg=;
        b=dI5Au0bxsaaFN08QnHuKWygFXhZs8/ltD11U3p73WFw7sk/Plrv0eRDXJCaXNZrOTz
         NarQMbEmZQLSGPpPMqJlvfl7iRmMUcV34dY0zag12aHPDKaTEPRLA71Lxuz7COzq0Ptp
         PnFrbLbKbcGy0zA+enQdSJ88MMitR/6/HwXrpsE1iyZN9arnVBQfgln7yXHZiOYl96yn
         ItHmKiAjvWhqQEShmk7quVtMZfDOExr8y6/8ClTQlixDrd84TsxjlU2qwcNU0otmYblA
         zJUqwUsf9zgXM2Ap48ioWIKRu15Mjg70M+AZIvKTfPGh6NF9+JwKrBUu7zu1gNawGSrI
         eTyQ==
X-Gm-Message-State: AGi0PuboFqMTBoyslq8djZ3CSLpon9W1yPqNMnzii8KUsj5AT9a+XcdY
        JUmQHl2FqZDz3IxVJ7ucjODHIwgRen0t6g==
X-Google-Smtp-Source: APiQypLttKT3SWY83gbGGp6Kj1Y4LsKg53UpN8WjCnn4NxYVGBQ/lOGRM1gn8dXlfLwC/TTmCRtAPeP7DJHcuw==
X-Received: by 2002:ad4:5546:: with SMTP id v6mr12063970qvy.11.1587064337976;
 Thu, 16 Apr 2020 12:12:17 -0700 (PDT)
Date:   Thu, 16 Apr 2020 12:11:52 -0700
Message-Id: <20200416191152.259434-1-jcargill@google.com>
Mime-Version: 1.0
X-Mailer: git-send-email 2.26.1.301.g55bc3eb7cb9-goog
Subject: [PATCH] KVM: Remove CREATE_IRQCHIP/SET_PIT2 race
From:   Jon Cargille <jcargill@google.com>
To:     Paolo Bonzini <pbonzini@redhat.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org
Cc:     Steve Rutherford <srutherford@google.com>,
        Jon Cargille <jcargill@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steve Rutherford <srutherford@google.com>

Fixes a NULL pointer dereference, caused by the PIT firing an interrupt
before the interrupt table has been initialized.

SET_PIT2 can race with the creation of the IRQchip. In particular,
if SET_PIT2 is called with a low PIT timer period (after the creation of
the IOAPIC, but before the instantiation of the irq routes), the PIT can
fire an interrupt at an uninitialized table.

Signed-off-by: Steve Rutherford <srutherford@google.com>
Signed-off-by: Jon Cargille <jcargill@google.com>
Reviewed-by: Jim Mattson <jmattson@google.com>
---
 arch/x86/kvm/x86.c | 10 ++++++++--
 1 file changed, 8 insertions(+), 2 deletions(-)

diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
index 027dfd278a973..3cc3f673785c8 100644
--- a/arch/x86/kvm/x86.c
+++ b/arch/x86/kvm/x86.c
@@ -5049,10 +5049,13 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&u.ps, argp, sizeof(u.ps)))
 			goto out;
+		mutex_lock(&kvm->lock);
 		r = -ENXIO;
 		if (!kvm->arch.vpit)
-			goto out;
+			goto set_pit_out;
 		r = kvm_vm_ioctl_set_pit(kvm, &u.ps);
+set_pit_out:
+		mutex_unlock(&kvm->lock);
 		break;
 	}
 	case KVM_GET_PIT2: {
@@ -5072,10 +5075,13 @@ long kvm_arch_vm_ioctl(struct file *filp,
 		r = -EFAULT;
 		if (copy_from_user(&u.ps2, argp, sizeof(u.ps2)))
 			goto out;
+		mutex_lock(&kvm->lock);
 		r = -ENXIO;
 		if (!kvm->arch.vpit)
-			goto out;
+			goto set_pit2_out;
 		r = kvm_vm_ioctl_set_pit2(kvm, &u.ps2);
+set_pit2_out:
+		mutex_unlock(&kvm->lock);
 		break;
 	}
 	case KVM_REINJECT_CONTROL: {
-- 
2.26.0.110.g2183baf09c-goog

