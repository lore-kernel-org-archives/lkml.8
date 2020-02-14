Return-Path: <SRS0=fG1M=4C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E7AD6C2BA83
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 09:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B891D20873
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Feb 2020 09:00:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="NidOUPcF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729073AbgBNJAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 14 Feb 2020 04:00:14 -0500
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:33923 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1727965AbgBNJAO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Feb 2020 04:00:14 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1581670812;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=x+VX2FQf3kyDtClegJXdB0mBW6VZ2ArXcFukxh9hdjk=;
        b=NidOUPcF1CwRKTBwt1LWGyEKwYYnHYzt92I+atULcDQl5PnYLm3yAQkMt9TyDsLPUkDDuH
        Xzs5gL4tgFC4rbR56ZI8esA8no+5TbR5jrc4sHV2nS3/duedEXvjvWP6fCGIen5+IOxRNl
        f5pSU0rxgia2FXvFLNFLfS4ZBwgbxjA=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-358-no-YWg8CNKKG7Bq-v6BCfQ-1; Fri, 14 Feb 2020 04:00:11 -0500
X-MC-Unique: no-YWg8CNKKG7Bq-v6BCfQ-1
Received: by mail-wr1-f72.google.com with SMTP id u8so3688220wrp.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Feb 2020 01:00:10 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=x+VX2FQf3kyDtClegJXdB0mBW6VZ2ArXcFukxh9hdjk=;
        b=jawLgaV6BBG2kt3o1b9N0tbmYxC0ni+oSPutOMK7I4gi1F/+3dwU0txtA0NyI3kaNI
         tcVSaOFKMPTs5FZ0SmMtV6jPRc9YV9YI13eL9NYGijuBPub1K/WcBYut7Np7HSwiKzyb
         X/fflm6b1iNQgqa5ldGIhbsrtpZtKsuBBvEJOAjnJ9EpUuGsz5V5UF8HHWUBG7qCzM7n
         E3jPCdDonr3j6qn9ALloLxYquVRnIvMUOZdUMwJrsSwDNZf1N6ocL3A83Y1NMKAG5HXz
         bSCy0FCbGXsLE236wAqNSFjipVOzip7I7YLbfWphe5Kq9/iYEdlK29fQ7IREjkeBrDOb
         Za5A==
X-Gm-Message-State: APjAAAVAe0o2u/xFvNxlgzbS64D00BU1LaoJ1yEo6wm9gqEyQ8JcavSW
        grGoY/zk/PCNR9DD5iM2r74fLmAsGnfoppE8pOmp9zbj4KpzI1N6DcI23eyEg3NPyf1XwNTOxC0
        0iOPQL4Qe59yWXq/MG/DlvPnm
X-Received: by 2002:a1c:7419:: with SMTP id p25mr3319338wmc.129.1581670809881;
        Fri, 14 Feb 2020 01:00:09 -0800 (PST)
X-Google-Smtp-Source: APXvYqyEIZIA9Kxrz8amgH46i7rBPtORsj7AocTwH1XDMgMl9UeS6VKJ+PUUPyV6/vdZr2Nk/NDObQ==
X-Received: by 2002:a1c:7419:: with SMTP id p25mr3319301wmc.129.1581670809571;
        Fri, 14 Feb 2020 01:00:09 -0800 (PST)
Received: from ?IPv6:2001:b07:6468:f312:59c7:c3ee:2dec:d2b4? ([2001:b07:6468:f312:59c7:c3ee:2dec:d2b4])
        by smtp.gmail.com with ESMTPSA id i204sm6932621wma.44.2020.02.14.01.00.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 14 Feb 2020 01:00:09 -0800 (PST)
Subject: Re: [PATCH] KVM: nVMX: Fix some obsolete comments and grammar error
To:     linmiaohe <linmiaohe@huawei.com>, rkrcmar@redhat.com,
        sean.j.christopherson@intel.com, vkuznets@redhat.com,
        wanpengli@tencent.com, jmattson@google.com, joro@8bytes.org,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com
Cc:     kvm@vger.kernel.org, linux-kernel@vger.kernel.org, x86@kernel.org
References: <1581648245-8414-1-git-send-email-linmiaohe@huawei.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <4fdb28f3-dbaa-34bb-2da4-496ca881fb2a@redhat.com>
Date:   Fri, 14 Feb 2020 10:00:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <1581648245-8414-1-git-send-email-linmiaohe@huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14/02/20 03:44, linmiaohe wrote:
> From: Miaohe Lin <linmiaohe@huawei.com>
> 
> Fix wrong variable names and grammar error in comment.
> 
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  arch/x86/kvm/vmx/nested.c | 10 +++++-----
>  1 file changed, 5 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/x86/kvm/vmx/nested.c b/arch/x86/kvm/vmx/nested.c
> index 657c2eda357c..f2d8cb68dce8 100644
> --- a/arch/x86/kvm/vmx/nested.c
> +++ b/arch/x86/kvm/vmx/nested.c
> @@ -3160,10 +3160,10 @@ static void load_vmcs12_host_state(struct kvm_vcpu *vcpu,
>   * or KVM_SET_NESTED_STATE).  Otherwise it's called from vmlaunch/vmresume.
>   *
>   * Returns:
> - *	NVMX_ENTRY_SUCCESS: Entered VMX non-root mode
> - *	NVMX_ENTRY_VMFAIL:  Consistency check VMFail
> - *	NVMX_ENTRY_VMEXIT:  Consistency check VMExit
> - *	NVMX_ENTRY_KVM_INTERNAL_ERROR: KVM internal error
> + *	NVMX_VMENTRY_SUCCESS: Entered VMX non-root mode
> + *	NVMX_VMENTRY_VMFAIL:  Consistency check VMFail
> + *	NVMX_VMENTRY_VMEXIT:  Consistency check VMExit
> + *	NVMX_VMENTRY_KVM_INTERNAL_ERROR: KVM internal error
>   */
>  enum nvmx_vmentry_status nested_vmx_enter_non_root_mode(struct kvm_vcpu *vcpu,
>  							bool from_vmentry)
> @@ -5301,7 +5301,7 @@ static bool nested_vmx_exit_handled_io(struct kvm_vcpu *vcpu,
>  }
>  
>  /*
> - * Return 1 if we should exit from L2 to L1 to handle an MSR access access,
> + * Return 1 if we should exit from L2 to L1 to handle an MSR access,
>   * rather than handle it ourselves in L0. I.e., check whether L1 expressed
>   * disinterest in the current event (read or write a specific MSR) by using an
>   * MSR bitmap. This may be the case even when L0 doesn't use MSR bitmaps.
> 

Queued, thanks.

Paolo

