Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6DBEDC282DD
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 15:12:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 43AE72082E
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 15:12:52 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729895AbgAKPMv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 11 Jan 2020 10:12:51 -0500
Received: from foss.arm.com ([217.140.110.172]:55866 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729839AbgAKPMv (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jan 2020 10:12:51 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E173C328;
        Sat, 11 Jan 2020 07:12:49 -0800 (PST)
Received: from [192.168.1.123] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 70BF73F534;
        Sat, 11 Jan 2020 07:12:48 -0800 (PST)
Subject: Re: [PATCH v1] arch_topology: Adjust initial CPU capacities with
 current freq
To:     JeffyChen <jeffy.chen@rock-chips.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org,
        Brian Norris <briannorris@chromium.org>,
        Marc Zyngier <marc.zyngier@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Heiko Stuebner <heiko@sntech.de>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
References: <20200109075214.31943-1-jeffy.chen@rock-chips.com>
 <20200110113711.GB39451@bogus> <5475692c-e72b-74c1-bd6e-95278703249b@arm.com>
 <15ab46e5-a2b4-eb96-1217-2b2ef8827f64@arm.com>
 <5E193828.1070000@rock-chips.com>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <5fa797f8-3ba5-7e18-4eed-2d39904b2f72@arm.com>
Date:   Sat, 11 Jan 2020 15:12:47 +0000
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.3.1
MIME-Version: 1.0
In-Reply-To: <5E193828.1070000@rock-chips.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-01-11 2:51 am, JeffyChen wrote:
> Hi Robin,
> 
> Thanks for the clarification :)
> 
> On 01/10/2020 08:28 PM, Robin Murphy wrote:
>> On 2020-01-10 12:01 pm, Dietmar Eggemann wrote:
>>> On 10/01/2020 12:37, Sudeep Holla wrote:
>>>> On Thu, Jan 09, 2020 at 03:52:14PM +0800, Jeffy Chen wrote:
>>>>> The CPU freqs are not supposed to change before cpufreq policies
>>>>> properly registered, meaning that they should be used to calculate the
>>>>> initial CPU capacities.
>>>>>
>>>>> Doing this helps choosing the best CPU during early boot, especially
>>>>> for the initramfs decompressing.
>>>>>
>>>>> Signed-off-by: Jeffy Chen <jeffy.chen@rock-chips.com>
>>>>
>>>> [...]
>>>>
>>>>> @@ -146,10 +153,15 @@ bool __init topology_parse_cpu_capacity(struct
>>>>> device_node *cpu_node, int cpu)
>>>>>                   return false;
>>>>>               }
>>>>>           }
>>>>> -        capacity_scale = max(cpu_capacity, capacity_scale);
>>>>>           raw_capacity[cpu] = cpu_capacity;
>>>>>           pr_debug("cpu_capacity: %pOF cpu_capacity=%u (raw)\n",
>>>>>               cpu_node, raw_capacity[cpu]);
>>>>> +
>>>>> +        cpu_clk = of_clk_get(cpu_node, 0);
>>>>> +        if (!PTR_ERR_OR_ZERO(cpu_clk))
>>>>> +            per_cpu(max_freq, cpu) = clk_get_rate(cpu_clk) / 1000;
>>>>> +
>>>>> +        clk_put(cpu_clk);
>>>>
>>>> I don't like to assume DVFS to be supplied only using 'clk'. So NACK!
>>>> We have other non-clk mechanism for CPU DVFS and this needs to simply
>>>> use cpufreq APIs to get frequency value if required.
>>>
>>> To support this, it's failing on my Arm64 Juno board.
>>>
>>> ...
>>> [    0.084858] CPU1 cpu_clk=-517
>>> [    0.087961] CPU2 cpu_clk=-517
>>> [    0.091005] CPU0 cpu_clk=-517
>>> [    0.094121] CPU3 cpu_clk=-517
>>> [    0.097248] CPU4 cpu_clk=-517
>>> [    0.100415] CPU5 cpu_clk=-517
> 
> It there any other way to get the initial cpu capacity for this case?
> 
> Or can we just assuming all the cores running at the same freq here?
> 
>>> ...
>>>
>>> Since you're on a big.LITTLE platform, did you specify
>>> 'capacity-dmips-mhz' for CPUs to be able to distinguish big and little
>>> CPUs before CPUfreq kicks in?
>>
>> Indeed, and that's the "problem" - the capacities are there, but with
>> the broken firmware the kernel starts with the little (boot) cluster
>> clocked at either 400 or 200MHz, but the big cluster at just 12MHz. At
>> that speed, a full distro config can take about 3 minutes to get to the
>> point of loading cpufreq as a module, and I've seen at least one distro
>> reverting 97df3aa76b4a to 'fix' the symptom :(
> 
> Right, for the big cluster, the bootrom(maskrom) will init the clock to 
> 24MHz, and if the bootloader(u-boot for example) doesn't bump it, it 
> would become 12MHz after kernel initialized the whole clk tree.
> 
> And in rockchip's BSP 4.4 kernel, there are hacks to bump it to 
> 800MHz(higher freq might require regulator changing) in clk tree 
> initialization, the BSP u-boot also added that recently.
> 
> The chromeos's coreboot looks fine, but upstream u-boot seems missing 
> that part too, i'll try to send a patch for that :)

Actually, last time I looked both the BSP U-Boot and mainline do contain 
equivalent code to initialise both PLLs to (IIRC) 600MHz and apparently 
adjust a couple of other things set by the maskrom. The trap is that 
mainline does it in the SPL - thus the unfortunately common combination 
of using the upstream main stage with the miniloader ends up missing out 
that step entirely. In comparison, I'm now using the full upstream 
TPL/SPL flow on my RK3399 board (NanoPC-T4) and even a full generic 
distro kernel is acceptably quick:

[    2.315378] Trying to unpack rootfs image as initramfs...
[    2.781747] Freeing initrd memory: 7316K
...
[    4.239990] Freeing unused kernel memory: 1984K
[    4.247829] Run /init as init process

Robin.
