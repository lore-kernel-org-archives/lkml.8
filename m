Return-Path: <SRS0=z/zp=5X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43FAEC2BA16
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 08:50:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 20E4320719
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Apr 2020 08:50:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727967AbgDGIur (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Apr 2020 04:50:47 -0400
Received: from foss.arm.com ([217.140.110.172]:53700 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725817AbgDGIuq (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Apr 2020 04:50:46 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 2CAA430E;
        Tue,  7 Apr 2020 01:50:46 -0700 (PDT)
Received: from [10.163.1.2] (unknown [10.163.1.2])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D21EE3F73D;
        Tue,  7 Apr 2020 01:50:36 -0700 (PDT)
Subject: Re: [PATCH 0/6] Introduce ID_PFR2 and other CPU feature changes
To:     Will Deacon <will@kernel.org>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marc Zyngier <maz@kernel.org>,
        James Morse <james.morse@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
References: <1580215149-21492-1-git-send-email-anshuman.khandual@arm.com>
 <20200406170911.GA7446@willie-the-truck>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <05f6eb1e-a82c-bd02-1871-e44ea00683d8@arm.com>
Date:   Tue, 7 Apr 2020 14:20:20 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <20200406170911.GA7446@willie-the-truck>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/06/2020 10:39 PM, Will Deacon wrote:
> On Tue, Jan 28, 2020 at 06:09:03PM +0530, Anshuman Khandual wrote:
>> This series is primarily motivated from an adhoc list from Mark Rutland
>> during our ID_ISAR6 discussion [1]. Besides, it also includes a patch
>> which does macro replacement for various open bits shift encodings in
>> various CPU ID registers. This series is based on linux-next 20200124.
>>
>> [1] https://patchwork.kernel.org/patch/11287805/
>>
>> Is there anything else apart from these changes which can be accommodated
>> in this series, please do let me know. Thank you.
> 
> The latest Arm ARM also talks about DFR1 and MMFR5. Please can you include

Sure, will do.

> those too? Might also be worth checking to see if anything is missing on
> the 64-bit side as well (I didn't look).

Yeah. Now there some missing ones, will add those as well.

> 
> Will
> 
