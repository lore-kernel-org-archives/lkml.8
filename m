Return-Path: <SRS0=s8dx=5M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8D39FC43331
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:43:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 53BB82073B
	for <linux-kernel@archiver.kernel.org>; Fri, 27 Mar 2020 06:43:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="SPa8DYgm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727495AbgC0GnG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 27 Mar 2020 02:43:06 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:52050 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgC0GnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 Mar 2020 02:43:05 -0400
Received: by mail-pj1-f67.google.com with SMTP id w9so3465910pjh.1;
        Thu, 26 Mar 2020 23:43:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:subject:to:cc:references:from:autocrypt:message-id:date
         :user-agent:mime-version:in-reply-to:content-language
         :content-transfer-encoding;
        bh=Gn4RDiUpqtiQaQrWSiN3ADF547Gz9FwHIuF5Us+3HlI=;
        b=SPa8DYgmQz9Ul5OjDHnV/2oR5deAWvbqWtgplujutcVD4oSxOpf1Dhv4DHbeW/XM8L
         ViJ+hVJyfjmsN+CMfX9s3f5cPdBp0U4Et/cQCV3YwNipSpxvWirpq1GZKkRasnD7HoTe
         ca8SBRHmBPKHpjX0AXAxqqIB1p82oZDN0ONJI8AhQP5FDtAAotN3+sYpqXIxU0ZVF6Fh
         Q8CHIlVGXDOJ/0OAIhVkfRURx9c4tZtEvR8igHVWIHZZwJL+bDtUH0YNBQMCKh+HJGoN
         x6hXLpOKkEhQNk03Etb5ZUklRIDuKHtxgzbw0Pi5+JtckQTdYKo0Yc7CKyUrZQWk3dYO
         janA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=Gn4RDiUpqtiQaQrWSiN3ADF547Gz9FwHIuF5Us+3HlI=;
        b=A8YBdiqv25e5j6wTWicZE8uG21BIo//ydXUqnkP1bKYec1CjiyJyBYBXzp1teww8K3
         ff7JaoqLmGG2qElQ/uGlWizpVnUEUh2iBb8Llsn8M2T5DRvIfH7CFFKn4eq1CVL3qEeW
         MVt12P87s2XkeUvjMaXwuKr+DUeFugyqETun4wL9EhPUKWWHKJuepBgd0pzd6Ac6nUWd
         kH688IqPd9j1gpuLr4LWXM/KuOat2osKq8ouyEj6hb3tcMwYrecMG0yt9RtGLdXJbISc
         V58G3cbMExLJcedZzKqHeyYr+PbUNn+R/jYuVO152nIovnlWvOSEc+bwpHtH1D76xWTx
         PmOg==
X-Gm-Message-State: ANhLgQ2ztM+ahXAP2XYNXuFB6lV4g/LmY707rrt15yCPNQEf94Qdd/EO
        Mu12RxcziwXgUu64C+2CzAT8M4ej
X-Google-Smtp-Source: ADFU+vu26OKVuS4MSs7MMcp5vgHZ4ea4oOOq/pDdUDA0Hb5gb9UNbIYIEIcUygYepHYGbl1RTPcfjw==
X-Received: by 2002:a17:90a:32c1:: with SMTP id l59mr4274806pjb.36.1585291383568;
        Thu, 26 Mar 2020 23:43:03 -0700 (PDT)
Received: from server.roeck-us.net ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id t15sm3065589pgv.61.2020.03.26.23.43.01
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 26 Mar 2020 23:43:02 -0700 (PDT)
Subject: Re: [PATCH] parisc: Regenerate parisc defconfigs
To:     Helge Deller <deller@gmx.de>
Cc:     linux-parisc@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200326202006.GA160630@roeck-us.net>
 <20200326221921.GA20495@ls3530.fritz.box>
From:   Guenter Roeck <linux@roeck-us.net>
Autocrypt: addr=linux@roeck-us.net; keydata=
 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
 mDW4+i+XlNFUPUYMrIKi9joBhu18ssf5i5Q=
Message-ID: <d83868cb-12cd-054e-db85-bcbb9121683a@roeck-us.net>
Date:   Thu, 26 Mar 2020 23:43:01 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200326221921.GA20495@ls3530.fritz.box>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/26/20 3:19 PM, Helge Deller wrote:
> * Guenter Roeck <linux@roeck-us.net>:
>> On Mon, Feb 03, 2020 at 10:31:22PM +0100, Helge Deller wrote:
>>> Regenerate the 32- and 64-bit defconfigs and drop the outdated specific
>>> machine defconfigs for the 712, A500, B160, C3000 and C8000 workstations.
>>> ---
>>>  arch/parisc/configs/712_defconfig           | 181 ---------------
>>>  arch/parisc/configs/a500_defconfig          | 177 ---------------
>>>  arch/parisc/configs/defconfig               | 206 -----------------
>>
>> Since the removal of arch/parisc/configs/defconfig, "make ARCH=parisc
>> defconfig" results in an endless recursive make loop.
> 
> Can you please test the patch below?
> Helge
> 
> ----
> [PATCH] parisc: Fix defconfig selection
> 
> Fix the recursive loop when running "make ARCH=parisc defconfig".
> 
> Fixes: 84669923e1ed ("parisc: Regenerate parisc defconfigs")
> Noticed-by: Guenter Roeck <linux@roeck-us.net>
> Signed-off-by: Helge Deller <deller@gmx.de>

This works.

Tested-by: Guenter Roeck <linux@roeck-us.net>

It would be nice if there was a better way to select 32-bit
vs. 64-bit defconfigs (for example based on the compiler,
or with ARCH={parisc,parisc64}). However, that never worked
for parisc, so I guess we can't expect it to magically work
now, and much less so for a bug fix.

Thanks,
Guenter

> 
> diff --git a/arch/parisc/Kconfig b/arch/parisc/Kconfig
> index 71034b54d74e..3801a2ef9bca 100644
> --- a/arch/parisc/Kconfig
> +++ b/arch/parisc/Kconfig
> @@ -79,6 +79,11 @@ config MMU
>  config STACK_GROWSUP
>  	def_bool y
> 
> +config ARCH_DEFCONFIG
> +	string
> +	default "arch/parisc/configs/generic-32bit_defconfig" if !64BIT
> +	default "arch/parisc/configs/generic-64bit_defconfig" if 64BIT
> +
>  config GENERIC_LOCKBREAK
>  	bool
>  	default y
> diff --git a/arch/parisc/Makefile b/arch/parisc/Makefile
> index dca8f2de8cf5..628cd8bb7ad8 100644
> --- a/arch/parisc/Makefile
> +++ b/arch/parisc/Makefile
> @@ -34,6 +34,13 @@ CC_ARCHES	= hppa hppa2.0 hppa1.1
>  LD_BFD		:= elf32-hppa-linux
>  endif
> 
> +# select defconfig based on actual architecture
> +ifeq ($(shell uname -m),parisc64)
> +	KBUILD_DEFCONFIG := generic-64bit_defconfig
> +else
> +	KBUILD_DEFCONFIG := generic-32bit_defconfig
> +endif
> +
>  export LD_BFD
> 
>  ifneq ($(SUBARCH),$(UTS_MACHINE))
> 

