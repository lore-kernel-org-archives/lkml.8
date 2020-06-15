Return-Path: <SRS0=PJcK=74=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6FD09C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:27:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 493C72078A
	for <linux-kernel@archiver.kernel.org>; Mon, 15 Jun 2020 15:27:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="RSrzRSdV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730327AbgFOP1f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 15 Jun 2020 11:27:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728326AbgFOP1e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Jun 2020 11:27:34 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BFF1C061A0E
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:27:33 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id e18so7736908pgn.7
        for <linux-kernel@vger.kernel.org>; Mon, 15 Jun 2020 08:27:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=H0eZIb3dx86MseSJBS54PQAJPp88oPjLSYVP7aVWt7s=;
        b=RSrzRSdV3qBplFG5UMkMrvF9ziCIuShr/gmIyUoUxrVaqyu1ajLVGDkWCNthr4sSu8
         edtCXUOOT48jlBbyRFQ2SO3H4CYA+sgstSNr20oDYmJwI17Kp5mFKFF1geTdmG/+Nyxi
         NjPmKlcxE4w+422UPAQq44897wldkVYO2ygTT4fsgAAynFbd4snyg1L1eajzot/OewZu
         e/YTWsD3tjB1HVRV9EflQKfRNQLhSqaDRpwpVwKMVqxZ+PAYCok4NUlx78ZYsJZdZTWy
         JseqUIFfj/hsCyCJW066V0sA21V3KBpCNnBhkoxe8F+Sp+TYjBrlCFRh553LDc/r/bAT
         2UaA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=H0eZIb3dx86MseSJBS54PQAJPp88oPjLSYVP7aVWt7s=;
        b=oSLjR2YhoB2JEcxKc7LvjSi+X2gw9sgvaUPR2bpS7/HLpSytlHYZ8O9g16q+c5WA9y
         N7/nx6sWtcZcUzU1un6iVfTBupPJRT0cGvlLJ2Jjs9GmH4vvKEeX+4k/qdfLlQKL7zRd
         yLUQlKptUuSkqanwOtDDdmOwV6e95iXuEqchDud47Pi2mAFis2zX3+fB7zzNiaD/LTwz
         so4meu9+JOewqPrtShcaL1fP/QxFQE1qHFIYvGrYPYY49qzbyvdoEV43iktH6wfkP3LA
         QPdSk9lpco7c13FjE5+VoOx/+rThwfiwW/JR4b/HPSQofNScAuYIWfB/8rW9u1AVoIn7
         MRpg==
X-Gm-Message-State: AOAM532mFfYr3+mz9vIc32O/2izIBUGavhwP2nnuFDUoScWwDCPHERjd
        x+/Qg5bOIBqAGyE9URKPPbA=
X-Google-Smtp-Source: ABdhPJwsl5zxKV57D6qsRWF959I6M4UWYtY1RhrPKMw1eCEpy5/mKSGwzfdZIGYISsD3Hnvg6bccGw==
X-Received: by 2002:a62:7610:: with SMTP id r16mr23328944pfc.70.1592234852837;
        Mon, 15 Jun 2020 08:27:32 -0700 (PDT)
Received: from localhost ([216.24.184.172])
        by smtp.gmail.com with ESMTPSA id j123sm8454252pfd.160.2020.06.15.08.27.31
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 15 Jun 2020 08:27:32 -0700 (PDT)
Date:   Mon, 15 Jun 2020 23:27:27 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
Subject: Re: drivers/reset/reset-intel-gw.c:18:9: warning: 'REG_OFFSET' macro
 redefined
Message-ID: <20200615152727.GA11811@nuc8i5>
References: <202006152207.BGQiLOS0%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006152207.BGQiLOS0%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 15, 2020 at 10:33:12PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b3a9e3b9622ae10064826dccb4f7a52bd88c7407
> commit: e44ab4e14d6f4c448ae555132090c1a116b19e5c regmap: Simplify implementation of the regmap_read_poll_timeout() macro
> date:   8 weeks ago
> config: arm-randconfig-r022-20200615 (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 3d8149c2a1228609fd7d7c91a04681304a2f0ca9)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install arm cross compiling tool for clang build
>         # apt-get install binutils-arm-linux-gnueabi
>         git checkout e44ab4e14d6f4c448ae555132090c1a116b19e5c
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
Hi

I sent a patch to fix it, and now the patch is currently under review.
https://lkml.org/lkml/2020/6/4/606

BR,
Dejin

> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> drivers/reset/reset-intel-gw.c:18:9: warning: 'REG_OFFSET' macro redefined [-Wmacro-redefined]
> #define REG_OFFSET      GENMASK(31, 16)
> ^
> arch/arm/mach-ixp4xx/include/mach/platform.h:25:9: note: previous definition is here
> #define REG_OFFSET      3
> ^
> 1 warning generated.
> 
> vim +/REG_OFFSET +18 drivers/reset/reset-intel-gw.c
> 
> c9aef213e38cde Dilip Kota 2020-01-03  17  
> c9aef213e38cde Dilip Kota 2020-01-03 @18  #define REG_OFFSET	GENMASK(31, 16)
> c9aef213e38cde Dilip Kota 2020-01-03  19  #define BIT_OFFSET	GENMASK(15, 8)
> c9aef213e38cde Dilip Kota 2020-01-03  20  #define STAT_BIT_OFFSET	GENMASK(7, 0)
> c9aef213e38cde Dilip Kota 2020-01-03  21  
> 
> :::::: The code at line 18 was first introduced by commit
> :::::: c9aef213e38cde27d4689a5cbe25a7c1b1db9fad reset: intel: Add system reset controller driver
> 
> :::::: TO: Dilip Kota <eswara.kota@linux.intel.com>
> :::::: CC: Philipp Zabel <p.zabel@pengutronix.de>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


