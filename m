Return-Path: <SRS0=faA3=B4=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.1 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1 autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 28755C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:17:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0CEBB2075E
	for <linux-kernel@archiver.kernel.org>; Tue, 18 Aug 2020 09:17:05 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726779AbgHRJRE (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 18 Aug 2020 05:17:04 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48132 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726474AbgHRJRD (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Aug 2020 05:17:03 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 6B5F6BE8540D178E13F7;
        Tue, 18 Aug 2020 17:17:00 +0800 (CST)
Received: from [127.0.0.1] (10.174.179.33) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Tue, 18 Aug 2020
 17:16:49 +0800
Subject: Re: [PATCH v2 0/2] ACPI/IORT: Code cleanups
To:     Zenghui Yu <yuzenghui@huawei.com>, <lorenzo.pieralisi@arm.com>,
        <sudeep.holla@arm.com>
CC:     <linux-acpi@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <wanghaibin.wang@huawei.com>
References: <20200818063625.980-1-yuzenghui@huawei.com>
From:   Hanjun Guo <guohanjun@huawei.com>
Message-ID: <12667629-5c3f-4606-ec27-72e5ef19f35a@huawei.com>
Date:   Tue, 18 Aug 2020 17:16:49 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:68.0) Gecko/20100101
 Thunderbird/68.6.0
MIME-Version: 1.0
In-Reply-To: <20200818063625.980-1-yuzenghui@huawei.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.174.179.33]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/8/18 14:36, Zenghui Yu wrote:
> * From v1 [1]:
>    - As pointed out by Hanjun, remove two now unused inline functions.
>      Compile tested with CONFIG_IOMMU_API is not selected.
> 
> [1] https://lore.kernel.org/r/20200817105946.1511-1-yuzenghui@huawei.com
> 
> Zenghui Yu (2):
>    ACPI/IORT: Drop the unused @ops of iort_add_device_replay()
>    ACPI/IORT: Remove the unused inline functions
> 
>   drivers/acpi/arm64/iort.c | 10 ++--------
>   1 file changed, 2 insertions(+), 8 deletions(-)

Nice cleanup.

Acked-by: Hanjun Guo <guohanjun@huawei.com>

