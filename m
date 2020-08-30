Return-Path: <SRS0=gmpU=CI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.9 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4D36BC433E2
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 02:40:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1F13D2075B
	for <linux-kernel@archiver.kernel.org>; Sun, 30 Aug 2020 02:40:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="p7Xy4/aM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728649AbgH3CkF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 29 Aug 2020 22:40:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52244 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728613AbgH3CkA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 29 Aug 2020 22:40:00 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29AF2C061573
        for <linux-kernel@vger.kernel.org>; Sat, 29 Aug 2020 19:39:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:Content-Type:
        In-Reply-To:MIME-Version:Date:Message-ID:From:References:Cc:To:Subject:Sender
        :Reply-To:Content-ID:Content-Description;
        bh=SdDZog69QLWfVU3NvoY9/Jobi6jSjClX5VpfY33c/Zw=; b=p7Xy4/aMqCley+sFAHDZZZNUb9
        NU45KmzlcERUy6Yt0U0vvq3NLr7IIoOXM5sa2cAiiVc8lHc2jpZTNxPCXRXidq2dXZ+PuMhOa3NV7
        abu5d2qlPNnOmAXjGWnVC55tCHFOPoLfWOX2QzZsK6o/JRkLCIBxpQnznH0Ms9Y51JnTEA5YaJIDo
        JaoZ9FjedK78wzAPJEtpnqu8n5wTq3Q80XGhNzyVZuwHxvzhYoJpQDpss5x4PBL10oFolwfquR3Rs
        pa2iVq5llQiR806YiMjmue+pVmowez0f+x1lRAcFihcAWpGK5HDPw7PtfUEDRaZBqRyZ7mEZPbe0/
        D0lmUcDA==;
Received: from [2601:1c0:6280:3f0::19c2]
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1kCDG6-0008DY-Ug; Sun, 30 Aug 2020 02:39:55 +0000
Subject: Re: ERROR: modpost: "max_low_pfn" undefined!
To:     kernel test robot <lkp@intel.com>,
        Corentin Labbe <clabbe@baylibre.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Herbert Xu <herbert@gondor.apana.org.au>
References: <202008301008.MSyEoOWn%lkp@intel.com>
From:   Randy Dunlap <rdunlap@infradead.org>
Message-ID: <af3881f2-0588-0470-7a29-4369c3bddfa8@infradead.org>
Date:   Sat, 29 Aug 2020 19:39:51 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <202008301008.MSyEoOWn%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 8/29/20 7:32 PM, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   1127b219ce9481c84edad9711626d856127d5e51
> commit: f23efcbcc523b09c2ee359a35eb3897dc1764fd3 crypto: ctr - no longer needs CRYPTO_SEQIV
> date:   4 months ago
> config: ia64-randconfig-s031-20200830 (attached as .config)
> compiler: ia64-linux-gcc (GCC) 9.3.0
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # apt-get install sparse
>         # sparse version: v0.6.2-191-g10164920-dirty
>         git checkout f23efcbcc523b09c2ee359a35eb3897dc1764fd3
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=ia64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> ERROR: modpost: "min_low_pfn" [drivers/crypto/cavium/nitrox/n5pf.ko] undefined!
> ERROR: modpost: "max_low_pfn" [drivers/crypto/cavium/nitrox/n5pf.ko] undefined!
> ERROR: modpost: "min_low_pfn" [drivers/mtd/nand/raw/nand.ko] undefined!
> ERROR: modpost: "max_low_pfn" [drivers/mtd/nand/raw/nand.ko] undefined!
> ERROR: modpost: "max_low_pfn" [drivers/tty/serial/fsl_lpuart.ko] undefined!
> ERROR: modpost: "min_low_pfn" [drivers/tty/serial/fsl_lpuart.ko] undefined!
> ERROR: modpost: "max_low_pfn" [crypto/tcrypt.ko] undefined!
> ERROR: modpost: "min_low_pfn" [crypto/tcrypt.ko] undefined!
>>> ERROR: modpost: "max_low_pfn" [crypto/drbg.ko] undefined!
>>> ERROR: modpost: "min_low_pfn" [crypto/drbg.ko] undefined!
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 

Hello kernel test robot,

Please test with this patch applied:

https://lore.kernel.org/lkml/20200829000126.2463-1-rdunlap@infradead.org/


thanks.
-- 
~Randy

