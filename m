Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92439C55189
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:39:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7C3C7206A2
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 07:39:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726599AbgDVHji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 03:39:38 -0400
Received: from mga12.intel.com ([192.55.52.136]:62378 "EHLO mga12.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbgDVHjh (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 03:39:37 -0400
IronPort-SDR: 1yzLhHY0RV5LMWR0X9m1ksDPCizZZSg4bXwQRuSRzUIwMkLpAYdwg96QMtP05CetTnigfAbPbm
 4CseAVGLniIA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga106.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Apr 2020 00:39:36 -0700
IronPort-SDR: rOG+gugz38OPOtrE3zpkTsVVAm/Lg3MPFrilo7XoPSO6y6dcaEB9DcMLSduCNt4tZDIQAx1LDf
 UKPM1Wovwvaw==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.72,412,1580803200"; 
   d="scan'208";a="402455261"
Received: from shao2-debian.sh.intel.com (HELO [10.239.13.3]) ([10.239.13.3])
  by orsmga004.jf.intel.com with ESMTP; 22 Apr 2020 00:39:34 -0700
Subject: Re: [kbuild-all] Re: sound/soc/soc-compress.c:75:28: warning:
 'component' is used uninitialized in this function
To:     Kuninori Morimoto <kuninori.morimoto.gx@renesas.com>
Cc:     kbuild test robot <lkp@intel.com>, kbuild-all@lists.01.org,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>
References: <202004201540.vYPhhYMs%lkp@intel.com>
 <87eeshuzla.wl-kuninori.morimoto.gx@renesas.com>
 <21c9be58-057d-a151-f64d-e8f85f1c585c@intel.com>
 <875zdsunmj.wl-kuninori.morimoto.gx@renesas.com>
From:   Rong Chen <rong.a.chen@intel.com>
Message-ID: <7048e026-2f6c-7b49-000a-a3b313a14366@intel.com>
Date:   Wed, 22 Apr 2020 15:39:25 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <875zdsunmj.wl-kuninori.morimoto.gx@renesas.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/20 12:53 PM, Kuninori Morimoto wrote:
> Hi Rong
>
>>> Hmm... I still can't reproduce this issue.
>>> I don't have gcc-6, thus can't try it.
>>> Is this the issue ??
> (snip)
>> We can reproduce the warning with gcc-6 (gcc version 6.5.0 20181026
>> (Debian 6.5.0-2)),
>> and the warning can be closed if changed to "struct snd_soc_component
>> *component = NULL, *save = NULL;"
> Thank you for your feedback.
> It sounds reasonable for me.
> Can you post it ? or do you want me to do it ?

Thanks, I have posted it.

Best Regards,
Rong Chen
