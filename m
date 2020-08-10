Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B5BFBC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:05:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DA5F2073A
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 12:05:44 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726542AbgHJMFn convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 08:05:43 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:54053 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726141AbgHJMFn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 08:05:43 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-230-tvWpWrCcO7y7IVQQWcjw3Q-1; Mon, 10 Aug 2020 13:05:39 +0100
X-MC-Unique: tvWpWrCcO7y7IVQQWcjw3Q-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 10 Aug 2020 13:05:38 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 10 Aug 2020 13:05:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'peterz@infradead.org'" <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>
CC:     "tglx@linutronix.de" <tglx@linutronix.de>,
        "mingo@kernel.org" <mingo@kernel.org>,
        "will@kernel.org" <will@kernel.org>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "elver@google.com" <elver@google.com>,
        "paulmck@kernel.org" <paulmck@kernel.org>,
        "rjw@rjwysocki.net" <rjw@rjwysocki.net>
Subject: RE: [RFC][PATCH 2/3] locking,entry: #PF vs TRACE_IRQFLAGS
Thread-Topic: [RFC][PATCH 2/3] locking,entry: #PF vs TRACE_IRQFLAGS
Thread-Index: AQHWbw1/Z8lTQlAHP0ywRZaHVLPEDKkxPiFg
Date:   Mon, 10 Aug 2020 12:05:38 +0000
Message-ID: <e948ccc6bdba4a789efecb73070d0bf2@AcuMS.aculab.com>
References: <20200807192336.405068898@infradead.org>
 <20200807193018.060388629@infradead.org>
 <20200807162148.48d96247@oasis.local.home>
 <20200810115743.GU2674@hirez.programming.kicks-ass.net>
In-Reply-To: <20200810115743.GU2674@hirez.programming.kicks-ass.net>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: peterz@infradead.org
> Sent: 10 August 2020 12:58
> 
...
> > > --- a/include/linux/entry-common.h
> > > +++ b/include/linux/entry-common.h
> > > @@ -310,6 +310,7 @@ void irqentry_exit_to_user_mode(struct p
> > >  #ifndef irqentry_state
> > >  typedef struct irqentry_state {
> > >  	bool	exit_rcu;
> > > +	bool	irqs_enabled;
> >
> > Instead of passing a structure around, should we look at converting
> > "irqentry_state" into a flags field?
> 
> Probably, on x86_64-linux sizeof(_Bool) == 1, so it's two bytes and that
> fits perfectly fine in a normal return value, but yeah, this is common
> code now and we can't rely on sizeof(_Bool) being sane.

I'd check the arm ABI(s).
IIRC 'sizeof bool' changed - but I can't remember which way :-)

There are probably other ABI where a 'struct' return value
is always implemented as a 'pass by reference' parameter
(Probably M68k?).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

