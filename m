Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A462DC43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:34:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6CBFA206CC
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:34:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="HrLDXXXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728997AbgC3VeK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 17:34:10 -0400
Received: from mail-ot1-f66.google.com ([209.85.210.66]:39417 "EHLO
        mail-ot1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728537AbgC3VeJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 17:34:09 -0400
Received: by mail-ot1-f66.google.com with SMTP id x11so19825303otp.6
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 14:34:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=eJ9iVLSHIFSUq96XznsAAHwNQ6GF7Gxs04ont8jFwbk=;
        b=HrLDXXXtUGChAkqyq9OS96wJHHa21T4l9IWr8hwl9TuYETxy7KpV7d5MTDBv4LQKAX
         5cfg0yjF5bynK1UDrwY8X2zpOQg6c+t90L2LQeuGPByXV1U9tZYT7Y5SfKUbb8MZZICP
         akM0UGW7/iQ31YAtdsNbvHCTWHOVi25tSteZnHAgn6R1MBkvT1kZchfEK0vAZpYfmVxi
         4muufN+Xm6LNlVTHfSzhW77Kw/0CgJkAxopVhvOu5OQlpd1GGGXUPF/Yt2WjjTlsxEsq
         AzUM/Qrwaq3OXoTJUftlTvJiEhyW0HbDgPJIYkA0BH1tL6VMEA9QG0rmOm7iMhe4x8kl
         zFpw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=eJ9iVLSHIFSUq96XznsAAHwNQ6GF7Gxs04ont8jFwbk=;
        b=jB3DqCboMkalVDIxHJ1Uq7spf31RZ5Bm3UtBXjg1AvztYXzoaSgO54GlMPyW8WJHUL
         z6DScF91MJ2x1e4bnrGPky0pd5iqNTYns466SBjDS9HbkOSaWcXQ1YvjPI1ccxxKIuVJ
         ldX36u9tKDpR7Is/DU5sRhDCJuVdu2muOQAjPFMuCitRTvOdG7ntnRWFGBimd2Hli75W
         XJARGTxP++rvZtL97GBSwPZ7GzkQXBiyFrWNHSaa+13LGkFBybrxLKwDJ4glxax4ZgzS
         UsjPm2gw2ZjkRVlbtCJrsmHvIlNEI9DPhxnMqFWg+rtJSeX9BNS7WmrIfv7011trF/x/
         WA7A==
X-Gm-Message-State: ANhLgQ2BXbhr7r+SfbA6EjmSsNLflQfY4v2L5HxUgZOdhHRQPZ/v36tr
        qCgoQeGuWufIuQKBR8104cE=
X-Google-Smtp-Source: ADFU+vv5iXxjbxyhjuo9A/sr2AMYQ9LtOejezRgV/oA7KRUe+sh8Y+HtmaHOpMpYfbQDrB+qWwA7fg==
X-Received: by 2002:a05:6830:11c1:: with SMTP id v1mr10963169otq.264.1585604048763;
        Mon, 30 Mar 2020 14:34:08 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id h65sm4741444oth.34.2020.03.30.14.34.07
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 30 Mar 2020 14:34:08 -0700 (PDT)
Date:   Mon, 30 Mar 2020 14:34:06 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Rob Herring <robh@kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Dirk Mueller <dmueller@suse.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Philip Li <philip.li@intel.com>
Subject: Re: ld.lld: error:
 drivers/staging/rtl8192e/rtllib_wx.o:(.rodata.str1.1): offset is outside the
 section
Message-ID: <20200330213406.GA3170@ubuntu-m2-xlarge-x86>
References: <202003310500.8jcJ6fgm%lkp@intel.com>
 <CAKwvOdnwaoPSB_pavQimvNEuFdt9wF4xSHBbLtjzQUC=urJAxw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdnwaoPSB_pavQimvNEuFdt9wF4xSHBbLtjzQUC=urJAxw@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 02:21:20PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> Apologies, we're in the process of getting LLD turned on.  These
> warnings look new to me, so I'll file an issue to follow up on.  It's
> unrelated to the yyloc change.
> https://github.com/ClangBuiltLinux/linux/issues/959

$ gzip -d .config.gz

$ rg ENDIAN .config
781:CONFIG_CPU_BIG_ENDIAN=y
782:CONFIG_CPU_ENDIAN_BE8=y
810:CONFIG_ARCH_SUPPORTS_BIG_ENDIAN=y
1112:CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y
7875:CONFIG_FB_FOREIGN_ENDIAN=y
7876:CONFIG_FB_BOTH_ENDIAN=y
7877:# CONFIG_FB_BIG_ENDIAN is not set
7878:# CONFIG_FB_LITTLE_ENDIAN is not set
9047:CONFIG_USB_OHCI_LITTLE_ENDIAN=y

ld.lld does not support AArch64 or ARM big endian:

https://reviews.llvm.org/D58655#1410281

https://github.com/ClangBuiltLinux/linux/issues/380

Does 0day do an allyesconfig little endian? I know that arm64 defaults
to little endian after commit d8e85e144bbe ("arm64: Kconfig: add a
choice for endianness") but arm does not have something like that (maybe
it should?). I've always forced CONFIG_CPU_LITTLE_ENDIAN with the
KCONFIG_ALLCONFIG variable, as I note in issue #380 above.

Kind of surprised that it got to drivers/staging though, I error out in
arch/arm/vdso/Makefile:

$ mkdir -p out/arm32 && curl -LSs 'https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/message/V6YPX24H2YFOKOE7FWFJ66DQI63R3WKZ/attachment/2/config.gz' | gzip -d > out/arm32/.config

$ make -j$(nproc) -s ARCH=arm CC=clang CROSS_COMPILE=arm-linux-gnueabi- LD=ld.lld O=out/arm32 olddefconfig all
ld.lld: error: unknown argument: --be8
make[3]: *** [/home/nathan/src/linux/arch/arm/vdso/Makefile:50: arch/arm/vdso/vdso.so.raw] Error 1

> On Mon, Mar 30, 2020 at 2:17 PM kbuild test robot <lkp@intel.com> wrote:
> >
> > Hi Dirk,
> >
> > First bad commit (maybe != root cause):
> >
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > head:   7111951b8d4973bda27ff663f2cf18b663d15b48
> > commit: e33a814e772cdc36436c8c188d8c42d019fda639 scripts/dtc: Remove redundant YYLOC global declaration
> > date:   3 days ago
> > config: arm-allyesconfig (attached as .config)
> > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project b4695351cb4ce1c4450a029a0c226dc8bb5f5d55)
> > reproduce:
> >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> >         chmod +x ~/bin/make.cross
> >         git checkout e33a814e772cdc36436c8c188d8c42d019fda639
> >         # save the attached .config to linux build tree
> >         COMPILER=clang make.cross ARCH=arm
> >
> > If you fix the issue, kindly add following tag
> > Reported-by: kbuild test robot <lkp@intel.com>
> >
> > All errors (new ones prefixed by >>):
> >
> > >> ld.lld: error: drivers/staging/rtl8192e/rtllib_wx.o:(.rodata.str1.1): offset is outside the section
> > >> ld.lld: error: drivers/staging/rtl8192e/rtllib_softmac.o:(.rodata.str1.1): offset is outside the section
> > >> ld.lld: error: drivers/staging/rtl8192e/rtllib_tx.o:(.rodata.str1.1): offset is outside the section
> > --
> > >> ld.lld: error: drivers/staging/rtl8192u/ieee80211/dot11d.o:(.rodata.str1.1): offset is outside the section
> > --
> > >> ld.lld: error: drivers/staging/rtl8723bs/core/rtw_debug.o:(.rodata.str1.1): offset is outside the section
> > >> ld.lld: error: drivers/staging/rtl8723bs/core/rtw_sta_mgt.o:(.rodata.str1.1): offset is outside the section
> > >> ld.lld: error: drivers/staging/rtl8723bs/core/rtw_security.o:(.rodata.str1.1): offset is outside the section
> > >> ld.lld: error: drivers/staging/rtl8723bs/core/rtw_wlan_util.o:(.rodata.str1.1): offset is outside the section
> > >> ld.lld: error: drivers/staging/rtl8723bs/core/rtw_ieee80211.o:(.rodata.cst4): offset is outside the section
> > >> ld.lld: error: drivers/staging/rtl8723bs/core/rtw_odm.o:(.rodata.str1.1): offset is outside the section
> > >> ld.lld: error: drivers/staging/rtl8723bs/core/rtw_recv.o:(.rodata.str1.1): offset is outside the section
> > >> ld.lld: error: drivers/staging/rtl8723bs/hal/hal_com.o:(.rodata.str1.1): offset is outside the section
> > >> ld.lld: error: drivers/staging/rtl8723bs/core/rtw_ioctl_set.o:(.rodata.str1.1): offset is outside the section
> > >> ld.lld: error: drivers/staging/rtl8723bs/core/rtw_xmit.o:(.rodata.str1.1): offset is outside the section
> >    ld.lld
> > --
> > >> ld.lld: error: drivers/misc/mic/vop/vop_vringh.o:(.rodata.str1.1): offset is outside the section
> > --
> >    ld.lld: error: drivers/staging/rtl8188eu/core/rtw_efuse.o:(.rodata.str1.1): offset is outside the section
> > >> ld.lld: error: drivers/staging/rtl8188eu/os_dep/xmit_linux.o:(.rodata.str1.1): offset is outside the section
> > --
> > >> ld.lld: error: drivers/staging/kpc2000/kpc_dma/fileops.o:(.rodata.str1.1): offset is outside the section
> >    ld.lld: error: drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.o:(.rodata.str1.1): offset is outside the section
> >
> > ---
> > 0-DAY CI Kernel Test Service, Intel Corporation
> > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> >
> 
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
> 
