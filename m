Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E8EC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:30:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 001C8206F1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 14:30:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726511AbgFQOag convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 10:30:36 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:44473 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725901AbgFQOag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 10:30:36 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-144-tRDTNmFJP0-XS1WZyvnh3A-1; Wed, 17 Jun 2020 15:30:32 +0100
X-MC-Unique: tRDTNmFJP0-XS1WZyvnh3A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 17 Jun 2020 15:30:31 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 17 Jun 2020 15:30:31 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Wolfram Sang' <wsa@kernel.org>,
        "wu000273@umn.edu" <wu000273@umn.edu>
CC:     "kjlu@umn.edu" <kjlu@umn.edu>,
        Michal Simek <michal.simek@xilinx.com>,
        Rob Herring <robh@kernel.org>,
        Shubhrajyoti Datta <shubhraj@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "linux-i2c@vger.kernel.org" <linux-i2c@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] i2c: xiic: Fix reference count leaks.
Thread-Topic: [PATCH] i2c: xiic: Fix reference count leaks.
Thread-Index: AQHWQiuTE76LjToEc02VHcgO+GXIWKjc4oTg
Date:   Wed, 17 Jun 2020 14:30:31 +0000
Message-ID: <8aa8ee3d005f4a7e9a4dfa6654cc2732@AcuMS.aculab.com>
References: <20200613215923.2611-1-wu000273@umn.edu>
 <20200614090950.GB2878@kunai>
In-Reply-To: <20200614090950.GB2878@kunai>
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

From: Wolfram Sang
> Sent: 14 June 2020 10:10
> 
> On Sat, Jun 13, 2020 at 04:59:23PM -0500, wu000273@umn.edu wrote:
> > From: Qiushi Wu <wu000273@umn.edu>
> >
> > pm_runtime_get_sync() increments the runtime PM usage counter even
> > when it returns an error code. Thus call pm_runtime_put_noidle()
> > if pm_runtime_get_sync() fails.
> 
> Can you point me to a discussion where it was decided that this is a
> proper fix? I'd think we rather should fix pm_runtime_get_sync() but
> maybe there are technical reasons against it.

Or, if there is one place that actually needs the reference split the
code so that unusual case keeps the reference.

In one of the patches I also spotted:
	ret = pm_runtime_get_sync();
	if (ret < 0 && ret != _EAGAIN)
		...

(I think it was EAGAIN.)
I can't help feeling that is just wrong somewhere.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

