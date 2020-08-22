Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.7 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A5637C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 02:53:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E94620732
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 02:53:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="o/fttRdB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726767AbgHVCxG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 22:53:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46240 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726118AbgHVCxF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 22:53:05 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 65501C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 19:53:05 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id s15so1868371pgc.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 19:53:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=Fi61h55ExXGzT2ZBExIo+D/RyH/cmpws7Vo4vm2UxqY=;
        b=o/fttRdBbiFFPEBWTk/aF0Lka807KFZG+/c2bPPhcs+eszPMCu7ACw1QLT3dZsKWNt
         cm5sJbdsKYO/ECTtMuM8OnXTjIrhxp3q/q4Mvt6hdjqGshlqO6wYrI8nzNcfaFQ/L8mX
         SyjPa8g+Z3SVBXkEB2+Iq/GR44hWI3qWE6x2kEFLx4k3161DfM/fpbtD/mYztJ++UATI
         XC7C4dF/UJMmF0Jgoa9p/iEgMSQW4HGQAplLlnQJS31RrZPvpn3c2AV59g/67X3wfc8Z
         HoJmvYqWRZAodlYskYQJxwGaYK48xwUJwW3pt6qCqkYZmVZgoRujUZyvsWOXiedUrI1C
         zPpA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=Fi61h55ExXGzT2ZBExIo+D/RyH/cmpws7Vo4vm2UxqY=;
        b=rQdUiRkPs5D42OB+v+Y148rshBpfSm6DDSqpv++h1lV2bBsDBeH5xvhoRaWEgYVBon
         l7CfWsTwhNQ6hmMONxVzVaStiMgMT1GZF/7WNGjTl5YwYJqVF0NEhKyMzmhy3+E+pe5t
         jeNn9HQXPT3PR8/15raDQU8xCouZs/g2ps0HSnG/eBngdDgGoKz9Ue3EWGoVoqZ5VASS
         Pfpo1O6gTS/fvrBHm+zlQMtsClBHNBUVufHzUP5I4BgyMNAhv494bW5bGz1g1DgWDc0i
         eXNamWrI/uJw7sqQVO+UpxviCRw5d9SUsw0oD6DPEC65HolU874VWRx+i50q+pv9qQNI
         sbIA==
X-Gm-Message-State: AOAM533FQGGVdYJdURSWLa3rlhGU7wcoh0o/EnTampCz/M4lgC1fQdmD
        3L1xbc/VAfg7LQFTf8Ii2fhOJm9tUk79dw==
X-Google-Smtp-Source: ABdhPJyqGoImJUnYz4mQyt4AHKSHYPNSCm3dQlGZ23Jy5GCxJdENV7zNK6a9aSMVsYDuve6nsDQlRg==
X-Received: by 2002:aa7:980f:: with SMTP id e15mr4783976pfl.194.1598064784663;
        Fri, 21 Aug 2020 19:53:04 -0700 (PDT)
Received: from ?IPv6:2600:1010:b065:fd25:10c:738e:cf50:c2a7? ([2600:1010:b065:fd25:10c:738e:cf50:c2a7])
        by smtp.gmail.com with ESMTPSA id q12sm4349533pfg.135.2020.08.21.19.53.03
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Aug 2020 19:53:03 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [REGRESSION] x86/cpu fsgsbase breaks TLS in 32 bit rr tracees on a 64 bit system
Date:   Fri, 21 Aug 2020 19:53:01 -0700
Message-Id: <139EF22C-FA09-42B8-BC31-E858CE5970B1@amacapital.net>
References: <CAP045AqiT75B9o5OV+SJT8uTzo7A55Y1BxjNcaSuxtm5EoAxaQ@mail.gmail.com>
Cc:     "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Robert O'Callahan <rocallahan@gmail.com>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>, Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
In-Reply-To: <CAP045AqiT75B9o5OV+SJT8uTzo7A55Y1BxjNcaSuxtm5EoAxaQ@mail.gmail.com>
To:     Kyle Huey <me@kylehuey.com>
X-Mailer: iPhone Mail (17G68)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Aug 21, 2020, at 2:33 PM, Kyle Huey <me@kylehuey.com> wrote:
>=20
> =EF=BB=BFOn Fri, Aug 21, 2020 at 1:08 PM Bae, Chang Seok
> <chang.seok.bae@intel.com> wrote:
>>=20
>>=20
>>>> On Aug 20, 2020, at 21:41, Kyle Huey <me@kylehuey.com> wrote:
>>>=20
>>> On the x86-64 5.9-rc1 TLS is completely broken in 32 bit tracees when
>>> running under rr[0]. Booting the kernel with `nofsgsbase` fixes it and
>>> I bisected to https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/l=
inux.git/commit/?h=3Dv5.8&id=3D673903495c85137791d5820d690229efe09c8f7b.
>>>=20
>>> STR:
>>> 1. Build rr from source by
>>> a. git clone https://github.com/mozilla/rr
>>> b. mkdir rr/obj
>>> c. cd rr/obj
>>> d. cmake ..
>>> e. make -j16
>>> 2. Run the simple 32 bit tracee outside of rr with `./bin/simple_32`.
>>> It should print a message and exit cleanly.
>>> 3. Run it under rr with `./bin/rr ./bin/simple_32`.
>>>=20
>>> It should behave the same way, but with fsgsbase enabled it will
>>> segfault. The `simple_32` binary is a simple "hello world" type
>>> program but it does link to pthreads, so pre-main code attempts to
>>> access TLS variables.
>>>=20
>>> The interplay between 32 bit and 64 bit TLS is dark magic to me
>>> unfortunately so this is all the useful information I have.
>>=20
>> As I run it and collect the ptrace logs, it starts to set FSBASE with
>> some numbers, e.g. 140632147826496, and then later attempts to set GS
>> with 99 through putreg(), not putreg32().
>>=20
>> With FSGSBASE, the FS/GS base is decoupled from the selector. Andy
>> made putreg32() to retain the old behavior, fetching FS/GS base
>> according to the index, but the putreg() does not do. So, rr probably
>> relies on the old behavior as observed to setting the GS index only.
>> But it was previously considered to be okay with this comment [1]:
>>=20
>>   "Our modifications to fs/gs/fs_base/gs_base are always either a)
>>    setting values that the kernel set during recording to make them
>>    happen during replay or b) emulating PTRACE_SET_REGS that a tracee
>>    ptracer tried to set on another tracee. Either way I think the
>>    effects are going to be the same as what would happen if the
>>    program were run without rr."
>>=20
>> It is not straightforward to go into the rr internal to me. Robert,
>> any thought?
>=20
> Hmm. When we are running a 32 bit tracee in a 64 bit build of rr we
> internally convert between the 32 bit and 64 bit user_regs_structs[0]
> at the ptrace boundary. This does not preserve the fs/gsbase (because
> there is no fs/gsbase in the 32 bit user_regs_struct, of course).
>=20
> 40c45904f818c1f6555294ca27afc5fda4f09e68 added magic for a 32 bit
> tracer tracing a 32 bit tracee on a 64 bit kernel, but it looks like a
> 64 bit tracer tracing a 32 bit tracee on a 64 bit kernel *is* now
> expected to preserve the fs/gsbase values (or die, in our case).
>=20
> Is that correct?

I was certainly not expecting rr to do this, and I thought I had asked in ad=
vance.  What exact ptrace() calls are you doing here?  Is this POKEUSER or s=
omething else?  Breaking rr is at least impolite, and I=E2=80=99d like to fi=
x this.

>=20
> - Kyle
>=20
> [0] https://github.com/mozilla/rr/blob/fcd2a26680a3fc2bda5f40d732d0c72b962=
8357b/src/Registers.cc#L519
