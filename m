Return-Path: <SRS0=Xzqw=5F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F250AC4332B
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:09:27 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id D368E20732
	for <linux-kernel@archiver.kernel.org>; Fri, 20 Mar 2020 12:09:27 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727046AbgCTMJ0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 20 Mar 2020 08:09:26 -0400
Received: from szxga06-in.huawei.com ([45.249.212.32]:43746 "EHLO huawei.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1726969AbgCTMJ0 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 Mar 2020 08:09:26 -0400
Received: from DGGEMS402-HUB.china.huawei.com (unknown [172.30.72.60])
        by Forcepoint Email with ESMTP id 01604CD906C56B9B967F;
        Fri, 20 Mar 2020 20:09:21 +0800 (CST)
Received: from [127.0.0.1] (10.173.222.27) by DGGEMS402-HUB.china.huawei.com
 (10.3.19.202) with Microsoft SMTP Server id 14.3.487.0; Fri, 20 Mar 2020
 20:09:13 +0800
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
 <8d7fdb7f-7a21-da22-52a2-51ee8ac9393f@huawei.com>
 <40cbdf23c0f8bfc229400c14899ecbe0@kernel.org>
From:   Zenghui Yu <yuzenghui@huawei.com>
Message-ID: <facb4eb5-57c6-e0d0-003d-ebaa0b83e6f2@huawei.com>
Date:   Fri, 20 Mar 2020 20:09:11 +0800
User-Agent: Mozilla/5.0 (Windows NT 10.0; WOW64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.0
MIME-Version: 1.0
In-Reply-To: <40cbdf23c0f8bfc229400c14899ecbe0@kernel.org>
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

On 2020/3/20 19:46, Marc Zyngier wrote:
>>> Side note: it'd be good to know what the rules are for your own GICv4
>>> implementations, so that we can at least make sure the current code 
>>> is safe.
>>
>> As far as I know, there will be some clean and invalidate operations
>> when v4.0 VPENDBASER.Valid gets programmed.
> 
> Interesting. The ideal behaviour would be that the VPT is up-to-date and
> the caches clean when Valid is cleared (and once Dirty flips to 0).
> 
>> But not sure about behaviors
>> on VMAPP (unmap), it may be a totally v4.1 stuff. I'll have a talk with
>> our SOC team.
> 
> The VMAPP stuff is purely v4.1.
> 
>> But how can the current code be unsafe? Is anywhere in the current code
>> will peek/poke the vpt (whilst GIC continues writing things into it)?
> 
> No. But on VM termination, the memory will be freed, and will eventually be
> reallocated. If the GIC can still write to that memory after it has been
> freed, you end-up with memory corruption... Which is why I'm curious of
> what ensures that on your implementation.

Ah, I got it. I will check it with HiSilicon people next week and go
back to you if the code becomes unsafe due to the incomplete GICv4.


Thanks,
Zenghui

