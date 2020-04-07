Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AE575C2BA1A
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 691AF206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 01:53:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="zSxTGofP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726428AbgDGBxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 21:53:14 -0400
Received: from mail-pf1-f195.google.com ([209.85.210.195]:32880 "EHLO
        mail-pf1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726230AbgDGBxN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 21:53:13 -0400
Received: by mail-pf1-f195.google.com with SMTP id c138so716275pfc.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Apr 2020 18:53:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=eEaA4et6N84qklCqdXFFeqkzbhM+H6IHlqNEE2Wj9aY=;
        b=zSxTGofP7P1Q0I/p64/KRPIbo0W1L3QCssd6UUnUcrfqNxKB5bKpV4Q48EqJVWvWlH
         LRy2UTEETWtKCK6EKfCAMXmMpNI/91yZwv3q6WGWougTQZZyUYzUwgUcb3wu+TOqesE7
         Hq4uDYDC9SdKLA99wDv5lwsLSUz9+WAOdlWvZLTmE0cT56JrkyFoGM/+zTiHQ1csh+qV
         s6glj3JlVjyfkAyjibgTjdOEIpkNFBWFlgR51rVb0DHgfsVqzPoPIJkSy52RQ/xgLb58
         mHEZ8tkScLVWVBDZ9ipMTm8Js+3FR4U3uC/Be8FCLZ4EuPk6TFiWdGmUmNYQ2NwxMncC
         tKgw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=eEaA4et6N84qklCqdXFFeqkzbhM+H6IHlqNEE2Wj9aY=;
        b=aJur39Kzmm7C9lSw8JCSuBe1q/BKDIhfsIFvdJd5vu7pE9iGQs2JE7MOldPvNSwv36
         DHlwki+NDE5Bsw5Xi9V38reLSfoS5HcfFRQGn/12W3JIkUmy5a/duVRtSWkH9ozIDrlY
         m6LTBBScDLZxlCgoqjxbWh/qFt+ZQUYdWMo1dOW0W6S286KZujKpkR/FmCaYrWbMbtV5
         9YO8gqoyetiragpe9YNcQu9TNlm5SDJmujPNI9ujeeaQUz7HqeY14kZG2vSGoEK7k0dr
         O6pSWeuEUq/LdotKYSaI2ZFzu04afi8s+AxU59/dEpFIY56UInZVMinHMpFDbZExiq8z
         dqfw==
X-Gm-Message-State: AGi0PuaSqhcIjt4QFoFAb/PVgPi4blnfBE5A287id/Rx+rHMI/VJPEgU
        N0K13m24S9xCD38BXravgM0nGw==
X-Google-Smtp-Source: APiQypL07PtmER8pma69ww6IcdUNHtWrciRwvz/2Sz++W8I0rPzdaTu15PFRgimEMa34erbkoQkEWw==
X-Received: by 2002:a63:700f:: with SMTP id l15mr1889527pgc.375.1586224392604;
        Mon, 06 Apr 2020 18:53:12 -0700 (PDT)
Received: from ?IPv6:2600:1010:b064:7066:dc53:1479:9187:9f80? ([2600:1010:b064:7066:dc53:1479:9187:9f80])
        by smtp.gmail.com with ESMTPSA id f3sm107921pjo.24.2020.04.06.18.53.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 06 Apr 2020 18:53:11 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH] x86/cpufeatures: Add enumeration for serialize instruction
Date:   Mon, 6 Apr 2020 18:53:10 -0700
Message-Id: <5A5AF726-1D7C-4267-90D8-7E6BD464BA47@amacapital.net>
References: <20200407013843.GB5587@ranerica-svr.sc.intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>, Borislav Petkov <bp@alien8.de>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        LKML <linux-kernel@vger.kernel.org>,
        Ricardo Neri <ricardo.neri@intel.com>, X86 ML <x86@kernel.org>,
        "Ravi V. Shankar" <ravi.v.shankar@intel.com>
In-Reply-To: <20200407013843.GB5587@ranerica-svr.sc.intel.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: iPhone Mail (17E255)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 6, 2020, at 6:37 PM, Ricardo Neri <ricardo.neri-calderon@linux.inte=
l.com> wrote:
>=20
> =EF=BB=BFOn Sat, Apr 04, 2020 at 02:15:57PM -0700, Andy Lutomirski wrote:
>>> On Fri, Apr 3, 2020 at 10:19 PM Ricardo Neri
>>> <ricardo.neri-calderon@linux.intel.com> wrote:
>>>=20
>>> On Fri, Apr 03, 2020 at 10:12:17AM +0200, Borislav Petkov wrote:
>>>> On Thu, Apr 02, 2020 at 06:40:26PM -0700, Ricardo Neri wrote:
>>>>> The serialize instruction ensures that before the next instruction is
>>>>> fetched and executed, all the modifications to flags, registers, and m=
emory
>>>>> made by previous instructions are completed, draining all buffered wri=
tes
>>>>> to memory.
>>>>>=20
>>>>> Importantly, the serialize instruction does not modify registers,
>>>>> arithmetic flags or memory.
>>>>>=20
>>>>> Hence, the serialize instructions provides a better way for software
>>>>> to serialize execution than using instructions such as cpuid, which do=
es
>>>>> modify registers and, in virtual machines, causes a VM exit.
>>>>>=20
>>>>> This instruction is supported by the CPU if CPUID.7H.EDX[bit 14] is
>>>>> set.
>>>>>=20
>>>>> Cc: x86@kernel.org
>>>>> Cc: "Ravi V. Shankar" <ravi.v.shankar@intel.com>
>>>>> Signed-off-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
>>>>> ---
>>>>> This new instruction is documented in the latest version of the Intel
>>>>> Architecture Instruction Set Extensions and Future Features Programmin=
g
>>>>> Reference Chapter 2.1 located at
>>>>> https://software.intel.com/sites/default/files/managed/c5/15/architect=
ure-instruction-set-extensions-programming-reference.pdf
>>>>> ---
>>>>> arch/x86/include/asm/cpufeatures.h | 1 +
>>>>> 1 file changed, 1 insertion(+)
>>>>>=20
>>>>> diff --git a/arch/x86/include/asm/cpufeatures.h b/arch/x86/include/asm=
/cpufeatures.h
>>>>> index db189945e9b0..cd9b1ec022ec 100644
>>>>> --- a/arch/x86/include/asm/cpufeatures.h
>>>>> +++ b/arch/x86/include/asm/cpufeatures.h
>>>>> @@ -364,6 +364,7 @@
>>>>> #define X86_FEATURE_AVX512_VP2INTERSECT (18*32+ 8) /* AVX-512 Intersec=
t for D/Q */
>>>>> #define X86_FEATURE_MD_CLEAR               (18*32+10) /* VERW clears C=
PU buffers */
>>>>> #define X86_FEATURE_TSX_FORCE_ABORT        (18*32+13) /* "" TSX_FORCE_=
ABORT */
>>>>> +#define X86_FEATURE_SERIALIZE              (18*32+14) /* SERIALIZE in=
struction */
>>>>> #define X86_FEATURE_PCONFIG                (18*32+18) /* Intel PCONFIG=
 */
>>>>> #define X86_FEATURE_SPEC_CTRL              (18*32+26) /* "" Speculatio=
n Control (IBRS + IBPB) */
>>>>> #define X86_FEATURE_INTEL_STIBP            (18*32+27) /* "" Single Thr=
ead Indirect Branch Predictors */
>>>>> --
>>>>=20
>>>> Send this together with code which is using it, pls.
>>>=20
>>> Do you mean code in the kernel using this instructions. Thus far, I
>>> don't have any kernel use cases for this instruction. My intention is to=
 expose
>>> this instruction to user space via /proc/cpuinfo. Is that not
>>> acceptable?
>>=20
>> Presumably sync_core() should do, roughly:
>>=20
>> if (static_cpu_has(X86_FEATURE_SERIALIZE)) {
>>  asm volatile("serialize");
>>  return;
>> }
>=20
> Sure Andy, I will look at implementing something as you propose.
>=20
>>=20
>> but with the appropriate magic to build it on older binutils. =20
>=20
> But old binutils will not be aware of this new instruction, right? How
> could they be impacted?

Because old binutils will fail to assemble serialize :). You=E2=80=99re need=
 a macro that turns it into .byte, or, if there=E2=80=99s just one user, you=
 could open-code the .byte.

>=20
>> should make sure that the in-kernel instruction decoder doesn't
>> explode when it sees serialize, presumably.
>=20
> Sure Andy. I will also test for this.
>=20
> Thanks and BR,
> Ricardo
