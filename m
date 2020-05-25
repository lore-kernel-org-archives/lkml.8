Return-Path: <SRS0=8lgJ=7H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A66EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:34:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9D54206D5
	for <linux-kernel@archiver.kernel.org>; Mon, 25 May 2020 08:34:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cogentembedded-com.20150623.gappssmtp.com header.i=@cogentembedded-com.20150623.gappssmtp.com header.b="STMrmb/z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388337AbgEYIeu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 25 May 2020 04:34:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47034 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388175AbgEYIet (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 May 2020 04:34:49 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39FACC061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:34:49 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id z18so19790653lji.12
        for <linux-kernel@vger.kernel.org>; Mon, 25 May 2020 01:34:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cogentembedded-com.20150623.gappssmtp.com; s=20150623;
        h=subject:to:cc:references:from:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=H1BMSVZkWADjrieVFVAXMCwoV1IdaPZXkmLHmjV4How=;
        b=STMrmb/zILaP/upNG1yawI1y2T4i0zG4i9EdgF8IXLjhr7HU9YXW/UR3jFxrVFa1Tn
         SHCZwWaGqSL8QbwMcYsy7IrlAfTzW/QBlSB5oPfjsV/h8gi7RGIlNgyy8GaEtL1tr6Gy
         kSyudst1CEFDQsbv2HCRu44+/B5GFXkdP48pEXF7J2ZxHSABBGs35KM81OU7kpF0PmKn
         CagFAXyZTTAtawkncJ1OlE9yMMi9r9Tv6CsjkiZCoSdGdeDxDF8O3/bCHNhAbPFulnXk
         ktTOR29Q0jYAK7h2gP7IMiOqUqw0sUcq5BepQ12h+N8d10JmhdmN4wcU8/fQ6lugo02w
         HH3A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=H1BMSVZkWADjrieVFVAXMCwoV1IdaPZXkmLHmjV4How=;
        b=UqMHpl1TGUjXvnpM8SRrMZ9Q6svirUY8Ey9j6df0R45ieHLBIRfCSaBQ4aMniji1hZ
         ekBT9k+Jd+9iDAgbwWZAm1TSb+YgiyzA4anNmRvBvQ84Jz4vT773DQnYdAXkaKatqqq7
         gSFT5ZOSwBstiUA/B0zJGdSEK5JOzFmfCBk0FMEltk4YJC+Wlc4rYHIqxM1m8Tn7ZI0n
         21Y0rKurAXOIm1r5ldwp6zQxuySv/SdnvBjFA6kGp5s7whjsUzuVGUrROALamFFIpAKD
         UItlLeel2Ik9EeimvPaCwOar52/hIvVMxAgBOWxsoOrdPHSbtWHTGC7L8C3d6dFTN5C2
         V7/w==
X-Gm-Message-State: AOAM5331wB7D+uyfGn1uIugfr/lq18q6qLCRvnU2hLZVvFdUroVFeQvf
        0IT0Ma8GVIvU9hABu35GGFs+RCTbDfuJkw==
X-Google-Smtp-Source: ABdhPJxOUjDrGfmc17Z/uBTbuo5ouGtNFEhqXL9XB1W+W5/nb10s8/j6F4fq+37EgBeLQvpQGeTAyw==
X-Received: by 2002:a05:651c:33c:: with SMTP id b28mr1858300ljp.219.1590395687723;
        Mon, 25 May 2020 01:34:47 -0700 (PDT)
Received: from ?IPv6:2a00:1fa0:425b:15e7:251c:5b3:d625:2d43? ([2a00:1fa0:425b:15e7:251c:5b3:d625:2d43])
        by smtp.gmail.com with ESMTPSA id o4sm4639825lff.78.2020.05.25.01.34.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 25 May 2020 01:34:46 -0700 (PDT)
Subject: Re: [PATCH] MIPS: Fix IRQ tracing when call handle_fpe()
To:     YuanJunQing <yuanjunqing66@163.com>, tsbogend@alpha.franken.de
Cc:     paulburton@kernel.org, chenhc@lemote.com,
        linux-mips@vger.kernel.org, linux-kernel@vger.kernel.org,
        liulichao@loongson.cn
References: <20200525033123.13114-1-yuanjunqing66@163.com>
From:   Sergei Shtylyov <sergei.shtylyov@cogentembedded.com>
Message-ID: <0cb09824-73c3-d0d0-3bfe-b94e382536d9@cogentembedded.com>
Date:   Mon, 25 May 2020 11:34:40 +0300
User-Agent: Mozilla/5.0 (Windows NT 6.3; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200525033123.13114-1-yuanjunqing66@163.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello!

On 25.05.2020 6:31, YuanJunQing wrote:

>   Register "a1" is unsaved in this function,
>   when CONFIG_TRACE_IRQFLAGS is enabled,
>   the TRACE_IRQS_OFF macro will call trace_hardirqs_off(),
>   and this may change register "a1".
>   The variment of register "a1" may send SIGFPE signal

    Variment?

>   to task when call do_fpe(),and this may kill the task.

    Need space after comma.

> Signed-off-by: YuanJunQing <yuanjunqing66@163.com>
> ---
>   arch/mips/kernel/genex.S | 6 ++++--
>   1 file changed, 4 insertions(+), 2 deletions(-)
> 
> diff --git a/arch/mips/kernel/genex.S b/arch/mips/kernel/genex.S
> index 8236fb291e3f..956a76429773 100644
> --- a/arch/mips/kernel/genex.S
> +++ b/arch/mips/kernel/genex.S
> @@ -480,16 +480,18 @@ NESTED(nmi_handler, PT_SIZE, sp)
>   	/* gas fails to assemble cfc1 for some archs (octeon).*/ \
>   	.set	mips1
>   	SET_HARDFLOAT
> -	cfc1	a1, fcr31
> +	cfc1	s0, fcr31
>   	.set	pop
>   	CLI
>   	TRACE_IRQS_OFF
> +	move    a1,s0

    Need space after comma.

>   	.endm
>   
>   	.macro	__build_clear_msa_fpe
> -	_cfcmsa	a1, MSA_CSR
> +	_cfcmsa	s0, MSA_CSR
>   	CLI
>   	TRACE_IRQS_OFF
> +	move    a1,s0

    Ditto.

[...]

MBR, Sergei
