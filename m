Return-Path: <SRS0=RI2K=4Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CDA67C3F2D2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:16:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9DDEE246AC
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Feb 2020 10:16:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="BLsyzh4j"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgB1KQS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Feb 2020 05:16:18 -0500
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:48961 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726626AbgB1KQR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Feb 2020 05:16:17 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1582884976;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=8Yuq0w99xWOCSYSMhOpYFNZZ7MnQhsxMdcr2Kk7+fsM=;
        b=BLsyzh4jatwVCEGpU3+gB9yEONiUDTIKHJYwvB3ha69n/j3bIOVozYgvuxs4gjRnhR43zz
        nbIlu5DxYD5wzBq/SiOiI5XiuT3pwbpdVyv5UumjgrbZotWv0bvtBnpkcgz9f4AFqW8rnL
        NWuM1q+nqxAr73kt/K6AXK9sntXK7vA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-182-Gmz7v2obM0uXOj3ZxVLm2A-1; Fri, 28 Feb 2020 05:16:14 -0500
X-MC-Unique: Gmz7v2obM0uXOj3ZxVLm2A-1
Received: by mail-wr1-f72.google.com with SMTP id f10so1142938wrv.1
        for <linux-kernel@vger.kernel.org>; Fri, 28 Feb 2020 02:16:14 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=8Yuq0w99xWOCSYSMhOpYFNZZ7MnQhsxMdcr2Kk7+fsM=;
        b=RoNGktcVcHinn3+Z2Chk9hTdwBSeIt7Oj3YZxCDH6LrdvjX4Q0Tj7Cm54sFjanrISa
         ZZbKAvM3AuenZv3g88Pi8fhdEdOcAt42VOzUwTPEdlfMulWIaYYqi0bajMzTEYffx9M8
         2nxqWQtM0YmnGL1lG/k1DxySZ5FFSzqs1aEHviHDN+mzeQ0THRUV+7qrv2ZSp9+P/v4O
         2Z+tMmktB4aJr11Pb7lYgjH2C/1Cz/Ix4vKVLCOo8u2v8W/WcLLpioqkbfmFXdfUMt70
         rv0EDCVtXFB4vcxkFw3/fs+Dw0FhGoDPDSsGZRwMKBAhIZ+CIrJjKWrBWr+4Wkl7r0Tf
         ztKw==
X-Gm-Message-State: APjAAAU2jLkys3DPp27MvAalnCgrVDPnudiEw9ssB6lsF/zn6LNACx2s
        I0KzN3jMt6WUjerSh9g73cocaTIi4AMMQjPR9WMbywWUOFcL3oyVIL8bhAWm8a1Aav/ArSqt/dG
        so9yJLlZTildHwVfCP4r0gxMQ
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr4093675wma.84.1582884972241;
        Fri, 28 Feb 2020 02:16:12 -0800 (PST)
X-Google-Smtp-Source: APXvYqww48iU01L+2UIHDN8maT/6XhdwCadWPyvh9i05KWipKkTPXTpA9aSzjcGgKDcRq+I5vQkURw==
X-Received: by 2002:a05:600c:2503:: with SMTP id d3mr4093643wma.84.1582884971917;
        Fri, 28 Feb 2020 02:16:11 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:d0d9:ea10:9775:f33f? ([2001:b07:6468:f312:d0d9:ea10:9775:f33f])
        by smtp.gmail.com with ESMTPSA id 133sm1683182wmd.5.2020.02.28.02.16.10
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 28 Feb 2020 02:16:11 -0800 (PST)
Subject: Re: [PATCH 1/3] KVM: VMX: Always VMCLEAR in-use VMCSes during crash
 with kexec support
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200227223047.13125-1-sean.j.christopherson@intel.com>
 <20200227223047.13125-2-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9edc8cef-9aa4-11ca-f8f2-a1fea990b87e@redhat.com>
Date:   Fri, 28 Feb 2020 11:16:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200227223047.13125-2-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 27/02/20 23:30, Sean Christopherson wrote:
> -void loaded_vmcs_init(struct loaded_vmcs *loaded_vmcs)
> +void loaded_vmcs_init(struct loaded_vmcs *loaded_vmcs, bool in_use)
>  {
>  	vmcs_clear(loaded_vmcs->vmcs);
>  	if (loaded_vmcs->shadow_vmcs && loaded_vmcs->launched)
>  		vmcs_clear(loaded_vmcs->shadow_vmcs);
> +
> +	if (in_use) {
> +		list_del(&loaded_vmcs->loaded_vmcss_on_cpu_link);
> +
> +		/*
> +		 * Ensure deleting loaded_vmcs from its current percpu list
> +		 * completes before setting loaded_vmcs->vcpu to -1, otherwise
> +		 * a different cpu can see vcpu == -1 first and add loaded_vmcs
> +		 * to its percpu list before it's deleted from this cpu's list.
> +		 * Pairs with the smp_rmb() in vmx_vcpu_load_vmcs().
> +		 */
> +		smp_wmb();
> +	}
> +

I'd like to avoid the new in_use argument and, also, I think it's a 
little bit nicer to always invoke the memory barrier.  Even though we 
use "asm volatile" for vmclear and therefore the compiler is already 
taken care of, in principle it's more correct to order the ->cpu write 
against vmclear's.

This gives the following patch on top:

diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
index c9d6152e7a4d..77a64110577b 100644
--- a/arch/x86/kvm/vmx/vmx.c
+++ b/arch/x86/kvm/vmx/vmx.c
@@ -656,25 +656,24 @@ static int vmx_set_guest_msr(struct vcpu_vmx *vmx, struct shared_msr_entry *msr,
 	return ret;
 }
 
-void loaded_vmcs_init(struct loaded_vmcs *loaded_vmcs, bool in_use)
+void loaded_vmcs_init(struct loaded_vmcs *loaded_vmcs)
 {
 	vmcs_clear(loaded_vmcs->vmcs);
 	if (loaded_vmcs->shadow_vmcs && loaded_vmcs->launched)
 		vmcs_clear(loaded_vmcs->shadow_vmcs);
 
-	if (in_use) {
+	if (!list_empty(&loaded_vmcs->loaded_vmcss_on_cpu_link))
 		list_del(&loaded_vmcs->loaded_vmcss_on_cpu_link);
 
-		/*
-		 * Ensure deleting loaded_vmcs from its current percpu list
-		 * completes before setting loaded_vmcs->vcpu to -1, otherwise
-		 * a different cpu can see vcpu == -1 first and add loaded_vmcs
-		 * to its percpu list before it's deleted from this cpu's list.
-		 * Pairs with the smp_rmb() in vmx_vcpu_load_vmcs().
-		 */
-		smp_wmb();
-	}
-
+	/*
+	 * Ensure all writes to loaded_vmcs, including deleting it
+	 * from its current percpu list, complete before setting
+	 * loaded_vmcs->vcpu to -1; otherwise,, a different cpu can
+	 * see vcpu == -1 first and add loaded_vmcs to its percpu
+	 * list before it's deleted from this cpu's list.  Pairs
+	 * with the smp_rmb() in vmx_vcpu_load_vmcs().
+	 */
+	smp_wmb();
 	loaded_vmcs->cpu = -1;
 	loaded_vmcs->launched = 0;
 }
@@ -701,7 +700,7 @@ static void __loaded_vmcs_clear(void *arg)
 	if (per_cpu(current_vmcs, cpu) == loaded_vmcs->vmcs)
 		per_cpu(current_vmcs, cpu) = NULL;
 
-	loaded_vmcs_init(loaded_vmcs, true);
+	loaded_vmcs_init(loaded_vmcs);
 }
 
 void loaded_vmcs_clear(struct loaded_vmcs *loaded_vmcs)
@@ -2568,7 +2567,8 @@ int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs)
 
 	loaded_vmcs->shadow_vmcs = NULL;
 	loaded_vmcs->hv_timer_soft_disabled = false;
-	loaded_vmcs_init(loaded_vmcs, false);
+	INIT_LIST_HEAD(&loaded_vmcs->loaded_vmcss_on_cpu_link);
+	loaded_vmcs_init(loaded_vmcs);
 
 	if (cpu_has_vmx_msr_bitmap()) {
 		loaded_vmcs->msr_bitmap = (unsigned long *)

Paolo

