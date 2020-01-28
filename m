Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E931C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 11:45:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EEF0524686
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 11:45:12 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726233AbgA1LpM convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 06:45:12 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:55996 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725941AbgA1LpL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 06:45:11 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-64-KHUc3FscOs2MVf9cLzs1SQ-1; Tue, 28 Jan 2020 11:45:06 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 28 Jan 2020 11:45:05 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 28 Jan 2020 11:45:05 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>
CC:     'linux-kernel' <linux-kernel@vger.kernel.org>
Subject: RE: sched/fair: Long delays starting RT processes on idle cpu.
Thread-Topic: sched/fair: Long delays starting RT processes on idle cpu.
Thread-Index: AQHV1SlucH1Za6AdTkOqbnnXEpKS/qf+tfxQgAAKfwCAASgewA==
Date:   Tue, 28 Jan 2020 11:45:05 +0000
Message-ID: <221f40db51b442aebb823e429e2b9de5@AcuMS.aculab.com>
References: <13797bbe87b64f34877b89a5bbdb6d03@AcuMS.aculab.com>
        <20200127104948.59eac75a@gandalf.local.home>
        <a23fe4c769364ab49865e4c46aa73830@AcuMS.aculab.com>
 <20200127121542.05a124d7@gandalf.local.home>
In-Reply-To: <20200127121542.05a124d7@gandalf.local.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: KHUc3FscOs2MVf9cLzs1SQ-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: linux-kernel-owner@vger.kernel.org <linux-kernel-owner@vger.kernel.org> On Behalf Of Steven Rostedt
> Sent: 27 January 2020 17:16
> On Mon, 27 Jan 2020 16:56:12 +0000
> David Laight <David.Laight@ACULAB.COM> wrote:
> 
> > >From Steven Rostedt
> > > Sent: 27 January 2020 15:50
> > > On Mon, 27 Jan 2020 15:39:24 +0000
> > > David Laight <David.Laight@ACULAB.COM> wrote:
> > >
> > > > I'd have thought that the processor should wake up much faster than that.
> > > > I can't see the memory write that is paired with the monitor/mwait.
> > > > Does it need a strong barrier?
> > >
> > > You may want to prevent the CPU from going into a deep C state. 90us is
> > > something I would expect if the CPU is in a deep C state (I've seen
> > > much longer wake up times due to deep C state).
> > >
> > > Boot the kernel with idle=poll and see if you can trigger the same
> > > latency. If not, then you know it's the CPU going into a deep C state
> > > that is causing your latency.
> >
> > With idle=poll the delays seem to be minimal.
> >
> > Is there any way to limit the C state entered by mwait?
> 
> I believe you can dynamically change C state. There's a pdf about it:
> 
>   https://wiki.ntb.ch/infoportal/_media/embedded_systems/ethercat/controlling_processor_c-state_usage_in_linux_v1.1_nov2013.pdf

Writing 20 to /dev/cpu_dma_latency (and holding the fd open) removes the excessive latency.
The latency values (for my system) seem to be 0, 1, 10, 59, 80.
I suspect the '10' - C1E (halt + energy saving) is not as bad as expected.

While it may well be that the cpu doesn't enter the C3/C6/C7 states if we
are doing a reasonable amount of work, they are a PITA when you are
trying to look at how a system behaves.

While searching for 'cpu_dma_latency' in Documentation does give some info,
it isn't entirely obvious that is what you need to look for.
Even finding the intel_idle.c code doesn't help much.
A reference from 'man setpriority'  might be a hint....

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

