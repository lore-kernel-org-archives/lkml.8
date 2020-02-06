Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 94013C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:22:35 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 6902D20838
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 06:22:35 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727841AbgBFGWe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 01:22:34 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10158 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726060AbgBFGWe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 01:22:34 -0500
Received: from DGGEMS406-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 40B44A058A6BDADCB195;
        Thu,  6 Feb 2020 14:22:30 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS406-HUB.china.huawei.com
 (10.3.19.206) with Microsoft SMTP Server id 14.3.439.0; Thu, 6 Feb 2020
 14:22:24 +0800
Subject: Re: [PATCH 0/5] irqchip/gic-v4.1: Cleanup and fixes for GICv4.1
To:     Marc Zyngier <maz@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <tglx@linutronix.de>,
        <jason@lakedaemon.net>, <wanghaibin.wang@huawei.com>
References: <20200204090940.1225-1-yuzenghui@huawei.com>
 <004ca9ea2d525d5b1bcf1d78f10c61ba@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <df640d5a-e7ba-b1c8-51f9-89b843ad6adb@huawei.com>
Date:   Thu, 6 Feb 2020 14:22:23 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <004ca9ea2d525d5b1bcf1d78f10c61ba@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2020/2/5 20:46, Marc Zyngier wrote:
> Hi Zenghui,
> 
> On 2020-02-04 09:09, Zenghui Yu wrote:
>> Hi,
>>
>> This series contains some cleanups, VPROPBASER field programming fix
>> and level2 vPE table allocation enhancement, collected while looking
>> through the GICv4.1 driver one more time.
>>
>> Hope they will help, thanks!
>>
>> Zenghui Yu (5):
>>   irqchip/gic-v4.1: Fix programming of GICR_VPROPBASER_4_1_SIZE
>>   irqchip/gic-v4.1: Set vpe_l1_base for all redistributors
>>   irqchip/gic-v4.1: Ensure L2 vPE table is allocated at RD level
>>   irqchip/gic-v4.1: Drop 'tmp' in inherit_vpe_l1_table_from_rd()
>>   irqchip/gic-v3-its: Remove superfluous WARN_ON
>>
>>  drivers/irqchip/irq-gic-v3-its.c   | 80 +++++++++++++++++++++++++++---
>>  include/linux/irqchip/arm-gic-v3.h |  2 +-
>>  2 files changed, 75 insertions(+), 7 deletions(-)
> 
> Thanks a lot for this, much appreciated, I'm quite happy with the overall
> state of the series. If you can just address the couple of nits I have on
> patch #3, I'll then queue the series and send off to Thomas together with
> the rest of the queued fixes.

I will respin patch#3 with your suggestion and send v2 today.
Thanks for your review!


Zenghui

