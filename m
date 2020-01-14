Return-Path: <SRS0=z1XV=3D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55DB0C33C9E
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:48:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A34324658
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jan 2020 17:48:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728905AbgANRs3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jan 2020 12:48:29 -0500
Received: from mga03.intel.com ([134.134.136.65]:37596 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728874AbgANRs0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jan 2020 12:48:26 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga103.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 14 Jan 2020 09:48:26 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,319,1574150400"; 
   d="scan'208";a="225285567"
Received: from snathamg-mobl.amr.corp.intel.com (HELO [10.252.136.159]) ([10.252.136.159])
  by orsmga003.jf.intel.com with ESMTP; 14 Jan 2020 09:48:24 -0800
Subject: Re: [alsa-devel] [PATCH] soundwire: bus: fix device number leak on
 errors
To:     Vinod Koul <vkoul@kernel.org>
Cc:     alsa-devel@alsa-project.org, tiwai@suse.de,
        gregkh@linuxfoundation.org, linux-kernel@vger.kernel.org,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        broonie@kernel.org, srinivas.kandagatla@linaro.org,
        jank@cadence.com, slawomir.blauciak@intel.com,
        Sanyog Kale <sanyog.r.kale@intel.com>,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>
References: <20200113225637.17313-1-pierre-louis.bossart@linux.intel.com>
 <20200114063738.GG2818@vkoul-mobl>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <0f53a197-bd2d-a181-b39c-5ebe99458eac@linux.intel.com>
Date:   Tue, 14 Jan 2020 10:10:40 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <20200114063738.GG2818@vkoul-mobl>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/14/20 12:37 AM, Vinod Koul wrote:
> On 13-01-20, 16:56, Pierre-Louis Bossart wrote:
>> If the programming of the dev_number fails due to an IO error, a new
>> device_number will be assigned, resulting in a leak.
>>
>> Make sure we only assign a device_number once per Slave device.
> 
> Although I am not sure if this would be a leak, we assign a new num and
> old number should have gotten recycled as they would be unattached
> status.

When you program the device number and it fails, there is still a 
Device0 reporting as attached, so you will loop and try to assign a new 
device number. In this case there is never a transition to UNATTACHED, 
the Slave remains ATTACHED as Device0 until the enumeration succeed with 
a successful non-zero device number.

This only happened to us w/ early prototypes where the PCB routing was 
questionable and the speed too high, but still it's useful to keep this 
device number constant

> Anyway this is good improvement as it helps to debug having same
> dev_num, so Applied, thanks

Thanks.
