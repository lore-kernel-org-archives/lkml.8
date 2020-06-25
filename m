Return-Path: <SRS0=lrRa=AG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71CC2C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:45:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E3C6206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 25 Jun 2020 14:45:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="ycezOlQN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405498AbgFYOpj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 25 Jun 2020 10:45:39 -0400
Received: from smtp75.iad3a.emailsrvr.com ([173.203.187.75]:49539 "EHLO
        smtp75.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2405444AbgFYOpc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 25 Jun 2020 10:45:32 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1593096330;
        bh=j3ODRoMKy1KlfOTUcwEgR0+btbQugqbU0ApOQFED+WM=;
        h=Date:Subject:From:To:From;
        b=ycezOlQNiDFjJ3HAg4xvtwtNcC5Zi5zZj6wUWtAg8EEx8EgW8sd8hQ42JLS2WCbGZ
         CQPwMVJyvFhstkwQ8uIWFd0b4NIfExTqIFe67Z1j6Ik+7Vnm9xeboe9/0vZ427zhpO
         zE6sMGaIp4kXwI6set7/1TOsiF7+wNhSOlaQmFxs=
Received: from app49.wa-webapps.iad3a (relay-webapps.rsapps.net [172.27.255.140])
        by smtp26.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 326435579;
        Thu, 25 Jun 2020 10:45:30 -0400 (EDT)
Received: from deepplum.com (localhost.localdomain [127.0.0.1])
        by app49.wa-webapps.iad3a (Postfix) with ESMTP id 1A782E003F;
        Thu, 25 Jun 2020 10:45:30 -0400 (EDT)
Received: by apps.rackspace.com
    (Authenticated sender: dpreed@deepplum.com, from: dpreed@deepplum.com) 
    with HTTP; Thu, 25 Jun 2020 10:45:30 -0400 (EDT)
X-Auth-ID: dpreed@deepplum.com
Date:   Thu, 25 Jun 2020 10:45:30 -0400 (EDT)
Subject: Re: [PATCH v2] Fix undefined operation VMXOFF during reboot and crash
From:   "David P. Reed" <dpreed@deepplum.com>
To:     "Sean Christopherson" <sean.j.christopherson@intel.com>
Cc:     "Thomas Gleixner" <tglx@linutronix.de>,
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
Message-ID: <1593096330.105426106@apps.rackspace.com>
X-Mailer: webmail/17.3.12-RC
X-Classification-ID: 47c80f5e-4484-4e30-ad65-1b5c68dc618e-1-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

[Sorry: this is resent because my mailer included HTML, rejected by LKML]=
=0AThanks for the response, Sean ... I had thought everyone was too busy to=
 follow up from the first version.=0A=C2=A0=0AI confess I'm not sure why th=
is should be broken up into a patch series, given that it is so very small =
and is all aimed at the same category of bug.=0A=C2=A0=0AAnd the "emergency=
" path pre-existed, I didn't want to propose removing it, since I assumed i=
t was there for a reason. I didn't want to include my own judgement as to w=
hether there should only be one path. (I'm pretty sure I didn't find a VMXO=
FF in KVM separately from the instance in this include file, but I will che=
ck).=0A=C2=A0=0AA question: if I make it a series, I have to test each patc=
h doesn't break something individually, in order to handle the case where o=
ne patch is accepted and the others are not. Do I need to test each individ=
ual patch thoroughly as an independent patch against all those cases?=0AI k=
now the combination don't break anything and fixes the issues I've discover=
ed by testing all combinations (and I've done some thorough testing of pani=
cs, oopses crashes, kexec, ... under all combinations of CR4.VMXE enablemen=
t and crash source to verify the fix fixes the problem's manifestations and=
 to verify that it doesn't break any of the working paths.=0A=C2=A0=0AThat =
said, I'm willing to do a v3 "series" based on these suggestions if it will=
 smooth its acceptance. If it's not going to get accepted after doing that,=
 my motivation is flagging.=0AOn Thursday, June 25, 2020 2:06am, "Sean Chri=
stopherson" <sean.j.christopherson@intel.com> said:=0A=0A=0A=0A> On Thu, Ju=
n 11, 2020 at 03:48:18PM -0400, David P. Reed wrote:=0A> > -/** Disable VMX=
 on the current CPU=0A> > +/* Disable VMX on the current CPU=0A> > *=0A> > =
- * vmxoff causes a undefined-opcode exception if vmxon was not run=0A> > -=
 * on the CPU previously. Only call this function if you know VMX=0A> > - *=
 is enabled.=0A> > + * vmxoff causes an undefined-opcode exception if vmxon=
 was not run=0A> > + * on the CPU previously. Only call this function direc=
tly if you know VMX=0A> > + * is enabled *and* CPU is in VMX root operation=
.=0A> > */=0A> > static inline void cpu_vmxoff(void)=0A> > {=0A> > - asm vo=
latile ("vmxoff");=0A> > + asm volatile ("vmxoff" ::: "cc", "memory"); /* c=
lears all flags on success=0A> */=0A> > cr4_clear_bits(X86_CR4_VMXE);=0A> >=
 }=0A> >=0A> > @@ -47,17 +47,35 @@ static inline int cpu_vmx_enabled(void)=
=0A> > return __read_cr4() & X86_CR4_VMXE;=0A> > }=0A> >=0A> > -/** Disable=
 VMX if it is enabled on the current CPU=0A> > - *=0A> > - * You shouldn't =
call this if cpu_has_vmx() returns 0.=0A> > +/*=0A> > + * Safely disable VM=
X root operation if active=0A> > + * Note that if CPU is not in VMX root op=
eration this=0A> > + * VMXOFF will fault an undefined operation fault,=0A> =
> + * so use the exception masking facility to handle that RARE=0A> > + * c=
ase.=0A> > + * You shouldn't call this directly if cpu_has_vmx() returns 0=
=0A> > + */=0A> > +static inline void cpu_vmxoff_safe(void)=0A> > +{=0A> > =
+ asm volatile("1:vmxoff\n\t" /* clears all flags on success */=0A> =0A> Eh=
, I wouldn't bother with the comment, there are a million other caveats=0A>=
 with VMXOFF that are far more interesting.=0A> =0A> > + "2:\n\t"=0A> > + _=
ASM_EXTABLE(1b, 2b)=0A> > + ::: "cc", "memory");=0A> =0A> Adding the memory=
 and flags clobber should be a separate patch.=0A> =0A> > + cr4_clear_bits(=
X86_CR4_VMXE);=0A> > +}=0A> =0A> =0A> I don't see any value in safe/unsafe =
variants. The only in-kernel user of=0A> VMXOFF outside of the emergency fl=
ows is KVM, which has its own VMXOFF=0A> helper, i.e. all users of cpu_vmxo=
ff() want the "safe" variant. Just add=0A> the exception fixup to cpu_vmxof=
f() and call it good.=0A> =0A> > +=0A> > +/*=0A> > + * Force disable VMX if=
 it is enabled on the current CPU,=0A> > + * when it is unknown whether CPU=
 is in VMX operation.=0A> > */=0A> > static inline void __cpu_emergency_vmx=
off(void)=0A> > {=0A> > - if (cpu_vmx_enabled())=0A> > - cpu_vmxoff();=0A> =
> + if (!cpu_vmx_enabled())=0A> > + return;=0A> > + cpu_vmxoff_safe();=0A> =
=0A> Unnecessary churn.=0A> =0A> > }=0A> >=0A> > -/** Disable VMX if it is =
supported and enabled on the current CPU=0A> > +/* Force disable VMX if it =
is supported on current CPU=0A> > */=0A> > static inline void cpu_emergency=
_vmxoff(void)=0A> > {=0A> > diff --git a/arch/x86/kernel/reboot.c b/arch/x8=
6/kernel/reboot.c=0A> > index e040ba6be27b..b0e6b106a67e 100644=0A> > --- a=
/arch/x86/kernel/reboot.c=0A> > +++ b/arch/x86/kernel/reboot.c=0A> > @@ -54=
0,21 +540,14 @@ static void emergency_vmx_disable_all(void)=0A> > *=0A> > *=
 For safety, we will avoid running the nmi_shootdown_cpus()=0A> > * stuff u=
nnecessarily, but we don't have a way to check=0A> > - * if other CPUs have=
 VMX enabled. So we will call it only if the=0A> > - * CPU we are running o=
n has VMX enabled.=0A> > - *=0A> > - * We will miss cases where VMX is not =
enabled on all CPUs. This=0A> > - * shouldn't do much harm because KVM alwa=
ys enable VMX on all=0A> > - * CPUs anyway. But we can miss it on the small=
 window where KVM=0A> > - * is still enabling VMX.=0A> > + * if other CPUs =
have VMX enabled.=0A> > */=0A> > - if (cpu_has_vmx() && cpu_vmx_enabled()) =
{=0A> > + if (cpu_has_vmx()) {=0A> > /* Disable VMX on this CPU. */=0A> > -=
 cpu_vmxoff();=0A> > + cpu_emergency_vmxoff();=0A> =0A> This also needs to =
be in a separate patch. And it should use=0A> __cpu_emergency_vmxoff() inst=
ead of cpu_emergency_vmxoff().=0A> =0A> >=0A> > /* Halt and disable VMX on =
the other CPUs */=0A> > nmi_shootdown_cpus(vmxoff_nmi);=0A> > -=0A> > }=0A>=
 > }=0A> >=0A> > --=0A> > 2.26.2=0A> >=0A>

