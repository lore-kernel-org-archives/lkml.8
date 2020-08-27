Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D1B50C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:30:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B8D8E22B4E
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:30:11 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728051AbgH0OaF convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:30:05 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:57430 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728048AbgH0OWC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 10:22:02 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-223-AW3ZNV-SP0aGNzZHgpXBVg-1; Thu, 27 Aug 2020 15:13:22 +0100
X-MC-Unique: AW3ZNV-SP0aGNzZHgpXBVg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 27 Aug 2020 15:13:21 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 27 Aug 2020 15:13:21 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: NTP adjustments to CLOCK_MONATONIC
Thread-Topic: NTP adjustments to CLOCK_MONATONIC
Thread-Index: AdZ8dpybr71tOIXqSjuzMi+avyML6Q==
Date:   Thu, 27 Aug 2020 14:13:21 +0000
Message-ID: <3df4f582304949648e104a2837555bad@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've just noticed some strange behaviour of some code that is
comparing CLOCK_MONATONIC to a second (external) clock source.

Normally the difference is between +/-200ns in 10ms.
Which is well within the ppm errors of the crystals.

However for around 90 seconds after system boot the error
was massive - I have to force a difference of around 8000ns/10ms
to see similar behaviour.

The only explanation I can guess at is that it was subject
to NTP's maximum slew rate of 0.5ms/sec (1/2000) while NTP
was aligning CLOCK_REALTIME.

While the NTP adjustments for clock frequency drift aren't
unreasonable for CLOCK_MONATONIC, including the adjustments
for the boot time offset is rather horrid.

In this case they stopped after 90 seconds, but a bigger
offset could take hours (or even days?) to clear.

This rather breaks what timekeeping.rst says about CLOCK_MONATONIC
being useful for 'reliable timestamps and measuring short time
intervals accurately'.

Any idea what happens to CLOCK_MONATONIC over a leap second?
Its offset to CLOCK_REALTIME should really change by 1 second.

I can't use CLOCK_MONATONIC_RAW because the hrtimer code
doesn't support it.

There are also programs that need to do things (like send RTP)
every 20ms - not every 20.01ms.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

