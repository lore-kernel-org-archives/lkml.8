Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7B6B8C35254
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:15:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4D71A21741
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 14:15:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728057AbgBEOPL convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 5 Feb 2020 09:15:11 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:43455 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726308AbgBEOPL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Feb 2020 09:15:11 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-35-BvQRpUPMMNCExX1WpXxwPQ-1; Wed, 05 Feb 2020 14:15:06 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 5 Feb 2020 14:15:05 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 5 Feb 2020 14:15:05 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Mubin Usman Sayyed' <mubin.usman.sayyed@xilinx.com>,
        "tglx@linutronix.de" <tglx@linutronix.de>,
        "jason@lakedaemon.net" <jason@lakedaemon.net>,
        "maz@kernel.org" <maz@kernel.org>,
        "michal.simek@xilinx.com" <michal.simek@xilinx.com>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "siva.durga.paladugu@xilinx.com" <siva.durga.paladugu@xilinx.com>,
        "anirudha.sarangi@xilinx.com" <anirudha.sarangi@xilinx.com>
Subject: RE: [PATCH v2] irqchip: xilinx: Add support for multiple instances
Thread-Topic: [PATCH v2] irqchip: xilinx: Add support for multiple instances
Thread-Index: AQHV3C4mebwt/HjFmUCQKmd1NdxYk6gMpOHw
Date:   Wed, 5 Feb 2020 14:15:05 +0000
Message-ID: <e0d01341ac5c417982da48074972f470@AcuMS.aculab.com>
References: <1580911535-19415-1-git-send-email-mubin.usman.sayyed@xilinx.com>
In-Reply-To: <1580911535-19415-1-git-send-email-mubin.usman.sayyed@xilinx.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: BvQRpUPMMNCExX1WpXxwPQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> This email and any attachments are intended for the sole use of the named recipient(s) and contain(s)
> confidential information that may be proprietary, privileged or copyrighted under applicable law. If
> you are not the intended recipient, do not read, copy, or forward this email message or any
> attachments. Delete this email message and any attachments immediately.

Deleted.....

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

