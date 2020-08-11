Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D0E05C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:45:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ADBE42075D
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 11:45:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728846AbgHKLpE convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 07:45:04 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:53547 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728838AbgHKLpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 07:45:04 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-255-VCkWQE-EOdO3IYWYtzwiVA-1; Tue, 11 Aug 2020 12:44:59 +0100
X-MC-Unique: VCkWQE-EOdO3IYWYtzwiVA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 11 Aug 2020 12:44:59 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 11 Aug 2020 12:44:59 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christoph Hellwig' <hch@lst.de>,
        Miles Chen <miles.chen@mediatek.com>
CC:     "David S . Miller" <davem@davemloft.net>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "linux-mediatek@lists.infradead.org" 
        <linux-mediatek@lists.infradead.org>,
        "wsd_upstream@mediatek.com" <wsd_upstream@mediatek.com>
Subject: RE: [PATCH] net: untag pointer in sockptr_is_kernel
Thread-Topic: [PATCH] net: untag pointer in sockptr_is_kernel
Thread-Index: AQHWb9DKxxLX2AshVECOBLD3J//Za6kyxXFQ
Date:   Tue, 11 Aug 2020 11:44:59 +0000
Message-ID: <36e381c558e24185bc2f7e80a758d06a@AcuMS.aculab.com>
References: <20200811102704.17875-1-miles.chen@mediatek.com>
 <20200811111551.GA3958@lst.de>
In-Reply-To: <20200811111551.GA3958@lst.de>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=C51A453 smtp.mailfrom=david.laight@aculab.com
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> On Tue, Aug 11, 2020 at 06:27:04PM +0800, Miles Chen wrote:
> > From: Miles Chen <miles.chen@mediatek.com>
> >
> > sockptr_is_kernel() uses (sockptr.kernel >= TASK_SIZE) to tell
> > if the pointer is kernel space or user space. When user space uses
> > the "top byte ignored" feature such as HWAsan, we must untag
> > the pointer before checking against TASK_SIZE.
> >
> > sockptr_is_kernel() will view a tagged user pointer as a kernel pointer
> > and use memcpy directly and causes a kernel crash.
> 
> Dave merged a patch from me to rever the optimized sockptr
> implementation for now.  If we bring it back we should fold in your
> fix.

I missed that going though :-(
I've looked for a fix to the access_ok(kernel_addr,0) being true issue.

Shouldn't TASK_SIZE be increased to cover all the 'tagged' addresses?
ISTR the 'tag' bits are the 'next' 8 (or so) address bits at the top
of valid user addresses.

Then presumably the user-copies would be able to use the tagged
address values getting whatever protection that gives.

ISTM that for kernel-user boundary checks TASK_SIZE is the
wrong constant.
(The upper limit for mmap() is entirely different.)
The limit should be independent of whether the process is 32 or 64bit
(any fault above 4G will fail to find a user-page for 32bit).
The limit can also go well into the address 'black hole' that
exists on x86-x64 (and similar) between valid user and kernel
addresses - handling the relevant trap should be too hard
(it is always an error, so need not be fast).

So with set_fs(KERNEL_DS) gone x86-x64 can (almost certainly)
do a cheap test for (long)addr >= 0 in access_ok() (+ length test).
While set_fs() is needed it can be:
	((long)addr & current->mask) >= 0
(masking off the top bit if kernel addresses are valid).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

