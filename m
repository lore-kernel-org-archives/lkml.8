Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 703BEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:34:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4CB22206FA
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 09:34:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="EqHiMJ7G"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727095AbgFVJeF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 05:34:05 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54722 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727011AbgFVJeF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 05:34:05 -0400
Received: from [10.165.156.120] (unknown [46.114.36.120])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 17BAB1EC0212;
        Mon, 22 Jun 2020 11:34:04 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1592818444;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Y56e9WGVRYsOicqPXPCPeVfznnt126+dC9+PEiT4864=;
        b=EqHiMJ7GFhrGMvyZe7kS5/eJcBjVahGXiU1xSYVl5S9+MEDa8dDsgQ0MWi5ZtwSDXh2OLb
        Uo7phNYCkf4kSK1ip8ojfRb/sbjGOv4h0D2z2nEtINs23kTjeMpqA+HIvDmhGDOVWDiddI
        0ZjOnkILnPJjCkITLCU68OTk/WHIK8s=
Date:   Mon, 22 Jun 2020 11:34:01 +0200
User-Agent: K-9 Mail for Android
In-Reply-To: <5484e005-3b3d-a53a-f18e-d9b6620cf84b@intel.com>
References: <20200618220139.GH27951@zn.tnic> <CAFmMkTGMAu-huTnP1aeMb_W4NddbTD_b2jhbDVKBDrkwgB97wg@mail.gmail.com> <20200619074053.GA32683@zn.tnic> <CAFmMkTGV0ZR6C=EBGQAiz1vw1vrUXSLTnH5ZbBUvfhPLg_tF6g@mail.gmail.com> <20200619132243.GC32683@zn.tnic> <CAD2FfiEr0kRWp2ut_PVqVDEVZqwESUxv=fxM9wUgi3n=ZCzPcQ@mail.gmail.com> <20200619134432.GE32683@zn.tnic> <CAD2FfiFRqwYGB50KK=aA0sU6uCALYneoyD=V4EfOsk-Ex=C+xg@mail.gmail.com> <20200619161026.GF32683@zn.tnic> <CAD2FfiGN5kdHHEz-6Oy9S-fFT35bJH0ZOfqfn5SyCG_Y2LtE_w@mail.gmail.com> <20200619164056.GB2235992@kroah.com> <CAD2FfiHVyt2hWBqcgtxbBaLEuxuzz6yAe1+8sK5J0SYWVEr5qQ@mail.gmail.com> <CALCETrXKzmdXtHsdBTJB7+RYZX5UOD_Q4MVd9zVAVOjYgU5WRA@mail.gmail.com> <CAD2FfiGT5bsb0sd2k8NGNmShvW_q3UV9YXgn-EwxBCJjx6PSTw@mail.gmail.com> <CALCETrVieskMnU5XHKHYm+qOfzc+o4yhsGw42pvBNhkv2zsQJA@mail.gmail.com> <5484e005-3b3d-a53a-f18e-d9b6620cf84b@intel.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH] Ability to read the MKTME status from userspace
To:     Dave Hansen <dave.hansen@intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Richard Hughes <hughsient@gmail.com>
CC:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Daniel Gutson <daniel@eclypsium.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, X86 ML <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>, Arnd Bergmann <arnd@arndb.de>,
        Peter Zijlstra <peterz@infradead.org>,
        "David S. Miller" <davem@davemloft.net>,
        Rob Herring <robh@kernel.org>, Tony Luck <tony.luck@intel.com>,
        Rahul Tanwar <rahul.tanwar@linux.intel.com>,
        Xiaoyao Li <xiaoyao.li@intel.com>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>
From:   Boris Petkov <bp@alien8.de>
Message-ID: <22C63085-BD78-4FEB-B1BD-D3668A54F1D1@alien8.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 19, 2020 10:24:23 PM GMT+02:00, Dave Hansen <dave=2Ehansen@intel=2E=
com> wrote:
>On 6/19/20 1:20 PM, Andy Lutomirski wrote:
>> Boris, etc: would it be reasonable to add a list of CPU features that
>> are present but turned off by firmware?  SME is far from the only
>> thing that's frequently in this category=2E  x2apic, fast strings, and
>> virtualization come to mind=2E
>
>Sounds sane to me=2E  I like the idea of proving ammo to end users to
>either go flip a BIOS switch, or yell at their firmware vendor=2E

Sure if the reenabling the feature in BIOS would enable the support=2E Whi=
ch is not the case with TME, as ypu pointed out, so I'm not sure a list CPU=
 features which are present but turned off in firmware, is enough=2E

I'm thinking more along the lines of adding freetext doc for such "complex=
" to enable features which explains to users what and where to check, what =
to switch on and off and what other prerequisites can be=2E=2E=2E

And yes, it is ugly=2E ;-/

--=20
Sent from a small device: formatting sux and brevity is inevitable=2E 
