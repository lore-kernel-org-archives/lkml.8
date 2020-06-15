Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3519EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:26:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10706206B7
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 09:26:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="GCF41UUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729035AbgFOJ0V (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 05:26:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:23203 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1728924AbgFOJ0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 05:26:21 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1592213179;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=hZRUtaUJ932ZlCQQbbYzNzjvtVWhAHymSOYbwBdTnCE=;
        b=GCF41UUUj5L8LC+phRyOd/CJ5TKqT0QpjlDliDuhwPrFtrVDntmWpVEoM7iaFKsrv6fAbb
        QIkZTOr9sZvpsB0zDWWUaiv/ddKIFh2ym4l9uZ8a2+e8BBA7fE2yyFwObw7XK1pvTGT4bZ
        uEqMJ6qK5sduNh5mn96Fv7jVZ3dM0U8=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-372-3Oc9P1HWNSKzqwL-zcLmlg-1; Mon, 15 Jun 2020 05:26:08 -0400
X-MC-Unique: 3Oc9P1HWNSKzqwL-zcLmlg-1
Received: by mail-wr1-f70.google.com with SMTP id s7so6820074wrm.16
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 02:26:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=hZRUtaUJ932ZlCQQbbYzNzjvtVWhAHymSOYbwBdTnCE=;
        b=qF43nm7rOu4KIFgbwDd8kEAWh6u5UPC7uwmF3j0XpSNVRfwYA6EYFHTKDGNlLPFB2m
         gMWB6dB7+fBSgyNdeoOYaDYO/7CrdXsnfDF9nTRp0NdgEO7a2IbmNU840zoPSmUrpf+/
         VQOdu2BYFS56f48PiAtJkVH7XK4zX5EYNDPt1w/06fmkkt9BSAeyAEztRJN5WVVqkhSZ
         gwL2Bwa7WxhhQLYVOaSIbtiL5sMzdsNGxHHJym2jIKKyCf9+0HLiTQKTVERlRHUA2ake
         OGLmrG8PT8lkb0KwGAbsj8PTfTDliD4GhzLFlrQ76Xy2r/QtK4Jcced/90jdRTBjvF2Z
         RWFg==
X-Gm-Message-State: AOAM53005AEI5x62kw+0irzcMM3GzERBoPqHT1AbD94iTuiRttO2OhxZ
        PG9eQVcJuFBHLAyKtRtOFGQ0C0xOMXtGW6MQtE/ty68Cvqg2gb+KyYo5BOioLLpHCyHh2WnwDHH
        iSIB3vRh3PBlqi/ukwQ3UhWhC
X-Received: by 2002:a5d:500d:: with SMTP id e13mr29684531wrt.150.1592213166873;
        Mon, 15 Jun 2020 02:26:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzv8DVyRZi9qtb8K0ghXXPE5Md7jQA6TvmLQFzaSBYlaUpm2+z2htDOIiu8mMzNA9/r75JKzw==
X-Received: by 2002:a5d:500d:: with SMTP id e13mr29684499wrt.150.1592213166643;
        Mon, 15 Jun 2020 02:26:06 -0700 (PDT)
Received: from [192.168.10.150] ([93.56.170.5])
        by smtp.gmail.com with ESMTPSA id t8sm21120194wmi.46.2020.06.15.02.26.05
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Jun 2020 02:26:06 -0700 (PDT)
Subject: Re: [PATCH] KVM: MIPS: fix spelling mistake "Exteneded" -> "Extended"
To:     Colin King <colin.king@canonical.com>,
        Thomas Bogendoerfer <tsbogend@alpha.franken.de>,
        Huacai Chen <chenhc@lemote.com>, linux-mips@vger.kernel.org,
        kvm@vger.kernel.org
Cc:     kernel-janitors@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200615082636.7004-1-colin.king@canonical.com>
From:   Paolo Bonzini <pbonzini@redhat.com>
Message-ID: <8719ff21-8344-a4d0-112b-c7876f0b6f29@redhat.com>
Date:   Mon, 15 Jun 2020 11:26:05 +0200
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200615082636.7004-1-colin.king@canonical.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 15/06/20 10:26, Colin King wrote:
> From: Colin Ian King <colin.king@canonical.com>
> 
> There is a spelling mistake in a couple of kvm_err messages. Fix them.
> 
> Signed-off-by: Colin Ian King <colin.king@canonical.com>
> ---
>  arch/mips/kvm/emulate.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/kvm/emulate.c b/arch/mips/kvm/emulate.c
> index 5ae82d925197..d3d322f70fe0 100644
> --- a/arch/mips/kvm/emulate.c
> +++ b/arch/mips/kvm/emulate.c
> @@ -1861,7 +1861,7 @@ enum emulation_result kvm_mips_emulate_store(union mips_instruction inst,
>  				  vcpu->arch.gprs[rt], *(u64 *)data);
>  			break;
>  		default:
> -			kvm_err("Godson Exteneded GS-Store not yet supported (inst=0x%08x)\n",
> +			kvm_err("Godson Extended GS-Store not yet supported (inst=0x%08x)\n",
>  				inst.word);
>  			break;
>  		}
> @@ -2103,7 +2103,7 @@ enum emulation_result kvm_mips_emulate_load(union mips_instruction inst,
>  			vcpu->mmio_needed = 30;	/* signed */
>  			break;
>  		default:
> -			kvm_err("Godson Exteneded GS-Load for float not yet supported (inst=0x%08x)\n",
> +			kvm_err("Godson Extended GS-Load for float not yet supported (inst=0x%08x)\n",
>  				inst.word);
>  			break;
>  		}
> 

Queued, thanks.

Paolo

