Return-Path: <SRS0=1cir=3Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3BDC9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:39:29 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 14A1921739
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jan 2020 15:39:29 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729632AbgA0Pj2 convert rfc822-to-8bit (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jan 2020 10:39:28 -0500
Received: from eu-smtp-delivery-151.mimecast.com ([207.82.80.151]:26169 "EHLO
        eu-smtp-delivery-151.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729146AbgA0Pj2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jan 2020 10:39:28 -0500
Received: from AcuMS.aculab.com (156.67.243.126 [156.67.243.126]) (Using
 TLS) by relay.mimecast.com with ESMTP id
 uk-mta-150-8MnTs0AvPaqL8Lj0TxP4uA-1; Mon, 27 Jan 2020 15:39:24 +0000
Received: from AcuMS.Aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) by
 AcuMS.aculab.com (fd9f:af1c:a25b:0:43c:695e:880f:8750) with Microsoft SMTP
 Server (TLS) id 15.0.1347.2; Mon, 27 Jan 2020 15:39:24 +0000
Received: from AcuMS.Aculab.com ([fe80::43c:695e:880f:8750]) by
 AcuMS.aculab.com ([fe80::43c:695e:880f:8750%12]) with mapi id 15.00.1347.000;
 Mon, 27 Jan 2020 15:39:24 +0000
From:   David Laight <David.Laight@ACULAB.COM>
To:     'Steven Rostedt' <rostedt@goodmis.org>
CC:     'linux-kernel' <linux-kernel@vger.kernel.org>
Subject: sched/fair: Long delays starting RT processes on idle cpu.
Thread-Topic: sched/fair: Long delays starting RT processes on idle cpu.
Thread-Index: AdXVJQ5JxcyiG/NbTmiWGSKnntaALg==
Date:   Mon, 27 Jan 2020 15:39:24 +0000
Message-ID: <13797bbe87b64f34877b89a5bbdb6d03@AcuMS.aculab.com>
Accept-Language: en-GB, en-US
Content-Language: en-US
X-MS-Has-Attach: 
X-MS-TNEF-Correlator: 
x-ms-exchange-transport-fromentityheader: Hosted
x-originating-ip: [10.202.205.107]
MIME-Version: 1.0
X-MC-Unique: 8MnTs0AvPaqL8Lj0TxP4uA-1
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: aculab.com
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8BIT
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

I'm seeing long delays (eg up to 90us) between a process being scheduled on an idle cpu
and the process actually executing.

This is an ivy bridge cpu:
model name      : Intel(R) Core(TM) i7-3770 CPU @ 3.40GHz

[    0.583178] intel_idle: MWAIT substates: 0x1120
[    0.583178] intel_idle: v0.4.1 model 0x3A
[    0.583293] intel_idle: lapic_timer_reliable_states 0xffffffff

I picked one wakeup out of some ftrace data.
A short extract:
Process 10318 (the one that is woken) goes to sleep.
...
          <idle>-0     [003] d... 945687.207448: sched_idle_set_state <-cpuidle_enter_state
          <idle>-0     [003] d... 945687.207449: intel_idle <-cpuidle_enter_state
          <idle>-0     [003] d... 945687.207449: leave_mm <-intel_idle
          <idle>-0     [003] d... 945687.207449: switch_mm <-intel_idle
          <idle>-0     [003] d... 945687.207449: switch_mm_irqs_off <-switch_mm

I think cpu-3 is now executing the MWAIT from mwait_idle_with_hints()
called from intel_idle() in drivers/idle/intel_idle.c.

Not much happens on any of the cpu for 10ms until a process wakes up from a timed delay
and then tries to wake up the other threads.

    ProsodySServ-10319 [000] d... 945687.217414: sched_wakeup: comm=ProsodySServ pid=10318 prio=3 target_cpu=003
    ProsodySServ-10319 [000] d... 945687.217414: task_woken_rt <-ttwu_do_wakeup
    ProsodySServ-10319 [000] d... 945687.217414: _raw_spin_unlock_irqrestore <-try_to_wake_up
    ProsodySServ-10319 [000] .... 945687.217414: drop_futex_key_refs.isra.14 <-futex_wake

I presume the above is supposed to have done a memory write that wakes the MWAIT.

There is now a long delay (26us here) before anything happens.
          <idle>-0     [003] dN.. 945687.217440: sched_idle_set_state <-cpuidle_enter_state
...
          <idle>-0     [003] d... 945687.217447: sched_switch: prev_comm=swapper/3 prev_pid=0 prev_prio=120 prev_state=R ==> next_comm=ProsodySServ next_pid=10318 next_prio=3

I'd have thought that the processor should wake up much faster than that.
I can't see the memory write that is paired with the monitor/mwait.
Does it need a strong barrier?

	David

-
Registered Address Lakeside, Bramley Road, Mount Farm, Milton Keynes, MK1 1PT, UK
Registration No: 1397386 (Wales)

