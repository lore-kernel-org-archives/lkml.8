Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96D94C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 02:42:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7378F20663
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 02:42:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="pdVm1jsr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726920AbgGJClD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 22:41:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726496AbgGJClD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 22:41:03 -0400
Received: from mail-oi1-x244.google.com (mail-oi1-x244.google.com [IPv6:2607:f8b0:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B201DC08C5CE
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 19:41:02 -0700 (PDT)
Received: by mail-oi1-x244.google.com with SMTP id x83so3597313oif.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 19:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=ij3YvsL4Rul6XPZefX+VkrzglhCxXEgOUPXujCuZUiA=;
        b=pdVm1jsr1Wzvo9+OSFETIIEWdhZJc2bP6Z+2NDXDHugV7Zm80kcIS3D3amqDCaR380
         tSIrQLwPbpjmQVU+u3lFylaJnP4KcBrNOgPpfT5bWHiXCKtmCK/iTjyvLo43P4tOoVu2
         EfcqYuQUy+gc9pHEXJiJ/8ieiF3MCACq8uvjj0lVjx7Gr/CIeXW67iBOR4hTZ4JTs4VA
         b+zkxwiBybRxUTaPzCfZIxZ55gn5OG2nRWcPCR0qyEaaNiU1Hd+hhpxsAXvRRxyKFglS
         mZ03N7b8agl2USYcMSq2ZFlmvJnAhrE+nc5DlrmAYdXLJLjc2H7YBQ/VOwL/X/nOkdsZ
         BNOw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ij3YvsL4Rul6XPZefX+VkrzglhCxXEgOUPXujCuZUiA=;
        b=rfEuGLBFp22YNPRS8tcIsmloWZfg7EfYfl9ijtvMtNZxAg0TPHmbOijtyAsw9Yf6li
         0nms/KCF7m7tgqUqmUnr1gVXV9shAQZrfKj+RCswBIDLt3hsEQ7G67zJ9Pdpp7xCxchn
         zUYp8PocFNohIFORz3nhyhX1Jpno9cMyraMVvpqEbd4Ts6wVj5G9kYnKbYPsyaXv2S08
         uxw8NP3aJHmJ8NMoSsiAmuLS7jKoEuzto4DVZJiLA6Xj5G6cnTiZuQFoizoWiyzeV2+K
         p11XC4SuU+C1xquxYLbyawewpCyZ/5DXkxSewnkOs9qFBPpYicDLsLqetSZcLG6Jzf7Z
         HY2Q==
X-Gm-Message-State: AOAM533V4xon5OQcNa3o+QOIohuMcnr7MtHS+W+9wugKUc/KmfgDlWhe
        KcRTlVObMQnB65m/z7aGEQU=
X-Google-Smtp-Source: ABdhPJx1eODgqJMWpwK2L5uzzHiWH5OWsC9YrWFVQ8PVq8CFDE4Pfnf2uvtWWKF0hv8KJXFD7fNwLA==
X-Received: by 2002:aca:5693:: with SMTP id k141mr2558176oib.35.1594348861915;
        Thu, 09 Jul 2020 19:41:01 -0700 (PDT)
Received: from ubuntu-n2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id j16sm842047oib.35.2020.07.09.19.41.01
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 09 Jul 2020 19:41:01 -0700 (PDT)
Date:   Thu, 9 Jul 2020 19:41:00 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Sven Van Asbroeck <thesven73@gmail.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
Subject: Re: sound/soc/codecs/zl38060.c:614:34: warning: unused variable
 'zl38_dt_ids'
Message-ID: <20200710024100.GA2055744@ubuntu-n2-xlarge-x86>
References: <202007100026.oufYkhwZ%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007100026.oufYkhwZ%lkp@intel.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 12:47:31AM +0800, kernel test robot wrote:
> Hi Sven,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   0bddd227f3dc55975e2b8dfa7fc6f959b062a2c7
> commit: 52e8a94baf9026276fcdc9ff21a50dc2ca0bc94b ASoC: Add initial ZL38060 driver
> date:   3 months ago
> config: x86_64-randconfig-r004-20200709 (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 02946de3802d3bc65bc9f2eb9b8d4969b5a7add8)
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         git checkout 52e8a94baf9026276fcdc9ff21a50dc2ca0bc94b
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>):
> 
> >> sound/soc/codecs/zl38060.c:614:34: warning: unused variable 'zl38_dt_ids' [-Wunused-const-variable]
>    static const struct of_device_id zl38_dt_ids[] = {
>                                     ^
>    1 warning generated.
> 
> vim +/zl38_dt_ids +614 sound/soc/codecs/zl38060.c
> 
>    613	
>  > 614	static const struct of_device_id zl38_dt_ids[] = {
>    615		{ .compatible = "mscc,zl38060", },
>    616		{ /* sentinel */ }
>    617	};
>    618	MODULE_DEVICE_TABLE(of, zl38_dt_ids);
>    619	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

When CONFIG_SND_SOC_ZL38060 is y, MODULE_DEVICE_TABLE expands to nothing
so zl38_dt_ids will be unused. This is a pretty common construct in the
kernel and the only way I can think of to resolve this through the code
is by adding __used annotations to all of these variables, which I think
is overkill for this.

Personally, I think this warning should be downgraded to W=2, thoughts?

Cheers,
Nathan
