Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CF2B5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 04:30:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A2D27206DA
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 04:30:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597120206;
	bh=HVa5a8fSarE3FjEzPI/tiTxOe2uPd2Fd/PzzU5E8/3M=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=U06u5RPASCQp0n6RUxKeumcOrPhFyCenCDTYUgSINFYCU1f8XaAECHozbXjtjzFXY
	 fiDQ4oPU/ujdsnYRzMngUlppSXXBEtO4XEDDz1kKuF8NJ+ZYbueyxSvA3vhxczlh93
	 mKQWeA5bKWfAZTFRjKeVa8iMHjIRYGNrQOhRmY4g=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726114AbgHKE16 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 00:27:58 -0400
Received: from mail.kernel.org ([198.145.29.99]:45886 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725837AbgHKE15 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 00:27:57 -0400
Received: from localhost.localdomain (c-73-231-172-41.hsd1.ca.comcast.net [73.231.172.41])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B09CE206DA;
        Tue, 11 Aug 2020 04:27:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1597120077;
        bh=HVa5a8fSarE3FjEzPI/tiTxOe2uPd2Fd/PzzU5E8/3M=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=gIfikik50rH/Y4HMFk3aIcoToJ/0tTiPNEUlv8NUE+AEiM79Y9PA2333Y6aefP6UU
         /dgCsVT51be2bS+OzVuRzzkGYXTeKuj5Ddu52sT6TWjCAsB05IW8+lUGz/GNybsJpE
         7iX8Ft0Ic/34l9pmo4/4Yv8nFJbx7CCImclFWS0k=
Date:   Mon, 10 Aug 2020 21:27:56 -0700
From:   Andrew Morton <akpm@linux-foundation.org>
To:     kernel test robot <lkp@intel.com>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Linux Memory Management List <linux-mm@kvack.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        Peter Rosin <peda@axentia.se>
Subject: Re: include/linux/bits.h:25:21: error: first argument to
 '__builtin_choose_expr' not a constant
Message-Id: <20200810212756.04c006476aa9c663edb01f32@linux-foundation.org>
In-Reply-To: <202008080833.zZnw48Gr%lkp@intel.com>
References: <202008080833.zZnw48Gr%lkp@intel.com>
X-Mailer: Sylpheed 3.5.1 (GTK+ 2.24.31; x86_64-pc-linux-gnu)
Mime-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 8 Aug 2020 08:03:38 +0800 kernel test robot <lkp@intel.com> wrote:

> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   30185b69a2d533c4ba6ca926b8390ce7de495e29
> commit: 295bcca84916cb5079140a89fccb472bb8d1f6e2 linux/bits.h: add compile time sanity check of GENMASK inputs
> date:   4 months ago
> config: s390-randconfig-r001-20200808 (attached as .config)
> compiler: s390-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout 295bcca84916cb5079140a89fccb472bb8d1f6e2
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=s390 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    drivers/mux/mmio.c: In function 'mux_mmio_probe':
>    drivers/mux/mmio.c:76:20: error: storage size of 'field' isn't known
>       76 |   struct reg_field field;
>          |                    ^~~~~
>    In file included from include/linux/bits.h:23,
>                     from include/linux/bitops.h:5,
>                     from drivers/mux/mmio.c:8:
> >> include/linux/bits.h:25:21: error: first argument to '__builtin_choose_expr' not a constant

I assume the first error is the cause of the second?

struct reg_field is only defined if CONFIG_REGMAP, and that is unset in
this .config.  Perhaps drivers/mux/mmio.c should depend on
CONFIG_REGMAP?  (cc Peter).


