Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 46781C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:22:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 206032068E
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 11:22:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729629AbgFOLWl convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 07:22:41 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:47223 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728285AbgFOLWl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 07:22:41 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-47-9KR430kxM7Czl-jMyYnSMw-1; Mon, 15 Jun 2020 12:22:36 +0100
X-MC-Unique: 9KR430kxM7Czl-jMyYnSMw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 15 Jun 2020 12:22:35 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 15 Jun 2020 12:22:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Al Viro' <viro@zeniv.linux.org.uk>,
        afzal mohammed <afzal.mohd.ma@gmail.com>
CC:     Arnd Bergmann <arnd@arndb.de>,
        Russell King - ARM Linux admin <linux@armlinux.org.uk>,
        Linus Walleij <linus.walleij@linaro.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Nicolas Pitre <nico@fluxnic.net>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Subject: RE: [RFC 1/3] lib: copy_{from,to}_user using gup & kmap_atomic()
Thread-Topic: [RFC 1/3] lib: copy_{from,to}_user using gup & kmap_atomic()
Thread-Index: AQHWQZeuKY4+jVw3gESBYOJARK44Q6jZh6/w
Date:   Mon, 15 Jun 2020 11:22:35 +0000
Message-ID: <3ef1b43f182041bc9585f5fd462a092f@AcuMS.aculab.com>
References: <cover.1591885760.git.afzal.mohd.ma@gmail.com>
 <9e1de19f35e2d5e1d115c9ec3b7c3284b4a4e077.1591885760.git.afzal.mohd.ma@gmail.com>
 <CAK8P3a1XUJHC0kG_Qwh4D4AoxTgCL5ggHd=45yNSmzaYWLUWXw@mail.gmail.com>
 <20200612135538.GA13399@afzalpc>
 <CAK8P3a25ffh_2Y1xKDbkL2xU9nLpGbEq7j6xHdODEwUtavgdwA@mail.gmail.com>
 <20200613120432.GA5319@afzalpc> <20200613125126.GE23230@ZenIV.linux.org.uk>
 <20200613125615.GF23230@ZenIV.linux.org.uk> <20200613134236.GA4086@afzalpc>
 <20200613153102.GG23230@ZenIV.linux.org.uk>
In-Reply-To: <20200613153102.GG23230@ZenIV.linux.org.uk>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Al Viro
> Sent: 13 June 2020 16:31
> On Sat, Jun 13, 2020 at 07:12:36PM +0530, afzal mohammed wrote:
> > Hi,
> >
> > On Sat, Jun 13, 2020 at 01:56:15PM +0100, Al Viro wrote:
> >
> > > Incidentally, what about get_user()/put_user()?  _That_ is where it's
> > > going to really hurt...
> >
> > All other uaccess routines are also planned to be added, posting only
> > copy_{from,to}_user() was to get early feedback (mentioned in the
> > cover letter)
> 
> Sure, but what I mean is that I'd expect the performance loss to be
> dominated by that, not by copy_from_user/copy_to_user on large amounts
> of data.  Especially on the loads like kernel builds - a lot of stat()
> and getdents() calls there.

Or any network traffic where the number of usercopies involved in,
for example, sendmsg() gives a measurable performance decrease when
HARDENED_USERCOPY is enabled.

Do you have issues with cache aliasing?
(Is aliasing the right term?)
Where potentially the temporary kernel map doesn't use the same
cache lines as the user processes map.

I'm not sure what problem you are trying to solve, but for 64bit
systems it may be possible to map all of physical memory into the
kernel address map, them you (loosely) only have to find the KVA
that matches the user-VA to do the copy.

IIRC our SYSV kernels used to do that - until we had 384MB of physical
memory and ran out of kernel address space.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

