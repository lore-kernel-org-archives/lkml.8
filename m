Return-Path: <SRS0=L1Qp=6D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39BF2C38A30
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 21:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 17DD921473
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Apr 2020 21:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726055AbgDSVhP convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Apr 2020 17:37:15 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:21884 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725848AbgDSVhP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Apr 2020 17:37:15 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-95-zqFcyXnbPHardQKmriLBlQ-1; Sun, 19 Apr 2020 22:37:11 +0100
X-MC-Unique: zqFcyXnbPHardQKmriLBlQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 19 Apr 2020 22:37:10 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 19 Apr 2020 22:37:10 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Petko Manolov' <petko.manolov@konsulko.com>
CC:     "Paul E . McKenney" <paulmck@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: RE: [RFC] WRITE_ONCE_INC() and friends
Thread-Topic: [RFC] WRITE_ONCE_INC() and friends
Thread-Index: AQHWFi8qKt3GQH4qWkGP1JyWbckPg6iAvLKQ///3OoCAAELwsA==
Date:   Sun, 19 Apr 2020 21:37:10 +0000
Message-ID: <8e5a0283ed76465aac19a2b97a27ff15@AcuMS.aculab.com>
References: <20200419094439.GA32841@carbon>
 <491f0b0bc9e4419d93a78974fd7f44c7@AcuMS.aculab.com>
 <20200419182957.GA36919@carbon>
In-Reply-To: <20200419182957.GA36919@carbon>
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

From: Petko Manolov
> Sent: 19 April 2020 19:30
> 
> On 20-04-19 18:02:50, David Laight wrote:
> > From: Petko Manolov
> > > Sent: 19 April 2020 10:45
> > > Recently I started reading up on KCSAN and at some point I ran into stuff like:
> > >
> > > WRITE_ONCE(ssp->srcu_lock_nesting[idx], ssp->srcu_lock_nesting[idx] + 1);
> > > WRITE_ONCE(p->mm->numa_scan_seq, READ_ONCE(p->mm->numa_scan_seq) + 1);
> >
> > If all the accesses use READ/WRITE_ONCE() why not just mark the structure
> > field 'volatile'?
> 
> This is a bit heavy.  I guess you've read this one:
> 
> 	https://lwn.net/Articles/233479/

I remember reading something similar before.
I also remember a very old gcc (2.95?) that did a readback
after every volatile write on sparc (to flush the store buffer).
That broke everything.

I suspect there is a lot more code that is attempting to be lockless
these days.
Ring buffers (one writer and one reader) are a typical example where
you don't need locks but do need to use a consistent value.

Now you may also need ordering between accesses - which I think needs
more than volatile.

> And no, i am not sure all accesses are through READ/WRITE_ONCE().  If, for
> example, all others are from withing spin_lock/unlock pairs then we _may_ not
> need READ/WRITE_ONCE().

The cost of volatile accesses is probably minimal unless the
code is written assuming the compiler will only access things once.

> I merely proposed the _INC() variant for better readability.

More like shorter code lines :-)

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

