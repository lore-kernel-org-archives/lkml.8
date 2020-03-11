Return-Path: <SRS0=Ktsx=44=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C244FC10F27
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:33:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE54620575
	for <linux-kernel@archiver.kernel.org>; Wed, 11 Mar 2020 14:33:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729862AbgCKOdz convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 11 Mar 2020 10:33:55 -0400
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:28374 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729782AbgCKOdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 Mar 2020 10:33:55 -0400
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-212-tcFhMaTpPPaYrkadpV6kaQ-1; Wed, 11 Mar 2020 14:33:52 +0000
X-MC-Unique: tcFhMaTpPPaYrkadpV6kaQ-1
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Wed, 11 Mar 2020 14:33:51 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Wed, 11 Mar 2020 14:33:51 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: synchronise_rcu() takes 18ms on an idle system
Thread-Topic: synchronise_rcu() takes 18ms on an idle system
Thread-Index: AdX3rf728sxj7DTIRpm0TGfIQRqntg==
Date:   Wed, 11 Mar 2020 14:33:51 +0000
Message-ID: <680f63f0c08544808061d5f37893eddf@AcuMS.aculab.com>
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

I'm looking into some scheduling delays in application that does
audio processing.

The code calls sys_perf_event_open() (to get a cycle counter).
After static_key_enable() has done some text_poke()s
the code calls synchronise_rcu().
This is all not unreasonable.

__wait_rcu_gp() then calls wait_for_completion().
Which sleeps in schedule_timeout().

At this point I'd expect the 'rcu' to complete pretty quickly.

However my process doesn't get scheduled again for 18ms.
The actual wakeup seems to be from smp_apic_timer_interrupt().
Probably because rcu_core_si() called wakeup_after_rcu() an
then complete().

I think I understand 'rcu', I thought any code relying on it
had to disable pre-emption - so that a process switch on
every cpu was more then enough to release the waiter.

In this case my 4 cpu are largely idle.

Waiting 18ms seems odd, I'm pretty sure I've seen softint
callbacks running for well over 1ms it isn't long enough
for a slow system - but is too long for a fast one.

This is a 5.4-rc7 kernel with CONFIG_HZ=250.

Now I can mitigate this particular case by calling
sys_perf_event_open() much earlier.
But any other calls are problematic.

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

