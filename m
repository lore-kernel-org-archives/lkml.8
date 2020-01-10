Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4FB78C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:44:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C7D420721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 15:44:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728410AbgAJPo5 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 10:44:57 -0500
Received: from coyote.holtmann.net ([212.227.132.17]:56794 "EHLO
        mail.holtmann.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728245AbgAJPo5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 10:44:57 -0500
Received: from marcel-macpro.fritz.box (p4FEFC5A7.dip0.t-ipconnect.de [79.239.197.167])
        by mail.holtmann.org (Postfix) with ESMTPSA id 364B6CED16;
        Fri, 10 Jan 2020 16:54:12 +0100 (CET)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [RFC] y2038: HCI_TIME_STAMP with time64
From:   Marcel Holtmann <marcel@holtmann.org>
In-Reply-To: <CAK8P3a1mOzsaD+ZnN+ZKvmcan=K=KbnTjUOe1y8fS8WOMXT+Dw@mail.gmail.com>
Date:   Fri, 10 Jan 2020 16:44:54 +0100
Cc:     Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>,
        Rich Felker <dalias@libc.org>
Content-Transfer-Encoding: 8BIT
Message-Id: <5E8DACB3-3B53-4E22-A834-4CEDFC6A1757@holtmann.org>
References: <CAK8P3a1mOzsaD+ZnN+ZKvmcan=K=KbnTjUOe1y8fS8WOMXT+Dw@mail.gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Arnd,

> I noticed earlier this week that the HCI_CMSG_TSTAMP/HCI_TIME_STAMP
> interface has no time64 equivalent, as we apparently missed that when
> converting the normal socket timestamps to support both time32 and time64
> variants of the sockopt and cmsg data.
> 
> The interface was originally added back in 2002 by Maksim Krasnyanskiy
> when bluetooth support first became non-experimental.
> 
> When using HCI_TIME_STAMP on a 32-bit system with a time64
> libc, users will interpret the { s32 tv_sec; s32 tv_usec } layout of
> the kernel as { s64 tv_sec; ... }, which puts complete garbage
> into the timestamp regardless of whether this code runs before or
> after y2038. From looking at codesearch.debian.org, I found two
> users of this: libpcap and hcidump. There are probably others that
> are not part of Debian.
> 
> Fixing this the same was as normal socket timestamps is not possible
> because include/net/bluetooth/hci.h is not an exported UAPI header.
> This means any changes to it for defining HCI_TIME_STAMP conditionally
> would be ignored by applications that use a different copy of the
> header.
> 
> I can see three possible ways forward:
> 
> 1. move include/net/bluetooth/hci.h to include/uapi/, add a conditional
>   definition of HCI_TIME_STAMP and make the kernel code support
>   both formats. Then change applications to rely on that version of
>   header file to get the correct definition but not change application code.
> 
> 2. Leave the kernel completely unchanged and modify only the users
>    to not expect the output to be a 'struct timeval' but interpret as
>    as { uint32_t tv_sec; int32_t tv_usec; } structure on 32-bit architectures,
>    which will work until the unsigned time overflows 86 years from now
>    in 2106 (same as the libpcap on-disk format).
> 
> 3. Add support for the normal SO_TIMESTAMPNS_NEW sockopt in
>   HCI, providing timestamps in the unambiguous { long long tv_sec;
>   long long tv_nsec; } format to user space, and change applications
>   to use that if supported by the kernel.

I have added SO_TIMESTAMP* to every Bluetooth socket a while back. And that should be used by the majority of the tools. One exception might by hcidump which has been replaced by btmon already anyway.

So I would not bother with HCI_TIME_STAMP fixing. We can do 2) if someone really still wants to use that socket option. However I am under the impression that 3) should be already possible.

Regards

Marcel

