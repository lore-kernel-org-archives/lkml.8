Return-Path: <SRS0=r24B=6M=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C13BFC83008
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:58:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 98D83206A1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Apr 2020 18:58:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="ADGKuWeW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728953AbgD1S6C (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Apr 2020 14:58:02 -0400
Received: from mail26.static.mailgun.info ([104.130.122.26]:64802 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1729417AbgD1S56 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Apr 2020 14:57:58 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1588100277; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=2Y6b36ayyOGCJzSMhx0uz2jc0TRSogQ1Q1n9GsQYtto=; b=ADGKuWeW2lqY+GeBoYYOmB9/RtXHBAOKOFHxz9ZfOWLXbQPE8S3LtcWda9mcipGg6CX2Z9fC
 bXynkLeZHgaWpFt8eo0X4UTEipX8u3RRedmbyqP1Ou7yb2C7mYhaeyeYLqI1f5NhMFEftJMk
 MBvs822Cbhu3FryA7EBUnlSWHvg=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5ea87cb3.7f844196e570-smtp-out-n03;
 Tue, 28 Apr 2020 18:57:55 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id DE93CC44788; Tue, 28 Apr 2020 18:57:54 +0000 (UTC)
Received: from [10.46.162.249] (i-global254.qualcomm.com [199.106.103.254])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: hemantk)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id BBCCAC4478F;
        Tue, 28 Apr 2020 18:57:53 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org BBCCAC4478F
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=hemantk@codeaurora.org
Subject: Re: [PATCH v3 6/6] bus: mhi: core: Fix channel device name conflict
To:     Jeffrey Hugo <jhugo@codeaurora.org>,
        manivannan.sadhasivam@linaro.org
Cc:     bbhatt@codeaurora.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org
References: <1588003153-13139-1-git-send-email-jhugo@codeaurora.org>
 <1588003153-13139-7-git-send-email-jhugo@codeaurora.org>
From:   Hemant Kumar <hemantk@codeaurora.org>
Message-ID: <72519148-a677-bfdf-05fc-f14cc3e3bffd@codeaurora.org>
Date:   Tue, 28 Apr 2020 11:57:53 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.6.1
MIME-Version: 1.0
In-Reply-To: <1588003153-13139-7-git-send-email-jhugo@codeaurora.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/27/20 8:59 AM, Jeffrey Hugo wrote:
> When multiple instances of the same MHI product are present in a system,
> we can see a splat from mhi_create_devices() - "sysfs: cannot create
> duplicate filename".
> 
> This is because the device names assigned to the MHI channel devices are
> non-unique.  They consist of the channel's name, and the channel's pipe
> id.  For identical products, each instance is going to have the same
> set of channel (both in name and pipe id).
> 
> To fix this, we prepend the device name of the parent device that the
> MHI channels belong to.  Since different instances of the same product
> should have unique device names, this makes the MHI channel devices for
> each product also unique.
> 
> Additionally, remove the pipe id from the MHI channel device name.  This
> is an internal detail to the MHI product that provides little value, and
> imposes too much device specific internal details to userspace.  It is
> expected that channel with a specific name (ie "SAHARA") has a specific
> client, and it does not matter what pipe id that channel is enumerated on.
> The pipe id is an internal detail between the MHI bus, and the hardware.
> The client is not expected to make decisions based on the pipe id, and to
> do so would require the client to have intimate knowledge of the hardware,
> which is inappropiate as it may violate the layering provided by the MHI
> bus.  The limitation of doing this is that each product may only have one
> instance of a channel by a unique name.  This limitation is appropriate
> given the usecases of MHI channels.
> 
> Signed-off-by: Jeffrey Hugo <jhugo@codeaurora.org>
> ---
Reviewed-by: Hemant Kumar <hemantk@codeaurora.org>

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum,
a Linux Foundation Collaborative Project
