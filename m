Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 27D18C35247
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:30:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id ED58020659
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 15:30:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="czJHx7Cl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727054AbgBEPaj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 10:30:39 -0500
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:26375 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726592AbgBEPai (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 10:30:38 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1580916638;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=moBbJsc64Ii3lhPLqwdyLSBVDQd6xMAbYyJ+BA5TEEA=;
        b=czJHx7ClKIawfj9hSNYcPJRf9wBk1quKB9FK4LmrfHTWpeDDqGu5xiWvmScpkr/2Tc8wFi
        /jxx2eLg2mdveGL5naDTjUcFdyTuB+YbzxcJf7+Nez+4M1TFfWOZvnSj4VcqznssvUjJ/D
        8oMyBJ+pHshCf+OycnpsA+T/uUmira8=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-412-NzmsbQK7OYe4Uxnm0XwHGg-1; Wed, 05 Feb 2020 10:30:35 -0500
X-MC-Unique: NzmsbQK7OYe4Uxnm0XwHGg-1
Received: by mail-wm1-f70.google.com with SMTP id t17so1137455wmi.7
        for <linux-kernel@vger.kernel.org>; Wed, 05 Feb 2020 07:30:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=moBbJsc64Ii3lhPLqwdyLSBVDQd6xMAbYyJ+BA5TEEA=;
        b=phX8fXTOi3KFfxBYOZnvVOiF5/7QVYllfncHMlAeZaMwDJOU7dRUvRsX82dmLKoiWV
         c7RSMBGIdWo3fCDcuVVDb2LnFGJbd76/ElHHpq/HI/lGnOUCSKzgU6OdcleljPGl2KGk
         dnys+vQQiicq2rX3V58627xyskquv4FeFeAoiZ4dhuPQOgAoG5fKE8rQZmqeIUAXu17Q
         AFS/HeDZPZlmOBRKqdROvBTvRA6+bgzbGbR8g/U4L8vpU6Pe9F3eQrQV+3QmB1dHyXBg
         r1HDXz106sSAjzH8j0fyteVJKt/GB1Zk6eZJVndAMbA4iGVx7aHf+cOzzapr+E/WMUc3
         KUgg==
X-Gm-Message-State: APjAAAWiEgIH451u7zFmNPitpsGzVmzZEXNUXBeUglTnAHwI7j3NLwCe
        aonKX5n6/NH521LVl4APjwHVBiyZnIeEOAaEYVGmKIXK/ZUc04bpSTaxpA1fxGU0s3WmpecRxv9
        CLjvDwW2WWKjbywYtkTqEe4cb
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr27607538wru.87.1580916634272;
        Wed, 05 Feb 2020 07:30:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqzmVLL0VB9sQknIvinhqAh+AOK25JOU/h1W4GA++8d5Em1eRF5fiPuuCQpd8gHgCiyL1qmfSw==
X-Received: by 2002:a5d:4f8b:: with SMTP id d11mr27607517wru.87.1580916633970;
        Wed, 05 Feb 2020 07:30:33 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id f1sm169304wro.85.2020.02.05.07.30.33
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 05 Feb 2020 07:30:33 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: Mark CR4.UMIP as reserved based on associated
 CPUID bit
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200128235344.29581-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <fc55c156-e689-0a3d-ae22-93c813630aa8@redhat.com>
Date:   Wed, 5 Feb 2020 16:30:32 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200128235344.29581-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29/01/20 00:53, Sean Christopherson wrote:
> Re-add code to mark CR4.UMIP as reserved if UMIP is not supported by the
> host.  The UMIP handling was unintentionally dropped during a recent
> refactoring.
> 
> Not flagging CR4.UMIP allows the guest to set its CR4.UMIP regardless of
> host support or userspace desires.  On CPUs with UMIP support, including
> emulated UMIP, this allows the guest to enable UMIP against the wishes
> of the userspace VMM.  On CPUs without any form of UMIP, this results in
> a failed VM-Enter due to invalid guest state.
> 
> Fixes: 345599f9a2928 ("KVM: x86: Add macro to ensure reserved cr4 bits checks stay in sync")
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/x86.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/arch/x86/kvm/x86.c b/arch/x86/kvm/x86.c
> index 7e3f1d937224..e70d1215638a 100644
> --- a/arch/x86/kvm/x86.c
> +++ b/arch/x86/kvm/x86.c
> @@ -898,6 +898,8 @@ EXPORT_SYMBOL_GPL(kvm_set_xcr);
>  		__reserved_bits |= X86_CR4_PKE;		\
>  	if (!__cpu_has(__c, X86_FEATURE_LA57))		\
>  		__reserved_bits |= X86_CR4_LA57;	\
> +	if (!__cpu_has(__c, X86_FEATURE_UMIP))		\
> +		__reserved_bits |= X86_CR4_UMIP;	\
>  	__reserved_bits;				\
>  })
>  
> 

Queued, thanks.

Paolo

