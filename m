Return-Path: <SRS0=Rqeb=BC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF0A8C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 02:13:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BEB0F20781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Jul 2020 02:13:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=dabbelt-com.20150623.gappssmtp.com header.i=@dabbelt-com.20150623.gappssmtp.com header.b="G725Kcgv"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387778AbgGWCNL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Jul 2020 22:13:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387467AbgGWCNK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jul 2020 22:13:10 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5E698C0619DC
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 19:13:10 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id d4so2283276pgk.4
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jul 2020 19:13:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=dabbelt-com.20150623.gappssmtp.com; s=20150623;
        h=date:subject:in-reply-to:cc:from:to:message-id:mime-version
         :content-transfer-encoding;
        bh=VIh7LORRnYnHbsVileK4t00kEVEKZppqimtaFGwwCyk=;
        b=G725KcgvUWYRPeij66AWuy2iN9XXkhx3pb7L8lUs/jvW0dWxo/cuEdQmYpMpDGC9Th
         +bvq0hXt7xPT7ZvIO7rs/JGcbd0ipvtXt1f4L1dqhLLpySLTPadIubGmGNPOC+/FJpKZ
         HwcVcFa/fVBTluncxEi7n6GKjjXN6QXh6J8TBlHcPfD703uEI2ujIf4JbdN6yLzhmeDv
         2wql7KpaoTfO1jS6X5d5kRyRbHfJilf5AZiEpkYy68jT336XrFIrrJJsCIrXIJH3xl/V
         hn/HwxD2zAOBh330fUo5/hwHkxp6eqcWBzOF8oUfwRXkWAj+CMuieSntNhikDlNQiYny
         52BQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:subject:in-reply-to:cc:from:to:message-id
         :mime-version:content-transfer-encoding;
        bh=VIh7LORRnYnHbsVileK4t00kEVEKZppqimtaFGwwCyk=;
        b=lx8F6RcD3Mw9INj/t5mJdxEK/Kh/2yynjfzB+V/XxWs5PSGNE+qDqAyHOcM0nB0iYd
         YwIsmvjFW+5mPoXrPclEONzDSkbl0oOj4GfoWJY8Sa9JWbaLeu8gcJcg2gaInx2Av5Jh
         jXS3j199i+pAQ3E8Hr60tobqdm8DXYjEnvYypqy6SaCvNZNhi+iumjNmPTstztshJUUk
         ZZaaXeUIOWoZPo1UjcygGpKWzlwgsaHDio1sZqJdJOpn+AluZeo37WERf0owFJ4wkAB7
         t32XKDDpuNfQm9VfRn9Y0C4L6LyqHYaTA3yBbR84I8t92IvK/kU2GLg4CQyvZ/3rIukC
         iTcg==
X-Gm-Message-State: AOAM533xrQU9tEAMrMRGW1mvpylTVXaYFDiXVDOUH42wR0IbFdRxX6YA
        4zYeBfJLYp/i23mCLdUrAKWISG2yuFA=
X-Google-Smtp-Source: ABdhPJyHQFHDIVofGYjLnQ9glzpgMMjE+iZHAhj9CAJYLWNzL41oZmuRp2f2W/fXwG87NKg7YZCttA==
X-Received: by 2002:aa7:988f:: with SMTP id r15mr2216804pfl.2.1595470389490;
        Wed, 22 Jul 2020 19:13:09 -0700 (PDT)
Received: from localhost (76-210-143-223.lightspeed.sntcca.sbcglobal.net. [76.210.143.223])
        by smtp.gmail.com with ESMTPSA id u24sm904505pfm.211.2020.07.22.19.13.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Jul 2020 19:13:08 -0700 (PDT)
Date:   Wed, 22 Jul 2020 19:13:08 -0700 (PDT)
X-Google-Original-Date: Wed, 22 Jul 2020 19:13:07 PDT (-0700)
Subject:     Re: [PATCH 1/1] riscv: Enable ARCH_HAS_FAST_MULTIPLIER for RV64I
In-Reply-To: <ca14f182-21e4-adb2-d6cf-da3e1cd7b104@eswin.com>
CC:     kernel@esmil.dk, Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org, chenxi.mao2013@gmail.com,
        wangqiang1@eswin.com
From:   Palmer Dabbelt <palmer@dabbelt.com>
To:     maochenxi@eswin.com
Message-ID: <mhng-f0599c86-b976-4116-9228-7da783085905@palmerdabbelt-glaptop1>
Mime-Version: 1.0 (MHng)
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 22 Jul 2020 18:59:12 PDT (-0700), maochenxi@eswin.com wrote:
> Hi Palmer and Emil:
>
> As Emil mentioned in previous E-mail loop, I did the same test on my kernel as well.

Sorry, I guess I crossed up my emails.  I think it's best to just drop this for
now, as it doesn't actually seem to generate better code for our current
target.

>
> My kernel is based on Linux 5.8-RC6 with GCC-10.1. (ISA C extension enabled)
>
> The disassembly code as below:
>
> CONFIG_ARCH_HAS_FAST_MULTIPLIER enabled:
>
> 0000000000000000 <__sw_hweight32>:
>    0:    555557b7              lui    a5,0x55555
>    4:    0015571b              srliw    a4,a0,0x1
>    8:    55578793              addi    a5,a5,1365 # 55555555 <.LASF5+0x5555509d>
>    c:    8ff9                    and    a5,a5,a4
>    e:    9d1d                    subw    a0,a0,a5
>
> 0000000000000010 <.LVL1>:
>   10:    333337b7              lui    a5,0x33333
>   14:    33378793              addi    a5,a5,819 # 33333333 <.LASF5+0x33332e7b>
>   18:    0025571b              srliw    a4,a0,0x2
>   1c:    8d7d                    and    a0,a0,a5
>   1e:    8ff9                    and    a5,a5,a4
>   20:    9fa9                    addw    a5,a5,a0
>   22:    0047d51b              srliw    a0,a5,0x4
>   26:    9fa9                    addw    a5,a5,a0
>   28:    0f0f1537              lui    a0,0xf0f1
>   2c:    1141                    addi    sp,sp,-16
>   2e:    f0f50513              addi    a0,a0,-241 # f0f0f0f <.LASF5+0xf0f0a57>
>   32:    e422                    sd    s0,8(sp)
>   34:    8fe9                    and    a5,a5,a0
>   36:    0800                    addi    s0,sp,16
>   38:    0087951b              slliw    a0,a5,0x8
>   3c:    6422                    ld    s0,8(sp)
>   3e:    9d3d                    addw    a0,a0,a5
>   40:    0105179b              slliw    a5,a0,0x10
>   44:    9d3d                    addw    a0,a0,a5
>   46:    0185551b              srliw    a0,a0,0x18
>   4a:    0141                    addi    sp,sp,16
>   4c:    8082                    ret
>
> CONFIG_ARCH_HAS_FAST_MULTIPLIER disabled:
>
> 000000000000004e <__sw_hweight32_default>:
>   4e:    55555737              lui    a4,0x55555
>   52:    0015579b              srliw    a5,a0,0x1
>   56:    55570713              addi    a4,a4,1365 # 55555555 <.LASF5+0x5555509d>
>   5a:    8ff9                    and    a5,a5,a4
>   5c:    9d1d                    subw    a0,a0,a5
>
> 000000000000005e <.LVL3>:
>   5e:    333337b7              lui    a5,0x33333
>   62:    33378793              addi    a5,a5,819 # 33333333 <.LASF5+0x33332e7b>
>   66:    0025571b              srliw    a4,a0,0x2
>   6a:    8d7d                    and    a0,a0,a5
>   6c:    8ff9                    and    a5,a5,a4
>   6e:    9fa9                    addw    a5,a5,a0
>   70:    0047d51b              srliw    a0,a5,0x4
>   74:    9d3d                    addw    a0,a0,a5
>   76:    0f0f17b7              lui    a5,0xf0f1
>   7a:    1141                    addi    sp,sp,-16
>   7c:    f0f78793              addi    a5,a5,-241 # f0f0f0f <.LASF5+0xf0f0a57>
>   80:    e422                    sd    s0,8(sp)
>   82:    8fe9                    and    a5,a5,a0
>   84:    0800                    addi    s0,sp,16
>   86:    0087d51b              srliw    a0,a5,0x8
>   8a:    6422                    ld    s0,8(sp)
>   8c:    9fa9                    addw    a5,a5,a0
>   8e:    0107d51b              srliw    a0,a5,0x10
>   92:    9d3d                    addw    a0,a0,a5
>   94:    0ff57513              andi    a0,a0,255
>   98:    0141                    addi    sp,sp,16
>   9a:    8082                    ret
>
> This 2 implementations is almost same but small differences.
>
> Especially in CONFIG_ARCH_HAS_FAST_MULTIPLIER condition,  below code didn't use "mul" instructions.
>
>     " return (w * 0x01010101) >> 24; "
>
> So I am trying to translate this code with inline assembly as below:
>
> //return (w * 0x01010101) >> 24;
> __asm__ (
> " mul %0, %0, %1\n"
> : "+r" (w)
> : "r" (w), "r"(0x01010101)
> :);
> return w >> 24;
>
> After above change, the disassambly as below:
> 0000000000000000 <__sw_hweight32>:
>    0:    555557b7              lui    a5,0x55555
>    4:    0015571b              srliw    a4,a0,0x1
>    8:    55578793              addi    a5,a5,1365 # 55555555 <.LASF5+0x55555119>
>    c:    8ff9                    and    a5,a5,a4
>    e:    9d1d                    subw    a0,a0,a5
>
> 0000000000000010 <.LVL1>:
>   10:    333337b7              lui    a5,0x33333
>   14:    0025571b              srliw    a4,a0,0x2
>   18:    33378793              addi    a5,a5,819 # 33333333 <.LASF5+0x33332ef7>
>   1c:    8d7d                    and    a0,a0,a5
>   1e:    8ff9                    and    a5,a5,a4
>   20:    9fa9                    addw    a5,a5,a0
>   22:    0047d71b              srliw    a4,a5,0x4
>   26:    9f3d                    addw    a4,a4,a5
>   28:    0f0f17b7              lui    a5,0xf0f1
>   2c:    1141                    addi    sp,sp,-16
>   2e:    f0f78793              addi    a5,a5,-241 # f0f0f0f <.LASF5+0xf0f0ad3>
>   32:    e422                    sd    s0,8(sp)
>   34:    8ff9                    and    a5,a5,a4
>   36:    0800                    addi    s0,sp,16
>   38:    01010737              lui    a4,0x1010
>   3c:    853e                    mv    a0,a5
>
> 000000000000003e <.LVL2>:
>   3e:    1017071b              addiw    a4,a4,257
>   42:    02f50533              mul    a0,a0,a5
>   46:    6422                    ld    s0,8(sp)
>   48:    0185551b              srliw    a0,a0,0x18
>
> "mul" instruction is leveraged as expectation, but 0x01010101 load waste several instructions.
>
> Based on this test, force to leverage "mul" instruction might be not faster than current compiler implementations.
>
> I am not sure above assembly is the best way to load 0x01010101? I checked the ISA manual, "lui" only
>
> load 20 bits per time, is this the best way to load instants?
>
>
> On the other hand, I try to compare ARM64 disassembly code:
>
> .....
>
>    4:    3200c3e2     mov    w2, #0x1010101                 // #16843009
>
> ......
>
>    w =  (w + (w >> 4)) & 0x0f0f0f0f;
>   20:    0b401000     add    w0, w0, w0, lsr #4
>   24:    1200cc00     and    w0, w0, #0xf0f0f0f
>     return (w * 0x01010101) >> 24;
>   28:    1b027c00     mul    w0, w0, w2
>
> Only one "mov" instructions to load 0x1010101 and one "mul" instruction for multiply.
>
>
> Let me summary as below:
>
> 1.  GCC 10.1 cannot generate "mul" instruction when CONFIG_ARCH_HAS_FAST_MULTIPLIER enabled.
>
> 2. force to generate "mul" didn't get better because instants load waste instructions.
>
> 3. If GCC compiler behavior is best solution for this case, we could have below work around on Riscv.
>
>  unsigned int __sw_hweight32(unsigned int w)
>  {
> -#ifdef CONFIG_ARCH_HAS_FAST_MULTIPLIER
> +/*
> + * Risc-V could not generate mul(w) instruction in this case
> + */
> +#if defined(CONFIG_ARCH_HAS_FAST_MULTIPLIER) && !defined(CONFIG_RISCV)
>         w -= (w >> 1) & 0x55555555;
>         w =  (w & 0x33333333) + ((w >> 2) & 0x33333333);
>         w =  (w + (w >> 4)) & 0x0f0f0f0f;
>
>
> Chenxi
>
>
> On 2020/7/21 上午9:17, Palmer Dabbelt wrote:
>> On Wed, 08 Jul 2020 22:19:22 PDT (-0700), maochenxi@eswin.com wrote:
>>> Enable ARCH_HAS_FAST_MULTIPLIER on RV64I
>>> which works fine on GCC-9.3 and GCC-10.1
>>>
>>> PS2: remove ARCH_SUPPORTS_INT128 because of RV64I already enabled.
>>>
>>> Signed-off-by: Chenxi Mao <maochenxi@eswin.com>
>>> ---
>>>  arch/riscv/Kconfig | 1 +
>>>  1 file changed, 1 insertion(+)
>>>
>>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>>> index 128192e14ff2..84e6777fecad 100644
>>> --- a/arch/riscv/Kconfig
>>> +++ b/arch/riscv/Kconfig
>>> @@ -202,6 +202,7 @@ config ARCH_RV64I
>>>      bool "RV64I"
>>>      select 64BIT
>>>      select ARCH_SUPPORTS_INT128 if CC_HAS_INT128 && GCC_VERSION >= 50000
>>> +    select ARCH_HAS_FAST_MULTIPLIER
>>>      select HAVE_DYNAMIC_FTRACE if MMU
>>>      select HAVE_DYNAMIC_FTRACE_WITH_REGS if HAVE_DYNAMIC_FTRACE
>>>      select HAVE_FTRACE_MCOUNT_RECORD
>>
>> Ah, thanks -- this one didn't show up when I was looking at the last one.  I
>> think we can put the fast multiplier on rv32 and rv64, there shouldn't be any
>> difference there.  I guess in theory we should be sticking this all in some
>> sort of "platform type" optimization flags, but that's probably bit much for
>> now.
