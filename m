Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 60071C3B186
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 06:32:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 36C70206DB
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 06:32:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="TMKHfvTs"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728280AbgBLGcT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 12 Feb 2020 01:32:19 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:34320 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728100AbgBLGcT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Feb 2020 01:32:19 -0500
Received: by mail-pl1-f194.google.com with SMTP id j7so573201plt.1
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 22:32:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=GxlpTDEfBiM+Lrd0uvS3F76lPFNbhk2ZRTz1WbZMTKk=;
        b=TMKHfvTsUQifq2CQtrudVlOCHAb6Nb3YWpNg08b0/IQTbPlQ2PKKni61zTK9j5Mk84
         oQP70mkWXnUPl4dg5H034uLrOnMW6yrX34706D9q4jZGFIFPklsDBDkrnbRSOGwhsPD0
         WxO2AkIDFE/R9gBECZ7Ie8yAQM/zjZ0DbIC4bZGXL0v71JZ2vPuo7Txnp5MC87+yzYyh
         EMuYoA0OxXqdOKtY5ELEJiWYkuWOKFpz42kTjEdrmf5ckuwTfd3lJZAqFiT795n5bKIt
         Kl1ZoAjIBP6XszFNdxZGE/4Bct120kWwS60sUYNP776KQWhQRohjaGdbPS/HCswyB9un
         o2PA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=GxlpTDEfBiM+Lrd0uvS3F76lPFNbhk2ZRTz1WbZMTKk=;
        b=YNnuhYws2KursG2pzSzdBNHcN2xV1Uslv8XBGaNm73HfOYaLwh67f2TWDkAI0up5oB
         2pc1Q5L3enwItimwCNil6M1Gu/CXEJ1p/SYq1Km7FWHBH2OzGijNPSl5apQ602BfRy5W
         inDfwrICUSCpjq5mstO+X4Fo6HKxSJ2J+Jk6HD+gNEuj2o7O1gDKO8tqSgiVuee6j7kh
         PpU1sd2MbjoFvpq1tpsubpbnOIQDRQAtGYlOzK8ZHll2FntFKt5RcGYtJEKAyViWooEi
         P084XVpylEKlv2u/xdC2Hrqsm8nCFsQua6pkF1oeGV0l0kSMHT0iaVolarkNiPrdARWV
         oU2g==
X-Gm-Message-State: APjAAAU7Eoz9pwMaR8C2529xh9dnrSatfTBsw9sdIyjFfeMiUOL9vHSk
        PYt8uZPpmv5ZKN7XHazYtL0tkg==
X-Google-Smtp-Source: APXvYqyuNc53YydyhfeNo07pFeihlSSJpWGZufskCNWU36ELfymOGkx94tkF5kfiAO+eA+pvfrTyRA==
X-Received: by 2002:a17:902:8d83:: with SMTP id v3mr7040485plo.282.1581489136996;
        Tue, 11 Feb 2020 22:32:16 -0800 (PST)
Received: from builder (104-188-17-28.lightspeed.sndgca.sbcglobal.net. [104.188.17.28])
        by smtp.gmail.com with ESMTPSA id l26sm6309608pgn.46.2020.02.11.22.32.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Feb 2020 22:32:16 -0800 (PST)
Date:   Tue, 11 Feb 2020 22:32:14 -0800
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Arun Kumar Neelakantam <aneela@codeaurora.org>
Cc:     clew@codeaurora.org, Andy Gross <agross@kernel.org>,
        "open list:ARM/QUALCOMM SUPPORT" <linux-arm-msm@vger.kernel.org>,
        open list <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] soc: qcom: aoss: Read back before triggering the IRQ
Message-ID: <20200212063214.GP3948@builder>
References: <1579681454-1229-1-git-send-email-aneela@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1579681454-1229-1-git-send-email-aneela@codeaurora.org>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 22 Jan 00:24 PST 2020, Arun Kumar Neelakantam wrote:

> In some device memory used by msm_qmp, there can be an early ack of a
> write to memory succeeding. This may cause the outgoing interrupt to be
> triggered before the msgram reflects the write.
> 
> Add a readback to ensure the data is flushed to device memory before
> triggering the ipc interrupt.
> 
> Signed-off-by: Arun Kumar Neelakantam <aneela@codeaurora.org>

Applied

Thanks,
Bjorn

> ---
>  drivers/soc/qcom/qcom_aoss.c | 4 ++++
>  1 file changed, 4 insertions(+)
> 
> diff --git a/drivers/soc/qcom/qcom_aoss.c b/drivers/soc/qcom/qcom_aoss.c
> index fe79661..f43a2e0 100644
> --- a/drivers/soc/qcom/qcom_aoss.c
> +++ b/drivers/soc/qcom/qcom_aoss.c
> @@ -225,6 +225,7 @@ static bool qmp_message_empty(struct qmp *qmp)
>  static int qmp_send(struct qmp *qmp, const void *data, size_t len)
>  {
>  	long time_left;
> +	size_t tlen;
>  	int ret;
>  
>  	if (WARN_ON(len + sizeof(u32) > qmp->size))
> @@ -239,6 +240,9 @@ static int qmp_send(struct qmp *qmp, const void *data, size_t len)
>  	__iowrite32_copy(qmp->msgram + qmp->offset + sizeof(u32),
>  			 data, len / sizeof(u32));
>  	writel(len, qmp->msgram + qmp->offset);
> +
> +	/* Read back len to confirm data written in message RAM */
> +	tlen = readl(qmp->msgram + qmp->offset);
>  	qmp_kick(qmp);
>  
>  	time_left = wait_event_interruptible_timeout(qmp->event,
> -- 
> 1.9.1
