Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A38A0C83000
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:50:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FAC9206D6
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 14:50:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="R291xHrz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728202AbgD1Ou0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 10:50:26 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:19212 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727888AbgD1OuX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 10:50:23 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588085423; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=840my3Iu6yk+BC/Y1oTomASSkMJd5a+KJg6tqb2LL6I=; b=R291xHrzNWgk48QpPdUgknUupLvopI8GdtrGbl7tjZpqHT47Fu+fGIHwQwmyzb+XUNUAoy7K
 tdxR2HNcQfolLjWRSA2wN0jiAAgOWGJGVmVhi3w25uqIbFCn2qkvxoS/X6OmXpkxN/vAD7UV
 q7OfTFXUAQfVok5yVl5J6qGSLo4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea8429f.7f95c61e3148-smtp-out-n02;
 Tue, 28 Apr 2020 14:50:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C0BD0C4478C; Tue, 28 Apr 2020 14:50:06 +0000 (UTC)
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id AF802C43637;
        Tue, 28 Apr 2020 14:50:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org AF802C43637
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v2 3/8] bus: mhi: core: Read transfer length from an event
 properly
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>, mani@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hemantk@codeaurora.org
References: <1588042766-17496-1-git-send-email-bbhatt@codeaurora.org>
 <1588042766-17496-4-git-send-email-bbhatt@codeaurora.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <cbd0698d-52ca-fad6-a658-e6e0009bde66@codeaurora.org>
Date:   Tue, 28 Apr 2020 08:50:04 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1588042766-17496-4-git-send-email-bbhatt@codeaurora.org>
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
> When MHI Driver receives an EOT event, it reads xfer_len from the
> event in the last TRE. The value is under control of the MHI device
> and never validated by Host MHI driver. The value should never be
> larger than the real size of the buffer but a malicious device can
> set the value 0xFFFF as maximum. This causes device to memory

The device will overflow, or the driver?

> overflow (both read or write). Fix this issue by reading minimum of
> transfer length from event and the buffer length provided.
> 
> Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> ---
>   drivers/bus/mhi/core/main.c | 5 ++++-
>   1 file changed, 4 insertions(+), 1 deletion(-)
> 
> diff --git a/drivers/bus/mhi/core/main.c b/drivers/bus/mhi/core/main.c
> index 1ccd4cc..3d468d9 100644
> --- a/drivers/bus/mhi/core/main.c
> +++ b/drivers/bus/mhi/core/main.c
> @@ -521,7 +521,10 @@ static int parse_xfer_event(struct mhi_controller *mhi_cntrl,
>   				mhi_cntrl->unmap_single(mhi_cntrl, buf_info);
>   
>   			result.buf_addr = buf_info->cb_buf;
> -			result.bytes_xferd = xfer_len;
> +
> +			/* truncate to buf len if xfer_len is larger */
> +			result.bytes_xferd =
> +				min_t(u16, xfer_len, buf_info->len);
>   			mhi_del_ring_element(mhi_cntrl, buf_ring);
>   			mhi_del_ring_element(mhi_cntrl, tre_ring);
>   			local_rp = tre_ring->rp;
> 


-- 
Jeffrey Hugo
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
