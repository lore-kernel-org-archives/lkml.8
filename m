Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AC8F2C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:34:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 806FB2078D
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:34:46 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726867AbgHTAep (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:34:45 -0400
Received: from mga06.intel.com ([134.134.136.31]:7673 "EHLO mga06.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726681AbgHTAeo (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 20:34:44 -0400
IronPort-SDR: EauY4riZJCl36P4jWmGSBoTjenjyGNQ/diN0hXLLcfM2zEkPip2XPX7Y7XlJ3EFZK6rq/S1GXN
 HWfW04f5nzSw==
X-IronPort-AV: E=McAfee;i="6000,8403,9718"; a="216751054"
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="216751054"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga005.jf.intel.com ([10.7.209.41])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 17:34:43 -0700
IronPort-SDR: nJmm0rF6UwMP7YmtFr8ehyHe2KjZmYZSek3t/nBnoCMsQqknuuzvozT/fgomnxxidyEP/KInLl
 W446bRfSzxLA==
X-IronPort-AV: E=Sophos;i="5.76,332,1592895600"; 
   d="scan'208";a="472442155"
Received: from rongch2-mobl.ccr.corp.intel.com (HELO [10.238.4.3]) ([10.238.4.3])
  by orsmga005-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2020 17:34:41 -0700
Subject: Re: [kbuild-all] Re: drivers/net/wireless/ti/wlcore/main.c:700:9:
 sparse: sparse: context imbalance in 'wlcore_irq' - different lock contexts
 for basic block
To:     Tony Lindgren <tony@atomide.com>, kernel test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Kalle Valo <kvalo@codeaurora.org>
References: <202008111908.j7IQlv5Q%lkp@intel.com>
 <20200817102821.GE2994@atomide.com>
From:   "Chen, Rong A" <rong.a.chen@intel.com>
Message-ID: <a817204f-8b4d-339f-6e22-701ed189795b@intel.com>
Date:   Thu, 20 Aug 2020 08:34:37 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200817102821.GE2994@atomide.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/17/2020 6:28 PM, Tony Lindgren wrote:
> Hi,
>
> * kernel test robot <lkp@intel.com> [200811 11:55]:
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   00e4db51259a5f936fec1424b884f029479d3981
>> commit: 35fba0f0fd762a8b87d403ae3c723e0061c4aa25 wlcore: Use spin_trylock in wlcore_irq() to see if we need to queue tx
>> date:   4 weeks ago
>> config: mips-randconfig-s032-20200811 (attached as .config)
>> compiler: mips64-linux-gcc (GCC) 9.3.0
>> reproduce:
>>          wget https://raw.githubusercontent.com/intel/lkp-tests/master/sbin/make.cross -O ~/bin/make.cross
>>          chmod +x ~/bin/make.cross
>>          # apt-get install sparse
>>          # sparse version: v0.6.2-168-g9554805c-dirty
>>          git checkout 35fba0f0fd762a8b87d403ae3c723e0061c4aa25
>>          # save the attached .config to linux build tree
>>          COMPILER_INSTALL_PATH=$HOME/0day COMPILER=gcc-9.3.0 make.cross C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=mips
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kernel test robot <lkp@intel.com>
>>
>>
>> sparse warnings: (new ones prefixed by >>)
>>
>>     drivers/net/wireless/ti/wlcore/main.c:643:34: sparse: sparse: context imbalance in 'wlcore_irq_locked' - different lock contexts for basic block
>>>> drivers/net/wireless/ti/wlcore/main.c:700:9: sparse: sparse: context imbalance in 'wlcore_irq' - different lock contexts for basic block
> I tried to reproduce this with cross compiling for ARM using sparse-0.6.2,
> but don't see any similar warnings.
>
> Is this only happening on mips for some reason?
>
> Regards,
>
> Tony
>

Hi Tony,

Sorry for the inconvenience, please ignore this report,
there is something wrong in the bot.

Best Regards,
Rong Chen
