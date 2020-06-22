Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0585EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:39:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CE70C2071A
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 11:39:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="i4Xx0xJz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727843AbgFVLjl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 07:39:41 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:50627 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726998AbgFVLjk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 07:39:40 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592825980; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=kQrKbNDc/6IkvX8zRZYkxck2Qap2jlhaPCjcowWErCM=; b=i4Xx0xJzTGSJIXHSfE/GMgV9dTERqixLlWH4Elr2Y+cZRsxuB9312w0HSPlueBt1iQ2F1qX0
 YR3pPgLHHXI2KEbcTEfGgrmAIji76YvfCsS7Elq1A/Tu9okB4AvWaJFZQ1fBuqzn3MRd4DPG
 TPjUZjb8p+ajvZQOSAH5WYfAiNU=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n13.prod.us-west-2.postgun.com with SMTP id
 5ef09873117610c7ffc171ca (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Mon, 22 Jun 2020 11:39:31
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 6E665C43395; Mon, 22 Jun 2020 11:39:31 +0000 (UTC)
Received: from [192.168.29.129] (unknown [49.36.71.202])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BFEE6C433C8;
        Mon, 22 Jun 2020 11:39:27 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BFEE6C433C8
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
Subject: Re: [PATCH] soc: qcom: rpmh-rsc: Set suppress_bind_attrs flag
To:     Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        dianders@chromium.org, rnayak@codeaurora.org, ilina@codeaurora.org,
        lsrao@codeaurora.org, john.stultz@linaro.org
References: <1592808805-2437-1-git-send-email-mkshah@codeaurora.org>
 <159281658960.62212.15968925558324290917@swboyd.mtv.corp.google.com>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <a429dfbb-4125-6019-c102-d5b2f4d7379f@codeaurora.org>
Date:   Mon, 22 Jun 2020 17:09:24 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <159281658960.62212.15968925558324290917@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

Thanks for the review Stephen.

On 6/22/2020 2:33 PM, Stephen Boyd wrote:
> Quoting Maulik Shah (2020-06-21 23:53:25)
>> rpmh-rsc driver is fairly core to system and should not be removable
>> once its probed. However it allows to unbind driver from sysfs using
>> below command which results into a crash on sc7180.
> What is the crash? The world falls apart because rpmh APIs start
> referencing pointers that point to freed memory?
Yes.
>
>> echo 18200000.rsc > /sys/bus/platform/drivers/rpmh/unbind
>>
>> Lets prevent unbind at runtime by setting suppress_bind_attrs flag.
> Ok. But when the Android module brigade comes knocking they'll have to
> revert this change and solve this problem too. Have fun!

No should not need to revert this change.

Even if rpmh-rsc is planned to be loadable module for android, Once 
loaded it should be disallowed to be removed.

same is the case for PDC irqchip as well. these drivers are core to the 
system and shouldn't be allowed to rmmod/unbind.

Thanks,
Maulik

>
>> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
>> ---
> Reviewed-by: Stephen Boyd <swboyd@chromium.org>

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

