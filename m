Return-Path: <SRS0=fqu/=3Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4E748C35249
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 04:14:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 23C3721582
	for <linux-kernel@archiver.kernel.org>; Wed,  5 Feb 2020 04:14:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="NXwQDWNR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727920AbgBEEOx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Feb 2020 23:14:53 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:51183 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727832AbgBEEOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Feb 2020 23:14:53 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580876092; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=mFggojvO9f3G3VuMRvXmpQHB4tK1ztWgPh7NXm+Cy0E=; b=NXwQDWNRDcFhomxHZCrDSV3y2gvqbOgNS0UoMqtWRP8htthqxhdltSUkvkWWkeL3Q2jjScHF
 T8s7noB0fJ/VPbHtsQRI+qqatFLl7SwothdW+SZ/GWybLIAqJ6Ur07H/8CuD+xJl7w9fEm13
 +pe/y0HvEcqNrotKA4EAf9s1O60=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3a4138.7f291dc1b768-smtp-out-n03;
 Wed, 05 Feb 2020 04:14:48 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 2855EC433CB; Wed,  5 Feb 2020 04:14:47 +0000 (UTC)
Received: from [10.206.13.37] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 87064C43383;
        Wed,  5 Feb 2020 04:14:43 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 87064C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
Subject: Re: [PATCH 1/3] soc: qcom: rpmh: Update dirty flag only when data
 changes
To:     Evan Green <evgreen@chromium.org>
Cc:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Doug Anderson <dianders@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
References: <1580796831-18996-1-git-send-email-mkshah@codeaurora.org>
 <1580796831-18996-2-git-send-email-mkshah@codeaurora.org>
 <CAE=gft6DCqmX8=cHWXNeOjSTuRHL23t7+b_GZOrvUJAPfhVD8A@mail.gmail.com>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <d95de83d-fbda-5ebf-1b87-126c19f4d604@codeaurora.org>
Date:   Wed, 5 Feb 2020 09:44:41 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAE=gft6DCqmX8=cHWXNeOjSTuRHL23t7+b_GZOrvUJAPfhVD8A@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/5/2020 6:05 AM, Evan Green wrote:
> On Mon, Feb 3, 2020 at 10:14 PM Maulik Shah <mkshah@codeaurora.org> wrote:
>> Currently rpmh ctrlr dirty flag is set for all cases regardless
>> of data is really changed or not.
>>
>> Add changes to update it when data is updated to new values.
>>
>> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
>> ---
>>   drivers/soc/qcom/rpmh.c | 15 +++++++++++----
>>   1 file changed, 11 insertions(+), 4 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
>> index 035091f..c3d6f00 100644
>> --- a/drivers/soc/qcom/rpmh.c
>> +++ b/drivers/soc/qcom/rpmh.c
>> @@ -139,20 +139,27 @@ static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
>>   existing:
>>          switch (state) {
>>          case RPMH_ACTIVE_ONLY_STATE:
>> -               if (req->sleep_val != UINT_MAX)
>> +               if (req->sleep_val != UINT_MAX) {
>>                          req->wake_val = cmd->data;
>> +                       ctrlr->dirty = true;
>> +               }
> Don't you need to set dirty = true for ACTIVE_ONLY state always? The
> conditional is just saying "if nobody set a sleep vote, then maintain
> this vote when we wake back up".

The ACTIVE_ONLY vote is cached as wake_val to be apply when wakeup happens.

In case value didn't change,wake_val is still same as older value and 
there is no need to mark the entire cache as dirty.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
