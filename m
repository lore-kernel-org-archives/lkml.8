Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EE37C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 19:52:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E171E2074F
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 19:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=g001.emailsrvr.com header.i=@g001.emailsrvr.com header.b="uAgZJZqh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728255AbgGETwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 15:52:10 -0400
Received: from smtp84.iad3a.emailsrvr.com ([173.203.187.84]:48128 "EHLO
        smtp84.iad3a.emailsrvr.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728002AbgGETwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 15:52:09 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=g001.emailsrvr.com;
        s=20190322-9u7zjiwi; t=1593978728;
        bh=ij7EIYjhCd3w9IF306GFbyGJQuU7dUEBuiU+1hkCksM=;
        h=Date:Subject:From:To:From;
        b=uAgZJZqhkYvQUjimQy8VTSqQvbxXnL4Z1z9DwQ8KMmH2ZoR+us6kJ++SeJDMpStki
         54w+dISo+rmtKfMluxTCKEHHRhJCm9Ave7CFBEoe5dT1zrPez3+cqofVpihm3IWQnk
         lE0xedafWQdSxsXLLs7WRizpsf3DicpAzz3RIDR4=
Received: from app27.wa-webapps.iad3a (relay-webapps.rsapps.net [172.27.255.140])
        by smtp19.relay.iad3a.emailsrvr.com (SMTP Server) with ESMTP id 2899737E8;
        Sun,  5 Jul 2020 15:52:08 -0400 (EDT)
Received: from deepplum.com (localhost.localdomain [127.0.0.1])
        by app27.wa-webapps.iad3a (Postfix) with ESMTP id 0F66721682;
        Sun,  5 Jul 2020 15:52:08 -0400 (EDT)
Received: by apps.rackspace.com
    (Authenticated sender: dpreed@deepplum.com, from: dpreed@deepplum.com) 
    with HTTP; Sun, 5 Jul 2020 15:52:08 -0400 (EDT)
X-Auth-ID: dpreed@deepplum.com
Date:   Sun, 5 Jul 2020 15:52:08 -0400 (EDT)
Subject: Re: [PATCH v3 2/3] Fix undefined operation fault that can hang a cpu on crash or panic
From:   "David P. Reed" <dpreed@deepplum.com>
To:     "Andy Lutomirski" <luto@kernel.org>
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
In-Reply-To: <CALCETrVZx4VA9rg-Hn7KdER866ZOtZtmTkR0MSacnj5jGO-Pag@mail.gmail.com>
References: <20200629214956.GA12962@linux.intel.com> 
 <20200704203809.76391-1-dpreed@deepplum.com> 
 <20200704203809.76391-3-dpreed@deepplum.com> 
 <CALCETrVZx4VA9rg-Hn7KdER866ZOtZtmTkR0MSacnj5jGO-Pag@mail.gmail.com>
Message-ID: <1593978728.059424180@apps.rackspace.com>
X-Mailer: webmail/17.3.12-RC
X-Classification-ID: 73f2171e-f80f-4dba-ab50-af6f631ae985-1-1
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks, will handle these. 2 questions below.=0A=0AOn Sunday, July 5, 2020 =
2:22pm, "Andy Lutomirski" <luto@kernel.org> said:=0A=0A> On Sat, Jul 4, 202=
0 at 1:38 PM David P. Reed <dpreed@deepplum.com> wrote:=0A>>=0A>> Fix: Mask=
 undefined operation fault during emergency VMXOFF that must be=0A>> attemp=
ted to force cpu exit from VMX root operation.=0A>> Explanation: When a cpu=
 may be in VMX root operation (only possible when=0A>> CR4.VMXE is set), cr=
ash or panic reboot tries to exit VMX root operation=0A>> using VMXOFF. Thi=
s is necessary, because any INIT will be masked while cpu=0A>> is in VMX ro=
ot operation, but that state cannot be reliably=0A>> discerned by the state=
 of the cpu.=0A>> VMXOFF faults if the cpu is not actually in VMX root oper=
ation, signalling=0A>> undefined operation.=0A>> Discovered while debugging=
 an out-of-tree x-visor with a race. Can happen=0A>> due to certain kinds o=
f bugs in KVM.=0A> =0A> Can you re-wrap lines to 68 characters?  Also, the =
Fix: and=0A=0AI used 'scripts/checkpatch.pl' and it had me wrap to 75 chars=
:=0A"WARNING: Possible unwrapped commit description (prefer a maximum 75 ch=
ars per line)"=0A=0AShould I submit a fix to checkpatch.pl to say 68? =0A=
=0A> Explanation: is probably unnecessary.  You could say:=0A> =0A> Ignore =
a potential #UD failut during emergency VMXOFF ...=0A> =0A> When a cpu may =
be in VMX ...=0A> =0A>>=0A>> Fixes: 208067 <https://bugzilla.kernel.org/sho=
w_bug.cgi?id=3D208067>=0A>> Reported-by: David P. Reed <dpreed@deepplum.com=
>=0A> =0A> It's not really necessary to say that you, the author, reported =
the=0A> problem, but I guess it's harmless.=0A> =0A>> Suggested-by: Thomas =
Gleixner <tglx@linutronix.de>=0A>> Suggested-by: Sean Christopherson <sean.=
j.christopherson@intel.com>=0A>> Suggested-by: Andy Lutomirski <luto@kernel=
.org>=0A>> Signed-off-by: David P. Reed <dpreed@deepplum.com>=0A>> ---=0A>>=
  arch/x86/include/asm/virtext.h | 20 ++++++++++++++------=0A>>  1 file cha=
nged, 14 insertions(+), 6 deletions(-)=0A>>=0A>> diff --git a/arch/x86/incl=
ude/asm/virtext.h b/arch/x86/include/asm/virtext.h=0A>> index 0ede8d04535a.=
.0e0900eacb9c 100644=0A>> --- a/arch/x86/include/asm/virtext.h=0A>> +++ b/a=
rch/x86/include/asm/virtext.h=0A>> @@ -30,11 +30,11 @@ static inline int cp=
u_has_vmx(void)=0A>>  }=0A>>=0A>>=0A>> -/* Disable VMX on the current CPU=
=0A>> +/* Exit VMX root mode and isable VMX on the current CPU.=0A> =0A> s/=
isable/disable/=0A> =0A> =0A>>  /* Disable VMX if it is supported and enabl=
ed on the current CPU=0A>> --=0A>> 2.26.2=0A>>=0A> =0A> Other than that:=0A=
> =0A> Reviewed-by: Andy Lutomirski <luto@kernel.org>=0A=0AAs a newbie, I h=
ave a process question - should I resend the patch with the 'Reviewed-by' l=
ine, as well as correcting the other wording? Thanks!=0A=0A> =0A> --Andy=0A=
> =0A

