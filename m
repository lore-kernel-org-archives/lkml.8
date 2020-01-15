Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53D68C33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:43:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22A932075B
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 14:43:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729076AbgAOOne convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 09:43:34 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:33723 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729037AbgAOOnd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 09:43:33 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-231-IfFknEpZP0yJZA75H2odGA-1; Wed, 15 Jan 2020 14:43:27 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 15 Jan 2020 14:43:26 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 15 Jan 2020 14:43:26 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>
CC:     'Vincent Guittot' <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        linux-kernel <linux-kernel@vger.kernel.org>
Subject: RE: sched/fair: scheduler not running high priority process on idle
 cpu
Thread-Topic: sched/fair: scheduler not running high priority process on idle
 cpu
Thread-Index: AdXK8cUFXa7JpPXmQNq7oQ32S9fYHAACik4AAADJLkAAAO3PAAAmXEggAAKDBAAAArEnQA==
Date:   Wed, 15 Jan 2020 14:43:26 +0000
Message-ID: <8421d8b6749c47d0a5519ddff5422e68@AcuMS.aculab.com>
References: <212fabd759b0486aa8df588477acf6d0@AcuMS.aculab.com>
        <20200114115906.22f952ff@gandalf.local.home>
        <5ba2ae2d426c4058b314c20c25a9b1d0@AcuMS.aculab.com>
        <20200114124812.4d5355ae@gandalf.local.home>
        <878a35a6642d482aa0770a055506bd5e@AcuMS.aculab.com>
 <20200115081830.036ade4e@gandalf.local.home>
In-Reply-To: <20200115081830.036ade4e@gandalf.local.home>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: IfFknEpZP0yJZA75H2odGA-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Steven Rostedt
> Sent: 15 January 2020 13:19
...
> BTW, I believe distros compile with "CONFIG_IRQ_FORCED_THREADING" which
> means if you add to the kernel command line "threadirqs" the interrupts
> will be run as threads. Which allows for even more preemption.

So they do...
I guess that'll stop the bh code running 'on top of' my RT thread.
But won't help getting the RT process running when the 'events_unbound'
kernel worker is running.

They also use grub2 which is so complicated update-grub is always used
which dumbs everything down to a default set that is hard to change.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

