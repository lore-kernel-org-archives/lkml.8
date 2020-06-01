Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 26EEAC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:49:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F22BC206A4
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 17:49:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=zytor.com header.i=@zytor.com header.b="s71ec2kV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727957AbgFARtF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 13:49:05 -0400
Received: from terminus.zytor.com ([198.137.202.136]:46603 "EHLO
        mail.zytor.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726201AbgFARtE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 13:49:04 -0400
Received: from [IPv6:2601:646:8600:3281:e829:29be:a995:f934] ([IPv6:2601:646:8600:3281:e829:29be:a995:f934])
        (authenticated bits=0)
        by mail.zytor.com (8.15.2/8.15.2) with ESMTPSA id 051HmhLE847708
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Mon, 1 Jun 2020 10:48:45 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 051HmhLE847708
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2020052301; t=1591033726;
        bh=fr+l0XoKIlsqLxaqesK1j3eC3xk+9waplQgCOIlQuTc=;
        h=Date:In-Reply-To:References:Subject:To:CC:From:From;
        b=s71ec2kVLNZ+dSNa25KG4sOuAKLvazy/amPQEfMieZGkdCGgsNZ/ASkyu402XDTe/
         DpTWgvm9yEZXtLUUypmJH03G3MTWQ4EiUumVUwNOVNu/EXcD6yYwF4A24AmYaKHLF8
         Zoiyp8svPCw19ad6k088vQGuQQG4+KX6ThKD4GwN1ZfcKuqtlm+kll3EQImHAaUkwd
         plaUubvQj1a48MphU90phImXi9Bl0j5T/ITaZhE6KeiEK72v6aEK75yHFjGOkFmLxW
         ssmSLpqoLNLYlk7qvBcTO4FONnUvq+XRcyH1oeoYDtvJ3CFG6+AfpyiuVhMVxCeHZ6
         xfnHPWzA2BKEQ==
Date:   Mon, 01 Jun 2020 10:48:36 -0700
User-Agent: K-9 Mail for Android
In-Reply-To: <3691744C-F4BC-49C6-9450-52E31DD14A92@amacapital.net>
References: <CAFUUQHO57YpWJv6oGmxXsOBxCzRG1ti_Q1QBDw8FU+4vBOPgBw@mail.gmail.com> <3691744C-F4BC-49C6-9450-52E31DD14A92@amacapital.net>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
Subject: Re: [PATCH RFC] seccomp: Implement syscall isolation based on memory areas
To:     Andy Lutomirski <luto@amacapital.net>,
        Billy Laws <blaws05@gmail.com>
CC:     krisman@collabora.com, gofmanp@gmail.com, keescook@chromium.org,
        kernel@collabora.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, tglx@linutronix.de, wad@chromium.org
From:   hpa@zytor.com
Message-ID: <F854F567-567C-401D-8A80-B25F4F5987C6@zytor.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On June 1, 2020 6:59:26 AM PDT, Andy Lutomirski <luto@amacapital=2Enet> wro=
te:
>
>
>> On Jun 1, 2020, at 2:23 AM, Billy Laws <blaws05@gmail=2Ecom> wrote:
>>=20
>> =EF=BB=BF
>>>=20
>>> On May 30, 2020, at 5:26 PM, Gabriel Krisman Bertazi
><krisman@collabora=2Ecom> wrote:
>>>=20
>>> =EF=BB=BFAndy Lutomirski <luto@amacapital=2Enet> writes:
>>>=20
>>>>>>> On May 29, 2020, at 11:00 PM, Gabriel Krisman Bertazi
><krisman@collabora=2Ecom> wrote:
>>>>>>=20
>>>>>> =EF=BB=BFModern Windows applications are executing system call
>instructions
>>>>>> directly from the application's code without going through the
>WinAPI=2E
>>>>>> This breaks Wine emulation, because it doesn't have a chance to
>>>>>> intercept and emulate these syscalls before they are submitted to
>Linux=2E
>>>>>>=20
>>>>>> In addition, we cannot simply trap every system call of the
>application
>>>>>> to userspace using PTRACE_SYSEMU, because performance would
>suffer,
>>>>>> since our main use case is to run Windows games over Linux=2E=20
>Therefore,
>>>>>> we need some in-kernel filtering to decide whether the syscall
>was
>>>>>> issued by the wine code or by the windows application=2E
>>>>=20
>>>> Do you really need in-kernel filtering?  What if you could have
>>>> efficient userspace filtering instead?  That is, set something up
>so
>>>> that all syscalls, except those from a special address, are
>translated
>>>> to CALL thunk where the thunk is configured per task=2E  Then the
>thunk
>>>> can do whatever emulation is needed=2E
>>>=20
>>> Hi,
>>>=20
>>> I suggested something similar to my customer, by using
>>> libsyscall-intercept=2E  The idea would be overwritting the syscall
>>> instruction with a call to the entry point=2E  I'm not a specialist on
>the
>>> specifics of Windows games, (cc'ed Paul Gofman, who can provide more
>>> details on that side), but as far as I understand, the reason why
>that
>>> is not feasible is that the anti-cheat protection in games will
>abort
>>> execution if the binary region was modified either on-disk or
>in-memory=2E
>>>=20
>>> Is there some mechanism to do that without modiyfing the
>application?
>>=20
>> Hi,
>>=20
>> I work on an emulator for the Nintendo Switch that uses a similar
>technique,
>> in our testing it works very well and is much more performant than
>even
>> PTRACE_SYSEMU=2E
>>=20
>> To work around DRM reading the memory contents I think mprotect could
>> be used, after patching the syscall a copy of the original code could
>be
>> kept somewhere in memory and the patched region mapped --X=2E
>> With this, any time the DRM attempts to read to the patched region
>and
>> perform integrity checks it will cause a segfault and a branch to the
>> signal handler=2E This handler can then return the contents of the
>original,
>> unpatched region to satisfy them checks=2E
>>=20
>> Are memory contents checked by DRM solutions too often for this to be
>> performant?
>
>A bigger issue is that hardware support for =E2=80=94X is quite spotty=2E=
 There
>is no x86 CPU that can do it cleanly in a bare metal setup, and client
>CPUs that can do it at all without hypervisor help may be nonexistent=2E
>I don=E2=80=99t know if the ARM situation is much better=2E
>
>> --
>> Billy Laws
>>>=20
>>>> Getting the details and especially the interaction with any seccomp
>>>> filters that may be installed right could be tricky, but the
>performance
>>>> should be decent, at least on non-PTI systems=2E
>>>>=20
>>>> (If we go this route, I suspect that the correct interaction with
>>>> seccomp is that this type of redirection takes precedence over
>seccomp
>>>> and seccomp filters are not invoked for redirected syscalls=2E After
>all,
>>>> a redirected syscall is, functionally, not a syscall at all=2E)
>>>>=20
>>>=20
>>>=20
>>> --
>>> Gabriel Krisman Bertazi

Running these things in a minimal VM container would allow this kind of fi=
ltering/trapping to be done in the VMM, too=2E I don't know how many layers=
 deep you invoke native Linux libraries, and so if the option would exist t=
o use out-of-range system call numbers for the Linux system numbers?
--=20
Sent from my Android device with K-9 Mail=2E Please excuse my brevity=2E
