Return-Path: <SRS0=tn8d=5J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2E9BFC4332B
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:39:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 050AB20870
	for <linux-kernel@archiver.kernel.org>; Tue, 24 Mar 2020 11:39:25 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727354AbgCXLjX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 24 Mar 2020 07:39:23 -0400
Received: from foss.arm.com ([217.140.110.172]:32932 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727066AbgCXLjX (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 Mar 2020 07:39:23 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B983131B;
        Tue, 24 Mar 2020 04:39:22 -0700 (PDT)
Received: from e107158-lin (e107158-lin.cambridge.arm.com [10.1.195.21])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 15B2D3F792;
        Tue, 24 Mar 2020 04:39:21 -0700 (PDT)
Date:   Tue, 24 Mar 2020 11:39:19 +0000
From:   Qais Yousef <qais.yousef@arm.com>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Davidlohr Bueso <dave@stgolabs.net>,
        Josh Triplett <josh@joshtriplett.org>,
        linux-kernel@vger.kernel.org
Subject: Re: Hit WARN_ON() in rcutorture.c:1055
Message-ID: <20200324113918.bnlnsip5crehxvlo@e107158-lin>
References: <20200323154309.nah44so2556ee56g@e107158-lin.cambridge.arm.com>
 <20200323155731.GK3199@paulmck-ThinkPad-P72>
 <20200323170609.w64xrfahd2snfz6h@e107158-lin.cambridge.arm.com>
 <20200323171751.GL3199@paulmck-ThinkPad-P72>
 <20200323174147.lneh4rp4tazhtm6x@e107158-lin.cambridge.arm.com>
 <20200323181010.GN3199@paulmck-ThinkPad-P72>
 <20200323182351.xr764b6wafzs6fse@e107158-lin.cambridge.arm.com>
 <20200323184437.GP3199@paulmck-ThinkPad-P72>
MIME-Version: 1.0
Content-Type: multipart/mixed; boundary="oykz3aaepkbgreh4"
Content-Disposition: inline
In-Reply-To: <20200323184437.GP3199@paulmck-ThinkPad-P72>
User-Agent: NeoMutt/20171215
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--oykz3aaepkbgreh4
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline

On 03/23/20 11:44, Paul E. McKenney wrote:
> > > > {register, unregister}_pm_notifier() don't seem to be too hard to use.
> > > 
> > > That part is easy.  It would also be necessary to find all the affected
> > > warnings in rcutorture and suppress them, not only during this time,
> > > but also for some period of time afterwards.  Maybe this is the only one,
> > > but that would be surprising.  ;-)
> > 
> > Wouldn't be easier to just deinit/init()? ie: treat it like unload/load module.
> > 
> > But you'll lose some info then that maybe you'd like to keep across
> > suspend/resume cycles.
> 
> Hmmm...  Are you running rcutorture as a loadable module or built into
> your kernel?  In the latter case, it starts up automatically shortly
> after boot.

Built-in. Sorry maybe I wasn't clear. I meant something like the attached.
Which still generates this warning, so yeah I get your point about suppressing
some warnings in the right places now.

[   48.898066] rcu-torture: Stopping rcu_torture_fwd_prog task
[   48.908998] rcu-torture: Stopping rcu_torture_reader
[   48.917052] rcu-torture: Stopping rcu_torture_fakewriter
[   48.926987] ------------[ cut here ]------------
[   48.927025] WARNING: CPU: 4 PID: 261 at kernel/rcu/rcutorture.c:1085 rcu_torture_writer+0x49c/0xa90
[   48.927038] rcu-torture: Stopping rcu_torture_fakewriter
[   48.927041] Modules linked in:
[   48.927070] CPU: 4 PID: 261 Comm: rcu_torture_wri Not tainted 5.6.0-rc6-00002-g533440e608d2-dirty #540
[   48.927085] Hardware name: ARM Juno development board (r2) (DT)
[   48.927103] pstate: 00000005 (nzcv daif -PAN -UAO)
[   48.927124] pc : rcu_torture_writer+0x49c/0xa90
[   48.927144] lr : rcu_torture_writer+0x494/0xa90
[   48.927157] sp : ffff800018bfbde0
[   48.927172] x29: ffff800018bfbde0 x28: ffff80001426da58
[   48.927198] x27: ffff80001426cf08 x26: ffff80001426cf08
[   48.927224] x25: ffff8000121b5000 x24: 0000000000000001
[   48.927250] x23: ffff80001426d650 x22: ffff80001426b000
[   48.927275] x21: ffff800013439000 x20: 0000000000000001
[   48.927301] x19: ffff80001426c000 x18: 0000000000000000
[   48.927326] x17: 0000000000000000 x16: 0000000000000000
[   48.927351] x15: 0000000000000000 x14: 0000000000000000
[   48.927376] x13: 0000000000000000 x12: 0000000000000000
[   48.927401] x11: 00000000000001fa x10: 0000000000000000
[   48.927426] x9 : ffff800013a130a0 x8 : ffff0009757f0850
[   48.927450] x7 : 0000000000000000 x6 : ffff800018bfbcc0
[   48.927475] x5 : 0000000000000001 x4 : 0000000000000000
[   48.927499] x3 : 0000000000000080 x2 : 0000000000000000
[   48.927524] x1 : 0000000000000000 x0 : 0000000000000001
[   48.927548] Call trace:
[   48.927569]  rcu_torture_writer+0x49c/0xa90
[   48.927590]  kthread+0x13c/0x140
[   48.927611]  ret_from_fork+0x10/0x18
[   48.927627] irq event stamp: 34170
[   48.927654] hardirqs last  enabled at (34169): [<ffff800010114300>] __local_bh_enable_ip+0x98/0x148
[   48.927680] hardirqs last disabled at (34170): [<ffff8000100a95d0>] do_debug_exception+0x1a8/0x258
[   48.927702] softirqs last  enabled at (34168): [<ffff8000101b949c>] rcu_torture_free+0x84/0x98
[   48.927725] softirqs last disabled at (34166): [<ffff8000101b9478>] rcu_torture_free+0x60/0x98
[   48.927740] ---[ end trace 57f88d092825f447 ]---

Thanks

--
Qais Yousef

--oykz3aaepkbgreh4
Content-Type: text/x-diff; charset=utf-8
Content-Disposition: attachment; filename="rcu_pm.patch"

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 1aeecc165b21..defad882b236 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -45,6 +45,7 @@
 #include <linux/sched/sysctl.h>
 #include <linux/oom.h>
 #include <linux/tick.h>
+#include <linux/suspend.h>
 
 #include "rcu.h"
 
@@ -1628,7 +1629,7 @@ static int rcu_torture_stall(void *args)
 }
 
 /* Spawn CPU-stall kthread, if stall_cpu specified. */
-static int __init rcu_torture_stall_init(void)
+static int rcu_torture_stall_init(void)
 {
 	if (stall_cpu <= 0)
 		return 0;
@@ -2008,7 +2009,7 @@ static int rcu_torture_fwd_prog(void *args)
 }
 
 /* If forward-progress checking is requested and feasible, spawn the thread. */
-static int __init rcu_torture_fwd_prog_init(void)
+static int rcu_torture_fwd_prog_init(void)
 {
 	struct rcu_fwd *rfp;
 
@@ -2359,7 +2360,7 @@ static void rcutorture_sync(void)
 		cur_ops->sync();
 }
 
-static int __init
+static int
 rcu_torture_init(void)
 {
 	long i;
@@ -2549,5 +2550,47 @@ rcu_torture_init(void)
 	return firsterr;
 }
 
-module_init(rcu_torture_init);
-module_exit(rcu_torture_cleanup);
+static int rcu_torture_notify(struct notifier_block *nb,
+			      unsigned long mode, void *_unused)
+{
+	switch (mode) {
+	case PM_HIBERNATION_PREPARE:
+	case PM_SUSPEND_PREPARE:
+		pr_info("Shutdodwn rcu torture..");
+		rcu_torture_cleanup();
+		break;
+
+	case PM_POST_RESTORE:
+		pr_info("Restart rcu torture..");
+		rcu_torture_init();
+		break;
+	}
+
+	return 0;
+}
+
+static struct notifier_block rcu_nb = {
+	.notifier_call = rcu_torture_notify
+};
+
+static int nb_failed;
+
+int rcu_torture_module_init(void)
+{
+	nb_failed = register_pm_notifier(&rcu_nb);
+	if (nb_failed)
+		pr_warn("Failed to register PM notifier");
+
+	return rcu_torture_init();
+}
+
+void rcu_torture_module_exit(void)
+{
+	if (!nb_failed)
+		unregister_pm_notifier(&rcu_nb);
+
+	rcu_torture_cleanup();
+}
+
+module_init(rcu_torture_module_init);
+module_exit(rcu_torture_module_exit);

--oykz3aaepkbgreh4--
