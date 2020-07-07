Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3458AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0A68B206DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 10:17:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="SDfdxurn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728298AbgGGKR3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 06:17:29 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:62255 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726946AbgGGKRM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 06:17:12 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594117031; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=BXI021rh3NXH5BcDC2Muu+0d+4q5W0LWbpYi2AY+2A4=; b=SDfdxurnYwJm8mP9s52bhnsKVxz9zZVXYnADFasVHWRiQtZIfjQsfrLjT1c35c6HeXV9oQom
 wqS4C9ITvrVTccAbMBFazAejDWeTB9lDkrczE4wCaRxppsIX74A/54vOVtv3tNzEFZu6/7mJ
 Rv0N3AUyUAp3IfamK7q+BqItxNE=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n17.prod.us-west-2.postgun.com with SMTP id
 5f044b93d8ca07a573e8c852 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Tue, 07 Jul 2020 10:16:51
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 70EB7C433CA; Tue,  7 Jul 2020 10:16:51 +0000 (UTC)
Received: from [192.168.0.15] (unknown [183.83.138.47])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: akashast)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id ACB36C433C6;
        Tue,  7 Jul 2020 10:16:46 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org ACB36C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=akashast@codeaurora.org
Subject: Re: [PATCH 1/3] spi: spi-geni-qcom: Avoid clock setting if not needed
To:     Douglas Anderson <dianders@chromium.org>,
        Mark Brown <broonie@kernel.org>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     linux-arm-msm@vger.kernel.org, mkshah@codeaurora.org,
        swboyd@chromium.org, georgi.djakov@linaro.org,
        ctheegal@codeaurora.org, mka@chromium.org,
        linux-kernel@vger.kernel.org, linux-spi@vger.kernel.org
References: <20200702004509.2333554-1-dianders@chromium.org>
 <20200701174506.1.Icfdcee14649fc0a6c38e87477b28523d4e60bab3@changeid>
From:   Akash Asthana <akashast@codeaurora.org>
Message-ID: <1b9f0313-0e8f-0a75-b0a5-b6a768af0a7a@codeaurora.org>
Date:   Tue, 7 Jul 2020 15:46:22 +0530
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200701174506.1.Icfdcee14649fc0a6c38e87477b28523d4e60bab3@changeid>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 7bit
Content-Language: en-US
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/2/2020 6:15 AM, Douglas Anderson wrote:
> Every SPI transfer could have a different clock rate.  The
> spi-geni-qcom controller code to deal with this was never very well
> optimized and has always had a lot of code plus some calls into the
> clk framework which, at the very least, would grab a mutex.  However,
> until recently, the overhead wasn't _too_ much.  That changed with
> commit 0e3b8a81f5df ("spi: spi-geni-qcom: Add interconnect support")
> we're now calling geni_icc_set_bw(), which leads to a bunch of math
> plus:
>    geni_icc_set_bw()
>      icc_set_bw()
>        apply_constraints()
>          qcom_icc_set()
>            qcom_icc_bcm_voter_commit()
>              rpmh_invalidate()
>              rpmh_write_batch()
> ...and those rpmh commands can be a bit beefy if you call them too
> often.

Reviewed-by: Akash Asthana<akashast@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,\na Linux Foundation Collaborative Project

