Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 713F7C4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:36:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 535A120754
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 11:36:02 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727113AbgCTLgB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 07:36:01 -0400
Received: from szxga07-in.huawei.com ([45.249.212.35]:48830 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726814AbgCTLgA (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 07:36:00 -0400
Received: from DGGEMS411-HUB.china.huawei.com (unknown [172.30.72.58])
        by Forcepoint Email with ESMTP id 83C19E8B7FC2A4E3E951;
        Fri, 20 Mar 2020 19:35:48 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS411-HUB.china.huawei.com
 (10.3.19.211) with Microsoft SMTP Server id 14.3.487.0; Fri, 20 Mar 2020
 19:35:41 +0800
Subject: Re: [PATCH v5 23/23] KVM: arm64: GICv4.1: Expose HW-based SGIs in
 debugfs
To:     Marc Zyngier <maz@kernel.org>
CC:     Auger Eric <eric.auger@redhat.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <kvmarm@lists.cs.columbia.edu>, <kvm@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>,
        Lorenzo Pieralisi <lorenzo.pieralisi@arm.com>,
        Jason Cooper <jason@lakedaemon.net>,
        "Robert Richter" <rrichter@marvell.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        "James Morse" <james.morse@arm.com>,
        Julien Thierry <julien.thierry.kdev@gmail.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>
References: <20200304203330.4967-1-maz@kernel.org>
 <20200304203330.4967-24-maz@kernel.org>
 <4cb4c3d4-7b02-bb77-cd7a-c185346b6a2f@redhat.com>
 <45c282bddd43420024633943c1befac3@kernel.org>
 <e1a1e537-9f8e-5cfb-0132-f796e8bf06c9@huawei.com>
 <b63950513f519d9a04f9719f5aa6a2db@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <8d7fdb7f-7a21-da22-52a2-51ee8ac9393f@huawei.com>
Date:   Fri, 20 Mar 2020 19:35:39 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <b63950513f519d9a04f9719f5aa6a2db@kernel.org>
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

On 2020/3/20 17:09, Marc Zyngier wrote:
> Hi Zenghui,
> 
> On 2020-03-20 04:38, Zenghui Yu wrote:
>> Hi Marc,
>>
>> On 2020/3/19 23:21, Marc Zyngier wrote:
>>> With GICv4.1, you can introspect the HW state for SGIs. You can also
>>> look at the vLPI state by peeking at the virtual pending table, but
>>> you'd need to unmap the VPE first,
>>
>> Out of curiosity, could you please point me to the "unmap the VPE"
>> requirement in the v4.1 spec? I'd like to have a look.
> 
> Sure. See IHI0069F, 5.3.19 (VMAPP GICv4.1), "Caching of virtual LPI data
> structures", and the bit that says:
> 
> "A VMAPP with {V,Alloc}=={0,1} cleans and invalidates any caching of the
> Virtual Pending Table and Virtual Configuration Table associated with the
> vPEID held in the GIC"
> 
> which is what was crucially missing from the GICv4.0 spec (it doesn't say
> when the GIC is done writing to memory).

OK. Thanks for the pointer!

> 
> Side note: it'd be good to know what the rules are for your own GICv4
> implementations, so that we can at least make sure the current code is 
> safe.

As far as I know, there will be some clean and invalidate operations
when v4.0 VPENDBASER.Valid gets programmed. But not sure about behaviors
on VMAPP (unmap), it may be a totally v4.1 stuff. I'll have a talk with
our SOC team.

But how can the current code be unsafe? Is anywhere in the current code
will peek/poke the vpt (whilst GIC continues writing things into it)?


Thanks,
Zenghui

