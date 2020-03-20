Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_2 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1ECEFC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:06:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DAE9620777
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 18:06:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726982AbgCTSGV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 14:06:21 -0400
Received: from mail.kernel.org ([198.145.29.99]:58766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726814AbgCTSGV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 14:06:21 -0400
Received: from gandalf.local.home (cpe-66-24-58-225.stny.res.rr.com [66.24.58.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E6C7D20739;
        Fri, 20 Mar 2020 18:06:19 +0000 (UTC)
Date:   Fri, 20 Mar 2020 14:06:18 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Lucas Stach <l.stach@pengutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Subject: Re: help needed in debugging missed wakeup(?)
Message-ID: <20200320140618.048714c9@gandalf.local.home>
In-Reply-To: <c74744cc78cab34f3be8b547b7ff3cd6769d299b.camel@pengutronix.de>
References: <c74744cc78cab34f3be8b547b7ff3cd6769d299b.camel@pengutronix.de>
X-Mailer: Claws Mail 3.17.3 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 20 Mar 2020 18:02:32 +0100
Lucas Stach <l.stach@pengutronix.de> wrote:

> Hi sched people,
> 
> I'm currently debugging something which looks like a missed wakeup and
> involves a rt_mutex (no RT kernel though, this is mainline i2c bus
> locking). The issue seems to be a race condition, as we are seeing it
> on around 5% population of a 300 devices test field all running the
> same load. I was only able to reproduce the issue twice in pretty long
> testing sessions on a single device and was able to gather some debug
> info, but running out of ideas where to look next. Hopefully someone
> around here is able to provide me some fruther clues.
> 
> The obvious thing which the kernel lockup detector is able to find is
> the sogov (schedutil governor frequency switching task) being blocked:
> 
> INFO: task sugov:0:299 blocked for more than 30 seconds.
> Not tainted 5.4.22 #3
> "echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
> sugov:0         D    0   299      2 0x00000000
> Backtrace: 
> [<80b306f8>] (__schedule) from [<80b30df8>] (schedule+0xa4/0xdc)
> [<80b30d54>] (schedule) from [<80b34084>] (__rt_mutex_slowlock+0x104/0x17c)
> [<80b33f80>] (__rt_mutex_slowlock) from [<80b34254>] (rt_mutex_slowlock+0x158/0x224)
> [<80b340fc>] (rt_mutex_slowlock) from [<80b34390>] (rt_mutex_lock_nested+0x70/0x7c)
> [<80b34320>] (rt_mutex_lock_nested) from [<807abf20>] (i2c_adapter_lock_bus+0x28/0x2c)
> [<807abef8>] (i2c_adapter_lock_bus) from [<807ae924>] (i2c_transfer+0x124/0x13c)
> [<807ae800>] (i2c_transfer) from [<807ae994>] (i2c_transfer_buffer_flags+0x58/0x80)
> [<807ae93c>] (i2c_transfer_buffer_flags) from [<80681a0c>] (regmap_i2c_write+0x24/0x40)
> [<806819e8>] (regmap_i2c_write) from [<8067cccc>] (_regmap_raw_write_impl+0x5d8/0x714)
> [<8067c6f4>] (_regmap_raw_write_impl) from [<8067ce98>] (_regmap_bus_raw_write+0x90/0x98)
> [<8067ce08>] (_regmap_bus_raw_write) from [<8067c4a0>] (_regmap_write+0x184/0x1cc)
> [<8067c31c>] (_regmap_write) from [<8067c5d4>] (_regmap_update_bits+0xec/0xfc)
> [<8067c4e8>] (_regmap_update_bits) from [<8067d884>] (regmap_update_bits_base+0x60/0x84)
> [<8067d824>] (regmap_update_bits_base) from [<80575468>] (regulator_set_voltage_sel_regmap+0x54/0x90)
> [<80575414>] (regulator_set_voltage_sel_regmap) from [<80570130>] (_regulator_call_set_voltage_sel+0x78/0xb4)
> [<805700b8>] (_regulator_call_set_voltage_sel) from [<80570784>] (_regulator_do_set_voltage+0x460/0x658)
> [<80570324>] (_regulator_do_set_voltage) from [<80573fa4>] (regulator_set_voltage_rdev+0x12c/0x1fc)
> [<80573e78>] (regulator_set_voltage_rdev) from [<80571dec>] (regulator_balance_voltage+0xf8/0x498)
> [<80571cf4>] (regulator_balance_voltage) from [<80573e64>] (regulator_set_voltage_unlocked+0xf4/0x108)
> [<80573d70>] (regulator_set_voltage_unlocked) from [<80573fc8>] (regulator_set_voltage_rdev+0x150/0x1fc)
> [<80573e78>] (regulator_set_voltage_rdev) from [<80571dec>] (regulator_balance_voltage+0xf8/0x498)
> [<80571cf4>] (regulator_balance_voltage) from [<80573e64>] (regulator_set_voltage_unlocked+0xf4/0x108)
> [<80573d70>] (regulator_set_voltage_unlocked) from [<805740c4>] (regulator_set_voltage+0x50/0x84)
> [<80574074>] (regulator_set_voltage) from [<807fe00c>] (regulator_set_voltage_tol.constprop.0+0x1c/0x38)
> [<807fdff0>] (regulator_set_voltage_tol.constprop.0) from [<807fe37c>] (imx6q_set_target+0x354/0x404)
> [<807fe028>] (imx6q_set_target) from [<807f96d8>] (__cpufreq_driver_target+0x254/0x300)
> [<807f9484>] (__cpufreq_driver_target) from [<8017ec98>] (sugov_work+0x5c/0x68)
> [<8017ec3c>] (sugov_work) from [<80154df4>] (kthread_worker_fn+0x178/0x214)
> [<80154c7c>] (kthread_worker_fn) from [<801553d0>] (kthread+0x120/0x130)
> [<801552b0>] (kthread) from [<801010b4>] (ret_from_fork+0x14/0x20)
> 
> The sugov thread blocks waiting for the i2c_bus rt_mutex, as it needs
> to adjust the voltage via a i2c attached PMIC.
> The lock holder of the i2c_bus rt_mutex at this time is a user task
> reading input data from a temperature sendor on the same i2c bus. This
> task does not make any progress, but it also doesn't show up in the
> lockup detector output, as it's in RUNNING state. A sysrq-t at some
> time after the lockup shows this:
> 
> QSGRenderThread R  running task        0   559    547 0x00000000
> Backtrace: 
> [<80b306f8>] (__schedule) from [<80b30df8>] (schedule+0xa4/0xdc)
> [<80b30d54>] (schedule) from [<80b347f8>] (schedule_timeout+0xd0/0x108)
> [<80b34728>] (schedule_timeout) from [<807b43dc>] (i2c_imx_trx_complete+0x90/0x13c)
> [<807b434c>] (i2c_imx_trx_complete) from [<807b5ab0>] (i2c_imx_xfer+0x938/0xac4)
> [<807b5178>] (i2c_imx_xfer) from [<807ae5f0>] (__i2c_transfer+0x5a8/0x7b8)
> [<807ae048>] (__i2c_transfer) from [<807ae8ec>] (i2c_transfer+0xec/0x13c)
> [<807ae800>] (i2c_transfer) from [<806819b4>] (regmap_i2c_read+0x64/0x98)
> [<8067cf80>] (_regmap_raw_read) from [<8067d338>] (_regmap_bus_read+0x4c/0x6c)
> [<8067d2ec>] (_regmap_bus_read) from [<8067be70>] (_regmap_read+0x94/0x1e8)
> [<8067bddc>] (_regmap_read) from [<8067c014>] (regmap_read+0x50/0x68)
> [<8067bfc4>] (regmap_read) from [<807e67bc>] (lm75_read+0x90/0xe0)
> [<807e672c>] (lm75_read) from [<807e5908>] (hwmon_attr_show+0x48/0x1cc)
> [<807e58c0>] (hwmon_attr_show) from [<80658570>] (dev_attr_show+0x2c/0x50)
> [<80658544>] (dev_attr_show) from [<80348414>] (sysfs_kf_seq_show+0x98/0xec)
> [<8034837c>] (sysfs_kf_seq_show) from [<80346a2c>] (kernfs_seq_show+0x34/0x38)
> [<803469f8>] (kernfs_seq_show) from [<802f9e48>] (seq_read+0x21c/0x454)
> [<802f9c2c>] (seq_read) from [<80346e50>] (kernfs_fop_read+0x40/0x1d0)
> [<80346e10>] (kernfs_fop_read) from [<802d1f58>] (__vfs_read+0x48/0xf0)
> [<802d1f10>] (__vfs_read) from [<802d209c>] (vfs_read+0x9c/0xb8)
> [<802d2000>] (vfs_read) from [<802d22c4>] (ksys_read+0x78/0xc4)
> [<802d224c>] (ksys_read) from [<802d2328>] (sys_read+0x18/0x1c)
> [<802d2310>] (sys_read) from [<80101000>] (ret_fast_syscall+0x0/0x28)
> 
> The task isn't making any progress, even though the
> wait_event_timeout() in i2c_imx_trx_complete() has a 100ms timeout to
> guard against bus lockups, the task is fully stuck there, so it's
> unlikely to be a peripheral HW issue. As the task is in RUNNING state I
> believe that the event that is waited for has happened, as expected.

I'm not so sure about that, especially if it is holding the lock.

> 
> The sched state at this time is "interesting" and I'm having a hard
> time making any sense out of this. The user task apparently inherited
> the DEADLINE priority from the sugov kthread. But while the user task
> state shows up as RUNNING the task doesn't show up in the dl_rq
> nr_running. Also while cpu#0 shows nr_running as 1, its curr->pid hints
> at it executing the idle task, which is at least consitent with the
> thread still being stuck in __schedule.
> 
> Shortened sched debug below. The machine has 4 cores, I only pasted the
> output of the CPUs containing the relevant user task and the sugov
> kthread.
> 

You have it running under SCHED_DEADLINE? That will cause it to run for
only the run time per period, and can cause even more delays.

Perhaps put in some trace_printk()s and see what exactly is happening.

-- Steve
