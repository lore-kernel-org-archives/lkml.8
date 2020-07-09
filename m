Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.5 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5CA8C433E1
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:44:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B31DE2073A
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 14:44:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="t8FTN88F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726932AbgGIOoF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 10:44:05 -0400
Received: from m43-7.mailgun.net ([69.72.43.7]:31775 "EHLO m43-7.mailgun.net"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726353AbgGIOoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 10:44:05 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1594305844; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=3We4BhHnsmyDDmm6gtgYzv/izpXX1ppdDtsySi/iWzs=;
 b=t8FTN88FNK+i9GbYLS2ecAMUUP2HeaCrYoLcBM4IXpMlS+J33t8RtVK61TLe1yXsame3XEdG
 gt+lvluu9fkXjiiKIuPxdenKxwy1WRtmoiRhLLI90sD1EQeSxurpCN5hWuJKbT7tKilHYPVU
 4JNl9vfWhvJRGhKTmFGgioDARfw=
X-Mailgun-Sending-Ip: 69.72.43.7
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n14.prod.us-east-1.postgun.com with SMTP id
 5f072d269f03943e5ce0ee16 (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Thu, 09 Jul 2020 14:43:50
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 34F4DC43395; Thu,  9 Jul 2020 14:43:50 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 82D43C433C6;
        Thu,  9 Jul 2020 14:43:49 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8;
 format=flowed
Content-Transfer-Encoding: 8bit
Date:   Thu, 09 Jul 2020 20:13:49 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Steev Klimaszewski <steev@kali.org>, viresh.kumar@linaro.org,
        sboyd@kernel.org, georgi.djakov@linaro.org, agross@kernel.org,
        robh+dt@kernel.org, linux-arm-msm@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        saravanak@google.com, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        robdclark@chromium.org, linux-kernel-owner@vger.kernel.org
Subject: Re: [PATCH v2] arm64: dts: qcom: sdm845: Add cpu OPP tables
In-Reply-To: <20200709142918.GA3521288@ripper>
References: <20200702204643.25785-1-sibis@codeaurora.org>
 <a61c5656-e21f-f071-1149-a3357fe2684e@kali.org>
 <20200709142918.GA3521288@ripper>
Message-ID: <f36df61af67245c5fe9ca4e7550b8861@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-09 19:59, Bjorn Andersson wrote:
> On Wed 08 Jul 19:22 PDT 2020, Steev Klimaszewski wrote:
> 
>> 
>> On 7/2/20 3:46 PM, Sibi Sankar wrote:
>> > Add OPP tables required to scale DDR/L3 per freq-domain on SDM845 SoCs.
>> >
>> > Signed-off-by: Sibi Sankar <sibis@codeaurora.org>
>> > ---
>> 
>> 
>> Hi Sibi,
>> 
>> 
>> Bjorn asked me to give this patch a whirl, and I have to say, I like 
>> it
>> but I'm not sure if I'm missing a dependency somewhere...
>> 
>> 
>> In 5.8.0-rc4, I'm seeing a couple probe defers
>> 
>> [    0.131341] cpu cpu0: _allocate_opp_table: Error finding 
>> interconnect
>> paths: -517
>> 
>> [    0.132694] cpu cpu4: _allocate_opp_table: Error finding 
>> interconnect
>> paths: -517
>> 
>> And then a bit later on,
>> 
>> [    0.625837] cpu cpu0: failed to get clock: -2
>> 
>> 
>> If these aren't anything to worry about, you can throw my Tested-by on
>> 
>> Tested-by: Steev Klimaszewski <steev@kali.org>
>> 
> 
> You need to enable:
> CONFIG_INTERCONNECT=y
> CONFIG_INTERCONNECT_QCOM=y
> CONFIG_INTERCONNECT_QCOM_OSM_L3=m
> CONFIG_INTERCONNECT_QCOM_SDM845=m

Steev had ^^ enabled but he was missing
the required cpufreq driver changes
available in linux-next.

> 
> With this I can see the interconnect_summary in debugfs change with the
> CPU frequency.
> 
> Regards,
> Bjorn

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
