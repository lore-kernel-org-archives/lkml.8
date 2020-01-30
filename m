Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 882F9C33C9E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 10:09:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 62821206F0
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 10:09:51 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgA3KJu convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 05:09:50 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:49687 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726873AbgA3KJu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 05:09:50 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-234-ziHQ9NlkMbaBnTTgqADTaw-1; Thu, 30 Jan 2020 10:09:45 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 30 Jan 2020 10:09:45 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 30 Jan 2020 10:09:45 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Greg KH' <gregkh@linuxfoundation.org>,
        Eric Biggers <ebiggers@kernel.org>
CC:     Tetsuo Handa <penguin-kernel@i-love.sakura.ne.jp>,
        "gustavo@embeddedor.com" <gustavo@embeddedor.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] hpet: Fix struct_size() in kzalloc()
Thread-Topic: [PATCH] hpet: Fix struct_size() in kzalloc()
Thread-Index: AQHV1zIWYxQa+FO7zkqmoqcRV+KmjagC+3VQ
Date:   Thu, 30 Jan 2020 10:09:45 +0000
Message-ID: <b04253f40d9e49e597af925599bd4964@AcuMS.aculab.com>
References: <202001300450.00U4ocvS083098@www262.sakura.ne.jp>
 <20200130052645.GA833@sol.localdomain> <20200130055650.GA623220@kroah.com>
In-Reply-To: <20200130055650.GA623220@kroah.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: ziHQ9NlkMbaBnTTgqADTaw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

...
> > > -	hpetp = kzalloc(struct_size(hpetp, hp_dev, hdp->hd_nirqs - 1),
> > > +	hpetp = kzalloc(struct_size(hpetp, hp_dev, hdp->hd_nirqs),
> > >  			GFP_KERNEL);
> > >
> > >  	if (!hpetp)
> > > --
> >
> > Yep, "char: hpet: Use flexible-array member" started causing random boot
> > failures on mainline for me.  Tetsuo beat me to sending the fix.
> >
> > Only thing I'll add is that GFP_KERNEL can now fit on the previous line.
> 
> Gustavo already sent a fix for this, I didn't realize it was causing
> boot problems, I'll forward it on to Linus soon.

grep -r --include '*.c' 'struct_size.*- 1'
gives 4 other matches.
I bet they all have the same bug.
There might be others that simple pattern doesn't find.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

