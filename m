Return-Path: <SRS0=n+Ub=5Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 696A4C2BA19
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 23:00:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 393DA206C0
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Apr 2020 23:00:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="E55hQkfn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726830AbgDIXAe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Apr 2020 19:00:34 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:33698 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726722AbgDIXAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Apr 2020 19:00:34 -0400
Received: by mail-qt1-f196.google.com with SMTP id x2so263711qtr.0
        for <linux-kernel@vger.kernel.org>; Thu, 09 Apr 2020 16:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9za1cgL5saDGUL4ncdk/vOmVKH89NTfUqWctXJV+wKg=;
        b=E55hQkfn3hQcBkJrMLs3sEnbbLpotAAeVJqDeDykwBSnbW0eLW6xgjXoIWc2skM5lr
         qGc8uv0RURI88S2jAw6upuDwEtQI09MviDMZR9fIR8NjL8PTWvnrUJOgvGIyLBYS2cR1
         f+NHmTKB9MgRErhKbEdkCHgyJ0gBiVSS1SPM1Xbkrjes67HLpXSIa8Oo1w6rdrjEYUFX
         0Z+NQhrLstrEmFjchg9kT+TcmmUewZIPmh8J79bIN7Pgv/8IH4ZCYBhoTi9o0alszVmm
         LhOgV+yhdrMnO01IN9AJVrQKMs9kQsMDh2WItUR55E3y99PWT7e1YM2WTSQCRP/UOuc7
         4Iow==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=9za1cgL5saDGUL4ncdk/vOmVKH89NTfUqWctXJV+wKg=;
        b=mjV9denXTvavVWgCbtEOYRjdvJfCrUuImq/FbX+gzae+pSDj7TmTsZgjpiCWUs+lNb
         Kx4+MQCGuZiZu/9hu7tHhCrVWejKZUO5XpySdwolk2uKcAwYlse7uB3eECaZrug788kC
         prjVb0VVhn0fkBrusPUYVpoBc1TjXrP6Yh5MX93uXx+Jops6GAQDf8RuETN47L27blfq
         c1xYeBgMHHtIBrqzBJ/JvjueEF2U1AONVeJxT5cCN0Qr2UjE2Qa6fzemndFHJZA3fR+X
         mxe6ahtajLa28ofj8la6N6TG67gusRgSlS+VqRMsATNtTMcdErILxj7S3/YtPpV8nHr/
         bW+w==
X-Gm-Message-State: AGi0PuZyOhym8UCCVTL2edyPuOsqhg+eEy53bOMOkD0+IMMuIDdZEL40
        QX+6Y/QZWQ8TKZ4fIIZJjPpFtA==
X-Google-Smtp-Source: APiQypJdEEO70ZVe9KDCzZVVqzsacezTot/Ht3b6zFQgwbRkUwZNwI5Z7LJvvFZfXqg9UKnMME8f3g==
X-Received: by 2002:ac8:7286:: with SMTP id v6mr1775597qto.299.1586473233327;
        Thu, 09 Apr 2020 16:00:33 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id 69sm226385qki.131.2020.04.09.16.00.32
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Thu, 09 Apr 2020 16:00:32 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: KCSAN + KVM = host reset
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <B5F0F530-911E-4B75-886A-9D8C54FF49C8@lca.pw>
Date:   Thu, 9 Apr 2020 19:00:31 -0400
Cc:     Paolo Bonzini <pbonzini@redhat.com>,
        "paul E. McKenney" <paulmck@kernel.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>, kvm@vger.kernel.org
Content-Transfer-Encoding: quoted-printable
Message-Id: <DF45D739-59F3-407C-BE8C-2B1E164B493B@lca.pw>
References: <E180B225-BF1E-4153-B399-1DBF8C577A82@lca.pw>
 <fb39d3d2-063e-b828-af1c-01f91d9be31c@redhat.com>
 <017E692B-4791-46AD-B9ED-25B887ECB56B@lca.pw>
 <CANpmjNMiHNVh3BVxZUqNo4jW3DPjoQPrn-KEmAJRtSYORuryEA@mail.gmail.com>
 <B7F7F73E-EE27-48F4-A5D0-EBB29292913E@lca.pw>
 <CANpmjNMEgc=+bLU472jy37hYPYo5_c+Kbyti8-mubPsEGBrm3A@mail.gmail.com>
 <2730C0CC-B8B5-4A65-A4ED-9DFAAE158AA6@lca.pw>
 <CANpmjNNUn9_Q30CSeqbU_TNvaYrMqwXkKCA23xO4ZLr2zO0w9Q@mail.gmail.com>
 <B5F0F530-911E-4B75-886A-9D8C54FF49C8@lca.pw>
To:     Marco Elver <elver@google.com>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 9, 2020, at 5:28 PM, Qian Cai <cai@lca.pw> wrote:
>=20
>=20
>=20
>> On Apr 9, 2020, at 12:03 PM, Marco Elver <elver@google.com> wrote:
>>=20
>> On Thu, 9 Apr 2020 at 17:30, Qian Cai <cai@lca.pw> wrote:
>>>=20
>>>=20
>>>=20
>>>> On Apr 9, 2020, at 11:22 AM, Marco Elver <elver@google.com> wrote:
>>>>=20
>>>> On Thu, 9 Apr 2020 at 17:10, Qian Cai <cai@lca.pw> wrote:
>>>>>=20
>>>>>=20
>>>>>=20
>>>>>> On Apr 9, 2020, at 3:03 AM, Marco Elver <elver@google.com> wrote:
>>>>>>=20
>>>>>> On Wed, 8 Apr 2020 at 23:29, Qian Cai <cai@lca.pw> wrote:
>>>>>>>=20
>>>>>>>=20
>>>>>>>=20
>>>>>>>> On Apr 8, 2020, at 5:25 PM, Paolo Bonzini <pbonzini@redhat.com> =
wrote:
>>>>>>>>=20
>>>>>>>> On 08/04/20 22:59, Qian Cai wrote:
>>>>>>>>> Running a simple thing on this AMD host would trigger a reset =
right away.
>>>>>>>>> Unselect KCSAN kconfig makes everything work fine (the host =
would also
>>>>>>>>> reset If only "echo off > /sys/kernel/debug/kcsan=E2=80=9D =
before running qemu-kvm).
>>>>>>>>=20
>>>>>>>> Is this a regression or something you've just started to play =
with?  (If
>>>>>>>> anything, the assembly language conversion of the AMD world =
switch that
>>>>>>>> is in linux-next could have reduced the likelihood of such a =
failure,
>>>>>>>> not increased it).
>>>>>>>=20
>>>>>>> I don=E2=80=99t remember I had tried this combination before, so =
don=E2=80=99t know if it is a
>>>>>>> regression or not.
>>>>>>=20
>>>>>> What happens with KASAN? My guess is that, since it also happens =
with
>>>>>> "off", something that should not be instrumented is being
>>>>>> instrumented.
>>>>>=20
>>>>> No, KASAN + KVM works fine.
>>>>>=20
>>>>>>=20
>>>>>> What happens if you put a 'KCSAN_SANITIZE :=3D n' into
>>>>>> arch/x86/kvm/Makefile? Since it's hard for me to reproduce on =
this
>>>>>=20
>>>>> Yes, that works, but this below alone does not work,
>>>>>=20
>>>>> KCSAN_SANITIZE_kvm-amd.o :=3D n
>>>>=20
>>>> There are some other files as well, that you could try until you =
hit
>>>> the right one.
>>>>=20
>>>> But since this is in arch, 'KCSAN_SANITIZE :=3D n' wouldn't be too =
bad
>>>> for now. If you can't narrow it down further, do you want to send a
>>>> patch?
>>>=20
>>> No, that would be pretty bad because it will disable KCSAN for Intel
>>> KVM as well which is working perfectly fine right now. It is only =
AMD
>>> is broken.
>>=20
>> Interesting. Unfortunately I don't have access to an AMD machine =
right now.
>>=20
>> Actually I think it should be:
>>=20
>> KCSAN_SANITIZE_svm.o :=3D n
>> KCSAN_SANITIZE_pmu_amd.o :=3D n
>>=20
>> If you want to disable KCSAN for kvm-amd.
>=20
> KCSAN_SANITIZE_svm.o :=3D n
>=20
> That alone works fine. I am wondering which functions there could =
trigger
> perhaps some kind of recursing with KCSAN?

Another data point is set CONFIG_KCSAN_INTERRUPT_WATCHER=3Dn alone
also fixed the issue. I saw quite a few interrupt related function in =
svm.c, so
some interrupt-related recursion going on?=
