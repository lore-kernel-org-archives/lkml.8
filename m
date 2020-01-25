Return-Path: <SRS0=aedO=3O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9930CC35242
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 09:32:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6BBA32071E
	for <linux-kernel@archiver.kernel.org>; Sat, 25 Jan 2020 09:32:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Of2AhvTn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727747AbgAYJcI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 25 Jan 2020 04:32:08 -0500
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55996 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725710AbgAYJcI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jan 2020 04:32:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1579944727;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4aVPwT+ullXbV9ZGelAsF2ZlUzo01e9ol8SPKMVndpw=;
        b=Of2AhvTnZpik7dhPmb37Ryh2IrPZ2XH6xNPAEgxDeW1jEuVGNdjkuiE6kS6BCmcpmRDQvs
        xvhvMb9TLArRxFmNf2pnNZM5TYQSe7OjlYt0nkxKhTeuf/MibS26/P3QNmz7KiQKQ/QPvp
        BZJIk/iPg/CInRAMqoHOoUxjKUoWR+Q=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-415-SfySA-O0PgKGEN1mHH71ZQ-1; Sat, 25 Jan 2020 04:32:05 -0500
X-MC-Unique: SfySA-O0PgKGEN1mHH71ZQ-1
Received: by mail-wm1-f71.google.com with SMTP id g26so401187wmk.6
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jan 2020 01:32:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4aVPwT+ullXbV9ZGelAsF2ZlUzo01e9ol8SPKMVndpw=;
        b=kQDJXcRBnDJbNzmwEMHNafIDHTpNhniZQL9d4xG/XYOlQqRi6ClJ7OhV8BLcDTMrsv
         EYOY0KQz47l107nGhkYoNO1ij6UIFhMnUjb/MKv78LD2hPVRLB0d4G9fQ9P5IAxbqi2m
         u0KCZHxPFgmXxg6P4VlKxD5MdluVVyBLC1GL4ogx/ZOcpxoM5H+AVmwUl42AgNvJWiSg
         lLp7fWPCM5HrOTHTP3aqudg4eOidO6AGncplAwwkNFLH+3/Pg+7pOyegiYHlsCSYxs3C
         5zNHj/O7d0zi4tvaq2KwXxIXDQpJ1HpoYoftWg5hkpNdk9o5KapMxoSmb7vg4ODX9Mjj
         3wVQ==
X-Gm-Message-State: APjAAAWC+DWVT33yc+1TM9znzUKAOefWGiS76IxGWPJ98B9+HhUH3PHp
        rqjsOUtbEAzkvlPZJJFVVX/rf6z76c7noOkC76fMjehievezSmToFgWrz6ww2Q7sj/U/z2r8/7f
        vonp3/izTwbxKw74/syDCbgTG
X-Received: by 2002:a05:6000:11c3:: with SMTP id i3mr9377038wrx.244.1579944724475;
        Sat, 25 Jan 2020 01:32:04 -0800 (PST)
X-Google-Smtp-Source: APXvYqy6XvOgjU6V9Wv3zn93Ex1jpxLzeOnJ89MIAzXJBVajO5ULnjaciehkCA0EPTt32FXxUHMtbg==
X-Received: by 2002:a05:6000:11c3:: with SMTP id i3mr9377021wrx.244.1579944724231;
        Sat, 25 Jan 2020 01:32:04 -0800 (PST)
Received: from [192.168.10.150] ([93.56.166.5])
        by smtp.gmail.com with ESMTPSA id b67sm10500968wmc.38.2020.01.25.01.32.02
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 25 Jan 2020 01:32:03 -0800 (PST)
Subject: Re: [PATCH] KVM: x86: Take a u64 when checking for a valid dr7 value
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>,
        Wanpeng Li <wanpengli@tencent.com>,
        Jim Mattson <jmattson@google.com>,
        Joerg Roedel <joro@8bytes.org>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Krish Sadhukhan <krish.sadhukhan@oracle.com>,
        Randy Dunlap <rdunlap@infradead.org>
References: <20200124230722.8964-1-sean.j.christopherson@intel.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <118ad0a6-b190-80ee-98fa-615466d2bf12@redhat.com>
Date:   Sat, 25 Jan 2020 10:32:02 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.1
MIME-Version: 1.0
In-Reply-To: <20200124230722.8964-1-sean.j.christopherson@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 25/01/20 00:07, Sean Christopherson wrote:
> Take a u64 instead of an unsigned long in kvm_dr7_valid() to fix a build
> warning on i386 due to right-shifting a 32-bit value by 32 when checking
> for bits being set in dr7[63:32].
> 
> Alternatively, the warning could be resolved by rewriting the check to
> use an i386-friendly method, but taking a u64 fixes another oddity on
> 32-bit KVM.  Beause KVM implements natural width VMCS fields as u64s to
> avoid layout issues between 32-bit and 64-bit, a devious guest can stuff
> vmcs12->guest_dr7 with a 64-bit value even when both the guest and host
> are 32-bit kernels.  KVM eventually drops vmcs12->guest_dr7[63:32] when
> propagating vmcs12->guest_dr7 to vmcs02, but ideally KVM would not rely
> on that behavior for correctness.
> 
> Cc: Jim Mattson <jmattson@google.com>
> Cc: Krish Sadhukhan <krish.sadhukhan@oracle.com>
> Fixes: ecb697d10f70 ("KVM: nVMX: Check GUEST_DR7 on vmentry of nested guests")
> Reported-by: Randy Dunlap <rdunlap@infradead.org>
> Signed-off-by: Sean Christopherson <sean.j.christopherson@intel.com>
> ---
>  arch/x86/kvm/x86.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/kvm/x86.h b/arch/x86/kvm/x86.h
> index 2d2ff855773b..3624665acee4 100644
> --- a/arch/x86/kvm/x86.h
> +++ b/arch/x86/kvm/x86.h
> @@ -357,7 +357,7 @@ static inline bool kvm_pat_valid(u64 data)
>  	return (data | ((data & 0x0202020202020202ull) << 1)) == data;
>  }
>  
> -static inline bool kvm_dr7_valid(unsigned long data)
> +static inline bool kvm_dr7_valid(u64 data)
>  {
>  	/* Bits [63:32] are reserved */
>  	return !(data >> 32);
> 

Queued, thanks.

Paolo

