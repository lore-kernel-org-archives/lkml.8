Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74A12C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:37:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5461C2067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:37:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="B64PHnnm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730507AbgGMQhl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 12:37:41 -0400
Received: from hqnvemgate26.nvidia.com ([216.228.121.65]:6947 "EHLO
        hqnvemgate26.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729969AbgGMQhk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:37:40 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate26.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f0c8dc60001>; Mon, 13 Jul 2020 09:37:26 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Mon, 13 Jul 2020 09:37:39 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Mon, 13 Jul 2020 09:37:39 -0700
Received: from [10.26.72.101] (10.124.1.5) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Mon, 13 Jul
 2020 16:37:38 +0000
Subject: Re: [PATCH 1/2] cpufreq: tegra186: Fix initial frequency
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200712100645.13927-1-jonathanh@nvidia.com>
 <20200713032554.cykywnygxln6ukrl@vireshk-i7>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <3d6091f2-6b04-185f-6c23-e39a34b87877@nvidia.com>
Date:   Mon, 13 Jul 2020 17:37:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.8.0
MIME-Version: 1.0
In-Reply-To: <20200713032554.cykywnygxln6ukrl@vireshk-i7>
X-Originating-IP: [10.124.1.5]
X-ClientProxiedBy: HQMAIL111.nvidia.com (172.20.187.18) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1594658246; bh=j07fRsUya2Rkr0o3lWYTAHPyUTT7NzlNKWFyMy2w+FU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=B64PHnnmjFFJzm6tcGsqHpZuxv/g2nvXhUgeOJl2Vbd+GAiwAIHLWiM3cdlBb1DDp
         s6e9UVM3Vv3e+J2Otc1z73T2hyJcDOxxRhwdenoQqYuzGfXvvmKxiqhtmbgi60tmqp
         +Yjn6B1jZP2WdTmE2JczxR5P+243Ls+0ZE9lpJG0l+txfFhRFOupM3mpAq0CNmOYSW
         QR4kLrJPx9Z1LUQW3yiK7Vc9/+lWxMQnLpS5U3tgTIliil8Fx6Gdz3bGQFJddTjzex
         3epeuegOs+m0eIdtMY3rrT5j6h54uubqQ+cOX7Qs4Q+dXs0HsTXpLaX5c2QR4QDnlc
         o/w3C6XcmPlkw==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 13/07/2020 04:25, Viresh Kumar wrote:
> On 12-07-20, 11:06, Jon Hunter wrote:
>> Commit 6cc3d0e9a097 ("cpufreq: tegra186: add
>> CPUFREQ_NEED_INITIAL_FREQ_CHECK flag") fixed CPUFREQ support for
>> Tegra186 but as a consequence the following warnings are now seen on
>> boot ...
>>
>>  cpufreq: cpufreq_online: CPU0: Running at unlisted freq: 0 KHz
>>  cpufreq: cpufreq_online: CPU0: Unlisted initial frequency changed to: 2035200 KHz
>>  cpufreq: cpufreq_online: CPU1: Running at unlisted freq: 0 KHz
>>  cpufreq: cpufreq_online: CPU1: Unlisted initial frequency changed to: 2035200 KHz
>>  cpufreq: cpufreq_online: CPU2: Running at unlisted freq: 0 KHz
>>  cpufreq: cpufreq_online: CPU2: Unlisted initial frequency changed to: 2035200 KHz
>>  cpufreq: cpufreq_online: CPU3: Running at unlisted freq: 0 KHz
>>  cpufreq: cpufreq_online: CPU3: Unlisted initial frequency changed to: 2035200 KHz
>>  cpufreq: cpufreq_online: CPU4: Running at unlisted freq: 0 KHz
>>  cpufreq: cpufreq_online: CPU4: Unlisted initial frequency changed to: 2035200 KHz
>>  cpufreq: cpufreq_online: CPU5: Running at unlisted freq: 0 KHz
>>  cpufreq: cpufreq_online: CPU5: Unlisted initial frequency changed to: 2035200 KHz
>>
>> Although we could fix this by adding a 'get' operator for the Tegra186
>> CPUFREQ driver, there is really little point because the CPUFREQ on
>> Tegra186 is set by writing a value stored in the frequency table to a
>> register and we just need to set the initial frequency.
> 
> The hardware still runs at the frequency requested by cpufreq core here, right ?

Yes.

> It is better to provide the get() callback as it is also used to show the
> current frequency in userspace.

I looked at that and I saw that if the get() callback is not provided,
the current frequency showed by userspace is policy->cur. For this
device, policy->cur is accurate and so if we added the get() callback we
essentially just going to return policy->cur. Therefore, given that we
already know policy->cur, I did not see the point in adding a device
specific handler to do the same thing.

Cheers
Jon

-- 
nvpublic
