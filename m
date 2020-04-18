Return-Path: <SRS0=3CHW=6C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5E7F2C38A2F
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 13:28:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FC6920780
	for <linux-kernel@archiver.kernel.org>; Sat, 18 Apr 2020 13:28:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726012AbgDRN17 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 18 Apr 2020 09:27:59 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:58124 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725804AbgDRN17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Apr 2020 09:27:59 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-163-iEq3HNYPO8Gv4ZuIWssZ0w-1; Sat, 18 Apr 2020 14:27:54 +0100
X-MC-Unique: iEq3HNYPO8Gv4ZuIWssZ0w-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sat, 18 Apr 2020 14:27:54 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sat, 18 Apr 2020 14:27:54 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mikulas Patocka' <mpatocka@redhat.com>,
        Dan Williams <dan.j.williams@intel.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        "Peter Zijlstra" <peterz@infradead.org>, X86 ML <x86@kernel.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>,
        device-mapper development <dm-devel@redhat.com>
Subject: RE: [PATCH] x86: introduce memcpy_flushcache_clflushopt
Thread-Topic: [PATCH] x86: introduce memcpy_flushcache_clflushopt
Thread-Index: AQHWFLZf1uwJ38llN06XsGw6srhIuah+3wRg
Date:   Sat, 18 Apr 2020 13:27:53 +0000
Message-ID: <69c2e011c5814255926f309dd50e6d67@AcuMS.aculab.com>
References: <alpine.LRH.2.02.2004071029270.8662@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4goJ2jbXNVZbMUKtRUominhuMhuTKrMh=fnhrfvC4jyjw@mail.gmail.com>
 <alpine.LRH.2.02.2004081439080.13932@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4grNHvyYEc4W6PkymhEJvLb17tXbC3JZdqvtFxmMZ8DCQ@mail.gmail.com>
 <alpine.LRH.2.02.2004090612320.27517@file01.intranet.prod.int.rdu2.redhat.com>
 <alpine.LRH.2.02.2004160411460.7833@file01.intranet.prod.int.rdu2.redhat.com>
 <CAPcyv4gpe8u=zNrRhvd9ioVNGbOJfRUXzFZuV--be6Hbj0xXtQ@mail.gmail.com>
 <alpine.LRH.2.02.2004170831530.16047@file01.intranet.prod.int.rdu2.redhat.com>
In-Reply-To: <alpine.LRH.2.02.2004170831530.16047@file01.intranet.prod.int.rdu2.redhat.com>
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

From: Mikulas Patocka
> Sent: 17 April 2020 13:47
...
> Index: linux-2.6/drivers/md/dm-writecache.c
> ===================================================================
> --- linux-2.6.orig/drivers/md/dm-writecache.c	2020-04-17 14:06:35.139999000 +0200
> +++ linux-2.6/drivers/md/dm-writecache.c	2020-04-17 14:06:35.129999000 +0200
> @@ -1166,7 +1166,10 @@ static void bio_copy_block(struct dm_wri
>  			}
>  		} else {
>  			flush_dcache_page(bio_page(bio));
> -			memcpy_flushcache(data, buf, size);
> +			if (likely(size > 512))
> +				memcpy_flushcache_clflushopt(data, buf, size);
> +			else
> +				memcpy_flushcache(data, buf, size);

Hmmm... have you looked at how long clflush actually takes?
It isn't too bad if you just do a small number, but using it
to flush large buffers can be very slow.

I've an Ivy bridge system where the X-server process requests the
frame buffer be flushed out every 10 seconds (no idea why).
With my 2560x1440 monitor this takes over 3ms.

This really needs a cond_resched() every few clflush instructions.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

