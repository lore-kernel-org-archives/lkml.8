Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB0C8C3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:56:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B8F472187F
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 08:56:43 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387742AbgCDI4m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 03:56:42 -0500
Received: from Galois.linutronix.de ([193.142.43.55]:46279 "EHLO
        Galois.linutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727734AbgCDI4m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 03:56:42 -0500
Received: from p5de0bf0b.dip0.t-ipconnect.de ([93.224.191.11] helo=nanos.tec.linutronix.de)
        by Galois.linutronix.de with esmtpsa (TLS1.2:DHE_RSA_AES_256_CBC_SHA256:256)
        (Exim 4.80)
        (envelope-from <tglx@linutronix.de>)
        id 1j9PpX-00079c-Lj; Wed, 04 Mar 2020 09:56:39 +0100
Received: by nanos.tec.linutronix.de (Postfix, from userid 1000)
        id D9DFD101161; Wed,  4 Mar 2020 09:56:37 +0100 (CET)
From:   Thomas Gleixner <tglx@linutronix.de>
To:     "Eric W. Biederman" <ebiederm@xmission.com>, Qian Cai <cai@lca.pw>
Cc:     oleg@redhat.com, linux-kernel@vger.kernel.org
Subject: Re: [PATCH timers/core] posix-cpu-timers: Put the task_struct in posix_cpu_timers_create
In-Reply-To: <877e00hf08.fsf@x220.int.ebiederm.org>
Date:   Wed, 04 Mar 2020 09:56:37 +0100
Message-ID: <87wo80lcqi.fsf@nanos.tec.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Linutronix-Spam-Score: -1.0
X-Linutronix-Spam-Level: -
X-Linutronix-Spam-Status: No , -1.0 points, 5.0 required,  ALL_TRUSTED=-1,SHORTCIRCUIT=-0.0001
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

ebiederm@xmission.com (Eric W. Biederman) writes:

> Qian Cai <cai@lca.pw> writes:
>> The recent commit removed put_task_struct() in posix_cpu_timer_del()
>> results in many memory leaks like this,
>>
>> unreferenced object 0xc0000016d9b44480 (size 8192):
>>   comm "timer_create01", pid 57749, jiffies 4295163733 (age 6159.670s)
>>   hex dump (first 32 bytes):
>>     02 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00  ................
>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>   backtrace:
>>     [<0000000056aca129>] copy_process+0x26c/0x18e0
>>     alloc_task_struct_node at kernel/fork.c:169
>>     (inlined by) dup_task_struct at kernel/fork.c:877
>>     (inlined by) copy_process at kernel/fork.c:1929
>>     [<00000000bdbbf9f8>] _do_fork+0xac/0xb20
>>     [<00000000dcb1c445>] __do_sys_clone+0x98/0xe0
>>     __do_sys_clone at kernel/fork.c:2591
>>     [<000000006c059205>] ppc_clone+0x8/0xc
>>     ppc_clone at arch/powerpc/kernel/entry_64.S:479
>>
>
> I forgot that get_task_for_clock called by posix_cpu_timer_create
> returns a reference to a task_struct.  Put that reference
> to avoid the leak.

I took the liberty to fold this back into the affected commit and add a
comment why this put_task_struct() is actually required.

Thanks,

        tglx
