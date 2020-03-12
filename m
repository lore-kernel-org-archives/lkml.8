Return-Path: <SRS0=+FT0=45=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D819EC10DCE
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:20:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BBC32206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 12 Mar 2020 08:20:18 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726467AbgCLIUR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 12 Mar 2020 04:20:17 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:45756 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1725978AbgCLIUR (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 Mar 2020 04:20:17 -0400
Received: from DGGEMS407-HUB.china.huawei.com (unknown [172.30.72.59])
        by Forcepoint Email with ESMTP id C0638E51DBA77F9B6D9A;
        Thu, 12 Mar 2020 16:20:13 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS407-HUB.china.huawei.com
 (10.3.19.207) with Microsoft SMTP Server id 14.3.487.0; Thu, 12 Mar 2020
 16:20:03 +0800
Subject: Re: [PATCH v5 13/23] irqchip/gic-v4.1: Move doorbell management to
 the GICv4 abstraction layer
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
 <20200304203330.4967-14-maz@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <d84de24d-e179-49ab-ddc7-4d93c5cf8e6b@huawei.com>
Date:   Thu, 12 Mar 2020 16:20:01 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <20200304203330.4967-14-maz@kernel.org>
Content-Type: text/plain; charset="utf-8"; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
X-Originating-IP: [10.173.222.27]
X-CFilter-Loop: Reflected
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020/3/5 4:33, Marc Zyngier wrote:
> In order to hide some of the differences between v4.0 and v4.1, move
> the doorbell management out of the KVM code, and into the GICv4-specific
> layer. This allows the calling code to ask for the doorbell when blocking,
> and otherwise to leave the doorbell permanently disabled.
> 
> This matches the v4.1 code perfectly, and only results in a minor
> refactoring of the v4.0 code.
> 
> Signed-off-by: Marc Zyngier <maz@kernel.org>

Reviewed-by: Zenghui Yu <yuzenghui@huawei.com>


Thanks

