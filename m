Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 273CFC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:00:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 083172070B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 19:00:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731315AbgEKTAO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 15:00:14 -0400
Received: from mga05.intel.com ([192.55.52.43]:8546 "EHLO mga05.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1731014AbgEKTAN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 15:00:13 -0400
IronPort-SDR: dky4Y82KMqtHnCxmB6pd8U51t9Kv17sSS/9XuMFWt+HD9F0Ou6jSW9Xz36rg5n0mk/xNTqUT+6
 O16oi/N9tOTA==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 11 May 2020 12:00:13 -0700
IronPort-SDR: UriJ4Mj+W1dUj4SAvvtpUe2eoHnCT1YifIAyVeIXqTp9uaMsPTUvo4cyNtBzMjm2ajwrhM0nUr
 FrG7Q4XFCzEQ==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.73,381,1583222400"; 
   d="scan'208";a="261861655"
Received: from unknown (HELO [10.254.66.92]) ([10.254.66.92])
  by orsmga003.jf.intel.com with ESMTP; 11 May 2020 12:00:11 -0700
Subject: Re: [PATCH 3/3] soundwire: bus_type: add sdw_master_device support
To:     Vinod Koul <vkoul@kernel.org>,
        Bard Liao <yung-chuan.liao@linux.intel.com>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        ranjani.sridharan@linux.intel.com, hui.wang@canonical.com,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, mengdong.lin@intel.com,
        slawomir.blauciak@intel.com, sanyog.r.kale@intel.com,
        rander.wang@linux.intel.com, bard.liao@intel.com
References: <20200429185145.12891-1-yung-chuan.liao@linux.intel.com>
 <20200429185145.12891-4-yung-chuan.liao@linux.intel.com>
 <20200511063227.GS1375924@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <e214d308-1b92-a7a5-3c76-da05dca99cc5@linux.intel.com>
Date:   Mon, 11 May 2020 14:00:11 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200511063227.GS1375924@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org




>> +	md = &bus->md;
>> +	md->dev.bus = &sdw_bus_type;
>> +	md->dev.type = &sdw_master_type;
>> +	md->dev.parent = parent;
>> +	md->dev.of_node = parent->of_node;
>> +	md->dev.fwnode = fwnode;
>> +	md->dev.dma_mask = parent->dma_mask;
>> +
>> +	dev_set_name(&md->dev, "sdw-master-%d", bus->link_id);
> 
> This give nice sdw-master-0. In DT this comes from reg property. I dont
> seem to recall if the ACPI/Disco spec treats link_id as unique across
> the system, can you check that please, if not we would need to update
> this.
Table 3 in the Disco for Soundwire 1.0 spec: "all LinkID values are 
relative to the immediate parent Device."

There isn't any known implementation with more than one controller.
