Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 58382C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:41:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 249792089D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 22:41:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="WsYdt1m7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726160AbgFZWlN (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 18:41:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725951AbgFZWlM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 18:41:12 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 238AAC03E979
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:41:13 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id d6so5532198pjs.3
        for <linux-kernel@vger.kernel.org>; Fri, 26 Jun 2020 15:41:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=jyAPAzsMhs9Zr4S/upw4vcz2u3YBAX8bVwtFvbGa900=;
        b=WsYdt1m7eb72QqAqYqr5Jmq/eveXJ3Q+s7NGWlAIIHy9K7bDaA9+mjVqBSqZmPL2at
         /qzRxaie0k4SBTyPlCXPrAT6R1DysDDK4HvCS57Edd+JQpCC8vQeu4D3CUEsFHRw+0Zi
         SCnyrchS/lcsfVdSU5fGX8Y2o3nLRbIJ4AvdzPk94wpyDgePg3XjTxuMBlfo5rM33/Hv
         ZSR3DNZGXXexPh96lTsBLvHi7fI0d7gE419FKlyoEFnVOuVPeb9hi/OPE7JZb9oBYeSk
         BufsvCyzS5V36ElryKAgxTcikwMNEtXIgv4hQZqnTU4xsXz23uCsztyxIY8CZh/HUdhm
         0dFg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:date:from:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to:user-agent;
        bh=jyAPAzsMhs9Zr4S/upw4vcz2u3YBAX8bVwtFvbGa900=;
        b=eRCBlSpPKAPlGT1IOUpaspIC0SWh8xc5Pk5f1tdi9fOuiL67XxcyErwhIaEno8CFjO
         dHN3BeViPflgr2gJ2XUPGSjHpJoxESNhuNyx8JXVYMpa0rnANSniZZpXY7LIMZnmCKGh
         LvkAKBj7o/ecPM299HJTi3fnIrBCZgBFuxoOSZHHIDdVSxfroglNsUNgtn47hDMfX0DB
         qzsArp73SY7a4MxCEGMsY/6C+BOgVEsIp3pH4wlT04OXj1rT1bl20mLeJY5rnT1uO/93
         k+KN1L7xFyKsc2DP84OXM4+MXdmaEVN5Y9mOx4g7XWkPoPj8YJi0uWrxVSwnVh2AZj6q
         eqZw==
X-Gm-Message-State: AOAM532q/It7X+beXcApuyWTU+Pc++wKK7cI7wmj+5IQS0/3jYJgpV4i
        VkjZTaDzh6803VPoZaBczuQ=
X-Google-Smtp-Source: ABdhPJwRtp9N3wYng98P6k8DZ2bBVbepo59kjEENXi/gn4UHNaA8hGcbRchnSC/PlGcvs2HBTswmXw==
X-Received: by 2002:a17:90b:78b:: with SMTP id l11mr5619404pjz.59.1593211272683;
        Fri, 26 Jun 2020 15:41:12 -0700 (PDT)
Received: from localhost ([2600:1700:e321:62f0:329c:23ff:fee3:9d7c])
        by smtp.gmail.com with ESMTPSA id m20sm28737108pfk.52.2020.06.26.15.41.11
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 26 Jun 2020 15:41:12 -0700 (PDT)
Date:   Fri, 26 Jun 2020 15:41:11 -0700
From:   Guenter Roeck <linux@roeck-us.net>
To:     kernel test robot <lkp@intel.com>
Cc:     Ingo Molnar <mingo@redhat.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] sched: Declare sched_rt_bandwidth_account() in include
 file
Message-ID: <20200626224111.GB256865@roeck-us.net>
References: <20200626140253.141358-1-linux@roeck-us.net>
 <202006270351.lVmaZ420%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006270351.lVmaZ420%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 27, 2020 at 03:16:15AM +0800, kernel test robot wrote:
> Hi Guenter,
> 
> I love your patch! Yet something to improve:
> 
> [auto build test ERROR on tip/sched/core]
> [also build test ERROR on tip/auto-latest linux/master linus/master v5.8-rc2 next-20200626]
> [If your patch is applied to the wrong git tree, kindly drop us a note.
> And when submitting patch, we suggest to use  as documented in
> https://git-scm.com/docs/git-format-patch]
> 
> url:    https://github.com/0day-ci/linux/commits/Guenter-Roeck/sched-Declare-sched_rt_bandwidth_account-in-include-file/20200626-220544
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git 01e377c539ca52a6c753d0fdbe93b3b8fcd66a1c
> config: x86_64-allnoconfig (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 6e11ed52057ffc39941cb2de6d93cae522db4782)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
> >> kernel/sched/deadline.c:1315:7: error: implicit declaration of function 'sched_rt_bandwidth_account' [-Werror,-Wimplicit-function-declaration]
>                    if (sched_rt_bandwidth_account(rt_rq))
>                        ^

Guess I missed some condition. I'll try again.

Guenter
