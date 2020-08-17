Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8FDC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:30:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E361020716
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 14:30:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729009AbgHQOaP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 10:30:15 -0400
Received: from mga03.intel.com ([134.134.136.65]:62633 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728669AbgHQOaG (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 10:30:06 -0400
IronPort-SDR: 96QmUbYVXBUGyNSGOlJ+hwNiLnGI0hZPNnNC71AmxRJjdFy4OJdYgXgOzL0bPUDPJRuuAR3Xqw
 U1QSQ9Ae1kEQ==
X-IronPort-AV: E=McAfee;i="6000,8403,9715"; a="154688690"
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="154688690"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 07:30:04 -0700
IronPort-SDR: rb9oDKBZ7Q6nZ+8PBCrPMVYTd0fot1WnZvQ1lnkpz12w55ZRqXvdhKbos46SyzTXYT2iT4PLxf
 tiCRjcbDK3zQ==
X-IronPort-AV: E=Sophos;i="5.76,322,1592895600"; 
   d="scan'208";a="292450642"
Received: from abhishik-mobl1.amr.corp.intel.com (HELO [10.212.204.20]) ([10.212.204.20])
  by orsmga003-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Aug 2020 07:30:03 -0700
Subject: Re: [PATCH 09/13] soundwire: intel: add CLK_STOP_BUS_RESET support
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, sanyog.r.kale@intel.com,
        slawomir.blauciak@intel.com, mengdong.lin@intel.com,
        bard.liao@intel.com
References: <20200721203723.18305-1-yung-chuan.liao@linux.intel.com>
 <20200721203723.18305-10-yung-chuan.liao@linux.intel.com>
 <20200817114729.GP2639@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <8aac898f-92d3-c907-ebb8-4642a618645b@linux.intel.com>
Date:   Mon, 17 Aug 2020 09:30:02 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200817114729.GP2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




>> +	} else if (clock_stop_quirks & SDW_INTEL_CLK_STOP_BUS_RESET) {
>> +		ret = sdw_cdns_clock_stop(cdns, true);
>> +		if (ret < 0) {
>> +			dev_err(dev, "cannot enable clock stop on suspend\n");
>> +			return ret;
>> +		}
>> +
>> +		ret = sdw_cdns_enable_interrupt(cdns, false);
>> +		if (ret < 0) {
>> +			dev_err(dev, "cannot disable interrupts on suspend\n");
>> +			return ret;
>> +		}
>> +
>> +		ret = intel_link_power_down(sdw);
>> +		if (ret) {
>> +			dev_err(dev, "Link power down failed: %d", ret);
>> +			return ret;
>> +		}
> 
> no cleanup on all the error cases here?

See above the 'else if' test, the clock stop on suspend will be followed 
by a bus reset on resume. this is essentially a complete bus restart.

The only open here is whether we should actually return an error while 
suspending, or just log the error and squelch it. We decided to return 
the status so that the pm_runtime suspend does not proceed: the state 
remains active which is easier to detect than a single line in a dmesg log.
