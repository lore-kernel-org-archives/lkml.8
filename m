Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0579AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 18:13:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4E252078D
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 18:13:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="MosJ9qJx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726112AbgFHSNz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 14:13:55 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:36476 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725283AbgFHSNx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 14:13:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=To:References:Message-Id:
        Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
        Content-Type:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=fIpP7gLteBD475nc1hFkkH/GDrIhfTqrr/+tJZRRidU=; b=MosJ9qJx93qJn0vlYUyPHcDcb
        sgFEJO/6dThadfP/Jmgt/L3OTZBSlGgu64pAWLcFOAdoI+7J3b/W2Flzqua5XwjpDsEspBxr+/uzQ
        RHw2G2MQVfblxNt2LuP+Tg+o1TBcQe+49ewifJHZxY7pzQnAGavjj9CJJFiW0qWEM3MnE=;
Received: from cpe-107-184-2-226.socal.res.rr.com ([107.184.2.226] helo=[192.168.2.117])
        by mail.codeweavers.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <bshanks@codeweavers.com>)
        id 1jiMHL-0008Ep-25; Mon, 08 Jun 2020 13:13:49 -0500
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH] x86/umip: Add emulation/spoofing for SLDT and STR
 instructions
From:   Brendan Shanks <bshanks@codeweavers.com>
In-Reply-To: <20200605224231.GA7466@ranerica-svr.sc.intel.com>
Date:   Mon, 8 Jun 2020 11:13:44 -0700
Cc:     Andy Lutomirski <luto@amacapital.net>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Rammhold <andi@notmuch.email>,
        "Moger, Babu" <Babu.Moger@amd.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <44E6353E-FFC1-4414-A5D7-2EF249A090BE@codeweavers.com>
References: <20200602184212.10813-1-bshanks@codeweavers.com>
 <20200604001243.GA24742@ranerica-svr.sc.intel.com>
 <CALCETrXrvNZQUqfjF+-=jh1TMBpdB0PT-8J5wWDO83+i3B5Q1w@mail.gmail.com>
 <E32838F8-665E-488F-96E4-040DD7BDA284@codeweavers.com>
 <20200605224231.GA7466@ranerica-svr.sc.intel.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: Apple Mail (2.3445.104.14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jun 5, 2020, at 3:42 PM, Ricardo Neri =
<ricardo.neri-calderon@linux.intel.com> wrote:
>=20
> On Fri, Jun 05, 2020 at 11:58:13AM -0700, Brendan Shanks wrote:
>>=20
>>> On Jun 3, 2020, at 9:39 PM, Andy Lutomirski <luto@amacapital.net> =
wrote:
>>>=20
>>> On Wed, Jun 3, 2020 at 5:12 PM Ricardo Neri
>>> <ricardo.neri-calderon@linux.intel.com =
<mailto:ricardo.neri-calderon@linux.intel.com>> wrote:
>>>>=20
>>>> On Tue, Jun 02, 2020 at 11:42:12AM -0700, Brendan Shanks wrote:
>>>>> Add emulation/spoofing of SLDT and STR for both 32- and 64-bit
>>>>> processes.
>>>>>=20
>>>>> Wine users have found a small number of Windows apps using SLDT =
that
>>>>> were crashing when run on UMIP-enabled systems.
>>>>>=20
>>>>> Reported-by: Andreas Rammhold <andi@notmuch.email>
>>>>> Originally-by: Ricardo Neri =
<ricardo.neri-calderon@linux.intel.com>
>>>>> Signed-off-by: Brendan Shanks <bshanks@codeweavers.com>
>>>>> ---
>>>>> arch/x86/kernel/umip.c | 23 ++++++++++++++---------
>>>>> 1 file changed, 14 insertions(+), 9 deletions(-)
>>>>>=20
>>>>> diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
>>>>> index 8d5cbe1bbb3b..59dfceac5cc0 100644
>>>>> --- a/arch/x86/kernel/umip.c
>>>>> +++ b/arch/x86/kernel/umip.c
>>>>> @@ -64,6 +64,8 @@
>>>>> #define UMIP_DUMMY_GDT_BASE 0xfffffffffffe0000ULL
>>>>> #define UMIP_DUMMY_IDT_BASE 0xffffffffffff0000ULL
>>>>>=20
>>>>> +#define UMIP_DUMMY_TASK_REGISTER_SELECTOR 0x40
>>>>> +
>>>>> /*
>>>>> * The SGDT and SIDT instructions store the contents of the global =
descriptor
>>>>> * table and interrupt table registers, respectively. The =
destination is a
>>>>> @@ -244,16 +246,24 @@ static int emulate_umip_insn(struct insn =
*insn, int umip_inst,
>>>>>             *data_size +=3D UMIP_GDT_IDT_LIMIT_SIZE;
>>>>>             memcpy(data, &dummy_limit, UMIP_GDT_IDT_LIMIT_SIZE);
>>>>>=20
>>>>> -     } else if (umip_inst =3D=3D UMIP_INST_SMSW) {
>>>>> -             unsigned long dummy_value =3D CR0_STATE;
>>>>> +     } else if (umip_inst =3D=3D UMIP_INST_SMSW || umip_inst =3D=3D=
 UMIP_INST_SLDT ||
>>>>> +                umip_inst =3D=3D UMIP_INST_STR) {
>>>>> +             unsigned long dummy_value;
>>>>> +
>>>>> +             if (umip_inst =3D=3D UMIP_INST_SMSW)
>>>>> +                     dummy_value =3D CR0_STATE;
>>>>> +             else if (umip_inst =3D=3D UMIP_INST_STR)
>>>>> +                     dummy_value =3D =
UMIP_DUMMY_TASK_REGISTER_SELECTOR;
>>>>> +             else
>>>>> +                     dummy_value =3D 0;
>>>>=20
>>>> Perhaps you can return a non-zero value for SLDT if it has an LDT, =
as
>>>> Andy had suggested. Maybe this can be implemented by looking at
>>>> current->mm->context.ldt
>>>>=20
>>>> I guess the non-zero value can be (GDT_ENTRY_LDT*8).
>>>=20
>>> You could probably even get away with always returning a nonzero
>>> value.  After all, an empty LDT is quite similar to no LDT.
>>=20
>>=20
>> Is something like this what you both had in mind?
>=20
>> I don=E2=80=99t have any software handy to test the LDT-present case =
though.
>=20
> Perhaps you can insert a test in the kernel selftest. Something like
> this (based on Andreas' test program):
>=20
> --- a/tools/testing/selftests/x86/ldt_gdt.c
> +++ b/tools/testing/selftests/x86/ldt_gdt.c
> @@ -220,12 +220,23 @@ static void install_invalid(const struct =
user_desc *desc, bool oldmode)
> 	}
> }
>=20
> +unsigned long test(void)
> +{
> +	 unsigned char ldtr[5] =3D "\xef\xbe\xad\xde";
> +	 unsigned long ldt =3D 0;
> +	 asm("sldt %0\n" : "=3Dm" (ldtr));
> +	 ldt =3D *((unsigned long *)&ldtr[0]);
> +	 printf ("LDT base: 0x%lx\n", ldt);
> +	 return (ldt);
> +}
> +
> static int safe_modify_ldt(int func, struct user_desc *ptr,
>                           unsigned long bytecount)
> {
> 	int ret =3D syscall(SYS_modify_ldt, 0x11, ptr, bytecount);
> 	if (ret < -1)
> 	errno =3D -ret;
> +	test();
> 	return ret;
> }

Thanks for the tip, I gave that a try and got the same results under =
UMIP and a non-UMIP system. I=E2=80=99ll send this next version of the =
patch out.

Brendan Shanks
CodeWeavers

