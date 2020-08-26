Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9E632C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:40:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 81FB8206F0
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 14:40:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727000AbgHZOka (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 10:40:30 -0400
Received: from mga11.intel.com ([192.55.52.93]:3727 "EHLO mga11.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726874AbgHZOkW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 10:40:22 -0400
IronPort-SDR: ddinD+VX9dI5epistoKIqeEZXli0yYGOb2v+mSGsIYgUSJsxQcZMVzvbGxm0d6PkdZ6YwnIAtQ
 VmaYvuTfkGFw==
X-IronPort-AV: E=McAfee;i="6000,8403,9725"; a="153869866"
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="153869866"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 07:40:22 -0700
IronPort-SDR: 3qQWmHAeoyu+Ah83AqVvZtMwmiF0fwP9YBedaITiYvRLqQEMSxRS2DLLjiu+Bf2T0sqk4dB+OS
 AK/EvdCcWAvQ==
X-IronPort-AV: E=Sophos;i="5.76,356,1592895600"; 
   d="scan'208";a="299494867"
Received: from gillelas-mobl1.amr.corp.intel.com (HELO [10.255.231.51]) ([10.255.231.51])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 26 Aug 2020 07:40:20 -0700
Subject: Re: [PATCH 07/11] soundwire: intel: Only call sdw stream APIs for the
 first cpu_dai
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        rander.wang@linux.intel.com, ranjani.sridharan@linux.intel.com,
        hui.wang@canonical.com, sanyog.r.kale@intel.com,
        mengdong.lin@intel.com, bard.liao@intel.com
References: <20200818024120.20721-1-yung-chuan.liao@linux.intel.com>
 <20200818024120.20721-8-yung-chuan.liao@linux.intel.com>
 <20200826094636.GB2639@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <5a7b75e5-4d64-9927-df81-68164ef2662a@linux.intel.com>
Date:   Wed, 26 Aug 2020 09:35:19 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200826094636.GB2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>> -	ret = sdw_prepare_stream(dma->stream);
>> +	/*
>> +	 * All cpu dais belong to a stream. To ensure sdw_prepare_stream
>> +	 * is called once per stream, we should call it only when
>> +	 * dai = first_cpu_dai.
>> +	 */
>> +	if (first_cpu_dai == dai)
>> +		ret = sdw_prepare_stream(dma->stream);
> 
> Hmmm why not use the one place which is unique in the card to call this,
> hint machine dais are only called once.

we are already calling directly sdw_startup_stream() and 
sdw_shutdown_stream() from the machine driver.

We could call sdw_stream_enable() in the dailink .trigger as well, since 
it only calls the stream API.

However for both .prepare() and .hw_free() there are a set of dai-level 
configurations using static functions defined only in intel.c, and I 
don't think we can move the code to the machine driver, or split the 
prepare/hw_free in two (dailink and dai operations).

I am not against your idea, I am not sure if it can be done.

Would you be ok to merge this as a first step and let us work on an 
optimization later (which would require ASoC/SoundWire synchronization)?


