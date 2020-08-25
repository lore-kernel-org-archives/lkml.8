Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6E642C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:14:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DC8D2075F
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 15:14:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="Se3cR6Eh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726707AbgHYPOV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 25 Aug 2020 11:14:21 -0400
Received: from terminus.zytor.com ([198.137.202.136]:36127 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726180AbgHYPOU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Aug 2020 11:14:20 -0400
Received: from [IPv6:2601:646:8600:3281:ac5a:5acb:ad61:7409] ([IPv6:2601:646:8600:3281:ac5a:5acb:ad61:7409])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 07PFE07C2895287
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Tue, 25 Aug 2020 08:14:00 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 07PFE07C2895287
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020072401; t=1598368441;
        bh=EWMm8se8kI2wXTq4mmPYDwFOsE37FUtVdOwSAlw5ftQ=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=Se3cR6Ehlm49FUFATgVkuAS4utwTOKJL2nqSWjh/EfqygjvSMZEntNB81gn6jSviC
         qipg50JEvAa2JJ81+CgoNRHDjMac5seToMTbwJC3jgzHDwZGnWgf/CgHO5uqUK5mRm
         gQ4F9OmTfKauqpkuGMe7AbCcybt4kC+3MkF1Key0eITEKKNhuDsWmjzq0+dMTPg9Pi
         iPlGtY4vxx7Qjisekr8gSF70aHv/cVASHZd39fRPBJ/ZTJ5/1/yQjqscqar2wFmepE
         VXwPjxy0kg4D1U1SSziMDNxLvjXsoOiU1Q1rsqu3L0FPf3LYZ8e9kJt/etVLDBdoO7
         rHpNxRtH7VvrQ==
Date:   Tue, 25 Aug 2020 08:13:51 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <CALCETrXvgb257CWnaA1NgUUp3x08+gJBEOQh4o9OYkB-RvAo1A@mail.gmail.com>
References: <CAOp6jLYrwMqV=7hmxgdZUdDZ2aeUB27TTHm=j6cQT7C10Muhww@mail.gmail.com> <7DF88F22-0310-40C9-9DA6-5EBCB4877933@amacapital.net> <CALCETrUrvrQNw6dPau_rtHjA_YuCVdCTWYd4dsdcvcGsOaspmg@mail.gmail.com> <b0813ec5-b163-cc11-bfc9-e9d08c9c4ff2@zytor.com> <CALCETrXvgb257CWnaA1NgUUp3x08+gJBEOQh4o9OYkB-RvAo1A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [REGRESSION] x86/cpu fsgsbase breaks TLS in 32 bit rr tracees on a 64 bit system
To:     Andy Lutomirski <luto@kernel.org>
CC:     "Robert O'Callahan" <robert@ocallahan.org>,
        "Bae, Chang Seok" <chang.seok.bae@intel.com>,
        Kyle Huey <me@kylehuey.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>,
        Andi Kleen <ak@linux.intel.com>,
        "Shankar, Ravi V" <ravi.v.shankar@intel.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "Hansen, Dave" <dave.hansen@intel.com>
From:   hpa@zytor.com
Message-ID: <F1D9A90A-A2D5-47E4-8E33-410460FCD6CC@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On August 24, 2020 5:30:56 PM PDT, Andy Lutomirski <luto@kernel=2Eorg> wrot=
e:
>On Mon, Aug 24, 2020 at 4:52 PM H=2E Peter Anvin <hpa@zytor=2Ecom> wrote:
>>
>> On 2020-08-24 14:10, Andy Lutomirski wrote:
>> >
>> > PTRACE_READ_SEGMENT_DESCRIPTOR to read a segment descriptor=2E
>> >
>> > PTRACE_SET_FS / PTRACE_SET_GS: Sets FS or GS and updates the base
>accordingly=2E
>> >
>> > PTRACE_READ_SEGMENT_BASE: pass in a segment selector, get a base
>out=2E
>> > You would use this to populate the base fields=2E
>> >
>> > or perhaps a ptrace SETREGS variant that tries to preserve the old
>> > base semantics and magically sets the bases to match the selectors
>if
>> > the selectors are nonzero=2E
>> >
>> > Do any of these choices sound preferable to any of you?
>> >
>>
>> My suggestion would be to export the GDT and LDT as a (readonly or
>mostly
>> readonly) regset(s) rather than adding entirely new operations=2E We
>could allow
>> the LDT and the per-thread GDT entries to be written, subject to the
>same
>> limitations as the corresponding system calls=2E
>>
>
>That seems useful, although we'd want to do some extensive
>sanitization of the GDT=2E  But maybe it's obnoxious to ask Kyle and
>Robert to parse the GDT, LDT, and selector just to emulate the
>demented pre-5=2E9 ptrace() behavior=2E
>
>--Andy

We only want to allow the same access that user space gets, that's exactly=
 the sanitization we need=2E
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
