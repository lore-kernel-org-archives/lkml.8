Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20A21C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:36:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9B932073B
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 12:36:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="LU+Rvd15"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728900AbgEEMgJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 08:36:09 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:43711 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728268AbgEEMgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 08:36:08 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588682166;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=bsccUuRQy2jvqaOH6LGPQ4vtE+LhlW8wtgFKVDHoZ34=;
        b=LU+Rvd15uKQSTHbcaFxfzVWmON/lqrYVLnTjpiRH1A/lJn5Du87nqj2s0QLteNcmmno+yi
        n25fUaaWQGxbPe1aWDcUprvqFsGeL7p8DT1vtgtFJnbkqD8kT93GMhRVcwxaoyLn6SBU3t
        tOOIAYTcACEBnXqJdtycoV83zs+N+9A=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-249-ZavRA1WUPru4bHb-LiSSqw-1; Tue, 05 May 2020 08:36:05 -0400
X-MC-Unique: ZavRA1WUPru4bHb-LiSSqw-1
Received: by mail-wr1-f71.google.com with SMTP id q13so1125064wrn.14
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 05:36:05 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=bsccUuRQy2jvqaOH6LGPQ4vtE+LhlW8wtgFKVDHoZ34=;
        b=cQ1GisUHGZMewtgPf/adCQhN8mIy6W07dYUyxY5nV6/6IYMK2K0F1dYhUHbdMpa+h3
         ti6LvHXu9GGhSnK5CxERHa9+1GZqpIBFdavROmoWb8C/3LgV2SqS5t005SncTKX332TY
         r645BczeA3rIF/GLHaekCGmfBxn1S5JO7LCnapaPeIelDUlku8ULKVr0GWB3vmpnLH4s
         fhP1Boc9HhuwimLim15raLb3pinF31a9ClNla/4N959bIKEqXfdzBVC/G1g5GErAUm67
         xnC03t9Hcj+xlrT1szLIaEbR/uaDygheNhIRaSYdI3KGi8BioDWr5kCjJVf/SpjE54Ah
         Kp6Q==
X-Gm-Message-State: AGi0PubA3Wgf2mhyuV0tHZkQaOZQjy1s7LSbPe6ASVAq8VIKFAFX5pGg
        5ie00ddf0JxuKVRf9wVKh0wNyjTmm7sfJ561RxP20v0fjjd0SQ0EFqYtxeZTfGJCrHI1MSWHuxa
        fqeNprKp9YbeE+wpH9iOOkl/I
X-Received: by 2002:a1c:3884:: with SMTP id f126mr3489104wma.91.1588682164247;
        Tue, 05 May 2020 05:36:04 -0700 (PDT)
X-Google-Smtp-Source: APiQypK2yQysqNlaBNEYFJEQoeRAd/S5v9BFxPbGikdmb1C+ke6RMlOFyst7gVZvWv7bHJDRTKfFpw==
X-Received: by 2002:a1c:3884:: with SMTP id f126mr3489080wma.91.1588682164010;
        Tue, 05 May 2020 05:36:04 -0700 (PDT)
Received: from [192.168.178.58] ([151.20.132.175])
        by smtp.gmail.com with ESMTPSA id 17sm3507092wmo.2.2020.05.05.05.36.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 05 May 2020 05:36:03 -0700 (PDT)
Subject: Re: [PATCH] KVM: selftests: Fix build for evmcs.h
To:     Peter Xu <peterx@redhat.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     Vitaly Kuznetsov <vkuznets@redhat.com>
References: <20200504220607.99627-1-peterx@redhat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <aebe1f8a-8c58-7508-80ed-848d3143fcad@redhat.com>
Date:   Tue, 5 May 2020 14:36:02 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200504220607.99627-1-peterx@redhat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/05/20 00:06, Peter Xu wrote:
> I got this error when building kvm selftests:
> 
> /usr/bin/ld: /home/xz/git/linux/tools/testing/selftests/kvm/libkvm.a(vmx.o):/home/xz/git/linux/tools/testing/selftests/kvm/include/evmcs.h:222: multiple definition of `current_evmcs'; /tmp/cco1G48P.o:/home/xz/git/linux/tools/testing/selftests/kvm/include/evmcs.h:222: first defined here
> /usr/bin/ld: /home/xz/git/linux/tools/testing/selftests/kvm/libkvm.a(vmx.o):/home/xz/git/linux/tools/testing/selftests/kvm/include/evmcs.h:223: multiple definition of `current_vp_assist'; /tmp/cco1G48P.o:/home/xz/git/linux/tools/testing/selftests/kvm/include/evmcs.h:223: first defined here
> 
> I think it's because evmcs.h is included both in a test file and a lib file so
> the structs have multiple declarations when linking.  After all it's not a good
> habit to declare structs in the header files.
> 
> Cc: Vitaly Kuznetsov <vkuznets@redhat.com>
> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
> 
> I initially thought it was something about my GCC 10 upgrade that I recently
> did to my laptop - gcc10 even fails the build of the latest kernel after
> all (though it turns out to be a kernel bug on build system rather than a gcc
> bug). but I'm not sure about this one...
> ---
>  tools/testing/selftests/kvm/include/evmcs.h  | 4 ++--
>  tools/testing/selftests/kvm/lib/x86_64/vmx.c | 3 +++
>  2 files changed, 5 insertions(+), 2 deletions(-)
> 
> diff --git a/tools/testing/selftests/kvm/include/evmcs.h b/tools/testing/selftests/kvm/include/evmcs.h
> index d8f4d6bfe05d..a034438b6266 100644
> --- a/tools/testing/selftests/kvm/include/evmcs.h
> +++ b/tools/testing/selftests/kvm/include/evmcs.h
> @@ -219,8 +219,8 @@ struct hv_enlightened_vmcs {
>  #define HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_MASK	\
>  		(~((1ull << HV_X64_MSR_VP_ASSIST_PAGE_ADDRESS_SHIFT) - 1))
>  
> -struct hv_enlightened_vmcs *current_evmcs;
> -struct hv_vp_assist_page *current_vp_assist;
> +extern struct hv_enlightened_vmcs *current_evmcs;
> +extern struct hv_vp_assist_page *current_vp_assist;
>  
>  int vcpu_enable_evmcs(struct kvm_vm *vm, int vcpu_id);
>  
> diff --git a/tools/testing/selftests/kvm/lib/x86_64/vmx.c b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
> index 6f17f69394be..4ae104f6ce69 100644
> --- a/tools/testing/selftests/kvm/lib/x86_64/vmx.c
> +++ b/tools/testing/selftests/kvm/lib/x86_64/vmx.c
> @@ -17,6 +17,9 @@
>  
>  bool enable_evmcs;
>  
> +struct hv_enlightened_vmcs *current_evmcs;
> +struct hv_vp_assist_page *current_vp_assist;
> +
>  struct eptPageTableEntry {
>  	uint64_t readable:1;
>  	uint64_t writable:1;
> 

Queued, thanks.

Paolo

