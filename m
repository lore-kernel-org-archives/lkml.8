Return-Path: <SRS0=jpuI=BA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 139E2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:23:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD58120771
	for <linux-kernel@archiver.kernel.org>; Tue, 21 Jul 2020 16:23:07 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730205AbgGUQXG convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jul 2020 12:23:06 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:44657 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728268AbgGUQXG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jul 2020 12:23:06 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-61-AirEoyffNvC1547t3qSSww-1; Tue, 21 Jul 2020 17:23:02 +0100
X-MC-Unique: AirEoyffNvC1547t3qSSww-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 21 Jul 2020 17:23:01 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 21 Jul 2020 17:23:01 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Thomas Gleixner' <tglx@linutronix.de>,
        Frederic Weisbecker <frederic@kernel.org>
CC:     LKML <linux-kernel@vger.kernel.org>,
        "x86@kernel.org" <x86@kernel.org>, Oleg Nesterov <oleg@redhat.com>,
        "Eric W. Biederman" <ebiederm@xmission.com>,
        John Stultz <john.stultz@linaro.org>,
        Paolo Bonzini <pbonzini@redhat.com>
Subject: RE: [patch V2 2/5] posix-cpu-timers: Convert the flags to a bitmap
Thread-Topic: [patch V2 2/5] posix-cpu-timers: Convert the flags to a bitmap
Thread-Index: AQHWX3mJuHICg1ghhkWtnXn9ULrVJqkSNyjg
Date:   Tue, 21 Jul 2020 16:23:01 +0000
Message-ID: <d9bb2c5f6df1471f8863f84e710e50a4@AcuMS.aculab.com>
References: <20200716201923.228696399@linutronix.de>
 <20200716202044.625081169@linutronix.de> <20200721123452.GA9290@lenoir>
 <874kq04zn3.fsf@nanos.tec.linutronix.de>
In-Reply-To: <874kq04zn3.fsf@nanos.tec.linutronix.de>
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

From: Thomas Gleixner
> Sent: 21 July 2020 17:11
> 
> Frederic Weisbecker <frederic@kernel.org> writes:
> > On Thu, Jul 16, 2020 at 10:19:25PM +0200, Thomas Gleixner wrote:
> >> --- a/kernel/time/posix-cpu-timers.c
> >> +++ b/kernel/time/posix-cpu-timers.c
> >> @@ -25,7 +25,7 @@ void posix_cputimers_group_init(struct p
> >>  	posix_cputimers_init(pct);
> >>  	if (cpu_limit != RLIM_INFINITY) {
> >>  		pct->bases[CPUCLOCK_PROF].nextevt = cpu_limit * NSEC_PER_SEC;
> >> -		pct->timers_active = true;
> >> +		set_bit(CPUTIMERS_ACTIVE, &pct->flags);
> >
> > I guess this one could be __set_bit().
> 
> True :)

Hmmm... does this code need the bit operations to be atmomic?
If not then an bitmap is completely the wrong thing to be using.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

