Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 71EE1C433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 09:51:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 58FA420678
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 09:51:39 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726497AbgHCJvj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 05:51:39 -0400
Received: from foss.arm.com ([217.140.110.172]:55020 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725965AbgHCJvg (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 05:51:36 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id DB3BC30E;
        Mon,  3 Aug 2020 02:51:35 -0700 (PDT)
Received: from [10.57.35.143] (unknown [10.57.35.143])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A83B03F6CF;
        Mon,  3 Aug 2020 02:51:33 -0700 (PDT)
Subject: Re: [RFC PATCH] arm64: defconfig: Disable fine-grained task level IRQ
 time accounting
To:     Vladimir Oltean <olteanv@gmail.com>,
        Kurt Kanzenbach <kurt.kanzenbach@linutronix.de>
Cc:     paulmck@kernel.org, Anna-Maria Gleixner <anna-maria@linutronix.de>,
        catalin.marinas@arm.com, Alison Wang <alison.wang@nxp.com>,
        linux-kernel@vger.kernel.org, leoyang.li@nxp.com,
        vladimir.oltean@nxp.com, Thomas Gleixner <tglx@linutronix.de>,
        mw@semihalf.com, will@kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Marc Zyngier <maz@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>
References: <20200729033934.22349-1-alison.wang@nxp.com> <877dumbtoi.fsf@kurt>
 <20200729094943.lsmhsqlnl7rlnl6f@skbuf> <87mu3ho48v.fsf@kurt>
 <20200730082228.r24zgdeiofvwxijm@skbuf> <873654m9zi.fsf@kurt>
 <20200803081625.czdfwcpw5emcd4ls@skbuf>
From:   Robin Murphy <robin.murphy@arm.com>
Message-ID: <f61560f5-c4e0-a40b-5845-af3f6d98c7ad@arm.com>
Date:   Mon, 3 Aug 2020 10:51:32 +0100
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:68.0) Gecko/20100101
 Thunderbird/68.11.0
MIME-Version: 1.0
In-Reply-To: <20200803081625.czdfwcpw5emcd4ls@skbuf>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-GB
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2020-08-03 09:16, Vladimir Oltean wrote:
> On Mon, Aug 03, 2020 at 10:04:01AM +0200, Kurt Kanzenbach wrote:
>> On Thu Jul 30 2020, Vladimir Oltean wrote:
>>> On Thu, Jul 30, 2020 at 09:23:44AM +0200, Kurt Kanzenbach wrote:
>>>> On Wed Jul 29 2020, Vladimir Oltean wrote:
>>>>> For more context, here is my original report of the issue:
>>>>> https://lkml.org/lkml/2020/6/4/1062
>>>>>
>>>>> Just like you, I could not reproduce the RCU stalls and system hang on a
>>>>> 5.6-rt kernel, just on mainline and derivatives, using the plain
>>>>> defconfig.
>>>>>
>>>>> The issue is not specific to Layerscape or i.MX8, but rather I was able
>>>>> to see the same behavior on Marvell Armada 37xx as well as Qualcomm
>>>>> MSM8976.
>>>>>
>>>>> So, while of course I agree that disabling IRQ time accounting for arm64
>>>>> isn't a real solution, it isn't by far an exaggerated proposal either.
>>>>> Nonetheless, the patch is just a RFC and should be treated as such. We
>>>>> are at a loss when it comes to debugging this any further and we would
>>>>> appreciate some pointers.
>>>>
>>>> Yeah, sure. I'll try to reproduce this issue first. So it triggers with:
>>>>
>>>>   * arm64
>>>>   * mainline, not -rt kernel
>>>>   * opened serial console
>>>>   * irq accounting enabled
>>>>
>>>> Anything else?
>>>>
>>>> Thanks,
>>>> Kurt
>>>
>>> Thanks for giving a helping hand, Kurt. The defconfig should be enough.
>>> In the interest of full disclosure, the only arm64 device on which we
>>> didn't reproduce this was the 16-core LX2160A. But we did reproduce on
>>> that with maxcpus=1 though. And also on msm8976 with all 8 cores booted.
>>> Just mentioning this in case you're testing on a 16-core system, you
>>> might want to reduce the number a bit.
>>
>> OK. I've reproduced it on a Marvell Armada SoC with v5.6 mainline. See
>> splats below. Running with irq time accounting enabled, kills the
>> machine immediately. However, I'm not getting the possible deadlock
>> warnings in 8250 as you did. So that might be unrelated.
>>
> 
> Yes, the console lockdep warnings are unrelated. They are discussed
> here:
> https://lore.kernel.org/lkml/CAHQZ30BnfX+gxjPm1DUd5psOTqbyDh4EJE=2=VAMW_VDafctkA@mail.gmail.com/
> 
>> Unfortunately I have no idea what to debug here.
>>
>> Thanks,
>> Kurt
> 
> So, this means we could submit a formal version of this patch? :)

Defconfig is absolutely not the appropriate way to work around bugs - 
it's merely a starting point for users and distros to set up their own 
kernel, and if they can still enable this option and render their system 
unusable then patching some other config that they aren't using is 
pointless. To usefully mitigate a problem you'd need to make sure the 
offending option cannot be selected at all (i.e. prohibit 
HAVE_IRQ_TASK_ACCOUNTING as well).

Having glanced across another thread that mentions IRQ accounting 
recently[1], I wonder if the underlying bug here might have something do 
to with the stuff that Marc's trying to clean up.

Robin.

[1] 
https://lore.kernel.org/linux-arm-kernel/20200624195811.435857-16-maz@kernel.org/
