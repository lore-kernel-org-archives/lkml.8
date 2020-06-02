Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79DE6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 10:19:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 623702072F
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 10:19:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgFBKTj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 06:19:39 -0400
Received: from outpost1.zedat.fu-berlin.de ([130.133.4.66]:51247 "EHLO
        outpost1.zedat.fu-berlin.de" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726217AbgFBKTN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 06:19:13 -0400
Received: from inpost2.zedat.fu-berlin.de ([130.133.4.69])
          by outpost.zedat.fu-berlin.de (Exim 4.93)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1jg40h-001feJ-SA; Tue, 02 Jun 2020 12:19:07 +0200
Received: from webmail1.zedat.fu-berlin.de ([130.133.4.91] helo=webmail.zedat.fu-berlin.de)
          by inpost2.zedat.fu-berlin.de (Exim 4.93)
          with esmtps (TLS1.2)
          tls TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256
          (envelope-from <mkarcher@zedat.fu-berlin.de>)
          id 1jg40h-002YxY-Cn; Tue, 02 Jun 2020 12:19:07 +0200
Received: from 92.196.166.68
        (ZEDAT-Webmail authenticated user mkarcher)
        by webmail.zedat.fu-berlin.de with HTTP;
        Tue, 2 Jun 2020 12:19:07 +0200
Message-ID: <52568.92.196.166.68.1591093147.webmail@webmail.zedat.fu-berlin.de>
In-Reply-To: <20200601205029.GW1079@brightrain.aerifal.cx>
References: <20200529174540.4189874-2-glaubitz@physik.fu-berlin.de>
    <CAMuHMdWG1wudoBP0EK8FiEj1BMEoL3r5oqJMUEbt2rqRU2gQpw@mail.gmail.com>
    <ba354e30-82ab-68c2-0771-2489463c9279@physik.fu-berlin.de>
    <2ad089c1-75cf-0986-c40f-c7f3f8fd6ead@physik.fu-berlin.de>
    <CAMuHMdXzje-qFH=pGoouSuXTZYf4NvnzbaYxTm_boMek-DbWMg@mail.gmail.com>
    <20200601030300.GT1079@brightrain.aerifal.cx>
    <CAMuHMdUmpLRyYTPO8LPtOyYtraQ77XZqYy9=8cUiWphmpvczmg@mail.gmail.com>
    <fbfca28d-217d-4857-a010-8c6e277db67c@physik.fu-berlin.de>
    <20200601165700.GU1079@brightrain.aerifal.cx>
    <50235.92.201.26.143.1591043169.webmail@webmail.zedat.fu-berlin.de>
    <20200601205029.GW1079@brightrain.aerifal.cx>
Date:   Tue, 2 Jun 2020 12:19:07 +0200
Subject: Re: [PATCH] sh: Implement __get_user_u64() required for 64-bit
 get_user()
From:   "Michael Karcher" <michael.karcher@fu-berlin.de>
To:     "Rich Felker" <dalias@libc.org>
Cc:     "Michael Karcher" <michael.karcher@fu-berlin.de>,
        "John Paul Adrian Glaubitz" <glaubitz@physik.fu-berlin.de>,
        "Geert Uytterhoeven" <geert@linux-m68k.org>,
        "Linux-sh list" <linux-sh@vger.kernel.org>,
        "Yoshinori Sato" <ysato@users.sourceforge.jp>,
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
>> There is a functional argument agains using get_user_32 twice, which I
>> overlooked in my private reply to Adrian. If any of the loads fail, we
>> do not only want err to be set to -EFAULT (which will happen), but we
>> also want a 64-bit zero as result. If one 32-bit read faults, but the
>> other one works, we would get -EFAULT together with 32 valid data bits,
>> and 32 zero bits.
> Indeed, if you do it that way you want to check the return value and
> set the value to 0 if either faults.

Indeed. And if you do *that*, the performance of the hot path is affected
by the extra check. The performance discussion below only applied to the
cold path, so it seems perfectly valid to disregard it in favore of better
maintainability. On the other hand, checking the return value has a
possibly more serious performance and size (and if you like at the
I-Cache, size means performance) impact. When discussing size impact,
we should keep in mind that put_user for fixed size is supposed to be
inlined, so it's not a one-time cost, but a cost per call. On the other
hand, though, put_user for 64-bit values on SH4 seems to be nearly never
called, so the impact is still most likely negligible.

> BTW I'm not sure what's supposed to happen on write if half faults
> after the other half already succeeded... Either a C approach or an
> asm approach has to consider that.
That's an interesting question. From a kernel developer's point of view,
it seems like a valid view to say: "If userspace provides a bad pointer
where the kernel has to put the data, it's a problem of userspace. The
kernel only needs to tell userspace that the write is incomplete." This
is different to the defensive approach used when reading from user space
into kernel space. Here forcing the whole 64 bit to be zero makes the
kernel itself more robust by removing strange corner cases.

> Indeed. I don't think it's a significant difference but if kernel
> folks do that's fine. In cases like this my personal preference is to
> err on the side of less arch-specific asm.
This is a good idea to reduce maintainance cost. I agree it's up to the
kernel folks to decide whether:
 - Half-zeroed reads of partially faulted 64-bit-reads are acceptable
 - Cold error checks in the hot path to ensure full zeroing is acceptable
 - maintainance of arch-specific asm on many 32-bit architectures is
acceptable.

I don't want to endorse one of these three options, as I am out of the loop
regarding kernel development priorities and philosophy, I just intend to
point out the different options the kernel has to pick the one that fits
best.

Regards,
  Michael Karcher

