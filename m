Return-Path: <SRS0=7zi/=BF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 47796C433E0
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 11:46:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 226D2206D8
	for <linux-kernel@archiver.kernel.org>; Sun, 26 Jul 2020 11:46:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=nvidia.com header.i=@nvidia.com header.b="Y4tMSRGb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726732AbgGZLqm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 26 Jul 2020 07:46:42 -0400
Received: from hqnvemgate24.nvidia.com ([216.228.121.143]:11912 "EHLO
        hqnvemgate24.nvidia.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725794AbgGZLqm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jul 2020 07:46:42 -0400
Received: from hqpgpgate101.nvidia.com (Not Verified[216.228.121.13]) by hqnvemgate24.nvidia.com (using TLS: TLSv1.2, DES-CBC3-SHA)
        id <B5f1d6cc80001>; Sun, 26 Jul 2020 04:45:13 -0700
Received: from hqmail.nvidia.com ([172.20.161.6])
  by hqpgpgate101.nvidia.com (PGP Universal service);
  Sun, 26 Jul 2020 04:46:41 -0700
X-PGP-Universal: processed;
        by hqpgpgate101.nvidia.com on Sun, 26 Jul 2020 04:46:41 -0700
Received: from [10.24.37.103] (172.20.13.39) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1473.3; Sun, 26 Jul
 2020 11:46:29 +0000
Subject: Re: [PATCH -next] arm64: Export __cpu_logical_map
To:     Sudeep Holla <sudeep.holla@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
CC:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Mikko Perttunen <mperttunen@nvidia.com>,
        Viresh Kumar <viresh.kumar@linaro.org>,
        Hulk Robot <hulkci@huawei.com>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        Sumit Gupta <sumitg@nvidia.com>, Bibek Basu <bbasu@nvidia.com>
References: <20200724030433.22287-1-wangkefeng.wang@huawei.com>
 <82f750c4-d423-1ed8-a158-e75153745e07@huawei.com>
 <20200724131059.GB6521@bogus>
From:   Sumit Gupta <sumitg@nvidia.com>
Message-ID: <00cf6e67-16ed-872d-2c16-0ceea6b6f514@nvidia.com>
Date:   Sun, 26 Jul 2020 17:16:27 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <20200724131059.GB6521@bogus>
X-Originating-IP: [172.20.13.39]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 HQMAIL107.nvidia.com (172.20.187.13)
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=nvidia.com; s=n1;
        t=1595763913; bh=g94Wu67n5RZjhKkaJ+xeY3ndTckRMdJqobOgyGCi+/0=;
        h=X-PGP-Universal:Subject:To:CC:References:From:Message-ID:Date:
         User-Agent:MIME-Version:In-Reply-To:X-Originating-IP:
         X-ClientProxiedBy:Content-Type:Content-Language:
         Content-Transfer-Encoding;
        b=Y4tMSRGbI6/makO3NIdpKmdsR4VJ2wNlFQDmHtTPH3P4fRtjuJejU4CdzjAR7qowK
         BWYXh5cZrw0NT+ejjKSTVmozZi2meJpfT8h7TC3Jdy/6En0Q+Q0Y14XHkGIOhu6QRK
         dYzMrgldjNbRl20DLBI5URvDvwEYBZcQBWkph6MPOEr07fYgW4/jsqp3wGLzN4jPOd
         SOJ9CXp6Z5M4mkpGbbmYLs0Vp5C9lZg/ZawqE2egxIHIzdbGi4lvX5T+hbwSDEqwP6
         fqBeMuxi+lQrGZSP2W6UsKbLk1rqnbfTk6KMiMDkxNhhNK+mm6u/oUfDVDnXiOP29h
         C4ipl48yTJxkQ==
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

>>> ERROR: modpost: "__cpu_logical_map" [drivers/cpufreq/tegra194-cpufreq.ko] undefined!
>>>
>>> ARM64 tegra194-cpufreq driver use cpu_logical_map, export
>>> __cpu_logical_map to fix build issue.
>>>
> 
> I wonder why like other instances in the drivers, the mpidr is not get
> directly from the cpu. The cpufreq_driver->init call happens when the cpu
> is being brought online and is executed on the required cpu IIUC.
> 
Yes, this occurs during hotplug case.
But in the case of system boot, 'cpufreq_driver->init' is called later 
during cpufreq platform driver's probe. The value of CPU in 
'policy->cpu' can be different from the current CPU. That's why 
read_cpuid_mpidr() can't be used.

> read_cpuid_mpidr() is inline and avoids having to export the logical_cpu_map.
> Though we may not add physical hotplug anytime soon, less dependency
> on this cpu_logical_map is better given that we can resolve this without
> the need to access the map.
> 
> --
> Regards,
> Sudeep
> 
