Return-Path: <SRS0=aGSP=5L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 73671C2D0E5
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:36:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58DD420719
	for <linux-kernel@archiver.kernel.org>; Thu, 26 Mar 2020 17:36:04 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727661AbgCZRgD convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 26 Mar 2020 13:36:03 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:23324 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726067AbgCZRgC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 Mar 2020 13:36:02 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-13-Tle9O2V7P9i3U-QD2IdWNw-1; Thu, 26 Mar 2020 17:34:36 +0000
X-MC-Unique: Tle9O2V7P9i3U-QD2IdWNw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 26 Mar 2020 17:34:35 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 26 Mar 2020 17:34:35 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jessica Yu' <jeyu@kernel.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "'Linus Torvalds'" <torvalds@linux-foundation.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Matthias Maennich <maennich@google.com>
Subject: RE: modpost Module.symver handling is broken in 5.6.0-rc7
Thread-Topic: modpost Module.symver handling is broken in 5.6.0-rc7
Thread-Index: AdYDiqOPE71nee/CTfS3aDSZbkO5JwABAkKAAABe9DAAAHoCgAAAc4Rg
Date:   Thu, 26 Mar 2020 17:34:35 +0000
Message-ID: <ac06c49345824fd1bfb84f7e62ceb4d9@AcuMS.aculab.com>
References: <931818529b1d4d13a08d30ddace22733@AcuMS.aculab.com>
 <20200326165036.GA22172@linux-8ccs>
 <90b763cc306140499fddf8e3185e26f5@AcuMS.aculab.com>
 <20200326171453.GA21406@linux-8ccs>
In-Reply-To: <20200326171453.GA21406@linux-8ccs>
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

From: Jessica Yu
> Sent: 26 March 2020 17:15
...
> I'm a bit confused - just to confirm, is there a legitimate bug
> upstream or was it just a hiccup related to your setup?

An upstream change broke our build scripts in a very confusing way.

I think KBUILD_EXTRA_SYMBOLS was added in 2.6.26.
Since we no longer need to build on anything older than 2.6.32
I can use that instead of copying the Module.symvers from the
other build directory and relying on the build scripts passing
-I Module.symver to modpost.

I just need to find a suitable system to check it on.
All made more difficult by working from home....

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

