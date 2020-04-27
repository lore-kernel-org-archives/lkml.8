Return-Path: <SRS0=jv8X=6L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D4BC4C54EEB
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:50:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B81E820728
	for <linux-kernel@archiver.kernel.org>; Mon, 27 Apr 2020 18:50:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="kw0g7Xn3"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726669AbgD0Suo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Apr 2020 14:50:44 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:33733 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726226AbgD0Sun (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Apr 2020 14:50:43 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588013443; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=7yOIc6cBQUmjb2EJJfMTPa2gtx2SJO7TFkVSbmtblNE=; b=kw0g7Xn3bTh+BwGOLSjcPLzYPU2N7HnqVTaeOkzbmBNpYrFdKKBd4pt/KZVLvCy2GGq/dxdM
 K5JusFF/TKrszBWaSnlEi3G0qXRaSD7jCPY4Gdw1ZBSyrUuLwfzg/FdTDR//d985Iw2D70yc
 1AqTEi2+wL0v0nZGj9PWUugTNpc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea72979.7f27702b2500-smtp-out-n04;
 Mon, 27 Apr 2020 18:50:33 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 21503C44788; Mon, 27 Apr 2020 18:50:32 +0000 (UTC)
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 204B6C433BA;
        Mon, 27 Apr 2020 18:50:31 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 204B6C433BA
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v1 2/8] bus: mhi: core: Add range check for channel id
 received in event ring
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>, mani@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hemantk@codeaurora.org
References: <1588012342-4995-1-git-send-email-bbhatt@codeaurora.org>
 <1588012342-4995-3-git-send-email-bbhatt@codeaurora.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <0dc0310f-3fbd-088c-75cd-291e7c76e83b@codeaurora.org>
Date:   Mon, 27 Apr 2020 12:50:30 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1588012342-4995-3-git-send-email-bbhatt@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/2020 12:32 PM, Bhaumik Bhatt wrote:
> From: Hemant Kumar <hemantk@codeaurora.org>
> 
> MHI data completion handler function reads channel id from event
> ring element. Value is under the control of MHI devices and can be
> any value between 0 and 255. In order to prevent out of bound access
> add a bound check against the max channel supported by controller
> and skip processing of that event ring element.
> 
> Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>

I believe your SOB is needed here after Hemant's per section 11 of 
Documentation/process/submitting-patches.rst

> ---
>   drivers/bus/mhi/core/main.c | 3 +++
>   1 file changed, 3 insertions(+)
> 
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index 23154f1..ba8afa7 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -827,6 +827,9 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
>   		enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
>   
>   		chan = MHI_TRE_GET_EV_CHID(local_rp);
> +		if (WARN_ON(chan >= mhi_cntrl->max_chan))
> +			continue;
> +
>   		mhi_chan = &mhi_cntrl->mhi_chan[chan];
>   
>   		if (likely(type == MHI_PKT_TYPE_TX_EVENT)) {
> 

How does this work?

I understand the need for the range check, however I looks like this 
change doesn't do proper handling.

Since all you do is "continue", we'll remain stuck in the while loop 
this exists in, continuously "processing" the same event, failing the 
same check, and spamming the kernel log with the WARN_ON output until 
the end of time.

What am I missing?

What is the behavior you want?  Do you want to just drop/ignore the 
invalid event, or issue a reset of the device because it is clearly 
misbehaving?

-- 
Jeffrey Hugo
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
