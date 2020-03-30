Return-Path: <SRS0=Mt+e=5P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 80014C43331
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:21:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 507E220771
	for <linux-kernel@archiver.kernel.org>; Mon, 30 Mar 2020 21:21:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hzcHEx2f"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728709AbgC3VVf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 30 Mar 2020 17:21:35 -0400
Received: from mail-pj1-f65.google.com ([209.85.216.65]:37203 "EHLO
        mail-pj1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728376AbgC3VVe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 Mar 2020 17:21:34 -0400
Received: by mail-pj1-f65.google.com with SMTP id o12so155799pjs.2
        for <linux-kernel@vger.kernel.org>; Mon, 30 Mar 2020 14:21:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=c58CgR5RaTTT0ridfaLClS+3w3fI3dWJ48HBtxaq8qI=;
        b=hzcHEx2fTjfAO8sI4uwW0GUfGzunMmmPcJ9OaqQShmJeqn5hZlhFd5JQjKAuwZoGHD
         WTVuTpHivpHmswpd+DjenJFn3y3mK9bXkhvkt5LsvubmfwthLYpe4zdhEpHeqghoPBb+
         x8/z4KybvAhHqOKn3b2PiKV/aggTVvKa9NN9asUfYOSLPZNGicusHUCw6vTgN/MsbxkT
         trYqwolaLaaHJnNzuVjqry2TsnhJh0zu0oV3KPEu24uhvhXsQLWrMEy2y8U7pglbiZ06
         L/q7C3htkHNrbyxhglZE5FTlpVQDVo75b1gIPFB2aYCsCwSVrho6mXU0kwAbBeOspI28
         KHbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=c58CgR5RaTTT0ridfaLClS+3w3fI3dWJ48HBtxaq8qI=;
        b=Py6dbpIqEEORiOePPOBIpN9Xo7dGg+uT2lpNOH6f8t7N5mWO2vaNwwqYij5Z2fyP5A
         80YPj07BjB+Cddxd9zl4/aqbz/ki6yxkDZykvKU6XFu2dHGlvhQfRfW0+RVtmKHKjHbx
         uWJXaQlu/DgxHISmckIPFu40Wme3Dmb9f6xAkNkWKdzJpSdt9iPieqZEC6Xzk2a2M+4r
         xJ7Y30EVyf10dnADrwd+R4/1cyQrjbhVJTtaIFRtHMeAoPJ54IDVG3EGcsViplljsChN
         h+nfRJT1IYMhI9VqpiIVF+vh+0k39nHb3PtE1XKmL40/HjqobYkUu0u5Y+2gMSKzdlz2
         Bc6Q==
X-Gm-Message-State: AGi0PuZuhM5VcOPOGU3j+5Ik8bKp6nR/Agpd86EL8zHQ0lqWDkiXevf3
        Kcr+zNDS/nyEHar09wKwfZexKEl7M92ylPQNxlCgjw==
X-Google-Smtp-Source: APiQypJD6KuAJxXwkf6/KglgRyyZBT1TGicfXCvZiL0QhGQMKV7TwftlWfceSnG2f72pzU8juFS5AtwqfVObT5Y4F7Q=
X-Received: by 2002:a17:902:76c6:: with SMTP id j6mr5049067plt.223.1585603293019;
 Mon, 30 Mar 2020 14:21:33 -0700 (PDT)
MIME-Version: 1.0
References: <202003310500.8jcJ6fgm%lkp@intel.com>
In-Reply-To: <202003310500.8jcJ6fgm%lkp@intel.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Mon, 30 Mar 2020 14:21:20 -0700
Message-ID: <CAKwvOdnwaoPSB_pavQimvNEuFdt9wF4xSHBbLtjzQUC=urJAxw@mail.gmail.com>
Subject: Re: ld.lld: error: drivers/staging/rtl8192e/rtllib_wx.o:(.rodata.str1.1):
 offset is outside the section
To:     Rob Herring <robh@kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>,
        Dirk Mueller <dmueller@suse.com>
Cc:     kbuild-all@lists.01.org,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        LKML <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Philip Li <philip.li@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Apologies, we're in the process of getting LLD turned on.  These
warnings look new to me, so I'll file an issue to follow up on.  It's
unrelated to the yyloc change.
https://github.com/ClangBuiltLinux/linux/issues/959

On Mon, Mar 30, 2020 at 2:17 PM kbuild test robot <lkp@intel.com> wrote:
>
> Hi Dirk,
>
> First bad commit (maybe != root cause):
>
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   7111951b8d4973bda27ff663f2cf18b663d15b48
> commit: e33a814e772cdc36436c8c188d8c42d019fda639 scripts/dtc: Remove redundant YYLOC global declaration
> date:   3 days ago
> config: arm-allyesconfig (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project b4695351cb4ce1c4450a029a0c226dc8bb5f5d55)
> reproduce:
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         git checkout e33a814e772cdc36436c8c188d8c42d019fda639
>         # save the attached .config to linux build tree
>         COMPILER=clang make.cross ARCH=arm
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
> >> ld.lld: error: drivers/staging/rtl8192e/rtllib_wx.o:(.rodata.str1.1): offset is outside the section
> >> ld.lld: error: drivers/staging/rtl8192e/rtllib_softmac.o:(.rodata.str1.1): offset is outside the section
> >> ld.lld: error: drivers/staging/rtl8192e/rtllib_tx.o:(.rodata.str1.1): offset is outside the section
> --
> >> ld.lld: error: drivers/staging/rtl8192u/ieee80211/dot11d.o:(.rodata.str1.1): offset is outside the section
> --
> >> ld.lld: error: drivers/staging/rtl8723bs/core/rtw_debug.o:(.rodata.str1.1): offset is outside the section
> >> ld.lld: error: drivers/staging/rtl8723bs/core/rtw_sta_mgt.o:(.rodata.str1.1): offset is outside the section
> >> ld.lld: error: drivers/staging/rtl8723bs/core/rtw_security.o:(.rodata.str1.1): offset is outside the section
> >> ld.lld: error: drivers/staging/rtl8723bs/core/rtw_wlan_util.o:(.rodata.str1.1): offset is outside the section
> >> ld.lld: error: drivers/staging/rtl8723bs/core/rtw_ieee80211.o:(.rodata.cst4): offset is outside the section
> >> ld.lld: error: drivers/staging/rtl8723bs/core/rtw_odm.o:(.rodata.str1.1): offset is outside the section
> >> ld.lld: error: drivers/staging/rtl8723bs/core/rtw_recv.o:(.rodata.str1.1): offset is outside the section
> >> ld.lld: error: drivers/staging/rtl8723bs/hal/hal_com.o:(.rodata.str1.1): offset is outside the section
> >> ld.lld: error: drivers/staging/rtl8723bs/core/rtw_ioctl_set.o:(.rodata.str1.1): offset is outside the section
> >> ld.lld: error: drivers/staging/rtl8723bs/core/rtw_xmit.o:(.rodata.str1.1): offset is outside the section
>    ld.lld
> --
> >> ld.lld: error: drivers/misc/mic/vop/vop_vringh.o:(.rodata.str1.1): offset is outside the section
> --
>    ld.lld: error: drivers/staging/rtl8188eu/core/rtw_efuse.o:(.rodata.str1.1): offset is outside the section
> >> ld.lld: error: drivers/staging/rtl8188eu/os_dep/xmit_linux.o:(.rodata.str1.1): offset is outside the section
> --
> >> ld.lld: error: drivers/staging/kpc2000/kpc_dma/fileops.o:(.rodata.str1.1): offset is outside the section
>    ld.lld: error: drivers/staging/kpc2000/kpc_dma/kpc_dma_driver.o:(.rodata.str1.1): offset is outside the section
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
> --
> You received this message because you are subscribed to the Google Groups "Clang Built Linux" group.
> To unsubscribe from this group and stop receiving emails from it, send an email to clang-built-linux+unsubscribe@googlegroups.com.
> To view this discussion on the web visit https://groups.google.com/d/msgid/clang-built-linux/202003310500.8jcJ6fgm%25lkp%40intel.com.



-- 
Thanks,
~Nick Desaulniers
