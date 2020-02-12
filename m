Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66387C2BA83
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:41:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3A63720675
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 11:41:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="stZDqEXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728021AbgBLLlo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 06:41:44 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:30898 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725781AbgBLLlo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 06:41:44 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581507703; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=tIoYrRRSOlI3zyCvTygKC57YOxbVL6cYX+0E0hEni48=; b=stZDqEXzJ3nl9YbOWVpCa17EvhjOnGxOK9dfsz+M/WkJumqsiA8AmM2Rw6gnfn2U9tCGwTPM
 370v6oB2R13UvQa8Uhn1VGenUQFYiLMcSzVf7UV1z1vA4ok0i6ykF9MIFpTVeY5CBlKf8OWp
 23P2o9RGR6gFxULHgbRvzCdIdiU=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e43e473.7f4a60268df8-smtp-out-n02;
 Wed, 12 Feb 2020 11:41:39 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 41889C4479C; Wed, 12 Feb 2020 11:41:38 +0000 (UTC)
Received: from [10.206.13.37] (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C0524C43383;
        Wed, 12 Feb 2020 11:41:34 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C0524C43383
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
 <d95de83d-fbda-5ebf-1b87-126c19f4d604@codeaurora.org>
 <CAE=gft7ESnpS8bYg4hmoAUtsuLiyek1D-AYEL+LWUKe=KubAJw@mail.gmail.com>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <4e54da6a-3418-7f06-818c-7d87443b5253@codeaurora.org>
Date:   Wed, 12 Feb 2020 17:11:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.2
MIME-Version: 1.0
In-Reply-To: <CAE=gft7ESnpS8bYg4hmoAUtsuLiyek1D-AYEL+LWUKe=KubAJw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 2/5/2020 11:37 PM, Evan Green wrote:
> On Tue, Feb 4, 2020 at 8:14 PM Maulik Shah <mkshah@codeaurora.org> wrote:
>>
>> On 2/5/2020 6:05 AM, Evan Green wrote:
>>> On Mon, Feb 3, 2020 at 10:14 PM Maulik Shah <mkshah@codeaurora.org> wrote:
>>>> Currently rpmh ctrlr dirty flag is set for all cases regardless
>>>> of data is really changed or not.
>>>>
>>>> Add changes to update it when data is updated to new values.
>>>>
>>>> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
>>>> ---
>>>>    drivers/soc/qcom/rpmh.c | 15 +++++++++++----
>>>>    1 file changed, 11 insertions(+), 4 deletions(-)
>>>>
>>>> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
>>>> index 035091f..c3d6f00 100644
>>>> --- a/drivers/soc/qcom/rpmh.c
>>>> +++ b/drivers/soc/qcom/rpmh.c
>>>> @@ -139,20 +139,27 @@ static struct cache_req *cache_rpm_request(struct rpmh_ctrlr *ctrlr,
>>>>    existing:
>>>>           switch (state) {
>>>>           case RPMH_ACTIVE_ONLY_STATE:
>>>> -               if (req->sleep_val != UINT_MAX)
>>>> +               if (req->sleep_val != UINT_MAX) {
>>>>                           req->wake_val = cmd->data;
>>>> +                       ctrlr->dirty = true;
>>>> +               }
>>> Don't you need to set dirty = true for ACTIVE_ONLY state always? The
>>> conditional is just saying "if nobody set a sleep vote, then maintain
>>> this vote when we wake back up".
>> The ACTIVE_ONLY vote is cached as wake_val to be apply when wakeup happens.
>>
>> In case value didn't change,wake_val is still same as older value and
>> there is no need to mark the entire cache as dirty.
>>
> Ah, I see it now. We don't actually cache active_only votes anywhere,
> since they're one time requests. The sleep/wake votes seem to be the
> only thing that gets cached.
>
> I was thinking it might be safer to also set dirty = true just after
> list_add_tail, since in the non-existing case this is a new batch that
> RPMh has never seen before and should always be written. But I suppose
> your checks here should cover that case, since sleep_val and wake_val
> are initialized to UINT_MAX. If you think the code might evolve, it
> might still be nice to add it.
current change seems good.
>
> While I'm looking at that, why do we have this needless INIT_LIST_HEAD?
>          INIT_LIST_HEAD(&req->list);
>          list_add_tail(&req->list, &ctrlr->cache);
>
> -Evan

Thanks for pointing this, i will remove this unnecessary INIT in next 
revision.

>
>> --
>> QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
