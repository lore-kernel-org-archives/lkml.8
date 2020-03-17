Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 08927C10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:32:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C76DF206EC
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 15:32:38 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726738AbgCQPch (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 11:32:37 -0400
Received: from mga18.intel.com ([134.134.136.126]:12705 "EHLO mga18.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726019AbgCQPch (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 11:32:37 -0400
IronPort-SDR: WrOyJMVk9110BS9P+wpTelS5oToTZEWCOS7vJv1YFyUq9HKFjcUEIXIYPcJh7q74Yy48CnFV3u
 Ed++G/cgKDig==
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from fmsmga004.fm.intel.com ([10.253.24.48])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Mar 2020 08:32:36 -0700
IronPort-SDR: AlObTxabHgmiM6Jn3ywAh/Yt0oaBfUo/bqhYV9hSVEb6s6cToF6f79VnvrY/w1+8SKKs8wIUcS
 rEU7Bof4w0Eg==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.70,564,1574150400"; 
   d="scan'208";a="268002291"
Received: from atthomas-mobl.amr.corp.intel.com (HELO [10.255.32.45]) ([10.255.32.45])
  by fmsmga004.fm.intel.com with ESMTP; 17 Mar 2020 08:32:33 -0700
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
 <6dde3b32-a29a-3ac9-d95d-283f5b05e64a@linux.intel.com>
 <7c7b334d-ae5c-35f6-9cf3-04700677211f@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <7a362c6a-364e-499a-e841-0a919f48bf84@linux.intel.com>
Date:   Tue, 17 Mar 2020 10:31:29 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <7c7b334d-ae5c-35f6-9cf3-04700677211f@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> The change below would be an error case for Intel, so it's probably 
>>>> better if we go with your suggestion. You have a very specific state 
>>>> handling due to your power amps and it's probably better to keep it 
>>>> platform-specific.
>>>
>>> Just trying to understand, why would it be error for Intel case?
>>>
>>> IMO, If stream state is SDW_STREAM_ENABLED that also implicit that 
>>> its prepared too. Similar thing with SDW_STREAM_DEPREPARED.
>>> Isn't it?
>>
>> the stream state is a scalar value, not a mask. The state machine only 
>> allows transition from CONFIGURED TO PREPARED or from DEPREPARED TO 
>> PREPARED, or DISABLED to PREPARED.
>> There is no allowed transition from ENABLED TO PREPARED, you have to 
>> go through the DISABLED state and make sure a bank switch occurred, 
>> and re-do a bank switch to prepare again.
> I agree with you if are on single dai case. Am happy to move to stream 
> handling to machine driver for now.
> 
> But this also means that in cases like multi-codec its not recommended 
> to call sdw_prepare and sdw_enable in a single function from codec.
> Which might be worth documenting.

Well, the bigger question is why use sdw_stream functions at the codec 
level in the first place? All other codec drivers seem to have no issue 
leaving the dais owned by the master control stream state changes.

I am not saying I object or it's bad, just that there were significant 
changes in usages of the 'stream' concept since it was introduced, as 
well as threads in MIPI circles to clarify the prepare/enable 
dependencies, so it'd be useful to have a complete picture of what 
different platforms need/want.
