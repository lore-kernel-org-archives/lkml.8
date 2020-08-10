Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 38E2DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 02:51:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EA4D9206A5
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 02:51:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726466AbgHJCvC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 9 Aug 2020 22:51:02 -0400
Received: from mga18.intel.com ([134.134.136.126]:25766 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726338AbgHJCvC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Aug 2020 22:51:02 -0400
IronPort-SDR: OTgRWCw+6go1+kxFHwAaWK40/MkRB28P18gTXlzfpNeOJ9NWW+tDhfdD4wj4e1aD7L4a5B2kC5
 cLMqCuQWmsHA==
X-IronPort-AV: E=McAfee;i="6000,8403,9708"; a="141076296"
X-IronPort-AV: E=Sophos;i="5.75,456,1589266800"; 
   d="scan'208";a="141076296"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga005.fm.intel.com ([10.253.24.32])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 09 Aug 2020 19:51:01 -0700
IronPort-SDR: Yy9cvCnNMl0PLHMe4fgB7IiSG/qsjvfOta04elk2Ih3KEUfTPf+nLwngoG4uHBikyj7rnZSHO3
 /O6L/9GE9/XA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,456,1589266800"; 
   d="scan'208";a="494646071"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by fmsmga005.fm.intel.com with ESMTP; 09 Aug 2020 19:51:00 -0700
Subject: Re: [kbuild-all] Re: drivers/video/fbdev/pxafb.c:916:24: sparse:
 sparse: incorrect type in assignment (different address spaces)
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org
References: <202008071833.kUoyxyIe%lkp@intel.com>
 <20200807115304.npzxzzcuxbn7td2h@ltop.local>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <290fcc86-0519-7763-102b-4728eb94a614@intel.com>
Date:   Mon, 10 Aug 2020 10:50:22 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <20200807115304.npzxzzcuxbn7td2h@ltop.local>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/7/20 7:53 PM, Luc Van Oostenryck wrote:
> On Fri, Aug 07, 2020 at 06:37:36PM +0800, kernel test robot wrote:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   86cfccb66937dd6cbf26ed619958b9e587e6a115
>> commit: 670d0a4b10704667765f7d18f7592993d02783aa sparse: use identifiers to define address spaces
>> date:   7 weeks ago
>> config: arm-randconfig-s031-20200807 (attached as .config)
>> compiler: arm-linux-gnueabi-gcc (GCC) 9.3.0
>> reproduce:
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # apt-get install sparse
>>          # sparse version: v0.6.2-118-ge1578773-dirty
>>          git checkout 670d0a4b10704667765f7d18f7592993d02783aa
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=arm
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> sparse warnings: (new ones prefixed by >>)
>>
>>>> drivers/video/fbdev/pxafb.c:916:24: sparse: sparse: incorrect type in assignment (different address spaces) @@     expected void [noderef] __iomem *video_mem @@     got void * @@
>>>> drivers/video/fbdev/pxafb.c:916:24: sparse:     expected void [noderef] __iomem *video_mem
> Hi,
>
> since late June I receive several mails per day about this commit but
> they are all false-positive.
> Commit 670d0a4b10704667765f7d18f7592993d02783aa can't introduce *new*
> warnings, it only change how address-spaces are displayed in sparse's
> warnings (for example, the address space for __user pointers were
> displayd as '<asn:1>', now it's nicely displayed as '__user', same
> for '__iomem', '__percpu' and '__rcu').
>
> Isn't it possible to ignore some commits like this one?

Hi Luc,

Sorry for the inconvenience, we'll ignore this commit firstly.

> Or, even better, should it be possible to only report when a new
> warning is effectively added, not when its content is simply modified?
> If not it would be nice to be able to see the difference in a diff-like
> format.
Thanks for your advice, we'll seriously consider it.

Best Regards,
Rong Chen
