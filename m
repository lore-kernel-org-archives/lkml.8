Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D83DBC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 16:19:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BB36420855
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 16:19:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726848AbgHMQTe convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 12:19:34 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:41098 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726167AbgHMQTc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 12:19:32 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-144-HFvdjctTMHyprBW8119_ew-1; Thu, 13 Aug 2020 17:19:28 +0100
X-MC-Unique: HFvdjctTMHyprBW8119_ew-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 13 Aug 2020 17:19:28 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 13 Aug 2020 17:19:28 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Josef Bacik' <josef@toxicpanda.com>, "hch@lst.de" <hch@lst.de>,
        "viro@ZenIV.linux.org.uk" <viro@ZenIV.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kernel-team@fb.com" <kernel-team@fb.com>
Subject: RE: [PATCH] proc: use vmalloc for our kernel buffer
Thread-Topic: [PATCH] proc: use vmalloc for our kernel buffer
Thread-Index: AQHWcYF4YUlfHEUFrEai+1gWcwt4Jak2N4WQ
Date:   Thu, 13 Aug 2020 16:19:27 +0000
Message-ID: <714c8baabe1a4d0191f8cdaf6e28a32d@AcuMS.aculab.com>
References: <20200813145305.805730-1-josef@toxicpanda.com>
In-Reply-To: <20200813145305.805730-1-josef@toxicpanda.com>
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

From: Josef Bacik
> Sent: 13 August 2020 15:53
> 
>   sysctl: pass kernel pointers to ->proc_handler
> 
> we have been pre-allocating a buffer to copy the data from the proc
> handlers into, and then copying that to userspace.  The problem is this
> just blind kmalloc()'s the buffer size passed in from the read, which in
> the case of our 'cat' binary was 64kib.  Order-4 allocations are not
> awesome, and since we can potentially allocate up to our maximum order,
> use vmalloc for these buffers.

What happens if I run 'dd bs=16M ...' ?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

