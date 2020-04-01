Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A07CCC43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:14:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6B22320714
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:14:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="BCf919XB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732093AbgDAIOP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:14:15 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:32530 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731849AbgDAIOP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:14:15 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585728854; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: References: Cc: To:
 Subject: From: Sender; bh=VEK+xKqqL07PbO0Tpfl9yU5mpA/DT2wGBLGIVg93tCU=;
 b=BCf919XB06WYxx7pPyTxl+rx5zf4eYM8eubaMy6+nWzW65sLlS28Q0xhQE8e7EmefgUQt/qU
 Zwac4k6EMWot8/ocMt4Eduy2AS6+1ngLrnlg4+AEL0qU4kVkawvCWev0oR9+e80yXX+gxft3
 yrXDAQ3bpd9JiTnaFwlL0G2vVB4=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e844d52.7f8c2d28b928-smtp-out-n02;
 Wed, 01 Apr 2020 08:14:10 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8EB10C433F2; Wed,  1 Apr 2020 08:14:10 +0000 (UTC)
Received: from [192.168.43.137] (unknown [106.213.199.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mkshah)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 29024C433D2;
        Wed,  1 Apr 2020 08:14:05 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org 29024C433D2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mkshah@codeaurora.org
From:   Maulik Shah <mkshah@codeaurora.org>
Subject: Re: [RFT PATCH v2 02/10] drivers: qcom: rpmh-rsc: Document the
 register layout better
To:     Douglas Anderson <dianders@chromium.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     mka@chromium.org, Rajendra Nayak <rnayak@codeaurora.org>,
        evgreen@chromium.org, Lina Iyer <ilina@codeaurora.org>,
        swboyd@chromium.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <20200311231348.129254-1-dianders@chromium.org>
 <20200311161104.RFT.v2.2.Iaddc29b72772e6ea381238a0ee85b82d3903e5f2@changeid>
Message-ID: <1fd57a5e-067c-5b2e-c9d5-5a1836e55273@codeaurora.org>
Date:   Wed, 1 Apr 2020 13:44:03 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200311161104.RFT.v2.2.Iaddc29b72772e6ea381238a0ee85b82d3903e5f2@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
Content-Language: en-GB
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

On 3/12/2020 4:43 AM, Douglas Anderson wrote:
> Perhaps it's just me, it took a really long time to understand what
> the register layout of rpmh-rsc was just from the #defines.  Let's add
> a bunch of comments describing which blocks are part of other blocks.
>
> Signed-off-by: Douglas Anderson<dianders@chromium.org>
> ---
>
> Changes in v2:
> - Now prose in comments instead of struct definitions.
> - Pretty ASCII art from Stephen.
>
>   drivers/soc/qcom/rpmh-rsc.c | 78 ++++++++++++++++++++++++++++++++++---
>   1 file changed, 73 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/soc/qcom/rpmh-rsc.c b/drivers/soc/qcom/rpmh-rsc.c
> index b87b79f0347d..02c8e0ffbbe4 100644
> --- a/drivers/soc/qcom/rpmh-rsc.c
> +++ b/drivers/soc/qcom/rpmh-rsc.c
> @@ -37,14 +37,24 @@
>   #define DRV_NCPT_MASK			0x1F
>   #define DRV_NCPT_SHIFT			27
>   
> -/* Register offsets */
> +/*
> + * Register offsets within a TCS.

Change this to

/* Offsets for common TCS Registers, one bit per TCS */

> + *
> + * TCSs are stored one after another; multiply tcs_id by RSC_DRV_TCS_OFFSET
> + * to find a given TCS and add one of the below to find a register.
> + */
Move above comment after these 3 common IRQ registers.
>   #define RSC_DRV_IRQ_ENABLE		0x00
>   #define RSC_DRV_IRQ_STATUS		0x04
> -#define RSC_DRV_IRQ_CLEAR		0x08

please add line break between RSC_DRV_IRQ_CLEAR and 
RSC_DRV_CMD_WAIT_FOR_CMPL

you may want to add one more comment inbetween saying

/* Offsets for per TCS Registers */

> -#define RSC_DRV_CMD_WAIT_FOR_CMPL	0x10
> +#define RSC_DRV_IRQ_CLEAR		0x08	/* w/o; write 1 to clear */
> +#define RSC_DRV_CMD_WAIT_FOR_CMPL	0x10	/* 1 bit per command */
>   #define RSC_DRV_CONTROL			0x14
> -#define RSC_DRV_STATUS			0x18
> -#define RSC_DRV_CMD_ENABLE		0x1C
> +#define RSC_DRV_STATUS			0x18	/* zero if tcs is busy */
> +#define RSC_DRV_CMD_ENABLE		0x1C	/* 1 bit per command */
> +
> +/*
> + * Commands (up to 16) start at 0x30 in a TCS; multiply command index
> + * by RSC_DRV_CMD_OFFSET and add one of the below to find a register.
> + */
you may also add /* Offsets for per command in a TCS */
>   #define RSC_DRV_CMD_MSGID		0x30
>   #define RSC_DRV_CMD_ADDR		0x34
>   #define RSC_DRV_CMD_DATA		0x38
> @@ -61,6 +71,64 @@
>   #define CMD_STATUS_ISSUED		BIT(8)
>   #define CMD_STATUS_COMPL		BIT(16)
>   
> +/*
> + * Here's a high level overview of how all the registers in RPMH work
> + * together:
> + *
> + * - The main rpmh-rsc address is the base of a register space that can
> + *   be used to find overall configuration of the hardware
> + *   (DRV_PRNT_CHLD_CONFIG).  Also found within the rpmh-rsc register
> + *   space are all the TCS blocks.  The offset of the TCS blocks is
> + *   specified in the device tree by "qcom,tcs-offset" and used to
> + *   compute tcs_base.
> + * - TCS blocks come one after another.  Type, count, and order are
> + *   specified by the device tree as "qcom,tcs-config".
> + * - Each TCS block has some registers, then space for up to 16 commands.
> + *   Note that though address space is reserved for 16 commands, fewer
> + *   might be present.  See ncpt (num cmds per TCS).
> + * - The first TCS block is special in that it has registers to control
> + *   interrupts (RSC_DRV_IRQ_XXX).  Space for these registers is reserved
> + *   in all TCS blocks to make the math easier, but only the first one
> + *   matters.

First TCS block is not special, the RSC_DRV_IRQ_XXX registers are common 
for all

TCSes.  can you please drop this last paragraph and then add one more 
block in

ASCII diagram to have TCS common IRQ registers like below to represent 
it more clear.

+----------------------------------------------+
|TCS                                           |
| IRQ                                          |
|                                              |
| +------------------------------------------+ |
| |TCS0  |  |  |  |  |  |  |  |  |  |  |  |  | |
| |      | 0| 1| 2| 3| 4| 5| .| .| .| .|14|15| |
| | ctrl |  |  |  |  |  |  |  |  |  |  |  |  | |
| +------------------------------------------+ |
+----------------------------------------------+


> + *
> + * Here's a picture:
> + *
> + *  +---------------------------------------------------+
> + *  |RSC                                                |
> + *  | ctrl                                              |
> + *  |                                                   |
> + *  | Drvs:                                             |
> + *  | +-----------------------------------------------+ |
> + *  | |DRV0                                           | |
> + *  | | ctrl                                          | |
> + *  | |                                               | |
> + *  | | TCSs:                                         | |
> + *  | | +------------------------------------------+  | |
> + *  | | |TCS0  |  |  |  |  |  |  |  |  |  |  |  |  |  | |
> + *  | | | IRQ  | 0| 1| 2| 3| 4| 5| .| .| .| .|14|15|  | |
> + *  | | | ctrl |  |  |  |  |  |  |  |  |  |  |  |  |  | |
> + *  | | +------------------------------------------+  | |
> + *  | | +------------------------------------------+  | |
> + *  | | |TCS1  |  |  |  |  |  |  |  |  |  |  |  |  |  | |
> + *  | | |      | 0| 1| 2| 3| 4| 5| .| .| .| .|14|15|  | |
> + *  | | | ctrl |  |  |  |  |  |  |  |  |  |  |  |  |  | |
> + *  | | +------------------------------------------+  | |
> + *  | | +------------------------------------------+  | |
> + *  | | |TCS2  |  |  |  |  |  |  |  |  |  |  |  |  |  | |
> + *  | | |      | 0| 1| 2| 3| 4| 5| .| .| .| .|14|15|  | |
> + *  | | | ctrl |  |  |  |  |  |  |  |  |  |  |  |  |  | |
> + *  | | +------------------------------------------+  | |
> + *  | |                    ......                     | |
> + *  | +-----------------------------------------------+ |
> + *  | +-----------------------------------------------+ |
> + *  | |DRV1                                           | |
> + *  | | (same as DRV0)                                | |
> + *  | +-----------------------------------------------+ |
> + *  |                      ......                       |
> + *  +---------------------------------------------------+
> + */
> +
> +

nit: two blank lines at the end, you can drop one.

Thanks,
Maulik
>   static u32 read_tcs_cmd(struct rsc_drv *drv, int reg, int tcs_id, int cmd_id)
>   {
>   	return readl_relaxed(drv->tcs_base + RSC_DRV_TCS_OFFSET * tcs_id + reg +

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, hosted by The Linux Foundation
