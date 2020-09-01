Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-16.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F08C6C433E6
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:27:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D07FA208CA
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 16:27:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1598977654;
	bh=v3ubAj4K8yP34BRJWBT76VmMtHRcJqZ7TClZ7Gyqd4k=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=MDRILAu7mv8Q4rEhh7/Q6uN7UH+MejLGxf5N7Uur8pjXOF9R/4y9pFi6Ev01cpHok
	 cSkcbl+rJ29u4WjRGcNBaZXDXtd3V17sA0/4AIzvPbdnSoRT/s7dpfU+A10o/cY9gX
	 dijAGQkE4ysoylDHz7Uf5FQepjRAgXixKPog0ZyM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730922AbgIAQ1b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 12:27:31 -0400
Received: from mail.kernel.org ([198.145.29.99]:60250 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731020AbgIAQ1U (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 12:27:20 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id F38D1206FA;
        Tue,  1 Sep 2020 16:27:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1598977640;
        bh=v3ubAj4K8yP34BRJWBT76VmMtHRcJqZ7TClZ7Gyqd4k=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=Q6HE2OGr/FVFJepUDnOmpdTMZnb1YikSFFeWlERuqMdEh3lZCIgUI92wkfPVrRCHQ
         hIZsU5xQD7TMqN8zhsdA3A67squHOh4loHeiupztWrDR6O0tNzmC7HHj6jgwweuTBS
         ePpJ8gzeuOsmgnIrjcymimF4H6J91Biv+B2z+IKI=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id CF92135226A5; Tue,  1 Sep 2020 09:27:19 -0700 (PDT)
Date:   Tue, 1 Sep 2020 09:27:19 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     Rong Chen <rong.a.chen@intel.com>
Cc:     kernel test robot <lkp@intel.com>, Ingo Molnar <mingo@kernel.org>,
        LKML <linux-kernel@vger.kernel.org>, lkp@lists.01.org
Subject: Re: [LKP] Re: [rcuperf] 4e88ec4a9e:
 UBSAN:division-overflow_in_arch/x86/include/asm/div64.h
Message-ID: <20200901162719.GE29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <20200831120122.GH4299@shao2-debian>
 <20200831155037.GZ2855@paulmck-ThinkPad-P72>
 <649fd850-602f-7f0d-d286-73a8dd88ad6d@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <649fd850-602f-7f0d-d286-73a8dd88ad6d@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 01, 2020 at 03:03:28PM +0800, Rong Chen wrote:
> 
> 
> On 8/31/20 11:50 PM, Paul E. McKenney wrote:
> > On Mon, Aug 31, 2020 at 08:01:22PM +0800, kernel test robot wrote:
> > > Greeting,
> > > 
> > > FYI, we noticed the following commit (built with gcc-9):
> > > 
> > > commit: 4e88ec4a9eb17527e640b063f79e5b875733eb53 ("rcuperf: Change rcuperf to rcuscale")
> > > https://git.kernel.org/cgit/linux/kernel/git/next/linux-next.git master
> > > 
> > > 
> > > in testcase: trinity
> > > with following parameters:
> > > 
> > > 	runtime: 300s
> > > 
> > > test-description: Trinity is a linux system call fuzz tester.
> > > test-url: http://codemonkey.org.uk/projects/trinity/
> > > 
> > > 
> > > on test machine: qemu-system-i386 -enable-kvm -cpu SandyBridge -smp 2 -m 8G
> > > 
> > > caused below changes (please refer to attached dmesg/kmsg for entire log/backtrace):
> > > 
> > > 
> > > +---------------------------------------------------------+------------+------------+
> > > |                                                         | 65bd77f554 | 4e88ec4a9e |
> > > +---------------------------------------------------------+------------+------------+
> > > | boot_successes                                          | 13         | 0          |
> > > | boot_failures                                           | 0          | 14         |
> > > | UBSAN:division-overflow_in_arch/x86/include/asm/div64.h | 0          | 14         |
> > > | error:#[##]                                             | 0          | 14         |
> > > | EIP:main_func.cold                                      | 0          | 14         |
> > > | Kernel_panic-not_syncing:Fatal_exception                | 0          | 14         |
> > > +---------------------------------------------------------+------------+------------+
> > > 
> > > 
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kernel test robot <lkp@intel.com>
> > Does the patch below fix this for you?
> 
> Yes, this patch can fix the issue, and nreaders was adjusted to 1:
> 
> [    5.953645] The force parameter has not been set to 1. The Iris poweroff
> handler will not be installed.
> [   12.546587] rcu-ref-scale: --- Start of test:  verbose=0 shutdown=1
> holdoff=10 loops=10000 nreaders=-1 nruns=30 readdelay=0
> [   12.561495] ------------[ cut here ]------------
> [   12.562016] ref_scale_init: nreaders = 0, adjusted to 1
> [   12.562601] WARNING: CPU: 0 PID: 1 at kernel/rcu/refscale.c:684
> ref_scale_init+0x653/0x80

Thank you!  May I add your Tested-by?

							Thanx, Paul

> Best Regards,
> Rong Chen
> 
> > 
> > 							Thanx, Paul
> > 
> > ------------------------------------------------------------------------
> > 
> > commit d301e320e952e2e604d83d9540e52510b0eb3d94
> > Author: Paul E. McKenney <paulmck@kernel.org>
> > Date:   Thu Aug 27 09:58:19 2020 -0700
> > 
> >      refscale: Bounds-check module parameters
> >      The default value for refscale.nreaders is -1, which results in the code
> >      setting the value to three-quarters of the number of CPUs.  On single-CPU
> >      systems, this results in three-quarters of the value one, which the C
> >      language's integer arithmetic rounds to zero.  This in turn results in
> >      a divide-by-zero error.
> >      This commit therefore adds bounds checking to the refscale module
> >      parameters, so that if they are less than one, they are set to the
> >      value one.
> >      Reported-by: kernel test robot <lkp@intel.com>
> >      Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> > 
> > diff --git a/kernel/rcu/refscale.c b/kernel/rcu/refscale.c
> > index 952595c..fb5f20d 100644
> > --- a/kernel/rcu/refscale.c
> > +++ b/kernel/rcu/refscale.c
> > @@ -681,6 +681,12 @@ ref_scale_init(void)
> >   	// Reader tasks (default to ~75% of online CPUs).
> >   	if (nreaders < 0)
> >   		nreaders = (num_online_cpus() >> 1) + (num_online_cpus() >> 2);
> > +	if (WARN_ONCE(loops <= 0, "%s: loops = %ld, adjusted to 1\n", __func__, loops))
> > +		loops = 1;
> > +	if (WARN_ONCE(nreaders <= 0, "%s: nreaders = %d, adjusted to 1\n", __func__, nreaders))
> > +		nreaders = 1;
> > +	if (WARN_ONCE(nruns <= 0, "%s: nruns = %d, adjusted to 1\n", __func__, nruns))
> > +		nruns = 1;
> >   	reader_tasks = kcalloc(nreaders, sizeof(reader_tasks[0]),
> >   			       GFP_KERNEL);
> >   	if (!reader_tasks) {
> > _______________________________________________
> > LKP mailing list -- lkp@lists.01.org
> > To unsubscribe send an email to lkp-leave@lists.01.org
> 
