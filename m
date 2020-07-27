Return-Path: <SRS0=+GcV=BG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5660C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:19:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A19F72074F
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Jul 2020 09:19:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WCiKux6o"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727034AbgG0JTX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 05:19:23 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:34840 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726982AbgG0JTW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 05:19:22 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1595841561;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=QCPl26vQjULmYn4YuaO0oBKJfB0p6s8zWHm/BxwN4DE=;
        b=WCiKux6o5qS82s0WrOQGc0/r3SvsBRSYAbN+MtJSviYQ16IrZp2fPZbQ/OnM1xei7Mp/zC
        JRWu1sq5xFQHx6jBhX72zPYb8WvuI3wbO1It4mk+y34rXTbFYdtto4DVciycg/fsI6KVaZ
        PsuQozz66uHQUYupwjXGvKqwovhwDfc=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-60-00t_0R-uN2uzdepoAZ3Eyg-1; Mon, 27 Jul 2020 05:19:18 -0400
X-MC-Unique: 00t_0R-uN2uzdepoAZ3Eyg-1
Received: by mail-pg1-f198.google.com with SMTP id m7so12195187pgv.12
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 02:19:18 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=QCPl26vQjULmYn4YuaO0oBKJfB0p6s8zWHm/BxwN4DE=;
        b=i39eGGZaOafDBSioxj90WgQ203+YWsHf6w6teQQd9RWNIQiKnNPI5GzMH/gUVZpY6/
         r8OLCoXnYF55Mw8QPpQ57OV7T6hPQInEovCCFSDMuwGLb9OuVnKtyh347c1/3+Vae623
         CBsy6hR9255W6wOIKw3tKjmLP5kBN2V4I3r8Ml/4PTtilYlWEhm5J4mdYjTpzZv5W6Kl
         VytlZSdIWSx5+LvhRUjImwOFRdZPwvtNO34qJtfaxLAHVg8XV+CiUGegPGMaRfcYkiz3
         bqVoVf2b+bF/qOyum3//XzUzQQFFAK5GUD4Knki2uIRVe1p+FM6tYngV6yRyeBxho3Xg
         SM5Q==
X-Gm-Message-State: AOAM532ZXA+w+5CrwpZZ967tHNIoXcRRIPvvU61klzAY26Da7yELLdyw
        u1wmL186tJqG4BJvSZbSiVrLcNjP92ce7yt1jv5y0wBadPhFDrN8ND057RdLOgZIGUo8/l6LTfQ
        rz7CLb+duymvbVlADVmZU6Qli
X-Received: by 2002:a63:f91d:: with SMTP id h29mr18850254pgi.185.1595841556946;
        Mon, 27 Jul 2020 02:19:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwomZ6+Vbp5luBgFa8hpysABhvhc7f3FEYvkY/cSFOsThpYQXzhZNVsN/6DsU8W0TlfjyleKQ==
X-Received: by 2002:a63:f91d:: with SMTP id h29mr18850241pgi.185.1595841556701;
        Mon, 27 Jul 2020 02:19:16 -0700 (PDT)
Received: from xiangao.remote.csb ([209.132.188.80])
        by smtp.gmail.com with ESMTPSA id gf24sm4659062pjb.4.2020.07.27.02.19.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 27 Jul 2020 02:19:16 -0700 (PDT)
Date:   Mon, 27 Jul 2020 17:19:05 +0800
From:   Gao Xiang <hsiangkao@redhat.com>
To:     kernel test robot <lkp@intel.com>
Cc:     Gao Xiang <hsiangkao@aol.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: arch/alpha/include/asm/xchg.h:234:32: sparse: sparse: cast
 truncates bits from constant value (5f0ecafe becomes fe)
Message-ID: <20200727091905.GA17835@xiangao.remote.csb>
References: <202007251532.y5A10ZoO%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202007251532.y5A10ZoO%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On Sat, Jul 25, 2020 at 03:15:39PM +0800, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   23ee3e4e5bd27bdbc0f1785eef7209ce872794c7
> commit: 47e4937a4a7ca4184fd282791dfee76c6799966a erofs: move erofs out of staging
> date:   11 months ago
> config: alpha-randconfig-s031-20200725 (attached as .config)
> compiler: alpha-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.2-93-g4c6cbe55-dirty
>         git checkout 47e4937a4a7ca4184fd282791dfee76c6799966a
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=alpha 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> 
> sparse warnings: (new ones prefixed by >>)
> 
>    fs/erofs/zdata.c: note: in included file (through arch/alpha/include/asm/cmpxchg.h, arch/alpha/include/asm/atomic.h, include/linux/atomic.h, ...):
> >> arch/alpha/include/asm/xchg.h:234:32: sparse: sparse: cast truncates bits from constant value (5f0ecafe becomes fe)
> >> arch/alpha/include/asm/xchg.h:236:32: sparse: sparse: cast truncates bits from constant value (5f0ecafe becomes cafe)
> >> arch/alpha/include/asm/xchg.h:234:32: sparse: sparse: cast truncates bits from constant value (5f0ecafe becomes fe)
> >> arch/alpha/include/asm/xchg.h:234:32: sparse: sparse: cast truncates bits from constant value (5f0edead becomes ad)
> >> arch/alpha/include/asm/xchg.h:236:32: sparse: sparse: cast truncates bits from constant value (5f0ecafe becomes cafe)
> >> arch/alpha/include/asm/xchg.h:236:32: sparse: sparse: cast truncates bits from constant value (5f0edead becomes dead)

I'm not sure what's wrong here? What should I proceed with it
(it seems relating with Alpha architecture? since I didn't notice the sparse warning in x86 and arm)

Z_EROFS_PCLUSTER_TAIL is a pointer with magic value to indicate
the end of opening decompressing chain, whose function is likewise
the function of POISON_POINTER_DELTA and CONFIG_ILLEGAL_POINTER_VALUE.

Thanks,
Gao Xiang

