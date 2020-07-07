Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B90B5C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:09:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98E3620720
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 19:09:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="Y7SZJgIc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728470AbgGGTJl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 15:09:41 -0400
Received: from smtp105.iad3a.emailsrvr.com ([173.203.187.105]:48057 "EHLO
        smtp105.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728133AbgGGTJl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 15:09:41 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1594148979;
        bh=7VMPN0e40VJ6Lmx5P81+MklnCgKOCTiqg1QQ89V2qs4=;
        h=Date:Subject:From:To:From;
        b=Y7SZJgIcMUte+UMpdYu0sGAz1zcTN+r9VhnBOwzv+ipJJ2gODuCvLUyZ+bL/XQZN/
         sGsx+StVHnw4eNS3KObpZgQKD94B+Q0llQEsvqzItDJ2WISoyZmzexMobmguxx3vI5
         vhGisGe/CGij5D4HCdJBL9bUmNyVutiqH7IvWpiA=
Received: from app12.wa-webapps.iad3a (relay-webapps.rsapps.net [172.27.255.140])
        by smtp22.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 0CA656861;
        Tue,  7 Jul 2020 15:09:39 -0400 (EDT)
Received: from deepplum.com (localhost.localdomain [127.0.0.1])
        by app12.wa-webapps.iad3a (Postfix) with ESMTP id EC4BAE0059;
        Tue,  7 Jul 2020 15:09:38 -0400 (EDT)
Received: by apps.rackspace.com
    (Authenticated sender: dpreed@deepplum.com, from: dpreed@deepplum.com) 
    with HTTP; Tue, 7 Jul 2020 15:09:38 -0400 (EDT)
X-Auth-ID: dpreed@deepplum.com
Date:   Tue, 7 Jul 2020 15:09:38 -0400 (EDT)
Subject: Re: [PATCH v3 2/3] Fix undefined operation fault that can hang a cpu on crash or panic
From:   "David P. Reed" <dpreed@deepplum.com>
To:     "Sean Christopherson" <sean.j.christopherson@intel.com>
Cc:     "Andy Lutomirski" <luto@amacapital.net>,
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
In-Reply-To: <20200707050932.GF5208@linux.intel.com>
References: <20200629214956.GA12962@linux.intel.com> 
 <20200704203809.76391-1-dpreed@deepplum.com> 
 <20200704203809.76391-3-dpreed@deepplum.com> 
 <20200707050932.GF5208@linux.intel.com>
Message-ID: <1594148978.965916054@apps.rackspace.com>
X-Mailer: webmail/17.3.12-RC
X-Classification-ID: f6c9456f-9b74-450c-b447-a139153e44de-1-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=0AOn Tuesday, July 7, 2020 1:09am, "Sean Christopherson" <sean.j.christ=
opherson@intel.com> said:=0A=0A> On Sat, Jul 04, 2020 at 04:38:08PM -0400, =
David P. Reed wrote:=0A>> Fix: Mask undefined operation fault during emerge=
ncy VMXOFF that must be=0A>> attempted to force cpu exit from VMX root oper=
ation.=0A>> Explanation: When a cpu may be in VMX root operation (only poss=
ible when=0A>> CR4.VMXE is set), crash or panic reboot tries to exit VMX ro=
ot operation=0A>> using VMXOFF. This is necessary, because any INIT will be=
 masked while cpu=0A>> is in VMX root operation, but that state cannot be r=
eliably=0A>> discerned by the state of the cpu.=0A>> VMXOFF faults if the c=
pu is not actually in VMX root operation, signalling=0A>> undefined operati=
on.=0A>> Discovered while debugging an out-of-tree x-visor with a race. Can=
 happen=0A>> due to certain kinds of bugs in KVM.=0A>>=0A>> Fixes: 208067 <=
https://bugzilla.kernel.org/show_bug.cgi?id=3D208067>=0A>> Reported-by: Dav=
id P. Reed <dpreed@deepplum.com>=0A>> Suggested-by: Thomas Gleixner <tglx@l=
inutronix.de>=0A>> Suggested-by: Sean Christopherson <sean.j.christopherson=
@intel.com>=0A>> Suggested-by: Andy Lutomirski <luto@kernel.org>=0A>> Signe=
d-off-by: David P. Reed <dpreed@deepplum.com>=0A>> ---=0A>>  arch/x86/inclu=
de/asm/virtext.h | 20 ++++++++++++++------=0A>>  1 file changed, 14 inserti=
ons(+), 6 deletions(-)=0A>>=0A>> diff --git a/arch/x86/include/asm/virtext.=
h b/arch/x86/include/asm/virtext.h=0A>> index 0ede8d04535a..0e0900eacb9c 10=
0644=0A>> --- a/arch/x86/include/asm/virtext.h=0A>> +++ b/arch/x86/include/=
asm/virtext.h=0A>> @@ -30,11 +30,11 @@ static inline int cpu_has_vmx(void)=
=0A>>  }=0A>>=0A>>=0A>> -/* Disable VMX on the current CPU=0A>> +/* Exit VM=
X root mode and isable VMX on the current CPU.=0A>>   *=0A>>   * vmxoff cau=
ses a undefined-opcode exception if vmxon was not run=0A>> - * on the CPU p=
reviously. Only call this function if you know VMX=0A>> - * is enabled.=0A>=
> + * on the CPU previously. Only call this function if you know cpu=0A>> +=
 * is in VMX root mode.=0A>>   */=0A>>  static inline void cpu_vmxoff(void)=
=0A>>  {=0A>> @@ -47,14 +47,22 @@ static inline int cpu_vmx_enabled(void)=
=0A>>  =09return __read_cr4() & X86_CR4_VMXE;=0A>>  }=0A>>=0A>> -/* Disable=
 VMX if it is enabled on the current CPU=0A>> +/* Safely exit VMX root mode=
 and disable VMX if VMX enabled=0A>> + * on the current CPU. Handle undefin=
ed-opcode fault=0A>> + * that can occur if cpu is not in VMX root mode, due=
=0A>> + * to a race.=0A>>   *=0A>>   * You shouldn't call this if cpu_has_v=
mx() returns 0.=0A>>   */=0A>>  static inline void __cpu_emergency_vmxoff(v=
oid)=0A>>  {=0A>> -=09if (cpu_vmx_enabled())=0A>> -=09=09cpu_vmxoff();=0A>>=
 +=09if (!cpu_vmx_enabled())=0A>> +=09=09return;=0A>> +=09asm volatile ("1:=
vmxoff\n\t"=0A>> +=09=09      "2:\n\t"=0A>> +=09=09      _ASM_EXTABLE(1b, 2=
b)=0A>> +=09=09      ::: "cc", "memory");=0A>> +=09cr4_clear_bits(X86_CR4_V=
MXE);=0A> =0A> Open coding vmxoff doesn't make sense, and IMO is flat out w=
rong as it fixes=0A> flows that use __cpu_emergency_vmxoff() but leaves the=
 same bug hanging=0A> around in emergency_vmx_disable_all() until the next =
patch.=0A> =0A> The reason I say it doesn't make sense is that there is no =
sane scenario=0A> where the generic vmxoff helper should _not_ eat the faul=
t.  All other VMXOFF=0A> faults are mode related, i.e. any fault is guarant=
eed to be due to the=0A> !post-VMXON check unless we're magically in RM, VM=
86, compat mode, or at=0A> CPL>0.  Given that the whole point of this serie=
s is that it's impossible to=0A> determine whether or not the CPU if post-V=
MXON if CR4.VMXE=3D1 without taking a=0A> fault of some form, there's simpl=
y no way that anything except the hypervisor=0A> (in normal operation) can =
know the state of VMX.  And given that the only=0A> in-tree hypervisor (KVM=
) has its own version of vmxoff, that means there is=0A> no scenario in whi=
ch cpu_vmxoff() can safely be used.  Case in point, after=0A> the next patc=
h there are no users of cpu_vmxoff().=0A> =0A> TL;DR: Just do fixup on cpu_=
vmxoff().=0A=0APersonally, I don't care either way, since it fixes the bug =
either way (and it's inlined, so either way no additional code is generated=
. I was just being conservative since the cpu_vmxoff() is exported througho=
ut the kernel source, so it might be expected to stay the same (when not in=
 an "emergency"). I'll wait a day or two for any objections to just doing t=
he fix in cpu_vmxoff() by other commenters. WIth no objection, I'll just do=
 it that way.=0A=0ASean, are you the one who would get this particular fix =
pushed into Linus's tree, by the way? The "maintainership" is not clear to =
me. If you are, happy to take direction from you as the primary input.=0A=
=0A> =0A>>  }=0A>>=0A>>  /* Disable VMX if it is supported and enabled on t=
he current CPU=0A>> --=0A>> 2.26.2=0A>>=0A> =0A

