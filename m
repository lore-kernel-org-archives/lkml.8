Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0B2EC2D0E8
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 05:23:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 917FB20757
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 05:23:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726481AbgCaFXF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 01:23:05 -0400
Received: from mga02.intel.com ([134.134.136.20]:27228 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgCaFXE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 01:23:04 -0400
IronPort-SDR: jQlH3q7+GwofYLMh9MclNqjWRDcEm5OuWjRWBKzXDcxhB+eXaYntBbGeI1YlgLdvNxkuJSEl9f
 tRio4x92NccQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 22:23:04 -0700
IronPort-SDR: jjSDt0sGR0jEVrpkUc2dMbErId9L2Dx8ff2YAlYZFTA2eNYzZhZFZztgwnXKo9v6zHiXN0sAEx
 lEQDMPxmn80w==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; 
   d="scan'208";a="422177181"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by orsmga005.jf.intel.com with ESMTP; 30 Mar 2020 22:23:01 -0700
Date:   Tue, 31 Mar 2020 13:22:22 +0800
From:   Philip Li <philip.li@intel.com>
To:     Nathan Chancellor <natechancellor@gmail.com>
Cc:     Nick Desaulniers <ndesaulniers@google.com>,
        Rob Herring <robh@kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Dirk Mueller <dmueller@suse.com>, kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>
Subject: Re: ld.lld: error:
 drivers/staging/rtl8192e/rtllib_wx.o:(.rodata.str1.1): offset is outside the
 section
Message-ID: <20200331052222.GB13302@intel.com>
References: <202003310500.8jcJ6fgm%lkp@intel.com>
 <CAKwvOdnwaoPSB_pavQimvNEuFdt9wF4xSHBbLtjzQUC=urJAxw@mail.gmail.com>
 <20200330213406.GA3170@ubuntu-m2-xlarge-x86>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200330213406.GA3170@ubuntu-m2-xlarge-x86>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 30, 2020 at 02:34:06PM -0700, Nathan Chancellor wrote:
> On Mon, Mar 30, 2020 at 02:21:20PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> > Apologies, we're in the process of getting LLD turned on.  These
> > warnings look new to me, so I'll file an issue to follow up on.  It's
> > unrelated to the yyloc change.
> > https://github.com/ClangBuiltLinux/linux/issues/959
> 
> $ gzip -d .config.gz
> 
> $ rg ENDIAN .config
> 781:CONFIG_CPU_BIG_ENDIAN=y
> 782:CONFIG_CPU_ENDIAN_BE8=y
> 810:CONFIG_ARCH_SUPPORTS_BIG_ENDIAN=y
> 1112:CONFIG_VHOST_CROSS_ENDIAN_LEGACY=y
> 7875:CONFIG_FB_FOREIGN_ENDIAN=y
> 7876:CONFIG_FB_BOTH_ENDIAN=y
> 7877:# CONFIG_FB_BIG_ENDIAN is not set
> 7878:# CONFIG_FB_LITTLE_ENDIAN is not set
> 9047:CONFIG_USB_OHCI_LITTLE_ENDIAN=y
> 
> ld.lld does not support AArch64 or ARM big endian:
got it, we will update build logic to keep lld where it suits.

> 
> https://reviews.llvm.org/D58655#1410281
> 
> https://github.com/ClangBuiltLinux/linux/issues/380
> 
> Does 0day do an allyesconfig little endian? I know that arm64 defaults
currently no, the default arm allyes uses CONFIG_CPU_BIG_ENDIAN=y.

> to little endian after commit d8e85e144bbe ("arm64: Kconfig: add a
> choice for endianness") but arm does not have something like that (maybe
> it should?). I've always forced CONFIG_CPU_LITTLE_ENDIAN with the
> KCONFIG_ALLCONFIG variable, as I note in issue #380 above.
> 
> Kind of surprised that it got to drivers/staging though, I error out in
> arch/arm/vdso/Makefile:
> 
> $ mkdir -p out/arm32 && curl -LSs 'https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org/message/V6YPX24H2YFOKOE7FWFJ66DQI63R3WKZ/attachment/2/config.gz' | gzip -d > out/arm32/.config
> 
> $ make -j$(nproc) -s ARCH=arm CC=clang CROSS_COMPILE=arm-linux-gnueabi- LD=ld.lld O=out/arm32 olddefconfig all
> ld.lld: error: unknown argument: --be8
> make[3]: *** [/home/nathan/src/linux/arch/arm/vdso/Makefile:50: arch/arm/vdso/vdso.so.raw] Error 1
> 
> > On Mon, Mar 30, 2020 at 2:17 PM kbuild test robot <lkp@intel.com> wrote:
> > >
> > > Hi Dirk,
> > >
> > > First bad commit (maybe != root cause):
> > >
> > > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> > > head:   7111951b8d4973bda27ff663f2cf18b663d15b48
> > > commit: e33a814e772cdc36436c8c188d8c42d019fda639 scripts/dtc: Remove redundant YYLOC global declaration
> > > date:   3 days ago
> > > config: arm-allyesconfig (attached as .config)
> > > compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project b4695351cb4ce1c4450a029a0c226dc8bb5f5d55)
> > > reproduce:
> > >         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
> > >         chmod +x ~/bin/make.cross
> > >         git checkout e33a814e772cdc36436c8c188d8c42d019fda639
> > >         # save the attached .config to linux build tree
> > >         COMPILER=clang make.cross ARCH=arm
> > >
> > > If you fix the issue, kindly add following tag
> > > Reported-by: kbuild test robot <lkp@intel.com>
> > >
> > > All errors (new ones prefixed by >>):
> > >
> > > >> ld.lld: error: drivers/staging/rtl8192e/rtllib_wx.o:(.rodata.str1.1): offset is outside the section
> > > >> ld.lld: error: drivers/staging/rtl8192e/rtllib_softmac.o:(.rodata.str1.1): offset is outside the section
> > > >> ld.lld: error: drivers/staging/rtl8192e/rtllib_tx.o:(.rodata.str1.1): offset is outside the section
> > > --
> > > >> ld.lld: error: drivers/staging/rtl8192u/ieee80211/dot11d.o:(.rodata.str1.1): offset is outside the section
> > > --
> > > >> ld.lld: error: drivers/staging/rtl8723bs/core/rtw_debug.o:(.rodata.str1.1): offset is outside the section
> > > >> ld.lld: error: drivers/staging/rtl8723bs/core/rtw_sta_mgt.o:(.rodata.str1.1): offset is outside the section
> > > >> ld.lld: error: drivers/staging/rtl8723bs/core/rtw_security.o:(.rodata.str1.1): offset is outside the section
> > > >> ld.lld: error: drivers/staging/rtl8723bs/core/rtw_wlan_util.o:(.rodata.str1.1): offset is outside the section
> > > >> ld.lld: error: drivers/staging/rtl8723bs/core/rtw_ieee80211.o:(.rodata.cst4): offset is outside the section
> > > >> ld.lld: error: drivers/staging/rtl8723bs/core/rtw_odm.o:(.rodata.str1.1): offset is outside the section
> > > >> ld.lld: error: drivers/staging/rtl8723bs/core/rtw_recv.o:(.rodata.str1.1): offset is outside the section
> > > >> ld.lld: error: drivers/staging/rtl8723bs/hal/hal_com.o:(.rodata.str1.1): offset is outside the section
> > > >> ld.lld: error: drivers/staging/rtl8723bs/core/rtw_ioctl_set.o:(.rodata.str1.1): offset is outside the section
> > > >> ld.lld: error: drivers/staging/rtl8723bs/core/rtw_xmit.o:(.rodata.str1.1): offset is outside the section
> > >    ld.lld
> > > --
> > > >> ld.lld: error: drivers/misc/mic/vop/vop_vringh.o:(.rodata.str1.1): offset is outside the section
> > > --
> > >    ld.lld: error: drivers/staging/rtl8188eu/core/rtw_efuse.o:(.rodata.str1.1): offset is outside the section
> > > >> ld.lld: error: drivers/staging/rtl8188eu/os_dep/xmit_linux.o:(.rodata.str1.1): offset is outside the section
> > > --
> > > >> ld.lld: error: drivers/staging/kpc2000/kpc_dma/fileops.o:(.rodata.str1.1): offset is outside the section
> > >    ld.lld: error: drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.o:(.rodata.str1.1): offset is outside the section
> > >
> > > ---
> > > 0-DAY CI Kernel Test Service, Intel Corporation
> > > https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> > >
> > 
> > 
> > 
> > -- 
> > Thanks,
> > ~Nick Desaulniers
> > 
