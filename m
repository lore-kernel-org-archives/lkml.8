Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D8AFFC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:08:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B4B4720772
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:08:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732109AbgDAIIv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:08:51 -0400
Received: from mga11.intel.com ([192.55.52.93]:24100 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1732100AbgDAIIu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:08:50 -0400
IronPort-SDR: vTsshMzgXZRfKcmJG+7CVMlZuxS4xoYJpHQw06YcA/NVVpMZp2g558m/Wv8NPXX3q/olvsd32e
 PNrx6w16hK8g==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 01 Apr 2020 01:08:50 -0700
IronPort-SDR: 9DbTYDMVjJRXR19Cf9qylzYCg+PmUSfVOntDnAP8N2UfWgAQSBa6c04Ep07AqlBPTIv+PMeYdu
 Wb8BUJr319OQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,330,1580803200"; 
   d="scan'208";a="422622654"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga005.jf.intel.com with ESMTP; 01 Apr 2020 01:08:48 -0700
Subject: Re: [kbuild-all] Error: Invalid compression type
To:     kbuild test robot <lkp@intel.com>,
        Sukadev Bhattiprolu <sukadev@linux.vnet.ibm.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>
References: <202004011110.pULPETYO%lkp@intel.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <587d127c-1fc9-df46-033b-51eb7547b2b6@intel.com>
Date:   Wed, 1 Apr 2020 16:08:28 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <202004011110.pULPETYO%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/1/20 11:28 AM, kbuild test robot wrote:
> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
> head:   b3aa112d57b704441143d84b0475fb633a750035
> commit: 493a55f1e7724dee5e71bc726d5b819292094587 powerpc/xmon: Fix compile error in print_insn* functions
> date:   10 weeks ago
> config: powerpc-randconfig-a001-20200401 (attached as .config)
> compiler: powerpc-linux-gcc (GCC) 9.3.0
> reproduce:
>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>          chmod +x ~/bin/make.cross
>          git checkout 493a55f1e7724dee5e71bc726d5b819292094587
>          # save the attached .config to linux build tree
>          GCC_VERSION=9.3.0 make.cross ARCH=powerpc
>
> If you fix the issue, kindly add following tag
> Reported-by: kbuild test robot <lkp@intel.com>
>
> All errors (new ones prefixed by >>):
>
>>> Error: Invalid compression type

Please ignore this report, the error is from mkimage: 
https://github.com/u-boot/u-boot/blob/master/tools/mkimage.c#L178

Best Regards,
Rong Chen

>     Usage: /usr/bin/mkimage -l image
>     -l ==> list image header information
>     /usr/bin/mkimage -A arch -O os -T type -C comp -a addr -e ep -n name -d image
>     -A ==> set architecture to 'arch'
>     -O ==> set operating system to 'os'
>     -T ==> set image type to 'type'
>     -C ==> set compression type 'comp'
>     -a ==> set load address to 'addr' (hex)
>     ==> set entry point to 'ep' (hex)
>     ==> set image name to 'name'-d ==> use image data from 'datafile'
>     -x ==> set XIP (execute in place)
>     /usr/bin/mkimage [-D dtc_options] [-f fit-image.its|-f auto|-F] [-b <dtb> [-b <dtb>]] [-i <ramdisk.cpio.gz>] fit-image
>     <dtb> file is used with -f auto, it may occur multiple times.
>     -D => set all options for device tree compiler
>     -f => input filename for FIT source
>     -i => input filename for ramdisk file
>     Signing / verified boot not supported (CONFIG_FIT_SIGNATURE undefined)
>     /usr/bin/mkimage -V ==> print version information and exit
>     Use '-T list' to see a list of available image types
>
> ---
> 0-DAY CI Kernel Test Service, Intel Corporation
> https://lists.01.org/hyperkitty/list/kbuild-all@lists.01.org
>
> _______________________________________________
> kbuild-all mailing list -- kbuild-all@lists.01.org
> To unsubscribe send an email to kbuild-all-leave@lists.01.org

