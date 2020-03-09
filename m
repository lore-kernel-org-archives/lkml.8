Return-Path: <SRS0=fsZL=42=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88D3DC10F27
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:05:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 673C620409
	for <linux-kernel@archiver.kernel.org>; Mon,  9 Mar 2020 13:05:55 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726512AbgCINFx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 9 Mar 2020 09:05:53 -0400
Received: from mout.kundenserver.de ([212.227.126.134]:42623 "EHLO
        mout.kundenserver.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725956AbgCINFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 Mar 2020 09:05:53 -0400
Received: from mail-qk1-f182.google.com ([209.85.222.182]) by
 mrelayeu.kundenserver.de (mreue012 [212.227.15.129]) with ESMTPSA (Nemesis)
 id 1MRVy9-1ixJUY13Q5-00NSSj for <linux-kernel@vger.kernel.org>; Mon, 09 Mar
 2020 14:05:51 +0100
Received: by mail-qk1-f182.google.com with SMTP id c145so3271186qke.12
        for <linux-kernel@vger.kernel.org>; Mon, 09 Mar 2020 06:05:51 -0700 (PDT)
X-Gm-Message-State: ANhLgQ30hWPltkBf/JKMqcl8sPzwoYniPGsCeGg27imZhUNwDBdHahgv
        0FvoXTLVm0PoEaYPYOxp0elHrC84G1W+eYC9+cs=
X-Google-Smtp-Source: ADFU+vtKzupDHpOeiejLxcFh2ypl0Td2zi1xavQ2PAx24dswZB9rq0oq6sEWdwnizi3Q7uRb9a3xj1ELIIT8TZrqRaY=
X-Received: by 2002:a37:b984:: with SMTP id j126mr14102418qkf.3.1583759150182;
 Mon, 09 Mar 2020 06:05:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200309021747.626-1-zhenzhong.duan@gmail.com> <20200309021747.626-3-zhenzhong.duan@gmail.com>
In-Reply-To: <20200309021747.626-3-zhenzhong.duan@gmail.com>
From:   Arnd Bergmann <arnd@arndb.de>
Date:   Mon, 9 Mar 2020 14:05:32 +0100
X-Gmail-Original-Message-ID: <CAK8P3a1L=ko-SenBq0_nFtpqz1PFiZCsr7tX=9sH01X+J2wZSQ@mail.gmail.com>
Message-ID: <CAK8P3a1L=ko-SenBq0_nFtpqz1PFiZCsr7tX=9sH01X+J2wZSQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/3] misc: move FLASH_MINOR into miscdevice.h and fix conflicts
To:     Zhenzhong Duan <zhenzhong.duan@gmail.com>
Cc:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jeff Dike <jdike@addtoit.com>,
        Richard Weinberger <richard@nod.at>,
        Anton Ivanov <anton.ivanov@cambridgegreys.com>,
        Miguel Ojeda Sandonis <miguel.ojeda.sandonis@gmail.com>,
        Willy Tarreau <willy@haproxy.com>,
        Ksenija Stanojevic <ksenija.stanojevic@gmail.com>,
        gregkh <gregkh@linuxfoundation.org>,
        Matt Mackall <mpm@selenic.com>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        jonathan@buzzard.org.uk,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        David Miller <davem@davemloft.net>,
        Bartlomiej Zolnierkiewicz <b.zolnierkie@samsung.com>,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>,
        Pavel Machek <pavel@ucw.cz>, Len Brown <len.brown@intel.com>,
        Russell King <linux@armlinux.org.uk>
Content-Type: text/plain; charset="UTF-8"
X-Provags-ID: V03:K1:5oUyQq4QGXxHLknlf/mvjL5SrKY3VM+Zeixn1MOogqfxwaNo+/5
 JvynEShxlLH0F7tuS+BFb2CfGmTgsl/M6m9p7uqgclxL9Qs1/F3oA/xsQhYTmrV4ztOVr7p
 +ETze/wPhnG6xcBxFDoZl7ehvcKpw9Rqie4KeqS6yB9HqaCc1V1g6gL8ggdPsv+I8ERqb1f
 MwLExDZ6jjigIWtwJ/t0Q==
X-UI-Out-Filterresults: notjunk:1;V03:K0:XFB/xOTdfmk=:/FfJgJ+ccl0I4KDNY0OICn
 DjAccIup4WTt/IaKJAXjSis8eU678qMYeAW2gaICDK9b/wC+9qqRGvIeo5qZxNPE7VbG3dhSc
 60zEtcq55cNYiIFH8M16/v2OQx9VIFT1bKl9X+NE6GnxdDJizn26Ua4r1KZA0Wf86vOznSELZ
 TLZivWtgBKsXXdru4bs+/qWLdm77GS1I6JoTgoI26kRQUau4YE+tqlYWfd+iWqdaGK2tRex59
 Tb5pxYUbM0PVHkI2t7VPOgqbBNzRww8KvAA9cz01KP2Km05p9CK6TPLADLc0YzNg0pMlw0nNA
 1fAD9W6W87vh6s4mshpgXmocCSjWhfYeTqf1UvJd5K8lscXVwu/3KAGajBmwpHcLsBSAYeTEj
 BXsnU4jEnARlioomQv175sjzzOlNY8sia4Z4B9FWJ7n8vY1es53DmOCIXUatSRBzax5W9OfMC
 GqOcYV5HJMBuXiXPGuxKATMv98cfFSyt7AdgfRO184XJ8uLoMWXCZ2xILBVHj895gdNZzMMpR
 HxbHKCfBqlxgKrMBxYjWBR6dSHotErdcZK5Q//RqKzlM/5uib4F12W+ysSoyrwX+UG07vZxga
 QW214vwwYq86W/sKi+Yxpu/y+j3qPRD2ojOLu1PWQ7Ipkmabq4JRu10ibOhPh5rvfoHF+5MTB
 AaB4LM5DS+6g13b3mxyIfYeZwzmnDezdHdrVXMOF4xHv8k0UhIjAmWspi7muElMnK5YaNRvQE
 Su+EvHAMyFeU0kIQHj3c6HS7pXESmSyUhuRR9ptr8jMRzhxxqGB861qfGae1gMTyySsDJUYS6
 3wry44pZEsVe0Rl+5KAu6atu1b7MUPYMMuB6bt52+2OLkgkuKY=
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 9, 2020 at 3:18 AM Zhenzhong Duan <zhenzhong.duan@gmail.com> wrote:
>
> FLASH_MINOR is used in both drivers/char/nwflash.c and
> drivers/sbus/char/flash.c with conflict minor numbers.
>
> Move all the definitions of FLASH_MINOR into miscdevice.h.
> Rename FLASH_MINOR for drivers/char/nwflash.c to NWFLASH_MINOR
> and FLASH_MINOR for drivers/sbus/char/flash.c to SBUS_FLASH_MINOR.
>
> Link: https://lore.kernel.org/lkml/20200120221323.GJ15860@mit.edu/t/
> Suggested-by: Arnd Bergmann <arnd@arndb.de>
> Signed-off-by: Zhenzhong Duan <zhenzhong.duan@gmail.com>
> Cc: Arnd Bergmann <arnd@arndb.de>
> Cc: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> Cc: Russell King <linux@armlinux.org.uk>
> Cc: "David S. Miller" <davem@davemloft.net>

Acked-by: Arnd Bergmann <arnd@arndb.de>
