Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 147BAC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:46:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A3B0206C0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 10:46:45 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgHDKq2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 06:46:28 -0400
Received: from mga03.intel.com ([134.134.136.65]:56268 "EHLO mga03.intel.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729126AbgHDKpr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 06:45:47 -0400
IronPort-SDR: 0LpYmLK5JTPTFn3wZUkOPdzX33V+C0JuBKqHbR4OswsGJ82HOra6EysTLRqAXR8wm9x5EeIfYY
 oFLTKhW5Of5g==
X-IronPort-AV: E=McAfee;i="6000,8403,9702"; a="152253332"
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="152253332"
X-Amp-Result: SKIPPED(no attachment in message)
X-Amp-File-Uploaded: False
Received: from orsmga002.jf.intel.com ([10.7.209.21])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 04 Aug 2020 03:45:46 -0700
IronPort-SDR: Rgl9HHvb284G3NxyLIBGw23xxbjPjyvfAQA228weCp025Qc9lmQuFYdiE2cRckxYSf6sCAJUAv
 cjD99fux4D/A==
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.75,433,1589266800"; 
   d="scan'208";a="306306680"
Received: from ipu5-build.bj.intel.com (HELO [10.238.232.196]) ([10.238.232.196])
  by orsmga002.jf.intel.com with ESMTP; 04 Aug 2020 03:45:45 -0700
Subject: Re: [PATCH] nvmem: core: add sanity check in nvmem_device_read()
To:     Srinivas Kandagatla <srinivas.kandagatla@linaro.org>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Bingbu Cao <bingbu.cao@intel.com>
Cc:     linux-kernel@vger.kernel.org
References: <1596532436-19073-1-git-send-email-bingbu.cao@intel.com>
 <20200804095815.GF13316@paasikivi.fi.intel.com>
 <0e8d60cf-7f8b-c6ab-4184-b869c16b603e@linaro.org>
From:   Bingbu Cao <bingbu.cao@linux.intel.com>
Message-ID: <48f2d716-dad9-054d-d049-452fa272d53b@linux.intel.com>
Date:   Tue, 4 Aug 2020 18:44:27 +0800
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <0e8d60cf-7f8b-c6ab-4184-b869c16b603e@linaro.org>
Content-Type: text/plain; charset=windows-1252
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 8/4/20 6:03 PM, Srinivas Kandagatla wrote:
> 
> 
> On 04/08/2020 10:58, Sakari Ailus wrote:
>> Hi Bingbu,
>>
>> Thank you for the patch.
>>
>> On Tue, Aug 04, 2020 at 05:13:56PM +0800, Bingbu Cao wrote:
>>> nvmem_device_read() could be called directly once nvmem device
>>> registered, the sanity check should be done before call
>>> nvmem_reg_read() as cell and sysfs read did now.
>>>
>>> Signed-off-by: Bingbu Cao <bingbu.cao@intel.com>
>>> ---
>>>   drivers/nvmem/core.c | 7 +++++++
>>>   1 file changed, 7 insertions(+)
>>>
>>> diff --git a/drivers/nvmem/core.c b/drivers/nvmem/core.c
>>> index 927eb5f6003f..c9a77993f008 100644
>>> --- a/drivers/nvmem/core.c
>>> +++ b/drivers/nvmem/core.c
>>> @@ -1491,6 +1491,13 @@ int nvmem_device_read(struct nvmem_device *nvmem,
>>>       if (!nvmem)
>>>           return -EINVAL;
>>>   +    if (offset >= nvmem->size || bytes < nvmem->word_size)
>>> +        return 0;
>>> +
>>> +    if (bytes + offset > nvmem->size)
>>> +        bytes = nvmem->size - offset;
>>
>> The check is relevant for nvmem_device_write(), too.
>>
>> There are also other ways to access nvmem devices such as nvmem_cell_read
>> and others alike. Should they be considered as well?
> 
> We should probably move these sanity checks to a common place like
> nvmem_reg_read() and nvmem_reg_write(), so the callers need not duplicate the same!
> 
Srini and Sakari, thanks for your review.

Is it OK just return INVAL with simple check like below?

if (bytes + offset > nvmem->size ||
    bytes != round_down(bytes, nvmem->word_size))
        return -EINVAL;


> --srini
> 
>>
>>> +
>>> +    bytes = round_down(bytes, nvmem->word_size);
>>>       rc = nvmem_reg_read(nvmem, offset, buf, bytes);
>>>         if (rc)
>>

-- 
Best regards,
Bingbu Cao
