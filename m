Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1AF26CA90AF
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:36:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6C2520659
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 12:36:48 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="H5yarWF2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732782AbgEMMgs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 08:36:48 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:11556 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1730570AbgEMMgr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 08:36:47 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1589373407; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=1bIACGn3qu0AkWG8WHlzjCsFZPAVF8AVKnV4pu2xA/M=; b=H5yarWF22ABOBdLPa9oeSlDw9aIUgM4j3Y18PEopQS75S6Ws2novxdOuasij4fSGaXcSsTPg
 pLC4Aimazj/RtaqU8Dbe7VyYsUZIFK2TmaCMl26K/G7rNe6qFIromzd2vZGpWQYbpvJoMrr/
 nVnsCMvgPNCY4Q6ibiThoPpyQ78=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ebbe9dc.7f104cbb9260-smtp-out-n01;
 Wed, 13 May 2020 12:36:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C5092C433BA; Wed, 13 May 2020 12:36:43 +0000 (UTC)
Received: from [172.20.10.2] (unknown [106.76.13.20])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: kathirav)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 309E4C433F2;
        Wed, 13 May 2020 12:36:39 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 309E4C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=kathirav@codeaurora.org
Subject: Re: [PATCH] coresight: platform: use dev_warn instead of
 dev_warn_once
To:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        mathieu.poirier@linaro.org
Cc:     mike.leach@linaro.org, alexander.shishkin@linux.intel.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
References: <1588933721-18700-1-git-send-email-kathirav@codeaurora.org>
 <20200511165851.GB13202@xps15> <2d59194a-2785-8762-81cd-bef34c6a51ec@arm.com>
From:   Kathiravan Thirumoorthy <kathirav@codeaurora.org>
Message-ID: <2fda05b0-ed3d-7e48-6fab-2309d8a1ad56@codeaurora.org>
Date:   Wed, 13 May 2020 18:06:36 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <2d59194a-2785-8762-81cd-bef34c6a51ec@arm.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 5/11/2020 11:01 PM, Suzuki K Poulose wrote:
> On 05/11/2020 05:58 PM, Mathieu Poirier wrote:
>> Hi Kathiravan,
>>
>> On Fri, May 08, 2020 at 03:58:41PM +0530, Kathiravan T wrote:
>>> When more than one coresight components uses the obsolete DT bindings,
>>> warning is displayed for only one component and not for the others.
>>> Lets warn it for all components by replacing dev_warn_once with 
>>> dev_warn.
>>>
>>> Signed-off-by: Kathiravan T <kathirav@codeaurora.org>
>>> ---
>>>   drivers/hwtracing/coresight/coresight-platform.c | 2 +-
>>>   1 file changed, 1 insertion(+), 1 deletion(-)
>>>
>>> diff --git a/drivers/hwtracing/coresight/coresight-platform.c 
>>> b/drivers/hwtracing/coresight/coresight-platform.c
>>> index 43418a2..b7d9a02 100644
>>> --- a/drivers/hwtracing/coresight/coresight-platform.c
>>> +++ b/drivers/hwtracing/coresight/coresight-platform.c
>>> @@ -284,7 +284,7 @@ static int of_get_coresight_platform_data(struct 
>>> device *dev,
>>>       if (!parent) {
>>>           legacy_binding = true;
>>>           parent = node;
>>> -        dev_warn_once(dev, "Uses obsolete Coresight DT bindings\n");
>>> +        dev_warn(dev, "Uses obsolete Coresight DT bindings\n");
>>
>> We made a concious decision to use dev_warn_once() rather than 
>> dev_warn().
>> There can be a lot of coresight devices on a platform and warning for 
>> every
>> device doesn't do anything more than adding noise.
>>
>> If one device is using obsolete bindings the others very likely to do 
>> so as
>> well.  While fixing one device, checking the remaining devices should be
>> intuitive.
>
> Exactly ! Or someone could repeat the process until all are fixed ;-)
>
> Cheers
> Suzuki

Thanks Mathieu and Suzuki for the inputs. I shall drop this patch.

Thanks,

Kathiravan T.
