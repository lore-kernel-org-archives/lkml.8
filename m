Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9443AC2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 16:56:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 714F1214AF
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 16:56:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726155AbgA0Q4R convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 11:56:17 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:49685 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725845AbgA0Q4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 11:56:17 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-142-AM_IIyULNle_IOOLINe5hw-1; Mon, 27 Jan 2020 16:56:13 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 27 Jan 2020 16:56:12 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 27 Jan 2020 16:56:12 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>
CC:     'linux-kernel' <linux-kernel@vger.kernel.org>
Subject: RE: sched/fair: Long delays starting RT processes on idle cpu.
Thread-Topic: sched/fair: Long delays starting RT processes on idle cpu.
Thread-Index: AQHV1SlucH1Za6AdTkOqbnnXEpKS/qf+tfxQ
Date:   Mon, 27 Jan 2020 16:56:12 +0000
Message-ID: <a23fe4c769364ab49865e4c46aa73830@AcuMS.aculab.com>
References: <13797bbe87b64f34877b89a5bbdb6d03@AcuMS.aculab.com>
 <20200127104948.59eac75a@gandalf.local.home>
In-Reply-To: <20200127104948.59eac75a@gandalf.local.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: AM_IIyULNle_IOOLINe5hw-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From Steven Rostedt
> Sent: 27 January 2020 15:50
> On Mon, 27 Jan 2020 15:39:24 +0000
> David Laight <David.Laight@ACULAB.COM> wrote:
> 
> > I'd have thought that the processor should wake up much faster than that.
> > I can't see the memory write that is paired with the monitor/mwait.
> > Does it need a strong barrier?
> 
> You may want to prevent the CPU from going into a deep C state. 90us is
> something I would expect if the CPU is in a deep C state (I've seen
> much longer wake up times due to deep C state).
> 
> Boot the kernel with idle=poll and see if you can trigger the same
> latency. If not, then you know it's the CPU going into a deep C state
> that is causing your latency.

With idle=poll the delays seem to be minimal.

Is there any way to limit the C state entered by mwait?
Or to try the check that monitor/mwait is being triggered properly.
Is there a clfulsh() in the writing side?
If not, might one help??

I see almost repeatable delays eg for 6 processes being scheduled (more or less in sequence).
10us waking cpu 2.
60us waking cpu 1.
40us waking cpu 0 and 40us waking cpu3.
20us waking cpu 2.
20us waking cpu 0.
None of the processes runs for anything like the delays.
The whole thing repeats every 10ms.
Note that the first process is actually signalling a CV that 4 of the other 5
are waiting on.
So there are cumulative delays of around 140us before the 4th is woken.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

