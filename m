Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2CE1EC433E0
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:35:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 06E6D2072E
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 15:35:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="MO+8OXTG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729600AbgFDPfb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 11:35:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729402AbgFDPfb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 11:35:31 -0400
Received: from mail-pg1-x541.google.com (mail-pg1-x541.google.com [IPv6:2607:f8b0:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60665C08C5C0
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 08:35:31 -0700 (PDT)
Received: by mail-pg1-x541.google.com with SMTP id u5so3618191pgn.5
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 08:35:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=Wax4PTMKC91KYPdKcHl2puiFv+eU6eLijgiQ1wOXRG4=;
        b=MO+8OXTGBmz97fF3PSAUhzNy/sUteX25T2uHr/xf1tHYvpVUxG1XScpC05FjrpAK4s
         zpKeD88G8PrmeBKrg918QFJTO/D2/5OWiEiOdU2xUPdPNigNXVLxMaY0cxTABLqPzHmB
         A6xODYnbuSBQfyTq668XHZWQDIS1meYvH6f47xEt6iTKFIj3nT03WfcqwrHXB8Ia8oYk
         JwpqYWJffVZ8EiOIlAuBZEljfybk2eJXZVa8oElFQ7sMgIMnbEYGOM20gXzna0n5JXyB
         R9zpfR9B+p/GfOruu+bdkIQleOHG1lTkQaLGIXgJXmNZrdXMMxt3Wh/hDcTwiqoDgj7e
         M/XA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Wax4PTMKC91KYPdKcHl2puiFv+eU6eLijgiQ1wOXRG4=;
        b=iKNl6Qr8nWr9wpJ/hCpWGT/Mn3VPTw+sBIfGiCNdXuRtqiD2TJUJPlzs2PhmC1Dd5u
         Tu6z2feQAIJt2CwSjGw5vX5Uk2NJBxmKxK2VQVaMDGGxY0234LGx5+JZIuQ909BjMpgn
         zlnwYlVT/6zsMHssRYitu3LYcx+LPEYYpddLjgtaoihuwjnEfnwPXCUBqzFZVPCXHfSU
         bVtld5gVoMDkPzGgUfBdJWqx54pLDHB0oW72SYQoLbj70zdhUJaBxv6rKrmiYcAPcCHa
         890TwH4TayzpaKisJ6USQHteMd0lzMdU+UcdJl9aYRvHHeIyA4B3deb3nrMTND4mwZsH
         E+Ag==
X-Gm-Message-State: AOAM532E/qq8LtM4h062VfwaFcSGIPB1UXn6HfXkwKrrjlJwGEu14IjU
        EbMtMq+rlALcm7khYWVLPuM=
X-Google-Smtp-Source: ABdhPJw2DdFyJawgCi1P2eY4+hgKaq55kDmEbpBocB7gjS8MfwwT/nXsKXMA9165aRyW/aow1QtOJQ==
X-Received: by 2002:aa7:8506:: with SMTP id v6mr4883505pfn.303.1591284930918;
        Thu, 04 Jun 2020 08:35:30 -0700 (PDT)
Received: from localhost ([162.211.223.96])
        by smtp.gmail.com with ESMTPSA id np5sm6659239pjb.43.2020.06.04.08.35.29
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Thu, 04 Jun 2020 08:35:30 -0700 (PDT)
Date:   Thu, 4 Jun 2020 23:35:18 +0800
From:   Dejin Zheng <zhengdejin5@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: drivers/reset/reset-intel-gw.c:18: warning: "REG_OFFSET"
 redefined
Message-ID: <20200604153518.GA23034@nuc8i5>
References: <202006041903.Mwlo5QJ5%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202006041903.Mwlo5QJ5%lkp@intel.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jun 04, 2020 at 07:37:06PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   6929f71e46bdddbf1c4d67c2728648176c67c555
> commit: e44ab4e14d6f4c448ae555132090c1a116b19e5c regmap: Simplify implementation of the regmap_read_poll_timeout() macro
> date:   6 weeks ago
> config: arm-randconfig-r035-20200604 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout e44ab4e14d6f4c448ae555132090c1a116b19e5c
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
>
Hi

Thanks very much for report this issue to me, and very very sorry for
that. I submit a commit to fix it. it is in here:
https://lkml.org/lkml/2020/6/4/606

BR,
Dejin

> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> drivers/reset/reset-intel-gw.c:18: warning: "REG_OFFSET" redefined
> 18 | #define REG_OFFSET GENMASK(31, 16)
> |
> In file included from arch/arm/mach-ixp4xx/include/mach/hardware.h:30,
> from arch/arm/mach-ixp4xx/include/mach/io.h:15,
> from arch/arm/include/asm/io.h:198,
> from include/linux/io.h:13,
> from include/linux/iopoll.h:14,
> from include/linux/regmap.h:20,
> from drivers/reset/reset-intel-gw.c:12:
> arch/arm/mach-ixp4xx/include/mach/platform.h:25: note: this is the location of the previous definition
> 25 | #define REG_OFFSET 3
> |
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


