Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F22D2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:59:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEE52207BB
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:59:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="qyHUnORE"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405639AbgFYO7G (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 10:59:06 -0400
Received: from smtp81.iad3a.emailsrvr.com ([173.203.187.81]:47255 "EHLO
        smtp81.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405480AbgFYO7F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 10:59:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1593097143;
        bh=dC98r+6RvKPubtZR6G9FlTj2y2RWC+QNrBt5bA1q3nw=;
        h=Date:Subject:From:To:From;
        b=qyHUnORErubwdjmf89kyBJ3FA+qMdS7n2pFDw3iUF+SgNsT6fGCjq9GNXVG4Ko6d9
         /t/Aod7OufghGrlbZ9LRV8CJ2JPpoAFUsHXUyNT32i1vN0/OrP1Mti7RPMAEeBboiB
         RiUuPuevv0Ay6ibzHQ3bs8umMguA4N/IULl9G+h0=
Received: from app3.wa-webapps.iad3a (relay-webapps.rsapps.net [172.27.255.140])
        by smtp19.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id BD3395224;
        Thu, 25 Jun 2020 10:59:02 -0400 (EDT)
Received: from deepplum.com (localhost.localdomain [127.0.0.1])
        by app3.wa-webapps.iad3a (Postfix) with ESMTP id A36D5A14DA;
        Thu, 25 Jun 2020 10:59:02 -0400 (EDT)
Received: by apps.rackspace.com
    (Authenticated sender: dpreed@deepplum.com, from: dpreed@deepplum.com) 
    with HTTP; Thu, 25 Jun 2020 10:59:02 -0400 (EDT)
X-Auth-ID: dpreed@deepplum.com
Date:   Thu, 25 Jun 2020 10:59:02 -0400 (EDT)
Subject: Re: [PATCH v2] Fix undefined operation VMXOFF during reboot and crash
From:   "David P. Reed" <dpreed@deepplum.com>
To:     "David P. Reed" <dpreed@deepplum.com>
Cc:     "Sean Christopherson" <sean.j.christopherson@intel.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        "Ingo Molnar" <mingo@redhat.com>, "Borislav Petkov" <bp@alien8.de>,
        "X86 ML" <x86@kernel.org>, "H. Peter Anvin" <hpa@zytor.com>,
        "Allison Randal" <allison@lohutok.net>,
        "Enrico Weigelt" <info@metux.net>,
        "Greg Kroah-Hartman" <gregkh@linuxfoundation.org>,
        "Kate Stewart" <kstewart@linuxfoundation.org>,
        "=?utf-8?Q?Peter_Zijlstra_=28Intel=29?=" <peterz@infradead.org>,
        "Randy Dunlap" <rdunlap@infradead.org>,
        "Martin Molnar" <martin.molnar.programming@gmail.com>,
        "Andy Lutomirski" <luto@kernel.org>,
        "Alexandre Chartre" <alexandre.chartre@oracle.com>,
        "Jann Horn" <jannh@google.com>,
        "Dave Hansen" <dave.hansen@linux.intel.com>,
        "LKML" <linux-kernel@vger.kernel.org>
MIME-Version: 1.0
Content-Type: text/plain;charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Importance: Normal
X-Priority: 3 (Normal)
X-Type: plain
In-Reply-To: <1593096330.105426106@apps.rackspace.com>
References: <1593096330.105426106@apps.rackspace.com>
Message-ID: <1593097142.667728396@apps.rackspace.com>
X-Mailer: webmail/17.3.12-RC
X-Classification-ID: 1557505d-ce70-4f7c-afe7-581d2aced36c-1-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Correction to my comment below.=0AOn Thursday, June 25, 2020 10:45am, "Davi=
d P. Reed" <dpreed@deepplum.com> said:=0A=0A> [Sorry: this is resent becaus=
e my mailer included HTML, rejected by LKML]=0A> Thanks for the response, S=
ean ... I had thought everyone was too busy to follow up=0A> from the first=
 version.=0A> =C2=A0=0A> I confess I'm not sure why this should be broken u=
p into a patch series, given=0A> that it is so very small and is all aimed =
at the same category of bug.=0A> =C2=A0=0A> And the "emergency" path pre-ex=
isted, I didn't want to propose removing it, since=0A> I assumed it was the=
re for a reason. I didn't want to include my own judgement as=0A> to whethe=
r there should only be one path. (I'm pretty sure I didn't find a VMXOFF=0A=
> in KVM separately from the instance in this include file, but I will chec=
k).=0AJust checked. Yes, the kvm code's handling of VMXOFF is separate, and=
 though it uses exception masking, seems to do other things, perhaps relate=
d to nested KVM, but I haven't studied the deep logic of KVM nesting.=0A=0A=
> =C2=A0=0A> A question: if I make it a series, I have to test each patch d=
oesn't break=0A> something individually, in order to handle the case where =
one patch is accepted=0A> and the others are not. Do I need to test each in=
dividual patch thoroughly as an=0A> independent patch against all those cas=
es?=0A> I know the combination don't break anything and fixes the issues I'=
ve discovered=0A> by testing all combinations (and I've done some thorough =
testing of panics, oopses=0A> crashes, kexec, ... under all combinations of=
 CR4.VMXE enablement and crash source=0A> to verify the fix fixes the probl=
em's manifestations and to verify that it doesn't=0A> break any of the work=
ing paths.=0A> =C2=A0=0A> That said, I'm willing to do a v3 "series" based =
on these suggestions if it will=0A> smooth its acceptance. If it's not goin=
g to get accepted after doing that, my=0A> motivation is flagging.=0A> On T=
hursday, June 25, 2020 2:06am, "Sean Christopherson"=0A> <sean.j.christophe=
rson@intel.com> said:=0A> =0A> =0A> =0A>> On Thu, Jun 11, 2020 at 03:48:18P=
M -0400, David P. Reed wrote:=0A>> > -/** Disable VMX on the current CPU=0A=
>> > +/* Disable VMX on the current CPU=0A>> > *=0A>> > - * vmxoff causes a=
 undefined-opcode exception if vmxon was not run=0A>> > - * on the CPU prev=
iously. Only call this function if you know VMX=0A>> > - * is enabled.=0A>>=
 > + * vmxoff causes an undefined-opcode exception if vmxon was not run=0A>=
> > + * on the CPU previously. Only call this function directly if you know=
 VMX=0A>> > + * is enabled *and* CPU is in VMX root operation.=0A>> > */=0A=
>> > static inline void cpu_vmxoff(void)=0A>> > {=0A>> > - asm volatile ("v=
mxoff");=0A>> > + asm volatile ("vmxoff" ::: "cc", "memory"); /* clears all=
 flags on success=0A>> */=0A>> > cr4_clear_bits(X86_CR4_VMXE);=0A>> > }=0A>=
> >=0A>> > @@ -47,17 +47,35 @@ static inline int cpu_vmx_enabled(void)=0A>>=
 > return __read_cr4() & X86_CR4_VMXE;=0A>> > }=0A>> >=0A>> > -/** Disable =
VMX if it is enabled on the current CPU=0A>> > - *=0A>> > - * You shouldn't=
 call this if cpu_has_vmx() returns 0.=0A>> > +/*=0A>> > + * Safely disable=
 VMX root operation if active=0A>> > + * Note that if CPU is not in VMX roo=
t operation this=0A>> > + * VMXOFF will fault an undefined operation fault,=
=0A>> > + * so use the exception masking facility to handle that RARE=0A>> =
> + * case.=0A>> > + * You shouldn't call this directly if cpu_has_vmx() re=
turns 0=0A>> > + */=0A>> > +static inline void cpu_vmxoff_safe(void)=0A>> >=
 +{=0A>> > + asm volatile("1:vmxoff\n\t" /* clears all flags on success */=
=0A>>=0A>> Eh, I wouldn't bother with the comment, there are a million othe=
r caveats=0A>> with VMXOFF that are far more interesting.=0A>>=0A>> > + "2:=
\n\t"=0A>> > + _ASM_EXTABLE(1b, 2b)=0A>> > + ::: "cc", "memory");=0A>>=0A>>=
 Adding the memory and flags clobber should be a separate patch.=0A>>=0A>> =
> + cr4_clear_bits(X86_CR4_VMXE);=0A>> > +}=0A>>=0A>>=0A>> I don't see any =
value in safe/unsafe variants. The only in-kernel user of=0A>> VMXOFF outsi=
de of the emergency flows is KVM, which has its own VMXOFF=0A>> helper, i.e=
. all users of cpu_vmxoff() want the "safe" variant. Just add=0A>> the exce=
ption fixup to cpu_vmxoff() and call it good.=0A>>=0A>> > +=0A>> > +/*=0A>>=
 > + * Force disable VMX if it is enabled on the current CPU,=0A>> > + * wh=
en it is unknown whether CPU is in VMX operation.=0A>> > */=0A>> > static i=
nline void __cpu_emergency_vmxoff(void)=0A>> > {=0A>> > - if (cpu_vmx_enabl=
ed())=0A>> > - cpu_vmxoff();=0A>> > + if (!cpu_vmx_enabled())=0A>> > + retu=
rn;=0A>> > + cpu_vmxoff_safe();=0A>>=0A>> Unnecessary churn.=0A>>=0A>> > }=
=0A>> >=0A>> > -/** Disable VMX if it is supported and enabled on the curre=
nt CPU=0A>> > +/* Force disable VMX if it is supported on current CPU=0A>> =
> */=0A>> > static inline void cpu_emergency_vmxoff(void)=0A>> > {=0A>> > d=
iff --git a/arch/x86/kernel/reboot.c b/arch/x86/kernel/reboot.c=0A>> > inde=
x e040ba6be27b..b0e6b106a67e 100644=0A>> > --- a/arch/x86/kernel/reboot.c=
=0A>> > +++ b/arch/x86/kernel/reboot.c=0A>> > @@ -540,21 +540,14 @@ static =
void emergency_vmx_disable_all(void)=0A>> > *=0A>> > * For safety, we will =
avoid running the nmi_shootdown_cpus()=0A>> > * stuff unnecessarily, but we=
 don't have a way to check=0A>> > - * if other CPUs have VMX enabled. So we=
 will call it only if the=0A>> > - * CPU we are running on has VMX enabled.=
=0A>> > - *=0A>> > - * We will miss cases where VMX is not enabled on all C=
PUs. This=0A>> > - * shouldn't do much harm because KVM always enable VMX o=
n all=0A>> > - * CPUs anyway. But we can miss it on the small window where =
KVM=0A>> > - * is still enabling VMX.=0A>> > + * if other CPUs have VMX ena=
bled.=0A>> > */=0A>> > - if (cpu_has_vmx() && cpu_vmx_enabled()) {=0A>> > +=
 if (cpu_has_vmx()) {=0A>> > /* Disable VMX on this CPU. */=0A>> > - cpu_vm=
xoff();=0A>> > + cpu_emergency_vmxoff();=0A>>=0A>> This also needs to be in=
 a separate patch. And it should use=0A>> __cpu_emergency_vmxoff() instead =
of cpu_emergency_vmxoff().=0A>>=0A>> >=0A>> > /* Halt and disable VMX on th=
e other CPUs */=0A>> > nmi_shootdown_cpus(vmxoff_nmi);=0A>> > -=0A>> > }=0A=
>> > }=0A>> >=0A>> > --=0A>> > 2.26.2=0A>> >=0A>>=0A> =0A> =0A

