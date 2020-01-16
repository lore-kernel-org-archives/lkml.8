Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 21161C3F68F
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:57:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id EBC88207FF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 15:57:17 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726973AbgAPP5Q (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 10:57:16 -0500
Received: from mga14.intel.com ([192.55.52.115]:54160 "EHLO mga14.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726741AbgAPP5Q (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 10:57:16 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga003.fm.intel.com ([10.253.24.29])
  by fmsmga103.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 16 Jan 2020 07:57:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,326,1574150400"; 
   d="scan'208";a="274042229"
Received: from frederic-mobl1.amr.corp.intel.com (HELO [10.251.150.187]) ([10.251.150.187])
  by FMSMGA003.fm.intel.com with ESMTP; 16 Jan 2020 07:57:14 -0800
Subject: Re: [alsa-devel] [PATCH] soundwire: cadence: fix kernel-doc parameter
 descriptions
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20200114233124.13888-1-pierre-louis.bossart@linux.intel.com>
 <20200116120459.GP2818@vkoul-mobl> <20200116120918.GR2818@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <bd2dc7aa-d626-6efc-9ba2-9212a23855c4@linux.intel.com>
Date:   Thu, 16 Jan 2020 08:27:13 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200116120918.GR2818@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/16/20 6:09 AM, Vinod Koul wrote:
> On 16-01-20, 17:35, Vinod Koul wrote:
>> On 14-01-20, 17:31, Pierre-Louis Bossart wrote:
>>> Fix previous update, bad git merge likely. oops.
>>
>> Applied, thanks
> 
> Btw I still have these warns on my next with W=1
> 
> drivers/soundwire/intel_init.c:193:7: warning: no previous prototype for ‘sdw_intel_init’ [-Wmissing-prototypes]
>   void *sdw_intel_init(acpi_handle *parent_handle, struct sdw_intel_res *res)
>         ^~~~~~~~~~~~~~
> drivers/soundwire/cadence_master.c:1022: warning: Function parameter or member 'clock_stop_exit' not described in 'sdw_cdns_init'
>    LD [M]  drivers/soundwire/soundwire-cadence.o
> drivers/soundwire/intel_init.c:214: warning: Function parameter or member 'ctx' not described in 'sdw_intel_exit'
> drivers/soundwire/intel_init.c:214: warning: Excess function parameter 'arg' description in 'sdw_intel_exit'

All of this is replaced by new code already submitted for review. try 
our SOF upstream/soundwire branch and you'll see.
