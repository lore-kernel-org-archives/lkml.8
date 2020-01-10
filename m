Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5541AC282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:24:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2187520721
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:24:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728581AbgAJQYT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:24:19 -0500
Received: from mga03.intel.com ([134.134.136.65]:7769 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728480AbgAJQYT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:24:19 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 08:24:18 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,417,1571727600"; 
   d="scan'208";a="224240060"
Received: from nehudak-mobl1.amr.corp.intel.com (HELO [10.251.145.164]) ([10.251.145.164])
  by orsmga003.jf.intel.com with ESMTP; 10 Jan 2020 08:24:11 -0800
Subject: Re: [alsa-devel] [PATCH 6/6] soundwire: stream: don't program ports
 for a stream that has not been prepared
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, linux-kernel@vger.kernel.org,
        tiwai@suse.de, broonie@kernel.org, gregkh@linuxfoundation.org,
        jank@cadence.com, srinivas.kandagatla@linaro.org,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Rander Wang <rander.wang@intel.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20200108175438.13121-1-pierre-louis.bossart@linux.intel.com>
 <20200108175438.13121-7-pierre-louis.bossart@linux.intel.com>
 <20200110070321.GA2818@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0553dba8-6a08-93c7-d0d5-4d2ca6a67f56@linux.intel.com>
Date:   Fri, 10 Jan 2020 10:24:10 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200110070321.GA2818@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




>> GitHub issue: https://github.com/thesofproject/linux/issues/1637
> 
> This is not relevant for kernel, pls remove

Why? it's not uncommon to have bugzilla links, why would we lose the 
publicly-available information because GitHub is used?

>>   	list_for_each_entry(m_rt, &bus->m_rt_list, bus_node) {
>> +
>> +		/*
>> +		 * this loop walks through all master runtimes for a
>> +		 * bus, but the ports can only be configured while
>> +		 * explicitly preparing a stream or handling an
>> +		 * already-prepared stream otherwise.
> 
> we can go upto 80 chars, make sure you align the above comment block as
> such

this is formatted by emacs, and with long words you get spaces at the end.

>>   		/* Program params */
>> -		ret = sdw_program_params(bus);
>> +		ret = sdw_program_params(bus, false);
> 
> Can you do a converse test as well, when the streams are running and
> concurrently two stream are stopped, it would be good to get it confirmed...

we cannot concurrently stop two streams since we take a bus lock. That's 
a problem but it'll have to be addressed separately. the problem with 
multiple streams addressed here is when one is CONFIGURED, which does 
not require a bus lock.
