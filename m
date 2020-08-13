Return-Path: <SRS0=dFdc=BX=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,NICE_REPLY_A,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 92FDFC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 13:14:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 583E4207DA
	for <linux-kernel@archiver.kernel.org>; Thu, 13 Aug 2020 13:14:03 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgHMNOB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 09:14:01 -0400
Received: from foss.arm.com ([217.140.110.172]:54510 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726100AbgHMNN5 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 09:13:57 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3B62F1063;
        Thu, 13 Aug 2020 06:13:57 -0700 (PDT)
Received: from [10.0.2.15] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 4AAAB3F6CF;
        Thu, 13 Aug 2020 06:13:55 -0700 (PDT)
Subject: Re: [PATCH v5 06/17] sched/debug: Output SD flag names rather than
 their values
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     kernel test robot <lkp@intel.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, kbuild-all@lists.01.org,
        mingo@kernel.org, peterz@infradead.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, morten.rasmussen@arm.com,
        Quentin Perret <qperret@google.com>
References: <20200812125300.11889-7-valentin.schneider@arm.com>
 <202008130025.XjiXqp1O%lkp@intel.com> <jhjpn7v66lf.mognet@arm.com>
 <20200813120249.vdadn3nutkx3mq7y@ltop.local>
From:   Valentin Schneider <valentin.schneider@arm.com>
Message-ID: <2507c6d6-eb66-504e-aba6-1333ce064da8@arm.com>
Date:   Thu, 13 Aug 2020 14:13:10 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <20200813120249.vdadn3nutkx3mq7y@ltop.local>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 13/08/2020 13:02, Luc Van Oostenryck wrote:
> On Wed, Aug 12, 2020 at 07:51:08PM +0100, Valentin Schneider wrote:
>> On 12/08/20 17:35, kernel test robot wrote:
>>
>>> config: i386-randconfig-s001-20200811 (attached as .config)
>>> reproduce:
>>>         # sparse version: v0.6.2-168-g9554805c-dirty
>>>         make W=1 C=1 CF='-fdiagnostic-prefix -D__CHECK_ENDIAN__' ARCH=i386
>>>
>>>>> kernel/sched/debug.c:279:17: sparse: sparse: non size-preserving pointer to integer cast
>>>>> kernel/sched/debug.c:279:17: sparse: sparse: non size-preserving integer to pointer cast
>>>
>>>  > 279		tmp += *ppos;
>>
>> I pretty much copied kernel/sysctl.c::_proc_do_string() and I think that's
>> exactly the same types here: char* buffer incremented by loff_t offset. It
>> does look fine to me, but I can't really parse that warning.
> 
> The warnings mean that there is a cast from a pointer to an integer with
> a size other than the size of a pointer and the other way around.
> 
> I's indeed the case here, on i386, where pointers are 32-bit and loff_t
> is 64-bit. But yes, I agree:
> 1) these messages are far from clear
> 2) these casts are internal and are probably not appropriate here.
> 
> I'll look later what can be done at sparse level.
> 

Thanks!

> Regards,
> -- Luc
> 
