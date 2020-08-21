Return-Path: <SRS0=Oudi=B7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D7CF6C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B4EEA207C3
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Aug 2020 15:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728025AbgHUPYR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 11:24:17 -0400
Received: from mga07.intel.com ([134.134.136.100]:44116 "EHLO mga07.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727950AbgHUPYE (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 11:24:04 -0400
IronPort-SDR: 70BIbq1x79/nF0LwGFq++WdYgCvh22Xe/STFbQoDatrGr2SLk1PiOmm8urbQ4e08HcfO0q9fWd
 44ZbjSKPnjOw==
X-IronPort-AV: E=McAfee;i="6000,8403,9719"; a="219843904"
X-IronPort-AV: E=Sophos;i="5.76,337,1592895600"; 
   d="scan'208";a="219843904"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga105.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 08:23:56 -0700
IronPort-SDR: zr1zjNdR2ZfsTBqk29XtWieg4LINsD0s6fmv+QUtyUtLdXM233ywWMMaCMB17PU9sMFN2bIyZ2
 BH/PZ1xhLQ+Q==
X-IronPort-AV: E=Sophos;i="5.76,337,1592895600"; 
   d="scan'208";a="442379328"
Received: from pcmiller-mobl1.amr.corp.intel.com (HELO [10.209.120.121]) ([10.209.120.121])
  by orsmga004-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Aug 2020 08:23:54 -0700
Subject: Re: [PATCH] soundwire: intel: fix CONFIG_PM and CONFIG_PM_SLEEP
 confusion
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20200820140441.9478-1-yung-chuan.liao@linux.intel.com>
 <20200821050159.GH2639@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <cab31891-15bf-4ae2-44dd-ae33de4eb4ed@linux.intel.com>
Date:   Fri, 21 Aug 2020 10:23:53 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200821050159.GH2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



>> When CONFIG_PM_SLEEP is not defined, GCC throws compilation warnings:
>>
>> drivers/soundwire/intel.c:1816:12: warning: ‘intel_resume’ defined but
>> not used [-Wunused-function]
>>   1816 | static int intel_resume(struct device *dev)
>>        |            ^~~~~~~~~~~~
>>
>> drivers/soundwire/intel.c:1697:12: warning: ‘intel_suspend’ defined
>> but not used [-Wunused-function]
>>   1697 | static int intel_suspend(struct device *dev)
>>
>> Fix by adding the missing CONFIG_PM_SLEEP.
> 
> Can you rather use __maybe for for these rather than wrapping in another
> ifdef, that is the recommended way to do this

No objections, that would work as well.
