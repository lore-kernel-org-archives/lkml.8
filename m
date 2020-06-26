Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.5 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 728C6C433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:06:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5901D206C0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 10:06:50 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726671AbgFZKGs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 06:06:48 -0400
Received: from lhrrgout.huawei.com ([185.176.76.210]:2362 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725283AbgFZKGs (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 06:06:48 -0400
Received: from lhreml724-chm.china.huawei.com (unknown [172.18.7.107])
        by Forcepoint Email with ESMTP id 040B89BFDCAC94704736;
        Fri, 26 Jun 2020 11:06:46 +0100 (IST)
Received: from [127.0.0.1] (10.47.7.19) by lhreml724-chm.china.huawei.com
 (10.201.108.75) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.1913.5; Fri, 26 Jun
 2020 11:06:44 +0100
Subject: Re: [PATCH 4/4] iommu/arm-smmu-v3: Remove cmpxchg() in
 arm_smmu_cmdq_issue_cmdlist()
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
CC:     Joerg Roedel <joro@8bytes.org>, kernel test robot <lkp@intel.com>,
        <will@kernel.org>, "robin.murphy@arm.com" <robin.murphy@arm.com>,
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
 <ee2d7a1e-3e22-f25a-ced9-82ccced28f8c@huawei.com>
 <CADRDgG5pOstGK=fm8s3Be_v8+vc-EyRYmpiMsTCeK-rMk2ZRQQ@mail.gmail.com>
From:   John Garry <john.garry@huawei.com>
Message-ID: <4f87e2e4-ec7d-49d1-037c-158e94f25ab6@huawei.com>
Date:   Fri, 26 Jun 2020 11:05:13 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.1.2
MIME-Version: 1.0
In-Reply-To: <CADRDgG5pOstGK=fm8s3Be_v8+vc-EyRYmpiMsTCeK-rMk2ZRQQ@mail.gmail.com>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.47.7.19]
X-ClientProxiedBy: lhreml714-chm.china.huawei.com (10.201.108.65) To
 lhreml724-chm.china.huawei.com (10.201.108.75)
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 23/06/2020 14:55, Rikard Falkeborn wrote:
> Den tis 23 juni 2020 12:21John Garry <john.garry@huawei.com 
> <mailto:john.garry@huawei.com>> skrev:
> 
>     On 23/06/2020 10:35, Rikard Falkeborn wrote:
>      >
>      >     I'd say that GENMASK_INPUT_CHECK() should be able to handle a
>     l=0 and
>      >     h=unsigned value, so I doubt this warn.
>      >
>      >     Using GENMASK((int)cmdq->q.llq.max_n_shift, 0) resolves it,
>     but it
>      >     looks
>      >     like GENMASK_INPUT_CHECK() could be improved.
>      >
>      >
>      > Indeed it could, it is fixed in -next.
> 
>     ok, thanks for the pointer, but I still see this on today's -next with
>     this patch:
> 
>     make W=1 drivers/iommu/arm-smmu-v3.o
> 
> 
> Oh, ok thanks for reporting. I guess different gcc versions have 
> different behaviour. I guess we'll have to change the comparison to 
> (!((h) == (l) || (h) > (l))) instead (not sure I got all parenthesis and 
> logic correct but you get the idea).
> 

Yeah, so this looks to fix it:

--- a/include/linux/bits.h
+++ b/include/linux/bits.h
@@ -23,7 +23,8 @@
#include <linux/build_bug.h>
#define GENMASK_INPUT_CHECK(h, l) \
        (BUILD_BUG_ON_ZERO(__builtin_choose_expr( \
-               __builtin_constant_p((l) > (h)), (l) > (h), 0)))
+               __builtin_constant_p(!((h) == (l) ||(h) > (l))), !((h) 
== (l) ||(h) > (l)), 0)))
+

We may be able to just use (h) == (l) as the const expr to make it more 
concise, but that may be confusing.

I only tested with my toolchain based on 7.5.0

Thanks,
John

