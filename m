Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E301C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:12:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 279A5207D3
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 16:12:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GQfrHS4W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730816AbgFOQM2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 12:12:28 -0400
Received: from us-smtp-1.mimecast.com ([207.211.31.81]:58795 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1730538AbgFOQM1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 12:12:27 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592237545;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OCMW+zRQoRVexmB9YumbelsaE73MORmWmoo3AK75EJM=;
        b=GQfrHS4WctNyjv57Vfi2G4QUAlXQG+pRBs2xIo6ZodN3xoCJMiy+T/fGphOIM8Z7t8lBI/
        u7+qbVfgU4Da/77W0KAwHH9LN/eK+L2frwc2b/J1CAc9gSQukZN4s7MDg11nKVJx+ox3oz
        cRaEZHEzO0GLKPphw6aF31aZ1Sseg1Y=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-311-wfb-q9bxOnqpgh_-eQt71g-1; Mon, 15 Jun 2020 12:12:22 -0400
X-MC-Unique: wfb-q9bxOnqpgh_-eQt71g-1
Received: by mail-wm1-f71.google.com with SMTP id h6so18343wmb.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 09:12:21 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=OCMW+zRQoRVexmB9YumbelsaE73MORmWmoo3AK75EJM=;
        b=G2uOajo9EKG/x2XWOT8yk72r13LD2LcPtMqsna2D1ezHUlGbNCZIWETPBkoZDy8Yra
         GDObGTRcseX6AiUg7IszqRJi8EWSqt8IX4Q0lUOzpQPr7LPHaPPBpVCNr2xsj8384tth
         4sKFnBEvTc3lo3Q7Cm1VsflLONKOmEtfm/8OEqWfKkVrrDfd6YsRFp6qbIkQ7yhYvxRM
         +IpkIk/YSbNPAQW6/BSWiqmHY600jVEic4Xhb9qA4HpGZlcXmX/HcBF9UdItxosb3Vhb
         1y3LiE1AMlKVAxyNteefhqWkoN4HQfrlRqcUpwq3YKZpf469/esQFaEmAHZX4+MWgIqh
         /fGA==
X-Gm-Message-State: AOAM530q8WRGmPw/ZDQ5O3xw8xM6JKzXd0V+xgvkd3eAaXdrsGKQq4ru
        /6KVKaSLd8bv6mIo1Hnufg3Ps7FkMkKMM0lTckPEabNaw3A4Xr+m8mbrWkOoSQxnbQybEXL3uUp
        ecLCty8Zq5xIF+EZXS4Ozc4vj
X-Received: by 2002:a1c:32c4:: with SMTP id y187mr39637wmy.79.1592237540168;
        Mon, 15 Jun 2020 09:12:20 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJw8Y9ZHqBEI7bzfblm4iLOhDq9lfZaf/VKMwnn+u0PM4fHGUPY+jVCFzxXzFMmrb8W7SSKvWA==
X-Received: by 2002:a1c:32c4:: with SMTP id y187mr39604wmy.79.1592237539927;
        Mon, 15 Jun 2020 09:12:19 -0700 (PDT)
Received: from [192.168.178.58] ([151.48.99.33])
        by smtp.gmail.com with ESMTPSA id f16sm30924wmh.27.2020.06.15.09.12.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 09:12:19 -0700 (PDT)
Subject: Re: [PATCH] KVM: VMX: Add helpers to identify interrupt type from
 intr_info
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200609014518.26756-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <9ee673cd-29b5-3e9a-ce34-9314c736df59@redhat.com>
Date:   Mon, 15 Jun 2020 18:12:18 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200609014518.26756-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09/06/20 03:45, Sean Christopherson wrote:
> Add is_intr_type() and is_intr_type_n() to consolidate the boilerplate
> code for querying a specific type of interrupt given an encoded value
> from VMCS.VM_{ENTER,EXIT}_INTR_INFO, with and without an associated
> vector respectively.
> 
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
> 
> I wrote and proposed a version of this patch a while back[*], but AFAICT
> never posted it as a formal patch.
> 
> [*] https://lkml.kernel.org/r/20190819233537.GG1916@linux.intel.com
> 
>  arch/x86/kvm/vmx/vmcs.h | 32 ++++++++++++++++++++------------
>  1 file changed, 20 insertions(+), 12 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/vmcs.h b/arch/x86/kvm/vmx/vmcs.h
> index 5c0ff80b85c0..7a3675fddec2 100644
> --- a/arch/x86/kvm/vmx/vmcs.h
> +++ b/arch/x86/kvm/vmx/vmcs.h
> @@ -72,11 +72,24 @@ struct loaded_vmcs {
>  	struct vmcs_controls_shadow controls_shadow;
>  };
>  
> +static inline bool is_intr_type(u32 intr_info, u32 type)
> +{
> +	const u32 mask = INTR_INFO_VALID_MASK | INTR_INFO_INTR_TYPE_MASK;
> +
> +	return (intr_info & mask) == (INTR_INFO_VALID_MASK | type);
> +}
> +
> +static inline bool is_intr_type_n(u32 intr_info, u32 type, u8 vector)
> +{
> +	const u32 mask = INTR_INFO_VALID_MASK | INTR_INFO_INTR_TYPE_MASK |
> +			 INTR_INFO_VECTOR_MASK;
> +
> +	return (intr_info & mask) == (INTR_INFO_VALID_MASK | type | vector);
> +}
> +
>  static inline bool is_exception_n(u32 intr_info, u8 vector)
>  {
> -	return (intr_info & (INTR_INFO_INTR_TYPE_MASK | INTR_INFO_VECTOR_MASK |
> -			     INTR_INFO_VALID_MASK)) ==
> -		(INTR_TYPE_HARD_EXCEPTION | vector | INTR_INFO_VALID_MASK);
> +	return is_intr_type_n(intr_info, INTR_TYPE_HARD_EXCEPTION, vector);
>  }
>  
>  static inline bool is_debug(u32 intr_info)
> @@ -106,28 +119,23 @@ static inline bool is_gp_fault(u32 intr_info)
>  
>  static inline bool is_machine_check(u32 intr_info)
>  {
> -	return (intr_info & (INTR_INFO_INTR_TYPE_MASK | INTR_INFO_VECTOR_MASK |
> -			     INTR_INFO_VALID_MASK)) ==
> -		(INTR_TYPE_HARD_EXCEPTION | MC_VECTOR | INTR_INFO_VALID_MASK);
> +	return is_exception_n(intr_info, MC_VECTOR);
>  }
>  
>  /* Undocumented: icebp/int1 */
>  static inline bool is_icebp(u32 intr_info)
>  {
> -	return (intr_info & (INTR_INFO_INTR_TYPE_MASK | INTR_INFO_VALID_MASK))
> -		== (INTR_TYPE_PRIV_SW_EXCEPTION | INTR_INFO_VALID_MASK);
> +	return is_intr_type(intr_info, INTR_TYPE_PRIV_SW_EXCEPTION);
>  }
>  
>  static inline bool is_nmi(u32 intr_info)
>  {
> -	return (intr_info & (INTR_INFO_INTR_TYPE_MASK | INTR_INFO_VALID_MASK))
> -		== (INTR_TYPE_NMI_INTR | INTR_INFO_VALID_MASK);
> +	return is_intr_type(intr_info, INTR_TYPE_NMI_INTR);
>  }
>  
>  static inline bool is_external_intr(u32 intr_info)
>  {
> -	return (intr_info & (INTR_INFO_VALID_MASK | INTR_INFO_INTR_TYPE_MASK))
> -		== (INTR_INFO_VALID_MASK | INTR_TYPE_EXT_INTR);
> +	return is_intr_type(intr_info, INTR_TYPE_EXT_INTR);
>  }
>  
>  enum vmcs_field_width {
> 

Queued, thnkas.

Paolo

