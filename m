Return-Path: <SRS0=5Fkd=6R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 931ABC28CBC
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 13:05:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6F5342073E
	for <linux-kernel@archiver.kernel.org>; Sun,  3 May 2020 13:05:30 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728612AbgECNF3 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 3 May 2020 09:05:29 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:20475 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728579AbgECNF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 May 2020 09:05:29 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mtapsc-1-PiwzYAMxPhqDKD10rKMWKg-1; Sun, 03 May 2020 14:05:25 +0100
X-MC-Unique: PiwzYAMxPhqDKD10rKMWKg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Sun, 3 May 2020 14:05:24 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Sun, 3 May 2020 14:05:24 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Jason Baron' <jbaron@akamai.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>
CC:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Alexander Viro" <viro@zeniv.linux.org.uk>, Heiher <r@hev.cc>,
        Roman Penyaev <rpenyaev@suse.de>,
        Khazhismel Kumykov <khazhy@google.com>,
        Davidlohr Bueso <dbueso@suse.de>,
        "stable@vger.kernel.org" <stable@vger.kernel.org>
Subject: RE: [PATCH] epoll: ensure ep_poll() doesn't miss wakeup events
Thread-Topic: [PATCH] epoll: ensure ep_poll() doesn't miss wakeup events
Thread-Index: AQHWH+3GezEky6u5mk6GywAVvMmIMKiWVkJw
Date:   Sun, 3 May 2020 13:05:24 +0000
Message-ID: <c2921e66bf3a4edfaa667c32abbefebf@AcuMS.aculab.com>
References: <1588360533-11828-1-git-send-email-jbaron@akamai.com>
In-Reply-To: <1588360533-11828-1-git-send-email-jbaron@akamai.com>
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

From: Jason Baron
> Sent: 01 May 2020 20:16
>
> Now that the ep_events_available() check is done in a lockless way, and
> we no longer perform wakeups from ep_scan_ready_list(), we need to ensure
> that either ep->rdllist has items or the overflow list is active. Prior to:
> commit 339ddb53d373 ("fs/epoll: remove unnecessary wakeups of nested
> epoll"), we did wake_up(&ep->wq) after manipulating the ep->rdllist and the
> overflow list. Thus, any waiters would observe the correct state. However,
> with that wake_up() now removed we need to be more careful to ensure that
> condition.

I'm wondering how much all this affects the (probably) more common
case of a process reading events from a lot of sockets in 'level'
mode.

Even the change to a rwlock() may have had an adverse effect
on such programs.

In 'level' mode it doesn't make any sense to have multiple
readers of the event queue.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

