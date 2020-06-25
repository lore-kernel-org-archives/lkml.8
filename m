Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 427B6C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:33:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 174C320709
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 12:33:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hquYfcFj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2404688AbgFYMdD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 08:33:03 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:31031 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2404451AbgFYMdC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 08:33:02 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593088381;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=4QAA6xTzivbUQMA9MfIr8KswP1KP4qpqOKsLkXMz+OE=;
        b=hquYfcFjFb3GQTuEInUnMWpfkFSqcr3qx+4jDfZwggx1P6M5iJciZu5ipc/PhmM4FMZ99i
        1TnZ1GMsnTjqXaTGY5N/95O3AI7Yy+Iw9MoPTn1KikKcK5k01gz/Wxrk6RP9tcee3wnzJd
        YSvNPXV/7Bbr4N2J4f84ZzcGuPIxOvw=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-282-hGq5q48qP_yNA9J7m7qN8w-1; Thu, 25 Jun 2020 08:32:59 -0400
X-MC-Unique: hGq5q48qP_yNA9J7m7qN8w-1
Received: by mail-wr1-f71.google.com with SMTP id d6so6700845wrn.1
        for <linux-kernel@vger.kernel.org>; Thu, 25 Jun 2020 05:32:59 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=4QAA6xTzivbUQMA9MfIr8KswP1KP4qpqOKsLkXMz+OE=;
        b=cdFN7kNoFTf2gICzci9ocXUlKXDNqbjEfz1s0hWqVP/ezAMG8LtIp0Dz6AxLclzLZq
         YHMebRM9JV6n4f+584zFKXPi3IKC39l+xlpO8ZaUX777B3/Wr4qI+5D/40nIaelvO8P+
         7NzEt7BbExTXsgdIN6Uk8H6tlNYl9zVTQouM5+ptbszj8b5wxQyQ18snSRvwWX2eTC1m
         hZIqsP43tP5UmsT3LYPpstNAWUpo/BMYy3fiy1jst82J0+Ee+U3be51LcTHIjmwYUp1e
         KD7aVh7sTVnqtGmCDaqCHnKGyTbOTwR/nRGXcUvawt3oRF3NjEkR4UbdPpX4xJ5AfV/e
         wxnQ==
X-Gm-Message-State: AOAM531vz0cDzCQFwSqOLwLnbK+GG2trwrRSpxqspssP7CeYJubl5ED6
        swYwSbexw7qV6IboykAtxUOFA4YZJC3QpqvAHS5pHxBGvfSKo9/Ufjkr9RNow4j0b/Ra7RzZF9+
        /FerTy81+aNt162W7e0LNZIzS
X-Received: by 2002:adf:ff8c:: with SMTP id j12mr36129916wrr.230.1593088378319;
        Thu, 25 Jun 2020 05:32:58 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJza6yC5dQ/KR4rQM92i44NL4zzevHmVpFRpkaZKX3IcBVU9bdyAaS6xr67Dsr0Uv3NHlppSyg==
X-Received: by 2002:adf:ff8c:: with SMTP id j12mr36129899wrr.230.1593088378068;
        Thu, 25 Jun 2020 05:32:58 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:91d0:a5f0:9f34:4d80? ([2001:b07:6468:f312:91d0:a5f0:9f34:4d80])
        by smtp.gmail.com with ESMTPSA id b18sm30801881wrn.88.2020.06.25.05.32.57
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 25 Jun 2020 05:32:57 -0700 (PDT)
Subject: Re: [PATCH] KVM: x86: Use VMCALL and VMMCALL mnemonics in kvm_para.h
To:     Uros Bizjak <ubizjak@gmail.com>, kvm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200623183439.5526-1-ubizjak@gmail.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <30a01d1f-5b36-5171-3d0a-e14fa7afa62e@redhat.com>
Date:   Thu, 25 Jun 2020 14:32:55 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200623183439.5526-1-ubizjak@gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/20 20:34, Uros Bizjak wrote:
> Current minimum required version of binutils is 2.23,
> which supports VMCALL and VMMCALL instruction mnemonics.
> 
> Replace the byte-wise specification of VMCALL and
> VMMCALL with these proper mnemonics.
> 
> Signed-off-by: Uros Bizjak <ubizjak@gmail.com>
> CC: Paolo Bonzini <pbonzini@redhat.com>
> ---
>  arch/x86/include/asm/kvm_para.h | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/x86/include/asm/kvm_para.h b/arch/x86/include/asm/kvm_para.h
> index 49d3a9edb06f..01317493807e 100644
> --- a/arch/x86/include/asm/kvm_para.h
> +++ b/arch/x86/include/asm/kvm_para.h
> @@ -18,7 +18,7 @@ static inline bool kvm_check_and_clear_guest_paused(void)
>  #endif /* CONFIG_KVM_GUEST */
>  
>  #define KVM_HYPERCALL \
> -        ALTERNATIVE(".byte 0x0f,0x01,0xc1", ".byte 0x0f,0x01,0xd9", X86_FEATURE_VMMCALL)
> +        ALTERNATIVE("vmcall", "vmmcall", X86_FEATURE_VMMCALL)
>  
>  /* For KVM hypercalls, a three-byte sequence of either the vmcall or the vmmcall
>   * instruction.  The hypervisor may replace it with something else but only the
> 

Queued, thanks.

