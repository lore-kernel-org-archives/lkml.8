Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 15A52C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:21:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E4C7620702
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 10:21:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732189AbgFWKVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 06:21:21 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2356 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1731158AbgFWKVS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 06:21:18 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.108])
        by Forcepoint Email with ESMTP id E5BDFB336F6AE3172B42;
        Tue, 23 Jun 2020 11:21:16 +0100 (IST)
Received: from [127.0.0.1] (10.47.2.88) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Tue, 23 Jun
 2020 11:21:15 +0100
Subject: Re: [PATCH 4/4] iommu/arm-smmu-v3: Remove cmpxchg() in
 arm_smmu_cmdq_issue_cmdlist()
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        "joro@8bytes.org" <joro@8bytes.org>
CC:     kernel test robot <lkp@intel.com>, <will@kernel.org>,
        "robin.murphy@arm.com" <robin.murphy@arm.com>,
        "kbuild-all@lists.01.org" <kbuild-all@lists.01.org>,
        "trivial@kernel.org" <trivial@kernel.org>,
        "linux-arm-kernel@lists.infradead.org" 
        <linux-arm-kernel@lists.infradead.org>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Linuxarm <linuxarm@huawei.com>, "maz@kernel.org" <maz@kernel.org>
References: <1592846920-45338-5-git-send-email-john.garry@huawei.com>
 <202006230905.3HpPgtSC%lkp@intel.com>
 <5ba2e240-b324-d316-c00c-38c03ee49baa@huawei.com>
 <CADRDgG4=uD3Ni6r7D3kHdSo=ketaXKGririHfFvPYq4qz8KjfQ@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <ee2d7a1e-3e22-f25a-ced9-82ccced28f8c@huawei.com>
Date:   Tue, 23 Jun 2020 11:19:47 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CADRDgG4=uD3Ni6r7D3kHdSo=ketaXKGririHfFvPYq4qz8KjfQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.2.88]
X-ClientProxiedBy: lhreml730-chm.china.huawei.com (10.201.108.81) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2020 10:35, Rikard Falkeborn wrote:
> 
>     I'd say that GENMASK_INPUT_CHECK() should be able to handle a l=0 and
>     h=unsigned value, so I doubt this warn.
> 
>     Using GENMASK((int)cmdq->q.llq.max_n_shift, 0) resolves it, but it
>     looks
>     like GENMASK_INPUT_CHECK() could be improved.
> 
> 
> Indeed it could, it is fixed in -next.

ok, thanks for the pointer, but I still see this on today's -next with 
this patch:

make W=1 drivers/iommu/arm-smmu-v3.o

In file included from ./include/linux/bits.h:23:0,
                 from ./include/linux/ioport.h:15,
                 from ./include/linux/acpi.h:12,
                 from drivers/iommu/arm-smmu-v3.c:12:
drivers/iommu/arm-smmu-v3.c: In function ‘arm_smmu_cmdq_issue_cmdlist’:
./include/linux/bits.h:27:7: warning: comparison of unsigned expression 
< 0 is always false [-Wtype-limits]
   (l) > (h), 0)))
       ^
./include/linux/build_bug.h:16:62: note: in definition of macro 
‘BUILD_BUG_ON_ZERO’
#define BUILD_BUG_ON_ZERO(e) ((int)(sizeof(struct { int:(-!!(e)); })))
                                                              ^
./include/linux/bits.h:40:3: note: in expansion of macro 
‘GENMASK_INPUT_CHECK’
  (GENMASK_INPUT_CHECK(h, l) + __GENMASK(h, l))
   ^~~~~~~~~~~~~~~~~~~
drivers/iommu/arm-smmu-v3.c:1404:18: note: in expansion of macro ‘GENMASK’
  u32 prod_mask = GENMASK(cmdq->q.llq.max_n_shift, 0);

That's gcc 7.5.0 .

Cheers,
John

