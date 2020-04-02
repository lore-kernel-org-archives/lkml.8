Return-Path: <SRS0=iZC5=5S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.3 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3785DC43331
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:33:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 0691A20721
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Apr 2020 02:33:21 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733270AbgDBCdU (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 22:33:20 -0400
Received: from foss.arm.com ([217.140.110.172]:36260 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1727135AbgDBCdT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 22:33:19 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 5664F30E;
        Wed,  1 Apr 2020 19:33:19 -0700 (PDT)
Received: from [10.163.1.8] (unknown [10.163.1.8])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D50E93F71E;
        Wed,  1 Apr 2020 19:33:16 -0700 (PDT)
Subject: Re: [PATCH 0/6] Introduce ID_PFR2 and other CPU feature changes
To:     Peter Maydell <peter.maydell@linaro.org>
Cc:     arm-mail-list <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        lkml - Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Marc Zyngier <maz@kernel.org>, Will Deacon <will@kernel.org>,
        kvmarm@lists.cs.columbia.edu
References: <1580215149-21492-1-git-send-email-anshuman.khandual@arm.com>
 <45ce930c-81b3-3161-ced6-34a8c8623ac8@arm.com>
 <CAFEAcA_yZ55rOD1x+FE9wYO8HXx9seK72ZCmnWjtDVr_95-whg@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <c2b672ca-9b74-89f8-388c-555bbcbd57ba@arm.com>
Date:   Thu, 2 Apr 2020 08:03:09 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <CAFEAcA_yZ55rOD1x+FE9wYO8HXx9seK72ZCmnWjtDVr_95-whg@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/14/2020 09:28 PM, Peter Maydell wrote:
> On Fri, 14 Feb 2020 at 04:23, Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>>
>>
>> On 01/28/2020 06:09 PM, Anshuman Khandual wrote:
>>> This series is primarily motivated from an adhoc list from Mark Rutland
>>> during our ID_ISAR6 discussion [1]. Besides, it also includes a patch
>>> which does macro replacement for various open bits shift encodings in
>>> various CPU ID registers. This series is based on linux-next 20200124.
>>>
>>> [1] https://patchwork.kernel.org/patch/11287805/
>>>
>>> Is there anything else apart from these changes which can be accommodated
>>> in this series, please do let me know. Thank you.
>>
>> Just a gentle ping. Any updates, does this series looks okay ? Is there
>> anything else related to CPU ID register feature bits, which can be added
>> up here. FWIW, the series still applies on v5.6-rc1.

Sorry for the delay in response, was distracted on some other patches.

> 
> I just ran into some "32-bit KVM doesn't expose all the ID
> registers to userspace via the ONE_REG API" issues today.
> I don't know if they'd be reasonable as something to include
> in this patchset or if they're unrelated.

IMHO, they are bit unrelated.

> 
> Anyway, missing stuff I have noticed specifically:
>  * MVFR2
>  * ID_MMFR4
>  * ID_ISAR6
> 
> More generally I would have expected all these 32-bit registers
> to exist and read-as-zero for the purpose of the ONE_REG APIs,
> because that's what the architecture says is supposed to happen
> and it means we have compatibility and QEMU doesn't gradually
> build up lots of "kernel doesn't support this yet" conditionals...
> I think we get this right for 64-bit KVM, but can we do it for
> 32-bit as well?

I am not very familiar with 32-bit KVM but will definitely keep these
suggestions noted for later, also try and accommodate if possible.

> thanks
> -- PMM
> 
