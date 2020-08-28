Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39318C433E2
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:39:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F3A0720776
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 07:39:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728397AbgH1Hjb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 03:39:31 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:28996 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726500AbgH1Hj3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 03:39:29 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-266-Gqqjngt5NDyRwtlGJI5Pew-1; Fri, 28 Aug 2020 08:39:26 +0100
X-MC-Unique: Gqqjngt5NDyRwtlGJI5Pew-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Fri, 28 Aug 2020 08:39:25 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Fri, 28 Aug 2020 08:39:25 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Kees Cook' <keescook@chromium.org>,
        Denis Efremov <efremov@linux.com>
CC:     Julia Lawall <julia.lawall@inria.fr>,
        Joe Perches <joe@perches.com>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        cocci <cocci@systeme.lip6.fr>,
        "accessrunner-general@lists.sourceforge.net" 
        <accessrunner-general@lists.sourceforge.net>,
        Alex Dewar <alex.dewar90@gmail.com>
Subject: RE: [Cocci] [PATCH] usb: atm: don't use snprintf() for sysfs attrs
Thread-Topic: [Cocci] [PATCH] usb: atm: don't use snprintf() for sysfs attrs
Thread-Index: AQHWfMBUatYqQRMSW0+Lm7S5UM8VU6lNInTw
Date:   Fri, 28 Aug 2020 07:39:25 +0000
Message-ID: <24d45f0868b74a3ba4924f031e968c55@AcuMS.aculab.com>
References: <20200824222322.22962-1-alex.dewar90@gmail.com>
 <48f2dc90-7852-eaf1-55d7-2c85cf954688@rasmusvillemoes.dk>
 <20200827071537.GA168593@kroah.com>
 <20200827131819.7rcl2f5js3hkoqj2@lenovo-laptop>
 <def24e9e-018c-9712-0d07-d4cbc84f07d9@rasmusvillemoes.dk>
 <20200827144846.yauuttjaqtxaldxg@lenovo-laptop>
 <5d1dfb9b031130d4d20763ec621233a19d6a88a2.camel@perches.com>
 <alpine.DEB.2.22.394.2008272141220.2482@hadrien>
 <5853c58e-7d26-2cf9-6cbf-698ecd93cbf9@linux.com>
 <202008271517.ECC1F1F8F@keescook>
In-Reply-To: <202008271517.ECC1F1F8F@keescook>
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

From: Kees Cook
> Sent: 27 August 2020 23:21
...
> 
> Agreed. This just makes me cringe. If the API design declares that when
> a show() callback starts, buf has been allocated with PAGE_SIZE bytes,
> then that's how the logic should proceed, and it should be using
> scnprintf...
> 
> show(...) {
> 	size_t remaining = PAGE_SIZE;
> 
> 	...
> 	remaining -= scnprintf(buf, remaining, "fmt", var args ...);
> 	remaining -= scnprintf(buf, remaining, "fmt", var args ...);
> 	remaining -= scnprintf(buf, remaining, "fmt", var args ...);

Not quite what you had in mind, maybe:
	char *end = buf + PAGE_SIZE;

	buf += scnprintf(buf, end - buf, ...);

	return PAGE_SIZE - (end - buf);

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

