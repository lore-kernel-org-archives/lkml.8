Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A34C2C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 04:26:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A6CCC2075D
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 04:26:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="a2GKq2zJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729246AbgHDE01 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 00:26:27 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:33234 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726000AbgHDE00 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 00:26:26 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1596515186; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=DM0cwbE0E11xbWUTJtr8W3gA66HihacHsZV+CyhBE6I=;
 b=a2GKq2zJtsEhbWPrHSg0niC3ZsVcByVZ6Hvr2xn4Rki8v+pwl1b5V5RN7N4Jctt/GMtCtgSh
 VnBVrQds9J38+axXQNp8wI3/Rm2ixkcYgzzxVsUsKgFd5+6UtAn8c6t3+Yvgsk0l5K+O6Lsh
 IKhi5QfEKuVEd7EDa4q21gwfR3Y=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n06.prod.us-east-1.postgun.com with SMTP id
 5f28e35b798b102968606315 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 04 Aug 2020 04:26:03
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C0E08C433CA; Tue,  4 Aug 2020 04:26:02 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E84AAC433C9;
        Tue,  4 Aug 2020 04:26:01 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 04 Aug 2020 09:56:01 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Qi Liu <liuqi115@huawei.com>
Cc:     gregkh@linuxfoundation.org, suzuki.poulose@arm.com,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linuxarm@huawei.com, Mathieu Poirier <mathieu.poirier@linaro.org>,
        Mike Leach <mike.leach@linaro.org>
Subject: Re: [PATCH] coresight: etm4x: Add Support for HiSilicon ETM device
In-Reply-To: <1596461740-13527-1-git-send-email-liuqi115@huawei.com>
References: <1596461740-13527-1-git-send-email-liuqi115@huawei.com>
Message-ID: <8285c6a853e0ded975483e53750805dd@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qi Liu,

On 2020-08-03 19:05, Qi Liu wrote:
> Add ETMv4 periperhal ID for HiSilicon Hip08 and Hip09 platform. Hip08
> contains ETMv4.2 device and Hip09 contains ETMv4.5 device.
> 
> Signed-off-by: Qi Liu <liuqi115@huawei.com>
> ---
>  drivers/hwtracing/coresight/coresight-etm4x.c | 2 ++
>  1 file changed, 2 insertions(+)
> 
> diff --git a/drivers/hwtracing/coresight/coresight-etm4x.c
> b/drivers/hwtracing/coresight/coresight-etm4x.c
> index 0c35cd5e..4a4f0bd 100644
> --- a/drivers/hwtracing/coresight/coresight-etm4x.c
> +++ b/drivers/hwtracing/coresight/coresight-etm4x.c
> @@ -1561,6 +1561,8 @@ static struct amba_cs_uci_id uci_id_etm4[] = {
>  };
> 
>  static const struct amba_id etm4_ids[] = {
> +	CS_AMBA_ID(0x000b6d02),			/* HiSilicon-Hip09 */
> +	CS_AMBA_ID(0x000b6d01),			/* HiSilicon-Hip08 */
>  	CS_AMBA_ID(0x000bb95d),			/* Cortex-A53 */
>  	CS_AMBA_ID(0x000bb95e),			/* Cortex-A57 */
>  	CS_AMBA_ID(0x000bb95a),			/* Cortex-A72 */
> --
> 2.8.1

You have missed adding the maintainers/reviewers of coresight(Mathieu 
and Mike),
you can use scripts/get_maintainer.pl on the drivers to get the 
maintainers and
reviewers for the corresponding drivers, same on other patch as well.

Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
