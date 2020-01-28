Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 782CCC2D0DB
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:36:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E4D124681
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 19:36:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ZqL3CZgu"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726583AbgA1TgR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 14:36:17 -0500
Received: from mail25.static.mailgun.info ([104.130.122.25]:61713 "EHLO
        mail25.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726234AbgA1TgR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 14:36:17 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1580240176; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=eD6pavUpVIfzOBxAZx81/D8x7XfFjDmVXln2oUQASnk=; b=ZqL3CZguX65ouAd4egzY0nfkk5R4IfKntWNj2xhBL7IgUwWNnxM/90fl+9eFh+ny6odCLJeF
 UdmWA1STXDODC1w+i+mG60Ru8+/tje/J5VXQBjtSS481frqjw0M1LayxJy5hbY5sMFXAZLs1
 cpCTU1JQCLS6kY7X4c14Rnykq5g=
X-Mailgun-Sending-Ip: 104.130.122.25
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e308d28.7f228a1fd308-smtp-out-n03;
 Tue, 28 Jan 2020 19:36:08 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 59CEDC447A1; Tue, 28 Jan 2020 19:36:07 +0000 (UTC)
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EE3CEC4479C;
        Tue, 28 Jan 2020 19:36:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org EE3CEC4479C
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH 08/16] bus: mhi: core: Add support for downloading
 firmware over BHIe
To:     Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>,
        gregkh@linuxfoundation.org, arnd@arndb.de
Cc:     smohanad@codeaurora.org, kvalo@codeaurora.org,
        bjorn.andersson@linaro.org, hemantk@codeaurora.org,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org
References: <20200123111836.7414-1-manivannan.sadhasivam@linaro.org>
 <20200123111836.7414-9-manivannan.sadhasivam@linaro.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <00e3d4f8-89ab-79f0-7094-90cc6d85fa41@codeaurora.org>
Date:   Tue, 28 Jan 2020 12:36:04 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <20200123111836.7414-9-manivannan.sadhasivam@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 1/23/2020 4:18 AM, Manivannan Sadhasivam wrote:
> MHI supports downloading the device firmware over BHI/BHIe (Boot Host
> Interface) protocol. Hence, this commit adds necessary helpers, which
> will be called during device power up stage.
> 
> This is based on the patch submitted by Sujeev Dias:
> https://lkml.org/lkml/2018/7/9/989
> 
> Signed-off-by: Sujeev Dias <sdias@codeaurora.org>
> Signed-off-by: Siddartha Mohanadoss <smohanad@codeaurora.org>
> [mani: splitted the data transfer patch and cleaned up for upstream]
> Signed-off-by: Manivannan Sadhasivam <manivannan.sadhasivam@linaro.org>
> ---
>   drivers/bus/mhi/core/boot.c     | 268 ++++++++++++++++++++++++++++++++
>   drivers/bus/mhi/core/init.c     |   1 +
>   drivers/bus/mhi/core/internal.h |   1 +
>   3 files changed, 270 insertions(+)
> 
> diff --git a/drivers/bus/mhi/core/boot.c b/drivers/bus/mhi/core/boot.c
> index 0996f18c4281..36956fb6eff2 100644
> --- a/drivers/bus/mhi/core/boot.c
> +++ b/drivers/bus/mhi/core/boot.c
> @@ -20,6 +20,121 @@
>   #include <linux/wait.h>
>   #include "internal.h"
>   
> +/* Download AMSS image to device */

Nit: I don't feel like this comment really adds any value.  I feel like 
it either should have more content, or be removed.  What do you think?
> +static int mhi_fw_load_amss(struct mhi_controller *mhi_cntrl,
> +			    const struct mhi_buf *mhi_buf)
> +{


> +/* Download SBL image to device */

Same here.  Comment seems self evident from the function name.
> +static int mhi_fw_load_sbl(struct mhi_controller *mhi_cntrl,
> +			   dma_addr_t dma_addr,
> +			   size_t size)
> +{
> +	u32 tx_status, val, session_id;
> +	int i, ret;
> +	void __iomem *base = mhi_cntrl->bhi;
> +	rwlock_t *pm_lock = &mhi_cntrl->pm_lock;
> +	struct {
> +		char *name;
> +		u32 offset;
> +	} error_reg[] = {
> +		{ "ERROR_CODE", BHI_ERRCODE },
> +		{ "ERROR_DBG1", BHI_ERRDBG1 },
> +		{ "ERROR_DBG2", BHI_ERRDBG2 },
> +		{ "ERROR_DBG3", BHI_ERRDBG3 },
> +		{ NULL },
> +	};
> +
> +	read_lock_bh(pm_lock);
> +	if (!MHI_REG_ACCESS_VALID(mhi_cntrl->pm_state)) {
> +		read_unlock_bh(pm_lock);
> +		goto invalid_pm_state;
> +	}
> +
> +	/* Start SBL download via BHI protocol */

I'm wondering, what do you think about having a debug level message here 
that SBL is being loaded?  I think it would be handy for looking into 
the device state.

> +	mhi_write_reg(mhi_cntrl, base, BHI_STATUS, 0);
> +	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_HIGH,
> +		      upper_32_bits(dma_addr));
> +	mhi_write_reg(mhi_cntrl, base, BHI_IMGADDR_LOW,
> +		      lower_32_bits(dma_addr));
> +	mhi_write_reg(mhi_cntrl, base, BHI_IMGSIZE, size);
> +	session_id = prandom_u32() & BHI_TXDB_SEQNUM_BMSK;
> +	mhi_write_reg(mhi_cntrl, base, BHI_IMGTXDB, session_id);
> +	read_unlock_bh(pm_lock);
> +
> +
> +static void mhi_firmware_copy(struct mhi_controller *mhi_cntrl,
> +			      const struct firmware *firmware,
> +			      struct image_info *img_info)

Perhaps its just me, but the parameters on the second and third lines do 
not look aligned in the style used in the rest of the file.


-- 
Jeffrey Hugo
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
