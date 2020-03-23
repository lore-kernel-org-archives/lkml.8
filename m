Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4639EC3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:11:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1606A206F8
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 15:11:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727240AbgCWPLq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 11:11:46 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:32604 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727096AbgCWPLp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 11:11:45 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-117-FP7y-fD7Or6NzgHxkL5fNw-1; Mon, 23 Mar 2020 15:11:41 +0000
X-MC-Unique: FP7y-fD7Or6NzgHxkL5fNw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 23 Mar 2020 15:11:40 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 23 Mar 2020 15:11:40 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Christophe JAILLET' <christophe.jaillet@wanadoo.fr>,
        "peterz@infradead.org" <peterz@infradead.org>,
        "mingo@redhat.com" <mingo@redhat.com>,
        "acme@kernel.org" <acme@kernel.org>,
        "mark.rutland@arm.com" <mark.rutland@arm.com>,
        "alexander.shishkin@linux.intel.com" 
        <alexander.shishkin@linux.intel.com>,
        "jolsa@redhat.com" <jolsa@redhat.com>,
        "namhyung@kernel.org" <namhyung@kernel.org>,
        "kan.liang@linux.intel.com" <kan.liang@linux.intel.com>,
        "zhe.he@windriver.com" <zhe.he@windriver.com>,
        "dzickus@redhat.com" <dzickus@redhat.com>,
        "jstancek@redhat.com" <jstancek@redhat.com>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-janitors@vger.kernel.org" <kernel-janitors@vger.kernel.org>
Subject: RE: [PATCH] perf cpumap: Use scnprintf instead of snprintf
Thread-Topic: [PATCH] perf cpumap: Use scnprintf instead of snprintf
Thread-Index: AQHWAG7rOhePTwQGyk2fyROkdMOaUqhWSN8A
Date:   Mon, 23 Mar 2020 15:11:40 +0000
Message-ID: <c0441e54a07e424f9646ca232d44e9d8@AcuMS.aculab.com>
References: <20200322172523.2677-1-christophe.jaillet@wanadoo.fr>
In-Reply-To: <20200322172523.2677-1-christophe.jaillet@wanadoo.fr>
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

From: Christophe JAILLET
> Sent: 22 March 2020 17:25
> 'scnprintf' returns the number of characters written in the output buffer
> excluding the trailing '\0', instead of the number of characters which
> would be generated for the given input.
> 
> Both function return a number of characters, excluding the trailing '\0'.
> So comparaison to check if it overflows, should be done against max_size-1.
> Comparaison against max_size can never match.

NACK.
Since snprintf() returns the number of characters it would have
written to an infinite buffer the comparison can 'match'.

However it should test for (ret >= PATH_MAX).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

