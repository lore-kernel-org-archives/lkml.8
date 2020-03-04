Return-Path: <SRS0=idZ5=4V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6CDDC3F2CD
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:17:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A785020848
	for <linux-kernel@archiver.kernel.org>; Wed,  4 Mar 2020 15:17:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729487AbgCDPRR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 4 Mar 2020 10:17:17 -0500
Received: from mga11.intel.com ([192.55.52.93]:39909 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726661AbgCDPRR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 4 Mar 2020 10:17:17 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by fmsmga102.fm.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 04 Mar 2020 07:17:09 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,514,1574150400"; 
   d="scan'208";a="387193635"
Received: from hhartana-mobl3.amr.corp.intel.com (HELO [10.251.140.18]) ([10.251.140.18])
  by orsmga004.jf.intel.com with ESMTP; 04 Mar 2020 07:17:07 -0800
Subject: Re: [PATCH 1/8] soundwire: bus_type: add master_device/driver support
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com, Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20200227223206.5020-1-pierre-louis.bossart@linux.intel.com>
 <20200227223206.5020-2-pierre-louis.bossart@linux.intel.com>
 <20200303054136.GP4148@vkoul-mobl>
 <8a04eda6-cbcf-582f-c229-5d6e4557344b@linux.intel.com>
 <20200304095312.GT4148@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <05dbe43c-abf8-9d5a-d808-35bf4defe4ba@linux.intel.com>
Date:   Wed, 4 Mar 2020 09:17:07 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200304095312.GT4148@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



> Were the above lines agreed or not? Do you see driver for master devices
> or not? Greg was okay with as well as these patches but I am not okay
> with the driver part for master, so I would like to see that removed.
> 
> Different reviewers can have different reasons.. I have given bunch of
> reasons here, BUT I have not seen a single technical reason why this
> cannot be done.

With all due respect, I consider Greg as THE reviewer for device/driver 
questions. Your earlier proposal to use platform devices was rejected by 
Greg, and we've lost an entire month in the process, so I am somewhat 
dubious on your proposal not to use a driver.

If you want a technical objection, let me restate what I already mentioned:

If you look at the hierarchy, we have

PCI device -> PCI driver
   soundwire_master_device0
      soundwire_slave(s) -> codec driver
   ...
   soundwire_master_deviceN
      soundwire_slave(s) -> codec driver

You have not explained how I could possibly deal with power management 
without having a driver for the master_device(s). The pm_ops need to be 
inserted in a driver structure, which means we need a driver. And if we 
need a driver, then we might as well have a real driver with .probe 
.remove support, driver_register(), etc.

I really don't see what's broken or unnecessary with these patches.

I would also kindly ask that you stop using exclamation marks and what I 
consider as hostile language. I've asked you multiple times, it's not 
professional, sorry.

Regards
-Pierre

