Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.4 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BF517C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:47:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 92E8320714
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 11:47:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="YQkyImeO"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728166AbgG0Lrg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 07:47:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40956 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726599AbgG0Lrf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 07:47:35 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 512DEC061794;
        Mon, 27 Jul 2020 04:47:35 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id l6so14873525qkc.6;
        Mon, 27 Jul 2020 04:47:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=subject:to:cc:references:from:autocrypt:message-id:date:user-agent
         :mime-version:in-reply-to:content-language:content-transfer-encoding;
        bh=b8Hu+aDDkZnRLMFteWRLRhi9v5IGraUJoPzTS3HMnPE=;
        b=YQkyImeOFzIamZSGxNsV3WEQRE96JA+dVCk+JLIWr4jJ717QhVz/3DfelwTxz4pyBX
         jp8uXVNrYQyLpSskGAMWViZKawGn9SqK/1XT8RTT0h089WmaEHsPXxBQfPx5cc5ZA0hN
         s8Nv9c59RSlKtWSoNjZQOprdrA3j9xxJqlMEctt2rjOYoxwGy/aocGg9/3iKF6UqoiZz
         uvDJMgzuFiGRqIm3OrioXuKJUIcwUeTS7g2sYTTkimHpZmSSf1GFtuSvtMdmXqT/sSRb
         Bch5fXO5nMuQ6ON9p7YOl3se0IXZb5LZUBgjbvLDxBlQFjTID3rE/9Vr1X3UsHIJBfT9
         8+ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:subject:to:cc:references:from:autocrypt
         :message-id:date:user-agent:mime-version:in-reply-to
         :content-language:content-transfer-encoding;
        bh=b8Hu+aDDkZnRLMFteWRLRhi9v5IGraUJoPzTS3HMnPE=;
        b=HC85MdIcaUQf8MEQ4dEwrUo2GEO6+maWqKiciSwLL19NXDBOxJGaAI/F2tAjB7+aHS
         +b8h9wneANpdSt/1HAx8Gy1HW8MEOg5m9o7/GbESl6PV3unOOkgWpXX9eRSGAp0r4iIT
         JRvV735N4aUSIpmwEx8EnW8gyfHENnNXHwkpJA9L/frCX40zuNBnof7XvU1akp/1rteN
         dqOrBJQU5fktus+diFOQSeJ6TlIdsu1PsoEZuDiMzGt4IErh+60I661DUGeRFffVq9Yj
         JOdVtFdrfFzlxXa+brX0z+R9/Cm5VNhbwAdigtq/KSzx4Y7xWmjFW6kJEOWWlM7B+bXb
         QJ/w==
X-Gm-Message-State: AOAM530Fx9U8Tzi8KJZdzjn5TzK2b5k9Co+AC0Ku/yJ0bXO0IkFXvNfP
        ZX9eaKPCczFCajtrpfsZ8Ee/8R3mBY1lCg==
X-Google-Smtp-Source: ABdhPJydiERLz+OzStrCVraLH2F9hKgfHaukPbulB3qdWt48O9VLyu3DrxAwi62YVOuAD59DRgGATw==
X-Received: by 2002:a37:6653:: with SMTP id a80mr21501427qkc.499.1595850454411;
        Mon, 27 Jul 2020 04:47:34 -0700 (PDT)
Received: from [192.168.1.201] (pool-108-51-35-162.washdc.fios.verizon.net. [108.51.35.162])
        by smtp.googlemail.com with ESMTPSA id d14sm13923421qti.41.2020.07.27.04.47.32
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 27 Jul 2020 04:47:33 -0700 (PDT)
Subject: Re: [PATCH v4 4/4] dt-bindings: timer: Add CLINT bindings
To:     Palmer Dabbelt <palmer@dabbelt.com>, atishp@atishpatra.org
Cc:     devicetree@vger.kernel.org, Damien Le Moal <Damien.LeMoal@wdc.com>,
        daniel.lezcano@linaro.org, kernel@esmil.dk,
        Anup Patel <Anup.Patel@wdc.com>, linux-kernel@vger.kernel.org,
        Atish Patra <Atish.Patra@wdc.com>, robh+dt@kernel.org,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Alistair Francis <Alistair.Francis@wdc.com>,
        tglx@linutronix.de, linux-riscv@lists.infradead.org,
        aou@eecs.berkeley.edu
References: <mhng-5833da8b-f9df-46c4-8dbe-0240e39d7bc5@palmerdabbelt-glaptop1>
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
Message-ID: <c1a1b920-124c-23b1-6dd5-1a4cc54659cc@gmail.com>
Date:   Mon, 27 Jul 2020 07:47:32 -0400
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <mhng-5833da8b-f9df-46c4-8dbe-0240e39d7bc5@palmerdabbelt-glaptop1>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/26/20 2:37 PM, Palmer Dabbelt wrote:
> On Tue, 21 Jul 2020 20:55:31 PDT (-0700), anup@brainfault.org wrote:
>> On Tue, Jul 21, 2020 at 5:48 PM Sean Anderson <seanga2@gmail.com> wrot=
e:
>>>
>>> On 7/20/20 9:15 PM, Atish Patra wrote:
>>> > On Fri, Jul 17, 2020 at 12:52 AM Anup Patel <anup.patel@wdc.com> wr=
ote:
>>> >>
>>> >> We add DT bindings documentation for CLINT device.
>>> >>
>>> >> Signed-off-by: Anup Patel <anup.patel@wdc.com>
>>> >> Reviewed-by: Palmer Dabbelt <palmerdabbelt@google.com>
>>> >> Tested-by: Emil Renner Berhing <kernel@esmil.dk>
>>> >> ---
>>> >>  .../bindings/timer/sifive,clint.yaml          | 58 ++++++++++++++=
+++++
>>> >>  1 file changed, 58 insertions(+)
>>> >>  create mode 100644 Documentation/devicetree/bindings/timer/sifive=
,clint.yaml
>>> >>
>>> >> diff --git a/Documentation/devicetree/bindings/timer/sifive,clint.=
yaml b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
>>> >> new file mode 100644
>>> >> index 000000000000..8ad115611860
>>> >> --- /dev/null
>>> >> +++ b/Documentation/devicetree/bindings/timer/sifive,clint.yaml
>>> >> @@ -0,0 +1,58 @@
>>> >> +# SPDX-License-Identifier: (GPL-2.0-only OR BSD-2-Clause)
>>> >> +%YAML 1.2
>>> >> +---
>>> >> +$id: http://devicetree.org/schemas/timer/sifive,clint.yaml#
>>> >> +$schema: http://devicetree.org/meta-schemas/core.yaml#
>>> >> +
>>> >> +title: SiFive Core Local Interruptor
>>> >> +
>>> >> +maintainers:
>>> >> +  - Palmer Dabbelt <palmer@dabbelt.com>
>>> >> +  - Anup Patel <anup.patel@wdc.com>
>>> >> +
>>> >> +description:
>>> >> +  SiFive (and other RISC-V) SOCs include an implementation of the=
 SiFive
>>> >> +  Core Local Interruptor (CLINT) for M-mode timer and M-mode inte=
r-processor
>>> >> +  interrupts. It directly connects to the timer and inter-process=
or interrupt
>>> >> +  lines of various HARTs (or CPUs) so RISC-V per-HART (or per-CPU=
) local
>>> >> +  interrupt controller is the parent interrupt controller for CLI=
NT device.
>>> >> +  The clock frequency of CLINT is specified via "timebase-frequen=
cy" DT
>>> >> +  property of "/cpus" DT node. The "timebase-frequency" DT proper=
ty is
>>> >> +  described in Documentation/devicetree/bindings/riscv/cpus.yaml
>>> >> +
>>> >> +properties:
>>> >> +  compatible:
>>> >> +    items:
>>> >> +      - const: sifive,clint0
>>> >> +      - const: sifive,fu540-c000-clint
>>> >> +
>>> >> +    description:
>>> >> +      Should be "sifive,<chip>-clint" and "sifive,clint<version>"=
=2E
>>> >> +      Supported compatible strings are -
>>> >> +      "sifive,fu540-c000-clint" for the SiFive CLINT v0 as integr=
ated
>>> >> +      onto the SiFive FU540 chip, and "sifive,clint0" for the SiF=
ive
>>> >> +      CLINT v0 IP block with no chip integration tweaks.
>>> >> +      Please refer to sifive-blocks-ip-versioning.txt for details=

>>> >> +
>>> >
>>> > As the DT binding suggests that the clint device should be named as=
 "sifive,**",
>>> > I think we should change the DT property in kendryte dts as well.
>>>
>>> The kendryte device is based on Rocket Chip, not any SiFive IP/device=
=2E
>>> If anything, the general binding should be "chipsalliance,clint" and =
the
>>> specific bindings should be "sifive,clint" and "kendryte,clint" (or
>>> "canaan,clint").
>>
>> AFAIK, Palmer clearly mentioned in previous discussion that CLINT
>> spec is still owned by SiFive. No matter who implements CLINT device
>> in their SOC, we will need one compatible string to represent the
>> spec version (i.e. "sifive,clint0") and another compatible representin=
g
>> specific implementation (for kendryte this can be "kendryte,k210-clint=
").
>=20
> I think "sifive,clint*" is the way to go here.  The Free Chips Foundati=
on owns
> Rocket Chip, which contains an implementation of SiFive's CLINT specifi=
cation,
> but as far as I can tell Free Chips itself does not produce a specifica=
tion for
> the CLINT.  The only CLINT specifications I can find are for SiFive's c=
hips and
> are copyright SiFive, and we generally prefer sticking to specification=
s rather
> than implementations for these sorts of things.

Ah, I wasn't aware that compatibility string assignment was based on
published specifications.

>=20
> To be honest, I'm not even sure the Free Chips CLINT is an implementati=
on of
> the SiFive specification: we don't have the source code for those chips=
, and
> while I'm fairly sure the Chisel source code for the CLINT itself on Si=
Five's
> chips is very close to what was in Rocket Chip at the time those chips =
were
> built (though we don't have the source, so we don't know for user), dev=
ice
> specifications depend on the broader SOC context they are embedded insi=
de.  For
> example: SiFive's CLINT allows us to use simple MMIO reads of mtime to =
meet the
> RISC-V rdtime requirements, but other bus configurations may not meet t=
hose
> requirements.
>=20
> If Free Chips publishes a specification for a CLINT and it's compatible=
 with
> this version of SiFive's CLINT then I don't see any reason why we could=
n't add
> that as a compatible string, but as it currently stands there is no Fre=
e Chips
> CLINT specification.  IMO it would be irresponsible for us to define on=
e on
> their behalf.
>=20
> I don't know anything about Kendryte's specifications, as I haven't rea=
d them
> myself.  Assuming they define the CLINT's behavior in their SOC manual,=
 then

They don't. I emailed some people from Canaan and they said they used
rocketchip as their core. The best thing we have is the documentation in
their SDK [1]. FWIW, these comments almost exactly match the SiFive's
CLINT documentation [2]. I don't know whether that meets Linux's
standards for a "specification" or not.

> adding something along the lines of "canaan,kendryte-k210-clint" seems
> reasonable to me -- don't really care that much about the specific name=
, but as
> we don't define the Kendryte SOCs then calling it anything more general=
 than
> this specific SOC's CLINT seems unreasonable.  AFAIK the Kendryte peopl=
e don't
> get involved with Linux development directly, so that's probably as muc=
h as we
> can define.

--Sean

[1] https://github.com/kendryte/kendryte-standalone-sdk/blob/develop/lib/=
drivers/include/clint.h
[2] e.g. chapter 9 of https://static.dev.sifive.com/U54-MC-RVCoreIP.pdf

