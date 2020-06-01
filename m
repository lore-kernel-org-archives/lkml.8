Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC848C433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:26:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8AA062073B
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 20:26:14 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728167AbgFAU0O (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 16:26:14 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:34471 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726944AbgFAU0N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 16:26:13 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.93)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1jfr0b-0028M4-7d; Mon, 01 Jun 2020 22:26:09 +0200
Received: from webmail1.zedat.fu-berlin.de ([130.133.4.91] helo=webmail.zedat.fu-berlin.de)
          by inpost2.zedat.fu-berlin.de (Exim 4.93)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1jfr0a-000TkQ-S2; Mon, 01 Jun 2020 22:26:09 +0200
Received: from 92.201.26.143
        (ZEDAT-Webmail authenticated user mkarcher)
        by webmail.zedat.fu-berlin.de with HTTP;
        Mon, 1 Jun 2020 22:26:09 +0200
Message-ID: <50235.92.201.26.143.1591043169.webmail@webmail.zedat.fu-berlin.de>
In-Reply-To: <20200601165700.GU1079@brightrain.aerifal.cx>
References: <20200529174540.4189874-1-glaubitz@physik.fu-berlin.de>
    <20200529174540.4189874-2-glaubitz@physik.fu-berlin.de>
    <CAMuHMdWG1wudoBP0EK8FiEj1BMEoL3r5oqJMUEbt2rqRU2gQpw@mail.gmail.com>
    <ba354e30-82ab-68c2-0771-2489463c9279@physik.fu-berlin.de>
    <2ad089c1-75cf-0986-c40f-c7f3f8fd6ead@physik.fu-berlin.de>
    <CAMuHMdXzje-qFH=pGoouSuXTZYf4NvnzbaYxTm_boMek-DbWMg@mail.gmail.com>
    <20200601030300.GT1079@brightrain.aerifal.cx>
    <CAMuHMdUmpLRyYTPO8LPtOyYtraQ77XZqYy9=8cUiWphmpvczmg@mail.gmail.com>
    <fbfca28d-217d-4857-a010-8c6e277db67c@physik.fu-berlin.de>
    <20200601165700.GU1079@brightrain.aerifal.cx>
Date:   Mon, 1 Jun 2020 22:26:09 +0200
Subject: Re: [PATCH] sh: Implement __get_user_u64() required for 64-bit
 get_user()
From:   "Michael Karcher" <michael.karcher@fu-berlin.de>
To:     "Rich Felker" <dalias@libc.org>
Cc:     "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Linux-sh list" <linux-sh@vger.kernel.org>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
        "Michael Karcher" <kernel@mkarcher.dialup.fu-berlin.de>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
User-Agent: ZEDAT-Webmail
MIME-Version: 1.0
Content-Type: text/plain;charset=utf-8
Content-Transfer-Encoding: 8bit
X-Originating-IP: 130.133.4.91
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Rich Felker schrieb:
>> >> Can I propose a different solution? For archs where there isn't
>> >> actually any 64-bit load or store instruction, does it make sense to
>> >> be writing asm just to do two 32-bit loads/stores, especially when
>> >> this code is not in a hot path?
>> > Yes, that's an option, too.
>> That's the solution that Michael Karcher suggested to me as an
>> alternative when I talked to him off-list.

There is a functional argument agains using get_user_32 twice, which I
overlooked in my private reply to Adrian. If any of the loads fail, we do
not only want err to be set to -EFAULT (which will happen), but we also
want a 64-bit zero as result. If one 32-bit read faults, but the other one
works, we would get -EFAULT together with 32 valid data bits, and 32 zero
bits.

I continue to elaborate on my performance remark, ignoring this functional
difference (which is a good reason to not just use two 32-bit accesses,
much more so than the performance "issue").

> I don't have an objection to doing it the way you've proposed, but I
> don't think there's any performance distinction or issue with the two
> invocations.

Assuming we don't need two exception table entries (put_user_64 currently
uses only one, maybe it's wrong), using put_user_32 twice creates an extra
unneeded exception table entry, which will "bloat" the exception table.
That table is most likely accessed by a binary search algorithm, so the
performance loss is marginal, though. Also a bigger table size is
cache-unfriendly. (Again, this is likely marginal again, as binary search
is already extremely cache-unfriendly).

A similar argument can be made for the exception handler. Even if we need
two entries in the exception table, so the first paragraph does not apply,
the two entries in the exception table can share the same exception
handler (clear the whole 64-bit destination to zero, set -EFAULT, jump
past both load instructions), so that part of (admittedly cold) kernel
code can get some instructios shorter.


Regards,
  Michael Karcher

