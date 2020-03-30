Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98090C2D0EB
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:14:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 738A5205ED
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 18:14:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727801AbgC3SOm convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 14:14:42 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:22606 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726017AbgC3SOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 14:14:42 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-228-Uzzyp6fHP5iCb0krCcGUIQ-1; Mon, 30 Mar 2020 19:14:38 +0100
X-MC-Unique: Uzzyp6fHP5iCb0krCcGUIQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 30 Mar 2020 19:14:38 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 30 Mar 2020 19:14:38 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>
CC:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: RE: ftrace not showing the process names for all processes on syscall
 events
Thread-Topic: ftrace not showing the process names for all processes on
 syscall events
Thread-Index: AdYGnj+cWqFtVCqqTmCXgoqvHM5xrf///P+A///qkvCAAEdbAP//7aKg
Date:   Mon, 30 Mar 2020 18:14:37 +0000
Message-ID: <ffd8aa59d88146fbb5a4cb02ea9b7440@AcuMS.aculab.com>
References: <3cdef49951734e83a14959628233d4f0@AcuMS.aculab.com>
        <20200330110855.437fe854@gandalf.local.home>
        <7dec110c2dc14792ba744419a4eb907e@AcuMS.aculab.com>
 <20200330140736.4b5f1667@gandalf.local.home>
In-Reply-To: <20200330140736.4b5f1667@gandalf.local.home>
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

From: Steven Rostedt
> Sent: 30 March 2020 19:08
> On Mon, 30 Mar 2020 15:34:08 +0000
> David Laight <David.Laight@ACULAB.COM> wrote:
> 
> > Oh, does the 'function_graph' code ignore tail calls?
> 
> Yes and no ;-)  It works by dumb luck. As it was a year after function
> graph tracing was live (some time in 2010 I believe) that someone brought
> up tail calls, and I had to take a look at how it never crashed, and was
> surprised that it "just worked". Here's a summary:

'Dumb luck' seems to be failing me :-)
I'll look more closely tomorrow.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

