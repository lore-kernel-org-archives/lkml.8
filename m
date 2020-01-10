Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D3EA4C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 23:43:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9453520721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 23:43:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727657AbgAJXm7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 18:42:59 -0500
Received: from c.mail.sonic.net ([64.142.111.80]:50374 "EHLO c.mail.sonic.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727608AbgAJXm7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 18:42:59 -0500
Received: from [10.0.2.187] (96-74-112-17-static.hfc.comcastbusiness.net [96.74.112.17] (may be forged))
        (authenticated bits=0)
        by c.mail.sonic.net (8.15.1/8.15.1) with ESMTPSA id 00ANWPe0014404
        (version=TLSv1.2 cipher=DHE-RSA-AES128-GCM-SHA256 bits=128 verify=NOT);
        Fri, 10 Jan 2020 15:32:25 -0800
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.0 \(3608.40.2.2.4\))
Subject: Re: [PATCH] hcidump: add support for time64 based libc
From:   Guy Harris <guy@alum.mit.edu>
In-Reply-To: <CAK8P3a2VONV2Z6rs=xpntJyzfX4W7YijqCFr-f-PNMm3g4zRyA@mail.gmail.com>
Date:   Fri, 10 Jan 2020 15:32:24 -0800
Cc:     Rich Felker <dalias@libc.org>,
        Bluez mailing list <linux-bluetooth@vger.kernel.org>,
        y2038 Mailman List <y2038@lists.linaro.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Deepa Dinamani <deepa.kernel@gmail.com>
Content-Transfer-Encoding: 8BIT
Message-Id: <0BF859F5-AA95-4941-A80D-7D33F7AC3636@alum.mit.edu>
References: <20200110204903.3495832-1-arnd@arndb.de>
 <20200110210512.GB30412@brightrain.aerifal.cx>
 <CAK8P3a2VONV2Z6rs=xpntJyzfX4W7YijqCFr-f-PNMm3g4zRyA@mail.gmail.com>
To:     Arnd Bergmann <arnd@arndb.de>
X-Mailer: Apple Mail (2.3608.40.2.2.4)
X-Sonic-CAuth: UmFuZG9tSVZfzRQnWvZjU7z+oCr5uoYP1bTOtA3Pmun4SpvjUHajIkrSUR9AvHwPE0H9mnMxZLfsnA5qFsdc26xnraVEakyT
X-Sonic-ID: C;+BkWdQE06hGJtCGeTRzYKg== M;Yh95dQE06hGJtCGeTRzYKg==
X-Sonic-Spam-Details: 0.0/5.0 by cerberusd
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Jan 10, 2020, at 1:19 PM, Arnd Bergmann <arnd@arndb.de> wrote:

> On Fri, Jan 10, 2020 at 10:05 PM Rich Felker <dalias@libc.org> wrote:
>> 
>> On Fri, Jan 10, 2020 at 09:49:03PM +0100, Arnd Bergmann wrote:
>>> musl is moving to a default of 64-bit time_t on all architectures,
>>> glibc will follow later. This breaks reading timestamps through cmsg
>>> data with the HCI_TIME_STAMP socket option.
>>> 
>>> Change both copies of hcidump to work on all architectures.  This also
>>> fixes x32, which has never worked, and carefully avoids breaking sparc64,
>>> which is another special case.
>> 
>> Won't it be broken on rv32 though? Based on my (albeit perhaps
>> incomplete) reading of the thread, I think use of HCI_TIME_STAMP
>> should just be dropped entirely in favor of using SO_TIMESTAMPNS -- my
>> understanding was that it works with bluetooth sockets too.
> 
> All 32-bit architectures use old_timeval32 timestamps in the kernel
> here, even rv32 and x32. As a rule, we keep the types bug-for-bug
> compatible between architectures and fix them all at the same time.
> 
> Changing hcidump to SO_TIMESTAMPNS would work as well, but
> that is a much bigger change and I don't know how to test that.

If so, maybe I'll just do that for libpcap.  Libpcap *does* have an API to request capturing with nanoseconds in tv_usec (and I plan to give it pcapng-flavored APIs to deliver higher-resolution time stamps, as well as metadata such as "incoming" vs. "outgoing", as well).
