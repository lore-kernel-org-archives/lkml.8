Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.3 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EC58C38A2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:27:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 578222083E
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 16:27:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ti.com header.i=@ti.com header.b="TqWZnijW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726235AbgDQQ1B (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 12:27:01 -0400
Received: from fllv0016.ext.ti.com ([198.47.19.142]:44190 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725877AbgDQQ1A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 12:27:00 -0400
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 03HGQwQF109796;
        Fri, 17 Apr 2020 11:26:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1587140818;
        bh=m70c/iHk1QCAeLZ1HYZLMTKUnM4CLvG0tVlQKue8Lx4=;
        h=Subject:To:CC:References:From:Date:In-Reply-To;
        b=TqWZnijW8zTOdKUTSx7IYI9/j7a0dv/I39FpDgukjaBDnmmWGf8jbyFs3X0HuIwfZ
         RAJskLLDwB2NvqrqFCGTzNKI7wjWLoks1LHhpGItt5pMah0RLT6bCINpshmCAPLnmp
         EqDY5DvGlAOp4FN0qaZ2lT7Ds8jH8JlUBQcSxkbU=
Received: from DLEE113.ent.ti.com (dlee113.ent.ti.com [157.170.170.24])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 03HGQw06032578
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 17 Apr 2020 11:26:58 -0500
Received: from DLEE108.ent.ti.com (157.170.170.38) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3; Fri, 17
 Apr 2020 11:26:57 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE108.ent.ti.com
 (157.170.170.38) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.1847.3 via
 Frontend Transport; Fri, 17 Apr 2020 11:26:57 -0500
Received: from [10.250.48.148] (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 03HGQvOS067089;
        Fri, 17 Apr 2020 11:26:57 -0500
Subject: Re: [PATCH 2/3] remoteproc: qcom_q6v5_mss: fix a bug in q6v5_probe()
To:     Alex Elder <elder@linaro.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Ohad Ben-Cohen <ohad@wizery.com>,
        Andy Gross <agross@kernel.org>
CC:     <linux-remoteproc@vger.kernel.org>,
        <linux-arm-msm@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200403175005.17130-1-elder@linaro.org>
 <20200403175005.17130-3-elder@linaro.org>
From:   Suman Anna <s-anna@ti.com>
Message-ID: <1b1abaa2-8059-5a2a-aad1-841f8487632e@ti.com>
Date:   Fri, 17 Apr 2020 11:26:57 -0500
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.7.0
MIME-Version: 1.0
In-Reply-To: <20200403175005.17130-3-elder@linaro.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/3/20 12:50 PM, Alex Elder wrote:
> If looking up the DT "firmware-name" property fails in q6v6_probe(),
> the function returns without freeing the remoteproc structure
> that has been allocated.  Fix this by jumping to the free_rproc
> label, which takes care of this.
> 

Please add the Fixes: line.

> Signed-off-by: Alex Elder <elder@linaro.org>
> ---
>   drivers/remoteproc/qcom_q6v5_mss.c | 2 +-
>   1 file changed, 1 insertion(+), 1 deletion(-)
> 
> diff --git a/drivers/remoteproc/qcom_q6v5_mss.c b/drivers/remoteproc/qcom_q6v5_mss.c
> index ce49c3236ff7..60cdf699ea80 100644
> --- a/drivers/remoteproc/qcom_q6v5_mss.c
> +++ b/drivers/remoteproc/qcom_q6v5_mss.c
> @@ -1675,7 +1675,7 @@ static int q6v5_probe(struct platform_device *pdev)
>   	ret = of_property_read_string_index(pdev->dev.of_node, "firmware-name",
>   					    1, &qproc->hexagon_mdt_image);
>   	if (ret < 0 && ret != -EINVAL)
> -		return ret;
> +		goto free_rproc;
>   
>   	platform_set_drvdata(pdev, qproc);
>   
> 

