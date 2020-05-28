Return-Path: <SRS0=f73W=7K=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.0 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C57EC433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:43:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 05CE32078C
	for <linux-kernel@archiver.kernel.org>; Thu, 28 May 2020 19:43:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="CO0NoRpk"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406712AbgE1TnI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 28 May 2020 15:43:08 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:42891 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2406643AbgE1TnF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 May 2020 15:43:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1590694985; h=Content-Transfer-Encoding: Content-Type:
 In-Reply-To: MIME-Version: Date: Message-ID: From: References: Cc: To:
 Subject: Sender; bh=kFF4zTCNyN955cs1Mb7JcP1qwZvQGrTVhfs8rEMbMb4=; b=CO0NoRpk5S1PpU94ge7UrrOuLin55sQuCdAV+DCexnyYG3lob8/egPq+Nfjl+iMB9ASou5nQ
 liM9xXn+y8N/9YUXO5zBYEi9YleMHF2vQi1gW62275VX34y1tJD7zb1jgL6RXc7ykxPE5tqG
 faNFMegJyWO7PobMLDR5wj9V2co=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n03.prod.us-east-1.postgun.com with SMTP id
 5ed0144476fccbb4c8194d7b (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 28 May 2020 19:43:00
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 8414AC433C9; Thu, 28 May 2020 19:42:59 +0000 (UTC)
Received: from [10.253.14.55] (unknown [180.166.53.21])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: zijuhu)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id E1768C433C6;
        Thu, 28 May 2020 19:42:56 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org E1768C433C6
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=zijuhu@codeaurora.org
Subject: Re: [PATCH v3] Bluetooth: hci_qca: Improve controller ID info log
 level
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     marcel@holtmann.org, johan.hedberg@gmail.com,
        linux-kernel@vger.kernel.org, linux-bluetooth@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, bgodavar@codeaurora.org,
        c-hbandi@codeaurora.org, hemantg@codeaurora.org,
        rjliao@codeaurora.org
References: <1590663797-16531-1-git-send-email-zijuhu@codeaurora.org>
 <20200528151700.GI4525@google.com>
From:   Zijun Hu <zijuhu@codeaurora.org>
Message-ID: <f336a66a-d392-c995-e28d-34c9cc465371@codeaurora.org>
Date:   Fri, 29 May 2020 03:42:54 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.1
MIME-Version: 1.0
In-Reply-To: <20200528151700.GI4525@google.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/28/2020 11:17 PM, Matthias Kaehlcke wrote:
> On Thu, May 28, 2020 at 07:03:17PM +0800, Zijun Hu wrote:
>> Controller ID info got by VSC EDL_PATCH_GETVER is very
>> important, so improve its log level from DEBUG to INFO.
>>
>> Signed-off-by: Zijun Hu <zijuhu@codeaurora.org>
> 
> Please add the tags from earlier version unless the new patch has
> substantial changes.
> 
actually, this v3 patch is only to correct the code stye issue pointed
by you. let me resend it.

> Reviewed-by: Matthias Kaehlcke <mka@chromium.org>
> 

-- 
The Qualcomm Innovation Center, Inc. is a member of the Code Aurora Forum, a Linux Foundation Collaborative Project
