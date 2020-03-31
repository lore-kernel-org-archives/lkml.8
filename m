Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	UNWANTED_LANGUAGE_BODY autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E60E1C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:52:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C2BD6206F5
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 13:52:28 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731118AbgCaNw1 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 09:52:27 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:23089 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730720AbgCaNwZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 09:52:25 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-122-FVNKL88IOG6sB4dqNWkibw-1; Tue, 31 Mar 2020 14:52:22 +0100
X-MC-Unique: FVNKL88IOG6sB4dqNWkibw-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Tue, 31 Mar 2020 14:52:21 +0100
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Tue, 31 Mar 2020 14:52:21 +0100
From:   David Laight <David.Laight@ACULAB.COM>
To:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Subject: [RFC PATCH 11/12] fs:io_uring: Remove #defines added for bisection.
Thread-Topic: [RFC PATCH 11/12] fs:io_uring: Remove #defines added for
 bisection.
Thread-Index: AdYHYzIoB2cZDalwSka88IaGUSKwXA==
Date:   Tue, 31 Mar 2020 13:52:21 +0000
Message-ID: <401b481ca75544d79f85df616f5118ab@AcuMS.aculab.com>
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


Signed-off-by: David Laight <david.laight@aculab.com>
---
 fs/io_uring.c | 4 ----
 1 file changed, 4 deletions(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 27d66cf..7b71b50 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -77,10 +77,6 @@
 #include <linux/eventpoll.h>
 #include <linux/fs_struct.h>
 
-/* Temporary for commit bisection */
-#define sendmsg_copy_msghdr(a, b, c, d) sendmsg_copy_msghdr(a, b, c, (void *)d)
-#define recvmsg_copy_msghdr(a, b, c, d, e) recvmsg_copy_msghdr(a, b, c, d, (void *)e)
-
 #define CREATE_TRACE_POINTS
 #include <trace/events/io_uring.h>
 
-- 
1.8.1.2

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

