Return-Path: <SRS0=pQss=CP=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 34DD8C433E2
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 20:52:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E5AD320C09
	for <linux-kernel@archiver.kernel.org>; Sun,  6 Sep 2020 20:52:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726401AbgIFUwi convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 6 Sep 2020 16:52:38 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:34949 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726154AbgIFUwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 6 Sep 2020 16:52:36 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-224-fEXZTQIXM4uphP0pOlU36w-1; Sun, 06 Sep 2020 21:52:31 +0100
X-MC-Unique: fEXZTQIXM4uphP0pOlU36w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 6 Sep 2020 21:52:31 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 6 Sep 2020 21:52:31 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christophe Leroy' <christophe.leroy@csgroup.eu>,
        Pavel Machek <pavel@denx.de>
CC:     Christoph Hellwig <hch@lst.de>, "arnd@arndb.de" <arnd@arndb.de>,
        "gregkh@linuxfoundation.org" <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] /dev/zero: also implement ->read
Thread-Topic: [PATCH] /dev/zero: also implement ->read
Thread-Index: AQHWggy41s1fAL/OckmYjTgFjgCjKqlXb8rwgASFNZ2AACUDkA==
Date:   Sun, 6 Sep 2020 20:52:31 +0000
Message-ID: <f2e9c57db2b548949e6bd570a6dc3c5d@AcuMS.aculab.com>
References: <20200903155922.1111551-1-hch@lst.de>
 <55d1ecb8-4a0c-fa58-d3cf-bf6796eea7bd@csgroup.eu>
 <3b0b58be4b844162b73db1b108a9b995@AcuMS.aculab.com>
 <20200906182122.GA12295@amd>
 <8c353864-76a9-90bf-fa2f-f7a8231b5487@csgroup.eu>
In-Reply-To: <8c353864-76a9-90bf-fa2f-f7a8231b5487@csgroup.eu>
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

From: Christophe Leroy
> Sent: 06 September 2020 19:36
> Hi,
> 
> Le 06/09/2020 à 20:21, Pavel Machek a écrit :
> > Hi!
> >
> >>>> Christophe reported a major speedup due to avoiding the iov_iter
> >>>> overhead, so just add this trivial function.  Note that /dev/zero
> >>>> already implements both an iter and non-iter writes so this just
> >>>> makes it more symmetric.
> >>>>
> >>>> Christophe Leroy <christophe.leroy@csgroup.eu>
> >>>> Signed-off-by: Christoph Hellwig <hch@lst.de>
> >>>
> >>> Tested-by: Christophe Leroy <christophe.leroy@csgroup.eu>
> >>
> >> Any idea what has happened to make the 'iter' version so bad?
> >
> > Exactly. Also it would be nice to note how the speedup was measured
> > and what the speedup is.
> >
> 
> Was measured on an 8xx powerpc running at 132MHz with:
> 
> 	dd if=/dev/zero of=/dev/null count=1M
> 
> With the patch, dd displays a throughput of 113.5MB/s
> Without the patch it is 99.9MB/s

That in itself isn't a problem.
What was the throughput before any of these patches?

I just remember another thread about the same test running
a lot slower after one of the related changes.
While this speeds up read /dev/zero (which is uncommon)
if this is needed to get near the old performance then
the changes to the 'iter' code will affect real workloads.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

