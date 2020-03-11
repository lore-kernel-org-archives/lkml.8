Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E933C10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:48:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2CB2A206B1
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:48:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729946AbgCKOsK convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:48:10 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:31251 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729738AbgCKOsK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:48:10 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-171-fMd22utfNWyW-zxpyZeZbg-1; Wed, 11 Mar 2020 14:48:06 +0000
X-MC-Unique: fMd22utfNWyW-zxpyZeZbg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 11 Mar 2020 14:48:05 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 11 Mar 2020 14:48:05 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christopher Lameter' <cl@linux.com>,
        Kees Cook <keescook@chromium.org>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Daniel Micay <danielmicay@gmail.com>,
        "Vitaly Nikolenko" <vnik@duasynt.com>,
        Silvio Cesare <silvio.cesare@gmail.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] slub: Relocate freelist pointer to middle of object
Thread-Topic: [PATCH] slub: Relocate freelist pointer to middle of object
Thread-Index: AQHV9X67MmF5azEdVkObEXGGVdzyJahDfGRw
Date:   Wed, 11 Mar 2020 14:48:05 +0000
Message-ID: <6fbf67b5936a44feaf9ad5b58d39082b@AcuMS.aculab.com>
References: <202003051624.AAAC9AECC@keescook>
 <alpine.DEB.2.21.2003081919290.14266@www.lameter.com>
In-Reply-To: <alpine.DEB.2.21.2003081919290.14266@www.lameter.com>
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

From: Christopher Lameter
> Sent: 08 March 2020 19:21

> 
> On Thu, 5 Mar 2020, Kees Cook wrote:
> 
> > Instead of having the freelist pointer at the very beginning of an
> > allocation (offset 0) or at the very end of an allocation (effectively
> > offset -sizeof(void *) from the next allocation), move it away from
> > the edges of the allocation and into the middle. This provides some
> > protection against small-sized neighboring overflows (or underflows),
> > for which the freelist pointer is commonly the target. (Large or well
> > controlled overwrites are much more likely to attack live object contents,
> > instead of attempting freelist corruption.)
> 
> Sounds good. You could even randomize the position to avoid attacks on via
> the freelist pointer.

Random overwrites could be detected (fairly cheaply) by putting two
copies of the pointer into the same cacheline in the buffer.
Or better make the second one 'pointer xor constant'.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

