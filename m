Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.5 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D053C433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 21:19:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 34C9E20DD4
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 21:19:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="1v2af67P"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726453AbgH3VTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 30 Aug 2020 17:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726150AbgH3VTr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Aug 2020 17:19:47 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F35AC061573
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 14:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=qxuGBO7OHoFOqMd5t3qfneyvkZfiMHtZf+BcpIMWA1c=; b=1v2af67PQiAzYmGMzuzpuzM3MD
        mo879MTEtJWgzTdjZMLkv5ZgqXAVjnKEdYq+rum8BJdNmasImy+T76wB7QQCmuY4KB9o3BY/4YuiF
        /90dRhblefAHjNPkUvDEvBpG37eJT0+nw1Bv8O1m0Lfc0UCdP+cfRQZbgrqen+PZKV6KbRz7guaUQ
        hDuVvCmd0l4s4/7zMUyVTqFn/1H1QiRJGqDegYzb1xN9ZofoBxzwpjYOgQXS1pf/naWGFG87LuGOT
        q7KaC4iKcfbZ2Ykm2lzD6qh5tTVRJf0JvMdNtybeYCrOsKzIAwY6pDPeTFC6iFiCgPlphlXzAEumV
        +ulgwAVA==;
Received: from [2601:1c0:6280:3f0:897c:6038:c71d:ecac]
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCUjl-0007UQ-3z; Sun, 30 Aug 2020 21:19:41 +0000
Subject: Re: powerpc64-linux-ld: mm/page_alloc.o:undefined reference to
 `node_reclaim_distance'
To:     kernel test robot <lkp@intel.com>,
        Matt Fleming <matt@codeblueprint.co.uk>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>
References: <202008310314.JpP8vEJ9%lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <47426554-9d42-602d-d3fe-b6b38a48b8c6@infradead.org>
Date:   Sun, 30 Aug 2020 14:19:34 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <202008310314.JpP8vEJ9%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/30/20 12:32 PM, kernel test robot wrote:
> Hi Matt,
> 
> FYI, the error/warning still remains.
> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   1127b219ce9481c84edad9711626d856127d5e51
> commit: a55c7454a8c887b226a01d7eed088ccb5374d81e sched/topology: Improve load balancing on AMD EPYC systems
> date:   12 months ago
> config: powerpc64-randconfig-c003-20200831 (attached as .config)
> compiler: powerpc64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout a55c7454a8c887b226a01d7eed088ccb5374d81e
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=powerpc64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>):
> 
>    powerpc64-linux-ld: warning: orphan section `.gnu.hash' from `linker stubs' being placed in section `.gnu.hash'
>    powerpc64-linux-ld: arch/powerpc/perf/perf_regs.o: in function `perf_reg_value':
>    arch/powerpc/perf/perf_regs.c:80: undefined reference to `.is_sier_available'
>>> powerpc64-linux-ld: mm/page_alloc.o:(.toc+0x0): undefined reference to `node_reclaim_distance'
> 
> ---

Build error for undefined "node_reclaim_distance" has been reported on both
arch/sh/ and arch/powerpc64/.

Matt's patch here
https://lore.kernel.org/lkml/20191223164220.GA14394@codeblueprint.co.uk/

fixes the build error in both cases (both $ARCH-es), although it needs to be
resent as a patch instead of "can someone test this?".

Matt?

Acked-by: Randy Dunlap <rdunlap@infradead.org> # build-tested

thanks.
-- 
~Randy
