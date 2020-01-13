Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E0C81C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BADF8207FD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 14:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728850AbgAMOeq convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 09:34:46 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:40233 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726074AbgAMOep (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 09:34:45 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-140-AwUQH5QOP_e8J5DRSiGalQ-1; Mon, 13 Jan 2020 14:34:43 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 13 Jan 2020 14:34:42 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 13 Jan 2020 14:34:42 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "'maarten.lankhorst@linux.intel.com'" 
        <maarten.lankhorst@linux.intel.com>,
        "'mripard@kernel.org'" <mripard@kernel.org>,
        "'sean@poorly.run'" <sean@poorly.run>,
        "'airlied@linux.ie'" <airlied@linux.ie>,
        "'daniel@ffwll.ch'" <daniel@ffwll.ch>,
        "'dri-devel@lists.freedesktop.org'" <dri-devel@lists.freedesktop.org>,
        "'linux-kernel@vger.kernel.org'" <linux-kernel@vger.kernel.org>
Subject: drm_cflush_sg() loops for over 3ms
Thread-Topic: drm_cflush_sg() loops for over 3ms
Thread-Index: AdXKGWEIeE2T2qdBRV+WPmYW5zRi/w==
Date:   Mon, 13 Jan 2020 14:34:42 +0000
Message-ID: <e2498e2794ab421bb27982b4c863e87f@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: AwUQH5QOP_e8J5DRSiGalQ-1
X-Mimecast-Spam-Score: 0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I've been looking at why some RT processes don't get scheduled promptly.
In my test the RT process's affinity ties it to a single cpu (this may not be such
a good idea as it seems).

What I've found is that the Intel i915 graphics driver uses the 'events_unbound'
kernel worker thread to periodically execute drm_cflush_sg().
(see https://github.com/torvalds/linux/blob/master/drivers/gpu/drm/drm_cache.c)

I'm guessing this is to ensure that any writes to graphics memory become
visible is a semi-timely manner.

This loop takes about 1us per iteration split fairly evenly between whatever is in
for_each_sg_page() and drm_cflush_page().
With a 2560x1440 display the loop count is 3600 (4 bytes/pixel) and the whole
function takes around 3.3ms.

Since the kernel isn't pre-emptive (I though that wasn't much harder than SMP)
nothing else can run on that cpu until the loop finishes.

Adding a cond_resched() to the loop (maybe every 64 iterations) will
allow higher priority processes to run.
But really the code needs to be a lot faster.

I actually suspect that the (I assume IPI based) wbinv_on_all_cpus() would be
a lot faster - especially done by a per-cpu work queue?

I had moderate difficulty getting from the process (kworker/u8:3) to the
name of the worker thread pool, never mind the actual work.
Fortunately it runs so long that some of the output from 'echo t >/proc/sysrq-trigger'
still linked the pid (which I knew from ftrace scheduler events (and schedviz))
to the actual work item name.
(Oh, after I'd written a program to tidy up the raw ftrace output so schedviz
didn't barf on a trace that had wrapped.)

Is there anything in /proc (etc) that shows all the work queues and their current
work?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

