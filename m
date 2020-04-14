Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28CA7C2BA19
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:47:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02523206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 15:47:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="kX5gbX5U"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2440897AbgDNPrZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 11:47:25 -0400
Received: from mail27.static.mailgun.info ([104.130.122.27]:54638 "EHLO
        mail27.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1731196AbgDNPrI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 11:47:08 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1586879228; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=Ev+tOWmh/spkiQzapjJsMT+Ybl+F09CQsdIN84fz7wM=;
 b=kX5gbX5UNsRbys+fpSygTF9FVSA6ksch3mx1c7QDCJ2WGLggLDt6kDjrHrHHjU90cuRmk4A4
 o+D1PDTl/ML24FCcd+7SGB8w0cQVh2e3eYzAviy/a1TOT8GnODQI3tCxgY4XKIZHQ1Vhgvbm
 9bVH93rsRZ62Ajj5UFGldarcc7A=
X-Mailgun-Sending-Ip: 104.130.122.27
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e95dafb.7f3976ce0618-smtp-out-n01;
 Tue, 14 Apr 2020 15:47:07 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id 960BDC44788; Tue, 14 Apr 2020 15:47:06 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: saiprakash.ranjan)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id EC16DC433BA;
        Tue, 14 Apr 2020 15:47:05 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Tue, 14 Apr 2020 21:17:05 +0530
From:   Sai Prakash Ranjan <saiprakash.ranjan@codeaurora.org>
To:     Mathieu Poirier <mathieu.poirier@linaro.org>
Cc:     Suzuki K Poulose <suzuki.poulose@arm.com>, mike.leach@linaro.org,
        swboyd@chromium.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH] coresight: tmc: Read TMC mode only when TMC hw is enabled
In-Reply-To: <20200413171418.GB28804@xps15>
References: <20200409113538.5008-1-saiprakash.ranjan@codeaurora.org>
 <9a792e3e-5a17-156d-4b59-4a3ec8f9993e@arm.com>
 <1751aeabd22bee18d2eef0f643883265@codeaurora.org>
 <20200413171418.GB28804@xps15>
Message-ID: <75ef334a7e2cc6d87deecadd12c74f59@codeaurora.org>
X-Sender: saiprakash.ranjan@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Mathieu,

On 2020-04-13 22:44, Mathieu Poirier wrote:
> On Mon, Apr 13, 2020 at 01:55:30PM +0530, Sai Prakash Ranjan wrote:
>> Hi Suzuki,
>> 
>> On 2020-04-13 04:47, Suzuki K Poulose wrote:
>> > Hi Sai,
>> >
>> > On 04/09/2020 12:35 PM, Sai Prakash Ranjan wrote:
>> > > Reading TMC mode register in tmc_read_prepare_etb without
>> > > enabling the TMC hardware leads to async exceptions like
>> > > the one in the call trace below. This can happen if the
>> > > user tries to read the TMC etf data via device node without
>> > > setting up source and the sink first which enables the TMC
>> > > hardware in the path. So make sure that the TMC is enabled
>> > > before we try to read TMC data.
>> >
>> > So, one can trigger the same SError by simply :
>> >
>> > $ cat /sys/bus/coresight/device/tmc_etb0/mgmt/mode
>> >
>> 
>> I do not see any SError when I run the above command.
>> 
>> localhost ~ # cat /sys/bus/coresight/devices/tmc_etf0/mgmt/mode
>> 0x0
>> 
>> And this is most likely due to
>> 
>> commit cd9e3474bb793dc ("coresight: add PM runtime calls to
>> coresight_simple_func()")
> 
> Ok, so this is related to power management (you can ignore my question 
> in the
> previous email).
> 
> Regarding function tmc_read_prepare_etb(), the best way to deal with 
> this is
> probably make sure drvdata->mode != CS_MODE_DISABLED before reading 
> TMC_MODE.
> If there is a buffer to read it will have been copied when the ETB was 
> disabled
> and there won't be a need to access the HW.
> 

This works as well, thanks.

diff --git a/drivers/hwtracing/coresight/coresight-tmc-etf.c 
b/drivers/hwtracing/coresight/coresight-tmc-etf.c
index d0cc3985b72a..7ffe05930984 100644
--- a/drivers/hwtracing/coresight/coresight-tmc-etf.c
+++ b/drivers/hwtracing/coresight/coresight-tmc-etf.c
@@ -596,6 +596,11 @@ int tmc_read_prepare_etb(struct tmc_drvdata 
*drvdata)
                 goto out;
         }

+       if (drvdata->mode == CS_MODE_DISABLED) {
+               ret = -EINVAL;
+               goto out;
+       }
+
         /* There is no point in reading a TMC in HW FIFO mode */
         mode = readl_relaxed(drvdata->base + TMC_MODE);
         if (mode != TMC_MODE_CIRCULAR_BUFFER) {


Thanks,
Sai

-- 
QUALCOMM INDIA, on behalf of Qualcomm Innovation Center, Inc. is a 
member
of Code Aurora Forum, hosted by The Linux Foundation
