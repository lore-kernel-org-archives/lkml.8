Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0B03DC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 20:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D220E20675
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 20:45:52 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597265152;
	bh=nsp30OjwJsZMirZS4TE87uFZBgzToOXBI+Ebs9g+O5I=;
	h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:List-ID:
	 From;
	b=BcfIVRzFyqHTidJu5WrfE5Cf2/crBVjc6Zh+lCbXm0xzle4HtwT1Sjr3SbvSvqfXW
	 CuToL1otUi4LBmvLlMoNjrcTvlw00iiObcKPGLRE10tirbUOk5aRmNFhK4PAR2D10g
	 LU8hPlrRWy/7ecwArAMmgZRx20GmUxpHleimX5Xk=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726547AbgHLUpv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Aug 2020 16:45:51 -0400
Received: from mail.kernel.org ([198.145.29.99]:57274 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726030AbgHLUpu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Aug 2020 16:45:50 -0400
Received: from paulmck-ThinkPad-P72.home (unknown [50.45.173.55])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 13CAC20675;
        Wed, 12 Aug 2020 20:45:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597265150;
        bh=nsp30OjwJsZMirZS4TE87uFZBgzToOXBI+Ebs9g+O5I=;
        h=Date:From:To:Cc:Subject:Reply-To:References:In-Reply-To:From;
        b=YWg7i33yEXOg+V+P7n+XXVzOg/eYJZZ/20UZDcXk7ojVeA/qdihAyIrY2lgQ4y+vf
         OAfaSPXow/Z7Ce9l/gcTMjuNY5RAm/KlL9Y01a0mKCYerxOAIKl/c70CxJUt9L+b3B
         sPlNqSclI2K7iBRgiWqV0j1U+xc11bg3VMDEN9p0=
Received: by paulmck-ThinkPad-P72.home (Postfix, from userid 1000)
        id E5EE13522615; Wed, 12 Aug 2020 13:45:48 -0700 (PDT)
Date:   Wed, 12 Aug 2020 13:45:48 -0700
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: [rcu:dev.2020.08.10a 105/111] main.c:undefined reference to
 `rcu_read_unlock_strict'
Message-ID: <20200812204548.GK4295@paulmck-ThinkPad-P72>
Reply-To: paulmck@kernel.org
References: <202008120752.kdAks6DZ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008120752.kdAks6DZ%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Aug 12, 2020 at 07:39:54AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/paulmck/linux-rcu.git dev.2020.08.10a
> head:   9dd4d242c535c30266a08806314ea6b016f94617
> commit: 9e20110f8ef2745df8f4fe2d679114dccfaaa1af [105/111] rcu: Report QS for outermost PREEMPT=n rcu_read_unlock() for strict GPs
> config: arm-mainstone_defconfig (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 9e20110f8ef2745df8f4fe2d679114dccfaaa1af
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    arm-linux-gnueabi-ld: init/main.o: in function `rest_init':
> >> main.c:(.ref.text+0x34): undefined reference to `rcu_read_unlock_strict'
> >> arm-linux-gnueabi-ld: main.c:(.ref.text+0x58): undefined reference to `rcu_read_unlock_strict'

Good catch, broke single-CPU yet again!  ;-)

Fixed, will be merge into original with attribution.

							Thanx, Paul

>    arm-linux-gnueabi-ld: kernel/fork.o: in function `get_mm_exe_file':
> >> fork.c:(.text+0x3ac): undefined reference to `rcu_read_unlock_strict'
>    arm-linux-gnueabi-ld: kernel/fork.o: in function `pidfd_poll':
>    fork.c:(.text+0x650): undefined reference to `rcu_read_unlock_strict'
>    arm-linux-gnueabi-ld: kernel/fork.o: in function `_do_fork':
>    fork.c:(.text+0x2e10): undefined reference to `rcu_read_unlock_strict'
>    arm-linux-gnueabi-ld: kernel/fork.o:fork.c:(.text+0x2e8c): more undefined references to `rcu_read_unlock_strict' follow
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


