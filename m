Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1F995C83003
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:37:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EFBB020731
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 09:37:48 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726747AbgD2Jhs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 05:37:48 -0400
Received: from foss.arm.com ([217.140.110.172]:36184 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726523AbgD2Jhr (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 05:37:47 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B4676C14;
        Wed, 29 Apr 2020 02:37:46 -0700 (PDT)
Received: from [10.163.71.39] (unknown [10.163.71.39])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 463A83F73D;
        Wed, 29 Apr 2020 02:37:44 -0700 (PDT)
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Subject: Re: [PATCH V2 00/16] arm64/cpufeature: Introduce ID_PFR2, ID_DFR1,
 ID_MMFR5 and other changes
To:     linux-arm-kernel@lists.infradead.org
Cc:     catalin.marinas@arm.com, will@kernel.org, mark.rutland@arm.com,
        maz@kernel.org, suzuki.poulose@arm.com,
        James Morse <james.morse@arm.com>,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org
References: <1586857710-17154-1-git-send-email-anshuman.khandual@arm.com>
Message-ID: <6749304e-8a4d-f4b9-eb40-91f0dd13166e@arm.com>
Date:   Wed, 29 Apr 2020 15:07:15 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.9.1
MIME-Version: 1.0
In-Reply-To: <1586857710-17154-1-git-send-email-anshuman.khandual@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 04/14/2020 03:18 PM, Anshuman Khandual wrote:
> This series is primarily motivated from an adhoc list from Mark Rutland
> during our previous ID_ISAR6 discussion [1]. The current proposal also
> accommodates some more suggestions from Will and Suzuki.
> 
> This series adds missing 32 bit system registers (ID_PFR2, ID_DFR1 and
> ID_MMFR5), adds missing features bits on all existing system registers
> (32 and 64 bit) and some other miscellaneous changes. While here it also
> includes a patch which does macro replacement for various open bits shift
> encodings for various CPU ID registers. There is a slight re-order of the
> patches here as compared to the previous version (V1).
> 
> This series is based on v5.7-rc1. All feature bits enabled here can be
> referred in ARM DDI 0487F.a specification. Though I have tried to select
> appropriate values for each new feature being added here, there might be
> some inconsistencies (or mistakes). In which case, please do let me know
> if anything needs to change. Thank you.
> 
> [1] https://patchwork.kernel.org/patch/11287805/
> 
> Cc: Catalin Marinas <catalin.marinas@arm.com>
> Cc: Will Deacon <will@kernel.org>
> Cc: Mark Rutland <mark.rutland@arm.com> 
> Cc: Marc Zyngier <maz@kernel.org>
> Cc: James Morse <james.morse@arm.com>
> Cc: Suzuki K Poulose <suzuki.poulose@arm.com>
> Cc: kvmarm@lists.cs.columbia.edu
> Cc: linux-arm-kernel@lists.infradead.org
> Cc: linux-kernel@vger.kernel.org
> 
> Changes in V2:
> 
> - Added Suggested-by tag from Mark Rutland for all changes he had proposed
> - Added comment for SpecSEI feature on why it is HIGHER_SAFE per Suzuki
> - Added a patch which makes ID_AA64DFR0_DOUBLELOCK a signed feature per Suzuki
> - Added ID_DFR1 and ID_MMFR5 system register definitions per Will
> - Added remaining features bits for relevant 64 bit system registers per Will
> - Changed commit message on [PATCH 5/7] regarding TraceFilt feature per Suzuki
> - Changed ID_PFR2.CSV3 (FTR_STRICT -> FTR_NONSTRICT) as 64 bit registers per Will
> - Changed ID_PFR0.CSV2 (FTR_STRICT -> FTR_NONSTRICT) as 64 bit registers per Will 
> - Changed some commit messages

Hello Will,

Just a gentle ping. I am wondering if you had a chance to glance
through this updated series.

- Anshuman
