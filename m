Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0FEFC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:24:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A12F92078D
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 12:24:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726570AbgHMMX7 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 08:23:59 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:26945 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726102AbgHMMXy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 08:23:54 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-192-sOwuS-RPNJy4xbaVllFbTw-1; Thu, 13 Aug 2020 13:23:49 +0100
X-MC-Unique: sOwuS-RPNJy4xbaVllFbTw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Thu, 13 Aug 2020 13:23:48 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Thu, 13 Aug 2020 13:23:48 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Daniel Axtens' <dja@axtens.net>,
        Christoph Hellwig <hch@infradead.org>
CC:     "viro@zeniv.linux.org.uk" <viro@zeniv.linux.org.uk>,
        "linux-fsdevel@vger.kernel.org" <linux-fsdevel@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: RE: [PATCH] fs/select.c: batch user writes in do_sys_poll
Thread-Topic: [PATCH] fs/select.c: batch user writes in do_sys_poll
Thread-Index: AQHWcWYJlYrYWDsW9k2hVZh5/SyFEKk19dsg
Date:   Thu, 13 Aug 2020 12:23:48 +0000
Message-ID: <452dbcc5064646028dc8b9f5f3d57a5d@AcuMS.aculab.com>
References: <20200813071120.2113039-1-dja@axtens.net>
 <20200813073220.GB15436@infradead.org>
 <87zh6zlynh.fsf@dja-thinkpad.axtens.net>
 <87wo22n5ez.fsf@dja-thinkpad.axtens.net>
In-Reply-To: <87wo22n5ez.fsf@dja-thinkpad.axtens.net>
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

From: Daniel Axtens
> Sent: 13 August 2020 12:37
> 
> >> Seem like this could simply use a copy_to_user to further simplify
> >> things?
> >
> > I'll benchmark it and find out.
> 
> I tried this:
> 
>         for (walk = head; walk; walk = walk->next) {
> -               struct pollfd *fds = walk->entries;
> -               int j;
> -
> -               for (j = 0; j < walk->len; j++, ufds++)
> -                       if (__put_user(fds[j].revents, &ufds->revents))
> -                               goto out_fds;
> +               if (copy_to_user(ufds, walk->entries,
> +                                sizeof(struct pollfd) * walk->len))
> +                       goto out_fds;
> +               ufds += walk->len;
>         }
> 
> With that approach, the poll2 microbenchmark (which polls 128 fds) is
> about as fast as v1.
> 
> However, the poll1 microbenchmark, which polls just 1 fd, regresses a
> touch (<1% - ~2%) compared to the current code, although it's largely
> within the noise. Thoughts?

Is that with or without 'user copy hardening'?
Or use __copy_to_user() to skip all that 'crap'.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

