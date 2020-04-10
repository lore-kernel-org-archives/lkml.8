Return-Path: <SRS0=VV4q=52=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 65D31C2D0EC
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:20:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 307AE20732
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Apr 2020 19:20:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Aouysy5T"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726740AbgDJTUy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Apr 2020 15:20:54 -0400
Received: from mail-qt1-f196.google.com ([209.85.160.196]:34345 "EHLO
        mail-qt1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726582AbgDJTUy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Apr 2020 15:20:54 -0400
Received: by mail-qt1-f196.google.com with SMTP id 14so2294532qtp.1
        for <linux-kernel@vger.kernel.org>; Fri, 10 Apr 2020 12:20:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=16bINEUNdNhK+AwM3+iDZL0tGkjvgNJMmBbTUZOzPIA=;
        b=Aouysy5TDHorqU4e9b8RTjHwsvi8y1PrgQM4zLBGJhptnIAu3k2eNyQssH3U9Nq7ta
         zGH07GYvg0yX3cDKOpiI6ZYRp9KP1mUUDytc0ubP8ZnLxi0EzauRDdVqcIDAnUxrz7km
         Mf6AMHDqiizq7CFxRmhAY+vC2XRXh821PByishLyahyIBFHIhuFjJhYKKcHHWRf79k/6
         +0mhKtev6/LNteALWWr9URXva6DMWAbnPsRa+4nZutDzKcpMoqBpF28DsfOFBxD+57U0
         qmNZwyThqHjT1j2IcG3gxwrnpDk7O2LuBQuT34Fb9TSDxRdmca9iOHAtdKtFaO+NWbpe
         5Nkg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=16bINEUNdNhK+AwM3+iDZL0tGkjvgNJMmBbTUZOzPIA=;
        b=X3kxElWTD9+qRgOkohL/BVzCf8W+eS0MfCeRXm3cVJczcyGxzByqyuyWE+U6vGwDcy
         2i1Ds12wbTStZmqlDAxxZzZomd+7//4jCNjZqDKGnUh70wuFddIAvFsfG31TMjygsEAc
         yx4+mF4Ev9EQwx1yAI9ExHYetxvcWGGdUrmd50tRYY+XiFYf+YQGDp+ETOfFKPZFhnPx
         eFWDmZy8dNl1ODsXkSuaeJtGsFrdNs4hLgvsdiLxgxeoIEGap3U4ZsQNeIB1e7A/p2PX
         ChwGW5zGzPkEvwmAJlbYlrNumIc1yUkCA/hyMq5eQD1mowGFY1LGA4p1aGaQ/fMcWYuq
         jDig==
X-Gm-Message-State: AGi0PuYfOjO+lMjKr/sOZ+R3x/HxM9niiHDCL/Op/456pthOF+Kgxgpn
        KOlT6KpwiiFfYx/AyzDkPwZpQg==
X-Google-Smtp-Source: APiQypJL2bIZS0O4AtwrP4A7fATr71ZDj8B7mjOr0/Tb4V1fxik9NY2b8ZbSyeaBCnRwfVLnCCLpIg==
X-Received: by 2002:ac8:303a:: with SMTP id f55mr692753qte.270.1586546451761;
        Fri, 10 Apr 2020 12:20:51 -0700 (PDT)
Received: from [192.168.1.153] (pool-71-184-117-43.bstnma.fios.verizon.net. [71.184.117.43])
        by smtp.gmail.com with ESMTPSA id a136sm2281799qkb.15.2020.04.10.12.20.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 10 Apr 2020 12:20:51 -0700 (PDT)
Content-Type: text/plain;
        charset=utf-8
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Linux-next POWER9 NULL pointer NIP since 1st Apr.
From:   Qian Cai <cai@lca.pw>
In-Reply-To: <20200409101413.35d9c72d@gandalf.local.home>
Date:   Fri, 10 Apr 2020 15:20:49 -0400
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Nicholas Piggin <npiggin@gmail.com>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Transfer-Encoding: quoted-printable
Message-Id: <06A2EA93-B730-4DB1-819F-D27E7032F0B3@lca.pw>
References: <15AC5B0E-A221-4B8C-9039-FA96B8EF7C88@lca.pw>
 <87eeszlb6u.fsf@mpe.ellerman.id.au>
 <0675B22E-8F32-432C-9378-FDE159DD1729@lca.pw>
 <20200407093054.3eb23e45@gandalf.local.home>
 <EA9F9A54-87BC-477A-BE8A-7D53F80C5223@lca.pw>
 <20200409101413.35d9c72d@gandalf.local.home>
To:     Steven Rostedt <rostedt@goodmis.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> On Apr 9, 2020, at 10:14 AM, Steven Rostedt <rostedt@goodmis.org> =
wrote:
>=20
> On Thu, 9 Apr 2020 06:06:35 -0400
> Qian Cai <cai@lca.pw> wrote:
>=20
>>>> I=E2=80=99ll go to bisect some more but it is going to take a =
while.
>>>>=20
>>>> $ git log --oneline 4c205c84e249..8e99cf91b99b
>>>> 8e99cf91b99b tracing: Do not allocate buffer in =
trace_find_next_entry() in atomic
>>>> 2ab2a0924b99 tracing: Add documentation on set_ftrace_notrace_pid =
and set_event_notrace_pid
>>>> ebed9628f5c2 selftests/ftrace: Add test to test new =
set_event_notrace_pid file
>>>> ed8839e072b8 selftests/ftrace: Add test to test new =
set_ftrace_notrace_pid file
>>>> 276836260301 tracing: Create set_event_notrace_pid to not trace =
tasks =20
>>>=20
>>>> b3b1e6ededa4 ftrace: Create set_ftrace_notrace_pid to not trace =
tasks
>>>> 717e3f5ebc82 ftrace: Make function trace pid filtering a bit more =
exact =20
>>>=20
>>> If it is affecting function tracing, it is probably one of the above =
two
>>> commits. =20
>>=20
>> OK, it was narrowed down to one of those messed with mcount here,
>=20
> Thing is, nothing here touches mcount.

Yes, you are right. I went back to test the commit just before the =
5.7-trace merge request,
I did reproduce there. The thing is that this bastard could take more =
6-hour to happen,
so my previous attempt did not wait long enough. Back to the square =
one...

>=20
>>=20
>> 8e99cf91b99b tracing: Do not allocate buffer in =
trace_find_next_entry() in atomic
>=20
> Touches reading the trace buffer.
>=20
>> 2ab2a0924b99 tracing: Add documentation on set_ftrace_notrace_pid and =
set_event_notrace_pid
>=20
> Documentation.
>=20
>> 6a13a0d7b4d1 ftrace/kprobe: Show the maxactive number on =
kprobe_events
>=20
> kprobe output.
>=20
>> c9b7a4a72ff6 ring-buffer/tracing: Have iterator acknowledge dropped =
events
>=20
> Reading the buffer.
>=20
>> 06e0a548bad0 tracing: Do not disable tracing when reading the trace =
file
>=20
> Reading the buffer.
>=20
>> 1039221cc278 ring-buffer: Do not disable recording when there is an =
iterator
>=20
> Reading the buffer.
>=20
>> 07b8b10ec94f ring-buffer: Make resize disable per cpu buffer instead =
of total buffer
>=20
> Resizing the buffer.
>=20
>> 153368ce1bd0 ring-buffer: Optimize rb_iter_head_event()
>=20
> Reading the buffer.
>=20
>> ff84c50cfb4b ring-buffer: Do not die if rb_iter_peek() fails more =
than thrice
>=20
> Reading the buffer.
>=20
>> 785888c544e0 ring-buffer: Have rb_iter_head_event() handle concurrent =
writer
>=20
> Reading the buffer.
>=20
>> 28e3fc56a471 ring-buffer: Add page_stamp to iterator for =
synchronization
>=20
> Reading the buffer.
>=20
>> bc1a72afdc4a ring-buffer: Rename ring_buffer_read() to =
read_buffer_iter_advance()
>=20
> Reading the buffer.
>=20
>> ead6ecfddea5 ring-buffer: Have ring_buffer_empty() not depend on =
tracing stopped
>=20
> Reading the buffer.
>=20
>> ff895103a84a tracing: Save off entry when peeking at next entry
>=20
> Reading the buffer.
>=20
>> bf2cbe044da2 tracing: Use address-of operator on section symbols
>=20
> Affects trace_printk()
>=20
>> bbd9d05618a6 gpu/trace: add a gpu total memory usage tracepoint
>=20
> New tracepoint infrastructure (just new trace events for gpu)
>=20
>> 89b74cac7834 tools/bootconfig: Show line and column in parse error
>=20
> Extended command line boot config.
>=20
>> 306b69dce926 bootconfig: Support O=3D<builddir> option
>=20
> Extended command line boot config
>=20
>> 5412e0b763e0 tracing: Remove unused TRACE_BUFFER bits
>=20
> Removed unused enums.
>=20
>> b396bfdebffc tracing: Have hwlat ts be first instance and record =
count of instances
>=20
> Affects only the hard ware latency detector (most likely not even
> configured in the kernel).
>=20
> So I don't understand how any of the above commits can cause a =
problem.
>=20
> -- Steve

