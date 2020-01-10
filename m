Return-Path: <SRS0=n6RB=27=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DA30C282DD
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:35:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3E786205F4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jan 2020 16:35:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728648AbgAJQfV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 11:35:21 -0500
Received: from mga09.intel.com ([134.134.136.24]:2757 "EHLO mga09.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728494AbgAJQfV (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 11:35:21 -0500
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga003.jf.intel.com ([10.7.209.27])
  by orsmga102.jf.intel.com with ESMTP/TLS/DHE-RSA-AES256-GCM-SHA384; 10 Jan 2020 08:35:20 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.69,417,1571727600"; 
   d="scan'208";a="224242394"
Received: from nehudak-mobl1.amr.corp.intel.com (HELO [10.251.145.164]) ([10.251.145.164])
  by orsmga003.jf.intel.com with ESMTP; 10 Jan 2020 08:35:19 -0800
Subject: Re: [alsa-devel] [PATCH v5 2/2] soundwire: qcom: add support for
 SoundWire controller
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        vkoul@kernel.org
Cc:     robh@kernel.org, alsa-devel@alsa-project.org,
        bgoswami@codeaurora.org, spapothi@codeaurora.org,
        lgirdwood@gmail.com, linux-kernel@vger.kernel.org,
        broonie@kernel.org
References: <20191219092842.10885-1-srinivas.kandagatla@linaro.org>
 <20191219092842.10885-3-srinivas.kandagatla@linaro.org>
 <c791e241-cd71-4c05-dac5-04e3ecaaf995@linux.intel.com>
 <a5315861-d9b8-0852-8a3a-012f60cc3a44@linaro.org>
 <4dab7ee8-dc0e-bf61-24db-3e227c459575@linaro.org>
From:   Pierre-Louis Bossart <pierre-louis.bossart@linux.intel.com>
Message-ID: <94aefed4-9f0d-f81a-b5c0-0ad4cafc6a96@linux.intel.com>
Date:   Fri, 10 Jan 2020 10:35:19 -0600
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <4dab7ee8-dc0e-bf61-24db-3e227c459575@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


>>>> +    if (sts & SWRM_INTERRUPT_STATUS_CMD_ERROR) {
>>>> +        ctrl->reg_read(ctrl, SWRM_CMD_FIFO_STATUS, &value);
>>>> +        dev_err_ratelimited(ctrl->dev,
>>>> +                    "CMD error, fifo status 0x%x\n",
>>>> +                     value);
>>>> +        ctrl->reg_write(ctrl, SWRM_CMD_FIFO_CMD, 0x1);
>>>> +    }
>>>> +
>>>> +    if ((sts & SWRM_INTERRUPT_STATUS_NEW_SLAVE_ATTACHED) ||
>>>> +        sts & SWRM_INTERRUPT_STATUS_CHANGE_ENUM_SLAVE_STATUS)
>>>> +        schedule_work(&ctrl->slave_work);
>>>> +
>>>> +    ctrl->reg_write(ctrl, SWRM_INTERRUPT_CLEAR, sts);
>>>
>>> is it intentional to clear the interrupts first, before doing 
>>> additional checks?
>>>
>>
>> No, I can move it to right to the end!
> 
> Reason why I did this was that if we run complete() before irq is 
> cleared complete might trigger another read/write which can raise an 
> interrupt. And with interrupt status not cleared we might miss it. This 
> is very much timing dependent specially with the threaded irq.
> 
> So code needs no change atm!

ok, a comment to keep track of this timing dependency could help future 
generations then...
