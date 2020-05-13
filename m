Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 12419CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:21:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7B582204EF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 13:21:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387527AbgEMNVM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 09:21:12 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:28433 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726001AbgEMNVL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 09:21:11 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-142-s2aarvEZM1aeGjcTCVqdUA-1; Wed, 13 May 2020 14:21:07 +0100
X-MC-Unique: s2aarvEZM1aeGjcTCVqdUA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 13 May 2020 14:21:06 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 13 May 2020 14:21:06 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Will Deacon' <will@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>
CC:     Marco Elver <elver@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Dmitry Vyukov <dvyukov@google.com>
Subject: RE: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Thread-Topic: [PATCH v5 00/18] Rework READ_ONCE() to improve codegen
Thread-Index: AQHWKSOwZor7e2JWdEKPvqldyEhGwKil/2ew
Date:   Wed, 13 May 2020 13:21:06 +0000
Message-ID: <9ba9552bd68a4461bb346dc3bae71d7a@AcuMS.aculab.com>
References: <20200511204150.27858-1-will@kernel.org>
 <20200512081826.GE2978@hirez.programming.kicks-ass.net>
 <CANpmjNNo3rhwqG=xEbpP9JiSd8-Faw8fkoUhYJjesHK5S5_KQQ@mail.gmail.com>
 <20200512190755.GL2957@hirez.programming.kicks-ass.net>
 <CANpmjNNeSnrAgfkskE5Y0NNu3-DS6hk+SwjkBunrr8FRxwwT-Q@mail.gmail.com>
 <20200513111057.GN2957@hirez.programming.kicks-ass.net>
 <CANpmjNMariz3-keqwUsLHVrpk2r7ThLSKtkhHxTDa3SEGeznhA@mail.gmail.com>
 <20200513123243.GO2957@hirez.programming.kicks-ass.net>
 <20200513124021.GB20278@willie-the-truck>
In-Reply-To: <20200513124021.GB20278@willie-the-truck>
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

From: Will Deacon
> Sent: 13 May 2020 13:40
> On Wed, May 13, 2020 at 02:32:43PM +0200, Peter Zijlstra wrote:
> > On Wed, May 13, 2020 at 01:48:41PM +0200, Marco Elver wrote:
> >
> > > Disabling most instrumentation for arch/x86 is reasonable. Also fine
> > > with the __READ_ONCE/__WRITE_ONCE changes (your improved
> > > compiler-friendlier version).
> > >
> > > We likely can't have both: still instrument __READ_ONCE/__WRITE_ONCE
> > > (as Will suggested) *and* avoid double-instrumentation in arch_atomic.
> > > If most use-cases of __READ_ONCE/__WRITE_ONCE are likely to use
> > > data_race() or KCSAN_SANITIZE := n anyway, I'd say it's reasonable for
> > > now.
> 
> I agree that Peter's patch is the right thing to do for now. I was hoping we
> could instrument __{READ,WRITE}_ONCE(), but that we before I realised that
> __no_sanitize_or_inline doesn't seem to do anything.

Could something be done that put the addresses of the instructions
into a separate segment and have KASAN check that table before
reporting an actual error?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

