Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CB70C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:37:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AAF42078C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:37:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="mcnIkGcJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406686AbgE1Thf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:37:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33738 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406676AbgE1Tha (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:37:30 -0400
Received: from mail-qt1-x841.google.com (mail-qt1-x841.google.com [IPv6:2607:f8b0:4864:20::841])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39884C08C5C7;
        Thu, 28 May 2020 12:37:30 -0700 (PDT)
Received: by mail-qt1-x841.google.com with SMTP id x29so11875qtv.4;
        Thu, 28 May 2020 12:37:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=JFF264SusAUehjXwP9Goi3exYGSw95TFftOywym8sME=;
        b=mcnIkGcJMYx5FNx609XJu0TkCeY5ioSR8B+qiRtl6z8YeClrkkXkxW/neQnC3rew06
         Znl8RX3FVG5z9wA0bZw6Hd7zW/F46iyFkyByKlpUCt+t76idGuYKj3D0Y2KMPGdKCMqq
         W3hR2h4/f1Rv0FzJcKBZmmX78/kEia/TUZ3eJeX6Uwsl92bOVdOR+2wJPYsk1jRlH82z
         vgJEaAFalRs5JRZmS6ZY/9L0/vRAtLaWKM/Z9KFs+tZkrQmTv8fsItgY4wOj6pW7drHy
         2gMJEWAlJ3dhRbP+IGyNdDZ/jB3i0Lsh6oYb4kj42vIsLPVxVTqoRDMQWpvYgG3fq1Wd
         pFHw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=JFF264SusAUehjXwP9Goi3exYGSw95TFftOywym8sME=;
        b=eZ8obGbARxCkUQM+7ywgTWyAVGO9LDR491MRM+gSSC6zeIX8RrrnjTPdtKMCfRXk7u
         R4pmZSzqe6pph4USzBffkHZ71UmMQG9SztqfHFuFCM0pmY1jmhHAxHoXdGXVHrK6dlh7
         bZrscNBsYWShraHp41HloPoWBl4QB9BG+HRJngwsHHH17tUEcYd+YyXd4ehS2yXrt4zd
         NgtT0fF1rOHZaXkJd1kzJFic3EEjPR6CMXATeOUzucOnPSXX1K2EsEry3fhERK67H3c5
         CKt+joR89uGAQE2rAIKmL+IxHOx2gAzXtqx54di9S/tzc4riNVqzzIWAYDCedJfXwOAt
         bQRA==
X-Gm-Message-State: AOAM530XBNtbOk8/YPwb1774onsQIZxosCmfrgvCG4ZpqDGJr+sah2vH
        Ag765LXJhjANHDtPYrdYOdM=
X-Google-Smtp-Source: ABdhPJwPUzR2IDBQb5dG8Gy5FhzEuIqk3+vykCQTGssKl/GIYIPBOn3d3hNc8cBc0fECly0dbEKOaQ==
X-Received: by 2002:ac8:7112:: with SMTP id z18mr5018357qto.274.1590694648920;
        Thu, 28 May 2020 12:37:28 -0700 (PDT)
Received: from [192.168.1.209] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id d21sm5975052qtr.45.2020.05.28.12.37.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 28 May 2020 12:37:27 -0700 (PDT)
Subject: Re: [PATCH 5/5] dt-bindings: timer: Add CLINT bindings
To:     Palmer Dabbelt <palmer@dabbelt.com>
Cc:     anup@brainfault.org, Anup Patel <Anup.Patel@wdc.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        aou@eecs.berkeley.edu, robh+dt@kernel.org,
        daniel.lezcano@linaro.org, tglx@linutronix.de,
        devicetree@vger.kernel.org, Damien Le Moal <Damien.LeMoal@wdc.com>,
        linux-kernel@vger.kernel.org, Atish Patra <Atish.Patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv@lists.infradead.org
References: <mhng-0995a264-b39c-4790-9aa5-b8c598b43ffd@palmerdabbelt-glaptop1>
From:   Sean Anderson <seanga2@gmail.com>
Autocrypt: addr=seanga2@gmail.com; prefer-encrypt=mutual; keydata=
 mQENBFe74PkBCACoLC5Zq2gwrDcCkr+EPGsT14bsxrW07GiYzQhLCgwnPdEpgU95pXltbFhw
 46GfyffABWxHKO2x+3L1S6ZxC5AiKbYXo7lpnTBYjamPWYouz+VJEVjUx9aaSEByBah5kX6a
 lKFZWNbXLAJh+dE1HFaMi3TQXXaInaREc+aO1F7fCa2zNE75ja+6ah8L4TPRFZ2HKQzve0/Y
 GXtoRw97qmnm3U36vKWT/m2AiLF619F4T1mHvlfjyd9hrVwjH5h/2rFyroXVXBZHGA9Aj8eN
 F2si35dWSZlIwXkNu9bXp0/pIu6FD0bI+BEkD5S7aH1G1iAcMFi5Qq2RNa041DfQSDDHABEB
 AAG0K1NlYW4gR2FsbGFnaGVyIEFuZGVyc29uIDxzZWFuZ2EyQGdtYWlsLmNvbT6JAVcEEwEK
 AEECGwMFCwkIBwIGFQgJCgsCBBYCAwECHgECF4ACGQEWIQSQYR1bzo1I0gPoYCg+6I/stKEQ
 bgUCXT+S2AUJB2TlXwAKCRA+6I/stKEQbhNOB/9ooea0hU9Sgh7PBloU6CgaC5mlqPLB7NTp
 +JkB+nh3Fqhk+qLZwzEynnuDLl6ESpVHIc0Ym1lyF4gT3DsrlGT1h0Gzw7vUwd1+ZfN0CuIx
 Rn861U/dAUjvbtN5kMBqOI4/5ea+0r7MACcIVnKF/wMXBD8eypHsorT2sJTzwZ6DRCNP70C5
 N1ahpqqNmXe0uLdP0pu55JCqhrGw2SinkRMdWyhSxT56uNwIVHGhLTqH7Q4t1N6G1EH626qa
 SvIJsWlNpll6Y3AYLDw2/Spw/hqieS2PQ/Ky3rPZnvJt7/aSNYsKoFGX0yjkH67Uq8Lx0k1L
 w8jpXnbEPQN3A2ZJCbeMuQENBF0/k2UBCADhvSlHblNc/aRAWtCFDblCJJMN/8Sd7S9u4ZRS
 w1wIB4tTF7caxc8yfCHa+FjMFeVu34QPtMOvd/gfHz0mr+t0PiTAdDSbd6o7tj+g5ylm+FhT
 OTUtJQ6mx6L9GzMmIDEbLxJMB9RfJaL2mT5JkujKxEst6nlHGV/lEQ54xBl5ImrPvuR5Dbnr
 zWQYlafb1IC5ZFwSMpBeSfhS7/kGPtFY3NkpLrii/CF+ME0DYYWxlkDIycqF3fsUGGfb3HIq
 z2l95OB45+mCs9DrIDZXRT6mFjLcl35UzuEErNIskCl9NKlbvAMAl+gbDH275SnE44ocC4qu
 0tMe7Z5jpOy6J8nNABEBAAGJATwEGAEKACYWIQSQYR1bzo1I0gPoYCg+6I/stKEQbgUCXT+T
 ZQIbDAUJAeEzgAAKCRA+6I/stKEQbjAGB/4mYRqZTTEFmcS+f+8zsmjt2CfWvm38kR+sJFWB
 vz82pFiUWbUM5xvcuOQhz698WQnIazbDGSYaOipyVNS52YiuYJDqMszzgw++DrcSuu0oRYWN
 EWCkJjxMqjGg8uY0OZ6FJG+gYRN5wMFErGfV1OqQ7l00FYA9OzpOEuW9PzPZEutFnAbbh77i
 zvxbQtT7IJCL24A4KutNYKmWg98im4mCzQcJCxE86Bv69ErLVPUyYbp4doLadScilXlvkkjL
 iq1wOt3rRzOuw+qnWVgWGBPxdDftz0Wck941tYF9XE0aMgkf4o1sGoDZFUFPCQdfEYPzzV7O
 S5hN3/mP5UeooFHb
Message-ID: <51c82a3f-15d1-3c1b-9bee-d89fea706e28@gmail.com>
Date:   Thu, 28 May 2020 15:37:26 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <mhng-0995a264-b39c-4790-9aa5-b8c598b43ffd@palmerdabbelt-glaptop1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/26/20 8:32 PM, Palmer Dabbelt wrote:
> On Thu, 21 May 2020 23:29:36 PDT (-0700), seanga2@gmail.com wrote:
>> On 5/22/20 1:54 AM, Anup Patel wrote:
>>> On Fri, May 22, 2020 at 1:35 AM Sean Anderson <seanga2@gmail.com> wrote:
>>>>
>>>> On 5/21/20 9:45 AM, Anup Patel wrote:
>>>>> +Required properties:
>>>>> +- compatible : "sifive,clint-1.0.0" and a string identifying the actual
>>>>> +  detailed implementation in case that specific bugs need to be worked around.
>>>>
>>>> Should the "riscv,clint0" compatible string be documented here? This
>>>
>>> Yes, I forgot to add this compatible string. I will add in v2.
>>>
>>>> peripheral is not really specific to sifive, as it is present in most
>>>> rocket-chip cores.
>>>
>>> I agree that CLINT is present in a lot of non-SiFive RISC-V SOCs and
>>> FPGAs but this IP is only documented as part of SiFive FU540 SOC.
>>> (Refer, https://static.dev.sifive.com/FU540-C000-v1.0.pdf)
>>>
>>> The RISC-V foundation should host the CLINT spec independently
>>> under https://github.com/riscv and make CLINT spec totally open.
>>>
>>> For now, I have documented it just like PLIC DT bindings found at:
>>> Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.0.txt
>>
>> The PLIC seems to have its own RISC-V-sponsored documentation [1] which
>> was split off from the older privileged specs. By your logic above,
>> should it be renamed to riscv,plic0.txt (with a corresponding change in
>> the documented compatible strings)?
>>
>> [1] https://github.com/riscv/riscv-plic-spec
> 
> Let's propose tagging that PLIC spec as v1.0.0 in the platform spec group, but
> I don't see a reason why that wouldn't be viable.  Assuming that's all OK, we
> can start calling this a RISC-V PLIC (in addition to a SiFive PLIC, as they'll
> be compatible).

Is there a version anyewhere in that spec? I looked around a bit and
couldn't find one.

>>>
>>> If RISC-V maintainers agree then I will document it as "RISC-V CLINT".
>>>
>>> @Palmer ?? @Paul ??
> 
> The CLINT is a SiFive spec.  It has open source RTL so it's been implemented in
> other designs, but it's not a RISC-V spec.  The CLIC, which is a superset of
> the CLINT, is a RISC-V spec.  IIRC it's not finished yet (it's the fast
> interrupts task group), but presumably we should have a "riscv,clic-2.0.0" (or
> whatever it ends up being called) compat string to go along with the
> specification.

The rocket chip is a Chips Alliance project on github; presumably the
"proper" compatibility string would be something like
"chips-alliance,clint"? Alternatively, it is already referred to as
"riscv,clint0" in U-Boot, following the pattern of the plic.

--Sean
