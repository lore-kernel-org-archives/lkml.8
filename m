Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6CEFFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:50:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 47E122075B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 06:50:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="fRJR1apC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729845AbgGHGuz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 02:50:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726171AbgGHGuy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 02:50:54 -0400
Received: from mail-wr1-x442.google.com (mail-wr1-x442.google.com [IPv6:2a00:1450:4864:20::442])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA0F3C061755
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jul 2020 23:50:53 -0700 (PDT)
Received: by mail-wr1-x442.google.com with SMTP id f18so39579763wrs.0
        for <linux-kernel@vger.kernel.org>; Tue, 07 Jul 2020 23:50:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zm6LHmqeNQ0tcaxZkaeCIIqRwFN7FjZi4Lduc1JwYJk=;
        b=fRJR1apC9tP8lVYdn3j4PJ1yriSkx4Mt/WuV+b80+RA5Xq3ntT4+aLgGJ/Uqjhuu4g
         7p9Mw1I2xkXOBppdQUM6I7EnIn9CzudChZM/tfIIOdv/CtjkGEoXp2PPgDOqmxv/xGwR
         mI+bT8lPb3qnqIfm1kvu5lm1qhNEtd0Amt/dqtoJIOEZUDSOi/R3Ja8C+BkQHDYY65IY
         zxusbVJ+N0GvjPkUD6Ow4kxwuOJk6se/RzCw7BM9O8rocL4wFRoG4aWvbMNV3xCm0Ceu
         ikUUmNmQ/kFzvMOZL8Grj/OFrW63cMbAlRNxIGAyJDwzOFjvnNCargZyG/oJhF/XUFMU
         EEFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:subject:from:in-reply-to:date:cc
         :content-transfer-encoding:message-id:references:to;
        bh=zm6LHmqeNQ0tcaxZkaeCIIqRwFN7FjZi4Lduc1JwYJk=;
        b=iJIZ0+JP/Er5pSaWbGW49n7zbA0kDHcWiT0b5kfi1/NjZlnLaxdhZrnBwY6yEvp3ti
         3zfAwudd6DWJQpsPjharzd/NXBdtiHFSdPAZXy9epRPHfCD4RyxHRr+6t5SViFC3oKut
         2ZdskscwdnYx2xePzNmN3SxlOGpzvxlbR8uoUqd1KKlxaiQSxP78JOCYkC1ZGCUtxOYG
         9Gy8bsAZCqXLGMCdgRhyct+cjr8gP41bwQKowGhN8kh6ZsoXIEWgpWjejXQNsakU7rqU
         X/aUbetIqgVOL3LeH2y6DsNv6FIabA+T8+1DGx8f6WBXzoQegvE7jTTFoCg+u7rdYz4t
         ZPvA==
X-Gm-Message-State: AOAM531RGpBg/QUN6wOUIl9VmSAarhmqTHJcrJF8XuCNrG3g+qizz7bl
        LuiQAPMcdm1FjlgNDOsApzOKVfGN
X-Google-Smtp-Source: ABdhPJz2R/+cNsDoIeb/g3pbJMV0I/TpK9H1ghfQndVC4WYYtbaXYBA44Liru39lOiaK2EeEVtbLkg==
X-Received: by 2002:adf:e6c8:: with SMTP id y8mr60478903wrm.40.1594191052272;
        Tue, 07 Jul 2020 23:50:52 -0700 (PDT)
Received: from [10.11.11.4] ([178.254.237.20])
        by smtp.gmail.com with ESMTPSA id q1sm4114745wro.82.2020.07.07.23.50.50
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Tue, 07 Jul 2020 23:50:51 -0700 (PDT)
Content-Type: text/plain;
        charset=us-ascii
Mime-Version: 1.0 (Mac OS X Mail 13.4 \(3608.80.23.2.2\))
Subject: Re: Bug Report High CPU Usage events_power_efficient
From:   Martin Zaharinov <micron10@gmail.com>
In-Reply-To: <6AD52867-83C1-4C6C-A0AE-4DE0D6C16310@gmail.com>
Date:   Wed, 8 Jul 2020 09:50:49 +0300
Cc:     gregkh@linuxfoundation.org, Florian Westphal <fw@strlen.de>,
        Eric Dumazet <edumazet@google.com>
Content-Transfer-Encoding: quoted-printable
Message-Id: <C89D167C-E03F-4116-9647-F50607DF3A45@gmail.com>
References: <E2C5FE67-C85E-469C-9B81-10F7555F836B@gmail.com>
 <91805D0F-2D74-4EA3-A2D7-13E4FBBEAB51@gmail.com>
 <6AD52867-83C1-4C6C-A0AE-4DE0D6C16310@gmail.com>
To:     "linux-kernel@vger kernel. org" <linux-kernel@vger.kernel.org>
X-Mailer: Apple Mail (2.3608.80.23.2.2)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add Greg , Florian, Eric to this bug=20

> On 7 Jul 2020, at 22:54, Martin Zaharinov <micron10@gmail.com> wrote:
>=20
> And this is log from /sys/kernel/debug/tracing/trace
>=20
>=20
> # entries-in-buffer/entries-written: 32410/32410   #P:64
> #
> #                              _-----=3D> irqs-off
> #                             / _----=3D> need-resched
> #                            | / _---=3D> hardirq/softirq
> #                            || / _--=3D> preempt-depth
> #                            ||| /     delay
> #           TASK-PID   CPU#  ||||    TIMESTAMP  FUNCTION
> #              | |       |   ||||       |         |
>           <...>-57259 [005] .... 29619.680698: =
workqueue_execute_start: work struct 00000000ef22e4b8: function =
gc_worker [nf_conntrack]
>           <...>-57259 [005] .... 29623.811407: workqueue_execute_end: =
work struct 00000000ef22e4b8: function gc_worker [nf_conntrack]
>           <...>-57259 [005] .... 29623.811410: =
workqueue_execute_start: work struct 0000000000aeec55: function =
fb_flashcursor
>           <...>-57259 [005] .... 29623.811421: workqueue_execute_end: =
work struct 0000000000aeec55: function fb_flashcursor
>           <...>-57259 [005] .... 29623.811422: =
workqueue_execute_start: work struct 00000000a6d382bb: function =
vmstat_update
>           <...>-57259 [005] .... 29623.811435: workqueue_execute_end: =
work struct 00000000a6d382bb: function vmstat_update
>=20
>> On 7 Jul 2020, at 22:44, Martin Zaharinov <micron10@gmail.com> wrote:
>>=20
>> the problem is hear with kernel 5.7.7=20
>>=20
>> last work kernel without this problem is 5.6.7
>>=20
>> hear is more info:
>>=20
>> cat /proc/57259/stack
>> root@megacableamarilis:~# cat /proc/57259/stack
>> [<0>] gc_worker+0x1be/0x380 [nf_conntrack]
>> [<0>] process_one_work+0x1bc/0x3b0
>> [<0>] worker_thread+0x4d/0x460
>> [<0>] kthread+0x10d/0x130
>> [<0>] ret_from_fork+0x1f/0x30
>>=20
>> PID USER      PR  NI    VIRT    RES    SHR S  %CPU  %MEM     TIME+ =
COMMAND                            57259 root      28   0       0      0 =
     0 R  69.8   0.0  82:42.14 kworker/5:2+events_power_efficient        =
                                                 =20
>> 32 root      21   0       0      0      0 R  31.0   0.0  87:06.33 =
ksoftirqd/4
>>=20
>>=20
>> Please help to fix this problem
>>=20
>>> On 22 Apr 2020, at 15:55, Martin Zaharinov <micron10@gmail.com> =
wrote:
>>>=20
>>> Hello Qian and Greg=20
>>> With latest 5.6.x kernel have problem with events_power_efficient =
28488 root      28   0       0      0      0 R  95.5   0.0 101:38.19 =
kworker/2:1+events_power_efficient Process start to load machine after =
3-4 hour and load not stop only reboot machine remove process . Server =
runing on AMD EPIC CPU 2x 7301 32Gb Ram Have 2 x 10G card Intel when =
machine load over 1G traffic machine locked and only restart fix problem =
to next load . After move traffic and server stop load process still =
hear and load server ?
>>> And after reboot process move to other core .
>>>=20
>>> Best Regards,
>>> Martin
>>=20
>=20

