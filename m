Return-Path: <SRS0=9JlO=3L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 07410C2D0CE
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 02:59:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CE0992087E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Jan 2020 02:59:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729047AbgAVC7d (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 21 Jan 2020 21:59:33 -0500
Received: from szxga06-in.huawei.com ([45.249.212.32]:34514 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1728779AbgAVC7c (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jan 2020 21:59:32 -0500
Received: from DGGEMS403-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id ADF7244081C22D3B539C;
        Wed, 22 Jan 2020 10:59:30 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS403-HUB.china.huawei.com
 (10.3.19.203) with Microsoft SMTP Server id 14.3.439.0; Wed, 22 Jan 2020
 10:59:21 +0800
Subject: Re: [PATCH v3 05/32] irqchip/gic-v4.1: VPE table (aka
 GICR_VPROPBASER) allocation
To:     Marc Zyngier <maz@kernel.org>, <kvmarm@lists.cs.columbia.edu>,
        <linux-kernel@vger.kernel.org>
CC:     Eric Auger <eric.auger@redhat.com>,
        James Morse <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Jason Cooper <jason@lakedaemon.net>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        "Andrew Murray" <Andrew.Murray@arm.com>,
        Robert Richter <rrichter@marvell.com>
References: <20191224111055.11836-1-maz@kernel.org>
 <20191224111055.11836-6-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <1c278098-f365-2b50-ce60-b27faeef2e48@huawei.com>
Date:   Wed, 22 Jan 2020 10:59:19 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20191224111055.11836-6-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2019/12/24 19:10, Marc Zyngier wrote:

> @@ -4147,6 +4453,8 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
>   	bool has_v4 = false;
>   	int err;
>   
> +	gic_rdists = rdists;
> +
>   	its_parent = parent_domain;
>   	of_node = to_of_node(handle);
>   	if (of_node)
> @@ -4159,8 +4467,6 @@ int __init its_init(struct fwnode_handle *handle, struct rdists *rdists,
>   		return -ENXIO;
>   	}
>   
> -	gic_rdists = rdists;
> -
>   	err = allocate_lpi_tables();
>   	if (err)
>   		return err;

And shouldn't this be part of patch#2?  (As the new ITS_MAX_VPEID_BITS
would use gic_rdists in the allocation of ITS vPE table.)

But I haven't tested the first two patches separately, I guess it may
crash my box ;-)


Thanks,
Zenghui

