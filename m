Return-Path: <SRS0=WByN=3C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CAA5C33CAD
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:22:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 38ED62084D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jan 2020 12:22:22 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728674AbgAMMWV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jan 2020 07:22:21 -0500
Received: from foss.arm.com ([217.140.110.172]:38750 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726450AbgAMMWU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jan 2020 07:22:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4291B13D5;
        Mon, 13 Jan 2020 04:22:20 -0800 (PST)
Received: from [192.168.0.103] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F1C303F68E;
        Mon, 13 Jan 2020 04:22:18 -0800 (PST)
Subject: Re: [PATCH] cpu-topology: warn if NUMA configurations conflicts with
 lower layer
To:     "Zengtao (B)" <prime.zeng@hisilicon.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Morten Rasmussen <morten.rasmussen@arm.com>
Cc:     Sudeep Holla <sudeep.holla@arm.com>,
        Linuxarm <linuxarm@huawei.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
References: <1577088979-8545-1-git-send-email-prime.zeng@hisilicon.com>
 <20191231164051.GA4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AE1D3@dggemm526-mbx.china.huawei.com>
 <20200102112955.GC4864@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340AEB67@dggemm526-mbx.china.huawei.com>
 <c43342d0-7e4d-3be0-0fe1-8d802b0d7065@arm.com>
 <678F3D1BB717D949B966B68EAEB446ED340AFCA0@dggemm526-mbx.china.huawei.com>
 <20200103114011.GB19390@bogus>
 <678F3D1BB717D949B966B68EAEB446ED340B31E9@dggemm526-mbx.china.huawei.com>
 <20200109104306.GA10914@e105550-lin.cambridge.arm.com>
 <678F3D1BB717D949B966B68EAEB446ED340BEDD6@dggemm526-mbx.china.huawei.com>
 <1a8f7963-97e9-62cc-12d2-39f816dfaf67@arm.com>
 <678F3D1BB717D949B966B68EAEB446ED340E2592@DGGEMM506-MBX.china.huawei.com>
 <15050bf2-99ec-e604-ab95-827ce86fd693@arm.com>
 <678F3D1BB717D949B966B68EAEB446ED340E420D@DGGEMM506-MBX.china.huawei.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <06aa5fef-9b72-0f6d-9070-831a0c9b8db0@arm.com>
Date:   Mon, 13 Jan 2020 13:22:17 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.2.2
MIME-Version: 1.0
In-Reply-To: <678F3D1BB717D949B966B68EAEB446ED340E420D@DGGEMM506-MBX.china.huawei.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13.01.20 13:08, Zengtao (B) wrote:
>> -----Original Message-----
>> From: Valentin Schneider [mailto:valentin.schneider@arm.com]
>> Sent: Monday, January 13, 2020 7:17 PM
>> To: Zengtao (B); Morten Rasmussen
>> Cc: Sudeep Holla; Linuxarm; Greg Kroah-Hartman; Rafael J. Wysocki;
>> linux-kernel@vger.kernel.org
>> Subject: Re: [PATCH] cpu-topology: warn if NUMA configurations
>> conflicts with lower layer
>>
>> On 13/01/2020 06:51, Zengtao (B) wrote:
>>> I have tried both, this previous one don't work. But this one seems
>> work
>>> correctly with the warning message printout as expected.
>>>
>>
>> Thanks for trying it out.
>>
>>> This patch is based on the fact " non-NUMA spans shouldn't overlap ",
>> I am
>>> not quite sure if this is always true?
>>>
>>
>> I think this is required for get_group() to work properly. Otherwise,
>> successive get_group() calls may override (and break) the sd->groups
>> linking as you initially reported.
>>
>> In your example, for MC level we have
>>
>>   tl->mask(3) == 3-7
>>   tl->mask(4) == 4-7
>>
>> Which partially overlaps, causing the relinking of '7->3' to '7->4'. Valid
>> configurations would be
>>
>>   wholly disjoint:
>>   tl->mask(3) == 0-3
>>   tl->maks(4) == 4-7
>>
>>   equal:
>>   tl->mask(3) == 3-7
>>   tl->mask(4) == 3-7
>>
>>> Anyway, Could you help to raise the new patch?
>>>
>>
>> Ideally I'd like to be able to reproduce this locally first (TBH I'd like
>> to get my first suggestion to work since it's less intrusive). Could you
>> share how you were able to trigger this? Dietmar's been trying to
>> reproduce
>> this with qemu but I don't think he's there just yet.
> 
> Do you have got a hardware platform with clusters?what's the hardware
> Cpu topology?

I can test this with:

sudo qemu-system-aarch64 -kernel ./Image -hda ./qemu-image-aarch64.img
-append 'root=/dev/vda console=ttyAMA0 loglevel=8 sched_debug' -smp
cores=8 --nographic -m 512 -cpu cortex-a53 -machine virt -numa
node,cpus=0-2,nodeid=0 -numa node,cpus=3-7,nodeid=1

and

diff --git a/drivers/base/arch_topology.c b/drivers/base/arch_topology.c
index 1eb81f113786..e941a402e5f1 100644
--- a/drivers/base/arch_topology.c
+++ b/drivers/base/arch_topology.c
@@ -465,6 +465,9 @@ void update_siblings_masks(unsigned int cpuid)
                if (cpuid_topo->package_id != cpu_topo->package_id)
                        continue;

+               if ((cpu < 4 && cpuid > 3) || (cpu > 3 && cpuid < 4))
+                       continue;
+
                cpumask_set_cpu(cpuid, &cpu_topo->core_sibling);
                cpumask_set_cpu(cpu, &cpuid_topo->core_sibling);

on mainline qemu. I do need the hack in update_siblings_masks() since
the topology detection via -smp cores=X, sockets=Y doesn't work yet.






