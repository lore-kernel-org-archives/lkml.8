Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D07F7C4BA11
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:51:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A06962084E
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 09:51:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (1024-bit key) header.d=mg.codeaurora.org header.i=@mg.codeaurora.org header.b="foOYNiQI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727909AbgBZJv5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 04:51:57 -0500
Received: from mail26.static.mailgun.info ([104.130.122.26]:40300 "EHLO
        mail26.static.mailgun.info" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1726329AbgBZJv5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 04:51:57 -0500
DKIM-Signature: a=rsa-sha256; v=1; c=relaxed/relaxed; d=mg.codeaurora.org; q=dns/txt;
 s=smtp; t=1582710716; h=In-Reply-To: Content-Type: MIME-Version:
 References: Message-ID: Subject: Cc: To: From: Date: Sender;
 bh=POFy3KliRKq8cq0QRv2JZ6k1sTr7/Med4NwvQ/3jSlA=; b=foOYNiQIbNzDed6ap7DX/LgTWv/WFkMskQmrnQgiyTbrGEirgLRx9LMV5Tc1NM64khK8YELN
 KZkzpN8jvvSdIbk/w0Di4HjGnFsOB9OIF0xQniaekvR7mRRLcpAavJ//QVVg7q4j1acQqeyu
 2r4qe/XNzk/g197BrU0h3X3gJTs=
X-Mailgun-Sending-Ip: 104.130.122.26
X-Mailgun-Sid: WyI0MWYwYSIsICJsaW51eC1rZXJuZWxAdmdlci5rZXJuZWwub3JnIiwgImJlOWU0YSJd
Received: from smtp.codeaurora.org (ec2-35-166-182-171.us-west-2.compute.amazonaws.com [35.166.182.171])
 by mxa.mailgun.org with ESMTP id 5e563fb0.7fcf28283688-smtp-out-n02;
 Wed, 26 Feb 2020 09:51:44 -0000 (UTC)
Received: by smtp.codeaurora.org (Postfix, from userid 1001)
        id ED25CC447A4; Wed, 26 Feb 2020 09:51:43 +0000 (UTC)
Received: from codeaurora.org (blr-c-bdr-fw-01_GlobalNAT_AllZones-Outside.qualcomm.com [103.229.19.19])
        (using TLSv1.2 with cipher ECDHE-RSA-AES128-GCM-SHA256 (128/128 bits))
        (No client certificate requested)
        (Authenticated sender: pkondeti)
        by smtp.codeaurora.org (Postfix) with ESMTPSA id A2010C43383;
        Wed, 26 Feb 2020 09:51:37 +0000 (UTC)
DMARC-Filter: OpenDMARC Filter v1.3.2 smtp.codeaurora.org A2010C43383
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; dmarc=none (p=none dis=none) header.from=codeaurora.org
Authentication-Results: aws-us-west-2-caf-mail-1.web.codeaurora.org; spf=none smtp.mailfrom=pkondeti@codeaurora.org
Date:   Wed, 26 Feb 2020 15:21:34 +0530
From:   Pavan Kondeti <pkondeti@codeaurora.org>
To:     Ionela Voinescu <ionela.voinescu@arm.com>
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com, sudeep.holla@arm.com,
        lukasz.luba@arm.com, valentin.schneider@arm.com,
        dietmar.eggemann@arm.com, rjw@rjwysocki.net, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org,
        viresh.kumar@linaro.org, linux-arm-kernel@lists.infradead.org,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org
Subject: Re: [PATCH v4 6/7] arm64: use activity monitors for frequency
 invariance
Message-ID: <20200226095134.GM28029@codeaurora.org>
References: <20200224141142.25445-1-ionela.voinescu@arm.com>
 <20200224141142.25445-7-ionela.voinescu@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200224141142.25445-7-ionela.voinescu@arm.com>
User-Agent: Mutt/1.5.24 (2015-08-30)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 24, 2020 at 02:11:41PM +0000, Ionela Voinescu wrote:

[...]

> +static int __init init_amu_fie(void)
> +{
> +	cpumask_var_t valid_cpus;
> +	bool have_policy = false;
> +	int cpu;
> +
> +	if (!zalloc_cpumask_var(&valid_cpus, GFP_KERNEL) ||
> +	    !zalloc_cpumask_var(&amu_fie_cpus, GFP_KERNEL))
> +		return -ENOMEM;

The patch looks good to me. one minor comment here. In an unlikely
scenario, valid_cpus which is a temporary mask can get allocated
but amu_fie_cpus may not. In that case, we have to free valid_cpus
here. I have seen some static code inspection tools catching these
type of errors. If you happen to rebase this series, fix this.

Thanks,
Pavan

-- 
Qualcomm India Private Limited, on behalf of Qualcomm Innovation Center, Inc.
Qualcomm Innovation Center, Inc. is a member of Code Aurora Forum, a Linux Foundation Collaborative Project.
