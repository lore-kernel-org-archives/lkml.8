Return-Path: <SRS0=fZJt=4U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 690A7C3F2C6
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:31:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3F6FA2083E
	for <linux-kernel@archiver.kernel.org>; Tue,  3 Mar 2020 15:31:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="RZb6bQdI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729951AbgCCPbW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 3 Mar 2020 10:31:22 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:31328 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729416AbgCCPbW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 Mar 2020 10:31:22 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583249480;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7UvOLNGx6p9fKROK7cYc0KuMbdmUhd2L++fUFlqw33s=;
        b=RZb6bQdI1QYC/mdi4qJ//nV11GmHAsnvKCrLdu64p26wYs7x7tLys3yGNYUhsJrzNfI7vP
        OtGRrOzHIYQD94ciWavGA2CTLlnxxkmn4chNf1L2Wg8J9C9Ip6tMtVYwxO3InJJFnsMvX2
        dVRppO4kp8+HX5k3Ii1N8W0nE7CJ5fo=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-379-szT6VE6HNnC91s47pDJ2ZQ-1; Tue, 03 Mar 2020 10:31:18 -0500
X-MC-Unique: szT6VE6HNnC91s47pDJ2ZQ-1
Received: by mail-wm1-f71.google.com with SMTP id f207so1237556wme.6
        for <linux-kernel@vger.kernel.org>; Tue, 03 Mar 2020 07:31:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=7UvOLNGx6p9fKROK7cYc0KuMbdmUhd2L++fUFlqw33s=;
        b=nTTtpaF/FxT/5IMol6y8EYZ0HcvK6eZp80/z3Vth4WBfQtxfcFdbf9xyBp7r/WGZSy
         DtX+LJAkqZFe/5vIBo8YPdsy/RIgPpKplxEqt0ZWxiSLHsgfVi3iDbKhgM093WpQOXJ0
         FKO9kKphz9iYAjg2XaEVx9spng/7GAgHQyJeydfB3G7jXwax5wnGk4MO6AgG/ONX9Y25
         HIWOWVP3vj5nPJy+C2jPQoksmCWr4AkvZK3HjJdZsf+i1oBvWK6Hp2DU+MhnYZBn1naF
         KRTxM4Bxx/CinW0z1v6EGi2RtFDYZvEFVJzg9og660TAH6qUBgSokZU6joeNUN2iaDgV
         QKxw==
X-Gm-Message-State: ANhLgQ1r2LaBO3wxKURGP6ezp1wZPesUG08XVQe8CqurZq3HzCtmdwL0
        pw9v0Ro+9oD8o98p6wKgQHuk0kKVr8vgfHR9s6GFfLksxKoPymjFqWxPtyOO8zGKGSG+guVjkr2
        8NAZBbEUKpzB7d2VDDEEjF2UO
X-Received: by 2002:adf:eb51:: with SMTP id u17mr6349419wrn.29.1583249477646;
        Tue, 03 Mar 2020 07:31:17 -0800 (PST)
X-Google-Smtp-Source: ADFU+vvklsBIwsMGjkjsJ0QvHOXEfxD/tv/m0rv4Qg+50ZvhJI35lH7ejzaGu22XzyvBUHoWl+uXTw==
X-Received: by 2002:adf:eb51:: with SMTP id u17mr6349404wrn.29.1583249477374;
        Tue, 03 Mar 2020 07:31:17 -0800 (PST)
Received: from [192.168.178.40] ([151.20.254.94])
        by smtp.gmail.com with ESMTPSA id f17sm13659823wrm.3.2020.03.03.07.31.16
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 03 Mar 2020 07:31:16 -0800 (PST)
Subject: Re: [PATCH v2 61/66] KVM: x86: Don't propagate MMU lpage support to
 memslot.disallow_lpage
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org, Xiaoyao Li <xiaoyao.li@intel.com>
References: <20200302235709.27467-1-sean.j.christopherson@intel.com>
 <20200302235709.27467-62-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <e436d608-41ed-c9ad-6584-360451fb6d65@redhat.com>
Date:   Tue, 3 Mar 2020 16:31:15 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200302235709.27467-62-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 03/03/20 00:57, Sean Christopherson wrote:
> Stop propagating MMU large page support into a memslot's disallow_lpage
> now that the MMU's max_page_level handles the scenario where VMX's EPT is
> enabled and EPT doesn't support 2M pages.
> 
> No functional change intended.
> 
> Reviewed-by: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/vmx/vmx.c | 3 ---
>  arch/x86/kvm/x86.c     | 6 ++----
>  2 files changed, 2 insertions(+), 7 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmx.c b/arch/x86/kvm/vmx/vmx.c
> index f8eb081b63fe..1fbe54dc3263 100644
> --- a/arch/x86/kvm/vmx/vmx.c
> +++ b/arch/x86/kvm/vmx/vmx.c
> @@ -7698,9 +7698,6 @@ static __init int hardware_setup(void)
>  	if (!cpu_has_vmx_tpr_shadow())
>  		kvm_x86_ops->update_cr8_intercept = NULL;
>  
> -	if (enable_ept && !cpu_has_vmx_ept_2m_page())
> -		kvm_disable_largepages();
> -
>  #if IS_ENABLED(CONFIG_HYPERV)
>  	if (ms_hyperv.nested_features & HV_X64_NESTED_GUEST_MAPPING_FLUSH
>  	    && enable_ept) {
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 4fdf5b04f148..cc9b543d210b 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -9863,11 +9863,9 @@ static int kvm_alloc_memslot_metadata(struct kvm_memory_slot *slot,
>  		ugfn = slot->userspace_addr >> PAGE_SHIFT;
>  		/*
>  		 * If the gfn and userspace address are not aligned wrt each
> -		 * other, or if explicitly asked to, disable large page
> -		 * support for this slot
> +		 * other, disable large page support for this slot.
>  		 */
> -		if ((slot->base_gfn ^ ugfn) & (KVM_PAGES_PER_HPAGE(level) - 1) ||
> -		    !kvm_largepages_enabled()) {
> +		if ((slot->base_gfn ^ ugfn) & (KVM_PAGES_PER_HPAGE(level) - 1)) {
>  			unsigned long j;
>  
>  			for (j = 0; j < lpages; ++j)
> 

This should technically go in the next patch.

Paolo

