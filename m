Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DD40C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:36:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1D12E2074B
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 22:36:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=codeweavers.com header.i=@codeweavers.com header.b="D25L8BuT"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgFHWgZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 18:36:25 -0400
Received: from mail.codeweavers.com ([50.203.203.244]:57396 "EHLO
        mail.codeweavers.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgFHWgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 18:36:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=codeweavers.com; s=6377696661; h=To:References:Message-Id:
        Content-Transfer-Encoding:Cc:Date:In-Reply-To:From:Subject:Mime-Version:
        Content-Type:Sender:Reply-To:Content-ID:Content-Description:Resent-Date:
        Resent-From:Resent-Sender:Resent-To:Resent-Cc:Resent-Message-ID:List-Id:
        List-Help:List-Unsubscribe:List-Subscribe:List-Post:List-Owner:List-Archive;
         bh=IHsIUYf/EF7HX/+mLk/exZGdZj+pE5reZm8Wq5yQBdg=; b=D25L8BuTK+m3Z+sR9Okiw7K8l
        JYfP55PrFCuiGZ/ocfrd/mWt9B3YPm9GK3UxtodtEDSjYcW4jYm5xsVlFHsv971UaLzbEqoqANeSw
        IFS9deyjHDXQIfsUthBEeUNFAVXRIZpm8wSMwXlajUrdIU+G3vCKx9D4+IOQhLH4nZz5o=;
Received: from cpe-107-184-2-226.socal.res.rr.com ([107.184.2.226] helo=[192.168.2.117])
        by mail.codeweavers.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <bshanks@codeweavers.com>)
        id 1jiQNQ-0004gi-EK; Mon, 08 Jun 2020 17:36:22 -0500
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 12.4 \(3445.104.14\))
Subject: Re: [PATCH v2] x86/umip: Add emulation/spoofing for SLDT and STR
 instructions
From:   Brendan Shanks <bshanks@codeweavers.com>
In-Reply-To: <20200608215315.GB23567@ranerica-svr.sc.intel.com>
Date:   Mon, 8 Jun 2020 15:36:18 -0700
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, X86 ML <x86@kernel.org>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        Andreas Rammhold <andi@notmuch.email>,
        "Moger, Babu" <Babu.Moger@amd.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <5256D924-9BFE-47EF-9A3A-2B5FB7B79946@codeweavers.com>
References: <20200608181454.14210-1-bshanks@codeweavers.com>
 <20200608215315.GB23567@ranerica-svr.sc.intel.com>
To:     Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
X-Mailer: Apple Mail (2.3445.104.14)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


> On Jun 8, 2020, at 2:53 PM, Ricardo Neri =
<ricardo.neri-calderon@linux.intel.com> wrote:
>=20
> On Mon, Jun 08, 2020 at 11:14:54AM -0700, Brendan Shanks wrote:
>> Add emulation/spoofing of SLDT and STR for both 32- and 64-bit
>> processes.
>>=20
>> Wine users have found a small number of Windows apps using SLDT that
>> were crashing when run on UMIP-enabled systems.
>>=20
>> Reported-by: Andreas Rammhold <andi@notmuch.email>
>> Originally-by: Ricardo Neri <ricardo.neri-calderon@linux.intel.com>
>> Signed-off-by: Brendan Shanks <bshanks@codeweavers.com>
>> ---
>>=20
>> v2: Return (GDT_ENTRY_LDT * 8) for SLDT when an LDT is set.
>>=20
>> arch/x86/kernel/umip.c | 34 +++++++++++++++++++++++++---------
>> 1 file changed, 25 insertions(+), 9 deletions(-)
>>=20
>> diff --git a/arch/x86/kernel/umip.c b/arch/x86/kernel/umip.c
>> index 8d5cbe1bbb3b..a85f0b0ec2b9 100644
>> --- a/arch/x86/kernel/umip.c
>> +++ b/arch/x86/kernel/umip.c
>> @@ -64,6 +64,8 @@
>> #define UMIP_DUMMY_GDT_BASE 0xfffffffffffe0000ULL
>> #define UMIP_DUMMY_IDT_BASE 0xffffffffffff0000ULL
>>=20
>> +#define UMIP_DUMMY_TASK_REGISTER_SELECTOR 0x40
>=20
> One more thing. How was this value selected? Would it be possible to =
use
> GDT_ENTRY_TSS*8? Linux already uses this value.

I used 0x40 because =E2=80=98sldt=E2=80=99 returned that value on every =
system I tested. GDT_ENTRY_TSS*8 also equals 0x40 (for 64-bit capable =
kernels), yes I can use that instead.


Thank you,

Brendan Shanks
CodeWeavers=
