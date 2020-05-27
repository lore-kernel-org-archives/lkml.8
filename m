Return-Path: <SRS0=UR55=7J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C571C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:59:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5563920873
	for <linux-kernel@archiver.kernel.org>; Wed, 27 May 2020 12:59:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730189AbgE0M7j convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 27 May 2020 08:59:39 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:25391 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730045AbgE0M7j (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 May 2020 08:59:39 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-198-qX9oc7T4N0KznTx0LSTJKg-1; Wed, 27 May 2020 13:59:35 +0100
X-MC-Unique: qX9oc7T4N0KznTx0LSTJKg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 27 May 2020 13:59:35 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 27 May 2020 13:59:35 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'kan.liang@linux.intel.com'" <kan.liang@linux.intel.com>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
CC:     "ak@linux.intel.com" <ak@linux.intel.com>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] perf/x86/intel/uncore: Fix oops when counting IMC uncore
 events on some TGL
Thread-Topic: [PATCH] perf/x86/intel/uncore: Fix oops when counting IMC uncore
 events on some TGL
Thread-Index: AQHWNCLukMKeXYb1T0G/ZA+cFsVVx6i75DXQ
Date:   Wed, 27 May 2020 12:59:35 +0000
Message-ID: <869fafc80da84d188678c1cbb0267a0b@AcuMS.aculab.com>
References: <1590582647-90675-1-git-send-email-kan.liang@linux.intel.com>
In-Reply-To: <1590582647-90675-1-git-send-email-kan.liang@linux.intel.com>
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

From: kan.liang@linux.intel.com
> Sent: 27 May 2020 13:31
> 
> From: Kan Liang <kan.liang@linux.intel.com>
> 
> When counting IMC uncore events on some TGL machines, an oops will be
> triggered.
>   [ 393.101262] BUG: unable to handle page fault for address:
>   ffffb45200e15858
>   [ 393.101269] #PF: supervisor read access in kernel mode
>   [ 393.101271] #PF: error_code(0x0000) - not-present page
> 
> Current perf uncore driver still use the IMC MAP SIZE inherited from
> SNB, which is 0x6000.
> However, the offset of IMC uncore counters for some TGL machines is
> larger than 0x6000, e.g. 0xd8a0.
> 
> Enlarge the IMC MAP SIZE for TGL to 0xe000.

Replacing one 'random' constant with a different one
doesn't seem like a proper fix.

Surely the actual bounds of the 'memory' area are properly
defined somewhere.
Or at least should come from a table.

You also need to verify that the offsets are within the mapped area.
An unexpected offset shouldn't try to access an invalid address.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

