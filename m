Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 90C92C3815B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:39:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 79947208E4
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 09:39:31 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730438AbgDQJja (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 17 Apr 2020 05:39:30 -0400
Received: from foss.arm.com ([217.140.110.172]:48898 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1730318AbgDQJj2 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Apr 2020 05:39:28 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 60F2F30E;
        Fri, 17 Apr 2020 02:39:28 -0700 (PDT)
Received: from [10.37.12.128] (unknown [10.37.12.128])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7D2C23F73D;
        Fri, 17 Apr 2020 02:39:26 -0700 (PDT)
Subject: Re: [PATCH 3/8] arm64: cpufeature: Add CPU capability for AArch32 EL1
 support
To:     maz@kernel.org
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, saiprakash.ranjan@codeaurora.org,
        dianders@chromium.org, kernel-team@android.com
References: <20200414213114.2378-1-will@kernel.org>
 <20200414213114.2378-4-will@kernel.org>
 <a83a19eb-9051-0a43-0bac-353f67d93d79@arm.com>
 <20200415101444.GC12621@willie-the-truck>
 <7978a5a9-463e-5e96-7ea9-d8472b7b051c@arm.com> <20200415142237.651114f7@why>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <1ffdf91a-e418-61ec-1056-756e1a81f4a6@arm.com>
Date:   Fri, 17 Apr 2020 10:44:16 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200415142237.651114f7@why>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/15/2020 02:22 PM, Marc Zyngier wrote:
> On Wed, 15 Apr 2020 14:15:51 +0100
> Suzuki K Poulose <suzuki.poulose@arm.com> wrote:
> 
>> On 04/15/2020 11:14 AM, Will Deacon wrote:
>>> On Wed, Apr 15, 2020 at 11:13:54AM +0100, Suzuki K Poulose wrote:
>>>> On 04/14/2020 10:31 PM, Will Deacon wrote:
>>>>> Although we emit a "SANITY CHECK" warning and taint the kernel if we
>>>>> detect a CPU mismatch for AArch32 support at EL1, we still online the
>>>>> CPU with disastrous consequences for any running 32-bit VMs.
>>>>>
>>>>> Introduce a capability for AArch32 support at EL1 so that late onlining
>>>>> of incompatible CPUs is forbidden.
>>>>>
>>>>> Signed-off-by: Will Deacon <will@kernel.org>
>>>>
>>>> One of the other important missing sanity check for KVM is the VMID width
>>>> check. I will code something up.
>>>
>>> Cheers! Do we handle things like the IPA size already?
>>
>> Good point. No, we don't. I will include this too.
> 
> There is also the question of the ARMv8.5-GTG extension. I have a patch
> that treats it as non-strict, but that approach would fail with KVM if
> we online a late CPU without support for the right page size at S2.

Good point. Again this can be added to the list of checks performed on
the hot-plugged CPUs along with IPA, VMID width.

Cheers
Suzuki

