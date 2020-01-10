Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88F33C33CA2
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:11:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 64E982077C
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 10:11:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727505AbgAJKLc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 05:11:32 -0500
Received: from mout.kundenserver.de ([212.227.126.130]:34649 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727315AbgAJKLc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 05:11:32 -0500
Received: from mail-qk1-f177.google.com ([209.85.222.177]) by
 mrelayeu.kundenserver.de (mreue010 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MeTkC-1jQHwc09p6-00aWkA; Fri, 10 Jan 2020 11:11:30 +0100
Received: by mail-qk1-f177.google.com with SMTP id k6so1310739qki.5;
        Fri, 10 Jan 2020 02:11:29 -0800 (PST)
X-Gm-Message-State: APjAAAUcXTz38EMlAxZzjZ+c0wegO1ZgZlxF5d+Skd/hiyP4FM7b193O
        C8nDbPFB18Ch6hD+ihKSMXG8yVPjvmEQIfV6cqw=
X-Google-Smtp-Source: APXvYqwQM3u/t39836dMD5tec9MQOJzMnWCL5+9yluxP60faDML2Mp4XZBlYFezwhUfGXcM6HBdbevOedqsVbMM2WcU=
X-Received: by 2002:a37:a8d4:: with SMTP id r203mr2305654qke.394.1578651088855;
 Fri, 10 Jan 2020 02:11:28 -0800 (PST)
MIME-Version: 1.0
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Fri, 10 Jan 2020 11:11:12 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1mOzsaD+ZnN+ZKvmcan=K=KbnTjUOe1y8fS8WOMXT+Dw@mail.gmail.com>
Message-ID: <CAK8P3a1mOzsaD+ZnN+ZKvmcan=K=KbnTjUOe1y8fS8WOMXT+Dw@mail.gmail.com>
Subject: [RFC] y2038: HCI_TIME_STAMP with time64
To:     Bluez mailing list <linux-bluetooth@vger.kernel.org>
Cc:     y2038 Mailman List <y2038@lists.linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Marcel Holtmann <marcel@holtmann.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Rich Felker <dalias@libc.org>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:YKg1X780VYvsErUuHmB5nhAY/Nxs0GeHQ/XRc9NBEplCI8QtS1C
 pywtiHr0vv5dxQb5e/ca5zes1KRMRk3UEoBAy5vY+rs05lV21NNzcXaHWSzuVkX+FuqZP1H
 9ReocYi9GGBxF2HobAfWQPVQVXS5gOWD/pe2mJJZ1xJBCqZdKHgz/kT2pR1peM6uE6aFOwJ
 pV1oS8kFlU5CwUk5kSGTQ==
X-UI-Out-Filterresults: notjunk:1;V03:K0:/DuaXvnNmp0=:FvmyYGGI4ra0R5nxHYg3V0
 RMe/ClISMbiyjrYbku3BUpF2Vz9BmLOO2E25yHum7F9obN9jqJVLtzHRH+UxS8O4tdnw+2ae5
 VX5To2lzVc32S/94yWbGkhmii9hRoJ2BFPlIdeDKX4Woqk7Owlznk5dX8HDHWg7qeDhkcBAF+
 bUEUmHuzRxgYs5P8oDN0qZF+s5MWEFSfyHpnqgzirmAXZCt17zEjRV/Or8DXBnPnGH4fgpnSc
 MluftaJIMXodzrkbIvwDfxED0oN8JycWaNSkGdux83F4Hvz8X6od40qU9G1xSgNPgejuwxxU7
 I3E84MGYLAHc4jcA2SEMfZA3vWBGOiHzCwTN5nJ7l5o/VtzACm1wBjexi2ymUigD9y/kk3Bh+
 od704TPEV16BKm9Dpkes8UDCL81O0rzt0hflNZ3VeGIyqjPPcWUN6yN7oYef1Qr0xhKeP7FaZ
 LfXlqtR4apfYFWRRZwD73yoQnPbLQemHZRj6lUIa/dMNLbmc21Y4uuU0O5MDtRHVYS2BW66Li
 jpsZvBhzIrytQW5BZ7lQZOcLYGO+Bk+rK+MYgRjKLivq+E2UwK+wCDypmVD64tHdZhL5E0NFK
 wzM9dcLBQT3mRaqeRDt4Y01CMhSwkoX1nhxm4eZdKcKgUkG5WDXcyZLD/xy2nahUEo2txYIDJ
 g3zzmjmkzNgP1Io8tg/Z5ibq+RGvl5v4EYweMMBq4DGRpPaVgXpNzvnWbJIoHBmFg6j2loDMW
 EzDmvA5BWXAHSF89RFOF/DpwwIPop3/TGJqkcB+N4AgDrO5TxbQ/bXOorEPz1R0QAioQ6lGV+
 EGT2UHo+iuN45seGdJkCHq8nrrOECspO/CJZqBbgaGu140l6BNxr4oJtxM+MluzeHDK0XCP81
 RU2Z+gBW99HGMmJXSUEg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I noticed earlier this week that the HCI_CMSG_TSTAMP/HCI_TIME_STAMP
interface has no time64 equivalent, as we apparently missed that when
converting the normal socket timestamps to support both time32 and time64
variants of the sockopt and cmsg data.

The interface was originally added back in 2002 by Maksim Krasnyanskiy
when bluetooth support first became non-experimental.

When using HCI_TIME_STAMP on a 32-bit system with a time64
libc, users will interpret the { s32 tv_sec; s32 tv_usec } layout of
the kernel as { s64 tv_sec; ... }, which puts complete garbage
into the timestamp regardless of whether this code runs before or
after y2038. From looking at codesearch.debian.org, I found two
users of this: libpcap and hcidump. There are probably others that
are not part of Debian.

Fixing this the same was as normal socket timestamps is not possible
because include/net/bluetooth/hci.h is not an exported UAPI header.
This means any changes to it for defining HCI_TIME_STAMP conditionally
would be ignored by applications that use a different copy of the
header.

I can see three possible ways forward:

1. move include/net/bluetooth/hci.h to include/uapi/, add a conditional
   definition of HCI_TIME_STAMP and make the kernel code support
   both formats. Then change applications to rely on that version of
   header file to get the correct definition but not change application code.

2. Leave the kernel completely unchanged and modify only the users
    to not expect the output to be a 'struct timeval' but interpret as
    as { uint32_t tv_sec; int32_t tv_usec; } structure on 32-bit architectures,
    which will work until the unsigned time overflows 86 years from now
    in 2106 (same as the libpcap on-disk format).

3. Add support for the normal SO_TIMESTAMPNS_NEW sockopt in
   HCI, providing timestamps in the unambiguous { long long tv_sec;
   long long tv_nsec; } format to user space, and change applications
   to use that if supported by the kernel.

      Arnd
