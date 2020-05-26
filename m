Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63DE8C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 06:40:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B8B0207D8
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 06:40:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728607AbgEZGkv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 02:40:51 -0400
Received: from szxga05-in.huawei.com ([45.249.212.191]:5281 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727075AbgEZGkv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 02:40:51 -0400
Received: from DGGEMS412-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 43581B913C77D32BEFE4;
        Tue, 26 May 2020 14:40:48 +0800 (CST)
Received: from [127.0.0.1] (10.173.220.25) by DGGEMS412-HUB.china.huawei.com
 (10.3.19.212) with Microsoft SMTP Server id 14.3.487.0; Tue, 26 May 2020
 14:40:40 +0800
Subject: Re: [PATCH v3 1/6] arm64: Detect the ARMv8.4 TTL feature
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        <catalin.marinas@arm.com>, <peterz@infradead.org>,
        <mark.rutland@arm.com>, <will@kernel.org>,
        <aneesh.kumar@linux.ibm.com>, <akpm@linux-foundation.org>,
        <npiggin@gmail.com>, <arnd@arndb.de>, <rostedt@goodmis.org>,
        <maz@kernel.org>, <suzuki.poulose@arm.com>, <tglx@linutronix.de>,
        <yuzhao@google.com>, <Dave.Martin@arm.com>, <steven.price@arm.com>,
        <broonie@kernel.org>, <guohanjun@huawei.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <linux-arch@vger.kernel.org>,
        <linux-mm@kvack.org>, <arm@kernel.org>, <xiexiangyou@huawei.com>,
        <prime.zeng@hisilicon.com>, <zhangshaokun@hisilicon.com>,
        <kuhn.chenqun@huawei.com>
References: <20200525125300.794-1-yezhenyu2@huawei.com>
 <20200525125300.794-2-yezhenyu2@huawei.com>
 <c6b6eb07-2606-9fc0-280a-e53b81a6491c@arm.com>
From:   Zhenyu Ye <yezhenyu2@huawei.com>
Message-ID: <050b7ee6-c7aa-5d61-4dff-4792a411464e@huawei.com>
Date:   Tue, 26 May 2020 14:40:38 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.3.0
MIME-Version: 1.0
In-Reply-To: <c6b6eb07-2606-9fc0-280a-e53b81a6491c@arm.com>
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.220.25]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Anshuman,

On 2020/5/26 10:39, Anshuman Khandual wrote:
> This patch (https://patchwork.kernel.org/patch/11557359/) is adding some
> more ID_AA64MMFR2 features including the TTL. I am going to respin parts
> of the V4 series patches along with the above mentioned patch. So please
> rebase this series accordingly, probably on latest next.
> 

I noticed that some patches of your series have been merged into arm64
tree (for-next/cpufeature), such as TLB range, but this one not. Why?

BTW, this patch is provided by Marc in his NV series [1], maybe you
should also let him know.

I will rebase my series after your patch is merged.

[1] https://lore.kernel.org/linux-arm-kernel/d6032191-ba0e-82a4-4dde-11beef369a11@arm.com/

Thanks,
Zhenyu

