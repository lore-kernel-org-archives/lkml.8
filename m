Return-Path: <SRS0=PjrZ=CH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5ABC433E6
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 13:37:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C1F74207BB
	for <linux-kernel@archiver.kernel.org>; Sat, 29 Aug 2020 13:37:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728069AbgH2NhR convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 09:37:17 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:59429 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728082AbgH2NhG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 09:37:06 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-260-sruLeLQHO6G7wRvBN5rGQw-1; Sat, 29 Aug 2020 14:37:02 +0100
X-MC-Unique: sruLeLQHO6G7wRvBN5rGQw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sat, 29 Aug 2020 14:37:02 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sat, 29 Aug 2020 14:37:02 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Bart Groeneveld' <avi@bartavi.nl>,
        Patches internal <patches.internal@link.bartavi.nl>
CC:     "David S . Miller" <davem@davemloft.net>,
        Jakub Kicinski <kuba@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Alexey Kuznetsov <kuznet@ms2.inr.ac.ru>,
        Hideaki YOSHIFUJI <yoshfuji@linux-ipv6.org>,
        "netdev@vger.kernel.org" <netdev@vger.kernel.org>,
        "linux-doc@vger.kernel.org" <linux-doc@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH v2] net: Use standardized (IANA) local port range
Thread-Topic: [PATCH v2] net: Use standardized (IANA) local port range
Thread-Index: AQHWfXt8zR3om+J6ikuVkMpiekBWLKlPFWkw
Date:   Sat, 29 Aug 2020 13:37:01 +0000
Message-ID: <30c8e904e2114204a4381034e7ee06c7@AcuMS.aculab.com>
References: <20200821142533.45694-1-avi@bartavi.nl>
 <20200828203959.32010-1-avi@bartavi.nl>
In-Reply-To: <20200828203959.32010-1-avi@bartavi.nl>
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

From: Bart Groeneveld
> Sent: 28 August 2020 21:40
> 
> IANA specifies User ports as 1024-49151,
> and Private ports (local/ephemeral/dynamic/w/e) as 49152-65535 [1].
> 
> This means Linux uses 32768-49151 'illegally'.
> This is not just a matter of following specifications:
> IANA actually assigns numbers in this range [1].

Linux is using the 'historic' values.
IANA shouldn't really have 'grabbed' half the port number space.
Really the 'problem' of TCP port numbers identifying the service
as well as the connection should have been addresses by some other
means (eg using port 1023 and a TCP option to select the serivce).

Changing the default base from 32k to 48k will break some existing
systems if/when a kernel upgrade is installed.

You are also changing the numbers for UDP.
Anyone doing a lot of RTP (which typically requires 2 adjacent
UDP ports) is already constrained by the availability or ports.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

