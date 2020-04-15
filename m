Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE076C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:57:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B638920857
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 15:57:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="SQrNtYzd"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2410025AbgDOP55 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 11:57:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2410018AbgDOP5w (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 11:57:52 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60164C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 08:57:52 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id l25so17756112qkk.3
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 08:57:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WoLXatgZ0kPKvWwgaZUiwyS4MRwDs1N6m2LhcTxFUGQ=;
        b=SQrNtYzdaavZZqu7QRnrqy3xpHZx5glGFPc1HQx7XouRdlG+N2ZwzS9JS5rVzBfwik
         rA39ye37SXHeFN61uBMzsBF2h9bkN/b+0u4D7YmPd5GyTL/jEkkZM3Mi1VJD9ir+mmm9
         LDIyOSH5DwP55jcpzdaBPfQbLGjRVO+4JZh+f2VWmBqM972bvvHDrRHZSXnVm2kMH3iL
         8caMOfSX6LaXQvJj6t/z63vQqHgYcAOl139tHv+WqFjOe1Fq6ajli9HMLIO6y7C73mAT
         nrXQVipqt61rZK/quil7c1IXOJ/G277L9NsFK1USg3MiyXZ1Coo1xThqO5nwD5q6QhWq
         efOQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=WoLXatgZ0kPKvWwgaZUiwyS4MRwDs1N6m2LhcTxFUGQ=;
        b=m2X0iWGnIPui4TKZ0dtc2J6Ww92octlG3dp6hbxBIZg4Kq8OfE1sIIIC6WsYgQk0O9
         jU1KPVSnF4+f0i+mJnQrp+LEFJsDhWd/iuy/edNhxYdKcpYEwFUR7Fedt/mZIYJZAhzH
         9BhZksmiF27q8Z0cUkBWRiAvy5G3k+zERfmxezsmk6c3nbtHaUHWWPKgn4jbBI26l0lg
         DVLFWB9s6rvlnCoK+D6nmHxmtb81O5WW7uge5uErke9N/ie0LM4SchRzlMP49RwrQoOw
         I1mnASIA5vnY5k3KenGQfu4aqGAoI1gNWCHLVdAkarG864zVUXnXY+d8GkYT/ZF83+Aq
         3PCA==
X-Gm-Message-State: AGi0Pubrz8m0sXKLHvr8J8Lqvf/M1tfkpeA0fC96y/Zi9/+nn0DXYTiQ
        XEq9daugaLL+G0bhbESSg24TUw==
X-Google-Smtp-Source: APiQypJ6oq8MV9YqaOT9f+ss8UoMahcS/0OQWdCdTdAjBjZMpRAFErRQM3Nm2bXq+GnilmSjKgcwxg==
X-Received: by 2002:a37:7605:: with SMTP id r5mr24570359qkc.345.1586966271450;
        Wed, 15 Apr 2020 08:57:51 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id i4sm12943212qkh.27.2020.04.15.08.57.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Wed, 15 Apr 2020 08:57:50 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Linux-next POWER9 NULL pointer NIP since 1st Apr.
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <06A2EA93-B730-4DB1-819F-D27E7032F0B3@lca.pw>
Date:   Wed, 15 Apr 2020 11:57:50 -0400
Cc:     Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <161662E3-5D9C-4C15-919C-CFEFE4CC35CB@lca.pw>
References: <15AC5B0E-A221-4B8C-9039-FA96B8EF7C88@lca.pw>
 <87eeszlb6u.fsf@mpe.ellerman.id.au>
 <0675B22E-8F32-432C-9378-FDE159DD1729@lca.pw>
 <20200407093054.3eb23e45@gandalf.local.home>
 <EA9F9A54-87BC-477A-BE8A-7D53F80C5223@lca.pw>
 <20200409101413.35d9c72d@gandalf.local.home>
 <06A2EA93-B730-4DB1-819F-D27E7032F0B3@lca.pw>
To:     Michael Ellerman <mpe@ellerman.id.au>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 10, 2020, at 3:20 PM, Qian Cai <cai@lca.pw> wrote:
>=20
>=20
>=20
>> On Apr 9, 2020, at 10:14 AM, Steven Rostedt <rostedt@goodmis.org> =
wrote:
>>=20
>> On Thu, 9 Apr 2020 06:06:35 -0400
>> Qian Cai <cai@lca.pw> wrote:
>>=20
>>>>> I=E2=80=99ll go to bisect some more but it is going to take a =
while.
>>>>>=20
>>>>> $ git log --oneline 4c205c84e249..8e99cf91b99b
>>>>> 8e99cf91b99b tracing: Do not allocate buffer in =
trace_find_next_entry() in atomic
>>>>> 2ab2a0924b99 tracing: Add documentation on set_ftrace_notrace_pid =
and set_event_notrace_pid
>>>>> ebed9628f5c2 selftests/ftrace: Add test to test new =
set_event_notrace_pid file
>>>>> ed8839e072b8 selftests/ftrace: Add test to test new =
set_ftrace_notrace_pid file
>>>>> 276836260301 tracing: Create set_event_notrace_pid to not trace =
tasks =20
>>>>=20
>>>>> b3b1e6ededa4 ftrace: Create set_ftrace_notrace_pid to not trace =
tasks
>>>>> 717e3f5ebc82 ftrace: Make function trace pid filtering a bit more =
exact =20
>>>>=20
>>>> If it is affecting function tracing, it is probably one of the =
above two
>>>> commits. =20
>>>=20
>>> OK, it was narrowed down to one of those messed with mcount here,
>>=20
>> Thing is, nothing here touches mcount.
>=20
> Yes, you are right. I went back to test the commit just before the =
5.7-trace merge request,
> I did reproduce there. The thing is that this bastard could take more =
6-hour to happen,
> so my previous attempt did not wait long enough. Back to the square =
one=E2=80=A6

OK, I starts to test all commits up to 12 hours. The progess on far is,

BAD: v5.6-rc1
GOOD: v5.5
GOOD: 153b5c566d30 Merge tag 'microblaze-v5.6-rc1' of =
git://git.monstr.eu/linux-2.6-microblaze

The next step I=E2=80=99ll be testing,

71c3a888cbca Merge tag 'powerpc-5.6-1' of =
git://git.kernel.org/pub/scm/linux/kernel/git/powerpc/linux

IF that is BAD, the merge request is the culprit. I can see a few =
commits are more related that others.

5290ae2b8e5f powerpc/64: Use {SAVE,REST}_NVGPRS macros
ed0bc98f8cbe powerpc/64s: Reimplement power4_idle code in C

Does it ring any bell yet?


