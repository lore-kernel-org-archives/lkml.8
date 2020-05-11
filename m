Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3555FC47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:26:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 10172206D7
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:26:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730826AbgEKR0J (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:26:09 -0400
Received: from foss.arm.com ([217.140.110.172]:36646 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729698AbgEKR0J (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:26:09 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 658B930E;
        Mon, 11 May 2020 10:26:08 -0700 (PDT)
Received: from [10.37.12.116] (unknown [10.37.12.116])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 2C3493F305;
        Mon, 11 May 2020 10:26:00 -0700 (PDT)
Subject: Re: [PATCH] coresight: platform: use dev_warn instead of
 dev_warn_once
To:     mathieu.poirier@linaro.org, kathirav@codeaurora.org
Cc:     mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1588933721-18700-1-git-send-email-kathirav@codeaurora.org>
 <20200511165851.GB13202@xps15>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <2d59194a-2785-8762-81cd-bef34c6a51ec@arm.com>
Date:   Mon, 11 May 2020 18:31:04 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200511165851.GB13202@xps15>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/11/2020 05:58 PM, Mathieu Poirier wrote:
> Hi Kathiravan,
> 
> On Fri, May 08, 2020 at 03:58:41PM +0530, Kathiravan T wrote:
>> When more than one coresight components uses the obsolete DT bindings,
>> warning is displayed for only one component and not for the others.
>> Lets warn it for all components by replacing dev_warn_once with dev_warn.
>>
>> Signed-off-by: Kathiravan T <kathirav@codeaurora.org>
>> ---
>>   drivers/hwtracing/coresight/coresight-platform.c | 2 +-
>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>
>> diff --git a/drivers/hwtracing/coresight/coresight-platform.c b/drivers/hwtracing/coresight/coresight-platform.c
>> index 43418a2..b7d9a02 100644
>> --- a/drivers/hwtracing/coresight/coresight-platform.c
>> +++ b/drivers/hwtracing/coresight/coresight-platform.c
>> @@ -284,7 +284,7 @@ static int of_get_coresight_platform_data(struct device *dev,
>>   	if (!parent) {
>>   		legacy_binding = true;
>>   		parent = node;
>> -		dev_warn_once(dev, "Uses obsolete Coresight DT bindings\n");
>> +		dev_warn(dev, "Uses obsolete Coresight DT bindings\n");
> 
> We made a concious decision to use dev_warn_once() rather than dev_warn().
> There can be a lot of coresight devices on a platform and warning for every
> device doesn't do anything more than adding noise.
> 
> If one device is using obsolete bindings the others very likely to do so as
> well.  While fixing one device, checking the remaining devices should be
> intuitive.

Exactly ! Or someone could repeat the process until all are fixed ;-)

Cheers
Suzuki
