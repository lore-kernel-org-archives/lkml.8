Return-Path: <SRS0=Fjb+=5D=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36D6DC2BB1D
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 03:29:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 1861A20752
	for <linux-kernel@archiver.kernel.org>; Wed, 18 Mar 2020 03:29:09 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726967AbgCRD3I (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 23:29:08 -0400
Received: from szxga04-in.huawei.com ([45.249.212.190]:11656 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726550AbgCRD3H (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 23:29:07 -0400
Received: from DGGEMS410-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 17D9D86B7533D136EEE3;
        Wed, 18 Mar 2020 11:29:06 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS410-HUB.china.huawei.com
 (10.3.19.210) with Microsoft SMTP Server id 14.3.487.0; Wed, 18 Mar 2020
 11:28:58 +0800
Subject: Re: [PATCH v5 18/23] KVM: arm64: GICv4.1: Add direct injection
 capability to SGI registers
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
References: <20200304203330.4967-1-maz@kernel.org>
 <20200304203330.4967-19-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <9c518e1d-5a0a-5438-a37d-d9250c4e6320@huawei.com>
Date:   Wed, 18 Mar 2020 11:28:56 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200304203330.4967-19-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marc,

On 2020/3/5 4:33, Marc Zyngier wrote:
> Most of the GICv3 emulation code that deals with SGIs now has to be
> aware of the v4.1 capabilities in order to benefit from it.
> 
> Add such support, keyed on the interrupt having the hw flag set and
> being a SGI.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>


Thanks

