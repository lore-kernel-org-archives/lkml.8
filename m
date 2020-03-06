Return-Path: <SRS0=glOU=4X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 23978C10F00
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:06:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F10742070A
	for <linux-kernel@archiver.kernel.org>; Fri,  6 Mar 2020 10:06:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Fbq6E4aa"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726240AbgCFKG5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 6 Mar 2020 05:06:57 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:29371 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726026AbgCFKG5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 Mar 2020 05:06:57 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583489215;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=CNDhmKPPyjU/I8ZjQqjbJHAaz9m6Pife/JBLkiK4lO0=;
        b=Fbq6E4aayTeqC7ax+TfWPFZsVBHiViY7afgvbA8Ynj4Whh9AsPmqmEIkzTvrmq6nGV6TCF
        HlwX4pjGvfVRqaJvBmsuXdOWsrpdAyvXQZg9+q6tkRwweXnBXJfrAOlYwVTmq2tyw60Css
        frJ1p70NGJpEaJCkOYZ1LwqKlKxYkZI=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-260-FUtuVDmlO923cxEjUIiV-Q-1; Fri, 06 Mar 2020 05:06:54 -0500
X-MC-Unique: FUtuVDmlO923cxEjUIiV-Q-1
Received: by mail-wr1-f70.google.com with SMTP id 72so790176wrc.6
        for <linux-kernel@vger.kernel.org>; Fri, 06 Mar 2020 02:06:54 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:to:cc:subject:in-reply-to:references:date
         :message-id:mime-version;
        bh=CNDhmKPPyjU/I8ZjQqjbJHAaz9m6Pife/JBLkiK4lO0=;
        b=IKRFm1Q8P8gekoRXAw8906klVYaANFBgqQAFXWM31pn4ghRcKnOny9O1GayjMB8kgy
         FFhfClF4N2WtJByBRwUL3R8A7oFjfCFuPg2EsuoUlbRCnUQ5O+4wMbX2rfrf4Jz23O8O
         vyLlaTaf3o2Z6fWjZmDQ1ZfbTeyR37lUWsb+9L+bSWmFmsOsE0eHggsRpMB6Emkz8UuD
         fp1j2fWxwXqqXuet6d4963in2KAAsO+kYtGTYxoJfQlWXXm2g9xrx0oc5CodmCACc1r2
         SL17T9MVZsYAHyM2Zm9syt92YydrzaNPt8ITDxbUZVJyO/JLe9Ymh38jI0XfDagqf+5E
         ATew==
X-Gm-Message-State: ANhLgQ11v4f7tABeen2NObwbgLQiSKXCBdOitenuhZEALBgPEYKRzYrT
        rd0YNH5hNV7zifD+AjQcAIO3mfBtYirAifvLsBfMsMti7YBWR/wUdQpUmZIPtUcFuA0yqajZnDA
        dS1wvC0dkiUUyxdSYVoBEuRDP
X-Received: by 2002:a05:600c:2f01:: with SMTP id r1mr3145204wmn.31.1583489213314;
        Fri, 06 Mar 2020 02:06:53 -0800 (PST)
X-Google-Smtp-Source: ADFU+vsCpKnLythwz5ylIW58CeFo2DLM+USTBNualw4sqyWdiqnoAs2Lj09ZRAWLj+zXfMhkGZXnnA==
X-Received: by 2002:a05:600c:2f01:: with SMTP id r1mr3145181wmn.31.1583489213031;
        Fri, 06 Mar 2020 02:06:53 -0800 (PST)
Received: from vitty.brq.redhat.com (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id s2sm10338017wmj.15.2020.03.06.02.06.52
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 06 Mar 2020 02:06:52 -0800 (PST)
From:   Vitaly Kuznetsov <vkuznets@redhat.com>
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        Jim Mattson <jmattson@google.com>,
        Wanpeng Li <wanpengli@tencent.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 2/2] KVM: VMX: untangle VMXON revision_id setting when using eVMCS
In-Reply-To: <20200305201000.GQ11500@linux.intel.com>
References: <20200305183725.28872-1-vkuznets@redhat.com> <20200305183725.28872-3-vkuznets@redhat.com> <20200305201000.GQ11500@linux.intel.com>
Date:   Fri, 06 Mar 2020 11:06:51 +0100
Message-ID: <87pndper0k.fsf@vitty.brq.redhat.com>
MIME-Version: 1.0
Content-Type: text/plain
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Sean Christopherson <sean.j.christopherson@intel.com> writes:

> On Thu, Mar 05, 2020 at 07:37:25PM +0100, Vitaly Kuznetsov wrote:
>> As stated in alloc_vmxon_regions(), VMXON region needs to be tagged with
>> revision id from MSR_IA32_VMX_BASIC even in case of eVMCS. The logic to
>> do so is not very straightforward: first, we set
>> hdr.revision_id = KVM_EVMCS_VERSION in alloc_vmcs_cpu() just to reset it
>> back to vmcs_config.revision_id in alloc_vmxon_regions(). Simplify this by
>> introducing 'enum vmcs_type' parameter to alloc_vmcs_cpu().
>> 
>> No functional change intended.
>> 
>> Signed-off-by: Vitaly Kuznetsov <vkuznets@redhat.com>
>> ---
>
> ...
>
>> +	 * However, even though not explicitly documented by TLFS, VMXArea
>> +	 * passed as VMXON argument should still be marked with revision_id
>> +	 * reported by physical CPU.
>
> LOL, nice.
>
>
>> +	 */
>> +	if (type != VMXON_REGION && static_branch_unlikely(&enable_evmcs))
>>  		vmcs->hdr.revision_id = KVM_EVMCS_VERSION;
>>  	else
>>  		vmcs->hdr.revision_id = vmcs_config.revision_id;
>>  
>> -	if (shadow)
>> +	if (type == SHADOW_VMCS_REGION)
>>  		vmcs->hdr.shadow_vmcs = 1;
>>  	return vmcs;
>>  }
>
>> -struct vmcs *alloc_vmcs_cpu(bool shadow, int cpu, gfp_t flags);
>> +enum vmcs_type {
>> +	VMXON_REGION,
>> +	VMCS_REGION,
>> +	SHADOW_VMCS_REGION,
>> +};
>> +
>> +struct vmcs *alloc_vmcs_cpu(enum vmcs_type type, int cpu, gfp_t flags);
>>  void free_vmcs(struct vmcs *vmcs);
>>  int alloc_loaded_vmcs(struct loaded_vmcs *loaded_vmcs);
>>  void free_loaded_vmcs(struct loaded_vmcs *loaded_vmcs);
>> @@ -498,8 +504,8 @@ void loaded_vmcs_clear(struct loaded_vmcs *loaded_vmcs);
>>  
>>  static inline struct vmcs *alloc_vmcs(bool shadow)
>
> I think it'd be cleaner overall to take "enum vmcs_type" in alloc_vmcs().
> Then the ternary operator goes away and the callers (all two of 'em) are
> self-documenting.

Ya, it didn't seem to be needed with my initial suggestion to rename
alloc_vmcs_cpu() to alloc_vmx_area_cpu() because in case we think of
VMXON region as something different from VMCS we have only two options:
normal VMCS or shadow VMCS and bool flag works perfectly. 

v3 is on the way, stay tuned!

-- 
Vitaly

