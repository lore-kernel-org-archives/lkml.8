Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 79EC3C83000
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:26:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4F7BA2074A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 14:26:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="lmFSRX6V"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728464AbgD3O04 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 10:26:56 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:55073 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1728296AbgD3O0z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 10:26:55 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588256815; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=r8YTGkSYkAs2tX+5jygTmI4J1E3dvGdwC9j2bG2dVjs=; b=lmFSRX6VViu/jPBmaaBbJSxMA78MwoOizpKm6zwsISS4Zf6w0ZJlY/m5gBUXVEhNFu5dtECN
 O4tjrqEE473uJEGMjc8D7EPuUbBJcOomrL8LqBMHn7irZ3seLfMbD7mgV2VjTaY+bw4X49kU
 dLKYUeWVSebqFzxnvFgqGRKGcmA=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eaae02b.7fdc6137f500-smtp-out-n05;
 Thu, 30 Apr 2020 14:26:51 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id C02FDC432C2; Thu, 30 Apr 2020 14:26:51 +0000 (UTC)
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B84BCC432C2;
        Thu, 30 Apr 2020 14:26:50 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B84BCC432C2
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v3 3/9] bus: mhi: core: Add range check for channel id
 received in event ring
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>, mani@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hemantk@codeaurora.org
References: <1588193551-31439-1-git-send-email-bbhatt@codeaurora.org>
 <1588193551-31439-4-git-send-email-bbhatt@codeaurora.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <4838aa03-d673-ab01-e88d-7ebb5b7fdbfe@codeaurora.org>
Date:   Thu, 30 Apr 2020 08:26:49 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1588193551-31439-4-git-send-email-bbhatt@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/2020 2:52 PM, Bhaumik Bhatt wrote:
> From: Hemant Kumar <hemantk@codeaurora.org>
> 
> MHI data completion handler function reads channel id from event
> ring element. Value is under the control of MHI devices and can be
> any value between 0 and 255. In order to prevent out of bound access
> add a bound check against the max channel supported by controller
> and skip processing of that event ring element.
> 
> Signed-off-by: Hemant Kumar <hemantk@codeaurora.org>
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> ---

Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>

-- 
Jeffrey Hugo
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
