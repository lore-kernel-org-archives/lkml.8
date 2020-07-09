Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 978E7C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:57:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 726E020775
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 17:57:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Ue9UWeIh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728436AbgGIR5Z (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 13:57:25 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:31996 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726758AbgGIR5Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 13:57:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1594317443;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=rtpxiZIC9DpP6xJFiIycdqh94KkxS8BGOIOnHFuI6lM=;
        b=Ue9UWeIhkv9ff//+nOOcXUDv98oX4GwdFePVx90Wx/66XqEto8k4J5AobFUFgU00jNG6cN
        Z9/fcAJlGbbH40aiBZ8c1rsjtAkVeCCPNV0Y/MG4uqryMCJzXssvK39v+zfJfgEdpW8DCH
        +Sf0h6UL2FyNsiNXu2vm0duFsfWvJIU=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-256-bUlZyC7qO0mZhk5axrFJxA-1; Thu, 09 Jul 2020 13:57:21 -0400
X-MC-Unique: bUlZyC7qO0mZhk5axrFJxA-1
Received: by mail-wr1-f71.google.com with SMTP id f5so2599510wrv.22
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 10:57:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=rtpxiZIC9DpP6xJFiIycdqh94KkxS8BGOIOnHFuI6lM=;
        b=njfsUguMaZoO9iQTFpGhpPxnSCRNGC3V8Ff1EGiuT5RnuX5fnxBK60J17IuTn5JVzV
         DHOv9VBGBebAS5Utci/mOYY+jFWFyLqrUP/NUSLbew31mixLsZ97eaSgCOiId+fM0N0l
         iTQQEDFm08f7w0P1OlUiUJIMScaohxyglH2dXgn3nVNf3fLCiYtUvGiF2BBfn7UwfZT0
         3x1Vu/TUVkTDl+/0BaO/wsd+E54ziDdgOFgYbQxiEcvmxDl32Z5YwiLJvH7uB1xnwyfK
         KmbsOG2QcijX+SHZBzFOxRP9j2uj8gNoofSN/2OAb5LazEvwCV5BKV/t+PhRKJOztQ7q
         0jiA==
X-Gm-Message-State: AOAM533onTgomE/NXzwE6pf6fhJMYb0pPzxs/NXoi9cm91B41IU6AeYq
        MNhh+C/461Ssfi0KXgI4wylwqD3VEiJWS5tFsJpheb52fSbOqXdUPalSOhSjzBiuLPWIBxb9VlB
        CydjYzBBDfdBQDjOt6doAXjZx
X-Received: by 2002:a7b:cc85:: with SMTP id p5mr1178744wma.18.1594317440359;
        Thu, 09 Jul 2020 10:57:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx816lR7V68tmogTqyiFqHKuAvOPgpQwxxuTWOciDQGLYuS7UzzPPkmPiIBoJAvQFDceCtG9w==
X-Received: by 2002:a7b:cc85:: with SMTP id p5mr1178730wma.18.1594317440116;
        Thu, 09 Jul 2020 10:57:20 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:9541:9439:cb0f:89c? ([2001:b07:6468:f312:9541:9439:cb0f:89c])
        by smtp.gmail.com with ESMTPSA id w128sm5899563wmb.19.2020.07.09.10.57.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 10:57:19 -0700 (PDT)
Subject: Re: [PATCH v3 7/9] KVM: nSVM: implement nested_svm_load_cr3() and use
 it for host->guest switch
To:     Vitaly Kuznetsov <vkuznets@redhat.com>, kvm@vger.kernel.org
Cc:     Sean Christopherson <sean.j.christopherson@intel.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Junaid Shahid <junaids@google.com>,
        linux-kernel@vger.kernel.org
References: <20200709145358.1560330-1-vkuznets@redhat.com>
 <20200709145358.1560330-8-vkuznets@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4d3f5b01-72d9-c2c5-08e8-c2b1e0046e5e@redhat.com>
Date:   Thu, 9 Jul 2020 19:57:17 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200709145358.1560330-8-vkuznets@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/07/20 16:53, Vitaly Kuznetsov wrote:
> +	if (nested_npt_enabled(svm))
> +		nested_svm_init_mmu_context(&svm->vcpu);
> +
>  	ret = nested_svm_load_cr3(&svm->vcpu, nested_vmcb->save.cr3,
>  				  nested_npt_enabled(svm));

This needs to be done in svm_set_nested_state, so my suggestion is that
the previous patch includes a call to nested_svm_load_cr3 in
svm_set_nested_state, and this one adds the "if" inside
nested_svm_load_cr3 itself.

Paolo

> @@ -364,13 +388,6 @@ static int nested_prepare_vmcb_save(struct vcpu_svm *svm, struct vmcb *nested_vm
>  static void nested_prepare_vmcb_control(struct vcpu_svm *svm)
>  {
>  	const u32 mask = V_INTR_MASKING_MASK | V_GIF_ENABLE_MASK | V_GIF_MASK;
> -	if (nested_npt_enabled(svm))
> -		nested_svm_init_mmu_context(&svm->vcpu);
> -
> -	/* Guest paging mode is active - reset mmu */
> -	kvm_mmu_reset_context(&svm->vcpu);
> -
> -	svm_flush_tlb(&svm->vcpu);
>  

