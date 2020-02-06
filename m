Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9CC4AC33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:42:12 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6C07C20720
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 16:42:12 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Nkr6vpT1"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727761AbgBFQmL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 11:42:11 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:60098 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727620AbgBFQmL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 11:42:11 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1581007330; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=Bn4zuBVJDCezYJhHbJc60/dyfLIJ5d2xUrXKxsWwH8g=; b=Nkr6vpT1Kwnv5O3fdN/+IzQoY+QJA+8EsOG39xZCyQfvKxmCoNu7IL3H9xAtis7t1rAhD5Hi
 +co7cCNCF20O9uVbqDz5lcKc1ZSvPS1Y4LReNXyYaBt9bL7pfGG41Q0/A79mTUL8pORJKfjI
 ryQJDBKgYdnBho1T+RvrXOisNQo=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e3c41d8.7f8d7a65b180-smtp-out-n01;
 Thu, 06 Feb 2020 16:42:00 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 5D934C447A0; Thu,  6 Feb 2020 16:41:59 +0000 (UTC)
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 1E04DC43383;
        Thu,  6 Feb 2020 16:41:58 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 1E04DC43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v2 09/16] bus: mhi: core: Add support for downloading RDDM
 image during panic
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     smohanad@codeaurora.org, kvalo@codeaurora.org,
        bjorn.andersson@linaro.org, hemantk@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200131135009.31477-1-manivannan.sadhasivam@linaro.org>
 <20200131135009.31477-10-manivannan.sadhasivam@linaro.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <e18c2c4d-730b-fd40-7f8b-2236620bcb45@codeaurora.org>
Date:   Thu, 6 Feb 2020 09:41:57 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200131135009.31477-10-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/31/2020 6:50 AM, Manivannan Sadhasivam wrote:
> MHI protocol supports downloading RDDM (RAM Dump) image from the
> device through BHIE. This is useful to debugging as the RDDM image
> can capture the firmware state.
> 
> This is based on the patch submitted by Sujeev Dias:
> https://lkml.org/lkml/2018/7/9/989
> 
> Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
> Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> [mani: splitted the data transfer patch and cleaned up for upstream]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/bus/mhi/core/boot.c     | 157 +++++++++++++++++++++++++++++++-
>   drivers/bus/mhi/core/init.c     |  38 ++++++++
>   drivers/bus/mhi/core/internal.h |   2 +
>   drivers/bus/mhi/core/pm.c       |  31 +++++++
>   include/linux/mhi.h             |  24 +++++
>   5 files changed, 249 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
> index 36956fb6eff2..564d61f98257 100644
> --- a/drivers/bus/mhi/core/boot.c
> +++ b/drivers/bus/mhi/core/boot.c
> @@ -20,7 +20,159 @@
>   #include <linux/wait.h>
>   #include "internal.h"
>   
> -/* Download AMSS image to device */

Seems a bit odd to add this line in patch 8, only to remove it here in 
patch 9.  Feels like never adding it in the first place would be better. 
  Not something to warrant a v3 through.

-- 
Jeffrey Hugo
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
