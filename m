Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB4B1C18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:24:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A99E620714
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 14:24:49 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726207AbgCQOYs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 10:24:48 -0400
Received: from mga02.intel.com ([134.134.136.20]:53607 "EHLO mga02.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726761AbgCQOYr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 10:24:47 -0400
IronPort-SDR: 2B/RkiUm3Rk15f7MbQaikyUo4iUrP3x+TqXsFf1LYIH6K7YohyYyYTrmdXPXvPetKQLbNbEWah
 EoOaLNAPooRQ==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga006.jf.intel.com ([10.7.209.51])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 07:24:46 -0700
IronPort-SDR: z6tRhruIKRbKwnps9QQqh/kGaQsiaTyf8oiJ8dlyOzVcUcsrY4SHRb4A2gd41wBHxfUDFy0ulP
 6FsHsJT5mGrA==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,564,1574150400"; 
   d="scan'208";a="247835629"
Received: from dasabhi1-mobl.amr.corp.intel.com (HELO [10.255.35.148]) ([10.255.35.148])
  by orsmga006.jf.intel.com with ESMTP; 17 Mar 2020 07:24:44 -0700
Subject: Re: [PATCH] soundwire: stream: only change state if needed
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        alsa-devel@alsa-project.org
Cc:     linux-kernel@vger.kernel.org, tiwai@suse.de, broonie@kernel.org,
        vkoul@kernel.org, gregkh@linuxfoundation.org, jank@cadence.com,
        slawomir.blauciak@intel.com,
        Bard liao <yung-chuan.liao@linux.intel.com>,
        Rander Wang <rander.wang@linux.intel.com>,
        Ranjani Sridharan <ranjani.sridharan@linux.intel.com>,
        Hui Wang <hui.wang@canonical.com>,
        Sanyog Kale <sanyog.r.kale@intel.com>
References: <20200317105142.4998-1-pierre-louis.bossart@linux.intel.com>
 <6bc8412a-f6d9-64d1-2218-ca98cfdb31c0@linaro.org>
 <27a73cbd-9418-4488-5cb2-fb21f9fc9110@linux.intel.com>
 <c1e5dc89-a069-a427-4912-89d90ecc0334@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <6dde3b32-a29a-3ac9-d95d-283f5b05e64a@linux.intel.com>
Date:   Tue, 17 Mar 2020 08:19:34 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <c1e5dc89-a069-a427-4912-89d90ecc0334@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/17/20 8:04 AM, Srinivas Kandagatla wrote:
> 
> 
> On 17/03/2020 12:22, Pierre-Louis Bossart wrote:
>>
>> The change below would be an error case for Intel, so it's probably 
>> better if we go with your suggestion. You have a very specific state 
>> handling due to your power amps and it's probably better to keep it 
>> platform-specific.
> 
> Just trying to understand, why would it be error for Intel case?
> 
> IMO, If stream state is SDW_STREAM_ENABLED that also implicit that its 
> prepared too. Similar thing with SDW_STREAM_DEPREPARED.
> Isn't it?

the stream state is a scalar value, not a mask. The state machine only 
allows transition from CONFIGURED TO PREPARED or from DEPREPARED TO 
PREPARED, or DISABLED to PREPARED.
There is no allowed transition from ENABLED TO PREPARED, you have to go 
through the DISABLED state and make sure a bank switch occurred, and 
re-do a bank switch to prepare again.
