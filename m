Return-Path: <SRS0=6VGy=AK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BDBC1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:54:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9683B206E2
	for <linux-kernel@archiver.kernel.org>; Mon, 29 Jun 2020 20:54:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="f8aVqo8+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388320AbgF2Uyt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 29 Jun 2020 16:54:49 -0400
Received: from smtp64.iad3a.emailsrvr.com ([173.203.187.64]:44952 "EHLO
        smtp64.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729267AbgF2Uyf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Jun 2020 16:54:35 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1593464072;
        bh=IWbL7IshviDQ4CHU7/hdyMbI4ChFfc9hpwBziN96dBY=;
        h=Date:Subject:From:To:From;
        b=f8aVqo8+UWLSEEyIibFaqA4KTMNSr8VI6khAcZueuwy3q+dVs62j1shhmIcuRQSfw
         F54AOJpU1d/mxqsd4U+SjUcLdGGzk1+gq5OS52WZ33EN/K+qkt7Ga+sFTbqOkFsm/s
         +/aNRG2uaVrqMniII2ON+gwB5n4QAH3szr86ChJ8=
Received: from app61.wa-webapps.iad3a (relay-webapps.rsapps.net [172.27.255.140])
        by smtp9.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 6F2D8576F;
        Mon, 29 Jun 2020 16:54:32 -0400 (EDT)
Received: from deepplum.com (localhost.localdomain [127.0.0.1])
        by app61.wa-webapps.iad3a (Postfix) with ESMTP id 560366067A;
        Mon, 29 Jun 2020 16:54:32 -0400 (EDT)
Received: by apps.rackspace.com
    (Authenticated sender: dpreed@deepplum.com, from: dpreed@deepplum.com) 
    with HTTP; Mon, 29 Jun 2020 16:54:32 -0400 (EDT)
X-Auth-ID: dpreed@deepplum.com
Date:   Mon, 29 Jun 2020 16:54:32 -0400 (EDT)
Subject: Re: [PATCH v2] Fix undefined operation VMXOFF during reboot and crash
From:   "David P. Reed" <dpreed@deepplum.com>
To:     "Thomas Gleixner" <tglx@linutronix.de>
Cc:     "Sean Christopherson" <sean.j.christopherson@intel.com>,
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
In-Reply-To: <1593097142.667728396@apps.rackspace.com>
References: <1593096330.105426106@apps.rackspace.com> 
 <1593097142.667728396@apps.rackspace.com>
Message-ID: <1593464072.34968499@apps.rackspace.com>
X-Mailer: webmail/17.3.12-RC
X-Classification-ID: 3885061c-5784-4d28-bfbe-483520d7192c-1-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Simple question for those on the To: and CC: list here. Should I abandon an=
y hope of this patch being accepted? It's been a long time.=0A=0AThe non-re=
sponse after I acknowledged that this was discovered by when working on a p=
ersonal, non-commercial research project - which is "out-of-tree" (apparent=
ly dirty words on LKML) has me thinking my contribution is unwanted. That's=
 fine, I suppose. I can maintain this patch out-of-tree as well.=0AI did in=
corporate all the helpful suggestions I received in this second patch, and =
given some encouragement, will happily submit a revised v3 if there is any =
likelihood of acceptance. I'm wary of doing more radical changes (like comb=
ining emergency and normal paths).=0A=0A=0AOn Thursday, June 25, 2020 10:59=
am, "David P. Reed" <dpreed@deepplum.com> said:=0A=0A> Correction to my com=
ment below.=0A> On Thursday, June 25, 2020 10:45am, "David P. Reed" <dpreed=
@deepplum.com> said:=0A> =0A>> [Sorry: this is resent because my mailer inc=
luded HTML, rejected by LKML]=0A>> Thanks for the response, Sean ... I had =
thought everyone was too busy to follow=0A>> up=0A>> from the first version=
.=0A>> =C2=A0=0A>> I confess I'm not sure why this should be broken up into=
 a patch series, given=0A>> that it is so very small and is all aimed at th=
e same category of bug.=0A>> =C2=A0=0A>> And the "emergency" path pre-exist=
ed, I didn't want to propose removing it, since=0A>> I assumed it was there=
 for a reason. I didn't want to include my own judgement as=0A>> to whether=
 there should only be one path. (I'm pretty sure I didn't find a VMXOFF=0A>=
> in KVM separately from the instance in this include file, but I will chec=
k).=0A> Just checked. Yes, the kvm code's handling of VMXOFF is separate, a=
nd though it=0A> uses exception masking, seems to do other things, perhaps =
related to nested KVM,=0A> but I haven't studied the deep logic of KVM nest=
ing.=0A> =0A>> =C2=A0=0A>> A question: if I make it a series, I have to tes=
t each patch doesn't break=0A>> something individually, in order to handle =
the case where one patch is accepted=0A>> and the others are not. Do I need=
 to test each individual patch thoroughly as an=0A>> independent patch agai=
nst all those cases?=0A>> I know the combination don't break anything and f=
ixes the issues I've discovered=0A>> by testing all combinations (and I've =
done some thorough testing of panics,=0A>> oopses=0A>> crashes, kexec, ... =
under all combinations of CR4.VMXE enablement and crash=0A>> source=0A>> to=
 verify the fix fixes the problem's manifestations and to verify that it=0A=
>> doesn't=0A>> break any of the working paths.=0A>> =C2=A0=0A>> That said,=
 I'm willing to do a v3 "series" based on these suggestions if it will=0A>>=
 smooth its acceptance. If it's not going to get accepted after doing that,=
 my=0A>> motivation is flagging.=0A>> On Thursday, June 25, 2020 2:06am, "S=
ean Christopherson"=0A>> <sean.j.christopherson@intel.com> said:=0A>>=0A>>=
=0A>>=0A>>> On Thu, Jun 11, 2020 at 03:48:18PM -0400, David P. Reed wrote:=
=0A>>> > -/** Disable VMX on the current CPU=0A>>> > +/* Disable VMX on the=
 current CPU=0A>>> > *=0A>>> > - * vmxoff causes a undefined-opcode excepti=
on if vmxon was not run=0A>>> > - * on the CPU previously. Only call this f=
unction if you know VMX=0A>>> > - * is enabled.=0A>>> > + * vmxoff causes a=
n undefined-opcode exception if vmxon was not run=0A>>> > + * on the CPU pr=
eviously. Only call this function directly if you know VMX=0A>>> > + * is e=
nabled *and* CPU is in VMX root operation.=0A>>> > */=0A>>> > static inline=
 void cpu_vmxoff(void)=0A>>> > {=0A>>> > - asm volatile ("vmxoff");=0A>>> >=
 + asm volatile ("vmxoff" ::: "cc", "memory"); /* clears all flags on succe=
ss=0A>>> */=0A>>> > cr4_clear_bits(X86_CR4_VMXE);=0A>>> > }=0A>>> >=0A>>> >=
 @@ -47,17 +47,35 @@ static inline int cpu_vmx_enabled(void)=0A>>> > return=
 __read_cr4() & X86_CR4_VMXE;=0A>>> > }=0A>>> >=0A>>> > -/** Disable VMX if=
 it is enabled on the current CPU=0A>>> > - *=0A>>> > - * You shouldn't cal=
l this if cpu_has_vmx() returns 0.=0A>>> > +/*=0A>>> > + * Safely disable V=
MX root operation if active=0A>>> > + * Note that if CPU is not in VMX root=
 operation this=0A>>> > + * VMXOFF will fault an undefined operation fault,=
=0A>>> > + * so use the exception masking facility to handle that RARE=0A>>=
> > + * case.=0A>>> > + * You shouldn't call this directly if cpu_has_vmx()=
 returns 0=0A>>> > + */=0A>>> > +static inline void cpu_vmxoff_safe(void)=
=0A>>> > +{=0A>>> > + asm volatile("1:vmxoff\n\t" /* clears all flags on su=
ccess */=0A>>>=0A>>> Eh, I wouldn't bother with the comment, there are a mi=
llion other caveats=0A>>> with VMXOFF that are far more interesting.=0A>>>=
=0A>>> > + "2:\n\t"=0A>>> > + _ASM_EXTABLE(1b, 2b)=0A>>> > + ::: "cc", "mem=
ory");=0A>>>=0A>>> Adding the memory and flags clobber should be a separate=
 patch.=0A>>>=0A>>> > + cr4_clear_bits(X86_CR4_VMXE);=0A>>> > +}=0A>>>=0A>>=
>=0A>>> I don't see any value in safe/unsafe variants. The only in-kernel u=
ser of=0A>>> VMXOFF outside of the emergency flows is KVM, which has its ow=
n VMXOFF=0A>>> helper, i.e. all users of cpu_vmxoff() want the "safe" varia=
nt. Just add=0A>>> the exception fixup to cpu_vmxoff() and call it good.=0A=
>>>=0A>>> > +=0A>>> > +/*=0A>>> > + * Force disable VMX if it is enabled on=
 the current CPU,=0A>>> > + * when it is unknown whether CPU is in VMX oper=
ation.=0A>>> > */=0A>>> > static inline void __cpu_emergency_vmxoff(void)=
=0A>>> > {=0A>>> > - if (cpu_vmx_enabled())=0A>>> > - cpu_vmxoff();=0A>>> >=
 + if (!cpu_vmx_enabled())=0A>>> > + return;=0A>>> > + cpu_vmxoff_safe();=
=0A>>>=0A>>> Unnecessary churn.=0A>>>=0A>>> > }=0A>>> >=0A>>> > -/** Disabl=
e VMX if it is supported and enabled on the current CPU=0A>>> > +/* Force d=
isable VMX if it is supported on current CPU=0A>>> > */=0A>>> > static inli=
ne void cpu_emergency_vmxoff(void)=0A>>> > {=0A>>> > diff --git a/arch/x86/=
kernel/reboot.c b/arch/x86/kernel/reboot.c=0A>>> > index e040ba6be27b..b0e6=
b106a67e 100644=0A>>> > --- a/arch/x86/kernel/reboot.c=0A>>> > +++ b/arch/x=
86/kernel/reboot.c=0A>>> > @@ -540,21 +540,14 @@ static void emergency_vmx_=
disable_all(void)=0A>>> > *=0A>>> > * For safety, we will avoid running the=
 nmi_shootdown_cpus()=0A>>> > * stuff unnecessarily, but we don't have a wa=
y to check=0A>>> > - * if other CPUs have VMX enabled. So we will call it o=
nly if the=0A>>> > - * CPU we are running on has VMX enabled.=0A>>> > - *=
=0A>>> > - * We will miss cases where VMX is not enabled on all CPUs. This=
=0A>>> > - * shouldn't do much harm because KVM always enable VMX on all=0A=
>>> > - * CPUs anyway. But we can miss it on the small window where KVM=0A>=
>> > - * is still enabling VMX.=0A>>> > + * if other CPUs have VMX enabled.=
=0A>>> > */=0A>>> > - if (cpu_has_vmx() && cpu_vmx_enabled()) {=0A>>> > + i=
f (cpu_has_vmx()) {=0A>>> > /* Disable VMX on this CPU. */=0A>>> > - cpu_vm=
xoff();=0A>>> > + cpu_emergency_vmxoff();=0A>>>=0A>>> This also needs to be=
 in a separate patch. And it should use=0A>>> __cpu_emergency_vmxoff() inst=
ead of cpu_emergency_vmxoff().=0A>>>=0A>>> >=0A>>> > /* Halt and disable VM=
X on the other CPUs */=0A>>> > nmi_shootdown_cpus(vmxoff_nmi);=0A>>> > -=0A=
>>> > }=0A>>> > }=0A>>> >=0A>>> > --=0A>>> > 2.26.2=0A>>> >=0A>>>=0A>>=0A>>=
=0A> =0A> =0A> =0A

