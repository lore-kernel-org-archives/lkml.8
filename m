Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EBC72C83006
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:29:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C9F3B206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 17:29:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="HZyYwtb2"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726910AbgD2R3h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 13:29:37 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:12045 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726524AbgD2R3g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 13:29:36 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588181376; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=Xp/0lr40wfL33pzbo6BAF3q5KzIJcGKl6bxJ0pSGH3E=; b=HZyYwtb2+83fvX9Rhv8igus7NqBL+fHXBN1IE9R4zSmhzeqybvcyYk25RPMO+4G9IHkQPeD5
 Txx+Dvk2Uut47nNo2bVDz4fyUc9oK+tPh6runj50meKrb/+n7ZvRxyH4lwPXZ8j8hwBqs92S
 1y1yNgeemJe9nSvdkSRvOJfPrHk=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea9b97f.7f04b832e298-smtp-out-n04;
 Wed, 29 Apr 2020 17:29:35 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 716BCC433D2; Wed, 29 Apr 2020 17:29:34 +0000 (UTC)
Received: from [10.46.162.249] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hemantk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id CE65CC433CB;
        Wed, 29 Apr 2020 17:29:33 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org CE65CC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=hemantk@codeaurora.org
Subject: Re: [PATCH v2 2/8] bus: mhi: core: Add range check for channel id
 received in event ring
To:     Jeffrey Hugo <jhugo@codeaurora.org>,
        Bhaumik Bhatt <bbhatt@codeaurora.org>, mani@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <1588042766-17496-1-git-send-email-bbhatt@codeaurora.org>
 <1588042766-17496-3-git-send-email-bbhatt@codeaurora.org>
 <5dfa3617-644c-42c3-0dfe-4f9f4a6d5ded@codeaurora.org>
From:   Hemant Kumar <hemantk@codeaurora.org>
Message-ID: <0e889174-4264-5911-ce6f-d2b6084a22a8@codeaurora.org>
Date:   Wed, 29 Apr 2020 10:29:33 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <5dfa3617-644c-42c3-0dfe-4f9f4a6d5ded@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Jeff

On 4/28/20 7:44 AM, Jeffrey Hugo wrote:
> On 4/27/2020 8:59 PM, Bhaumik Bhatt wrote:
>> From: Hemant Kumar <hemantk@codeaurora.org>
>>
>> MHI data completion handler function reads channel id from event
>> ring element. Value is under the control of MHI devices and can be
>> any value between 0 and 255. In order to prevent out of bound access
>> add a bound check against the max channel supported by controller
>> and skip processing of that event ring element.
>>
>> Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
>> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
>> ---
>>   drivers/bus/mhi/core/main.c | 4 ++++
>>   1 file changed, 4 insertions(+)
>>
>> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
>> index 23154f1..1ccd4cc 100644
>> --- a/drivers/bus/mhi/core/main.c
>> +++ b/drivers/bus/mhi/core/main.c
>> @@ -827,6 +827,9 @@ int mhi_process_data_event_ring(struct 
>> mhi_controller *mhi_cntrl,
>>           enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
>>           chan = MHI_TRE_GET_EV_CHID(local_rp);
>> +        if (WARN_ON(chan >= mhi_cntrl->max_chan))
>> +            goto next_event;
>> +
>>           mhi_chan = &mhi_cntrl->mhi_chan[chan];
>>           if (likely(type == MHI_PKT_TYPE_TX_EVENT)) {
>> @@ -837,6 +840,7 @@ int mhi_process_data_event_ring(struct 
>> mhi_controller *mhi_cntrl,
>>               event_quota--;
>>           }
>> +next_event:
>>           mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
>>           local_rp = ev_ring->rp;
>>           dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
>>
> 
> It looks like the same issue exists in mhi_process_ctrl_ev_ring(), and 
> thus some form of this solution needs to be applied there as well. Would 
> you please fix that too?
> 
As discussed with you off line, spec allows to have just event ring to 
be used for both data and control. Updating this in V3.

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
