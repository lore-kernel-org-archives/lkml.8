Return-Path: <SRS0=EKp2=A6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6525C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 22:08:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AE16D207FC
	for <linux-kernel@archiver.kernel.org>; Sun, 19 Jul 2020 22:08:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595196496;
	bh=7X7urT2By7j0mmLDtENEN+mkOg4aY8A+3G27jGikHO4=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=HcdFw4VHyXMgVzDLWmO4PwOWovcmQElYw9L3CREjBY464gq8PqNdGw6G6aDPMmnno
	 xExKp61SKdRtld4cY6noOeGJlIcmXhh3h7uEm0a6OKrTI+reH0ghpGdtOEpYznr88Z
	 1VRmho9V6VXXMEwx3g04+Aigebh8hst/2vHTr4ms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726587AbgGSWIP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 18:08:15 -0400
Received: from mail.kernel.org ([198.145.29.99]:56536 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726156AbgGSWIO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 18:08:14 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-111-31.bvtn.or.frontiernet.net [50.39.111.31])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D2599207FC;
        Sun, 19 Jul 2020 22:08:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1595196493;
        bh=7X7urT2By7j0mmLDtENEN+mkOg4aY8A+3G27jGikHO4=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=GL6p568re0heCQPM0B8REuqmunYM//VB3t90gkpmsvXHAA1hNiRQC033V01iASkOl
         CZWGKyPSlEY255QGjHwV4ctveSiFjYEnyf+r1zFcQgLBnoLWSG6QGT/52PNVQ7IbWC
         NorT0M83X+cf8GNIC5oYhnsr3rYiW/MLuzcghHUw=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B817635230B3; Sun, 19 Jul 2020 15:08:13 -0700 (PDT)
Date:   Sun, 19 Jul 2020 15:08:13 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <rong.a.chen@intel.com>
Cc:     LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [rcutorture] 5155be9994:
 BUG:kernel_NULL_pointer_dereference,address
Message-ID: <20200719220813.GO9247@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200717060455.GA19262@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200717060455.GA19262@shao2-debian>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 17, 2020 at 02:04:55PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 5155be9994e557618a8312389fb4e52dfbf28a3c ("rcutorture: Dynamically allocate rcu_fwds structure")
> https://git.kernel.org/cgit/linux/kernel/git/torvalds/linux.git master
> 
> 
> in testcase: trinity
> with following parameters:
> 
> 	runtime: 300s
> 
> test-description: Trinity is a linux system call fuzz tester.
> test-url: http://codemonkey.org.uk/projects/trinity/
> 
> 
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 16G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +-----------------------------------------------------------+------------+------------+
> |                                                           | 6764100bd2 | 5155be9994 |
> +-----------------------------------------------------------+------------+------------+
> | boot_successes                                            | 13         | 13         |
> | boot_failures                                             | 9          | 9          |
> | WARNING:at_kernel/rcu/rcutorture.c:#rcutorture_oom_notify | 9          | 9          |
> | EIP:rcutorture_oom_notify                                 | 9          | 9          |
> | invoked_oom-killer:gfp_mask=0x                            | 3          |            |
> | Mem-Info                                                  | 3          |            |
> | BUG:kernel_NULL_pointer_dereference,address               | 0          | 9          |
> | Oops:#[##]                                                | 0          | 9          |
> | EIP:rcu_torture_fwd_cb_hist                               | 0          | 9          |
> | Kernel_panic-not_syncing:Fatal_exception                  | 0          | 9          |
> +-----------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <rong.a.chen@intel.com>

Good catch!  Fix shown below, and thank you for your testing efforts!

							Thanx, Paul

------------------------------------------------------------------------

commit 36444974a456b95c18805dec8e0341cf02570fdc
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Sun Jul 19 14:40:31 2020 -0700

    rcutorture: Properly set rcu_fwds for OOM handling
    
    The conversion of rcu_fwds to dynamic allocation failed to actually
    allocate the required structure.  This commit therefore allocates it,
    frees it, and updates rcu_fwds accordingly.  While in the area, it
    abstracts the cleanup actions into rcu_torture_fwd_prog_cleanup().
    
    Fixes: 5155be9994e5 ("rcutorture: Dynamically allocate rcu_fwds structure")
    Reported-by: kernel test robot <rong.a.chen@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/rcutorture.c b/kernel/rcu/rcutorture.c
index 748212c..e40a38f 100644
--- a/kernel/rcu/rcutorture.c
+++ b/kernel/rcu/rcutorture.c
@@ -2153,9 +2153,20 @@ static int __init rcu_torture_fwd_prog_init(void)
 		return -ENOMEM;
 	spin_lock_init(&rfp->rcu_fwd_lock);
 	rfp->rcu_fwd_cb_tail = &rfp->rcu_fwd_cb_head;
+	rcu_fwds = rfp;
 	return torture_create_kthread(rcu_torture_fwd_prog, rfp, fwd_prog_task);
 }
 
+static void rcu_torture_fwd_prog_cleanup(void)
+{
+	struct rcu_fwd *rfp;
+
+	torture_stop_kthread(rcu_torture_fwd_prog, fwd_prog_task);
+	rfp = rcu_fwds;
+	rcu_fwds = NULL;
+	kfree(rfp);
+}
+
 /* Callback function for RCU barrier testing. */
 static void rcu_torture_barrier_cbf(struct rcu_head *rcu)
 {
@@ -2453,7 +2464,7 @@ rcu_torture_cleanup(void)
 	show_rcu_gp_kthreads();
 	rcu_torture_read_exit_cleanup();
 	rcu_torture_barrier_cleanup();
-	torture_stop_kthread(rcu_torture_fwd_prog, fwd_prog_task);
+	rcu_torture_fwd_prog_cleanup();
 	torture_stop_kthread(rcu_torture_stall, stall_task);
 	torture_stop_kthread(rcu_torture_writer, writer_task);
 
