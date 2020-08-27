Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CD0BBC433E6
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:03:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AA2A620872
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 22:03:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727996AbgH0WDa convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 18:03:30 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:52418 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727944AbgH0WD1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 18:03:27 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-59-OGrq4_s1M6OWOpSfz2k_Ug-1; Thu, 27 Aug 2020 23:03:21 +0100
X-MC-Unique: OGrq4_s1M6OWOpSfz2k_Ug-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 27 Aug 2020 23:03:20 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 27 Aug 2020 23:03:20 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joe Perches' <joe@perches.com>,
        Julia Lawall <julia.lawall@inria.fr>
CC:     Alex Dewar <alex.dewar90@gmail.com>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        cocci <cocci@systeme.lip6.fr>, Kees Cook <keescook@chromium.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-usb@vger.kernel.org" <linux-usb@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Gustavo A. R. Silva" <gustavoars@kernel.org>,
        "accessrunner-general@lists.sourceforge.net" 
        <accessrunner-general@lists.sourceforge.net>
Subject: RE: [Cocci] [PATCH] usb: atm: don't use snprintf() for sysfs attrs
Thread-Topic: [Cocci] [PATCH] usb: atm: don't use snprintf() for sysfs attrs
Thread-Index: AQHWfLDNatYqQRMSW0+Lm7S5UM8VU6lMgaZA
Date:   Thu, 27 Aug 2020 22:03:20 +0000
Message-ID: <c3926f18f98e446daad957cd66a94890@AcuMS.aculab.com>
References: <20200824222322.22962-1-alex.dewar90@gmail.com>
         <48f2dc90-7852-eaf1-55d7-2c85cf954688@rasmusvillemoes.dk>
         <20200827071537.GA168593@kroah.com>
         <20200827131819.7rcl2f5js3hkoqj2@lenovo-laptop>
         <def24e9e-018c-9712-0d07-d4cbc84f07d9@rasmusvillemoes.dk>
         <20200827144846.yauuttjaqtxaldxg@lenovo-laptop>
         <5d1dfb9b031130d4d20763ec621233a19d6a88a2.camel@perches.com>
         <alpine.DEB.2.22.394.2008272141220.2482@hadrien>
 <cf9b1ea3716305447be43bffc8f90b7ef7292f5b.camel@perches.com>
In-Reply-To: <cf9b1ea3716305447be43bffc8f90b7ef7292f5b.camel@perches.com>
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

From: Joe Perches
> Sent: 27 August 2020 21:30
...
> Perhaps what's necessary is to find any
> appropriate .show function and change
> any use of strcpy/sprintf within those
> function to some other name.
> 
> For instance:
> 
> drivers/isdn/mISDN/core.c-static ssize_t name_show(struct device *dev,
> drivers/isdn/mISDN/core.c-                       struct device_attribute *attr, char *buf)
> drivers/isdn/mISDN/core.c-{
> drivers/isdn/mISDN/core.c:      strcpy(buf, dev_name(dev));
> drivers/isdn/mISDN/core.c-      return strlen(buf);
> drivers/isdn/mISDN/core.c-}
> drivers/isdn/mISDN/core.c-static DEVICE_ATTR_RO(name);

That form ends up calculating the string length twice.
Better would be:
	len = strlen(msg);
	memcpy(buf, msg, len);
	return len;


	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

