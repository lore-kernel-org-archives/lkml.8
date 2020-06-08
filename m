Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C0433C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 03:26:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8DA6B2076A
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 03:26:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nlGwpXz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728828AbgFHD0h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 7 Jun 2020 23:26:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52900 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728065AbgFHD0g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Jun 2020 23:26:36 -0400
Received: from mail-oi1-x242.google.com (mail-oi1-x242.google.com [IPv6:2607:f8b0:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6CF9CC08C5C3
        for <linux-kernel@vger.kernel.org>; Sun,  7 Jun 2020 20:26:35 -0700 (PDT)
Received: by mail-oi1-x242.google.com with SMTP id t25so14014605oij.7
        for <linux-kernel@vger.kernel.org>; Sun, 07 Jun 2020 20:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=5PTaL+u+dScBzy4iRXxf7pcmQlfzifFKKyqQzeh6wHU=;
        b=nlGwpXz8xQoud7psx5xPIoq3r/FET6JxKfZcZksUfG0EOJukjjC7Qcrbs8HmbS9oQp
         DniEuVUMbHIxrZ8ecGLvyrWMJvttFAj9AT7k4xUhu0ZakrABGPpHtq8OmGKbmwEOzkAu
         Yr2V6JU/icDu3C0toHA1kh7WuD4ECxzKC8ZAldIVEN5SQgyl6FIu1LMsutsITZl1CFsJ
         buyHnpfljpzrTV2BTpcIAWrcaky+zi7tkY3/AB3+7GGV1LZTmFkXP+SDJ0yXPZX/8Zb/
         mMIRMM5yNEMzcg8VoMxsBohzHur/Y8joFZSEh5eyLyMLGR8zszLopm5akLyMDz7D8zPy
         Zgvg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=5PTaL+u+dScBzy4iRXxf7pcmQlfzifFKKyqQzeh6wHU=;
        b=E1oaki4skDNhTCY7CvHQncCMfp4PdD1YrELonnC2r8ILukUKUWyg/HtCrYf2t/lixD
         AMYiBF7bQ1Ew35FsAgFrZy4ME2i0qjR4KiKAXiQalRgTzqX3AntCFBd577oMuev71sQo
         gLX06VbEdmYu220t+727mKeoTPIhGUZHWkMz6keBFzxu5Ysx4JbNLyrXLVVu9/b4ZO/9
         gttv90Txwgr1ED+TikuPD3BtWUWROWn1dik2owA4CPzox+Bi5VIOEHqnvyClxfVLcfs7
         fusjsrZKv7vrxuiG6q/t39pqerHXfh3xn1PQ5o0YJcJHOc7y4uOYuvFTIL9uKG9Dao5D
         CXhQ==
X-Gm-Message-State: AOAM530XLCLqnV+MvLBCW9kgoLt+wTi0Lar1Q8Hck3j/gKwf6w04zuG4
        zV4mj3HrN4HmgiH9dil7wcQ=
X-Google-Smtp-Source: ABdhPJwaEGjNVZkDePjmoEol1TkhAThGNEeL+SS+XOhg6sxx6bUhlhUZZe9YFUuwhMrG+wR+6BqjaA==
X-Received: by 2002:aca:530e:: with SMTP id h14mr8324377oib.172.1591586794569;
        Sun, 07 Jun 2020 20:26:34 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:4111:8b00::3])
        by smtp.gmail.com with ESMTPSA id a137sm826919oob.27.2020.06.07.20.26.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 07 Jun 2020 20:26:33 -0700 (PDT)
Date:   Sun, 7 Jun 2020 20:26:32 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Kefeng Wang <wangkefeng.wang@huawei.com>
Cc:     paulmck@kernel.org, kernel test robot <lkp@intel.com>,
        Ingo Molnar <mingo@kernel.org>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2020.06.02a 67/90] kernel/rcu/rcuperf.c:727:38:
 warning: format specifies type 'size_t' (aka 'unsigned int') but the
 argument has type 'unsigned long'
Message-ID: <20200608032632.GA2618368@ubuntu-n2-xlarge-x86>
References: <202006060704.dM7SxfSK%lkp@intel.com>
 <20200606001914.GE4455@paulmck-ThinkPad-P72>
 <20200607190057.GA19362@paulmck-ThinkPad-P72>
 <f6df7c3e-4c43-47eb-4c4f-a5e9de0d332f@huawei.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <f6df7c3e-4c43-47eb-4c4f-a5e9de0d332f@huawei.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 08, 2020 at 09:56:16AM +0800, Kefeng Wang wrote:
> 
> On 2020/6/8 3:00, Paul E. McKenney wrote:
> > On Fri, Jun 05, 2020 at 05:19:14PM -0700, Paul E. McKenney wrote:
> > > On Sat, Jun 06, 2020 at 07:07:10AM +0800, kernel test robot wrote:
> > > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.06.02a
> > > > head:   5216948905dd07a84cef8a7dc72c2ec076802efd
> > > > commit: 7d16add62717136b1839f0b3d7ea4cbb98f38c2a [67/90] rcuperf: Fix kfree_mult to match printk() format
> > > > config: arm-randconfig-r004-20200605 (attached as .config)
> > > > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 6dd738e2f0609f7d3313b574a1d471263d2d3ba1)
> > > > reproduce (this is a W=1 build):
> > > >          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > > >          chmod +x ~/bin/make.cross
> > > >          # install arm cross compiling tool for clang build
> > > >          # apt-get install binutils-arm-linux-gnueabi
> > > >          git checkout 7d16add62717136b1839f0b3d7ea4cbb98f38c2a
> > > >          # save the attached .config to linux build tree
> > > >          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm
> > > > 
> > > > If you fix the issue, kindly add following tag as appropriate
> > > > Reported-by: kernel test robot <lkp@intel.com>
> > > Adding Kefeng on CC.  Kefeng, thoughts?
> > Like this, perhaps?
> 
> Hi Paul，I check https://lkml.org/lkml/2020/6/2/286 and <https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/log/?h=dev.2020.06.02a>
> 
> https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git/log/?h=dev.2020.06.02a
> 
> There are two different ways to fix the same issue
> 
> patch 1:  rcuperf: Fix printk format warning urgent-for-mingo
> 
> patch 2:  'rcuperf: Fix kfree_mult to match printk() format' from Ingo 
> after my patch
> 
> since patch1 already merged,  patch2 is not needed, so skip patch2?
> 
> Thanks.
> 
> 
> 
> 
> > 
> > 							Thanx, Paul
> > 
> > diff --git a/kernel/rcu/rcuperf.c b/kernel/rcu/rcuperf.c
> > index 962869d..dc7483a 100644
> > --- a/kernel/rcu/rcuperf.c
> > +++ b/kernel/rcu/rcuperf.c
> > @@ -724,7 +724,7 @@ kfree_perf_init(void)
> >   		schedule_timeout_uninterruptible(1);
> >   	}
> > -	pr_alert("kfree object size=%zu\n", kfree_mult * sizeof(struct kfree_obj));
> > +	pr_alert("kfree object size=%zu\n", (size_t)kfree_mult * sizeof(struct kfree_obj));
> >   	kfree_reader_tasks = kcalloc(kfree_nrealthreads, sizeof(kfree_reader_tasks[0]),
> >   			       GFP_KERNEL);
> > 
> > > > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > > > 
> > > > > > kernel/rcu/rcuperf.c:727:38: warning: format specifies type 'size_t' (aka 'unsigned int') but the argument has type 'unsigned long' [-Wformat]
> > > > pr_alert("kfree object size=%zun", kfree_mult * sizeof(struct kfree_obj));
> > > > ~~~     ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
> > > > %lu
> > > > include/linux/printk.h:295:35: note: expanded from macro 'pr_alert'
> > > > printk(KERN_ALERT pr_fmt(fmt), ##__VA_ARGS__)
> > > > ~~~     ^~~~~~~~~~~
> > > > 1 warning generated.
> > > > 
> > > > vim +727 kernel/rcu/rcuperf.c
> > > > 
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  709)
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  710) static int __init
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  711) kfree_perf_init(void)
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  712) {
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  713) 	long i;
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  714) 	int firsterr = 0;
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  715)
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  716) 	kfree_nrealthreads = compute_real(kfree_nthreads);
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  717) 	/* Start up the kthreads. */
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  718) 	if (shutdown) {
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  719) 		init_waitqueue_head(&shutdown_wq);
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  720) 		firsterr = torture_create_kthread(kfree_perf_shutdown, NULL,
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  721) 						  shutdown_task);
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  722) 		if (firsterr)
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  723) 			goto unwind;
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  724) 		schedule_timeout_uninterruptible(1);
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  725) 	}
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  726)
> > > > b3e2d20973db3e Kefeng Wang             2020-04-17 @727  	pr_alert("kfree object size=%zu\n", kfree_mult * sizeof(struct kfree_obj));
> > > > f87dc808009ac8 Joel Fernandes (Google  2020-03-16  728)
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  729) 	kfree_reader_tasks = kcalloc(kfree_nrealthreads, sizeof(kfree_reader_tasks[0]),
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  730) 			       GFP_KERNEL);
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  731) 	if (kfree_reader_tasks == NULL) {
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  732) 		firsterr = -ENOMEM;
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  733) 		goto unwind;
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  734) 	}
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  735)
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  736) 	for (i = 0; i < kfree_nrealthreads; i++) {
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  737) 		firsterr = torture_create_kthread(kfree_perf_thread, (void *)i,
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  738) 						  kfree_reader_tasks[i]);
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  739) 		if (firsterr)
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  740) 			goto unwind;
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  741) 	}
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  742)
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  743) 	while (atomic_read(&n_kfree_perf_thread_started) < kfree_nrealthreads)
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  744) 		schedule_timeout_uninterruptible(1);
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  745)
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  746) 	torture_init_end();
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  747) 	return 0;
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  748)
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  749) unwind:
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  750) 	torture_init_end();
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  751) 	kfree_perf_cleanup();
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  752) 	return firsterr;
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  753) }
> > > > e6e78b004fa7e0 Joel Fernandes (Google  2019-08-30  754)
> > > > 
> > > > :::::: The code at line 727 was first introduced by commit
> > > > :::::: b3e2d20973db3ec87a6dd2fee0c88d3c2e7c2f61 rcuperf: Fix printk format warning
> > > > 
> > > > :::::: TO: Kefeng Wang <wangkefeng.wang@huawei.com>
> > > > :::::: CC: Paul E. McKenney <paulmck@kernel.org>
> > > > 
> > > > ---
> > > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> > > 
> > .
> > 
> 

Agreed, this is a problem with both patches being applied together,
both GCC and clang agree: https://godbolt.org/z/gGzPV7

Either patch works, it is just a matter of deciding which is better.

Cheers,
Nathan
