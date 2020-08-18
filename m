Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,NICE_REPLY_A,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DB5D5C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:50:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B9E8D2076D
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 03:50:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726541AbgHRDuC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 23:50:02 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:9827 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726302AbgHRDuC (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 23:50:02 -0400
Received: from DGGEMS409-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 837AC39DF0EADA83333A;
        Tue, 18 Aug 2020 11:50:00 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.33) by DGGEMS409-HUB.china.huawei.com
 (10.3.19.209) with Microsoft SMTP Server id 14.3.487.0; Tue, 18 Aug 2020
 11:49:53 +0800
Subject: Re: [PATCH] ACPI/IORT: Drop the unused @ops of
 iort_add_device_replay()
To:     Zenghui Yu <yuzenghui@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>
References: <20200817105946.1511-1-yuzenghui@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <8b15f022-8fb9-aa5c-fcd8-f92d4878a0a3@huawei.com>
Date:   Tue, 18 Aug 2020 11:49:52 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200817105946.1511-1-yuzenghui@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.33]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/17 18:59, Zenghui Yu wrote:
> Since commit d2e1a003af56 ("ACPI/IORT: Don't call iommu_ops->add_device
> directly"), we use the IOMMU core API to replace a direct invoke of the
> specified callback. The parameter @ops has therefore became unused. Let's
> drop it.
> 
> Signed-off-by: Zenghui Yu <yuzenghui@huawei.com>
> ---
>   drivers/acpi/arm64/iort.c | 8 +++-----
>   1 file changed, 3 insertions(+), 5 deletions(-)
> 
> diff --git a/drivers/acpi/arm64/iort.c b/drivers/acpi/arm64/iort.c
> index ec782e4a0fe4..a0ece0e201b2 100644
> --- a/drivers/acpi/arm64/iort.c
> +++ b/drivers/acpi/arm64/iort.c
> @@ -811,8 +811,7 @@ static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev)
>   	return (fwspec && fwspec->ops) ? fwspec->ops : NULL;
>   }
>   
> -static inline int iort_add_device_replay(const struct iommu_ops *ops,
> -					 struct device *dev)
> +static inline int iort_add_device_replay(struct device *dev)
>   {
>   	int err = 0;
>   
> @@ -1072,7 +1071,7 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>   	 */
>   	if (!err) {
>   		ops = iort_fwspec_iommu_ops(dev);
> -		err = iort_add_device_replay(ops, dev);
> +		err = iort_add_device_replay(dev);
>   	}
>   
>   	/* Ignore all other errors apart from EPROBE_DEFER */
> @@ -1089,8 +1088,7 @@ const struct iommu_ops *iort_iommu_configure_id(struct device *dev,
>   #else
>   static inline const struct iommu_ops *iort_fwspec_iommu_ops(struct device *dev)
>   { return NULL; }
> -static inline int iort_add_device_replay(const struct iommu_ops *ops,
> -					 struct device *dev)
> +static inline int iort_add_device_replay(struct device *dev)

inline functions iort_fwspec_iommu_ops() and iort_add_device_replay()
are not needed anymore after commit 8212688600ed ("ACPI/IORT: Fix build
error when IOMMU_SUPPORT is disabled"), could you please add another
patch to remove them as well?

Thanks
Hanjun

