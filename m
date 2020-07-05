Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 217DBC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 22:07:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E66AB20C56
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 22:07:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="ERb5Dfy1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728521AbgGEWHF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 18:07:05 -0400
Received: from smtp80.iad3a.emailsrvr.com ([173.203.187.80]:41807 "EHLO
        smtp80.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728493AbgGEWHF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 18:07:05 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1593986823;
        bh=fZYcaNcJdBru10o0yqpllHMigHBuTh9ZE+3jepjz8Es=;
        h=Date:Subject:From:To:From;
        b=ERb5Dfy1wyuwsTFLlc07ZqdIirMX785HmtU1xd0I/w3gsVpvO6cGAt/0rIyQ6v2+q
         SpDKFwnSmyaacWZw4lLmM6USUN6E7CFJOiTaI4g8mYRE3qU6Qivg5chllZyn5O75Tc
         FQHCuYz/lFJ1eTSOuBz5v/ZJheS3d8Vp+wdqnYYQ=
Received: from app58.wa-webapps.iad3a (relay-webapps.rsapps.net [172.27.255.140])
        by smtp11.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id A2B4C2917;
        Sun,  5 Jul 2020 18:07:03 -0400 (EDT)
Received: from deepplum.com (localhost.localdomain [127.0.0.1])
        by app58.wa-webapps.iad3a (Postfix) with ESMTP id 90CE020073;
        Sun,  5 Jul 2020 18:07:03 -0400 (EDT)
Received: by apps.rackspace.com
    (Authenticated sender: dpreed@deepplum.com, from: dpreed@deepplum.com) 
    with HTTP; Sun, 5 Jul 2020 18:07:03 -0400 (EDT)
X-Auth-ID: dpreed@deepplum.com
Date:   Sun, 5 Jul 2020 18:07:03 -0400 (EDT)
Subject: Re: [PATCH v3 2/3] Fix undefined operation fault that can hang a cpu on crash or panic
From:   "David P. Reed" <dpreed@deepplum.com>
To:     "Andy Lutomirski" <luto@kernel.org>
Cc:     "Andy Lutomirski" <luto@kernel.org>,
        "Sean Christopherson" <sean.j.christopherson@intel.com>,
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
In-Reply-To: <CALCETrVCEP6bLrwTYg7h_Rx-XHEsOXT4QZ=BnwpReM-n8eco6g@mail.gmail.com>
References: <20200629214956.GA12962@linux.intel.com> 
 <20200704203809.76391-1-dpreed@deepplum.com> 
 <20200704203809.76391-3-dpreed@deepplum.com> 
 <CALCETrVZx4VA9rg-Hn7KdER866ZOtZtmTkR0MSacnj5jGO-Pag@mail.gmail.com> 
 <1593978728.059424180@apps.rackspace.com> 
 <CALCETrVCEP6bLrwTYg7h_Rx-XHEsOXT4QZ=BnwpReM-n8eco6g@mail.gmail.com>
Message-ID: <1593986823.58943274@apps.rackspace.com>
X-Mailer: webmail/17.3.12-RC
X-Classification-ID: 05f02492-5b8f-466c-b974-a73dfef03a59-1-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

=0A=0AOn Sunday, July 5, 2020 4:55pm, "Andy Lutomirski" <luto@kernel.org> s=
aid:=0A=0A> On Sun, Jul 5, 2020 at 12:52 PM David P. Reed <dpreed@deepplum.=
com> wrote:=0A>>=0A>> Thanks, will handle these. 2 questions below.=0A>>=0A=
>> On Sunday, July 5, 2020 2:22pm, "Andy Lutomirski" <luto@kernel.org> said=
:=0A>>=0A>> > On Sat, Jul 4, 2020 at 1:38 PM David P. Reed <dpreed@deepplum=
.com> wrote:=0A>> >>=0A>> >> Fix: Mask undefined operation fault during eme=
rgency VMXOFF that must be=0A>> >> attempted to force cpu exit from VMX roo=
t operation.=0A>> >> Explanation: When a cpu may be in VMX root operation (=
only possible when=0A>> >> CR4.VMXE is set), crash or panic reboot tries to=
 exit VMX root operation=0A>> >> using VMXOFF. This is necessary, because a=
ny INIT will be masked while cpu=0A>> >> is in VMX root operation, but that=
 state cannot be reliably=0A>> >> discerned by the state of the cpu.=0A>> >=
> VMXOFF faults if the cpu is not actually in VMX root operation, signallin=
g=0A>> >> undefined operation.=0A>> >> Discovered while debugging an out-of=
-tree x-visor with a race. Can happen=0A>> >> due to certain kinds of bugs =
in KVM.=0A>> >=0A>> > Can you re-wrap lines to 68 characters?  Also, the Fi=
x: and=0A>>=0A>> I used 'scripts/checkpatch.pl' and it had me wrap to 75 ch=
ars:=0A>> "WARNING: Possible unwrapped commit description (prefer a maximum=
 75 chars per=0A>> line)"=0A>>=0A>> Should I submit a fix to checkpatch.pl =
to say 68?=0A> =0A> 75 is probably fine too, but something is odd about you=
r wrapping.=0A> You have long lines mostly alternating with short lines.  I=
t's as if=0A> you wrote 120-ish character lines and then wrapped to 75 with=
out=0A> reflowing.=0AMy emacs settings tend to wrap at about 85 depending o=
n file type (big screens). I did the shortening manually, aimed at breaking=
 at meaningful points, not worrying too much about=0Aline-length uniformity=
.=0A=0A> =0A>>=0A>> > Explanation: is probably unnecessary.  You could say:=
=0A>> >=0A>> > Ignore a potential #UD failut during emergency VMXOFF ...=0A=
>> >=0A>> > When a cpu may be in VMX ...=0A>> >=0A>> >>=0A>> >> Fixes: 2080=
67 <https://bugzilla.kernel.org/show_bug.cgi?id=3D208067>=0A>> >> Reported-=
by: David P. Reed <dpreed@deepplum.com>=0A>> >=0A>> > It's not really neces=
sary to say that you, the author, reported the=0A>> > problem, but I guess =
it's harmless.=0A>> >=0A>> >> Suggested-by: Thomas Gleixner <tglx@linutroni=
x.de>=0A>> >> Suggested-by: Sean Christopherson <sean.j.christopherson@inte=
l.com>=0A>> >> Suggested-by: Andy Lutomirski <luto@kernel.org>=0A>> >> Sign=
ed-off-by: David P. Reed <dpreed@deepplum.com>=0A>> >> ---=0A>> >>  arch/x8=
6/include/asm/virtext.h | 20 ++++++++++++++------=0A>> >>  1 file changed, =
14 insertions(+), 6 deletions(-)=0A>> >>=0A>> >> diff --git a/arch/x86/incl=
ude/asm/virtext.h b/arch/x86/include/asm/virtext.h=0A>> >> index 0ede8d0453=
5a..0e0900eacb9c 100644=0A>> >> --- a/arch/x86/include/asm/virtext.h=0A>> >=
> +++ b/arch/x86/include/asm/virtext.h=0A>> >> @@ -30,11 +30,11 @@ static i=
nline int cpu_has_vmx(void)=0A>> >>  }=0A>> >>=0A>> >>=0A>> >> -/* Disable =
VMX on the current CPU=0A>> >> +/* Exit VMX root mode and isable VMX on the=
 current CPU.=0A>> >=0A>> > s/isable/disable/=0A>> >=0A>> >=0A>> >>  /* Dis=
able VMX if it is supported and enabled on the current CPU=0A>> >> --=0A>> =
>> 2.26.2=0A>> >>=0A>> >=0A>> > Other than that:=0A>> >=0A>> > Reviewed-by:=
 Andy Lutomirski <luto@kernel.org>=0A>>=0A>> As a newbie, I have a process =
question - should I resend the patch with the=0A>> 'Reviewed-by' line, as w=
ell as correcting the other wording? Thanks!=0A> =0A> Probably.  Sometimes =
a maintainer will apply the patch and make these=0A> types of cosmetic chan=
ges, but it's easier if you resubmit.  That=0A> being said, for non-urgent =
patches, it's usually considered polite to=0A> wait a day or two to give ot=
her people a chance to comment.=0A=0AI'm not sure which maintainer will mov=
e the patches along. I am waiting for additional input, but will resubmit i=
n a day or two.=0A=0A> =0A> --Andy=0A> =0A

