Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71B7CC433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:39:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4098F20792
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 15:39:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=gmx.net header.i=@gmx.net header.b="UMkzd58t"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728599AbgFKPjy (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 11 Jun 2020 11:39:54 -0400
Received: from mout.gmx.net ([212.227.17.20]:59183 "EHLO mout.gmx.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728104AbgFKPjx (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Jun 2020 11:39:53 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=gmx.net;
        s=badeba3b8450; t=1591889982;
        bh=duYddU7rZ/sCtC2hxJLn7gufkhi9vJTrZjvVF5a0TQ4=;
        h=X-UI-Sender-Class:From:To:Cc:Subject:References:Date:In-Reply-To;
        b=UMkzd58thGfJBde5a2CIRPH4Ee9AEmSr32w+3bLLP9w9mzhfQN4yk8WWYbsIv3Eut
         Z15JNaxojAmDuKx0E7RGYhKB8yTEIpV4191o3jKuMBKJ7GqTP9Syef5bIsTmlDhzB9
         alj5Z5x9CeFff7u0fHtGeEFnVSkxNqvhOtTzMG4k=
X-UI-Sender-Class: 01bb95c1-4bf8-414a-932a-4f6e2808ef9c
Received: from strobe-jhalfs ([178.6.148.191]) by mail.gmx.com (mrgmx104
 [212.227.17.168]) with ESMTPSA (Nemesis) id 1M72sJ-1jqpY91nl1-008deo; Thu, 11
 Jun 2020 17:39:42 +0200
From:   Stephen Berman <stephen.berman@gmx.net>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        linux-kernel@vger.kernel.org
Subject: Re: power-off delay/hang due to commit 6d25be57 (mainline)
References: <87bln7ves7.fsf@gmx.net>
        <20200506215713.qoo4enq32ckcjmz7@linutronix.de>
        <87v9l65d2y.fsf@gmx.net>
        <20200513220428.4nksinis2qs5dtmh@linutronix.de>
        <87mu6aurfn.fsf@gmx.net>
        <20200522164012.ynyvrjompv42jtmx@linutronix.de>
        <87y2owwo2o.fsf@rub.de>
        <20200609202339.cgy57twm2zdtjhje@linutronix.de>
        <87tuzjcovq.fsf@gmx.net>
        <20200610102514.4vdzu5u7d6vnpicn@linutronix.de>
        <87imfyh6yx.fsf@gmx.net>
Date:   Thu, 11 Jun 2020 17:39:40 +0200
In-Reply-To: <87imfyh6yx.fsf@gmx.net> (Stephen Berman's message of "Thu, 11
        Jun 2020 00:49:26 +0200")
Message-ID: <87wo4dligz.fsf@gmx.net>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/28.0.50 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-Provags-ID: V03:K1:YaG4ZGm00kCZCNwUK5e+OOIW7mUztVomXm6KpW7zOVhozRyidMB
 xQpFnWxqDIYCem3Iwc/EzAIkSc8hSrAnkTmRi57IdTleKwpnKE//nisOmWgBnzv2QNxdcyt
 9rdFM/sD+ICZJMNQ62h2moOIrgBP3iWMsjAJXPQ+MmAYcNQfUolP6BmRlDbyLnHldM0zytB
 Vs61qGUfJ+pStfNdHKzMA==
X-UI-Out-Filterresults: notjunk:1;V03:K0:yQZagXvcqfY=:4UQXG2Uf6qP/u34yuqp1B9
 8L7VgTk92n+k26DcDWABliOzxy4+dnA3k+mkhsc37sO9BNaTdF0D9Pu7jPYwgrAOFasN+jzDs
 3za94iwHPFX8HiehGInojBSfgjx7gzTwtWcDvHupl4H716uTQ+TfiZbyetQwFpSvHcze32omo
 Q0BEX3TQvIOlwqatJI8SRQepvNl6iwGEW38an4Vsbkrq2Sl9j0lxA37rlnJOKymfxMj+Yvuvf
 7zZMxIbMfPKaVWsx//G2lfjvWCB6I4RtAmNOIlh9F6tuTbVXL/AD8zJ451iiaxywnnzD8qN1w
 IJn5KLn6Gnf2UewKtbMG8Tbr09fozH2GwnTAIgNvbwISBZzcn06LhB+HX5Guqm2lIVtvuVbQ8
 QiaVe9k7kAamBZew4xrXnbpWRv43ugGegsZAwU24LwGExUdx1FuHBKpAMxPDuTn51jNPC6567
 URvvPOOL1zbBMX5PcOBDG6bcWvf5Tt/RkyPF5/DVAkArgXQGWV/Nb2FrKy4YMbOHG/zUKLKkO
 VcYpWdjW8pXZCziI1idws0lhiOktxsbYC/P4ZcHnuW/ZDOA/s+6JEqQJWT4kExJOCSBvMjECw
 0at6TAjIkF8695FYW1pUf2TiUmuAfCd2bIXTzTRE0M1bZH44CVvYLeFBPA5TuIQL48vAJ1tgr
 b1x4xjw2XXhllKiaVFQafBzU6I4DqYJ2QR+lmRTKS2doKrnpSq8079sKdSqrgMyj8puO0dVWF
 SjdJyzDbo9IHsOtsGysJ7qyDiWAg2i+7J4feN3enXlNOpD9ITE7eZlLvOJgC8HDfblYc6CiPO
 g+WexSnyCK6saYxbiF7PLhQT6Kj3qiD4hPc4HrmspM82b7OIQ8w8+Jo6rqXVQpqTyRgrOVqUK
 Z6LYRpVMVs1ypJvzV5CLJPFYPUW+o7u6IytaYlzwmNjhdADQjKaBjdxH1esk4K1a86Q/OZk0O
 vxJdjnK8G06As0cLV/KoYCw38IJHfgd8WunoN4FiJEQ4XaVSXDZUJ8Gb5xuWgZEyRI2YURsKr
 VCQM5AlEg7HPo95YPJgZlmbc8oQNx457dmv26j/XZImlEpFKcxxhWAMfuau8Q0QDhagcQRwXW
 1IcsgzzPW6n4X+4X3tW/RZ4pkj7LdfE1SmxMehsA7iF9dvsAxwFM8NTKfYX4jO2qtNbtG5cIc
 9E1KiLtCk6NWRFoDne+L0jBeA+lAtZ7PAO/R/0gajX469t4oJWZKfs8TalufOqiIuVf/psLmN
 sFs71bB/0rmHG3g3m
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 11 Jun 2020 00:49:26 +0200 Stephen Berman <stephen.berman@gmx.net> wrote:

> On Wed, 10 Jun 2020 12:25:14 +0200 Sebastian Andrzej Siewior
> <bigeasy@linutronix.de> wrote:
> [...]
>>> By the other patch do you mean the following?  (This email was also put
>>> into my spam by GMX and AFAICT has not yet shown up on the vger list.)
>>
>> Yes. But now that I played a little with it, I made dis:
> [...]
>> So you should have output like:
>> |[   14.131696] Flushing events_freezable_power_
>> the flush that hangs
>>
>> |[   17.203246] Flushing events_freezable_power_ over, 0
>> It has been noticed (0 at the end)
>>
>> |[   17.203849] Showing busy workqueues and worker pools:
>> |[   17.204400] workqueue events_freezable_power_: flags=0x84
>> |[   17.205009]   pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
>> |[   17.205774]     in-flight: 2147:disk_events_workfn
>> |[   17.206268] workqueue kblockd: flags=0x18
>> |[   17.206682]   pwq 13: cpus=6 node=0 flags=0x0 nice=-20 active=1/256 refcnt=2
>> |[   17.207428]     pending: blk_mq_requeue_work
>> |[ 17.207958] pool 12: cpus=6 node=0 flags=0x0 nice=0 hung=2s workers=3 idle:
>> | 535 42
>>
>> A dump of all pending worqueue items.
>>
>> |[   20.275239] Flushing events_freezable_power_ over, 0
>> |[   20.275812] Showing busy workqueues and worker pools:
>> |[   20.276385] workqueue events_freezable_power_: flags=0x84
>> |[   20.276972]   pwq 12: cpus=6 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
>> |[   20.277712]     in-flight: 2147:disk_events_workfn
>> |[   20.278245] workqueue kblockd: flags=0x18
>> |[   20.278685]   pwq 13: cpus=6 node=0 flags=0x0 nice=-20 active=1/256 refcnt=2
>> |[   20.279471]     pending: blk_mq_requeue_work
>> |[ 20.279989] pool 12: cpus=6 node=0 flags=0x0 nice=0 hung=5s workers=3 idle:
>> | 535 42
>>
>> Another atempt. As you see `blk_mq_requeue_work' is references in both
>> outputs but it makes progress (it is scheduled multiple times). The item
>> `disk_events_workfn' stucks.
>
> I rebuilt kernel 5.6.4 with that patch, but before calling `shutdown -h
> now' I guess I should have set printk_delay, because this time there was
> a lot of output and it went by too fast.  I'll try to delay it the next
> time.

I've done that now.  I've sent you screenshots offlist.  Here's a brief
summary: The initial shutdown log output is essentially the same as the
transcription I posted upthread, except that it is interspersed with
messages from your patch like "Flush hid_reset+0x0/0x80".  Then comes:

ACPI: Preparing to enter system sleep state S5
Flushing kacpid
Flushing kacpid_notify
Flushing kacpid_notify over, 0
Showing busy workqueues and worker pools:
workqueue events: flags=0x0
  pwq 4: cpus=2 node=0 flags=0x0 nice=0 active=1/256 refcnt=2
     pending: drm_fb_helper_diry_work
workqueue kacpid_notify: flags=0x0
  pwq 0: cpus=0 node=0 flags=0x0 nice=0 active=1/1 refcnt=4185
     in-flight: 1578:acpi_os_execute_deferred
     delayed: acpi_os_execute_deferred, acpi_os_execute_deferred, ...

The "acpi_os_execute_deferred" messages were repeated many times in the
above line, then every 20-30 seconds again for several minutes.  Then
suddenly a call trace appeared which was similar but not identical to
the one I posted upthread, and each line of the trace was followed by
the line ", acpi_os_execute_deferred".  This went by quite quickly even
with the printk_delay I added, and I was unable to photograph the start
of it and couldn't get all of the subsequent output, but the screenshots
show some of it.  After several minutes of this output I again did a
hard reboot.

Steve Berman
