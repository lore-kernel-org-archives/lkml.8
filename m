Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C4DBBC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:37:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A197A2071A
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 14:37:36 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733082AbgDAOhf convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 10:37:35 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:60292 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1733022AbgDAOhf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 10:37:35 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-247-kZ-q67PqNDK7_iboeSQpxg-1; Wed, 01 Apr 2020 15:37:29 +0100
X-MC-Unique: kZ-q67PqNDK7_iboeSQpxg-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 1 Apr 2020 15:37:28 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 1 Apr 2020 15:37:28 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>
CC:     'Linux Kernel Mailing List' <linux-kernel@vger.kernel.org>
Subject: RE: ftrace not showing the process names for all processes on syscall
 events
Thread-Topic: ftrace not showing the process names for all processes on
 syscall events
Thread-Index: AdYGnj+cWqFtVCqqTmCXgoqvHM5xrf///P+A///qkvCAAEdbAP//7aKg//zzjTA=
Date:   Wed, 1 Apr 2020 14:37:28 +0000
Message-ID: <985e88f06c2140dcba09b7aa73121e6c@AcuMS.aculab.com>
References: <3cdef49951734e83a14959628233d4f0@AcuMS.aculab.com>
        <20200330110855.437fe854@gandalf.local.home>
        <7dec110c2dc14792ba744419a4eb907e@AcuMS.aculab.com>
 <20200330140736.4b5f1667@gandalf.local.home>
 <ffd8aa59d88146fbb5a4cb02ea9b7440@AcuMS.aculab.com>
In-Reply-To: <ffd8aa59d88146fbb5a4cb02ea9b7440@AcuMS.aculab.com>
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

From: David Laight
> Sent: 30 March 2020 19:15
> From: Steven Rostedt
> > Sent: 30 March 2020 19:08
> > On Mon, 30 Mar 2020 15:34:08 +0000
> > David Laight <David.Laight@ACULAB.COM> wrote:
> >
> > > Oh, does the 'function_graph' code ignore tail calls?
> >
> > Yes and no ;-)  It works by dumb luck. As it was a year after function
> > graph tracing was live (some time in 2010 I believe) that someone brought
> > up tail calls, and I had to take a look at how it never crashed, and was
> > surprised that it "just worked". Here's a summary:
> 
> 'Dumb luck' seems to be failing me :-)
> I'll look more closely tomorrow.

The 'problem' is that some files like lib/iov_iter.c don't have the
tracepoints compiled in.

So calls I was expecting to see were absent.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

