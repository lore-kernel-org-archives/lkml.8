Return-Path: <SRS0=F/Af=7W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3491AC433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 03:11:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A76D2078C
	for <linux-kernel@archiver.kernel.org>; Tue,  9 Jun 2020 03:11:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgFIDLr (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 23:11:47 -0400
Received: from mga03.intel.com ([134.134.136.65]:53709 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726803AbgFIDLq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 23:11:46 -0400
IronPort-SDR: oFim8bOGTTgZzSbZxLh5YJzrhekEXpzEKnutpZjEQQ1dFOsA4lD/JtvTzbQAmsoINJyWJTOV6o
 zvpkQgm/rD3A==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Jun 2020 20:11:46 -0700
IronPort-SDR: 41gQ4+UFJ1LwzdlsxqTdkKI9KQT7UgNLO+3RdRxfrxQgI3+2UblSq+sKyvzJmVtsKkAzmsz5sK
 aITrlSyXvLtQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,490,1583222400"; 
   d="scan'208";a="349380289"
Received: from linux.intel.com ([10.54.29.200])
  by orsmga001.jf.intel.com with ESMTP; 08 Jun 2020 20:11:46 -0700
Received: from [10.213.44.24] (unknown [10.213.44.24])
        by linux.intel.com (Postfix) with ESMTP id BEFB75805EF;
        Mon,  8 Jun 2020 20:11:44 -0700 (PDT)
Reply-To: vadivel.muruganx.ramuthevar@linux.intel.com
Subject: Re: FATAL: drivers/phy/intel/phy-intel-emmc: sizeof(struct
 of_device_id)=200 is not a modulo of the size of section
 __mod_of__<identifier>_device_table=512.
To:     kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, clang-built-linux@googlegroups.com,
        linux-kernel@vger.kernel.org,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Andy Shevchenko <andriy.shevchenko@intel.com>
References: <202006081031.R2VosrSx%lkp@intel.com>
From:   "Ramuthevar, Vadivel MuruganX" 
        <vadivel.muruganx.ramuthevar@linux.intel.com>
Message-ID: <8fda2c12-a243-043f-3f56-b70fdb0fb033@linux.intel.com>
Date:   Tue, 9 Jun 2020 11:11:42 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <202006081031.R2VosrSx%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/6/2020 10:23 am, kernel test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   af7b4801030c07637840191c69eb666917e4135d
> commit: 9227942383307f97fa6992416f73af4a23ef972c phy: intel-lgm-emmc: Add support for eMMC PHY
> date:   5 months ago
> config: x86_64-randconfig-a011-20200607 (attached as .config)
> compiler: clang version 11.0.0 (https://github.com/llvm/llvm-project e429cffd4f228f70c1d9df0e5d77c08590dd9766)
> reproduce (this is a W=1 build):
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          # install x86_64 cross compiling tool for clang build
>          # apt-get install binutils-x86-64-linux-gnu
>          git checkout 9227942383307f97fa6992416f73af4a23ef972c
>          # save the attached .config to linux build tree
>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=clang make.cross ARCH=x86_64
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All errors (new ones prefixed by >>, old ones prefixed by <<):
> 
> WARNING: modpost: missing MODULE_LICENSE() in drivers/phy/intel/phy-intel-emmc.o
> see include/linux/module.h for more information
>>> FATAL: drivers/phy/intel/phy-intel-emmc: sizeof(struct of_device_id)=200 is not a modulo of the size of section __mod_of__<identifier>_device_table=512.
> Fix definition of struct of_device_id in mod_devicetable.h
Thanks for the report!

Noted, will fix it.

Regards
Vadivel

> 
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
> 
