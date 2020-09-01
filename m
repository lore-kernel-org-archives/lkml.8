Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79F04C433E2
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:36:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62F7A2087D
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 09:36:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726764AbgIAJgi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 05:36:38 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:51232 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726679AbgIAJge (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 05:36:34 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-198-0_ckY7SzOmm2B0gV5icsSA-1; Tue, 01 Sep 2020 10:36:30 +0100
X-MC-Unique: 0_ckY7SzOmm2B0gV5icsSA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 1 Sep 2020 10:36:29 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 1 Sep 2020 10:36:29 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Norbert Preining' <norbert@preining.info>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: kernel hard lockups wit 5.9-rc{2,3}
Thread-Topic: kernel hard lockups wit 5.9-rc{2,3}
Thread-Index: AQHWf177xf+hBGUvkEWCmoTo7Rvn6alThq5g
Date:   Tue, 1 Sep 2020 09:36:29 +0000
Message-ID: <85b60791227e4719ae98ef08d1200af2@AcuMS.aculab.com>
References: <20200831053847.GA5022@bulldog.preining.info>
In-Reply-To: <20200831053847.GA5022@bulldog.preining.info>
Accept-Language: en-GB, en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0.001
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Norbert Preining
> I am seeing hard lockups with 5.9-rc2 and -rc3, while 5.8.N (1,2,3,4,5)
> work without any problems.
> 
> THe lockups are hard to debug, since not even Sysrq works anymore. The
> screen freezes completely, no reaction. Ports are also dead, ssh into
> the machine is not possible.
> 
> Hangs are repeatable, but not triggerable (at least I didn't find a
> way). Last time I left the screen locked and went shopping to find it
> locked up coming back. In total I got about 10 lock ups.

I've had a random lockup on a pre-rc1 kernel.
But that might be one of our own drivers - OTOH they 'normally'
generate OOPS tracebacks.

Have you tried setting up a serial console?
It might contain some useful messages.

Sysrq is more likely to work with a PS2 keyboard (not USB).
IIRC the 'caps lock' light only needs PS2 keyboard interrupts
to be working - a useful check on how dead a system it.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

