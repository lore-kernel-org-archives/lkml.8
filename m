Return-Path: <SRS0=AA2M=7E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 14DA6C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 06:29:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E63DE20825
	for <linux-kernel@archiver.kernel.org>; Fri, 22 May 2020 06:29:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PT4yOoiu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728140AbgEVG3k (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 22 May 2020 02:29:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35598 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727839AbgEVG3j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 May 2020 02:29:39 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 682C2C061A0E;
        Thu, 21 May 2020 23:29:39 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id er16so4283340qvb.0;
        Thu, 21 May 2020 23:29:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=HjmL6pfe0f3OhioV2JNbpEM60lA22erI2gsb1y8QDSY=;
        b=PT4yOoiuKuBt/zdxmrF57ViJ9qT4kYjccVUk7DVs1GipOIi/hfbL9Tn+woIX5fd3wM
         wIrnNvSTAYlQb7jgE5DUtDGU28+L7wK9Hc21fd43W8HRmTpJlLck6DsR1xgmoMxSdZLv
         0UjE2FWy02blFLBedkvCwOdgLSud9h4kfXlPTWpWBXSE6nU+HyQlkVTdOkMAqwjPjhhe
         SWbw+VF30WeZNPacf1fW49o2HbnC1oRKurYqgjoNRLMIWvxL4IreseJZK4VKskzt2bFf
         GsNys43B9ssz6DIml/iE/vIJmO7UKbtBWOqTcO+dBgTyYdzSRyphExX9opYO73n+L0f+
         asug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=HjmL6pfe0f3OhioV2JNbpEM60lA22erI2gsb1y8QDSY=;
        b=lsKm/joNmvg8iQM72H7WjMO1AHnlDouoxTFrgnMMBe2/b+O/x1LshxNFoZo6m2FIvU
         2yfWN5uhFdqOJZmgwZgNA5GOVz7WEtkefhxXEMHC8VDNVmq4FD/O/fjHGg9fDMw64Cq3
         YCrLq532TEjk1WoRIhkAt9XgWzPhgwrwd9fnU/3O6tPv8mXQtaik/w7hhE7LDQspeHlv
         BroVn+LyROuGdTZAG/1nzV7udBgeZUewRjV0sWWMLWYxs5vjeaNSktIDNVGmZ/bow2C3
         u4xvZxhyoDvzmhJtY8HO1bCXP3pEIQSmofx0H6+sjPvCUxU2KFE+tR9gBaP1IpPON6+F
         UrOg==
X-Gm-Message-State: AOAM532xeG6ZoOAEKTN/40T4m3lQv8jAnIYftqxRpAw3Yng/Zl4fQTVH
        XdVMTsc3cMrOXDH01Zyc90g=
X-Google-Smtp-Source: ABdhPJyBja49phXuJS/COK+hhpwZH7O+f/HMQzLZuJcaLN+ios1xoFmUBHgcTYOnRbcjwNR4GhzggQ==
X-Received: by 2002:a0c:b60c:: with SMTP id f12mr2308661qve.244.1590128978414;
        Thu, 21 May 2020 23:29:38 -0700 (PDT)
Received: from [192.168.1.209] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id v4sm6198876qkv.43.2020.05.21.23.29.37
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 May 2020 23:29:37 -0700 (PDT)
Subject: Re: [PATCH 5/5] dt-bindings: timer: Add CLINT bindings
To:     Anup Patel <anup@brainfault.org>
Cc:     Anup Patel <anup.patel@wdc.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        Rob Herring <robh+dt@kernel.org>,
        Daniel Lezcano <daniel.lezcano@linaro.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        devicetree@vger.kernel.org, Damien Le Moal <damien.lemoal@wdc.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Atish Patra <atish.patra@wdc.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        linux-riscv <linux-riscv@lists.infradead.org>
References: <20200521134544.816918-1-anup.patel@wdc.com>
 <20200521134544.816918-6-anup.patel@wdc.com>
 <2aec08b7-7197-4b60-89d9-c3b0d5a8a258@gmail.com>
 <CAAhSdy0OuxCwMVPBrvPpYMfVrhUuY3pONysk75yognOM5-0U+g@mail.gmail.com>
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
Message-ID: <c0e9e625-daf8-b72f-2237-06018ff5d8a0@gmail.com>
Date:   Fri, 22 May 2020 02:29:36 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <CAAhSdy0OuxCwMVPBrvPpYMfVrhUuY3pONysk75yognOM5-0U+g@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/22/20 1:54 AM, Anup Patel wrote:
> On Fri, May 22, 2020 at 1:35 AM Sean Anderson <seanga2@gmail.com> wrote=
:
>>
>> On 5/21/20 9:45 AM, Anup Patel wrote:
>>> +Required properties:
>>> +- compatible : "sifive,clint-1.0.0" and a string identifying the act=
ual
>>> +  detailed implementation in case that specific bugs need to be work=
ed around.
>>
>> Should the "riscv,clint0" compatible string be documented here? This
>=20
> Yes, I forgot to add this compatible string. I will add in v2.
>=20
>> peripheral is not really specific to sifive, as it is present in most
>> rocket-chip cores.
>=20
> I agree that CLINT is present in a lot of non-SiFive RISC-V SOCs and
> FPGAs but this IP is only documented as part of SiFive FU540 SOC.
> (Refer, https://static.dev.sifive.com/FU540-C000-v1.0.pdf)
>=20
> The RISC-V foundation should host the CLINT spec independently
> under https://github.com/riscv and make CLINT spec totally open.
>=20
> For now, I have documented it just like PLIC DT bindings found at:
> Documentation/devicetree/bindings/interrupt-controller/sifive,plic-1.0.=
0.txt

The PLIC seems to have its own RISC-V-sponsored documentation [1] which
was split off from the older privileged specs. By your logic above,
should it be renamed to riscv,plic0.txt (with a corresponding change in
the documented compatible strings)?

[1] https://github.com/riscv/riscv-plic-spec

>=20
> If RISC-V maintainers agree then I will document it as "RISC-V CLINT".
>=20
> @Palmer ?? @Paul ??
>=20
> Regards,
> Anup
>=20

--Sean

