Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CA542C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:44:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A7D6F206C0
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:44:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="l4SgabZe"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728084AbgD1OoY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:44:24 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:18713 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728073AbgD1OoX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:44:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588085063; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=nQ1Rk345+B1CzRfg7oYPjHw4VBZBtZklp4KplnRGW8k=; b=l4SgabZeZzq+FuRbVP8PcHTFavDyObLnBemPIhxXc+gaZxbaG4zwoXCGJARJHv6Nds8GyBS/
 Tml3QxzY9fcFK6C3F1iLvq6QaInH/0vip8vqpNzRrFBMl8BV5vjMgdDZDhLrHV1QFTZy0Ifd
 J3Cas3davqGD7AYBn8KKG7fAlCc=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea84142.7ff0eeb10ae8-smtp-out-n03;
 Tue, 28 Apr 2020 14:44:18 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 7AF56C433F2; Tue, 28 Apr 2020 14:44:17 +0000 (UTC)
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 7F980C433CB;
        Tue, 28 Apr 2020 14:44:16 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 7F980C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v2 2/8] bus: mhi: core: Add range check for channel id
 received in event ring
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>, mani@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hemantk@codeaurora.org
References: <1588042766-17496-1-git-send-email-bbhatt@codeaurora.org>
 <1588042766-17496-3-git-send-email-bbhatt@codeaurora.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <5dfa3617-644c-42c3-0dfe-4f9f4a6d5ded@codeaurora.org>
Date:   Tue, 28 Apr 2020 08:44:15 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1588042766-17496-3-git-send-email-bbhatt@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/27/2020 8:59 PM, Bhaumik Bhatt wrote:
> From: Hemant Kumar <hemantk@codeaurora.org>
> 
> MHI data completion handler function reads channel id from event
> ring element. Value is under the control of MHI devices and can be
> any value between 0 and 255. In order to prevent out of bound access
> add a bound check against the max channel supported by controller
> and skip processing of that event ring element.
> 
> Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> ---
>   drivers/bus/mhi/core/main.c | 4 ++++
>   1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index 23154f1..1ccd4cc 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -827,6 +827,9 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
>   		enum mhi_pkt_type type = MHI_TRE_GET_EV_TYPE(local_rp);
>   
>   		chan = MHI_TRE_GET_EV_CHID(local_rp);
> +		if (WARN_ON(chan >= mhi_cntrl->max_chan))
> +			goto next_event;
> +
>   		mhi_chan = &mhi_cntrl->mhi_chan[chan];
>   
>   		if (likely(type == MHI_PKT_TYPE_TX_EVENT)) {
> @@ -837,6 +840,7 @@ int mhi_process_data_event_ring(struct mhi_controller *mhi_cntrl,
>   			event_quota--;
>   		}
>   
> +next_event:
>   		mhi_recycle_ev_ring_element(mhi_cntrl, ev_ring);
>   		local_rp = ev_ring->rp;
>   		dev_rp = mhi_to_virtual(ev_ring, er_ctxt->rp);
> 

It looks like the same issue exists in mhi_process_ctrl_ev_ring(), and 
thus some form of this solution needs to be applied there as well. 
Would you please fix that too?

-- 
Jeffrey Hugo
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
