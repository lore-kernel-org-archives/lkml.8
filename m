Return-Path: <SRS0=3tRb=3K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2158DC33CB6
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:12:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E1C1C24653
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jan 2020 11:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="MSFOt2+a"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729602AbgAULMS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 06:12:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:33536 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729508AbgAULMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 06:12:16 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579605134;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=SUmH5ZMutw7kgyRL+tUGBiFKuqlrQTYA6wv/vKtVsig=;
        b=MSFOt2+accEUdESn2VGs18YipXtcz1qzy7yDxGK9d6JeKnHaAcRxJiMCVcEkFIG6pODgs9
        uVcZVr86fm/mK8fC/u9GlaNGMDF9yn+qlTQx1/iil7ambpLysj3moDOUSAvpkudueRDWlH
        EvclFrIHuUhYVKerWO0eqIuqfPNCe0w=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-293-o5y8wX_IMi2f8o4Ap8-QUA-1; Tue, 21 Jan 2020 06:12:13 -0500
X-MC-Unique: o5y8wX_IMi2f8o4Ap8-QUA-1
Received: by mail-wm1-f69.google.com with SMTP id q206so479635wme.9
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jan 2020 03:12:13 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=SUmH5ZMutw7kgyRL+tUGBiFKuqlrQTYA6wv/vKtVsig=;
        b=C/zkDAM/B5S7+CfsSDUyDlmC8JiixyVH/RpZoMY8Hw2uJvAuIdMVikGrmroptS0+KX
         CKpf2U8Gy5TG+jnmTEhH+zSww0lRkGaIU0CjNkdFJODJxHAVGI4GjKcwciM0M4uSiWyg
         Sq1izH95W81VvlJZrq2NfScShpc6psIb8B4vTWwgDEfvn+aba282dATyeSmnHG+LAKX+
         oaDk+N20oO4V7jT2UYtFCDKRccZulGrl5/V6ptIg4wljO4jcGFb5H1LreQ/dZPaZrGFR
         cUkaI0++hKBE/iRi1OD2id8R1t/Q7CKhJX4IHdKMvoCq5+y8A7LR6tPt9AuFRjIvgFzF
         I2FQ==
X-Gm-Message-State: APjAAAXPChYJSurfA1u5qPUJm3pMAR1/A2lBEqtxhSJU+xPN/Q/UkpQ6
        2MxOXZstBckW9oQ0E5K9ljqMuoY6FH7Y6+A78DFYUbKERYBIOx5XImNhqCzLFLhiQe/4wsGD3Kz
        mtZQn6/hfMkwVqUCTdhzbP12Z
X-Received: by 2002:a05:6000:11c9:: with SMTP id i9mr4806248wrx.164.1579605131969;
        Tue, 21 Jan 2020 03:12:11 -0800 (PST)
X-Google-Smtp-Source: APXvYqypfAKKGH/a848HhEdWp/8kNPn20JC8kc1fEqjae+lABJTb9oaxjSSRLWrYZHNDzVwQwM45Kg==
X-Received: by 2002:a05:6000:11c9:: with SMTP id i9mr4806191wrx.164.1579605131619;
        Tue, 21 Jan 2020 03:12:11 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:b509:fc01:ee8a:ca8a? ([2001:b07:6468:f312:b509:fc01:ee8a:ca8a])
        by smtp.gmail.com with ESMTPSA id z8sm51076203wrq.22.2020.01.21.03.12.09
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 21 Jan 2020 03:12:11 -0800 (PST)
Subject: Re: [PATCH v2 41/45] KVM: PPC: Move all vcpu init code into
 kvm_arch_vcpu_create()
To:     Paul Mackerras <paulus@ozlabs.org>,
        Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Marc Zyngier <maz@kernel.org>, James Hogan <jhogan@kernel.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Janosch Frank <frankja@linux.ibm.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        David Hildenbrand <david@redhat.com>,
        Cornelia Huck <cohuck@redhat.com>,
        Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>,
        linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-mips@vger.kernel.org, kvm-ppc@vger.kernel.org,
        kvm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Greg Kurz <groug@kaod.org>
References: <20191218215530.2280-1-sean.j.christopherson@intel.com>
 <20191218215530.2280-42-sean.j.christopherson@intel.com>
 <20200120034658.GD14307@blackberry>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <d3d465b0-6a45-c754-0538-1e4d1e130357@redhat.com>
Date:   Tue, 21 Jan 2020 12:12:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200120034658.GD14307@blackberry>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/01/20 04:46, Paul Mackerras wrote:
> On Wed, Dec 18, 2019 at 01:55:26PM -0800, Sean Christopherson wrote:
>> Fold init() into create() now that the two are called back-to-back by
>> common KVM code (kvm_vcpu_init() calls kvm_arch_vcpu_init() as its last
>> action, and kvm_vm_ioctl_create_vcpu() calls kvm_arch_vcpu_create()
>> immediately thereafter).  Rinse and repeat for kvm_arch_vcpu_uninit()
>> and kvm_arch_vcpu_destroy().  This paves the way for removing
>> kvm_arch_vcpu_{un}init() entirely.
>>
>> Note, calling kvmppc_mmu_destroy() if kvmppc_core_vcpu_create() fails
>> may or may not be necessary.  Move it along with the more obvious call
>> to kvmppc_subarch_vcpu_uninit() so as not to inadvertantly introduce a
>> functional change and/or bug.
>>
>> No functional change intended.
>>
>> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> 
> This doesn't compile.  I get:
> 
>   CC [M]  arch/powerpc/kvm/powerpc.o
> /home/paulus/kernel/kvm/arch/powerpc/kvm/powerpc.c: In function ‘kvm_arch_vcpu_create’:
> /home/paulus/kernel/kvm/arch/powerpc/kvm/powerpc.c:733:34: error: ‘kvmppc_decrementer_wakeup’ undeclared (first use in this function)
>   vcpu->arch.dec_timer.function = kvmppc_decrementer_wakeup;
>                                   ^
> /home/paulus/kernel/kvm/arch/powerpc/kvm/powerpc.c:733:34: note: each undeclared identifier is reported only once for each function it appears in
> /home/paulus/kernel/kvm/arch/powerpc/kvm/powerpc.c: At top level:
> /home/paulus/kernel/kvm/arch/powerpc/kvm/powerpc.c:794:29: warning: ‘kvmppc_decrementer_wakeup’ defined but not used [-Wunused-function]
>  static enum hrtimer_restart kvmppc_decrementer_wakeup(struct hrtimer *timer)
>                              ^
> make[3]: *** [/home/paulus/kernel/kvm/scripts/Makefile.build:266: arch/powerpc/kvm/powerpc.o] Error 1
> 
> The problem is that kvmppc_decrementer_wakeup() is a static function
> defined in this file (arch/powerpc/kvm/powerpc.c) after
> kvm_arch_vcpu_create() but before kvm_arch_vcpu_init().  You need a
> forward static declaration of kvmppc_decrementer_wakeup() before
> kvm_arch_vcpu_create(), or else move one or other function.
> 
> Paul.
> 

Squashed:

diff --git a/arch/powerpc/kvm/powerpc.c b/arch/powerpc/kvm/powerpc.c
index 91cf94d4191e..4fbf8690b8c5 100644
--- a/arch/powerpc/kvm/powerpc.c
+++ b/arch/powerpc/kvm/powerpc.c
@@ -725,6 +725,16 @@ int kvm_arch_vcpu_precreate(struct kvm *kvm, unsigned int id)
 	return 0;
 }
 
+static enum hrtimer_restart kvmppc_decrementer_wakeup(struct hrtimer *timer)
+{
+	struct kvm_vcpu *vcpu;
+
+	vcpu = container_of(timer, struct kvm_vcpu, arch.dec_timer);
+	kvmppc_decrementer_func(vcpu);
+
+	return HRTIMER_NORESTART;
+}
+
 int kvm_arch_vcpu_create(struct kvm_vcpu *vcpu)
 {
 	int err;
@@ -791,16 +801,6 @@ int kvm_cpu_has_pending_timer(struct kvm_vcpu *vcpu)
 	return kvmppc_core_pending_dec(vcpu);
 }
 
-static enum hrtimer_restart kvmppc_decrementer_wakeup(struct hrtimer *timer)
-{
-	struct kvm_vcpu *vcpu;
-
-	vcpu = container_of(timer, struct kvm_vcpu, arch.dec_timer);
-	kvmppc_decrementer_func(vcpu);
-
-	return HRTIMER_NORESTART;
-}
-
 int kvm_arch_vcpu_init(struct kvm_vcpu *vcpu)
 {
 	return 0;

Paolo

