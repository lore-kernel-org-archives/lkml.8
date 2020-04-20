Return-Path: <SRS0=QXtz=6E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BC3AC3815B
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:57:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0906D20857
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Apr 2020 19:57:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726201AbgDTT5a (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 20 Apr 2020 15:57:30 -0400
Received: from mout.kundenserver.de ([212.227.126.133]:36137 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgDTT53 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Apr 2020 15:57:29 -0400
Received: from mail-qt1-f175.google.com ([209.85.160.175]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1Mxpqo-1j1dLV0rXC-00zJFM for <linux-kernel@vger.kernel.org>; Mon, 20 Apr
 2020 21:57:27 +0200
Received: by mail-qt1-f175.google.com with SMTP id 71so9644758qtc.12
        for <linux-kernel@vger.kernel.org>; Mon, 20 Apr 2020 12:57:27 -0700 (PDT)
X-Gm-Message-State: AGi0PubCAdM0dJhwDlzY6aZ9P2TDdut5wI/IZPGjXwVsBrOBZy6/MZmb
        wFWp9Ue7FY0kDKarDUzBmKzkXADxr/2aRK9vwj0=
X-Google-Smtp-Source: APiQypInnw/7oNYx/8ddrJ6wNqe8VjAmS6wcn2pUIGPpe8WVzo1dDQTGa7G0KfTaObn2R3jT+v4Zk6Fys9mI49clMeo=
X-Received: by 2002:ac8:4c8d:: with SMTP id j13mr11333587qtv.142.1587412646124;
 Mon, 20 Apr 2020 12:57:26 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1587401492.git.christophe.leroy@c-s.fr>
In-Reply-To: <cover.1587401492.git.christophe.leroy@c-s.fr>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 20 Apr 2020 21:57:09 +0200
X-Gmail-Original-Message-ID: <CAK8P3a11t=piuDq+TuGMo0xDiN06OLMxsym0PGiWNv5qYSUXLQ@mail.gmail.com>
Message-ID: <CAK8P3a11t=piuDq+TuGMo0xDiN06OLMxsym0PGiWNv5qYSUXLQ@mail.gmail.com>
Subject: Re: [PATCH v7 0/7] powerpc: switch VDSO to C implementation
To:     Christophe Leroy <christophe.leroy@c-s.fr>
Cc:     Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Nathan Lynch <nathanl@linux.ibm.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        Andy Lutomirski <luto@kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:16V4lY66fCNXNqpA8/Sba6SlvQ+9OumNy1LZtgHtYBdzyBJjyYs
 t6DqVnbz9Cp0Mb2Czz10aTMf2VMuFTtYfpuk+c217nmo8N94frakJM7oErgjOYqY9HjhI+S
 rMeXlvQcye/lzpIsr2Tz8yVrMXRdz8M43nfTnbYwWAvrFjai3nFfrU7uPWYEcWZIf2w9k3Q
 PJf7xHBUqTuPwUZDLgI4A==
X-UI-Out-Filterresults: notjunk:1;V03:K0:NfDUN8NIaUU=:a+xo6oUQZUUyOfxX3oifAX
 xq4ff7NAdc6NtgJ2hOist3xlO3IERbQZnOWekCyRthyvo3h+IC52PxEb6L2dNg2VJbVDKr3s5
 xXxpwn1kFXHffbMMMNe603oQH6UAbfo8A7yaFJds67URC31Fjo+uNsI7jT7foyWbdbxO+NO2y
 LLhOipxrgJYTOsf/Z0D+x3khg+/din26Vx+3vRzrVSb4cIsWygpLWIJ3n2N8Rf7bITRMHjNgs
 36O4yjSckgZWnrZReitLtAjHRqy9dhbDLju3n8aca7MmRA70B8z1YA7xXox4ehH1aERut1gDe
 fxwLnqx3DW91O6f5M67tnwUuLmXKZ4+s4j0iama1JwjSuq7zUZllcV54lFQIp30L89deebTzT
 iRPYZ2nVRcEd+NOGwYhVJHgIuLPtwSOI5gFTHdkLN6SCUNJtE4S46fmoKmvpB019dmch5ihjk
 cNCHZ9Icr3+4tsfpekDmoN9+h8BoPhudeWgriJYdIOQaCxjKzTj4e/WYw6rupyRHcFXY+ECc4
 dum70CEWUSPMEqcUbvmtHi3rOln0jQtKPufC9VfmVwMUgDsbeQ6lvdHmZrdXrv8SEFIR1irjm
 6s1xFC1F9x8pJqHeMcc25yPc5+iiodvTPQXd+SnWq3+ReONSsgFgACw+cL8ycjnsozxmxHgAv
 mgPmoHZDRYkt9bZ9upPsGNTrtswDF8v1dAZv8flLlarnz+Qo5+kqHLf+tRTbbBLUHIOGq2Y1q
 y+/Ac9Q7R7QB8abp8k49Ic11D49RwTHHvXNFQntK/SCYX4yl83aoGFo5fcIbo44R4E8noqkPC
 fT8d8Je4Dtlqi55O7sa0EGw8rkYUwihfji+hPLEeqcgAZ+9xe8=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 20, 2020 at 6:56 PM Christophe Leroy
<christophe.leroy@c-s.fr> wrote:
>
> This is the seventh version of a series to switch powerpc VDSO to
> generic C implementation.
>
> Main changes since v6 are:
> - Added -fasynchronous-unwind-tables in CFLAGS
> - Split patch 2 in two parts
> - Split patch 5 (which was patch 4) in two parts
>
> This series applies on today's powerpc/merge branch.
>
> See the last two patches for details on changes and performance.
>
> Christophe Leroy (7):
>   powerpc/vdso64: Switch from __get_datapage() to get_datapage inline
>     macro
>   powerpc/vdso: Remove __kernel_datapage_offset and simplify
>     __get_datapage()
>   powerpc/vdso: Remove unused \tmp param in __get_datapage()
>   powerpc/processor: Move cpu_relax() into asm/vdso/processor.h
>   powerpc/vdso: Prepare for switching VDSO to generic C implementation.
>   powerpc/vdso: Switch VDSO to generic C implementation.

This all looks fine, but I'm a bit puzzled why you don't add a
clock_gettime64() implementation in the same series. Isn't
that the main purpose of doing all that work?

Without it, any 32-bit user space has to go through the system call
for time()/getttimeofday()/clock_gettime() when built with a
modern libc.

         Arnd
