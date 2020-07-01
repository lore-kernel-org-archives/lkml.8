Return-Path: <SRS0=SbvM=AM=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2BA0CC433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:53:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0406E20747
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Jul 2020 10:53:15 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730144AbgGAKxO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Jul 2020 06:53:14 -0400
Received: from foss.arm.com ([217.140.110.172]:57020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729892AbgGAKxN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jul 2020 06:53:13 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B597030E;
        Wed,  1 Jul 2020 03:53:12 -0700 (PDT)
Received: from [10.57.21.32] (unknown [10.57.21.32])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BB9483F73C;
        Wed,  1 Jul 2020 03:53:08 -0700 (PDT)
Subject: Re: [PATCH v3 00/34] iommu: Move iommu_group setup to IOMMU core code
To:     Qian Cai <cai@lca.pw>, Joerg Roedel <joro@8bytes.org>
Cc:     Heiko Stuebner <heiko@sntech.de>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        linux-tegra@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        Daniel Drake <drake@endlessm.com>,
        Will Deacon <will@kernel.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.org>,
        linux-samsung-soc@vger.kernel.org,
        iommu@lists.linux-foundation.org,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        linux-rockchip@lists.infradead.org, Andy Gross <agross@kernel.org>,
        jonathan.derrick@intel.com, linux-s390@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, linux-mediatek@lists.infradead.org,
        Matthias Brugger <matthias.bgg@gmail.com>,
        virtualization@lists.linux-foundation.org,
        Gerald Schaefer <gerald.schaefer@de.ibm.com>,
        David Woodhouse <dwmw2@infradead.org>,
        linux-kernel@vger.kernel.org, Kukjin Kim <kgene@kernel.org>
References: <20200429133712.31431-1-joro@8bytes.org>
 <20200701004020.GA6221@lca.pw>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <9b0ef27a-f249-a90b-9899-e53b946f83cc@arm.com>
Date:   Wed, 1 Jul 2020 11:53:07 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.9.0
MIME-Version: 1.0
In-Reply-To: <20200701004020.GA6221@lca.pw>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-07-01 01:40, Qian Cai wrote:
> Looks like this patchset introduced an use-after-free on arm-smmu-v3.
> 
> Reproduced using mlx5,
> 
> # echo 1 > /sys/class/net/enp11s0f1np1/device/sriov_numvfs
> # echo 0 > /sys/class/net/enp11s0f1np1/device/sriov_numvfs
> 
> The .config,
> https://github.com/cailca/linux-mm/blob/master/arm64.config
> 
> Looking at the free stack,
> 
> iommu_release_device->iommu_group_remove_device
> 
> was introduced in 07/34 ("iommu: Add probe_device() and release_device()
> call-backs").

Right, iommu_group_remove_device can tear down the group and call 
->domain_free before the driver has any knowledge of the last device 
going away via the ->release_device call.

I guess the question is do we simply flip the call order in 
iommu_release_device() so drivers can easily clean up their internal 
per-device state first, or do we now want them to be robust against 
freeing domains with devices still nominally attached?

Robin.
