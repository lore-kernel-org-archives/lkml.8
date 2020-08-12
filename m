Return-Path: <SRS0=ZArZ=BW=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9200EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 03:10:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6CE0A20658
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Aug 2020 03:10:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="UKJ9zKl7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726506AbgHLDKZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 23:10:25 -0400
Received: from us-smtp-1.mimecast.com ([205.139.110.61]:41362 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726255AbgHLDKY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 23:10:24 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597201822;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nDl358hadDvWBm+9rO2ZxJIYW/JXgdgwf/ILlk9uMb8=;
        b=UKJ9zKl7VV45WKAbw0dPCl0S1U2BSQq0CI0rnY9KzyEfFnxU/NCTnu0fb9Jg4eV1+jfrzH
        kU2Vwo4qivUf5MWHWc1ksC1dbu9k92dVxkvuSs6lt+EdJYv+WA5fAytb5zhXaMjhKIB90C
        67w8LvE7PGpX6L6OjMeDXv+t/xEvOjY=
Received: from mail-pl1-f200.google.com (mail-pl1-f200.google.com
 [209.85.214.200]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-252-TCxFJFaePnqc3NeVaBmgQw-1; Tue, 11 Aug 2020 23:10:08 -0400
X-MC-Unique: TCxFJFaePnqc3NeVaBmgQw-1
Received: by mail-pl1-f200.google.com with SMTP id s2so712694plr.22
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 20:10:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=nDl358hadDvWBm+9rO2ZxJIYW/JXgdgwf/ILlk9uMb8=;
        b=r6fayqPEg2I26eI9ZfKjHrNeJF6I8eLh2C4ixwfwzlRZObojZY/qYXBQ4Sg29pjZ+E
         3l9DL8IMIDugCLUW3VGIo+NgiJhAsdAkS79im3u162Sp0hxLTluLEtqAS+8N9KpKrShx
         S1eHXmK2dBmN1vSlu96ted/zN6o9La+cExj/eDOuzXJYvlO/NSFFbXLaLnz7bNswKgF7
         PTzfgpQykPxFXjIaB+S2K310ypmqXtlx99ovpA3iPDNzc9nKXOCUqi5BstpNU3M4UGBO
         4UWAA8clOFTqkkC8/qCEK+vkW0mWMurcGMis3YEMQZ3H0dDz0ByTMTeQgPWhVs1pyV4H
         +v8A==
X-Gm-Message-State: AOAM533SlqFXPT0+vFyKFmKq1m6x1EXJgfD9W6bQmyI3sx8/R/WKnJWE
        KbfJ/FW6eeXF4FzKvwz4qBo9SiK5c8WX3hCmxYMYMinNP9kJ/L63uqD7jNN15PMcB/SmnG74Fqd
        mFZn22pRV1vZg1XQitpZzuA+v
X-Received: by 2002:a65:68c2:: with SMTP id k2mr3411649pgt.260.1597201807334;
        Tue, 11 Aug 2020 20:10:07 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwDKfoEY2rO0GyZwHTHm7rG+zUTuGzIt4KzhxdvZ+puX4OdVJFlfEWZFU7aNaIKO+/+WZi33w==
X-Received: by 2002:a65:68c2:: with SMTP id k2mr3411640pgt.260.1597201807077;
        Tue, 11 Aug 2020 20:10:07 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id y196sm484736pfc.202.2020.08.11.20.10.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 20:10:06 -0700 (PDT)
Date:   Wed, 12 Aug 2020 11:09:56 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Gao Xiang <hsiangkao@aol.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: arch/sparc/include/asm/cmpxchg_64.h:161:55: sparse: sparse: cast
 truncates bits from constant value (ffffffffe0f510cc becomes cc)
Message-ID: <20200812030956.GA17005@xiangao.remote.csb>
References: <202008120933.YrVhHyoA%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202008120933.YrVhHyoA%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Wed, Aug 12, 2020 at 09:49:38AM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   fb893de323e2d39f7a1f6df425703a2edbdf56ea
> commit: 47e4937a4a7ca4184fd282791dfee76c6799966a erofs: move erofs out of staging
> date:   12 months ago
> config: sparc64-randconfig-s032-20200812 (attached as .config)
> compiler: sparc64-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.2-168-g9554805c-dirty
>         git checkout 47e4937a4a7ca4184fd282791dfee76c6799966a
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=sparc64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
>    fs/erofs/utils.c: note: in included file (through arch/sparc/include/asm/cmpxchg.h, arch/sparc/include/asm/atomic_64.h, arch/sparc/include/asm/atomic.h, ...):
> >> arch/sparc/include/asm/cmpxchg_64.h:161:55: sparse: sparse: cast truncates bits from constant value (ffffffffe0f510cc becomes cc)
> --
>    fs/erofs/zdata.c: note: in included file (through arch/sparc/include/asm/cmpxchg.h, arch/sparc/include/asm/atomic_64.h, arch/sparc/include/asm/atomic.h, ...):
> >> arch/sparc/include/asm/cmpxchg_64.h:161:55: sparse: sparse: cast truncates bits from constant value (ffffffffe0f510cc becomes cc)
>    arch/sparc/include/asm/cmpxchg_64.h:161:50: sparse: sparse: cast truncates bits from constant value (5f0ecafe becomes fe)
>    arch/sparc/include/asm/cmpxchg_64.h:161:50: sparse: sparse: cast truncates bits from constant value (5f0ecafe becomes fe)
>    arch/sparc/include/asm/cmpxchg_64.h:161:55: sparse: sparse: cast truncates bits from constant value (5f0edead becomes ad)
> 
> vim +161 arch/sparc/include/asm/cmpxchg_64.h
> 
> d550bbd40c0e10 David Howells 2012-03-28  155  
> d550bbd40c0e10 David Howells 2012-03-28  156  static inline unsigned long
> d550bbd40c0e10 David Howells 2012-03-28  157  __cmpxchg(volatile void *ptr, unsigned long old, unsigned long new, int size)
> d550bbd40c0e10 David Howells 2012-03-28  158  {
> d550bbd40c0e10 David Howells 2012-03-28  159  	switch (size) {
> a12ee2349312d7 Babu Moger    2017-05-24  160  		case 1:
> a12ee2349312d7 Babu Moger    2017-05-24 @161  			return __cmpxchg_u8(ptr, old, new);
> d550bbd40c0e10 David Howells 2012-03-28  162  		case 4:
> d550bbd40c0e10 David Howells 2012-03-28  163  			return __cmpxchg_u32(ptr, old, new);
> d550bbd40c0e10 David Howells 2012-03-28  164  		case 8:
> d550bbd40c0e10 David Howells 2012-03-28  165  			return __cmpxchg_u64(ptr, old, new);
> d550bbd40c0e10 David Howells 2012-03-28  166  	}
> d550bbd40c0e10 David Howells 2012-03-28  167  	__cmpxchg_called_with_bad_pointer();
> d550bbd40c0e10 David Howells 2012-03-28  168  	return old;
> d550bbd40c0e10 David Howells 2012-03-28  169  }
> d550bbd40c0e10 David Howells 2012-03-28  170  

Again, I have no idea how to deal with that in my current
gatekeeping code.

I got these reports, but I cannot help to resolve that.
Even I don't know if that's another sparse issue (since I
only got such reports on sparc and alpha arch, but no x86
or arm64.)

https://lore.kernel.org/r/202007251532.y5A10ZoO%25lkp@intel.com
https://lore.kernel.org/r/202007272132.1AgbBO3U%25lkp@intel.com
https://lore.kernel.org/r/202008100408.Wc6WGrac%25lkp@intel.com
https://lore.kernel.org/r/202008120933.YrVhHyoA%25lkp@intel.com

If no one can help that, could you please silence such reports.
It really makes me confusing.

Thanks,
Gao Xiang

> 
> :::::: The code at line 161 was first introduced by commit
> :::::: a12ee2349312d7112b9b7c6ac2e70c5ec2ca334e arch/sparc: Introduce cmpxchg_u8 SPARC
> 
> :::::: TO: Babu Moger <babu.moger@oracle.com>
> :::::: CC: David S. Miller <davem@davemloft.net>
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


