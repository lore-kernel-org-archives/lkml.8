Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D385C2BB85
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22D552078C
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 14:28:55 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586269735;
	bh=G6M+/h+GzYxHgmHQGEXmYLT3cbRilcHwYyAogjKX4uk=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=st/TN5TboLfxEEyA/jccka5OP4LLQUP72ZEKRRA9cG1gObv45LgLOsJ6xoY2NyNt6
	 /Lb4wmRP2MqcLxfC9XxS6BaV3vr8j2XUFn88xQidxo9P06piJxUFYwkcTYiGTdQ/aq
	 QfLSlDP8GIUMYFEWtvCOJ9/h8pcxgYha5xlziyOY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729185AbgDGO2x (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 10:28:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:47528 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729163AbgDGO2t (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 10:28:49 -0400
Received: from paulmck-ThinkPad-P72.home (50-39-105-78.bvtn.or.frontiernet.net [50.39.105.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 47C902078C;
        Tue,  7 Apr 2020 14:28:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586269729;
        bh=G6M+/h+GzYxHgmHQGEXmYLT3cbRilcHwYyAogjKX4uk=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=poTrtYyI1ZrO76LYau4vYTfIgauSey2imTJW2W6bU6HLOPNJYCbV71duGry1rsQ0i
         79kyUuBSHzuG+gY0ZHtEtXPUvxUppvV0Epen2BHsUW5Qm0CIZkN1HhkI+usUUvfXP+
         2Vl/yfMfHKUBgv/3L5YBENuCmdFQXbeY2EHFi4iY=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id 2187435226A6; Tue,  7 Apr 2020 07:28:49 -0700 (PDT)
Date:   Tue, 7 Apr 2020 07:28:49 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2020.04.05b 101/101] kprobes.c:undefined reference to
 `.synchronize_rcu_tasks'
Message-ID: <20200407142849.GR19865@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202004071208.Y3tnrrx2%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202004071208.Y3tnrrx2%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 12:06:11PM +0800, kbuild test robot wrote:
> Hi Paul,
> 
> It's probably a bug fix that unveils the link errors.

Looks like my fault, actually, but your "unveils" point is right on,
as it appears that this change exposed a bug in an earlier commit.

Will fix, and thank you for the testing!

							Thanx, Paul

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.04.05b
> head:   805020c8028f6e95a8fc57132af5f896a8ad6391
> commit: 805020c8028f6e95a8fc57132af5f896a8ad6391 [101/101] squash! rcu-tasks: Add an RCU Tasks Trace to simplify protection of tracing hooks
> config: powerpc-defconfig (attached as .config)
> compiler: powerpc64-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 805020c8028f6e95a8fc57132af5f896a8ad6391
>         # save the attached .config to linux build tree
>         GCC_VERSION=9.3.0 make.cross ARCH=powerpc 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    powerpc64-linux-ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'
>    powerpc64-linux-ld: kernel/kprobes.o: in function `.kprobe_optimizer':
> >> kprobes.c:(.text+0x2bc8): undefined reference to `.synchronize_rcu_tasks'
>    powerpc64-linux-ld: kernel/bpf/trampoline.o: in function `.bpf_trampoline_put':
> >> trampoline.c:(.text+0x630): undefined reference to `.synchronize_rcu_tasks'
>    powerpc64-linux-ld: kernel/bpf/trampoline.o: in function `.bpf_trampoline_update':
>    trampoline.c:(.text+0x908): undefined reference to `.synchronize_rcu_tasks'
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


