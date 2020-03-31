Return-Path: <SRS0=6o4L=5Q=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA0E9C43331
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 05:14:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 9D49E2071A
	for <linux-kernel@archiver.kernel.org>; Tue, 31 Mar 2020 05:14:34 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726437AbgCaFOd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 31 Mar 2020 01:14:33 -0400
Received: from mga09.intel.com ([134.134.136.24]:21215 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725809AbgCaFOd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 Mar 2020 01:14:33 -0400
IronPort-SDR: UlaoPy7Xjg/gIAfF1gLPV0KSEolyij5PYB6hspiukSBz4zC78uSrz3pIv1+LTX0qwyZlWR2o+l
 OcOjOsdQMBbw==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 30 Mar 2020 22:14:32 -0700
IronPort-SDR: pyOGj4JMFVgH9bKXmJht5P4G1rabdEzJO4CIyab0A0KBv4odf4m89mpUPjSkas2aWwI96II+Sg
 RdpHozv1p8Wg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,327,1580803200"; 
   d="scan'208";a="294822776"
Received: from pl-dbox.sh.intel.com (HELO intel.com) ([10.239.159.39])
  by FMSMGA003.fm.intel.com with ESMTP; 30 Mar 2020 22:14:30 -0700
Date:   Tue, 31 Mar 2020 13:13:51 +0800
From:   Philip Li <philip.li@intel.com>
To:     kbuild test robot <lkp@intel.com>
Cc:     Dirk Mueller <dmueller@suse.com>, kbuild-all@lists.01.org,
        clang-built-linux@googlegroups.com, linux-kernel@vger.kernel.org,
        Rob Herring <robh@kernel.org>,
        David Gibson <david@gibson.dropbear.id.au>
Subject: Re: [kbuild-all] ld.lld: error:
 drivers/staging/gdm724x/gdm_usb.o:(.rodata.str1.1): offset is outside the
 section
Message-ID: <20200331051351.GA13302@intel.com>
References: <202003311137.1kHCgonh%lkp@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202003311137.1kHCgonh%lkp@intel.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 31, 2020 at 11:14:40AM +0800, kbuild test robot wrote:
> Hi Dirk,
> 
> First bad commit (maybe != root cause):
Sorry Dirk, kindly ignore this, it was explained in early email loop
regarding another report.

[kbuild-all] ld.lld: error: drivers/staging/rtl8192e/rtllib_wx.o:(.rodata.str1.1): offset is outside the section

We will update 0-day ci build to avoid this.

> 
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   2ce94bc4e056d3e48291aac87a95ebd2a86348ba
> commit: e33a814e772cdc36436c8c188d8c42d019fda639 scripts/dtc: Remove redundant YYLOC global declaration
> date:   4 days ago
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
>    ld.lld: error: drivers/staging/gdm724x/netlink_k.o:(.rodata.str1.1): offset is outside the section
> >> ld.lld: error: drivers/staging/gdm724x/gdm_usb.o:(.rodata.str1.1): offset is outside the section
>    ld.lld: error: drivers/staging/gdm724x/gdm_lte.o:(.rodata.str1.1): offset is outside the section
> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org


> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

