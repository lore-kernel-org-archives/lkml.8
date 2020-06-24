Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19A4CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:53:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E2F4E20738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 06:53:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="AhiwksU9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389555AbgFXGxa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 02:53:30 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:18246 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S2388972AbgFXGx3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 02:53:29 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592981608; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=mfTvbat16k8ntfxME31zkmPcnDzW9AvI4GxEfGq3e5Q=;
 b=AhiwksU9Cy07ubIPLsu3jMwvgzlv0C1/NpcdctNvYxnfIFApAuB8nC1x1IRYuOXmAaTnXwBs
 SdbAgYDAgsXs6uZvogfvhtqNW4yY4qz2s/GjgOjY1Ez/bipexg8Dpwhc3M9W9uSRY00FSB5N
 t9jTaFplD3mXM6IKqIG/OpocjpU=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n02.prod.us-east-1.postgun.com with SMTP id
 5ef2f8668fe116ddd9308e01 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 24 Jun 2020 06:53:26
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 615DAC433A0; Wed, 24 Jun 2020 06:53:25 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id B31C6C433C8;
        Wed, 24 Jun 2020 06:53:24 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 24 Jun 2020 12:23:24 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mike Leach <mike.leach@linaro.org>, coresight@lists.linaro.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Stephen Boyd <swboyd@chromium.org>
Subject: Re: [PATCHv3] coresight: tmc: Add shutdown callback for TMC ETR
In-Reply-To: <20200623172532.GA1843779@xps15>
References: <20200616045623.27549-1-saiprakash.ranjan@codeaurora.org>
 <20200623172532.GA1843779@xps15>
Message-ID: <7bfbef95a0ec59fd45b101ea05a9ce36@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-23 22:55, Mathieu Poirier wrote:
> On Tue, Jun 16, 2020 at 10:26:23AM +0530, Sai Prakash Ranjan wrote:
>> Implement a shutdown callback to ensure ETR hardware is
>> properly shutdown in reboot/shutdown path. This is required
>> for ETR which has SMMU address translation enabled like on
>> SC7180 SoC and few others. If the hardware is still accessing
>> memory after SMMU translation is disabled as part of SMMU
>> shutdown callback in system reboot or shutdown path, then
>> IOVAs(I/O virtual address) which it was using will go on the
>> bus as the physical addresses which might result in unknown
>> crashes (NoC/interconnect errors). So we make sure from this
>> shutdown callback that the ETR is shutdown before SMMU translation
>> is disabled and device_link in SMMU driver will take care of
>> ordering of shutdown callbacks such that SMMU shutdown callback
>> is not called before any of its consumer shutdown callbacks.
>> 
>> Signed-off-by: Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
>> ---
> 
> I have applied your patch.
> 

Thanks Mathieu.

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
