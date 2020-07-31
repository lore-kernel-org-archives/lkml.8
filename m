Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.3 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 99A17C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:14:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 77A612245C
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 12:14:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="bNVZRRmX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733114AbgGaMOU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 08:14:20 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:18970 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732784AbgGaMOS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 08:14:18 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f240ab80000>; Fri, 31 Jul 2020 05:12:44 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Fri, 31 Jul 2020 05:14:18 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Fri, 31 Jul 2020 05:14:18 -0700
Received: from [10.26.73.28] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Fri, 31 Jul
 2020 12:14:12 +0000
Subject: Re: [PATCH 1/2] cpufreq: tegra186: Fix initial frequency
To:     Viresh Kumar <viresh.kumar@linaro.org>
CC:     Thierry Reding <thierry.reding@gmail.com>,
        "Rafael J . Wysocki" <rjw@rjwysocki.net>,
        <linux-tegra@vger.kernel.org>, <linux-kernel@vger.kernel.org>
References: <20200712100645.13927-1-jonathanh@nvidia.com>
 <20200713032554.cykywnygxln6ukrl@vireshk-i7>
 <3d6091f2-6b04-185f-6c23-e39a34b87877@nvidia.com>
 <20200714034635.2zdv3wzmftjg2t4a@vireshk-i7>
From:   Jon Hunter <jonathanh@nvidia.com>
Message-ID: <8c6d3c32-c142-3981-3a52-6560e885f4c9@nvidia.com>
Date:   Fri, 31 Jul 2020 13:14:09 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200714034635.2zdv3wzmftjg2t4a@vireshk-i7>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1596197564; bh=y7zPiwOFyQtt0rLys/IwA3DQdByn03F5BY9HhZm1uGU=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=bNVZRRmX8+2ltVanZS1OMvKhphVdXl2odp8h+VQBK+Rwo/7AbIg5b3/oKCxt6q3Ky
         vhaxHJqlX1X3eQFeUvfgfurUP5sKw58bG0CayL5BDrcVgMDvQcRdNdVPSRlBdTekC4
         zP0180OGr3VINBKhzwxQSgIvyrEoIofunWApjlz5IWzpsa3aG0Lmgk8UyKma1KfA9C
         uHBYDluv8wViENYf0tuf47ekrkut5EkiVzdF/+bSTBwdi2RAxtF5UXfqyUsyios84b
         0Nh0iHe0swdwAjDplU8hn5nK+LTm+UUE+3PFxPJv+CQRSLn2flTyjc8HvuVztXMkqn
         llKsF3Gu5pGtg==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Viresh,

On 14/07/2020 04:46, Viresh Kumar wrote:

...

> The get() callback is supposed to read the frequency from hardware and
> return it, no cached value here. policy->cur may end up being wrong in
> case there is a bug.

I have been doing some more testing on Tegra, I noticed that when
reading the current CPU frequency via the sysfs scaling_cur_freq entry,
this always returns the cached value (at least for Tegra). Looking at
the implementation of scaling_cur_freq I see ...

static ssize_t show_scaling_cur_freq(struct cpufreq_policy *policy, char *buf)
{
        ssize_t ret; 
        unsigned int freq;

        freq = arch_freq_get_on_cpu(policy->cpu);
        if (freq)
                ret = sprintf(buf, "%u\n", freq);
        else if (cpufreq_driver && cpufreq_driver->setpolicy &&
                        cpufreq_driver->get)
                ret = sprintf(buf, "%u\n", cpufreq_driver->get(policy->cpu));
        else
                ret = sprintf(buf, "%u\n", policy->cur);
        return ret; 
}

The various Tegra CPU frequency drivers do not implement the
set_policy callback and hence why we always get the cached value. I
see the following commit added this and before it simply return the
cached value ...

commit c034b02e213d271b98c45c4a7b54af8f69aaac1e
Author: Dirk Brandewie <dirk.j.brandewie@intel.com>
Date:   Mon Oct 13 08:37:40 2014 -0700

    cpufreq: expose scaling_cur_freq sysfs file for set_policy() drivers

Is this intentional? 

Cheers
Jon

-- 
nvpublic
