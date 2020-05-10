Return-Path: <SRS0=j177=6Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60047C38A2A
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:47:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4002D20820
	for <linux-kernel@archiver.kernel.org>; Sun, 10 May 2020 12:47:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728907AbgEJMrS convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 10 May 2020 08:47:18 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:31193 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726863AbgEJMrR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 May 2020 08:47:17 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-111-wTKvyRDLNUioeEmIP5t2pw-1; Sun, 10 May 2020 13:47:13 +0100
X-MC-Unique: wTKvyRDLNUioeEmIP5t2pw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 10 May 2020 13:47:13 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 10 May 2020 13:47:13 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Joe Perches' <joe@perches.com>, Arnd Bergmann <arnd@arndb.de>,
        "Oleksandr Natalenko" <oleksandr@redhat.com>
CC:     "Jason A. Donenfeld" <Jason@zx2c4.com>,
        LKML <linux-kernel@vger.kernel.org>, X86 ML <x86@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: RE: [PATCH] Kconfig: default to CC_OPTIMIZE_FOR_PERFORMANCE_O3 for
 gcc >= 10
Thread-Topic: [PATCH] Kconfig: default to CC_OPTIMIZE_FOR_PERFORMANCE_O3 for
 gcc >= 10
Thread-Index: AQHWJUo8bK79Vz6Er0qWTasVui4yHqihRWbA
Date:   Sun, 10 May 2020 12:47:13 +0000
Message-ID: <9590a4674863448e8b13fee5086fcf73@AcuMS.aculab.com>
References: <20200507224530.2993316-1-Jason@zx2c4.com>
         <20200508090202.7s3kcqpvpxx32syu@butterfly.localdomain>
         <CAHmME9pTZTa9AEUL0-ojTr7P-F7NYe8OR9=-GBPaQNpnSDrEiw@mail.gmail.com>
         <20200508113336.2vdfdnc6tqyx4pu6@butterfly.localdomain>
         <CAK8P3a0dJ0vNnktcoWFiPKB4NJbeyf7nvwWf0YLyeUyxT5pvQg@mail.gmail.com>
 <c774d7371a9599526090e63e85f61e69bddf4795.camel@perches.com>
In-Reply-To: <c774d7371a9599526090e63e85f61e69bddf4795.camel@perches.com>
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

From: Joe Perches
> Sent: 08 May 2020 16:06
> On Fri, 2020-05-08 at 13:49 +0200, Arnd Bergmann wrote:
> > Personally, I'm more interested in improving compile speed of the kernel
> 
> Any opinion on precompiled header support?

When ever I've been anywhere near it it is always a disaster.
It may make sense for C++ where there is lots of complicated
code to parse in .h files. Parsing C headers is usually easier.

One this I have done that significantly speeds up .h file
processing is to take the long list of '-I directory' parameters
that are passed to the compiler and copy the first version
of each file into a separate 'object headers' directory.
This saves the compiler doing lots of 'failed opens'.

If each fragment makefile lists its 'public' headers make
can generate dependency rules that do the copies.

FWIW make is much faster if you delete all the builtin and
suffix rules and rely on explicit rules for each file.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

