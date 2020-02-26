Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 39309C4BA10
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:27:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0B5B920637
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 11:27:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728224AbgBZL1s convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 06:27:48 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:32887 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727974AbgBZL1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 06:27:48 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-221-jmmFPVgaPpuJ4wTdSCkJng-1; Wed, 26 Feb 2020 11:27:44 +0000
X-MC-Unique: jmmFPVgaPpuJ4wTdSCkJng-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 26 Feb 2020 11:27:44 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 26 Feb 2020 11:27:44 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Tycho Andersen' <tycho@tycho.ws>, Jonathan Corbet <corbet@lwn.net>
CC:     "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] doc: fix filesystems/porting.rst whitespace
Thread-Topic: [PATCH] doc: fix filesystems/porting.rst whitespace
Thread-Index: AQHV6/0CVU3EL3UBYk6CPBpDNZlfS6gtVxNA
Date:   Wed, 26 Feb 2020 11:27:43 +0000
Message-ID: <4635ca9f17344643816994dc267cc25d@AcuMS.aculab.com>
References: <20200220214009.11645-1-tycho@tycho.ws>
 <20200225032028.2bda9de8@lwn.net> <20200225165954.GA11763@cisco>
In-Reply-To: <20200225165954.GA11763@cisco>
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

> It's actually the default vim syntax highlighter that gets confused in
> my case,
> 
> VIM - Vi IMproved 8.1 (2018 May 18, compiled Sep 05 2019 11:15:15)
> Included patches: 1-875, 878, 884, 948, 1046, 1365-1368, 1382, 1401

Yep, syntax highlighting doesn't stand a chance of getting it right.
Just makes it look as though someone has vomited on the screen.

Best to turn it off.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

