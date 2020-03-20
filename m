Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4DFD6C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:02:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id F3E9120724
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 17:02:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727535AbgCTRCh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 13:02:37 -0400
Received: from metis.ext.pengutronix.de ([85.220.165.71]:41463 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726953AbgCTRCg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 13:02:36 -0400
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=localhost)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <l.stach@pengutronix.de>)
        id 1jFL2Y-0001PS-Vc; Fri, 20 Mar 2020 18:02:35 +0100
Message-ID: <c74744cc78cab34f3be8b547b7ff3cd6769d299b.camel@pengutronix.de>
Subject: help needed in debugging missed wakeup(?)
From:   Lucas Stach <l.stach@pengutronix.de>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>
Date:   Fri, 20 Mar 2020 18:02:32 +0100
Content-Type: text/plain; charset="UTF-8"
User-Agent: Evolution 3.34.4 (3.34.4-1.fc31) 
MIME-Version: 1.0
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: l.stach@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi sched people,

I'm currently debugging something which looks like a missed wakeup and
involves a rt_mutex (no RT kernel though, this is mainline i2c bus
locking). The issue seems to be a race condition, as we are seeing it
on around 5% population of a 300 devices test field all running the
same load. I was only able to reproduce the issue twice in pretty long
testing sessions on a single device and was able to gather some debug
info, but running out of ideas where to look next. Hopefully someone
around here is able to provide me some fruther clues.

The obvious thing which the kernel lockup detector is able to find is
the sogov (schedutil governor frequency switching task) being blocked:

INFO: task sugov:0:299 blocked for more than 30 seconds.
Not tainted 5.4.22 #3
"echo 0 > /proc/sys/kernel/hung_task_timeout_secs" disables this message.
sugov:0         D    0   299      2 0x00000000
Backtrace: 
[<80b306f8>] (__schedule) from [<80b30df8>] (schedule+0xa4/0xdc)
[<80b30d54>] (schedule) from [<80b34084>] (__rt_mutex_slowlock+0x104/0x17c)
[<80b33f80>] (__rt_mutex_slowlock) from [<80b34254>] (rt_mutex_slowlock+0x158/0x224)
[<80b340fc>] (rt_mutex_slowlock) from [<80b34390>] (rt_mutex_lock_nested+0x70/0x7c)
[<80b34320>] (rt_mutex_lock_nested) from [<807abf20>] (i2c_adapter_lock_bus+0x28/0x2c)
[<807abef8>] (i2c_adapter_lock_bus) from [<807ae924>] (i2c_transfer+0x124/0x13c)
[<807ae800>] (i2c_transfer) from [<807ae994>] (i2c_transfer_buffer_flags+0x58/0x80)
[<807ae93c>] (i2c_transfer_buffer_flags) from [<80681a0c>] (regmap_i2c_write+0x24/0x40)
[<806819e8>] (regmap_i2c_write) from [<8067cccc>] (_regmap_raw_write_impl+0x5d8/0x714)
[<8067c6f4>] (_regmap_raw_write_impl) from [<8067ce98>] (_regmap_bus_raw_write+0x90/0x98)
[<8067ce08>] (_regmap_bus_raw_write) from [<8067c4a0>] (_regmap_write+0x184/0x1cc)
[<8067c31c>] (_regmap_write) from [<8067c5d4>] (_regmap_update_bits+0xec/0xfc)
[<8067c4e8>] (_regmap_update_bits) from [<8067d884>] (regmap_update_bits_base+0x60/0x84)
[<8067d824>] (regmap_update_bits_base) from [<80575468>] (regulator_set_voltage_sel_regmap+0x54/0x90)
[<80575414>] (regulator_set_voltage_sel_regmap) from [<80570130>] (_regulator_call_set_voltage_sel+0x78/0xb4)
[<805700b8>] (_regulator_call_set_voltage_sel) from [<80570784>] (_regulator_do_set_voltage+0x460/0x658)
[<80570324>] (_regulator_do_set_voltage) from [<80573fa4>] (regulator_set_voltage_rdev+0x12c/0x1fc)
[<80573e78>] (regulator_set_voltage_rdev) from [<80571dec>] (regulator_balance_voltage+0xf8/0x498)
[<80571cf4>] (regulator_balance_voltage) from [<80573e64>] (regulator_set_voltage_unlocked+0xf4/0x108)
[<80573d70>] (regulator_set_voltage_unlocked) from [<80573fc8>] (regulator_set_voltage_rdev+0x150/0x1fc)
[<80573e78>] (regulator_set_voltage_rdev) from [<80571dec>] (regulator_balance_voltage+0xf8/0x498)
[<80571cf4>] (regulator_balance_voltage) from [<80573e64>] (regulator_set_voltage_unlocked+0xf4/0x108)
[<80573d70>] (regulator_set_voltage_unlocked) from [<805740c4>] (regulator_set_voltage+0x50/0x84)
[<80574074>] (regulator_set_voltage) from [<807fe00c>] (regulator_set_voltage_tol.constprop.0+0x1c/0x38)
[<807fdff0>] (regulator_set_voltage_tol.constprop.0) from [<807fe37c>] (imx6q_set_target+0x354/0x404)
[<807fe028>] (imx6q_set_target) from [<807f96d8>] (__cpufreq_driver_target+0x254/0x300)
[<807f9484>] (__cpufreq_driver_target) from [<8017ec98>] (sugov_work+0x5c/0x68)
[<8017ec3c>] (sugov_work) from [<80154df4>] (kthread_worker_fn+0x178/0x214)
[<80154c7c>] (kthread_worker_fn) from [<801553d0>] (kthread+0x120/0x130)
[<801552b0>] (kthread) from [<801010b4>] (ret_from_fork+0x14/0x20)

The sugov thread blocks waiting for the i2c_bus rt_mutex, as it needs
to adjust the voltage via a i2c attached PMIC.
The lock holder of the i2c_bus rt_mutex at this time is a user task
reading input data from a temperature sendor on the same i2c bus. This
task does not make any progress, but it also doesn't show up in the
lockup detector output, as it's in RUNNING state. A sysrq-t at some
time after the lockup shows this:

QSGRenderThread R  running task        0   559    547 0x00000000
Backtrace: 
[<80b306f8>] (__schedule) from [<80b30df8>] (schedule+0xa4/0xdc)
[<80b30d54>] (schedule) from [<80b347f8>] (schedule_timeout+0xd0/0x108)
[<80b34728>] (schedule_timeout) from [<807b43dc>] (i2c_imx_trx_complete+0x90/0x13c)
[<807b434c>] (i2c_imx_trx_complete) from [<807b5ab0>] (i2c_imx_xfer+0x938/0xac4)
[<807b5178>] (i2c_imx_xfer) from [<807ae5f0>] (__i2c_transfer+0x5a8/0x7b8)
[<807ae048>] (__i2c_transfer) from [<807ae8ec>] (i2c_transfer+0xec/0x13c)
[<807ae800>] (i2c_transfer) from [<806819b4>] (regmap_i2c_read+0x64/0x98)
[<8067cf80>] (_regmap_raw_read) from [<8067d338>] (_regmap_bus_read+0x4c/0x6c)
[<8067d2ec>] (_regmap_bus_read) from [<8067be70>] (_regmap_read+0x94/0x1e8)
[<8067bddc>] (_regmap_read) from [<8067c014>] (regmap_read+0x50/0x68)
[<8067bfc4>] (regmap_read) from [<807e67bc>] (lm75_read+0x90/0xe0)
[<807e672c>] (lm75_read) from [<807e5908>] (hwmon_attr_show+0x48/0x1cc)
[<807e58c0>] (hwmon_attr_show) from [<80658570>] (dev_attr_show+0x2c/0x50)
[<80658544>] (dev_attr_show) from [<80348414>] (sysfs_kf_seq_show+0x98/0xec)
[<8034837c>] (sysfs_kf_seq_show) from [<80346a2c>] (kernfs_seq_show+0x34/0x38)
[<803469f8>] (kernfs_seq_show) from [<802f9e48>] (seq_read+0x21c/0x454)
[<802f9c2c>] (seq_read) from [<80346e50>] (kernfs_fop_read+0x40/0x1d0)
[<80346e10>] (kernfs_fop_read) from [<802d1f58>] (__vfs_read+0x48/0xf0)
[<802d1f10>] (__vfs_read) from [<802d209c>] (vfs_read+0x9c/0xb8)
[<802d2000>] (vfs_read) from [<802d22c4>] (ksys_read+0x78/0xc4)
[<802d224c>] (ksys_read) from [<802d2328>] (sys_read+0x18/0x1c)
[<802d2310>] (sys_read) from [<80101000>] (ret_fast_syscall+0x0/0x28)

The task isn't making any progress, even though the
wait_event_timeout() in i2c_imx_trx_complete() has a 100ms timeout to
guard against bus lockups, the task is fully stuck there, so it's
unlikely to be a peripheral HW issue. As the task is in RUNNING state I
believe that the event that is waited for has happened, as expected.

The sched state at this time is "interesting" and I'm having a hard
time making any sense out of this. The user task apparently inherited
the DEADLINE priority from the sugov kthread. But while the user task
state shows up as RUNNING the task doesn't show up in the dl_rq
nr_running. Also while cpu#0 shows nr_running as 1, its curr->pid hints
at it executing the idle task, which is at least consitent with the
thread still being stuck in __schedule.

Shortened sched debug below. The machine has 4 cores, I only pasted the
output of the CPUs containing the relevant user task and the sugov
kthread.

Sched Debug Version: v0.11, 5.4.22 #3
ktime                                   : 8167595.022639
sched_clk                               : 8167600.901887
cpu_clk                                 : 8167600.902554
jiffies                                 : 786762
sysctl_sched
.sysctl_sched_latency                    : 18.000000
.sysctl_sched_min_granularity            : 2.250000
.sysctl_sched_wakeup_granularity         : 3.000000
.sysctl_sched_child_runs_first           : 0
.sysctl_sched_features                   : 2059067
.sysctl_sched_tunable_scaling            : 1 (logarithmic)
cpu#0
  .nr_running                    : 1
  .nr_switches                   : 2616061
  .nr_load_updates               : 0
  .nr_uninterruptible            : 3
  .next_balance                  : 0.786770
  .curr->pid                     : 0
  .clock                         : 8167706.573554
  .clock_task                    : 8167709.714554
  .avg_idle                      : 1000000
  .max_idle_balance_cost         : 500000
cfs_rq[0]:/
  .exec_clock                    : 0.000000
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 170655.365388
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : 0.000000
  .nr_spread_over                : 0
  .nr_running                    : 0
  .load                          : 0
  .runnable_weight               : 0
  .load_avg                      : 137
  .runnable_load_avg             : 0
  .util_avg                      : 111
  .util_est_enqueued             : 0
  .removed.load_avg              : 0
  .removed.util_avg              : 0
  .removed.runnable_sum          : 0
  .tg_load_avg_contrib           : 0
  .tg_load_avg                   : 0
rt_rq[0]:
  .rt_nr_running                 : 0
  .rt_nr_migratory               : 0
  .rt_throttled                  : 0
  .rt_time                       : 15.497666
  .rt_runtime                    : 950.000000
dl_rq[0]:
  .dl_nr_running                 : 0
  .dl_nr_migratory               : 0
  .dl_bw->bw                     : 996147
  .dl_bw->total_bw               : 0
runnable tasks:
 S           task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep
-----------------------------------------------------------------------------------------------------------
 I         rcu_gp     3         7.244826         3   100         0.000000         0.202666         0.000000 /
 I     rcu_par_gp     4         8.838316         3   100         0.000000         0.172000         0.000000 /
 I   kworker/0:0H     6      6281.741275        12   100         0.000000         1.777333         0.000000 /
 I   mm_percpu_wq     8        14.640920         3   100         0.000000         0.143000         0.000000 /
 S    ksoftirqd/0     9    170272.531056     11048   120         0.000000      8117.785661         0.000000 /
 I    rcu_preempt    10    170647.484054     85503   120         0.000000     10540.749756         0.000000 /
 S    migration/0    11         0.000000      2052     0         0.000000       169.551366         0.000000 /
 I    kworker/0:1    12    170492.300722     34025   120         0.000000      5087.014467         0.000000 /
 S        cpuhp/0    13      3130.355881         9   120         0.000000         0.537667         0.000000 /
 S     khungtaskd    34    170186.022389      1187   120         0.000000      7649.525998         0.000000 /
 I       cfg80211   110      2586.210829         4   100         0.000000         0.221000         0.000000 /
 S      jfsCommit   139      2682.261200         2   120         0.000000         0.127334         0.000000 /
 I    kworker/0:2   143     13553.725798      3017   120         0.000000       500.353366         0.000000 /
 I    usbip_event   163      3472.106794         2   100         0.000000         0.216334         0.000000 /
 I          sdhci   168      3481.262131         2   100         0.000000         0.213334         0.000000 /
 S    irq/60-mmc0   169         0.000000         7    49         0.000000         1.281667         0.000000 /
 S    irq/61-mmc1   173         0.000000         7    49         0.000000         0.842335         0.000000 /
 S    irq/62-mmc2   177         0.000000         4    49         0.000000         0.398334         0.000000 /
 I   mmc_complete   178      3491.982425         2   100         0.000000         0.192668         0.000000 /
 I   mmc_complete   182      3507.515908         2   100         0.000000         0.209334         0.000000 /
 S irq/97-mma8451   296         0.000000         2    49         0.000000         0.209334         0.000000 /
 S     134000.gpu   320         0.000000         2    98         0.000000         0.207334         0.000000 /
 S    2204000.gpu   321         0.000000         2    98         0.000000         0.192000         0.000000 /
 Sirq/330-!soc!ai   334         0.000000         2    49         0.000000         0.175333         0.000000 /
 Sirq/331-!soc!ai   335         0.000000         2    49         0.000000         0.142667         0.000000 /
 Sirq/18-imx_ther   338         0.000000         3    49         0.000000         0.300000         0.000000 /
 I   kworker/u8:4   339    170173.058056     47403   120         0.000000     14864.604657         0.000000 /
 I   kworker/u9:2   349    170272.470384     49098   100         0.000000     22626.085716         0.000000 /
 Ssystemd-journal   371    170655.365388      5176   120         0.000000      8538.471989         0.000000 /
 S    irq/66-vdoa   448         0.075666     56853    49         0.000000      7462.914997         0.000000 /
 Sirq/30-2040000.   449         0.000000        22    49         0.000000         3.228000         0.000000 /
 Sirq/31-coda jpe   450         0.081000         3    49         0.000000         0.362001         0.000000 /
 I           coda   451      6026.818189         2   100         0.000000         0.221000         0.000000 /
 I   kworker/0:2H   464     13131.123871       178   100         0.000000        74.261336         0.000000 /
 Salsa-sink-20280   506         0.000000    328034    94         0.000000    137857.664438         0.000000 /
 S          ptp4l   512    170588.727054     14587   120         0.000000     12961.910636         0.000000 /
 S          lldpd   518    161330.930102       413   120         0.000000       235.196326         0.000000 /
 S          lldpd   523    167124.946732       522   120         0.000000       164.690670         0.000000 /
 S     QQmlThread   555     13035.420131       633   120         0.000000       693.330648         0.000000 /
 Sgldisplay-event   558     13572.855460         1   120         0.000000         0.680333         0.000000 /
 RQSGRenderThread   559         0.000000     21984    -1         0.000000      9455.140648         0.000000 /
 Sgldisplay-event   560     13625.136454         1   120         0.000000         0.607000         0.000000 /
 Sgldisplay-event   561     13634.828782         1   120         0.000000         0.692333         0.000000 /
 S  typefind:sink   572     14346.726433       205   120         0.000000        84.886339         0.000000 /
 Smatroskademux0:   575     27839.889727      8421   120         0.000000      3155.833732         0.000000 /
 Smultiqueue1:src   580     27939.450393      7412   120         0.000000      3322.682665         0.000000 /
 Smultiqueue2:src   582     64702.132151     36004   120         0.000000     14180.398062         0.000000 /
 S    threaded-ml   587    170653.935720    806958   120         0.000000    191834.284940         0.000000 /
cpu#1
  .nr_running                    : 0
  .nr_switches                   : 1951962
  .nr_load_updates               : 0
  .nr_uninterruptible            : -17
  .next_balance                  : 0.786848
  .curr->pid                     : 0
  .clock                         : 8168488.074888
  .clock_task                    : 8168488.074888
  .avg_idle                      : 1000000
  .max_idle_balance_cost         : 500000
cfs_rq[1]:/
  .exec_clock                    : 0.000000
  .MIN_vruntime                  : 0.000001
  .min_vruntime                  : 79675.927756
  .max_vruntime                  : 0.000001
  .spread                        : 0.000000
  .spread0                       : -91036.566966
  .nr_spread_over                : 0
  .nr_running                    : 0
  .load                          : 11916
  .runnable_weight               : 0
  .load_avg                      : 1200
  .runnable_load_avg             : 0
  .util_avg                      : 51
  .util_est_enqueued             : 0
  .removed.load_avg              : 0
  .removed.util_avg              : 0
  .removed.runnable_sum          : 0
  .tg_load_avg_contrib           : 0
  .tg_load_avg                   : 0
rt_rq[1]:
  .rt_nr_running                 : 0
  .rt_nr_migratory               : 0
  .rt_throttled                  : 0
  .rt_time                       : 36.943999
  .rt_runtime                    : 950.000000
dl_rq[1]:
  .dl_nr_running                 : 0
  .dl_nr_migratory               : 0
  .dl_bw->bw                     : 996147
  .dl_bw->total_bw               : 0
runnable tasks:
 S           task   PID         tree-key  switches  prio     wait-time             sum-exec        sum-sleep
-----------------------------------------------------------------------------------------------------------
 S        systemd     1     78427.950089      7820   120         0.000000     16317.471696         0.000000 /
 S        cpuhp/1    14       144.194268         8   120         0.000000         1.279665         0.000000 /
 S    migration/1    15         0.000000      2095     0         0.000000       173.322016         0.000000 /
 S    ksoftirqd/1    16     78430.110423       827   120         0.000000       220.178683         0.000000 /
 I          netns    30         5.169486         2   100         0.000000         0.273000         0.000000 /
 I      writeback    36        14.311131         2   100         0.000000         0.153000         0.000000 /
 I        kblockd   104      6063.650697         5   100         0.000000         1.485334         0.000000 /
 I        xprtiod   109        32.881708         2   100         0.000000         0.170001         0.000000 /
 S        kswapd0   133       144.235935         3   120         0.000000         0.300668         0.000000 /
 I         nfsiod   134       153.138601         2   100         0.000000         0.157667         0.000000 /
 S irq/308-aerdrv   146         0.000000         2    49         0.000000         0.144999         0.000000 /
 S      scsi_eh_0   147      6187.181146        42   120         0.000000        46.664002         0.000000 /
 I    rmi4-poller   164       242.126243         2   100         0.000000         0.177001         0.000000 /
 I          sdhci   172       251.241547         2   100         0.000000         0.170333         0.000000 /
 S          hwrng   295      1981.228871        19   120         0.000000         6.145667         0.000000 /
 D        sugov:0   299         0.000000     20836    -1         0.000000      6428.315062         0.000000 /
 I   kworker/u8:9   355     78399.595765     44983   120         0.000000     13516.948580         0.000000 /
 I   kworker/1:2H   463     12217.874057       118   100         0.000000        32.701656         0.000000 /
 I   kworker/1:3H   466      6630.229350         3   100         0.000000         0.192334         0.000000 /
 Salsa-sink-202c0   505         0.000000    467719    94         0.000000    501687.028908         0.000000 /
 S     bluetoothd   483     12196.448363       219   120         0.000000       207.692334         0.000000 /
 S NetworkManager   514     78428.249422      1426   120         0.000000       958.963685         0.000000 /
 S          gmain   516     79661.895205      2911   120         0.000000      1462.902691         0.000000 /
 S        telnetd   546     13136.934667       201   120         0.000000       128.003662         0.000000 /
 SQEvdevTouchScre   553     10397.580038        13   120         0.000000         5.707002         0.000000 /
 S  typefind:sink   573     13074.246005       159   120         0.000000        99.711000         0.000000 /
 Smultiqueue2:src   585     56018.750354     55803   120         0.000000     32116.048930         0.000000 /
 S    threaded-ml   587     79674.485504    806994   120         0.000000    191843.905943         0.000000 /
 S     aqueue:src   590     61290.642959    103825   120         0.000000     38918.500285         0.000000 /
 S     aqueue:src   593     25819.269867     22273   120         0.000000      6675.391368         0.000000 /
 I   kworker/u9:0   601     61161.845023     23285   100         0.000000     11131.996351         0.000000 /
 D    kworker/1:2   617     75716.639814       116   120         0.000000        13.313333         0.000000 /
 I    kworker/1:3   618     79667.860300      9536   120         0.000000      1262.709303         0.000000 /
 I    kworker/1:1   619     77765.434809         2   120         0.000000         0.189000         0.000000 /

Any ideas on what it happening here or how I could gather better debug
data?

Regards,
Lucas

