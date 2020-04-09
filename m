Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF3A5C2BB86
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:30:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C63B4206E9
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 15:30:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="d5ONUE0g"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgDIPaU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 11:30:20 -0400
Received: from mail-qk1-f193.google.com ([209.85.222.193]:38307 "EHLO
        mail-qk1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728221AbgDIPaT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 11:30:19 -0400
Received: by mail-qk1-f193.google.com with SMTP id h14so4318334qke.5
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 08:30:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KqSuwj1Lnw+46mOu5HvLLZOQhrSTpPUDCk9ASXa3iQI=;
        b=d5ONUE0gQuF4hk3cd/VSQKPVX4IwjmtsLuFUsGMclkB/xhBWg0Pty34wvNvc39ykJY
         EeNCzEYGA7j2gcFtlgPiNjUWg8c6M0knlzWB6nESPIxtc+rgA5b7sSENhNQ6odJr7BZz
         vEJ+caBJy71h0A3ced/bVeO/0yznbAH8hnAIqlR8XB9lGuhcqDF10KXkRO/0HYSlZihc
         ZVaJfb0whw0kt/8yQWVRemzmsgloGMzzFFi0FNeM4wz24m15M+JDmlyhxmZSpwczlwci
         rECKrsLhuRCPExqIiyyikfex584HV2NssvHiAUbdW146oHVg8609ybuqOMJVZfpFSI2x
         8JCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=KqSuwj1Lnw+46mOu5HvLLZOQhrSTpPUDCk9ASXa3iQI=;
        b=XNmyeMh1Ycg169WhJS7fq+WjGWgGbnzZ5WVdZidYNn/rhROKPn8ydG40zUFaBqZ71J
         BUvttGZNRrgMktOK7hzywTLPcDExNdF7TnZCmEitLpApuUHsiYuq2wIEMI5f0wqWnjJJ
         ZATfuxk8rJV/yCFWXpFaqQfhsDiPBBKjOurIStAH7hzLvv+iXvLcpXmgu8Min5X9j2l+
         0oaaDepIOeRj67TsUdgSgNh9vTD+mwe5Bi8vM++TTX9d+f+jDZEhelkkawknloxTBqwX
         LwgqQHA6nZJV9RVI5IQxTSPkx+2TlD6OixhzKqFeG/PzvYlPNYCk8C4R5gFYCV4Qp7BG
         vXLw==
X-Gm-Message-State: AGi0PuaIgj19xeLdbC5kK5zX4Imh/jYmProQGg3fMUxnBp1yIuYZ0RV/
        giQVw/VQbZPL7C7ICC5YX4TXnCCR2bv4eA==
X-Google-Smtp-Source: APiQypJMWSnwBHUdttlGDzAqxcTAqgSmmePEX1OyQXfyS73FbkDipkvmd1HaJVn7qa3wYZyMldtW2Q==
X-Received: by 2002:ae9:e80f:: with SMTP id a15mr352621qkg.367.1586446218111;
        Thu, 09 Apr 2020 08:30:18 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id q5sm11214109qkn.59.2020.04.09.08.30.16
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2020 08:30:17 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: KCSAN + KVM = host reset
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <CANpmjNMEgc=+bLU472jy37hYPYo5_c+Kbyti8-mubPsEGBrm3A@mail.gmail.com>
Date:   Thu, 9 Apr 2020 11:30:14 -0400
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <2730C0CC-B8B5-4A65-A4ED-9DFAAE158AA6@lca.pw>
References: <E180B225-BF1E-4153-B399-1DBF8C577A82@lca.pw>
 <fb39d3d2-063e-b828-af1c-01f91d9be31c@redhat.com>
 <017E692B-4791-46AD-B9ED-25B887ECB56B@lca.pw>
 <CANpmjNMiHNVh3BVxZUqNo4jW3DPjoQPrn-KEmAJRtSYORuryEA@mail.gmail.com>
 <B7F7F73E-EE27-48F4-A5D0-EBB29292913E@lca.pw>
 <CANpmjNMEgc=+bLU472jy37hYPYo5_c+Kbyti8-mubPsEGBrm3A@mail.gmail.com>
To:     Marco Elver <elver@google.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 9, 2020, at 11:22 AM, Marco Elver <elver@google.com> wrote:
>=20
> On Thu, 9 Apr 2020 at 17:10, Qian Cai <cai@lca.pw> wrote:
>>=20
>>=20
>>=20
>>> On Apr 9, 2020, at 3:03 AM, Marco Elver <elver@google.com> wrote:
>>>=20
>>> On Wed, 8 Apr 2020 at 23:29, Qian Cai <cai@lca.pw> wrote:
>>>>=20
>>>>=20
>>>>=20
>>>>> On Apr 8, 2020, at 5:25 PM, Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>>>>>=20
>>>>> On 08/04/20 22:59, Qian Cai wrote:
>>>>>> Running a simple thing on this AMD host would trigger a reset =
right away.
>>>>>> Unselect KCSAN kconfig makes everything work fine (the host would =
also
>>>>>> reset If only "echo off > /sys/kernel/debug/kcsan=E2=80=9D before =
running qemu-kvm).
>>>>>=20
>>>>> Is this a regression or something you've just started to play =
with?  (If
>>>>> anything, the assembly language conversion of the AMD world switch =
that
>>>>> is in linux-next could have reduced the likelihood of such a =
failure,
>>>>> not increased it).
>>>>=20
>>>> I don=E2=80=99t remember I had tried this combination before, so =
don=E2=80=99t know if it is a
>>>> regression or not.
>>>=20
>>> What happens with KASAN? My guess is that, since it also happens =
with
>>> "off", something that should not be instrumented is being
>>> instrumented.
>>=20
>> No, KASAN + KVM works fine.
>>=20
>>>=20
>>> What happens if you put a 'KCSAN_SANITIZE :=3D n' into
>>> arch/x86/kvm/Makefile? Since it's hard for me to reproduce on this
>>=20
>> Yes, that works, but this below alone does not work,
>>=20
>> KCSAN_SANITIZE_kvm-amd.o :=3D n
>=20
> There are some other files as well, that you could try until you hit
> the right one.
>=20
> But since this is in arch, 'KCSAN_SANITIZE :=3D n' wouldn't be too bad
> for now. If you can't narrow it down further, do you want to send a
> patch?

No, that would be pretty bad because it will disable KCSAN for Intel
KVM as well which is working perfectly fine right now. It is only AMD
is broken.

>=20
> Thanks,
> -- Marco
>=20
>> I have been able to reproduce this on a few AMD hosts.
>>=20
>>> exact system, I'd ask you to narrow it down by placing =
'KCSAN_SANITIZE
>>> :=3D n' into suspect subsystems' Makefiles. Once you get it to work =
with
>>> that, we can refine the solution.
>>>=20
>>> Thanks,
>>> -- Marco

