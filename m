Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9565AC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:43:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 671DE21527
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 16:43:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="d68b4iTK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726879AbgFQQnk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 17 Jun 2020 12:43:40 -0400
Received: from mail29.static.mailgun.info ([104.130.122.29]:25667 "EHLO
        mail29.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726708AbgFQQnj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Jun 2020 12:43:39 -0400
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1592412219; h=Message-ID: References: In-Reply-To: Subject:
 Cc: To: From: Date: Content-Transfer-Encoding: Content-Type:
 MIME-Version: Sender; bh=D4RdphQ0R1rE6zlNQnweaxq4dFFlOZRlQvz+hdcu5Dk=;
 b=d68b4iTK8iDx7nlgEVT3qIXgshjzLrQ6a78EAmBZJq6Cv6b6/VdQU4xpxrD8b2Sm/HMV0ilI
 gA6usy771pw0iUUnhCyIW+CmxwgWC3eMwlkxj5KLVGcOKx2AQOySxRpfkW4jFLRcMvOi8s0w
 EIJF3OcT+XIPRJ/PbwE30wbzsL0=
X-Mailgun-Sending-Ip: 104.130.122.29
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org
 (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171]) by
 smtp-out-n12.prod.us-east-1.postgun.com with SMTP id
 5eea482abfb34e631c49cc0a (version=TLS1.2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256); Wed, 17 Jun 2020 16:43:22
 GMT
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id B7188C433A0; Wed, 17 Jun 2020 16:43:21 +0000 (UTC)
Received: from mail.codeaurora.org (localhost.localdomain [127.0.0.1])
        (using TLSv1 with cipher ECDHE-RSA-AES256-SHA (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: sibis)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id 11054C433CA;
        Wed, 17 Jun 2020 16:43:21 +0000 (UTC)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII;
 format=flowed
Content-Transfer-Encoding: 7bit
Date:   Wed, 17 Jun 2020 22:13:21 +0530
From:   Sibi Sankar <sibis@codeaurora.org>
To:     Matthias Kaehlcke <mka@chromium.org>
Cc:     viresh.kumar@linaro.org, sboyd@kernel.org,
        georgi.djakov@linaro.org, saravanak@google.com, nm@ti.com,
        bjorn.andersson@linaro.org, agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com, smasetty@codeaurora.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH v6 4/5] cpufreq: qcom: Update the bandwidth levels on
 frequency change
In-Reply-To: <20200616221157.GA4525@google.com>
References: <20200605213332.609-1-sibis@codeaurora.org>
 <20200605213332.609-5-sibis@codeaurora.org>
 <20200615172553.GU4525@google.com>
 <e21f85d64d72ec637c10dae93e8323bb@codeaurora.org>
 <20200616221157.GA4525@google.com>
Message-ID: <8a6ea89f41a3341e9d00ed9aa66355d6@codeaurora.org>
X-Sender: sibis@codeaurora.org
User-Agent: Roundcube Webmail/1.3.9
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-06-17 03:41, Matthias Kaehlcke wrote:
> Hi Sibi,
> 
> after doing the review I noticed that Viresh replied on the cover 
> letter
> that he picked the series up for v5.9, so I'm not sure if it makes 
> sense
> to send a v7.
> 
> On Wed, Jun 17, 2020 at 02:35:00AM +0530, Sibi Sankar wrote:
> 
>> > > @@ -112,7 +178,7 @@ static int qcom_cpufreq_hw_read_lut(struct
>> > > device *cpu_dev,
>> > >
>> > >  		if (freq != prev_freq && core_count != LUT_TURBO_IND) {
>> > >  			table[i].frequency = freq;
>> > > -			dev_pm_opp_add(cpu_dev, freq * 1000, volt);
>> > > +			qcom_cpufreq_update_opp(cpu_dev, freq, volt);
>> >
>> > This is the cross-validation mentioned above, right? Shouldn't it
>> > include
>> > a check of the return value?
>> 
>> Yes, this is the cross-validation step,
>> we adjust the voltage if opp-tables are
>> present/added successfully and enable
>> them, else we would just do a add opp.
>> We don't want to exit early on a single
>> opp failure. We will error out a bit
>> later if the opp-count ends up to be
>> zero.
> 
> At least an error/warning message would seem convenient when 
> adjusting/adding
> an OPP fails, otherwise you would only notice by looking at the sysfs
> attributes (if you'd even spot a single/few OPPs to be missing).

I did consider the case where adjust
voltage fails and we do report the
freq for which it fails for as well.
If adding a OPP fails we will still
it being listed in the sysfs cpufreq
scaling_available_frequencies since
it lists the freq_table in khz there
instead.

-- 
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum,
a Linux Foundation Collaborative Project.
