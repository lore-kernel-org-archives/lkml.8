Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B135C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 01:18:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3CDA220747
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 01:18:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726359AbgDVBSE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Apr 2020 21:18:04 -0400
Received: from mga14.intel.com ([192.55.52.115]:32180 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726024AbgDVBSD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Apr 2020 21:18:03 -0400
IronPort-SDR: mPF/MjPpdp1hShjwy3PUg9c6QNhmFnNaRksMWzfVf2YxavAyMUnkJ6lMAEXD3MXAP69R4iXJHP
 cSFppLR6e+3Q==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2020 18:18:03 -0700
IronPort-SDR: 6l6YK4sA5Ns3pKrIUT/p5tb8q0agx3EDFMEWSNFL1xj4zJzkoITPI9nyz+AfyYptrSi3a5rg1V
 AYAkdLsXWzjA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,412,1580803200"; 
   d="scan'208";a="402370693"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga004.jf.intel.com with ESMTP; 21 Apr 2020 18:18:01 -0700
Subject: Re: [kbuild-all] Re: sound/soc/soc-compress.c:75:28: warning:
 'component' is used uninitialized in this function
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>,
        kbuild test robot <lkp@intel.com>
Cc:     kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        Mark Brown <broonie@kernel.org>
References: <202004201540.vYPhhYMs%lkp@intel.com>
 <87eeshuzla.wl-kuninori.morimoto.gx@renesas.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <21c9be58-057d-a151-f64d-e8f85f1c585c@intel.com>
Date:   Wed, 22 Apr 2020 09:17:52 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <87eeshuzla.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/20 2:23 PM, Kuninori Morimoto wrote:
> Hi
>
>> tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.git master
>> head:   7a56db0299f9d43b4fe076838150c5cc293df131
>> commit: 613fb50059cf19aa6acbc503a00265d9151c0b09 ASoC: soc-core: remove snd_soc_rtdcom_list
>> date:   3 months ago
>> config: i386-randconfig-a002-20200420 (attached as .config)
>> compiler: gcc-6 (Debian 6.3.0-18+deb9u1) 6.3.0 20170516
>> reproduce:
>>          git checkout 613fb50059cf19aa6acbc503a00265d9151c0b09
>>          # save the attached .config to linux build tree
>>          make ARCH=i386
>>
>> If you fix the issue, kindly add following tag as appropriate
>> Reported-by: kbuild test robot <lkp@intel.com>
>>
>> All warnings (new ones prefixed by >>):
>>
>>     sound/soc/soc-compress.c: In function 'soc_compr_open':
>>>> sound/soc/soc-compress.c:75:28: warning: 'component' is used uninitialized in this function [-Wuninitialized]
>>       struct snd_soc_component *component, *save = NULL;
>>                                 ^~~~~~~~~
> Hmm... I still can't reproduce this issue.
> I don't have gcc-6, thus can't try it.
> Is this the issue ??

Hi Kuninori,

We can reproduce the warning with gcc-6 (gcc version 6.5.0 20181026 
(Debian 6.5.0-2)),
and the warning can be closed if changed to "struct snd_soc_component 
*component = NULL, *save = NULL;"

Best Regards,
Rong Chen
