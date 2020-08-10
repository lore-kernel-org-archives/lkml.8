Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6B1AC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:11:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 855292073A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 08:11:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="SaVuQHoA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726355AbgHJILz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 04:11:55 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:55062 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725846AbgHJILx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 04:11:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597047111;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zC1toKyx2VR+U9KzPo/PLlhMRukBuugOL6OoEK15XWo=;
        b=SaVuQHoAemjvkwGob5LvIq1/GupOG5FcC/6gvtmNVKMNVv/j0+hATlwvSiVNrROZxSBe8q
        4llgTJEm3EtUMWIhYLyKcRusKIUf54UsiH1C7tDBRbgu4Tg2C9+Js96DVlcbV5GaktlOdt
        fUgYQ2Vdu0a2hpxvOK+sN2f3z+blDoY=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-31-jTM6G5w4P8K9I8VWdc_UzQ-1; Mon, 10 Aug 2020 04:11:49 -0400
X-MC-Unique: jTM6G5w4P8K9I8VWdc_UzQ-1
Received: by mail-wr1-f72.google.com with SMTP id f14so3879181wrm.22
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 01:11:49 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=zC1toKyx2VR+U9KzPo/PLlhMRukBuugOL6OoEK15XWo=;
        b=F18A74U33j0FRUEoZJptlTlp5bCuRxksRGm+ia5zASqCsQvUi9Qmf7jOujqk7tjnat
         DYB37j7eyZYhwKEVoZ4HnygJrKu9RUQ8DimCpU5qjNDYhzN+D2w49cgyCuzy3rlAUImn
         w5mTD77lyMEuCT3cWwtepEBPEhL0EMCpV7cNuDBAN/n/LJK2KUkz5MehIJ7NixwmAnKj
         t5C5f1H5tnerDNepL82v1iqRDSc+HoHpT2O+B0LZ5akml3Z2uaW0sxMcnp5kePQCIzDO
         OzvQRq8MI4/hfZ1L1x4EFzq3og47HG6U8vdGStAmU9oxc4f1Jx5gAmpBS+4yo2488/A/
         cNzA==
X-Gm-Message-State: AOAM530NcLD5aAkqkNi59YdRzz1kVMJ6+fTVa7NR1QIvRDeDQn/RT5L4
        yUe8ZueDRCLFCRkvEOhaHEBxkMwM8EeCQU9FMlb5j9yf0C6lfg/kviS4Fy1or3UZ42XGztcfwp9
        F/5iGzXVbAyFRSI49JuvNsmQV
X-Received: by 2002:a5d:5704:: with SMTP id a4mr22915222wrv.318.1597047108705;
        Mon, 10 Aug 2020 01:11:48 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx06vKPGNJTLrqXR4QKmwbxkXMvNDUzd/1ArhhCxhYjuqxYkRBJZpNV0anpK/U2bP0kmVxWYw==
X-Received: by 2002:a5d:5704:: with SMTP id a4mr22915196wrv.318.1597047108466;
        Mon, 10 Aug 2020 01:11:48 -0700 (PDT)
Received: from ?IPv6:2001:b07:6468:f312:5d6c:f50:4462:5103? ([2001:b07:6468:f312:5d6c:f50:4462:5103])
        by smtp.gmail.com with ESMTPSA id f131sm20877690wme.40.2020.08.10.01.11.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 10 Aug 2020 01:11:47 -0700 (PDT)
Subject: Re: [PATCH RESEND for-5.9] MIPS: KVM: Convert a fallthrough comment
 to fallthrough
To:     Jiaxun Yang <jiaxun.yang@flygoat.com>, kvm@vger.kernel.org
Cc:     Huacai Chen <chenhc@lemote.com>,
        Aleksandar Markovic <aleksandar.qemu.devel@gmail.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200810011749.3211128-1-jiaxun.yang@flygoat.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <a479bd7f-a71b-441d-4e82-6bcc163bab71@redhat.com>
Date:   Mon, 10 Aug 2020 10:11:47 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200810011749.3211128-1-jiaxun.yang@flygoat.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 10/08/20 03:17, Jiaxun Yang wrote:
> There is a fallthrough comment being forgotten,
> GCC complains about it:
> 
> arch/mips/kvm/emulate.c: In function kvm_mips_emulate_load:
> arch/mips/kvm/emulate.c:1936:21: error: this statement may fall through
>  1936 |   vcpu->mmio_needed = 1; /* unsigned */
>       |   ~~~~~~~~~~~~~~~~~~^~~
> arch/mips/kvm/emulate.c:1939:2: note: here
>  1939 |  case lw_op:
> 
> Just fix it.
> 
> Signed-off-by: Jiaxun Yang <jiaxun.yang@flygoat.com>
> Reviewed-by: Huacai Chen <chenhc@lemote.com>
> ---
> This is blocking KVM MIPS from build, so it needs to get into 5.9.
> ---
>  arch/mips/kvm/emulate.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
> index 703782355318..d70c4f8e14e2 100644
> --- a/arch/mips/kvm/emulate.c
> +++ b/arch/mips/kvm/emulate.c
> @@ -1935,7 +1935,7 @@ enum emulation_result kvm_mips_emulate_load(union mips_instruction inst,
>  
>  	case lwu_op:
>  		vcpu->mmio_needed = 1;	/* unsigned */
> -		/* fall through */
> +		fallthrough;
>  #endif
>  	case lw_op:
>  		run->mmio.len = 4;
> 

Queued, thanks.

Paolo

