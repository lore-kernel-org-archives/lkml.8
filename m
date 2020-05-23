Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D52DAC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:48:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9CFB7207F7
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 18:48:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BkSah+YQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728509AbgEWSsi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 14:48:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35094 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726790AbgEWSsi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 14:48:38 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF48C061A0E
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 11:48:38 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id t16so5747718plo.7
        for <linux-kernel@vger.kernel.org>; Sat, 23 May 2020 11:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=4UZFboajCyvY8ffJvevOtWVLcZNPbhfr/3Q3BIm6NEc=;
        b=BkSah+YQ4euBT82PIMqzOF2OETZxGyffSXEqOprvsPNsAePR9L8KiSVHWhiwmWRTCl
         DXsEbiR4aIrrDOz987mGXS0OKAoQTEczfSPTbA5Cwr5dof7MjaQicDaeUQkttzzU0GWX
         9+5ZIa+7VcUbeh8oVgeUa+rvEh++dyeAXlnL1+926LIXMEREesROixWFYUNJ7nuCHERe
         eswP0ldSXrpAkX6g216DePyzfVFkhXvDNf+ZVdxd38UJwDExfd+hqZCT1ygSGl+4usWp
         MHLYMWfoutOM1E9p0ug8XDbpf5qQrkhAKFDxp8XpDS+YC+mLVQwHOIQA/GQK6CN2yLpy
         Uqpg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4UZFboajCyvY8ffJvevOtWVLcZNPbhfr/3Q3BIm6NEc=;
        b=atVMLc9pAyNj/+f93fA5MuEsJGVFcojU1fWKu4HXbxKtpjtu3NxErZa2MXXAPQHWcX
         443fKJ/kwHe8oewJVi/5lViEYVizsPgmOdE8VpPytRth4UYUl2rQquqQvRGyWmTRtrMn
         +F2dJl0GlKe1GI5MduEYzzCu3nKs2yYVC97a3t3NqyNv6OIvNFJF9emECGw/23QNzpO9
         YJBgmbMQwL4VjUOqWwVX9s8I2Rq3u0RKNRZUFnBK0BPpP4xLwuwuyiOl8udgeuVRYzFr
         kTilsMn9lV5UpdpLU4p+HqLcs1LeoP9eO+cm3aRqNg9xU/KPF9bNsinfw+JKIAjt7LPI
         HJOA==
X-Gm-Message-State: AOAM530KicydURtitoVsWG8nwzzfAQO0RzWCIrUiL2wLLspmzthNS0Th
        tInHCKtdf6OiEdr/ELwSWO0=
X-Google-Smtp-Source: ABdhPJzIIkzFxpnOXjtWPPlZZYPExXaAVW6PTrwGxlVqoEZgXrh7haXBC4himDGYKXz7z8TnZPPSRg==
X-Received: by 2002:a17:90a:4495:: with SMTP id t21mr11886501pjg.185.1590259717472;
        Sat, 23 May 2020 11:48:37 -0700 (PDT)
Received: from workstation-portable ([103.87.56.140])
        by smtp.gmail.com with ESMTPSA id u73sm9930668pfc.0.2020.05.23.11.48.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 23 May 2020 11:48:36 -0700 (PDT)
Date:   Sun, 24 May 2020 00:18:30 +0530
From:   Amol Grover <frextrite@gmail.com>
To:     joel@joelfernandes.org
Cc:     kernel test robot <lkp@intel.com>,
        Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>,
        LKP <lkp@lists.01.org>, linux-kernel@vger.kernel.org,
        "Paul E. McKenney" <paulmck@kernel.org>, philip.li@intel.com
Subject: Re: f410328e93 ("Default enable RCU list lockdep debugging with
 .."): WARNING: suspicious RCU usage
Message-ID: <20200523184830.GA2462@workstation-portable>
References: <5ec96105.3P8mdNMioNCPj5S6%lkp@intel.com>
 <62D222FE-1187-4A0F-8CF4-127058F9413C@joelfernandes.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <62D222FE-1187-4A0F-8CF4-127058F9413C@joelfernandes.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, May 23, 2020 at 02:28:36PM -0400, joel@joelfernandes.org wrote:
> Madhu,
> Did the creds patches make it upstream? If not, could you or Amol revive them?
> 

Hi Joel,

I was myself thinking of reviving the cred patches (but it slipped my
mind). Thanks for the reminder, I'll do it.

Thanks
Amol

> Thanks.
> 
> 
> On May 23, 2020 1:44:37 PM EDT, kernel test robot <lkp@intel.com> wrote:
> >Greetings,
> >
> >0day kernel testing robot got the below dmesg and the first bad commit
> >is
> >
> >https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git
> >dev.2020.05.14b
> >
> >commit f410328e93834f1d9c7e2f707ac05fd9e6417c27
> >Author:     Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> >AuthorDate: Fri Feb 28 14:54:51 2020 +0530
> >Commit:     Paul E. McKenney <paulmck@kernel.org>
> >CommitDate: Thu May 14 10:11:39 2020 -0700
> >
> >    Default enable RCU list lockdep debugging with PROVE_RCU
> >    
> >    This patch default enables CONFIG_PROVE_RCU_LIST option with
> >    CONFIG_PROVE_RCU for RCU list lockdep debugging.
> >    
> >    With this change, RCU list lockdep debugging will be default
> >    enabled in CONFIG_PROVE_RCU=y kernels.
> >    
> >    Most of the RCU users (in core kernel/, drivers/, and net/
> >    subsystem) have already been modified to include lockdep
> >    expressions hence RCU list debugging can be enabled by
> >    default.
> >    
> >    However, there are still chances of enountering
> >    false-positive lockdep splats because not everything is converted,
> >    in case RCU list primitives are used in non-RCU read-side critical
> >    section but under the protection of a lock. It would be okay to
> > have a few false-positives, as long as bugs are identified, since this
> >    patch only affects debugging kernels.
> >    
> >    Co-developed-by: Amol Grover <frextrite@gmail.com>
> >    Signed-off-by: Amol Grover <frextrite@gmail.com>
> >    Signed-off-by: Madhuparna Bhowmik <madhuparnabhowmik10@gmail.com>
> >    Acked-by: Joel Fernandes (Google) <joel@joelfernandes.org>
> >    Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
> >
> >df2e4807c8  torture: Add --allcpus argument to the kvm.sh script
> >f410328e93  Default enable RCU list lockdep debugging with PROVE_RCU
> >c1628f71b9  ubsan, kcsan: Don't combine sanitizer with kcov on clang
> >+-------------------------------------------------------------------------+------------+------------+------------+
> >|                                                                      
> >  | df2e4807c8 | f410328e93 | c1628f71b9 |
> >+-------------------------------------------------------------------------+------------+------------+------------+
> >| boot_successes                                                       
> >  | 2          | 0          | 0          |
> >| boot_failures                                                        
> >  | 37         | 17         | 23         |
> >| Assertion_failed                                                     
> >  | 33         | 13         | 13         |
> >| Kernel_panic-not_syncing:Attempted_to_kill_init!exitcode=            
> >  | 35         | 15         | 21         |
> >| BUG:kernel_hang_in_test_stage                                        
> >  | 2          | 1          |            |
> >| WARNING:suspicious_RCU_usage                                         
> >  | 0          | 17         | 23         |
> >| security/smack/smack_lsm.c:#RCU-list_traversed_in_non-reader_section 
> >  | 0          | 17         | 23         |
> >|
> >security/smack/smack_access.c:#RCU-list_traversed_in_non-reader_section
> >| 0          | 17         | 23         |
> >+-------------------------------------------------------------------------+------------+------------+------------+
> >
> >If you fix the issue, kindly add following tag
> >Reported-by: kernel test robot <lkp@intel.com>
> >
> >[    0.347631] ..... CPU clock speed is 2893.0023 MHz.
> >[    0.347631] ..... host bus clock speed is 1000.0027 MHz.
> >[    0.347677] smpboot: CPU0: Intel Common KVM processor (family: 0xf,
> >model: 0x6, stepping: 0x1)
> >[    0.348602] 
> >[    0.348635] =============================
> >[    0.348962] WARNING: suspicious RCU usage
> >[    0.349295] 5.7.0-rc2-00236-gf410328e93834 #1 Not tainted
> >[    0.349634] -----------------------------
> >[    0.349962] security/smack/smack_lsm.c:354 RCU-list traversed in
> >non-reader section!!
> >[    0.350634] 
> >[    0.350634] other info that might help us debug this:
> >[    0.350634] 
> >[    0.351278] 
> >[    0.351278] rcu_scheduler_active = 1, debug_locks = 1
> >[    0.351675] no locks held by kthreadd/2.
> >[    0.351997] 
> >[    0.351997] stack backtrace:
> >[    0.352636] CPU: 0 PID: 2 Comm: kthreadd Not tainted
> >5.7.0-rc2-00236-gf410328e93834 #1
> >[    0.353267] Hardware name: QEMU Standard PC (i440FX + PIIX, 1996),
> >BIOS 1.12.0-1 04/01/2014
> >[    0.353631] Call Trace:
> >[    0.353631]  ? dump_stack+0x6b/0x9b
> >[    0.353631]  ? smack_cred_prepare+0x1c8/0x1e0
> >[    0.353631]  ? smack_sk_alloc_security+0xa0/0xa0
> >[    0.353631]  ? security_prepare_creds+0x3f/0x90
> >[    0.353631]  ? prepare_creds+0x13c/0x260
> >[    0.353631]  ? copy_creds+0x2c/0x1d0
> >[    0.353631]  ? copy_process+0x366/0x1760
> >[    0.353631]  ? lock_acquire+0x72/0x370
> >[    0.353631]  ? _do_fork+0x71/0x680
> >[    0.353631]  ? lock_acquire+0x72/0x370
> >[    0.353631]  ? kthread_park+0xa0/0xa0
> >[    0.353631]  ? kthreadd+0x50/0x140
> >[    0.353631]  ? kernel_thread+0x4e/0x60
> >[    0.353631]  ? kthread_park+0xa0/0xa0
> >[    0.353631]  ? kthreadd+0xf4/0x140
> >[    0.353631]  ? kthread_create_on_cpu+0x80/0x80
> >[    0.353631]  ? ret_from_fork+0x2e/0x38
> >[    0.354096] Performance Events: unsupported Netburst CPU model 6 no
> >PMU driver, software events only.
> >[    0.354910] rcu: Hierarchical SRCU implementation.
> >[    0.356850] NMI watchdog: Perf NMI watchdog permanently disabled
> >[    0.357864] smp: Bringing up secondary CPUs ...
> >[    0.359261] x86: Booting SMP configuration:
> >
> >                   # HH:MM RESULT GOOD BAD GOOD_BUT_DIRTY DIRTY_NOT_BAD
> >git bisect start 144ce0ceed88071d2cffb323089fcb710f2e4350
> >0e698dfa282211e414076f9dc7e83c1c288314fd --
> >git bisect good 0f5233d56ed5563c895eb957131074e71b821ffd  # 23:25  G   
> >11     0   11  11  Merge 'regulator/for-next' into
> >devel-catchup-202005150615
> >git bisect good a9f1f0805c1a2d8b1a53afbae38c3516b5194179  # 23:31  G   
> > 11     0   11  17  Merge 's390/fixes' into devel-catchup-202005150615
> >git bisect  bad 61973078db675fd3ee2e26fc0bd9708b9d79b2df  # 23:41  B   
> >0     8   29   5  Merge 'rcu/dev.2020.05.14b' into
> >devel-catchup-202005150615
> >git bisect good 74e078cc85670493864c48208e04229d4fac48fa  # 23:50  G   
> >11     0   11  17  Merge
> >'linux-review/Grygorii-Strashko/soc-ti-add-k3-platforms-chipid-module-driver/20200514-153644'
> >into devel-catchup-202005150615
> >git bisect good 4b0c4c07546dfca786eaa447d9f9f95b25c7b399  # 23:58  G   
> >10     0   10  22  Merge 'jpirko-mlxsw/combined_queue' into
> >devel-catchup-202005150615
> >git bisect good 8b458949f2e7896ee126899994a23735a9be2d2d  # 00:07  G   
> >11     0   11  17  Merge 'block/for-5.8/block' into
> >devel-catchup-202005150615
> >git bisect  bad e317828f7d9693a7cd5a718e947bcf3824f6146a  # 00:16  B   
> >  0     7   25   2  rcu: Expedited grace-period sleeps to idle priority
> >git bisect  bad 9ddfee9e62685e77b23c25a0fff7eaef56092130  # 00:23  B   
> >0    11   32   5  rcu: Grace-period-kthread related sleeps to idle
> >priority
> >git bisect  bad f410328e93834f1d9c7e2f707ac05fd9e6417c27  # 00:33  B   
> >0     1   21   4  Default enable RCU list lockdep debugging with
> >PROVE_RCU
> ># first bad commit: [f410328e93834f1d9c7e2f707ac05fd9e6417c27] Default
> >enable RCU list lockdep debugging with PROVE_RCU
> >git bisect good df2e4807c87c32ff01e0fe25b0fdf1352ab986bd  # 00:53  G   
> >33     0   33  35  torture: Add --allcpus argument to the kvm.sh script
> ># extra tests with debug options
> >git bisect  bad f410328e93834f1d9c7e2f707ac05fd9e6417c27  # 01:01  B   
> >0    10   26   0  Default enable RCU list lockdep debugging with
> >PROVE_RCU
> ># extra tests on head commit of rcu/dev.2020.05.14b
> >git bisect  bad c1628f71b9ac81a2349f02cdebaaefe35a3fe4ba  # 01:22  B   
> >0     8   36  12  ubsan, kcsan: Don't combine sanitizer with kcov on
> >clang
> ># bad: [c1628f71b9ac81a2349f02cdebaaefe35a3fe4ba] ubsan, kcsan: Don't
> >combine sanitizer with kcov on clang
> ># extra tests on revert first bad commit
> >git bisect good 183564b7c798c2d106ad64972d202433a536ccca  # 01:44  G   
> >11     0   11  11  Revert "Default enable RCU list lockdep debugging
> >with PROVE_RCU"
> ># good: [183564b7c798c2d106ad64972d202433a536ccca] Revert "Default
> >enable RCU list lockdep debugging with PROVE_RCU"
> >
> >---
> >0-DAY CI Kernel Test Service, Intel Corporation
> >https://lists.01.org/hyperkitty/list/lkp@lists.01.org
> 
> -- 
> Sent from my Android device with K-9 Mail. Please excuse my brevity.
