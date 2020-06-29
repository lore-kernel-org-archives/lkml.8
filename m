Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0BEAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:23:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 940B7208B6
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 21:23:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="m9RPAOl/"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2390881AbgF2VXB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 17:23:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36312 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2390976AbgF2VWt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 17:22:49 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E607FC061755
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:22:48 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id k71so5066772pje.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Jun 2020 14:22:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=5xsK0oIThKD+bohTApTv3y1TerDd+wZ2JdpPQEuM5i8=;
        b=m9RPAOl/LoixNt1qg3XtQ/BL58WkcqysD5zZvAuGnbu2WrSuT1F90TMrMS91Ywky8O
         dHReVV3F5J/rpeSbMM5b46gmzkTcXeTTOcRsERDtrKvTVmJfKAlk2UU3i0eQ2rH0CcTJ
         IpU7gGgewS+hx6M5Xltaxs4Hy2+COleo4vjoYhLJRKnU7FQBgOszKYZ0NP0WGCQV1hVB
         5uU796FcEmcZ6hWlSp2sXugA5uC+jLvS41z37Hpz11Ge6iamt/KvXm6sAjiqVFoP8a+8
         k5Nfze2Kdmb7rr/1+2rnbLJ/0mmRZ/UM1bWlUq5N6bfcDJVdm32RiXMxRnGZwd7o6Y0b
         HPfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=5xsK0oIThKD+bohTApTv3y1TerDd+wZ2JdpPQEuM5i8=;
        b=iBUs1Oo3vykUPD9Q+QtY/Op7toAkQq2N3Gm4TaJY6M7YRA9SOGYZ4nTWkINSTEu7Px
         UHfTHrTl0p3xYaUNCAdUxpZpJ9RWgkru+Pb8DOEjoAMwfpu6O3eRJlXqVzweKCPEoplP
         X5RRwMzkyz7zF/i/ZuS6zScHrDyL/YhToAcJuLfMTs+2LEEy3DJSftdIYKfvw2Gq6TiC
         kYTSfyW8P2s1s5fg9nBUV/BIUQseeW7kPR2HTKhDdZe7pGjf1N0keQoyWcrux0vFoU9H
         0TrAHAYLW1skxZI0aBi53HQsl3DOo7giJpDxu1lIym4vK5ii4s58ZmFkPe/XjvphLflP
         gEcQ==
X-Gm-Message-State: AOAM532TbM87vvMEO0EMbNjnPnA0iD8ob7e1/fnpoyjG8tHXDcdcBi9t
        vuZ73l3And0p6gGQyxNH5TNRyQ==
X-Google-Smtp-Source: ABdhPJytK/bJOBQULvmJspF488edThQeq20z7a145ss79B7j5CutYRbetpYc2FRVevHgje1y2QpBSQ==
X-Received: by 2002:a17:902:8204:: with SMTP id x4mr8444721pln.16.1593465768306;
        Mon, 29 Jun 2020 14:22:48 -0700 (PDT)
Received: from ?IPv6:2600:1010:b055:d081:844f:f486:fc68:2fa0? ([2600:1010:b055:d081:844f:f486:fc68:2fa0])
        by smtp.gmail.com with ESMTPSA id q20sm513757pfn.111.2020.06.29.14.22.47
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 29 Jun 2020 14:22:47 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v2] Fix undefined operation VMXOFF during reboot and crash
Date:   Mon, 29 Jun 2020 14:22:45 -0700
Message-Id: <0AFABBBA-18B7-4E2F-BCE7-D69889CC0F79@amacapital.net>
References: <1593464072.34968499@apps.rackspace.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        X86 ML <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        Allison Randal <allison@lohutok.net>,
        Enrico Weigelt <info@metux.net>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Kate Stewart <kstewart@linuxfoundation.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Randy Dunlap <rdunlap@infradead.org>,
        Martin Molnar <martin.molnar.programming@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Alexandre Chartre <alexandre.chartre@oracle.com>,
        Jann Horn <jannh@google.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        LKML <linux-kernel@vger.kernel.org>
In-Reply-To: <1593464072.34968499@apps.rackspace.com>
To:     "David P. Reed" <dpreed@deepplum.com>
X-Mailer: iPhone Mail (17F80)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 29, 2020, at 1:54 PM, David P. Reed <dpreed@deepplum.com> wrote:
>=20
> =EF=BB=BFSimple question for those on the To: and CC: list here. Should I a=
bandon any hope of this patch being accepted? It's been a long time.
>=20
> The non-response after I acknowledged that this was discovered by when wor=
king on a personal, non-commercial research project - which is "out-of-tree"=
 (apparently dirty words on LKML) has me thinking my contribution is unwante=
d. That's fine, I suppose. I can maintain this patch out-of-tree as well.
> I did incorporate all the helpful suggestions I received in this second pa=
tch, and given some encouragement, will happily submit a revised v3 if there=
 is any likelihood of acceptance. I'm wary of doing more radical changes (li=
ke combining emergency and normal paths).
>=20

Sorry about being slow and less actively encouraging than we should be. We a=
bsolutely welcome personal contributions. The actual problem is that everyon=
e is worked and we=E2=80=99re all slow. Also, you may be hitting a corner ca=
se in the process: is this a KVM patch or an x86 patch?

>=20
> On Thursday, June 25, 2020 10:59am, "David P. Reed" <dpreed@deepplum.com> s=
aid:
>=20
>> Correction to my comment below.
>> On Thursday, June 25, 2020 10:45am, "David P. Reed" <dpreed@deepplum.com>=
 said:
>>=20
>>> [Sorry: this is resent because my mailer included HTML, rejected by LKML=
]
>>> Thanks for the response, Sean ... I had thought everyone was too busy to=
 follow
>>> up
>>> from the first version.
>>> =20
>>> I confess I'm not sure why this should be broken up into a patch series,=
 given
>>> that it is so very small and is all aimed at the same category of bug.
>>> =20
>>> And the "emergency" path pre-existed, I didn't want to propose removing i=
t, since
>>> I assumed it was there for a reason. I didn't want to include my own jud=
gement as
>>> to whether there should only be one path. (I'm pretty sure I didn't find=
 a VMXOFF
>>> in KVM separately from the instance in this include file, but I will che=
ck).
>> Just checked. Yes, the kvm code's handling of VMXOFF is separate, and tho=
ugh it
>> uses exception masking, seems to do other things, perhaps related to nest=
ed KVM,
>> but I haven't studied the deep logic of KVM nesting.
>>=20
>>> =20
>>> A question: if I make it a series, I have to test each patch doesn't bre=
ak
>>> something individually, in order to handle the case where one patch is a=
ccepted
>>> and the others are not. Do I need to test each individual patch thorough=
ly as an
>>> independent patch against all those cases?
>>> I know the combination don't break anything and fixes the issues I've di=
scovered
>>> by testing all combinations (and I've done some thorough testing of pani=
cs,
>>> oopses
>>> crashes, kexec, ... under all combinations of CR4.VMXE enablement and cr=
ash
>>> source
>>> to verify the fix fixes the problem's manifestations and to verify that i=
t
>>> doesn't
>>> break any of the working paths.
>>> =20
>>> That said, I'm willing to do a v3 "series" based on these suggestions if=
 it will
>>> smooth its acceptance. If it's not going to get accepted after doing tha=
t, my
>>> motivation is flagging.
>>> On Thursday, June 25, 2020 2:06am, "Sean Christopherson"
>>> <sean.j.christopherson@intel.com> said:
>>>=20
>>>=20
>>>=20
>>>>> On Thu, Jun 11, 2020 at 03:48:18PM -0400, David P. Reed wrote:
>>>>>> -/** Disable VMX on the current CPU
>>>>>> +/* Disable VMX on the current CPU
>>>>>> *
>>>>>> - * vmxoff causes a undefined-opcode exception if vmxon was not run
>>>>>> - * on the CPU previously. Only call this function if you know VMX
>>>>>> - * is enabled.
>>>>>> + * vmxoff causes an undefined-opcode exception if vmxon was not run
>>>>>> + * on the CPU previously. Only call this function directly if you kn=
ow VMX
>>>>>> + * is enabled *and* CPU is in VMX root operation.
>>>>>> */
>>>>>> static inline void cpu_vmxoff(void)
>>>>>> {
>>>>>> - asm volatile ("vmxoff");
>>>>>> + asm volatile ("vmxoff" ::: "cc", "memory"); /* clears all flags on s=
uccess
>>>>> */
>>>>>> cr4_clear_bits(X86_CR4_VMXE);
>>>>>> }
>>>>>>=20
>>>>>> @@ -47,17 +47,35 @@ static inline int cpu_vmx_enabled(void)
>>>>>> return __read_cr4() & X86_CR4_VMXE;
>>>>>> }
>>>>>>=20
>>>>>> -/** Disable VMX if it is enabled on the current CPU
>>>>>> - *
>>>>>> - * You shouldn't call this if cpu_has_vmx() returns 0.
>>>>>> +/*
>>>>>> + * Safely disable VMX root operation if active
>>>>>> + * Note that if CPU is not in VMX root operation this
>>>>>> + * VMXOFF will fault an undefined operation fault,
>>>>>> + * so use the exception masking facility to handle that RARE
>>>>>> + * case.
>>>>>> + * You shouldn't call this directly if cpu_has_vmx() returns 0
>>>>>> + */
>>>>>> +static inline void cpu_vmxoff_safe(void)
>>>>>> +{
>>>>>> + asm volatile("1:vmxoff\n\t" /* clears all flags on success */
>>>>>=20
>>>>> Eh, I wouldn't bother with the comment, there are a million other cave=
ats
>>>>> with VMXOFF that are far more interesting.
>>>>>=20
>>>>>> + "2:\n\t"
>>>>>> + _ASM_EXTABLE(1b, 2b)
>>>>>> + ::: "cc", "memory");
>>>>>=20
>>>>> Adding the memory and flags clobber should be a separate patch.
>>>>>=20
>>>>>> + cr4_clear_bits(X86_CR4_VMXE);
>>>>>> +}
>>>>>=20
>>>>>=20
>>>>> I don't see any value in safe/unsafe variants. The only in-kernel user=
 of
>>>>> VMXOFF outside of the emergency flows is KVM, which has its own VMXOFF=

>>>>> helper, i.e. all users of cpu_vmxoff() want the "safe" variant. Just a=
dd
>>>>> the exception fixup to cpu_vmxoff() and call it good.
>>>>>=20
>>>>>> +
>>>>>> +/*
>>>>>> + * Force disable VMX if it is enabled on the current CPU,
>>>>>> + * when it is unknown whether CPU is in VMX operation.
>>>>>> */
>>>>>> static inline void __cpu_emergency_vmxoff(void)
>>>>>> {
>>>>>> - if (cpu_vmx_enabled())
>>>>>> - cpu_vmxoff();
>>>>>> + if (!cpu_vmx_enabled())
>>>>>> + return;
>>>>>> + cpu_vmxoff_safe();
>>>>>=20
>>>>> Unnecessary churn.
>>>>>=20
>>>>>> }
>>>>>>=20
>>>>>> -/** Disable VMX if it is supported and enabled on the current CPU
>>>>>> +/* Force disable VMX if it is supported on current CPU
>>>>>> */
>>>>>> static inline void cpu_emergency_vmxoff(void)
>>>>>> {
>>>>>> diff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c
>>>>>> index e040ba6be27b..b0e6b106a67e 100644
>>>>>> --- a/arch/x86/kernel/reboot.c
>>>>>> +++ b/arch/x86/kernel/reboot.c
>>>>>> @@ -540,21 +540,14 @@ static void emergency_vmx_disable_all(void)
>>>>>> *
>>>>>> * For safety, we will avoid running the nmi_shootdown_cpus()
>>>>>> * stuff unnecessarily, but we don't have a way to check
>>>>>> - * if other CPUs have VMX enabled. So we will call it only if the
>>>>>> - * CPU we are running on has VMX enabled.
>>>>>> - *
>>>>>> - * We will miss cases where VMX is not enabled on all CPUs. This
>>>>>> - * shouldn't do much harm because KVM always enable VMX on all
>>>>>> - * CPUs anyway. But we can miss it on the small window where KVM
>>>>>> - * is still enabling VMX.
>>>>>> + * if other CPUs have VMX enabled.
>>>>>> */
>>>>>> - if (cpu_has_vmx() && cpu_vmx_enabled()) {
>>>>>> + if (cpu_has_vmx()) {
>>>>>> /* Disable VMX on this CPU. */
>>>>>> - cpu_vmxoff();
>>>>>> + cpu_emergency_vmxoff();
>>>>>=20
>>>>> This also needs to be in a separate patch. And it should use
>>>>> __cpu_emergency_vmxoff() instead of cpu_emergency_vmxoff().
>>>>>=20
>>>>>>=20
>>>>>> /* Halt and disable VMX on the other CPUs */
>>>>>> nmi_shootdown_cpus(vmxoff_nmi);
>>>>>> -
>>>>>> }
>>>>>> }
>>>>>>=20
>>>>>> --
>>>>>> 2.26.2
>>>>>>=20
>>>>>=20
>>>=20
>>>=20
>>=20
>>=20
>>=20
>=20
>=20
