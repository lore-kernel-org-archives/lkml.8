Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5995DC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:28:32 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3704C20708
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 00:28:32 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728292AbgETA2b (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 19 May 2020 20:28:31 -0400
Received: from foss.arm.com ([217.140.110.172]:44316 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726318AbgETA2b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 May 2020 20:28:31 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 52EC631B;
        Tue, 19 May 2020 17:28:30 -0700 (PDT)
Received: from [10.163.75.101] (unknown [10.163.75.101])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 833363F68F;
        Tue, 19 May 2020 17:28:27 -0700 (PDT)
Subject: Re: [PATCH V2] arm64/cpuinfo: Move HWCAP name arrays alongside their
 bit definitions
To:     Will Deacon <will@kernel.org>
Cc:     Mark Rutland <mark.rutland@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        linux-kernel@vger.kernel.org, Ard Biesheuvel <ardb@kernel.org>,
        Mark Brown <broonie@kernel.org>,
        Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org
References: <1588858150-26823-1-git-send-email-anshuman.khandual@arm.com>
 <20200513150405.GS21779@arm.com>
 <0999fa28-3ee7-3f02-4def-a0c6013ec6dd@arm.com>
 <20200514073613.GB4280@willie-the-truck>
 <8ddd0ca5-07c9-3a99-2ec6-4a201725ebe8@arm.com>
 <20200518223506.GA5866@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <f3f3836c-42bb-9745-88ee-a6fe6f653cc5@arm.com>
Date:   Wed, 20 May 2020 05:57:52 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200518223506.GA5866@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 8bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 05/19/2020 04:05 AM, Will Deacon wrote:
> On Fri, May 15, 2020 at 08:58:05AM +0530, Anshuman Khandual wrote:
>> On 05/14/2020 01:06 PM, Will Deacon wrote:
>>> Why is it a change? We've never reported e.g. "java" on an arm64 kernel, so
>>
>> We already have "java" defined in existing compat_hwcap_str[] array even
>> though it might never get set in compat_elf_hwcap. AFAICS, compat_elf_hwcap
>> will have the following capabilities set (at the most).
>>
>> Via COMPAT_ELF_HWCAP_DEFAULT
>>
>> 01.  COMPAT_HWCAP_HALF
>> 02.  COMPAT_HWCAP_THUMB
>> 03.  COMPAT_HWCAP_FAST_MULT
>> 04.  COMPAT_HWCAP_EDSP
>> 05.  COMPAT_HWCAP_TLS
>> 06.  COMPAT_HWCAP_IDIV
>> 07.  COMPAT_HWCAP_LPAE
>>
>> Via setup_elf_hwcaps(compat_elf_hwcaps) <-- setup_cpu_features()
>>
>> 8.  COMPAT_HWCAP_NEON
>> 9.  COMPAT_HWCAP_VFPv4
>> 10. COMPAT_HWCAP_VFP
>> 11. COMPAT_HWCAP_VFPv3
>>
>> Via arch_timer_set_evtstrm_feature()
>>
>> 12. COMPAT_HWCAP_EVTSTRM
>>
>> The code exists for "java" string to be displayed with /proc/cpuinfo but it
>> may never get triggered as compat_elf_hwcap will never have JAVA capability
>> unless there is a bug as you had rightly mentioned.
> 
> Fair enough, but applying this patch causes a *tonne* of warnings from
> aiaiai:
> 
> +In file included from arch/arm64/include/asm/cpufeature.h:11,
> +                 from arch/arm64/include/asm/ptrace.h:11,
> +                 from arch/arm64/include/asm/irqflags.h:10,
> +                 from include/linux/irqflags.h:16,
> +                 from include/linux/spinlock.h:54,
> +                 from include/linux/seqlock.h:36,
> +                 from include/linux/time.h:6,
> +                 from arch/arm64/include/asm/stat.h:12,
> +                 from include/linux/stat.h:6,
> +                 from include/linux/module.h:13,
> +                 from drivers/media/rc/keymaps/rc-imon-mce.mod.c:1:
> +arch/arm64/include/asm/hwcap.h:189:26: warning: ‘compat_hwcap2_str’ defined but not used [-Wunused-const-variable=]
> +  189 | static const char *const compat_hwcap2_str[] = {
> +      |                          ^~~~~~~~~~~~~~~~~

Native default build (defconfig) on arm64 does not throw this warning.
I guess this came up with 'make W=n' or something. Anyways if this is
indeed an issue, we will have to add in helpers for each HWCAP arrays
which will fetch a feature string on index value to be used in c_show
(arch/arm64/kernel/cpuinfo.c). I wanted to avoid this to reduce code. 

> 
> so I'm dropping this for now.

Sure, will respin this later probably after 5.8-rc1.
