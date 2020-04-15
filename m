Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00F34C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:04:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CD5C52064A
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:04:33 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896120AbgDOKEb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:04:31 -0400
Received: from foss.arm.com ([217.140.110.172]:41230 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2895955AbgDOKEZ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:04:25 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 416D71063;
        Wed, 15 Apr 2020 03:04:25 -0700 (PDT)
Received: from [10.37.12.1] (unknown [10.37.12.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D6CDD3F68F;
        Wed, 15 Apr 2020 03:04:22 -0700 (PDT)
Subject: Re: [PATCH 2/8] arm64: cpufeature: Spell out register fields for
 ID_ISAR4 and ID_PFR1
To:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com, maz@kernel.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        saiprakash.ranjan@codeaurora.org, dianders@chromium.org,
        kernel-team@android.com
References: <20200414213114.2378-1-will@kernel.org>
 <20200414213114.2378-3-will@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <632b7ace-a7db-a961-b9eb-c9c303376fcd@arm.com>
Date:   Wed, 15 Apr 2020 11:09:12 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200414213114.2378-3-will@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/14/2020 10:31 PM, Will Deacon wrote:
> In preparation for runtime updates to the strictness of some AArch32
> features, spell out the register fields for ID_ISAR4 and ID_PFR1 to make
> things clearer to read. Note that this isn't functionally necessary, as
> the feature arrays themselves are not modified dynamically and remain
> 'const'.
> 
> Signed-off-by: Will Deacon <will@kernel.org>
> ---
>   arch/arm64/include/asm/sysreg.h | 17 +++++++++++++++++
>   arch/arm64/kernel/cpufeature.c  | 28 ++++++++++++++++++++++++++--
>   2 files changed, 43 insertions(+), 2 deletions(-)

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
