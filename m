Return-Path: <SRS0=y5Sx=A3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D5F2BC433E2
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:11:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B837520760
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jul 2020 11:11:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgGPLLi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jul 2020 07:11:38 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2490 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726332AbgGPLLi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jul 2020 07:11:38 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id 18781E943ECF9A2B6D13;
        Thu, 16 Jul 2020 12:11:36 +0100 (IST)
Received: from [127.0.0.1] (10.210.168.254) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Thu, 16 Jul
 2020 12:11:35 +0100
Subject: Re: [PATCH] drivers/perf: Fix kernel panic when rmmod PMU modules
 during perf sampling
To:     Will Deacon <will@kernel.org>
CC:     Robin Murphy <robin.murphy@arm.com>, Qi Liu <liuqi115@huawei.com>,
        <mark.rutland@arm.com>, <linux-kernel@vger.kernel.org>,
        <linuxarm@huawei.com>, <zhangshaokun@hisilicon.com>,
        <wang.wanghaifeng@huawei.com>,
        <linux-arm-kernel@lists.infradead.org>
References: <1594891165-8228-1-git-send-email-liuqi115@huawei.com>
 <20200716094144.GC6771@willie-the-truck>
 <a0f3d0c2-6a08-16a5-f7e9-42ac1d96ea11@arm.com>
 <20200716103058.GE7036@willie-the-truck>
 <66a8eb37-b91a-d228-4ea4-8601e5518b31@huawei.com>
 <20200716104422.GF7036@willie-the-truck>
From:   John Garry <john.garry@huawei.com>
Message-ID: <bcf5623d-aba1-8cc2-6702-57020a8ae517@huawei.com>
Date:   Thu, 16 Jul 2020 12:09:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <20200716104422.GF7036@willie-the-truck>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.210.168.254]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16/07/2020 11:44, Will Deacon wrote:
>> Please also note what Qi Liu wrote about being able to unbind the driver and
>> cause the same issue. I don't know if you can about that issue also.
> I guess we have to throw in some '.suppress_bind_attrs = true,' lines as
> well, then?

Yeah, I think it would be a follow up using suppress_bind_attrs. TBH, I 
don't know why this is an opt out feature, than an opt in. Probably a 
good reason...

  I'll queue this as-is, but happy to take a follow-up if somebody
> can test it.
> 

Thanks,
john

