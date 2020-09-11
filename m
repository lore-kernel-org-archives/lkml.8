Return-Path: <SRS0=qBN/=CU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7233DC43461
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:07:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 44AD5221EF
	for <linux-kernel@archiver.kernel.org>; Fri, 11 Sep 2020 16:07:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599840468;
	bh=BJY+yNOoMw7zgK4ILlhzlsiyaMOXXiK4sqc9bxH+pm0=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=zIuaCSGBrJs/IHmpHWMvFNIcACXLhzeSBJTdqeoMTudVt2SlJXWfTWhAvXn9Xnrsd
	 SWxfwVuNaC9OyjKEXjPktmFVYeqD4Vzyh364U5L0khONkHE/2re45vhJFMjv7Ogu4Z
	 ZtOw6B7qdB0tvvA2e3Rqym8MivEBLnRRayZh0Bb8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725904AbgIKQH1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 11 Sep 2020 12:07:27 -0400
Received: from mail.kernel.org ([198.145.29.99]:48276 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726462AbgIKQFa (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Sep 2020 12:05:30 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id E0BCD206CA;
        Fri, 11 Sep 2020 13:47:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1599832034;
        bh=BJY+yNOoMw7zgK4ILlhzlsiyaMOXXiK4sqc9bxH+pm0=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=x4A6vei/VnGjiAPOYTWwLqys1twjVk5NRfAmBdbh4OQ+5ibNbh77xIUdy0h71PlZL
         NYrpKO79pscJy10yXb7rMSr+nsIBVxitQCgvcwV/5/3YdTYn6zsaA5P7PmsilONeXh
         8z1G9u6L6kS3YXUAGnORQ4udmuDN8OhyVL46eWY0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id B1FA03522679; Fri, 11 Sep 2020 06:47:14 -0700 (PDT)
Date:   Fri, 11 Sep 2020 06:47:14 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2020.09.07a 23/23] ia64-linux-ld: core.c:undefined
 reference to `n_rtt_sched'
Message-ID: <20200911134714.GW29330@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202009111247.rmtg5aZ8%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202009111247.rmtg5aZ8%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 11, 2020 at 12:54:49PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.09.07a
> head:   cccf684a1da846c3ff830d553bc4cf97bf779f48
> commit: cccf684a1da846c3ff830d553bc4cf97bf779f48 [23/23] rcu-tasks: Mass of debug and fixes
> config: ia64-defconfig (attached as .config)
> compiler: ia64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout cccf684a1da846c3ff830d553bc4cf97bf779f48
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=ia64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>

This one was strictly for debugging, and was not designed to work in
all configurations.  It is not intended for upstream.

							Thanx, Paul

> All errors (new ones prefixed by >>):
> 
>    ia64-linux-ld: kernel/sched/core.o: in function `try_invoke_on_locked_down_task':
>    core.c:(.text+0x86b0): undefined reference to `n_rtt_sched'
> >> ia64-linux-ld: core.c:(.text+0x86c1): undefined reference to `n_rtt_sched'
> >> ia64-linux-ld: core.c:(.text+0x8810): undefined reference to `n_rtt_sched_waking'
>    ia64-linux-ld: core.c:(.text+0x8811): undefined reference to `n_rtt_sched_waking'
> >> ia64-linux-ld: core.c:(.text+0x8850): undefined reference to `n_rtt_sched_fail'
>    ia64-linux-ld: core.c:(.text+0x8851): undefined reference to `n_rtt_sched_fail'
> >> ia64-linux-ld: core.c:(.text+0x88a0): undefined reference to `n_rtt_sched_running'
>    ia64-linux-ld: core.c:(.text+0x88a1): undefined reference to `n_rtt_sched_running'
>    ia64-linux-ld: core.c:(.text+0x88e0): undefined reference to `n_rtt_sched_fail'
>    ia64-linux-ld: core.c:(.text+0x88e1): undefined reference to `n_rtt_sched_fail'
> >> ia64-linux-ld: core.c:(.text+0x8990): undefined reference to `n_rtt_sched_offrq'
>    ia64-linux-ld: core.c:(.text+0x8991): undefined reference to `n_rtt_sched_offrq'
> >> ia64-linux-ld: core.c:(.text+0x8a90): undefined reference to `n_rtt_sched_onrq'
>    ia64-linux-ld: core.c:(.text+0x8a91): undefined reference to `n_rtt_sched_onrq'
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


