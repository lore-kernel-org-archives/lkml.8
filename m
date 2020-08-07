Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D9D5EC433E0
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:53:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AEDEC2075D
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 11:53:10 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ej2O6FAJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728455AbgHGLxJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 07:53:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49708 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726293AbgHGLxI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 07:53:08 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC85BC061574
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 04:53:07 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id c16so1753392ejx.12
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 04:53:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wTdRBKiB7nfAhpSsvP1RXs+/uy2BYq/STu2ChZq1IcQ=;
        b=Ej2O6FAJ6dFQS5I7wKiWLpGGq2zwEj/WsP9k7jR+1JY/QMwfRlXH2ovbIc8v1UUNPU
         2jZjdWaH7FnCvQmufEQ/A6ouiMl5Iue5iPG/eLKrYVi9Qr+z3/GvasqpdY/wIS7HJAdM
         pNdUKZsDssb0r7rDJff6ixiA84k7qsw3MIs7BZ5oqa8x3CeuJxiiK37z/5N9HxDucJ6k
         TM4nRS2oFBR97a4twlHb5DLA7wndiAflqsoC+pK06eRbxRdwVKEwdjHc5VgEXtdC4rIo
         jypanLwlHEgHq0xXgPbTduw/f2D/vr7ohFqORLzsKt7YZZTRJVsKJKMuk07nBcvPedIq
         x53g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wTdRBKiB7nfAhpSsvP1RXs+/uy2BYq/STu2ChZq1IcQ=;
        b=NGmD+qBPJYPaFYKUNMDC5y92mQ3VI+/GwAQjdB0dUOmxmO5GC4dpFwsha8qbmyDS2Y
         QXAfBNlpFObnckvslwfIdab2e4Hoehhk3UC90vWXYbUGJssX0MosqqCXx7IEudqxsb21
         82JcNNe4ISB1lb/N/zopsK3JnZEVsIfwDAnvFcl6GfRkCIEm0nVyrN05IUsfOxxIMNln
         8O39SCYs5JjIAcYxZ1DU8uOAGR5zBTdhLgFLUTc7IcsfSU4eJxiuufw1Ukuld3pDvn4o
         Gz9nTJ75jUAivQuSCh4aHEB9XTHpc+EcOYMpthkyQeDafa91WrommUe9PiQ9mvslmHpp
         Zgqg==
X-Gm-Message-State: AOAM530UMItBBnri4apvkWP7p5Th8vOl91y8raskR8FEfAqnwjulbh7l
        sL9rljPo0SIHWhnq3fIv6bk9hOiG
X-Google-Smtp-Source: ABdhPJzO2cUb0CWDxCQKiDsxIwJLZzUh6fYbXnyg8USOYTwwbIb9QunWGWu7Nez0mEs81Y4EsesqNg==
X-Received: by 2002:a17:906:841:: with SMTP id f1mr9135783ejd.158.1596801186704;
        Fri, 07 Aug 2020 04:53:06 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:a7fb:e200:5975:4576:7691:7d5b])
        by smtp.gmail.com with ESMTPSA id e8sm5212824edy.68.2020.08.07.04.53.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 07 Aug 2020 04:53:05 -0700 (PDT)
Date:   Fri, 7 Aug 2020 13:53:04 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
Subject: Re: drivers/video/fbdev/pxafb.c:916:24: sparse: sparse: incorrect
 type in assignment (different address spaces)
Message-ID: <20200807115304.npzxzzcuxbn7td2h@ltop.local>
References: <202008071833.kUoyxyIe%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008071833.kUoyxyIe%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 07, 2020 at 06:37:36PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   86cfccb66937dd6cbf26ed619958b9e587e6a115
> commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
> date:   7 weeks ago
> config: arm-randconfig-s031-20200807 (attached as .config)
> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.2-118-ge1578773-dirty
>         git checkout 670d0a4b10704667765f7d18f7592993d02783aa
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arm 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
> >> drivers/video/fbdev/pxafb.c:916:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *video_mem @@     got void * @@
> >> drivers/video/fbdev/pxafb.c:916:24: sparse:     expected void [noderef] __iomem *video_mem

Hi,

since late June I receive several mails per day about this commit but
they are all false-positive.
Commit 670d0a4b10704667765f7d18f7592993d02783aa can't introduce *new*
warnings, it only change how address-spaces are displayed in sparse's
warnings (for example, the address space for __user pointers were
displayd as '<asn:1>', now it's nicely displayed as '__user', same
for '__iomem', '__percpu' and '__rcu').

Isn't it possible to ignore some commits like this one?
Or, even better, should it be possible to only report when a new
warning is effectively added, not when its content is simply modified?
If not it would be nice to be able to see the difference in a diff-like
format.

Best regards,
-- Luc
