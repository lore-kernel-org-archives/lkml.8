Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66092C43331
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E62020787
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 16:25:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728557AbgCZQZ2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 12:25:28 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:31542 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727056AbgCZQZ2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 12:25:28 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-255-ydnrF7b3NuGh2o2Hbu-eWA-1; Thu, 26 Mar 2020 16:25:23 +0000
X-MC-Unique: ydnrF7b3NuGh2o2Hbu-eWA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 26 Mar 2020 16:25:23 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 26 Mar 2020 16:25:23 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     Jessica Yu <jeyu@kernel.org>,
        'Linus Torvalds' <torvalds@linux-foundation.org>
Subject: modpost Module.symver handling is broken in 5.6.0-rc7
Thread-Topic: modpost Module.symver handling is broken in 5.6.0-rc7
Thread-Index: AdYDiqOPE71nee/CTfS3aDSZbkO5Jw==
Date:   Thu, 26 Mar 2020 16:25:23 +0000
Message-ID: <931818529b1d4d13a08d30ddace22733@AcuMS.aculab.com>
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

Something is currently broken in modpost.
I'm guessing it is down to the recent patch that moved the
namespace back to the end of the line.

I'm building 2 'out of tree' modules that have a symbol dependency.
When I build the 2nd module I get ERROR "symbol" undefined message.

If I flip the order of the fields in Module.symver to the older order
and link with modpost from 5.4.0-rc7 (which I happen to have lurking)
it all works fine.

Note that I'm using a named namespace, not the default one
that is the full path of the module.

I'll dig in a little further.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

