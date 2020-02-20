Return-Path: <SRS0=NukP=4I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C98E6C5ACC4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 03:18:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A610024656
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Feb 2020 03:18:00 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727987AbgBTDR7 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Feb 2020 22:17:59 -0500
Received: from szxga04-in.huawei.com ([45.249.212.190]:10652 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1727476AbgBTDR7 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Feb 2020 22:17:59 -0500
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id 4EA016CB1DDE32654D92;
        Thu, 20 Feb 2020 11:17:57 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.439.0; Thu, 20 Feb 2020
 11:17:49 +0800
Subject: Re: [PATCH v4 04/20] irqchip/gic-v4.1: Map the ITS SGIR register page
To:     Marc Zyngier <maz@kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
CC:     Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        Robert Richter <rrichter@marvell.com>,
        "Thomas Gleixner" <tglx@linutronix.de>,
        Eric Auger <eric.auger@redhat.com>,
        "James Morse" <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20200214145736.18550-1-maz@kernel.org>
 <20200214145736.18550-5-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <154bd918-de16-e810-d10d-e7642e340415@huawei.com>
Date:   Thu, 20 Feb 2020 11:17:47 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200214145736.18550-5-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/2/14 22:57, Marc Zyngier wrote:
> One of the new features of GICv4.1 is to allow virtual SGIs to be
> directly signaled to a VPE. For that, the ITS has grown a new
> 64kB page containing only a single register that is used to
> signal a SGI to a given VPE.
> 
> Add a second mapping covering this new 64kB range, and take this
> opportunity to limit the original mapping to 64kB, which is enough
> to cover the span of the ITS registers.

Yes, no need to do ioremap for the translation register.

> 
> Signed-off-by: Marc Zyngier<maz@kernel.org>

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>

