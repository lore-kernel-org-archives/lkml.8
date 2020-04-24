Return-Path: <SRS0=nwpL=6I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6F318C54FCB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 01:04:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3F5F920736
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Apr 2020 01:04:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="HEvhI3mB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728196AbgDXBEE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 21:04:04 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:13770 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727968AbgDXBEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 21:04:04 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1587690243; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=G6mhG4mz2toGOYigr/TcPYDN0XCRA/uAhCT3m96wlxE=; b=HEvhI3mBYr1Cm0KjaVGPLM2tegTpkerzCMC/VYNIjeUa5WOl/SkSfmIuOWWMvmL3bIbbL2iR
 TLoQShm72md1ou0giVbwKJ/L5UOxm7unfEP+Rn99InanLS8NnqX9nrBVC8+0WR1cuLbp4Hfc
 H1gKk0py5aU5W7V5BrczKlyed5A=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea23af5.7fe8ed549228-smtp-out-n03;
 Fri, 24 Apr 2020 01:03:49 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id A37D7C433BA; Fri, 24 Apr 2020 01:03:48 +0000 (UTC)
Received: from [192.168.142.6] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: clew)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id C04BEC433CB;
        Fri, 24 Apr 2020 01:03:47 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org C04BEC433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=clew@codeaurora.org
Subject: Re: [PATCH 2/4] soc: qcom: glink_ssr: Internalize ssr_notifiers
To:     Bjorn Andersson <bjorn.andersson@linaro.org>,
        Andy Gross <agross@kernel.org>,
        Ohad Ben-Cohen <ohad@wizery.com>
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-remoteproc@vger.kernel.org,
        Sibi <sibis@codeaurora.org>,
        Siddharth Gupta <sidgup@codeaurora.org>
References: <20200423003736.2027371-1-bjorn.andersson@linaro.org>
 <20200423003736.2027371-3-bjorn.andersson@linaro.org>
From:   Chris Lew <clew@codeaurora.org>
Message-ID: <520f62ea-144d-92dd-aaa5-562d45deeade@codeaurora.org>
Date:   Thu, 23 Apr 2020 18:03:47 -0700
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200423003736.2027371-3-bjorn.andersson@linaro.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/22/2020 5:37 PM, Bjorn Andersson wrote:
> Rather than carrying a special purpose blocking notifier for glink_ssr
> in remoteproc's qcom_common.c, move it into glink_ssr so allow wider
> reuse of the common one.
> 
> The rpmsg glink header file is used in preparation for the next patch.
> 
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
Acked-by: Chris Lew <clew@codeaurora.org>

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a 
Linux Foundation Collaborative Project
