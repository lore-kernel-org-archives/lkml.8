Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1BF30C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 09:13:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA302207F9
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 09:13:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726806AbgETJNU convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 05:13:20 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:55795 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726224AbgETJNT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 05:13:19 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id uk-mta-6-UGwfFmtFPw6X4FXYTYQnQg-1;
 Wed, 20 May 2020 10:13:15 +0100
X-MC-Unique: UGwfFmtFPw6X4FXYTYQnQg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 20 May 2020 10:13:15 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 20 May 2020 10:13:15 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Thomas Gleixner' <tglx@linutronix.de>,
        'Sasha Levin' <sashal@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "bp@alien8.de" <bp@alien8.de>, "luto@kernel.org" <luto@kernel.org>,
        "hpa@zytor.com" <hpa@zytor.com>,
        "dave.hansen@intel.com" <dave.hansen@intel.com>,
        "tony.luck@intel.com" <tony.luck@intel.com>,
        "ak@linux.intel.com" <ak@linux.intel.com>,
        "ravi.v.shankar@intel.com" <ravi.v.shankar@intel.com>,
        "chang.seok.bae@intel.com" <chang.seok.bae@intel.com>,
        Andrew Cooper <andrew.cooper3@citrix.com>,
        "x86@kernel.org" <x86@kernel.org>
Subject: RE: [PATCH v12 10/18] x86/fsgsbase/64: Enable FSGSBASE instructions
 in helper functions
Thread-Topic: [PATCH v12 10/18] x86/fsgsbase/64: Enable FSGSBASE instructions
 in helper functions
Thread-Index: AQHWLVJcG1AiHrfpmEaP5P6pVvKjjqivU+WggAAZtICAAUUdcA==
Date:   Wed, 20 May 2020 09:13:14 +0000
Message-ID: <f35d0f8ddc2a4e518bd9674b74e40497@AcuMS.aculab.com>
References: <20200511045311.4785-11-sashal@kernel.org>
 <87v9ktw1ev.fsf@nanos.tec.linutronix.de> <20200518202435.GD33628@sasha-vm>
 <238a6e2609eb4e0497b13fbe5f531917@AcuMS.aculab.com>
 <87r1vg6kwq.fsf@nanos.tec.linutronix.de>
In-Reply-To: <87r1vg6kwq.fsf@nanos.tec.linutronix.de>
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

From: Thomas Gleixner
> Sent: 19 May 2020 15:48
> 
> David Laight <David.Laight@ACULAB.COM> writes:
> > From: Sasha Levin
> >> >> +		native_swapgs();
> >> >> +		gsbase = rdgsbase();
> >> >> +		native_swapgs();
> >
> > Does local_irq_save() even do anything useful here.
> > You need to actually execute CLI, not just set a
> > flag that indicates interrupts shouldn't happen.
> > (Which is what I think local_irq_save() might do.)
> 
>   local_irq_save()
>     raw_local_irq_save()
>       arch_local_irq_save()
>         arch_local_irq_disable()
>           native_irq_disable()
>             asm("CLI")

Ah, I was expecting software 'tricks' to avoid the expensive CLI.
But that call chain probably costs more - unless it is all inlined.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

