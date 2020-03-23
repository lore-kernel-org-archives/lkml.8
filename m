Return-Path: <SRS0=M7MX=5I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84EF0C3F2CD
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 14:14:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5C04620735
	for <linux-kernel@archiver.kernel.org>; Mon, 23 Mar 2020 14:14:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="tRVtXFAK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728606AbgCWOOM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 23 Mar 2020 10:14:12 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:49200 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728542AbgCWOOM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 23 Mar 2020 10:14:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1584972851; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=eoXl/UGZmMz/ABa7xJzX716BPb2HfAsc1SNuOejhtls=; b=tRVtXFAKtFjqvtfcJwVk7ErsL7cW4zus3BOhENbKj2B0pthr1YFCMdOuOO7Tyu3G/PCfPtuU
 A4L2g2+/wmITYublilVlZk/MxcuY3GUl2+JtnERmV0zvex2oYzLPzzOMWDVHG8QF64q10zk2
 HZS59yro3617HBz9or751R4hxh0=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e78c432.7fd0cdd39f80-smtp-out-n05;
 Mon, 23 Mar 2020 14:14:10 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 75C01C433BA; Mon, 23 Mar 2020 14:14:09 +0000 (UTC)
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 0CC8DC433CB;
        Mon, 23 Mar 2020 14:14:07 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 0CC8DC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v2 2/7] bus: mhi: core: Add support for reading MHI info
 from device
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        gregkh@linuxfoundation.org, davem@davemloft.net
Cc:     smohanad@codeaurora.org, kvalo@codeaurora.org,
        bjorn.andersson@linaro.org, hemantk@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200323123102.13992-1-manivannan.sadhasivam@linaro.org>
 <20200323123102.13992-3-manivannan.sadhasivam@linaro.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <c6b696ed-b9cf-98ed-7402-9fb82bcab1c6@codeaurora.org>
Date:   Mon, 23 Mar 2020 08:14:07 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.4.1
MIME-Version: 1.0
In-Reply-To: <20200323123102.13992-3-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 3/23/2020 6:30 AM, Manivannan Sadhasivam wrote:
> The MHI register base has several registers used for getting the MHI
> specific information such as version, family, major, and minor numbers
> from the device. This information can be used by the controller drivers
> for usecases such as applying quirks for a specific revision etc...
> 
> While at it, let's also rearrange the local variables
> in mhi_register_controller().
> 
> Suggested-by: Hemant Kumar <hemantk@codeaurora.org>
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
> --- a/include/linux/mhi.h
> +++ b/include/linux/mhi.h
> @@ -310,6 +310,10 @@ struct mhi_controller_config {
>    * @sw_ev_rings: Number of software event rings
>    * @nr_irqs_req: Number of IRQs required to operate (optional)
>    * @nr_irqs: Number of IRQ allocated by bus master (required)
> + * @family_number: MHI controller family number
> + * @device_number: MHI controller device number
> + * @major_version: MHI controller major revision number
> + * @minor_version: MHI controller minor revision number

Maybe expand the comment to indicate there are valid after register() to 
give controller implementations an idea of when they can use these for 
quirks, etc?

>    * @mhi_event: MHI event ring configurations table
>    * @mhi_cmd: MHI command ring configurations table
>    * @mhi_ctxt: MHI device context, shared memory between host and device
> @@ -375,6 +379,10 @@ struct mhi_controller {
>   	u32 sw_ev_rings;
>   	u32 nr_irqs_req;
>   	u32 nr_irqs;
> +	u32 family_number;
> +	u32 device_number;
> +	u32 major_version;
> +	u32 minor_version;
>   
>   	struct mhi_event *mhi_event;
>   	struct mhi_cmd *mhi_cmd;
> 


-- 
Jeffrey Hugo
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
