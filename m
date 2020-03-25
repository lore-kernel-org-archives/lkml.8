Return-Path: <SRS0=vy7l=5K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3544FC2D0E5
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 18:05:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1928E20777
	for <linux-kernel@archiver.kernel.org>; Wed, 25 Mar 2020 18:05:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727895AbgCYSFb convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 25 Mar 2020 14:05:31 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([146.101.78.151]:37399 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726820AbgCYSFb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 Mar 2020 14:05:31 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-119-4aYfkUtjPiqI5hRXUU8wVw-1; Wed, 25 Mar 2020 18:05:28 +0000
X-MC-Unique: 4aYfkUtjPiqI5hRXUU8wVw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 25 Mar 2020 18:05:27 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 25 Mar 2020 18:05:27 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Marcelo Tosatti' <mtosatti@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>
CC:     Chris Friesen <chris.friesen@windriver.com>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "Christoph Lameter" <cl@linux.com>,
        Jim Somerville <Jim.Somerville@windriver.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Frederic Weisbecker <fweisbec@gmail.com>,
        Peter Zijlstra <peterz@infradead.org>
Subject: RE: [PATCH v2] isolcpus: affine kernel threads to specified cpumask
Thread-Topic: [PATCH v2] isolcpus: affine kernel threads to specified cpumask
Thread-Index: AQHWAe/VaQ9sFT2YFEq1MC0lycC6lqhZmykw
Date:   Wed, 25 Mar 2020 18:05:27 +0000
Message-ID: <b88327780661496fbee6d8ebe2e0d965@AcuMS.aculab.com>
References: <20200323135414.GA28634@fuller.cnet>
 <87k13boxcn.fsf@nanos.tec.linutronix.de>
 <af285c22-2a3f-5aa6-3fdb-27fba73389bd@windriver.com>
 <87imiuq0cg.fsf@nanos.tec.linutronix.de> <20200324152016.GA25422@fuller.cnet>
In-Reply-To: <20200324152016.GA25422@fuller.cnet>
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

From: Marcelo Tosatti
> Sent: 24 March 2020 15:20
> 
> This is a kernel enhancement to configure the cpu affinity of kernel
> threads via kernel boot option isolcpus=no_kthreads,<isolcpus_params>,<cpulist>
> 
> When this option is specified, the cpumask is immediately applied upon
> thread launch. This does not affect kernel threads that specify cpu
> and node.
> 
> This allows CPU isolation (that is not allowing certain threads
> to execute on certain CPUs) without using the isolcpus=domain parameter,
> making it possible to enable load balancing on such CPUs
> during runtime
...

How about making it possible to change the default affinity
for new kthreads at run time?
Is it possible to change the affinity of existing threads?
Or maybe only those that didn't specify an explicit one??

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

