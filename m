Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id BCF4DC33CA9
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 05:05:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 91004222C3
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 05:05:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="m7sWVYrB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726379AbgANFFh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 00:05:37 -0500
Received: from terminus.zytor.com ([198.137.202.136]:56633 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725306AbgANFFh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 00:05:37 -0500
Received: from [IPv6:2601:646:8600:3281:f01b:4b70:2f15:dd93] ([IPv6:2601:646:8600:3281:f01b:4b70:2f15:dd93])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 00E55DIg1625580
        (version=TLSv1.2 cipher=ECDHE-RSA-AES128-GCM-SHA256 bits=128 verify=NO);
        Mon, 13 Jan 2020 21:05:15 -0800
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 00E55DIg1625580
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2019122001; t=1578978316;
        bh=83fFDcR4CorQO5vMReXB6erEPxRwA4L0PljKCTQE+8Y=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=m7sWVYrBUnXLP4IqlWHMXtQLf8x4ZHoRSKUxQqUPf0/fyCEUOmf/Ks852dfrZmpDv
         qA4eb0pd1PtGYYLzx2HojW3aOddKAEETMk5SjggUuovO4B2Kbti3A8WHH3NzgH8Cc4
         xY3ktUd8nopiTZT3kI/10ivs18bPRltSpD/f/lvXKp+dxbGO5/ZDg0w/xA5SrXsL7S
         CgbE1XbwPDI4Y1AYPG/zug3M5AdP8jiAu95IWMIGGmXLKRM3W7clwPqeg9SNgywglh
         mAzcqTC1uM20Ga6Dr7bxbus0MwOkTDxzh7csmI6ZPEqclihYLFvuRhI4B3SFJ5Apy9
         jXL+yoofYQIDA==
Date:   Mon, 13 Jan 2020 21:05:05 -0800
User-Agent: K-9 Mail for Android
In-Reply-To: <20200114035858.GA2536335@rani.riverdale.lan>
References: <20200113161310.GA191743@rani.riverdale.lan> <20200113195337.604646-1-nivedita@alum.mit.edu> <202001131750.C1B8468@keescook> <261ae869-4169-296e-f673-5c08ff34bdde@zytor.com> <20200114035858.GA2536335@rani.riverdale.lan>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH v3] x86/vmlinux: Fix vmlinux.lds.S with pre-2.23 binutils
To:     Arvind Sankar <nivedita@alum.mit.edu>
CC:     Kees Cook <keescook@chromium.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Mauro Rossi <issor.oruam@gmail.com>,
        Michael Matz <matz@suse.de>
From:   hpa@zytor.com
Message-ID: <F7B2A25D-E6A2-4637-9802-8AEC543916E9@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On January 13, 2020 7:58:59 PM PST, Arvind Sankar <nivedita@alum=2Emit=2Eed=
u> wrote:
>On Mon, Jan 13, 2020 at 05:57:23PM -0800, H=2E Peter Anvin wrote:
>> On 2020-01-13 17:53, Kees Cook wrote:>>
>> >> diff --git a/arch/x86/kernel/vmlinux=2Elds=2ES
>b/arch/x86/kernel/vmlinux=2Elds=2ES
>> >> index 3a1a819da137=2E=2Ebad4e22384dc 100644
>> >> --- a/arch/x86/kernel/vmlinux=2Elds=2ES
>> >> +++ b/arch/x86/kernel/vmlinux=2Elds=2ES
>> >> @@ -144,10 +144,12 @@ SECTIONS
>> >>  		*(=2Etext=2E__x86=2Eindirect_thunk)
>> >>  		__indirect_thunk_end =3D =2E;
>> >>  #endif
>> >> +
>> >> +		/* End of text section */
>> >> +		_etext =3D =2E;
>> >>  	} :text =3D0xcccc
>> >> =20
>> >> -	/* End of text section, which should occupy whole number of
>pages */
>> >> -	_etext =3D =2E;
>> >> +	/* =2Etext should occupy whole number of pages */
>> >>  	=2E =3D ALIGN(PAGE_SIZE);
>> >=20
>> > NAK: linkers can add things at the end of =2Etext that will go
>missing from
>> > the kernel if _etext isn't _outside_ the =2Etext section, truly
>beyond the
>> > end of the =2Etext section=2E This patch will break Control Flow
>Integrity
>> > checking since the jump tables are at the end of =2Etext=2E
>> >=20
>> > Boris, we're always working around weird linker problems; I don't
>see a
>> > problem with the v2 patch to fix up old binutils=2E=2E=2E
>> >=20
>>=20
>> Why not add the marker into a separate section instead of leaving it
>as an
>> absolute "floater"? Very old binutils would botch that case, but I
>think that
>> has been long since addressed well below our current minimum version=2E
>>=20
>> 	-hpa
>>=20
>>=20
>>=20
>
>Kees, thanks, I noted in the other email that you had mentioned this in
>a since-reverted commit, but you did not mention in the most recent
>commit=2E
>
>hpa, I think this runs afoul of the bug you noted in commit
>fd952815307f
>("x86-32, relocs: Whitelist more symbols for ld bug workaround"), ld
>version 2=2E22=2E52=2E0=2E[12] can incorrectly promote relative symbols t=
o
>absolute, if the output section they appear in is otherwise empty=2E
>
>That's 2=2E22, which is more recent than the 2=2E21 that the kernel
>documents as supported=2E

Oh right=2E=2E=2E they introduced that little piece of drain bramage=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
