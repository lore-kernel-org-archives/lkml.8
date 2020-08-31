Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CCE05C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 00:46:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A5A85206CD
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 00:46:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="olDie+Rm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726527AbgHaAqq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 20:46:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726179AbgHaAqn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 20:46:43 -0400
Received: from mail-pl1-x641.google.com (mail-pl1-x641.google.com [IPv6:2607:f8b0:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4237DC061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 17:46:43 -0700 (PDT)
Received: by mail-pl1-x641.google.com with SMTP id l9so606555plt.8
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 17:46:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=WOJm8ChQvGCMDz2RMh62IxNo08qEpOf/spwm7+vX978=;
        b=olDie+Rm4WopleSRFNWphbZ444xvDBmf46Q8CcaDyjdLnvqx9Ylc/eat1SsC+ljLFr
         0Raf0NtPzp1x9/0KCV1XxzSSxsIf+kawpf/pZ4tZVPQ2528NgTQ+/tPCWKsxS5HDd4Ns
         G5t9n0gkJWMab+9SXlJU7UKfPaQr45VeOFboZ7fbDXxZz0l6HKCIhni4E7jN7BW0TZ4/
         gmgCuNqzGMeBRoQyqiM8C3Z+OSxV8CpeH7v4cJagSScSCN6Cspzv715k5IWnQ7KoUrNb
         4QPLFDPlKkZZNY/OcYQfOrXxEvc4ok9wmMsnSATHgSZrzFbPRjMcWBb3RARvGQNj0Mo8
         4UvQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=WOJm8ChQvGCMDz2RMh62IxNo08qEpOf/spwm7+vX978=;
        b=JiK3UAeuxSepQABKxeest/rIuZexiIKIlyIYiMGUQr2DYOt03L2qTrQuolDIaX/USM
         2Hq2aoWDrr2sepXB8MkmU42nkqlQaia0J8kdbzgkrXSfVpeLQqyb7NLBGW/E6GBXEjUe
         5thvYZcZzCVE8C5A+bJIC5gE2SgagjI0xzL9wqFWsXiZDFDS1RB7Zcrl0zZP1nqdwoQ1
         BKP0BLseGfS32fkKIbMzr+SaKShczti1k0w4SufoOUgF9nZ8p/6oMQIVjgrIdFT7cxJC
         GWhjYnvd9AM2V2KgLGc8AHwc1z3Q6AnFgBkGken0EU9+zaHiPaJ3qmocg51RaxEv8TU7
         BJgg==
X-Gm-Message-State: AOAM531GYc8ezjETGsNHC1N27afpzdlgCWU8aOPl8plNfy/1G5rG2MTd
        p4vorAiGG41U1P1HPEUSn4Xasg==
X-Google-Smtp-Source: ABdhPJySBM/g4LQlvQrX4En+nX15sAosgmwv21+iFTd2a998u6UCHAnjcd3Z/kYUzo0sVt7qGFLqzA==
X-Received: by 2002:a17:90a:1741:: with SMTP id 1mr8846973pjm.173.1598834802639;
        Sun, 30 Aug 2020 17:46:42 -0700 (PDT)
Received: from leoy-ThinkPad-X240s ([2600:3c01::f03c:91ff:fe8a:bb03])
        by smtp.gmail.com with ESMTPSA id l22sm6226183pfc.27.2020.08.30.17.46.40
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Sun, 30 Aug 2020 17:46:42 -0700 (PDT)
Date:   Mon, 31 Aug 2020 08:46:36 +0800
From:   Leo Yan <leo.yan@linaro.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jeffrey Hugo <jeffrey.l.hugo@gmail.com>
Subject: Re: include/asm-generic/qspinlock.h:94:9: sparse: sparse: context
 imbalance in '__msm_console_write' - unexpected unlock
Message-ID: <20200831004636.GB4715@leoy-ThinkPad-X240s>
References: <202008290845.9m3df1TL%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008290845.9m3df1TL%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Aug 29, 2020 at 08:27:03AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   005c53447a63cbce10de37406975a34d7bdc8704
> commit: 0e4f7f920a5c6bfe5e851e989f27b35a0cc7fb7e tty: serial: msm_serial: Fix lockup for sysrq and oops
> date:   9 months ago
> config: arm64-randconfig-s031-20200829 (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.2-191-g10164920-dirty
>         git checkout 0e4f7f920a5c6bfe5e851e989f27b35a0cc7fb7e
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arm64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
>    drivers/tty/serial/msm_serial.c:736:25: sparse: sparse: context imbalance in 'msm_handle_rx_dm' - unexpected unlock
>    drivers/tty/serial/msm_serial.c:802:28: sparse: sparse: context imbalance in 'msm_handle_rx' - unexpected unlock
>    drivers/tty/serial/msm_serial.c:1100:12: sparse: sparse: context imbalance in 'msm_set_baud_rate' - unexpected unlock
>    drivers/tty/serial/msm_serial.c: note: in included file (through arch/arm64/include/generated/asm/qspinlock.h, arch/arm64/include/asm/spinlock.h, include/linux/spinlock.h, ...):
> >> include/asm-generic/qspinlock.h:94:9: sparse: sparse: context imbalance in '__msm_console_write' - unexpected unlock

I think this is a false positive report.  Let's see the locking
relevant code in __msm_console_write():

  __msm_console_write() {

      int locked = 1;

      [...]

      if (port->sysrq)
          locked = 0;
      else if (oops_in_progress)
          locked = spin_trylock(&port->lock);
      else
          spin_lock(&port->lock);

      [...]

      if (locked)
          spin_unlock(&port->lock);
  }

Since we need to handle oops and sysrq as special cases, it uses
'locked' to indicate the spinlock has been acquired and later will
release spinlock if 'locked' is true.  So locking and unlocking are
paired and I don't see what's the reason the robot reports the context
imbalance.

BTW, this report is not only for msm_serial driver, it also might be
applied to many other serial drivers, e.g.

  drivers/tty/serial/amba-pl011.c
  drivers/tty/serial/xilinx_uartps.c
  drivers/tty/serial/stm32-usart.c

Maybe I miss something at here, if so please let me know.

Thanks,
Leo

> # https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git/commit/?id=0e4f7f920a5c6bfe5e851e989f27b35a0cc7fb7e
> git remote add linus https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git
> git fetch --no-tags linus master
> git checkout 0e4f7f920a5c6bfe5e851e989f27b35a0cc7fb7e
> vim +/__msm_console_write +94 include/asm-generic/qspinlock.h
> 
> a33fda35e3a765 Waiman Long 2015-04-24  83  
> a33fda35e3a765 Waiman Long 2015-04-24  84  #ifndef queued_spin_unlock
> a33fda35e3a765 Waiman Long 2015-04-24  85  /**
> a33fda35e3a765 Waiman Long 2015-04-24  86   * queued_spin_unlock - release a queued spinlock
> a33fda35e3a765 Waiman Long 2015-04-24  87   * @lock : Pointer to queued spinlock structure
> a33fda35e3a765 Waiman Long 2015-04-24  88   */
> a33fda35e3a765 Waiman Long 2015-04-24  89  static __always_inline void queued_spin_unlock(struct qspinlock *lock)
> a33fda35e3a765 Waiman Long 2015-04-24  90  {
> a33fda35e3a765 Waiman Long 2015-04-24  91  	/*
> ca50e426f96c90 Pan Xinhui  2016-06-03  92  	 * unlock() needs release semantics:
> a33fda35e3a765 Waiman Long 2015-04-24  93  	 */
> 626e5fbc143589 Will Deacon 2018-04-26 @94  	smp_store_release(&lock->locked, 0);
> a33fda35e3a765 Waiman Long 2015-04-24  95  }
> a33fda35e3a765 Waiman Long 2015-04-24  96  #endif
> a33fda35e3a765 Waiman Long 2015-04-24  97  
> 
> :::::: The code at line 94 was first introduced by commit
> :::::: 626e5fbc14358901ddaa90ce510e0fbeab310432 locking/qspinlock: Use smp_store_release() in queued_spin_unlock()
> 
> :::::: TO: Will Deacon <will.deacon@arm.com>
> :::::: CC: Ingo Molnar <mingo@kernel.org>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


