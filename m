Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C7A92C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:24:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 37DF022B45
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 19:24:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="RC/JndeD"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727940AbgHCTYt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 15:24:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726615AbgHCTYs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 15:24:48 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70DC3C06174A
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 12:24:48 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 189so3079783pfd.9
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 12:24:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=dKXkBNh6OkWWXJsSvYgmUXcwbCkOFE+wfSIRyOfUtCY=;
        b=RC/JndeDmkmZwALLGSqtKqISTD4ASw1JTRDR7F6RDOzwI74wdw0MSBPfaOxFDJmmFN
         jytRW7FEHy3q9cb4nA/EGhENNuzI2BRFMI1NrZtNYphlLQvA5sPcCplvHKqIdCMa2by1
         +77m2Z7jGnsiCGQqriE9iuaXa+2X+U7cRuZg//3BUibRQJUxwdrJ4OHukWt8xMeCS/8M
         WDm7N8QEX4Cae2zfNQNq5u7xBM9DoRrYDBFN3GDN2a62yoJj9XGlW+U6UURjrA1Stqki
         80YKVNkS8QghLHubGum1IPV55BFONAq2Ms3G2FDpbcHOTKL2GjdTf9YJBPGMCFCf4GHe
         rYqw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=dKXkBNh6OkWWXJsSvYgmUXcwbCkOFE+wfSIRyOfUtCY=;
        b=PdHuNhFeYGe9Yu/q1Y6gQWkitOvi9dc9SE0yMjcJqYxiIax1ZWmgrs3K5E2AxFStpp
         cJJoonHfAXuylXJFLjVRSaUaBObZN+wjaCF4lc9oxGSSoNNO6dxxINE8YemKAozZmCBT
         xh58o8mruqZGYwN0/F15aIqqRaezmRt3a2+KxE2PAtQxqAhshk0yb12BiZ0losoiExgG
         PJMfzVLdmHxBAR1Q7KVEUwz61ZNSxGEEaZFTULO42KSjfzoc3ZLP3Jbj0tXcWL3Mb8a2
         89pkOzmEHGO5ANzrcAvvzV7QISLUkrTzpUkQkNUK+1BTEeFIzEpENxu+MQjO1/5g0wPm
         BzVQ==
X-Gm-Message-State: AOAM533GUABwiKiPo0rUG65+cV74N+PfD/RieT4PWo9PiTzBIikFkcfd
        4pxCPGSvpfaKhzIwejLv12MHSQ==
X-Google-Smtp-Source: ABdhPJwdCNodiHqX2T19OMRJL6fkYEsRLdIrhW4D5SAzdXg27eEywIryiOjXUIA/kPK3aD+AYoHRjg==
X-Received: by 2002:a62:fb07:: with SMTP id x7mr17856621pfm.252.1596482687856;
        Mon, 03 Aug 2020 12:24:47 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:2921:e1f6:5101:6c22? ([2601:646:c200:1ef2:2921:e1f6:5101:6c22])
        by smtp.gmail.com with ESMTPSA id x23sm19599186pfi.60.2020.08.03.12.24.45
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 03 Aug 2020 12:24:46 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH v6 12/12] x86/traps: Fix up invalid PASID
Date:   Mon, 3 Aug 2020 12:24:44 -0700
Message-Id: <56C96132-6F42-4E50-B712-C7F31CB01C9D@amacapital.net>
References: <92a14516-1f63-5b5f-7f30-8870fe343c8e@intel.com>
Cc:     Andy Lutomirski <luto@kernel.org>,
        Fenghua Yu <fenghua.yu@intel.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Joerg Roedel <joro@8bytes.org>, Ingo Molnar <mingo@redhat.com>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <peterz@infradead.org>,
        H Peter Anvin <hpa@zytor.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Felix Kuehling <Felix.Kuehling@amd.com>,
        Tony Luck <tony.luck@intel.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ashok Raj <ashok.raj@intel.com>,
        Jacob Jun Pan <jacob.jun.pan@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Sohil Mehta <sohil.mehta@intel.com>,
        Ravi V Shankar <ravi.v.shankar@intel.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        x86 <x86@kernel.org>, iommu <iommu@lists.linux-foundation.org>,
        amd-gfx <amd-gfx@lists.freedesktop.org>
In-Reply-To: <92a14516-1f63-5b5f-7f30-8870fe343c8e@intel.com>
To:     Dave Hansen <dave.hansen@intel.com>
X-Mailer: iPhone Mail (17G68)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




> On Aug 3, 2020, at 10:34 AM, Dave Hansen <dave.hansen@intel.com> wrote:
>=20
> =EF=BB=BFOn 8/3/20 10:16 AM, Andy Lutomirski wrote:
>> - TILE: genuinely per-thread, but it's expensive so it's
>> lazy-loadable.  But the lazy-load mechanism reuses #NM, and it's not
>> fully disambiguated from the other use of #NM.  So it sort of works,
>> but it's gross.
>=20
> For those playing along at home, there's a new whitepaper out from Intel
> about some new CPU features which are going to be fun:
>=20
>> https://software.intel.com/content/dam/develop/public/us/en/documents/arc=
hitecture-instruction-set-extensions-programming-reference.pdf
>=20
> Which part were you worried about?  I thought it was fully disambuguated
> from this:
>=20
>> When XFD causes an instruction to generate #NM, the processor loads
>> the IA32_XFD_ERR MSR to identify the disabled state component(s).
>> Specifically, the MSR is loaded with the logical AND of the IA32_XFD
>> MSR and the bitmap corresponding to the state components required by
>> the faulting instruction.
>>=20
>> Device-not-available exceptions that are not due to XFD =E2=80=94 those=20=

>> resulting from setting CR0.TS to 1 =E2=80=94 do not modify the IA32_XFD_E=
RR
>> MSR.
>=20
> So if you always make sure to *clear* IA32_XFD_ERR after handing and XFD
> exception, any #NM's with a clear IA32_XFD_ERR are from "legacy"
> CR0.TS=3D1.  Any bits set in IA32_XFD_ERR mean a new-style XFD exception.
>=20
> Am I missing something?

I don=E2=80=99t think you=E2=80=99re missing anything, but this mechanism se=
ems to be solidly in the category of =E2=80=9Cjust barely works=E2=80=9D, ki=
nd of like #DB and DR6, which also just barely works.

And this PASID vs #GP mess is just sad. We=E2=80=99re trying to engineer aro=
und an issue that has no need to exist in the first place.  For some reason w=
e have two lazy-loading-fault mechanisms showing up in x86 in rapid successi=
on, one of them is maybe 3/4-baked, and the other is totally separate and ma=
ybe 1/4 baked.

If ENQCMD instead raise #NM, this would be trivial. (And it even makes sense=
 =E2=80=94 the error is, literally, =E2=80=9Can instruction tried to use som=
ething in XSTATE that isn=E2=80=99t initialized=E2=80=9D.). Or if someone ha=
d noticed that, kind of like PKRU, PASID didn=E2=80=99t really belong in XST=
ATE, we wouldn=E2=80=99t have this mess.

Yes, obviously Linux can get all this stuff to work, but maybe Intel could a=
spire to design features that are straightforward to use well instead of mer=
ely possible to use well?=
