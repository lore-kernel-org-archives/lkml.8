Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 82BDAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:55:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4337E204EC
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 20:55:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=alien8.de header.i=@alien8.de header.b="Y7dwlmoe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726651AbgESUzP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 16:55:15 -0400
Received: from mail.skyhub.de ([5.9.137.197]:54352 "EHLO mail.skyhub.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725998AbgESUzP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 16:55:15 -0400
Received: from zn.tnic (p200300ec2f0b87001461a870af27ee92.dip0.t-ipconnect.de [IPv6:2003:ec:2f0b:8700:1461:a870:af27:ee92])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.skyhub.de (SuperMail on ZX Spectrum 128k) with ESMTPSA id 4E5F51EC0116;
        Tue, 19 May 2020 22:55:12 +0200 (CEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=alien8.de; s=dkim;
        t=1589921712;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=X2V7bouPUzsQ8Xr8SCd7667H/T1ORcUDQXiU9kyEDw0=;
        b=Y7dwlmoeYDqUqS9pSvmhEmAWP/Of7Yt8jInJi2EqQmfr5PxcJlUI4Ts17ngeoN14YQMaIY
        gmp00L8xwPbsaDLE7GQdRH+aJOzJhlIcD1gxyLL+V9+mQKk2buHeEKDNf54tLKz2jlW01f
        WaRLYFwx5eC0bFasjnMhO1HZc4YcONk=
Date:   Tue, 19 May 2020 22:55:05 +0200
From:   Borislav Petkov <bp@alien8.de>
To:     kbuild test robot <lkp@intel.com>
Cc:     Christoph Hellwig <hch@lst.de>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        x86@kernel.org, Benjamin Thiel <b.thiel@posteo.de>
Subject: Re: [tip:x86/mm 1/23] arch/x86/mm/init.c:75:6: warning: no previous
 prototype for function 'x86_has_pat_wp'
Message-ID: <20200519205505.GD444@zn.tnic>
References: <202005200123.gFjGzJEH%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <202005200123.gFjGzJEH%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 20, 2020 at 01:51:25AM +0800, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
> head:   bd1de2a7aace4d1d312fb1be264b8fafdb706208
> commit: 1f6f655e01adebf5bd5e6c3da2e843c104ded051 [1/23] x86/mm: Add a x86_has_pat_wp() helper
> config: x86_64-randconfig-r012-20200519 (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 135b877874fae96b4372c8a3fbfaa8ff44ff86e3)
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # install x86_64 cross compiling tool for clang build
>         # apt-get install binutils-x86-64-linux-gnu
>         git checkout 1f6f655e01adebf5bd5e6c3da2e843c104ded051
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kbuild test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
> >> arch/x86/mm/init.c:75:6: warning: no previous prototype for function 'x86_has_pat_wp' [-Wmissing-prototypes]
> bool x86_has_pat_wp(void)
> ^

Triggers with gcc too:

make W=1 arch/x86/mm/init.o

...

arch/x86/mm/init.c:81:6: warning: no previous prototype for ‘x86_has_pat_wp’ [-Wmissing-prototypes]
   81 | bool x86_has_pat_wp(void)
      |      ^~~~~~~~~~~~~~


-Wmissing-prototypes is default off, though, dunno why clang 11 has it
on.

Anyway, something for Benni to fix. CCed and leaving the rest for him as
reference.

> arch/x86/mm/init.c:75:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> bool x86_has_pat_wp(void)
> ^
> static
> arch/x86/mm/init.c:866:13: warning: no previous prototype for function 'mem_encrypt_free_decrypted_mem' [-Wmissing-prototypes]
> void __weak mem_encrypt_free_decrypted_mem(void) { }
> ^
> arch/x86/mm/init.c:866:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> void __weak mem_encrypt_free_decrypted_mem(void) { }
> ^
> static
> 2 warnings generated.
> 
> vim +/x86_has_pat_wp +75 arch/x86/mm/init.c
> 
>     73	
>     74	/* Check that the write-protect PAT entry is set for write-protect */
>   > 75	bool x86_has_pat_wp(void)
>     76	{
>     77		return __pte2cachemode_tbl[_PAGE_CACHE_MODE_WP] == _PAGE_CACHE_MODE_WP;
>     78	}
>     79	
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org



-- 
Regards/Gruss,
    Boris.

https://people.kernel.org/tglx/notes-about-netiquette
