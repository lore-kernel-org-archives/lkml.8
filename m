Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F6E1C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:59:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4EE82207BC
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 13:59:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=amacapital-net.20150623.gappssmtp.com header.i=@amacapital-net.20150623.gappssmtp.com header.b="sGjiXO6U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726128AbgFAN7c (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 09:59:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725976AbgFAN7c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 09:59:32 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EE610C05BD43
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 06:59:30 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id fs4so5186302pjb.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 06:59:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=amacapital-net.20150623.gappssmtp.com; s=20150623;
        h=content-transfer-encoding:from:mime-version:subject:date:message-id
         :references:cc:in-reply-to:to;
        bh=QsbwnmP5b76zoq82B36wAJL8tN4jBWJXygV+SOZcGsI=;
        b=sGjiXO6UfisdBumTwmLHedPwXnJWMp4WbvELvwzmI2kQSKQtHI3EYpTNz12oY6ePh/
         P5w1llkSBxMm6z1F6to2Lll3/c2bgROSRGnbQc7lGT0fFk+lRG1XIM2duq+fULZs+IVI
         /dVC8asFD+xLm7JzfBwo2APHG287UILgmc5+owWWlqOybhRSg13PZJjnhQlJOimm2Boe
         VwuVc2JTKpdLaWHMPvv0v7EQ/CkqVrW6nkgyPgg9APEmEtmZ9l0Z3W0q/XMXGNt6mCDj
         dnwqT1IvJXPYnwdRCq5bLCsGVakyyQHM1y9KkfERgQFzewv8YD3GZF6VRy99M9WyK1L8
         6mug==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:content-transfer-encoding:from:mime-version
         :subject:date:message-id:references:cc:in-reply-to:to;
        bh=QsbwnmP5b76zoq82B36wAJL8tN4jBWJXygV+SOZcGsI=;
        b=ugPAcBadz4R4qIffgxG9VKPWk6B8jETYLk08r4zk75JFF87RRK4yBGRfT8J6Ofjg4H
         Cx6C0D3UcgjU9rF8KkaskTNQRdmcbzhHawFI0rrrfFMrzSSj5U4bISvgdurpWp7VRslu
         IOTixTpiQFG6AxLK72p89ZLbS6ZMMEgOkVt9ncoWn5iizbI6DPp9Ks73kddUB/zL7T2R
         GZfq57+MuK3uknKLn1tDgODP8pUK6CJGwJloq54KtYU7wZn9aGQDDOkvcnNEjCRLu+l1
         ep66jBQuTTBz5hBS1a+T4k+VbhRJj+6DuDboVCPUsVfYeLclcDOPsCgnBEyqAxqfUPAY
         m4ZQ==
X-Gm-Message-State: AOAM5327OZIVfp1mRW6h5R5Tx0vUiHINmI1LS+xbjQMQar8k2vtVxbos
        zEnth5fMaOCxllbpvgSUJDb1cw==
X-Google-Smtp-Source: ABdhPJyKhj14bKPCpUybVRKKj5vDhDqcVqT/7L+WV/P2p5VksBGMwu4fq2M7tBpovJ9UP3KuwTeHkQ==
X-Received: by 2002:a17:90b:78b:: with SMTP id l11mr22434967pjz.97.1591019970325;
        Mon, 01 Jun 2020 06:59:30 -0700 (PDT)
Received: from ?IPv6:2601:646:c200:1ef2:1d33:1e7d:661b:bcd4? ([2601:646:c200:1ef2:1d33:1e7d:661b:bcd4])
        by smtp.gmail.com with ESMTPSA id m3sm8062035pjs.17.2020.06.01.06.59.29
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 01 Jun 2020 06:59:29 -0700 (PDT)
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: quoted-printable
From:   Andy Lutomirski <luto@amacapital.net>
Mime-Version: 1.0 (1.0)
Subject: Re: [PATCH RFC] seccomp: Implement syscall isolation based on memory areas
Date:   Mon, 1 Jun 2020 06:59:26 -0700
Message-Id: <3691744C-F4BC-49C6-9450-52E31DD14A92@amacapital.net>
References: <CAFUUQHO57YpWJv6oGmxXsOBxCzRG1ti_Q1QBDw8FU+4vBOPgBw@mail.gmail.com>
Cc:     krisman@collabora.com, gofmanp@gmail.com, hpa@zytor.com,
        keescook@chromium.org, kernel@collabora.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        tglx@linutronix.de, wad@chromium.org
In-Reply-To: <CAFUUQHO57YpWJv6oGmxXsOBxCzRG1ti_Q1QBDw8FU+4vBOPgBw@mail.gmail.com>
To:     Billy Laws <blaws05@gmail.com>
X-Mailer: iPhone Mail (17E262)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Jun 1, 2020, at 2:23 AM, Billy Laws <blaws05@gmail.com> wrote:
>=20
> =EF=BB=BF
>>=20
>> On May 30, 2020, at 5:26 PM, Gabriel Krisman Bertazi <krisman@collabora.c=
om> wrote:
>>=20
>> =EF=BB=BFAndy Lutomirski <luto@amacapital.net> writes:
>>=20
>>>>>> On May 29, 2020, at 11:00 PM, Gabriel Krisman Bertazi <krisman@collab=
ora.com> wrote:
>>>>>=20
>>>>> =EF=BB=BFModern Windows applications are executing system call instruc=
tions
>>>>> directly from the application's code without going through the WinAPI.=

>>>>> This breaks Wine emulation, because it doesn't have a chance to
>>>>> intercept and emulate these syscalls before they are submitted to Linu=
x.
>>>>>=20
>>>>> In addition, we cannot simply trap every system call of the applicatio=
n
>>>>> to userspace using PTRACE_SYSEMU, because performance would suffer,
>>>>> since our main use case is to run Windows games over Linux.  Therefore=
,
>>>>> we need some in-kernel filtering to decide whether the syscall was
>>>>> issued by the wine code or by the windows application.
>>>=20
>>> Do you really need in-kernel filtering?  What if you could have
>>> efficient userspace filtering instead?  That is, set something up so
>>> that all syscalls, except those from a special address, are translated
>>> to CALL thunk where the thunk is configured per task.  Then the thunk
>>> can do whatever emulation is needed.
>>=20
>> Hi,
>>=20
>> I suggested something similar to my customer, by using
>> libsyscall-intercept.  The idea would be overwritting the syscall
>> instruction with a call to the entry point.  I'm not a specialist on the
>> specifics of Windows games, (cc'ed Paul Gofman, who can provide more
>> details on that side), but as far as I understand, the reason why that
>> is not feasible is that the anti-cheat protection in games will abort
>> execution if the binary region was modified either on-disk or in-memory.
>>=20
>> Is there some mechanism to do that without modiyfing the application?
>=20
> Hi,
>=20
> I work on an emulator for the Nintendo Switch that uses a similar techniqu=
e,
> in our testing it works very well and is much more performant than even
> PTRACE_SYSEMU.
>=20
> To work around DRM reading the memory contents I think mprotect could
> be used, after patching the syscall a copy of the original code could be
> kept somewhere in memory and the patched region mapped --X.
> With this, any time the DRM attempts to read to the patched region and
> perform integrity checks it will cause a segfault and a branch to the
> signal handler. This handler can then return the contents of the original,=

> unpatched region to satisfy them checks.
>=20
> Are memory contents checked by DRM solutions too often for this to be
> performant?

A bigger issue is that hardware support for =E2=80=94X is quite spotty. Ther=
e is no x86 CPU that can do it cleanly in a bare metal setup, and client CPU=
s that can do it at all without hypervisor help may be nonexistent. I don=E2=
=80=99t know if the ARM situation is much better.

> --
> Billy Laws
>>=20
>>> Getting the details and especially the interaction with any seccomp
>>> filters that may be installed right could be tricky, but the performance=

>>> should be decent, at least on non-PTI systems.
>>>=20
>>> (If we go this route, I suspect that the correct interaction with
>>> seccomp is that this type of redirection takes precedence over seccomp
>>> and seccomp filters are not invoked for redirected syscalls. After all,
>>> a redirected syscall is, functionally, not a syscall at all.)
>>>=20
>>=20
>>=20
>> --
>> Gabriel Krisman Bertazi
