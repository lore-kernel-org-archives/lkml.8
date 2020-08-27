Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 354DCC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:56:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 18F9622B4B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 14:56:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728098AbgH0O40 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 10:56:26 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:38606 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726084AbgH0NHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 09:07:45 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-193-ebJTYPNPMbe2YTXzj0WrTA-1; Thu, 27 Aug 2020 14:07:34 +0100
X-MC-Unique: ebJTYPNPMbe2YTXzj0WrTA-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 27 Aug 2020 14:07:33 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 27 Aug 2020 14:07:33 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Matthew Wilcox' <willy@infradead.org>,
        Shaokun Zhang <zhangshaokun@hisilicon.com>
CC:     "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Yuqi Jin <jinyuqi@huawei.com>, Will Deacon <will@kernel.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: RE: [PATCH] fs: Optimized fget to improve performance
Thread-Topic: [PATCH] fs: Optimized fget to improve performance
Thread-Index: AQHWfHA0Q0HraGCxZUqID6ug/Nw0ZqlL69xQ
Date:   Thu, 27 Aug 2020 13:07:33 +0000
Message-ID: <6feef2f0b6ed4df99e66c8325c8e66ae@AcuMS.aculab.com>
References: <1598523584-25601-1-git-send-email-zhangshaokun@hisilicon.com>
 <20200827123040.GE14765@casper.infradead.org>
In-Reply-To: <20200827123040.GE14765@casper.infradead.org>
Accept-Language: en-GB, en-US
Content-Language: en-US
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
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Matthew Wilcox
> Sent: 27 August 2020 13:31
> On Thu, Aug 27, 2020 at 06:19:44PM +0800, Shaokun Zhang wrote:
> > From: Yuqi Jin <jinyuqi@huawei.com>
> >
> > It is well known that the performance of atomic_add is better than that of
> > atomic_cmpxchg.
> 
> I don't think that's well-known at all.

Especially since on (probably) every architecture except x86
atomic_add() is implemented using atomic_cmpxchg().

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

