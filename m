Return-Path: <SRS0=j27y=4W=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A147CC3F2CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:05:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7718B208CD
	for <linux-kernel@archiver.kernel.org>; Thu,  5 Mar 2020 10:05:13 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726974AbgCEKFM (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 5 Mar 2020 05:05:12 -0500
Received: from foss.arm.com ([217.140.110.172]:46648 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725880AbgCEKFM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 Mar 2020 05:05:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C89F331B;
        Thu,  5 Mar 2020 02:05:11 -0800 (PST)
Received: from [10.37.12.115] (unknown [10.37.12.115])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 73E993F6C4;
        Thu,  5 Mar 2020 02:05:07 -0800 (PST)
Subject: Re: [PATCH] drm/exynos: Fix memory leak and release IOMMU mapping
 structures
To:     Marek Szyprowski <m.szyprowski@samsung.com>,
        linux-kernel@vger.kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org
Cc:     inki.dae@samsung.com, jy0922.shim@samsung.com,
        sw0312.kim@samsung.com, kyungmin.park@samsung.com,
        airlied@linux.ie, daniel@ffwll.ch, kgene@kernel.org,
        krzk@kernel.org, b.zolnierkie@samsung.com, a.hajda@samsung.com,
        Dietmar.Eggemann@arm.com
References: <CGME20200304220106eucas1p232aae5af79945664c4586930a9412eda@eucas1p2.samsung.com>
 <20200304220022.8003-1-lukasz.luba@arm.com>
 <684ef9fb-eafb-22d3-40c1-50f596211d85@samsung.com>
From:   Lukasz Luba <lukasz.luba@arm.com>
Message-ID: <1044756c-39cf-9fea-4338-40e5a68349a9@arm.com>
Date:   Thu, 5 Mar 2020 10:05:03 +0000
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:60.0) Gecko/20100101
 Thunderbird/60.9.0
MIME-Version: 1.0
In-Reply-To: <684ef9fb-eafb-22d3-40c1-50f596211d85@samsung.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marek,

On 3/5/20 7:07 AM, Marek Szyprowski wrote:
> Hi Lukasz,
> 
> On 04.03.2020 23:00, Lukasz Luba wrote:
>> There is a memory leak which left some objects not freed. The reference
>> counter of mapping: 'mapping->kref' was 2 when calling
>> arm_iommu_detach_device(), so the release_iommu_mapping() won't be called.
>> Since the old mapping structure is not going to be used any more (because
>> it is detached and new one attached), call arm_iommu_release_mapping()
>> to trigger cleanup.
> 
> This will break IOMMU support in Exynos DRM if deferred probe happens.
> Here is a proper fix:

I forgot about the deferred probe.

> 
> https://patchwork.kernel.org/patch/11415715/
> 
> The mapping initially created by DMA-mapping framework should be
> attached back when Exynos DRM releases the subdev device.
> 

Indeed, as you responded in that thread with the example, there is
more dependencies and attaching back the old mapping will work.

I am going add my reviewed-by to your patch.

Regards,
Lukasz
