Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAFDBC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:06:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDFE2205CB
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:06:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726489AbgHKVG2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:06:28 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([185.58.86.151]:21284 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726115AbgHKVG2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:06:28 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-263-bL9UjMbLOpS-QdQrBdhE5A-1; Tue, 11 Aug 2020 22:06:24 +0100
X-MC-Unique: bL9UjMbLOpS-QdQrBdhE5A-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 11 Aug 2020 22:06:23 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 11 Aug 2020 22:06:23 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Andi Kleen' <ak@linux.intel.com>
CC:     Peter Zijlstra <peterz@infradead.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Arnaldo Carvalho de Melo <acme@redhat.com>,
        Ingo Molnar <mingo@redhat.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Jiri Olsa <jolsa@kernel.org>,
        "alexey.budankov@linux.intel.com" <alexey.budankov@linux.intel.com>,
        "adrian.hunter@intel.com" <adrian.hunter@intel.com>
Subject: RE: [PATCH 1/2] perf: Add closing sibling events' file descriptors
Thread-Topic: [PATCH 1/2] perf: Add closing sibling events' file descriptors
Thread-Index: AQHWb+1snIoIlGwKoUSHzUM68Tmsxaky+9RQgAAnAgCAAEM5sA==
Date:   Tue, 11 Aug 2020 21:06:23 +0000
Message-ID: <457dfe5709e642bd9b462f4c36e8ed75@AcuMS.aculab.com>
References: <20200708151635.81239-1-alexander.shishkin@linux.intel.com>
 <20200708151635.81239-2-alexander.shishkin@linux.intel.com>
 <20200806083530.GV2674@hirez.programming.kicks-ass.net>
 <20200806153205.GA1448395@tassilo.jf.intel.com>
 <875z9q1u3g.fsf@ashishki-desk.ger.corp.intel.com>
 <20200810144518.GB1448395@tassilo.jf.intel.com>
 <20200810203632.GF3982@worktop.programming.kicks-ass.net>
 <20200811142955.GC1448395@tassilo.jf.intel.com>
 <9ff26c5231954e65bbd4873d54ebd727@AcuMS.aculab.com>
 <20200811180334.GH1448395@tassilo.jf.intel.com>
In-Reply-To: <20200811180334.GH1448395@tassilo.jf.intel.com>
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

> On Tue, Aug 11, 2020 at 02:47:03PM +0000, David Laight wrote:
> > From: Andi Kleen
> > > On Mon, Aug 10, 2020 at 10:36:32PM +0200, Peter Zijlstra wrote:
> > > > On Mon, Aug 10, 2020 at 07:45:18AM -0700, Andi Kleen wrote:
> > > >
> > > > > Unfortunately we're kind of stuck with the old NFILE=1024 default
> > > > > even though it makes little sense on modern servers.
> > > >
> > > > Why can't that be changed? It seems to me all of userspace changes all
> > > > the time; heck that system-doofus thing flushed 20+ years of sysadmin
> > > > experience down the drain, just cause. Why can't we up a file limit?
> > >
> > > We could try, but I believe it's hard coded in various places outside
> > > the kernel.
> >
> > The place it really bites is select().
> > Although the kernel supports large bitmaps glibc doesn't.
> > The random bit overwrites are a PITA to debug.
> 
> Good point.
> 
> I remember I asked for a simple define to increase like glibc5 had, but
> they still didn't implement that.

Even windows lets you redefine FDSET_SIZE before including the header.
And their select() is much more like poll() - so the limit is the number
of sockets, not the highest socket number (which do happen to be small
integers).

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

