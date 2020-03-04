Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3DFDEC3F2D1
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:36:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1A88220848
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 14:36:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729484AbgCDOgM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 09:36:12 -0500
Received: from out02.mta.xmission.com ([166.70.13.232]:45264 "EHLO
        out02.mta.xmission.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726561AbgCDOgM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 09:36:12 -0500
Received: from in01.mta.xmission.com ([166.70.13.51])
        by out02.mta.xmission.com with esmtps (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.90_1)
        (envelope-from <ebiederm@xmission.com>)
        id 1j9V86-0007Lq-7y; Wed, 04 Mar 2020 07:36:10 -0700
Received: from ip68-227-160-95.om.om.cox.net ([68.227.160.95] helo=x220.xmission.com)
        by in01.mta.xmission.com with esmtpsa (TLS1.2:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.87)
        (envelope-from <ebiederm@xmission.com>)
        id 1j9V6V-0005fb-RG; Wed, 04 Mar 2020 07:36:08 -0700
From:   ebiederm@xmission.com (Eric W. Biederman)
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     Qian Cai <cai@lca.pw>, oleg@redhat.com,
        linux-kernel@vger.kernel.org
References: <87wo80lcqi.fsf@nanos.tec.linutronix.de>
Date:   Wed, 04 Mar 2020 08:32:22 -0600
In-Reply-To: <87wo80lcqi.fsf@nanos.tec.linutronix.de> (Thomas Gleixner's
        message of "Wed, 04 Mar 2020 09:56:37 +0100")
Message-ID: <87lfogfax5.fsf@x220.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/26.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1j9V6V-0005fb-RG;;;mid=<87lfogfax5.fsf@x220.int.ebiederm.org>;;;hst=in01.mta.xmission.com;;;ip=68.227.160.95;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX18ZxI6RGtjE7slLwFYskhXIghFEN64IuMA=
X-SA-Exim-Connect-IP: 68.227.160.95
X-SA-Exim-Mail-From: ebiederm@xmission.com
Subject: Re: [PATCH timers/core] posix-cpu-timers: Put the task_struct in posix_cpu_timers_create
X-SA-Exim-Version: 4.2.1 (built Thu, 05 May 2016 13:38:54 -0600)
X-SA-Exim-Scanned: Yes (on in01.mta.xmission.com)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thomas Gleixner <tglx@linutronix.de> writes:

> ebiederm@xmission.com (Eric W. Biederman) writes:
>
>> Qian Cai <cai@lca.pw> writes:
>>> The recent commit removed put_task_struct() in posix_cpu_timer_del()
>>> results in many memory leaks like this,
>>>
>>> unreferenced object 0xc0000016d9b44480 (size 8192):
>>>   comm "timer_create01", pid 57749, jiffies 4295163733 (age 6159.670s)
>>>   hex dump (first 32 bytes):
>>>     02 00 00 00 00 00 00 00 10 00 00 00 00 00 00 00  ................
>>>     00 00 00 00 00 00 00 00 00 00 00 00 00 00 00 00  ................
>>>   backtrace:
>>>     [<0000000056aca129>] copy_process+0x26c/0x18e0
>>>     alloc_task_struct_node at kernel/fork.c:169
>>>     (inlined by) dup_task_struct at kernel/fork.c:877
>>>     (inlined by) copy_process at kernel/fork.c:1929
>>>     [<00000000bdbbf9f8>] _do_fork+0xac/0xb20
>>>     [<00000000dcb1c445>] __do_sys_clone+0x98/0xe0
>>>     __do_sys_clone at kernel/fork.c:2591
>>>     [<000000006c059205>] ppc_clone+0x8/0xc
>>>     ppc_clone at arch/powerpc/kernel/entry_64.S:479
>>>
>>
>> I forgot that get_task_for_clock called by posix_cpu_timer_create
>> returns a reference to a task_struct.  Put that reference
>> to avoid the leak.
>
> I took the liberty to fold this back into the affected commit and add a
> comment why this put_task_struct() is actually required.

Good enough.

We should be able to use rcu and remove the reference entirely.
But that is a change for another day.

Eric
