Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6297BC2D0E5
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:54:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 37305205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 15:54:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729735AbgC3Py1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 11:54:27 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:47850 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726497AbgC3Py0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 11:54:26 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-87-ODMv5bv9P12XgKJf7O7OVA-1; Mon, 30 Mar 2020 16:54:23 +0100
X-MC-Unique: ODMv5bv9P12XgKJf7O7OVA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 30 Mar 2020 16:54:22 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 30 Mar 2020 16:54:22 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Al Viro' <viro@zeniv.linux.org.uk>, Ingo Molnar <mingo@kernel.org>
CC:     Linus Torvalds <torvalds@linux-foundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "x86@kernel.org" <x86@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Borislav Petkov" <bp@alien8.de>
Subject: RE: [RFC][PATCH 01/22] x86 user stack frame reads: switch to explicit
 __get_user()
Thread-Topic: [RFC][PATCH 01/22] x86 user stack frame reads: switch to
 explicit __get_user()
Thread-Index: AQHWBfOGBuGXOsXgxk+vqOM7n5IKaahhSkVQ
Date:   Mon, 30 Mar 2020 15:54:22 +0000
Message-ID: <0c08c4e00e4e4965969a16410e4e15d1@AcuMS.aculab.com>
References: <20200323183620.GD23230@ZenIV.linux.org.uk>
 <20200323183819.250124-1-viro@ZenIV.linux.org.uk>
 <20200328104857.GA93574@gmail.com>
 <20200328115936.GA23230@ZenIV.linux.org.uk>
 <20200329092602.GB93574@gmail.com>
 <20200329175735.GC23230@ZenIV.linux.org.uk>
In-Reply-To: <20200329175735.GC23230@ZenIV.linux.org.uk>
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

From: Al Viro
> Sent: 29 March 2020 18:58
...
> [*] IMO compat_alloc_user_space() should die; this "grab some space on
> user stack, copy the 32bit data structure into 64bit equivalent there,
> complete with pointer chasing and creating 64bit equivalents of everything
> that's referenced from that struct, then call native ioctl, then do the
> reverse conversion" is just plain wrong.  That native ioctl is going to
> bring the structures we'd constructed back into the kernel space and
> work with them there; we might as well separate the function that work
> with the copied struct (usually we do have those anyway) and call those
> instead the native ioctl.  And skip the damn "copy the structures we'd
> built into temp allocation on user stack, then have it copied back"
> part.  We have relatively few callers, thankfully.

I helped rip the same 'stackgap' code out of netbsd many years ago.
No only was it being used for system call compatibility, but
also for security checks and rewriting filenames.
Completely hopeless in a threaded program.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

