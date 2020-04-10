Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EDB8C2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 16:05:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0F34B2078E
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 16:05:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Kcjra8yw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726691AbgDJQE7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 12:04:59 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:50163 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726177AbgDJQE7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 12:04:59 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586534698;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cxOJV+PXw0OWe981JdPu+MdBwKVnkcb6yaLM9gtV+Uw=;
        b=Kcjra8ywv9Jjuzx6WXeliOahC2e5rWyCJ4bd4zZKa7KNnvaFrTKnk0h0q4bhvVC/EdL0Kg
        PNMKq9p1p8cTK5d5JQJeF3yLTGyedzjooC9jaL5piiwiy5xBDNagXRQC3ovhoso2InTXIs
        3K4PMS72I95j/yNM+UY5BLqGU2itUe0=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-472-Glr7dZZ0Nu6Pp-bi6MoPdw-1; Fri, 10 Apr 2020 12:04:57 -0400
X-MC-Unique: Glr7dZZ0Nu6Pp-bi6MoPdw-1
Received: by mail-wr1-f70.google.com with SMTP id j12so1404391wrr.18
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 09:04:56 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=cxOJV+PXw0OWe981JdPu+MdBwKVnkcb6yaLM9gtV+Uw=;
        b=TNnZJJRN7mlc1wZSSyJfmu37b0VhD4+4TYeJCre2RoU4W1Ziq87xNOCK9IEo5pdnju
         M88XbtQhX6uCi6J8Qq2d7iekTaFunqZm7iuJBO0BJcd9g9xfyOtu4lxQ5IaWvxbxX11T
         xz5Khq4RvkZeHSCx3ELGXhTPLJ46TbWxaaXrLyNKarqutNUiaOVIhLJn5KLnqagqiQtZ
         bXtaG5/MxNUsbt4Juq7oIPt2AVYBucPtNxNcYczaSFH2xi2jzH//ITNHCcoaYCgyvFvD
         3aAGsGOgfZwZuFBUPShliTEOoS2o2OvZIJixfv8WiPQ44YPDC9V1JFx+eTSct02g83Q5
         rH8A==
X-Gm-Message-State: AGi0PuYvP+EZ3ZymejkKfaRDpLIhQjeRN/cWo4ZlyLvi5XFzGSslf3RF
        CggfRhyLV/aNm/+3B3pBThFwaZh5ncR3IRuXwjLF9H09F5Qc0sMjYGCxyYnpacFWGcEDL/+Fmq/
        lP6OG9E2Iau3M+czUwYkUYJeU
X-Received: by 2002:a1c:6545:: with SMTP id z66mr5590630wmb.81.1586534695911;
        Fri, 10 Apr 2020 09:04:55 -0700 (PDT)
X-Google-Smtp-Source: APiQypIUoTNzgT8EHUupmSiQmqAgjl7+0TQSoQpIjhsdXJ4SNG1cJk937+fQ4caZS5evjdxQhgMaNA==
X-Received: by 2002:a1c:6545:: with SMTP id z66mr5590603wmb.81.1586534695605;
        Fri, 10 Apr 2020 09:04:55 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:f4b7:b34c:3ace:efb6? ([2001:b07:6468:f312:f4b7:b34c:3ace:efb6])
        by smtp.gmail.com with ESMTPSA id j10sm3249165wru.85.2020.04.10.09.04.54
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 10 Apr 2020 09:04:54 -0700 (PDT)
Subject: Re: KCSAN + KVM = host reset
To:     Qian Cai <cai@lca.pw>, Marco Elver <elver@google.com>
Cc:     "paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org
References: <CANpmjNMR4BgfCxL9qXn0sQrJtQJbEPKxJ5_HEa2VXWi6UY4wig@mail.gmail.com>
 <AC8A5393-B817-4868-AA85-B3019A1086F9@lca.pw>
 <CANpmjNPqQHKUjqAzcFym5G8kHX0mjProOpGu8e4rBmuGRykAUg@mail.gmail.com>
 <B798749E-F2F0-4A14-AFE3-F386AB632AEB@lca.pw>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <1d6db024-82d1-5530-2e78-478ee333173e@redhat.com>
Date:   Fri, 10 Apr 2020 18:04:54 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <B798749E-F2F0-4A14-AFE3-F386AB632AEB@lca.pw>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/04/20 17:50, Qian Cai wrote:
> This works,
> 
> --- a/arch/x86/kvm/svm/svm.c
> +++ b/arch/x86/kvm/svm/svm.c
> @@ -3278,7 +3278,7 @@ static void svm_cancel_injection(struct kvm_vcpu *vcpu)
>  
>  bool __svm_vcpu_run(unsigned long vmcb_pa, unsigned long *regs);
>  
> -static void svm_vcpu_run(struct kvm_vcpu *vcpu)
> +static __no_kcsan void svm_vcpu_run(struct kvm_vcpu *vcpu)
>  {
>         struct vcpu_svm *svm = to_svm(vcpu);
> 
> Does anyone has any idea why svm_vcpu_run() would be a problem for KCSAN_INTERRUPT_WATCHER=y?

All of svm_vcpu_run() has interrupts disabled anyway, but perhaps KCSAN
checks the interrupt flag?  That could be a problem because
svm_vcpu_run() disables the interrupts with GIF not IF (and in fact
IF=1).

You can try this patch which moves the problematic section inside
the assembly language trampoline:

 
diff --git a/arch/x86/kvm/svm/svm.c b/arch/x86/kvm/svm/svm.c
index 27f4684a4c20..6ffa07d42e5e 100644
--- a/arch/x86/kvm/svm/svm.c
+++ b/arch/x86/kvm/svm/svm.c
@@ -3337,8 +3337,6 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 	 */
 	x86_spec_ctrl_set_guest(svm->spec_ctrl, svm->virt_spec_ctrl);
 
-	local_irq_enable();
-
 	__svm_vcpu_run(svm->vmcb_pa, (unsigned long *)&svm->vcpu.arch.regs);
 
	/* Eliminate branch target predictions from guest mode */
@@ -3373,8 +3368,6 @@ static void svm_vcpu_run(struct kvm_vcpu *vcpu)
 
 	reload_tss(vcpu);
 
-	local_irq_disable();
-
 	x86_spec_ctrl_restore_host(svm->spec_ctrl, svm->virt_spec_ctrl);
 
 	vcpu->arch.cr2 = svm->vmcb->save.cr2;
diff --git a/arch/x86/kvm/svm/vmenter.S b/arch/x86/kvm/svm/vmenter.S
index fa1af90067e9..a2608ede0975 100644
--- a/arch/x86/kvm/svm/vmenter.S
+++ b/arch/x86/kvm/svm/vmenter.S
@@ -78,6 +78,7 @@ SYM_FUNC_START(__svm_vcpu_run)
 	pop %_ASM_AX
 
 	/* Enter guest mode */
+	sti
 1:	vmload %_ASM_AX
 	jmp 3f
 2:	cmpb $0, kvm_rebooting
@@ -99,6 +100,8 @@ SYM_FUNC_START(__svm_vcpu_run)
 	ud2
 	_ASM_EXTABLE(5b, 6b)
 7:
+	cli
+
 	/* "POP" @regs to RAX. */
 	pop %_ASM_AX
 

Paolo

