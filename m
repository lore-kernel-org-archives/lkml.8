Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2A105C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:50:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 127E52073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 10:50:19 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727812AbgFVKuR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 06:50:17 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2348 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726919AbgFVKuO (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 06:50:14 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id A8AFB26D710A9753088E;
        Mon, 22 Jun 2020 11:50:12 +0100 (IST)
Received: from [127.0.0.1] (10.47.7.242) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Mon, 22 Jun
 2020 11:50:11 +0100
Subject: Re: [PATCH v3] driver core: platform: expose numa_node to users in
 sysfs
To:     Barry Song <song.bao.hua@hisilicon.com>,
        <gregkh@linuxfoundation.org>, <rafael@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>,
        <linux-kernel@vger.kernel.org>,
        Prime Zeng <prime.zeng@hisilicon.com>, <linuxarm@huawei.com>
References: <20200619030045.81956-1-song.bao.hua@hisilicon.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <dc66d5a7-fa26-4c56-7445-57f99d3a5018@huawei.com>
Date:   Mon, 22 Jun 2020 11:48:44 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200619030045.81956-1-song.bao.hua@hisilicon.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.47.7.242]
X-ClientProxiedBy: lhreml716-chm.china.huawei.com (10.201.108.67) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 19/06/2020 04:00, Barry Song wrote:
> Some platform devices like ARM SMMU are memory-mapped and populated by ACPI/IORT.
> In this case, NUMA topology of those platform devices are exported by firmware as
> well. Software might care about the numa_node of those devices in order to achieve
> NUMA locality.

Is it generally the case that the SMMU will be in the same NUMA node as 
the endpoint device (which you're driving)? If so, we can get this info 
from sysfs already for the endpoint, and also have a link from the 
endpoint to the iommu for pci devices (which I assume you're interested in):

root@(none)$ ls -l /sys/devices/pci0000:74/0000:74:02.0/ | grep iommu
lrwxrwxrwx 1 root  root 0 Jun 22 10:33 iommu -> 
../../platform/arm-smmu-v3.2.auto/iommu/smmu3.0x0000000140000000
lrwxrwxrwx 1 root  root 0 Jun 22 10:33 iommu_group -> 
../../../kernel/iommu_groups/0
root@(none)$

Thanks,
John
