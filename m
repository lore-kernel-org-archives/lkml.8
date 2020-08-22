Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 783A0C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:23:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 50ED82072D
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 16:23:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="OY7P8/bQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728467AbgHVQXP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 22 Aug 2020 12:23:15 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:58396 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728380AbgHVQXO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 22 Aug 2020 12:23:14 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1598113393; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=FYhJMKEBU4SFBiKHH2BxM4N53QqRKVAxSvII5SnSWsw=; b=OY7P8/bQw8K3b/s4sswNiJqqe9grWGUP0ybYkAV07oVeLVq8ZTtwXOAMt0qqptfpZIIOYUhE
 iFR2S/SFdTrYWbW+GSSg5ZHxPy1chLu1n4LXDDwb9pcvz6LfTtml6u7wWY9fVAP+D4ADk98X
 4XPjpgcIV/kn0XqrSjtHEc9QGG0=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-west-2.postgun.com with SMTP id
 5f414671c1ce10a051518a44 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Sat, 22 Aug 2020 16:23:13
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 314FEC43391; Sat, 22 Aug 2020 16:23:13 +0000 (UTC)
Received: from [192.168.29.129] (unknown [49.36.0.88])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 29B4DC433C6;
        Sat, 22 Aug 2020 16:23:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 29B4DC433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
Subject: Re: [PATCH 2/2] Revert "Revert "soc: qcom: rpmh: Allow RPMH driver to
 be loaded as a module""
To:     Stephen Boyd <swboyd@chromium.org>, agross@kernel.org,
        bjorn.andersson@linaro.org
Cc:     linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        ulf.hansson@linaro.org, dianders@chromium.org,
        rnayak@codeaurora.org, ilina@codeaurora.org, lsrao@codeaurora.org,
        John Stultz <john.stultz@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Todd Kjos <tkjos@google.com>,
        Saravana Kannan <saravanak@google.com>
References: <1597831670-17401-1-git-send-email-mkshah@codeaurora.org>
 <1597831670-17401-3-git-send-email-mkshah@codeaurora.org>
 <159796512284.334488.2457174259443414342@swboyd.mtv.corp.google.com>
From:   Maulik Shah <mkshah@codeaurora.org>
Message-ID: <739fd1bd-ebf0-8a1e-f737-5b11342ad72f@codeaurora.org>
Date:   Sat, 22 Aug 2020 21:53:05 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <159796512284.334488.2457174259443414342@swboyd.mtv.corp.google.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 8/21/2020 4:42 AM, Stephen Boyd wrote:
> Quoting Maulik Shah (2020-08-19 03:07:50)
>> The _rcuidle tracepoints are removed from RPMH driver which prevented
>> to compile it as module. Bring back the change to make it module.
>>
>> This reverts commit 1f7a3eb785e4a4e196729cd3d5ec97bd5f9f2940.
>>
>> Cc: John Stultz <john.stultz@linaro.org>
>> Cc: Stephen Rothwell <sfr@canb.auug.org.au>
>> Cc: Todd Kjos <tkjos@google.com>
>> Cc: Saravana Kannan <saravanak@google.com>
>> Signed-off-by: Maulik Shah <mkshah@codeaurora.org>
>> ---
> Please send the original patch and add your SoB to it. Reverting a patch
> out of the history works, but doesn't do justice to the authorship of
> the patch.
Sure, i will re-send the original patch in v2 instead of doing revert's 
revert.

Thanks,
Maulik

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation

