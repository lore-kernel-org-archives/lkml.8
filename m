Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15D81C10F26
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:36:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id DA5CB20678
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 07:36:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Rl2JedC6"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387502AbgDBHgA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Apr 2020 03:36:00 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:37858 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729033AbgDBHf7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Apr 2020 03:35:59 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1585812958; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=naqNAxywddNgWhPDH5Wtz+lOJzNYkTWgjlzNiVKiv48=; b=Rl2JedC66GIoBkWoMo7JBQiMhudnqkZ8hRzx1ggWlKKPJW4xyO2BJMOB8l94OWQ8gWb7r/oy
 TsjLssZnuxUrgMfCRQDdclsTH4+I3khg85HsS/zu30GM0Rv41hq0K5OBCABV0BwKzUjInGGw
 qa27dxP2GomrfVbvB37nFydPRR0=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e8595cd.7f5dad9b0ab0-smtp-out-n01;
 Thu, 02 Apr 2020 07:35:41 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DF789C43637; Thu,  2 Apr 2020 07:35:40 +0000 (UTC)
Received: from [10.111.194.152] (blr-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.18.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: mgautam)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B28D7C433F2;
        Thu,  2 Apr 2020 07:35:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B28D7C433F2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=mgautam@codeaurora.org
Subject: Re: [PATCH v4 4/4] phy: qcom-qmp: Use proper PWRDOWN offset for
 sm8150 USB
To:     Wesley Cheng <wcheng@codeaurora.org>, agross@kernel.org,
        bjorn.andersson@linaro.org, kishon@ti.com, robh+dt@kernel.org,
        mark.rutland@arm.com, p.zabel@pengutronix.de
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org
References: <1585597017-30683-1-git-send-email-wcheng@codeaurora.org>
 <1585597017-30683-5-git-send-email-wcheng@codeaurora.org>
From:   Manu Gautam <mgautam@codeaurora.org>
Message-ID: <d61723e3-17a3-366d-f476-c33931766efd@codeaurora.org>
Date:   Thu, 2 Apr 2020 13:05:32 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <1585597017-30683-5-git-send-email-wcheng@codeaurora.org>
Content-Type: text/plain; charset=utf-8
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 3/31/2020 1:06 AM, Wesley Cheng wrote:
> The register map for SM8150 QMP USB SSPHY has moved
> QPHY_POWER_DOWN_CONTROL to a different offset.  Allow for
> an offset in the register table to override default value
> if it is a DP capable PHY.
>
> Signed-off-by: Wesley Cheng <wcheng@codeaurora.org>
> ---
>  drivers/phy/qualcomm/phy-qcom-qmp.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/phy/qualcomm/phy-qcom-qmp.c b/drivers/phy/qualcomm/phy-qcom-qmp.c
> index cc04471..4c0517e 100644
> --- a/drivers/phy/qualcomm/phy-qcom-qmp.c
> +++ b/drivers/phy/qualcomm/phy-qcom-qmp.c
> @@ -164,6 +164,7 @@ enum qphy_reg_layout {
>  	[QPHY_SW_RESET]			= 0x00,
>  	[QPHY_START_CTRL]		= 0x44,
>  	[QPHY_PCS_STATUS]		= 0x14,
> +	[QPHY_COM_POWER_DOWN_CONTROL]	= 0x40,
Since this is in PCS block please rename it to -

QPHY_PCS_POWER_DOWN_CONTROL

>  };
>  
>  static const unsigned int sdm845_ufsphy_regs_layout[] = {
> @@ -1627,6 +1628,9 @@ static int qcom_qmp_phy_com_init(struct qmp_phy *qphy)
>  	if (cfg->has_phy_com_ctrl)
>  		qphy_setbits(serdes, cfg->regs[QPHY_COM_POWER_DOWN_CONTROL],
>  			     SW_PWRDN);
> +	else if (cfg->has_phy_dp_com_ctrl && cfg->regs[QPHY_COM_POWER_DOWN_CONTROL])
> +		qphy_setbits(pcs, cfg->regs[QPHY_COM_POWER_DOWN_CONTROL],
> +			     cfg->pwrdn_ctrl);
>  	else
>  		qphy_setbits(pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
Since, this register is in PCS block why check for dp_com_ctrl here?
Something like:

 	if (cfg->has_phy_com_ctrl) {
 		qphy_setbits(serdes, cfg->regs[QPHY_COM_POWER_DOWN_CONTROL],
 			     SW_PWRDN);
	} else {
		if (cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL]) 
			qphy_setbits(pcs, cfg->regs[QPHY_PCS_POWER_DOWN_CONTROL],
			     cfg->pwrdn_ctrl);
 		else
 			qphy_setbits(pcs, QPHY_POWER_DOWN_CONTROL, cfg->pwrdn_ctrl);
	}

>  
> @@ -1671,10 +1675,12 @@ static int qcom_qmp_phy_com_init(struct qmp_phy *qphy)
>  	return ret;
>  }
>  
> -static int qcom_qmp_phy_com_exit(struct qcom_qmp *qmp)
> +static int qcom_qmp_phy_com_exit(struct qmp_phy *qphy)
>  {
> +	struct qcom_qmp *qmp = qphy->qmp;
>  	const struct qmp_phy_cfg *cfg = qmp->cfg;
>  	void __iomem *serdes = qmp->serdes;
> +	void __iomem *pcs = qphy->pcs;
>  	int i = cfg->num_resets;
>  
>  	mutex_lock(&qmp->phy_mutex);
> @@ -1691,6 +1697,9 @@ static int qcom_qmp_phy_com_exit(struct qcom_qmp *qmp)
>  			     SW_RESET);
>  		qphy_setbits(serdes, cfg->regs[QPHY_COM_POWER_DOWN_CONTROL],
>  			     SW_PWRDN);
> +	} else if (cfg->has_phy_dp_com_ctrl && cfg->regs[QPHY_COM_POWER_DOWN_CONTROL]) {

Can we add change similar to init() here ?


> +			     cfg->pwrdn_ctrl);
>  	}
>  
>  	while (--i >= 0)
> @@ -1829,7 +1838,7 @@ static int qcom_qmp_phy_enable(struct phy *phy)
>  	if (cfg->has_lane_rst)
>  		reset_control_assert(qphy->lane_rst);
>  err_lane_rst:
> -	qcom_qmp_phy_com_exit(qmp);
> +	qcom_qmp_phy_com_exit(qphy);
>  
>  	return ret;
>  }
> @@ -1855,7 +1864,7 @@ static int qcom_qmp_phy_disable(struct phy *phy)
>  	if (cfg->has_lane_rst)
>  		reset_control_assert(qphy->lane_rst);
>  
> -	qcom_qmp_phy_com_exit(qmp);
> +	qcom_qmp_phy_com_exit(qphy);
>  
>  	qmp->phy_initialized = false;
>  

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
