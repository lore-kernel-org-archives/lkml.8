Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9AE0EC10F27
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:10:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6E9BF2467F
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 11:10:04 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="KimsQRUi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726462AbgCJLKD (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 07:10:03 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:27962 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1725937AbgCJLKC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 07:10:02 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1583838602; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To:
 Subject: From: Sender; bh=Va3n/cJLbQfqQGCh5nSi8Ti3b5OUaE9Hu4OHUP+lYJM=;
 b=KimsQRUiktGsQdHQsRjyaCHai52dO+qLPfWPbI61D1MsYw9/eclKpOTSZSpVWQ+fc87RtqH/
 yIM6+DYwRBTJcWElH8n5R28chscqdTYAEeMS+ISnm4sjQqWnCQRxIjl2kBklwhQQxapoChF2
 ezIzrguYgpJn5tBF2H6V3V3SNP8=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e67757a.7f87c5cede30-smtp-out-n03;
 Tue, 10 Mar 2020 11:09:46 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 29253C432C2; Tue, 10 Mar 2020 11:09:46 +0000 (UTC)
Received: from [192.168.1.2] (unknown [183.83.137.78])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 78BEEC433CB;
        Tue, 10 Mar 2020 11:09:41 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 78BEEC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
Subject: Re: [PATCH v13 3/5] soc: qcom: rpmh: Invalidate SLEEP and WAKE TCSes
 before flushing new data
To:     Doug Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
References: <1583746236-13325-1-git-send-email-mkshah@codeaurora.org>
 <1583746236-13325-4-git-send-email-mkshah@codeaurora.org>
 <CAD=FV=Xkqquyk907zAE-v7_QK_dOSmn1ooTzuXxP5Fckmhaw+Q@mail.gmail.com>
Message-ID: <ba1d108d-8baa-a09e-2678-497acb6d9e9c@codeaurora.org>
Date:   Tue, 10 Mar 2020 16:39:38 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=Xkqquyk907zAE-v7_QK_dOSmn1ooTzuXxP5Fckmhaw+Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/10/2020 5:12 AM, Doug Anderson wrote:
> Hi,
>
> On Mon, Mar 9, 2020 at 2:31 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>> TCSes have previously programmed data when rpmh_flush is called.
>> This can cause old data to trigger along with newly flushed.
>>
>> Fix this by cleaning SLEEP and WAKE TCSes before new data is flushed.
>>
>> With this there is no need to invoke rpmh_rsc_invalidate() call from
>> rpmh_invalidate().
>>
>> Simplify rpmh_invalidate() by moving invalidate_batch() inside.
>>
>> Fixes: 600513dfeef3 ("drivers: qcom: rpmh: cache sleep/wake state requests")
>> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
>> ---
>>  drivers/soc/qcom/rpmh.c | 36 +++++++++++++++---------------------
>>  1 file changed, 15 insertions(+), 21 deletions(-)
>>
>> diff --git a/drivers/soc/qcom/rpmh.c b/drivers/soc/qcom/rpmh.c
>> index 03630ae..5bed8f4 100644
>> --- a/drivers/soc/qcom/rpmh.c
>> +++ b/drivers/soc/qcom/rpmh.c
>> @@ -317,19 +317,6 @@ static int flush_batch(struct rpmh_ctrlr *ctrlr)
>>         return ret;
>>  }
>>
>> -static void invalidate_batch(struct rpmh_ctrlr *ctrlr)
>> -{
>> -       struct batch_cache_req *req, *tmp;
>> -       unsigned long flags;
>> -
>> -       spin_lock_irqsave(&ctrlr->cache_lock, flags);
>> -       list_for_each_entry_safe(req, tmp, &ctrlr->batch_cache, list)
>> -               kfree(req);
>> -       INIT_LIST_HEAD(&ctrlr->batch_cache);
>> -       ctrlr->dirty = true;
>> -       spin_unlock_irqrestore(&ctrlr->cache_lock, flags);
>> -}
>> -
>>  /**
>>   * rpmh_write_batch: Write multiple sets of RPMH commands and wait for the
>>   * batch to finish.
>> @@ -467,6 +454,11 @@ int rpmh_flush(struct rpmh_ctrlr *ctrlr)
>>                 return 0;
>>         }
>>
>> +       /* Invalidate the TCSes first to avoid stale data */
>> +       do {
>> +               ret = rpmh_rsc_invalidate(ctrlr_to_drv(ctrlr));
>> +       } while (ret == -EAGAIN);
>> +
> You forgot to actually check the return value.
>
> if (ret)
>   return ret;
Done.
>
>>         /* First flush the cached batch requests */
>>         ret = flush_batch(ctrlr);
>>         if (ret)
>> @@ -503,19 +495,21 @@ int rpmh_flush(struct rpmh_ctrlr *ctrlr)
>>   *
>>   * @dev: The device making the request
>>   *
>> - * Invalidate the sleep and active values in the TCS blocks.
>> + * Invalidate the sleep and wake values in batch_cache.
> Thanks for updating this.  It was on my todo list.  Can you also
> update the function description, which still says "Invalidate all
> sleep and active sets sets."  While you're at it, remove the double
> "sets".

Done.

Thanks,
Maulik

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
