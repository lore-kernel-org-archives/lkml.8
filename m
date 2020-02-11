Return-Path: <SRS0=PxPh=37=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3921C352A3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:34:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C0723206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Feb 2020 14:34:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbgBKOeQ convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 09:34:16 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:20942 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727818AbgBKOeP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 09:34:15 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-54-dctIXTQ8O5OXh04oyb3tqA-1; Tue, 11 Feb 2020 14:34:11 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 11 Feb 2020 14:34:11 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 11 Feb 2020 14:34:11 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Xiaoyao Li' <xiaoyao.li@intel.com>,
        Paolo Bonzini <pbonzini@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sean Christopherson <sean.j.christopherson@intel.com>,
        Ingo Molnar <mingo@redhat.com>,
        "Borislav Petkov" <bp@alien8.de>,
        Andy Lutomirski <luto@amacapital.net>
CC:     "x86@kernel.org" <x86@kernel.org>,
        "kvm@vger.kernel.org" <kvm@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2 3/6] kvm: x86: Emulate split-lock access as a write
Thread-Topic: [PATCH v2 3/6] kvm: x86: Emulate split-lock access as a write
Thread-Index: AQHV4OP68X/A1Fe8pUKXUjVj7zr1z6gWDhjw
Date:   Tue, 11 Feb 2020 14:34:11 +0000
Message-ID: <973e772012ce4f0f9a689fe33608236a@AcuMS.aculab.com>
References: <20200203151608.28053-1-xiaoyao.li@intel.com>
 <20200203151608.28053-4-xiaoyao.li@intel.com>
 <95d29a81-62d5-f5b6-0eb6-9d002c0bba23@redhat.com>
 <878sl945tj.fsf@nanos.tec.linutronix.de>
 <d690c2e3-e9ef-a504-ede3-d0059ec1e0f6@redhat.com>
 <f6d37da1-ce56-7a11-63d8-32126b76094a@intel.com>
In-Reply-To: <f6d37da1-ce56-7a11-63d8-32126b76094a@intel.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: dctIXTQ8O5OXh04oyb3tqA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Xiaoyao Li
> Sent: 11 February 2020 14:03
...
> Alright, I don't know the history of TEST_CTRL, there is a bit 31 in it
> which means "Disable LOCK# assertion for split locked access" when set.
> Bit 31 exists for a long period, but linux seems not use it so I guess
> it may be a testing purpose bit.

My brain remembers something about some system just ignoring
locked accesses for misaligned transfers.
Trouble is it was probably nearly 30 years ago and there are
no details coming out of 'long term storage'.

It might be that some systems I had either set this bit
or acted as if it was set.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

