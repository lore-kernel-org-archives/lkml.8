Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C325C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:37:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 52AB720707
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 08:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727093AbgHZIhq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 04:37:46 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:34383 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727030AbgHZIho (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 04:37:44 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-35-QRdC98wbMdmvHPHECW8jgw-1; Wed, 26 Aug 2020 09:37:40 +0100
X-MC-Unique: QRdC98wbMdmvHPHECW8jgw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 26 Aug 2020 09:37:39 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 26 Aug 2020 09:37:39 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kent Overstreet' <kent.overstreet@gmail.com>
CC:     'Marcelo Ricardo Leitner' <marcelo.leitner@gmail.com>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>,
        "'linux-sctp@vger.kernel.org'" <linux-sctp@vger.kernel.org>,
        'Eric Biggers' <ebiggers@kernel.org>,
        'Catalin Marinas' <catalin.marinas@arm.com>,
        "'Andrew Morton'" <akpm@linux-foundation.org>,
        'Neil Horman' <nhorman@tuxdriver.com>
Subject: RE: [PATCH 00/13] lib/generic-radix-tree: genradix bug fix and
 optimisations.
Thread-Topic: [PATCH 00/13] lib/generic-radix-tree: genradix bug fix and
 optimisations.
Thread-Index: AdZ67b0yl7qlbV/xQHyOe3+CAeHrEgAABLWAAAIsYaD///zZAP/+9nJQ//3Y1HA=
Date:   Wed, 26 Aug 2020 08:37:39 +0000
Message-ID: <3e60559ff056423dbd19bb5e2eecc2e9@AcuMS.aculab.com>
References: <21289d79b0474811b21ed8478c465159@AcuMS.aculab.com>
 <20200825154127.GB2444@localhost.localdomain>
 <17da427b99b444ce9d310d6542ae197e@AcuMS.aculab.com>
 <20200825163224.GA499490@zaphod.evilpiepirate.org>
 <425b461bdd4c429c905f99d2ab7451f2@AcuMS.aculab.com>
In-Reply-To: <425b461bdd4c429c905f99d2ab7451f2@AcuMS.aculab.com>
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

From: David Laight
> Sent: 26 August 2020 08:36
...
> I'm going to try marking the lookup functions with '__attribute__ ((pure))'.
> That should help the sctp code that does repeated SCTP_SI().
> In reality I want to mark them __attribute__ ((const)) - including the
> inline wrappers, but that isn't allowed if they read memory.

Neither pure nor const makes any difference.
Even to code that like:
	if (SCTP_SO(...)->ext)
		SCTP_SO(...)->ext->foo = 0;

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

