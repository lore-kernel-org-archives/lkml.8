Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 05BE0C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:49:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D8FC720734
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 10:49:58 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgFPKt5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 06:49:57 -0400
Received: from foss.arm.com ([217.140.110.172]:35286 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726526AbgFPKt4 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 06:49:56 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id F40681F1;
        Tue, 16 Jun 2020 03:49:55 -0700 (PDT)
Received: from [10.163.80.105] (unknown [10.163.80.105])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A8BFE3F6CF;
        Tue, 16 Jun 2020 03:49:52 -0700 (PDT)
Subject: Re: [PATCH] arm64/panic: Unify all three existing notifier blocks
To:     kernel test robot <lkp@intel.com>,
        linux-arm-kernel@lists.infradead.org
Cc:     kbuild-all@lists.01.org, Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Steve Capper <steve.capper@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        linux-kernel@vger.kernel.org
References: <1592277017-31784-1-git-send-email-anshuman.khandual@arm.com>
 <202006161624.KLnEetbG%lkp@intel.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <32f4d7d2-1db3-6264-8b79-a12b0702477f@arm.com>
Date:   Tue, 16 Jun 2020 16:19:46 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <202006161624.KLnEetbG%lkp@intel.com>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 06/16/2020 01:59 PM, kernel test robot wrote:
> Hi Anshuman,
> 
> Thank you for the patch! Perhaps something to improve:
> 
> [auto build test WARNING on arm64/for-next/core]
> [also build test WARNING on soc/for-next v5.8-rc1 next-20200616]
> [cannot apply to arm/for-next xlnx/master kvmarm/next]
> [if your patch is applied to the wrong git tree, please drop us a note to help
> improve the system. BTW, we also suggest to use '--base' option to specify the
> base tree in git format-patch, please see https://stackoverflow.com/a/37406982]
> 
> url:    https://github.com/0day-ci/linux/commits/Anshuman-Khandual/arm64-panic-Unify-all-three-existing-notifier-blocks/20200616-111111
> base:   https://git.kernel.org/pub/scm/linux/kernel/git/arm64/linux.git for-next/core
> config: arm64-allyesconfig (attached as .config)
> compiler: aarch64-linux-gcc (GCC) 9.3.0
> reproduce (this is a W=1 build):
>         wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>         chmod +x ~/bin/make.cross
>         # save the attached .config to linux build tree
>         COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross ARCH=arm64 
> 
> If you fix the issue, kindly add following tag as appropriate
> Reported-by: kernel test robot <lkp@intel.com>
> 
> All warnings (new ones prefixed by >>, old ones prefixed by <<):
> 
>>> arch/arm64/kernel/setup.c:403:6: warning: no previous prototype for 'dump_kernel_offset' [-Wmissing-prototypes]
> 403 | void dump_kernel_offset(void)
> |      ^~~~~~~~~~~~~~~~~~
> 
> vim +/dump_kernel_offset +403 arch/arm64/kernel/setup.c
> 
>    402	
>  > 403	void dump_kernel_offset(void)

Just missed a 'static' here, which caused this warning with W=1.
Will fix this next time around.
