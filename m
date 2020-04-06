Return-Path: <SRS0=Zj89=5W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F3205C2BA18
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 05:13:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id C3B142074F
	for <linux-kernel@archiver.kernel.org>; Mon,  6 Apr 2020 05:13:07 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="nr+vWYNr"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726608AbgDFFNG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 6 Apr 2020 01:13:06 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:23058 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726455AbgDFFNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Apr 2020 01:13:06 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586149985; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=tANryGArsikEbRKGuh59UuK8NiPOtSWy4smmXqPMdlM=; b=nr+vWYNrVnZrtw6o5y31dw36XypTQqgo+/NZVXHnmmYz6wWWr37k/8iIp+4x+q9Z6zwuDXYT
 rVgAOdX7z1zAZ6Dw4PSof787+MqemyqBi/xX1yjAeY36DG66fI3huClWpoj2BLNVGUwMgIPn
 kM9c2r9TUgPPH79y5IiqDIc4CU0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8aba5a.7fdc353a9ed8-smtp-out-n05;
 Mon, 06 Apr 2020 05:12:58 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7911BC43637; Mon,  6 Apr 2020 05:12:58 +0000 (UTC)
Received: from [192.168.43.137] (unknown [106.213.172.166])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 00075C433D2;
        Mon,  6 Apr 2020 05:12:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 00075C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
Subject: Re: [PATCH v15 7/7] soc: qcom: rpmh-rsc: Allow using free WAKE TCS
 for active request
To:     Doug Anderson <dianders@chromium.org>
Cc:     Stephen Boyd <swboyd@chromium.org>,
        Evan Green <evgreen@chromium.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-arm-msm <linux-arm-msm@vger.kernel.org>,
        Andy Gross <agross@kernel.org>,
        Matthias Kaehlcke <mka@chromium.org>,
        Rajendra Nayak <rnayak@codeaurora.org>,
        Lina Iyer <ilina@codeaurora.org>, lsrao@codeaurora.org
References: <1585660782-23416-1-git-send-email-mkshah@codeaurora.org>
 <1585660782-23416-8-git-send-email-mkshah@codeaurora.org>
 <CAD=FV=X_JJWAb9BBkhWGZJ+jUvtO3ipf-OxFRYo38YY25cA42Q@mail.gmail.com>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <dd447c2a-c2b7-c40f-e3e9-27a9ba9614c7@codeaurora.org>
Date:   Mon, 6 Apr 2020 10:42:50 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <CAD=FV=X_JJWAb9BBkhWGZJ+jUvtO3ipf-OxFRYo38YY25cA42Q@mail.gmail.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 4/3/2020 1:43 AM, Doug Anderson wrote:
> Hi,
>
> On Tue, Mar 31, 2020 at 6:21 AM Maulik Shah <mkshah@codeaurora.org> wrote:
>> When there are more than one WAKE TCS available and there is no dedicated
>> ACTIVE TCS available, invalidating all WAKE TCSes and waiting for current
>> transfer to complete in first WAKE TCS blocks using another free WAKE TCS
>> to complete current request.
>>
>> Remove rpmh_rsc_invalidate() to happen from tcs_write() when WAKE TCSes
>> is re-purposed to be used for Active mode. Clear only currently used
>> WAKE TCS's register configuration.
>>
>> Mark the caches as dirty so next time when rpmh_flush() is invoked it
>> can invalidate and program cached sleep and wake sets again.
> Comment above is no longer right now that you've removed the place
> that marks caches as dirty.
>
>
>> Fixes: 2de4b8d33eab (drivers: qcom: rpmh-rsc: allow active requests from wake TCS)
>> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
>> ---
>>   drivers/soc/qcom/rpmh-rsc.c | 23 +++++++++++------------
>>   1 file changed, 11 insertions(+), 12 deletions(-)
> Other than the comment nit:
>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>

Thanks Doug for the review.

I will remove last paragraph from commit message.

Thanks,
Maulik

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
