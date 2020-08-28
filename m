Return-Path: <SRS0=aBbL=CG=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7596EC433E6
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:18:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3FD6C20757
	for <linux-kernel@archiver.kernel.org>; Fri, 28 Aug 2020 15:18:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728261AbgH1PS0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 28 Aug 2020 11:18:26 -0400
Received: from mga01.intel.com ([192.55.52.88]:1987 "EHLO mga01.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726330AbgH1PSS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Aug 2020 11:18:18 -0400
IronPort-SDR: gG/jxwuNTeWg7Mi0d+u9H/cus6cXVA2KxWDml8wTNAFijhQC3w9x8sOrovFJHAT+GR8RsQZe6/
 MycdTMwavn0g==
X-IronPort-AV: E=McAfee;i="6000,8403,9727"; a="174732342"
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="174732342"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by fmsmga101.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 08:18:17 -0700
IronPort-SDR: SFp7fwoh3RchKClBFDuKhvS/zyDJ89FB5QdHBT8YxtTTdzyj6eGP06bF4a0Hnwq18on9CEopNw
 z409P3XXfl0A==
X-IronPort-AV: E=Sophos;i="5.76,364,1592895600"; 
   d="scan'208";a="300266451"
Received: from lilymao-mobl.amr.corp.intel.com (HELO [10.209.185.175]) ([10.209.185.175])
  by orsmga006-auth.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 28 Aug 2020 08:18:15 -0700
Subject: Re: [PATCH 4/4] regmap: sdw: add support for SoundWire 1.2 MBQ
To:     Vinod Koul <vkoul@kernel.org>
Cc:     Guennadi Liakhovetski <guennadi.liakhovetski@linux.intel.com>,
        alsa-devel@alsa-project.org,
        Kai Vehmanen <kai.vehmanen@linux.intel.com>,
        "Rafael J. Wysocki" <rafael@kernel.org>, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>, broonie@kernel.org,
        srinivas.kandagatla@linaro.org, jank@cadence.com,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20200825171656.75836-1-pierre-louis.bossart@linux.intel.com>
 <20200825171656.75836-5-pierre-louis.bossart@linux.intel.com>
 <20200826090542.GZ2639@vkoul-mobl>
 <c5119781-bee0-f11b-eb73-cd2da6ab09f5@linux.intel.com>
 <20200828072342.GK2639@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <79ec0d5b-21e9-d54d-1c73-e1007cf493fa@linux.intel.com>
Date:   Fri, 28 Aug 2020 09:49:16 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200828072342.GK2639@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> +#include <linux/mod_devicetable.h>
>>>
>>> Curious why do you need this header?
>>
>> I'll return the question back to you, since you added this header for
>> regmap-sdw.c:
>>
>> 7c22ce6e21840 (Vinod Koul           2018-01-08 15:50:59 +0530  6) #include
>> <linux/mod_devicetable.h>
> 
> Looks like it should be removed :)
> 
> I could compile it without any issues on few archs I do. let me push the
> patch on my tree and see if bots are happy, will send the patch

I already fixed this on my side, will submit next week.
