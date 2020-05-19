Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5414DC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:25:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F5162072C
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 21:25:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kH0wmO1b"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726944AbgESVZp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 17:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37546 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725998AbgESVZo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 17:25:44 -0400
Received: from mail-ot1-x341.google.com (mail-ot1-x341.google.com [IPv6:2607:f8b0:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9651AC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 14:25:44 -0700 (PDT)
Received: by mail-ot1-x341.google.com with SMTP id v17so826567ote.0
        for <linux-kernel@vger.kernel.org>; Tue, 19 May 2020 14:25:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=FWlhpdjVXDxOYBQi8YbLzRL++t+OQcthpCLKDRscJz8=;
        b=kH0wmO1bycL1iv4n++MA16V17RfBjSH+apnFCQ97AlOUeR+Sa3GfXmBLARpo6Gv08X
         /LuGMeXjCH1NaZdPlc5QYSlHif2nHRJ9F9SsgxdAOuMk08UaX0oCLDj3Ppk7xkZ2M+uX
         v8SOJte0wDnjwaaCmQ2pVUENmd3a20VOJn3fpBcoq/+SGoYNsr5+2UVK14lq+z2jJq6V
         FFBYkcxdp7c18468UbJu5Qahzujf9FoNhzsXJgbqQKWflMySzYgnnZLBcRqpgCANriP6
         QhX22vaeYapbZFhIIK5OdRoGFe8XXfScaL9+oVIl0dOGCpLn33iORRYvU8OPTjsoSPEd
         D1Qw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=FWlhpdjVXDxOYBQi8YbLzRL++t+OQcthpCLKDRscJz8=;
        b=iKRPzrUbQoLKDuGZX1ou0lpXq1JuJiH/K0SUdAeCoFug5AoXj2vYCFm+Hd33y0nQnU
         Rl8E37+ODQdk8wmJHvLIrU2Z/R3YnTN168q1VSeRunnmcmidIwWeq03Ca2GmCVp34pRh
         /Bdnq6yoHmr8GWoUfBvoDgY26qZFKfjPqcKxqYBVBTNKdFwfBZON2jT2c/jiV0AXj3MA
         F8+9+9R3S7WT/bMyMe5M7NAiPrP9kO87rMHEonAmk+psymEaKM6INBQ9/4QV8mP6IdKR
         IaybPJdX/JowdwAbwe+cGM8AzZQqNzNB+ZMejjQMHsy8h2FEP1G9fDxBh2qAg8Kq79Mt
         3Ulw==
X-Gm-Message-State: AOAM53349xL3TBtwFxrP9VVr47/7UwSCnuJ9q5fWAQZRe9FC8eb7zSfs
        PhhGORifqYIJAXEYVz0YWXE=
X-Google-Smtp-Source: ABdhPJxLaflqXPcLEu1keomDRIV6n30/y1SrU6TaOM6YfBxPZk1VAOZsygtXdvYoboKtnNiuQZck6g==
X-Received: by 2002:a9d:47:: with SMTP id 65mr790008ota.349.1589923543750;
        Tue, 19 May 2020 14:25:43 -0700 (PDT)
Received: from ubuntu-s3-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id d15sm216747otk.41.2020.05.19.14.25.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 19 May 2020 14:25:43 -0700 (PDT)
Date:   Tue, 19 May 2020 14:25:41 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Borislav Petkov <bp@alien8.de>
Cc:     kbuild test robot <lkp@intel.com>, Christoph Hellwig <hch@lst.de>,
        kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org, x86@kernel.org,
        Benjamin Thiel <b.thiel@posteo.de>
Subject: Re: [tip:x86/mm 1/23] arch/x86/mm/init.c:75:6: warning: no previous
 prototype for function 'x86_has_pat_wp'
Message-ID: <20200519212541.GA3580016@ubuntu-s3-xlarge-x86>
References: <202005200123.gFjGzJEH%lkp@intel.com>
 <20200519205505.GD444@zn.tnic>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20200519205505.GD444@zn.tnic>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 19, 2020 at 10:55:05PM +0200, Borislav Petkov wrote:
> On Wed, May 20, 2020 at 01:51:25AM +0800, kbuild test robot wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/tip/tip.git x86/mm
> > head:   bd1de2a7aace4d1d312fb1be264b8fafdb706208
> > commit: 1f6f655e01adebf5bd5e6c3da2e843c104ded051 [1/23] x86/mm: Add a x86_has_pat_wp() helper
> > config: x86_64-randconfig-r012-20200519 (attached as .config)
> > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project 135b877874fae96b4372c8a3fbfaa8ff44ff86e3)
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         # install x86_64 cross compiling tool for clang build
> >         # apt-get install binutils-x86-64-linux-gnu
> >         git checkout 1f6f655e01adebf5bd5e6c3da2e843c104ded051
> >         # save the attached .config to linux build tree
> >         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64 
> > 
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kbuild test robot <lkp@intel.com>
> > 
> > All warnings (new ones prefixed by >>, old ones prefixed by <<):
> > 
> > >> arch/x86/mm/init.c:75:6: warning: no previous prototype for function 'x86_has_pat_wp' [-Wmissing-prototypes]
> > bool x86_has_pat_wp(void)
> > ^
> 
> Triggers with gcc too:
> 
> make W=1 arch/x86/mm/init.o
> 
> ...
> 
> arch/x86/mm/init.c:81:6: warning: no previous prototype for ‘x86_has_pat_wp’ [-Wmissing-prototypes]
>    81 | bool x86_has_pat_wp(void)
>       |      ^~~~~~~~~~~~~~
> 
> 
> -Wmissing-prototypes is default off, though, dunno why clang 11 has it
> on.

It doesn't: https://godbolt.org/z/rU5_5H

I assume this is caused by some sort of internal change to the 0day
infrastructure (testing W=1?)

I cannot see this without adding W=1 to make at the listed commit with
the provided config.

Cheers,
Nathan

> Anyway, something for Benni to fix. CCed and leaving the rest for him as
> reference.
> 
> > arch/x86/mm/init.c:75:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> > bool x86_has_pat_wp(void)
> > ^
> > static
> > arch/x86/mm/init.c:866:13: warning: no previous prototype for function 'mem_encrypt_free_decrypted_mem' [-Wmissing-prototypes]
> > void __weak mem_encrypt_free_decrypted_mem(void) { }
> > ^
> > arch/x86/mm/init.c:866:1: note: declare 'static' if the function is not intended to be used outside of this translation unit
> > void __weak mem_encrypt_free_decrypted_mem(void) { }
> > ^
> > static
> > 2 warnings generated.
> > 
> > vim +/x86_has_pat_wp +75 arch/x86/mm/init.c
> > 
> >     73	
> >     74	/* Check that the write-protect PAT entry is set for write-protect */
> >   > 75	bool x86_has_pat_wp(void)
> >     76	{
> >     77		return __pte2cachemode_tbl[_PAGE_CACHE_MODE_WP] == _PAGE_CACHE_MODE_WP;
> >     78	}
> >     79	
> > 
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
> 
> 
> -- 
> Regards/Gruss,
>     Boris.
> 
> https://people.kernel.org/tglx/notes-about-netiquette
> 
