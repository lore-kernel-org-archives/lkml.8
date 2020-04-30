Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37E85C47253
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:06:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 079652082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 15:06:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="Qxd1CH7k"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726841AbgD3PGx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 11:06:53 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:24879 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726501AbgD3PGw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 11:06:52 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588259212; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=b3Fk8o+zUWDtaaxt3LW4me8q66Riwnz1AJgdSV4hMvY=; b=Qxd1CH7kNw+FQXYgYc0CU2oBYRLkHK/DtKAbZWHWjIzdw/R3eROlh8ie16kLXOHSYlLSgeqb
 /+wbcdUHU8k/sNPV8WDfiEfr5u0A70DjTsd26h7FvpCYU3yKkDpO5txc/97JPHrVaBxhyXz9
 ukvyJ87X3/f6VpTjidJYR79eh18=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5eaae97d.7f7376767d50-smtp-out-n03;
 Thu, 30 Apr 2020 15:06:37 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id D7441C433F2; Thu, 30 Apr 2020 15:06:36 +0000 (UTC)
Received: from [10.226.58.28] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: jhugo)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B22E3C433CB;
        Thu, 30 Apr 2020 15:06:35 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org B22E3C433CB
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=jhugo@codeaurora.org
Subject: Re: [PATCH v3 8/9] bus: mhi: core: Improve debug logs for loading
 firmware
To:     Bhaumik Bhatt <bbhatt@codeaurora.org>, mani@kernel.org
Cc:     linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        hemantk@codeaurora.org
References: <1588193551-31439-1-git-send-email-bbhatt@codeaurora.org>
 <1588193551-31439-9-git-send-email-bbhatt@codeaurora.org>
From:   Jeffrey Hugo <jhugo@codeaurora.org>
Message-ID: <6b8fbb74-3e56-be82-f262-e282d8393c61@codeaurora.org>
Date:   Thu, 30 Apr 2020 09:06:34 -0600
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.5.0
MIME-Version: 1.0
In-Reply-To: <1588193551-31439-9-git-send-email-bbhatt@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/29/2020 2:52 PM, Bhaumik Bhatt wrote:
> Add log messages to track boot flow errors and timeouts in SBL or AMSS
> firmware loading to aid in debug.
> 
> Signed-off-by: Bhaumik Bhatt <bbhatt@codeaurora.org>
> 

Reviewed-by: Jeffrey Hugo <jhugo@codeaurora.org>

-- 
Jeffrey Hugo
Qualcomm Technologies, Inc. is a member of the
Code Aurora Forum, a Linux Foundation Collaborative Project.
