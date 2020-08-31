Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2081BC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EF4FB20719
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 15:50:43 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598889044;
	bh=dQpfZaNAgiClmqPKDMjF2Yz+e+jKQj4shrJqtvKqmiU=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=jgkaP6ouWH3OFn8kcWCDiUZfqATcY9LeZThMTDluYoNe+MZSbaLHTs2oIckrpGnYi
	 mdFJ/3l//GEPRqif4ekC2BhOp0nO4sJoeAfjYNHuc/4/DxO2j0FQpE5Cjpnc6NsW+O
	 YRrLTxswNw2GxKfcnm3716XBkwUNfzimXYB/7TA4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727989AbgHaPul (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 11:50:41 -0400
Received: from mail.kernel.org ([198.145.29.99]:38836 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727919AbgHaPui (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 11:50:38 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 15A8720719;
        Mon, 31 Aug 2020 15:50:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598889038;
        bh=dQpfZaNAgiClmqPKDMjF2Yz+e+jKQj4shrJqtvKqmiU=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=UPJGD3bGtMa66nUuXu0AMi7MvPz9rC5TKF3LYd/4vWqqQCJVy3FJKLjmD2loTjGOf
         ena/H6xC5KFKXCf1As5JTQULkFZGzng4JeU2kQZiEY/+oB73SZKPm7IiswCvLCLQE2
         kYJbTBKXTHS5lZ6zxRybQw13KZNAIWy/VAIpRUYQ=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id D0ABA3522A20; Mon, 31 Aug 2020 08:50:37 -0700 (PDT)
Date:   Mon, 31 Aug 2020 08:50:37 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [rcuperf] 4e88ec4a9e:
 UBSAN:division-overflow_in_arch/x86/include/asm/div64.h
Message-ID: <20200831155037.GZ2855@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200831120122.GH4299@shao2-debian>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200831120122.GH4299@shao2-debian>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 31, 2020 at 08:01:22PM +0800, kernel test robot wrote:
> Greeting,
> 
> FYI, we noticed the following commit (built with gcc-9):
> 
> commit: 4e88ec4a9eb17527e640b063f79e5b875733eb53 ("rcuperf: Change rcuperf to rcuscale")
> https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
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
> on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> 
> caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> 
> 
> +---------------------------------------------------------+------------+------------+
> |                                                         | 65bd77f554 | 4e88ec4a9e |
> +---------------------------------------------------------+------------+------------+
> | boot_successes                                          | 13         | 0          |
> | boot_failures                                           | 0          | 14         |
> | UBSAN:division-overflow_in_arch/x86/include/asm/div64.h | 0          | 14         |
> | error:#[##]                                             | 0          | 14         |
> | EIP:main_func.cold                                      | 0          | 14         |
> | Kernel_panic-not_syncing:Fatal_exception                | 0          | 14         |
> +---------------------------------------------------------+------------+------------+
> 
> 
> If you fix the issue, kindly add following tag
> Reported-by: kernel test robot <lkp@intel.com>

Does the patch below fix this for you?

							Thanx, Paul

------------------------------------------------------------------------

commit d301e320e952e2e604d83d9540e52510b0eb3d94
Author: Paul E. McKenney <paulmck@kernel.org>
Date:   Thu Aug 27 09:58:19 2020 -0700

    refscale: Bounds-check module parameters
    
    The default value for refscale.nreaders is -1, which results in the code
    setting the value to three-quarters of the number of CPUs.  On single-CPU
    systems, this results in three-quarters of the value one, which the C
    language's integer arithmetic rounds to zero.  This in turn results in
    a divide-by-zero error.
    
    This commit therefore adds bounds checking to the refscale module
    parameters, so that if they are less than one, they are set to the
    value one.
    
    Reported-by: kernel test robot <lkp@intel.com>
    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>

diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
index 952595c..fb5f20d 100644
--- a/kernel/rcu/refscale.c
+++ b/kernel/rcu/refscale.c
@@ -681,6 +681,12 @@ ref_scale_init(void)
 	// Reader tasks (default to ~75% of online CPUs).
 	if (nreaders < 0)
 		nreaders = (num_online_cpus() >> 1) + (num_online_cpus() >> 2);
+	if (WARN_ONCE(loops <= 0, "%s: loops = %ld, adjusted to 1\n", __func__, loops))
+		loops = 1;
+	if (WARN_ONCE(nreaders <= 0, "%s: nreaders = %d, adjusted to 1\n", __func__, nreaders))
+		nreaders = 1;
+	if (WARN_ONCE(nruns <= 0, "%s: nruns = %d, adjusted to 1\n", __func__, nruns))
+		nruns = 1;
 	reader_tasks = kcalloc(nreaders, sizeof(reader_tasks[0]),
 			       GFP_KERNEL);
 	if (!reader_tasks) {
