Return-Path: <SRS0=8+oI=7O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.4 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EE78EC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:01:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C688520679
	for <linux-kernel@archiver.kernel.org>; Mon,  1 Jun 2020 11:01:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="t/Z7/edJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726067AbgFALBq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 1 Jun 2020 07:01:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55174 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725925AbgFALBV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Jun 2020 07:01:21 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96F90C03E97C
        for <linux-kernel@vger.kernel.org>; Mon,  1 Jun 2020 04:01:19 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id m7so4156590plt.5
        for <linux-kernel@vger.kernel.org>; Mon, 01 Jun 2020 04:01:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=vSd1F9IWmylmdRhuAnkzZkcm/vhp0PvuDBF/lEkmWYM=;
        b=t/Z7/edJ+cZ8JjeZehSfuBXZPJJtj7/nryWGlIAR6tVr3jRy92L52wK2yPqqcJ6hUZ
         Zw2fDUxXjK4GLKozfv5U2FexgQOI+tiIvUmSfh1QP1fnlNvOPAvorTf8bJW2IhNr031a
         9mzjkAzrQzmmZI9NTUnAAol0UsJ66onm5nIy/+U9tIly5mu4YgSKOoZ38lPxfHTMsJBp
         qGTj1qfgCNvY4LEI5xJQ85EIUn522vjEXAjRPHdrhTwnpV5ZUzNoQ1f8+27fU31yAvte
         fWfrQ7Ne16RjH7nH35WeQs/F3bLDRAj8OeO2Xl3cRiGS9zL1FCTppOHUjx96V4Hywxmc
         cXfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=vSd1F9IWmylmdRhuAnkzZkcm/vhp0PvuDBF/lEkmWYM=;
        b=T/00lzs/RvRaIwXnPpU6xbLV25qiuHLR2XyjtMbfzB6YzsjIwm8R1oFYPhZFDWCqUE
         ySYNI1GjH+UujAfrI4ziQth7+uDiqSB/MM/F4YwPOKWZhPoXKxTIbvmnb+ZFqwoRnBYf
         EkEksu4uhJWxusUSUM2Oqup/YC/AIofc7hzfszDxTMfjPKBvZlZBVm9LvuGTRmdI9sVf
         n4DCRf30+XQKcdggyz0tfiyWNuyxZ3bocD2z9Dk+HZowVXKXMsfkopSSxQ6BFRhYWrMO
         wH59v8zKFPQswmNo/qzxLH8/hw/xLLM2TPMVScaFOFvJpSAGSIMZTotBIhEkgdDYYEox
         0DAA==
X-Gm-Message-State: AOAM531Hext820IAlkw5TgfQlT45n8L5PnepTFk+R17iFQIlcbXRCYAd
        rraFXD2PF9Wq+iYHach3OeasYw==
X-Google-Smtp-Source: ABdhPJwAVadiEigs3N3Sh4nG5ncaSZnIPjxqEIMNOmDBbJC05+jH/KHIkzRncLVURZ5nRvvxZzCKTw==
X-Received: by 2002:a17:90a:f508:: with SMTP id cs8mr5446247pjb.16.1591009278922;
        Mon, 01 Jun 2020 04:01:18 -0700 (PDT)
Received: from localhost ([122.172.62.209])
        by smtp.gmail.com with ESMTPSA id q5sm14121925pfl.199.2020.06.01.04.01.17
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Mon, 01 Jun 2020 04:01:17 -0700 (PDT)
Date:   Mon, 1 Jun 2020 16:31:16 +0530
From:   Viresh Kumar <viresh.kumar@linaro.org>
To:     Sibi Sankar <sibis@codeaurora.org>
Cc:     sboyd@kernel.org, georgi.djakov@linaro.org, saravanak@google.com,
        mka@chromium.org, nm@ti.com, bjorn.andersson@linaro.org,
        agross@kernel.org, rjw@rjwysocki.net,
        linux-arm-msm@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, dianders@chromium.org,
        vincent.guittot@linaro.org, amit.kucheria@linaro.org,
        lukasz.luba@arm.com, sudeep.holla@arm.com, smasetty@codeaurora.org,
        linux-arm-msm-owner@vger.kernel.org
Subject: Re: [PATCH v5 4/5] cpufreq: qcom: Update the bandwidth levels on
 frequency change
Message-ID: <20200601110116.jteoalg3yjhsbkpw@vireshk-i7>
References: <20200527202153.11659-1-sibis@codeaurora.org>
 <20200527202153.11659-5-sibis@codeaurora.org>
 <20200529100028.2wz2iqi5vqji2heb@vireshk-i7>
 <a90bce2d52f7cdb726e8b799e3512fad@codeaurora.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a90bce2d52f7cdb726e8b799e3512fad@codeaurora.org>
User-Agent: NeoMutt/20180716-391-311a52
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29-05-20, 17:00, Sibi Sankar wrote:
> > > +static int qcom_cpufreq_update_opp(struct device *cpu_dev,
> > > +				   unsigned long freq_khz,
> > > +				   unsigned long volt)
> > > +{
> > > +	unsigned long freq_hz = freq_khz * 1000;
> > > +
> > > +	if (dev_pm_opp_adjust_voltage(cpu_dev, freq_hz, volt, volt, volt))
> > > +		return dev_pm_opp_add(cpu_dev, freq_hz, volt);
> > 
> > What's going on here ? Why add OPP here ?
> 
> We update the voltage if opp were
> initially added as part of
> dev_pm_opp_of_add_table. However
> if the cpu node does not have an
> opp table associated with it, we
> do a opp_add_v1 instead.

Instead of depending on the failure of dev_pm_opp_adjust_voltage(),
pass a flag to qcom_cpufreq_update_opp() which will decide if we want
to adjust voltage or add an opp.

-- 
viresh
