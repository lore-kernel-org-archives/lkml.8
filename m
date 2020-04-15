Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6A998C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:39:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4B28D206D9
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:39:47 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2408562AbgDOKji (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:39:38 -0400
Received: from foss.arm.com ([217.140.110.172]:41946 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2408812AbgDOKit (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:38:49 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E636A1063;
        Wed, 15 Apr 2020 03:38:48 -0700 (PDT)
Received: from [10.37.12.1] (unknown [10.37.12.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C788E3F68F;
        Wed, 15 Apr 2020 03:38:46 -0700 (PDT)
Subject: Re: [PATCH 6/8] arm64: cpufeature: Relax AArch32 system checks if EL1
 is 64-bit only
To:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com, maz@kernel.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        saiprakash.ranjan@codeaurora.org, dianders@chromium.org,
        kernel-team@android.com
References: <20200414213114.2378-1-will@kernel.org>
 <20200414213114.2378-7-will@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <b648691c-e9cd-f0eb-2ed2-50451a4bceb8@arm.com>
Date:   Wed, 15 Apr 2020 11:43:36 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200414213114.2378-7-will@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/14/2020 10:31 PM, Will Deacon wrote:
> If AArch32 is not supported at EL1, the AArch32 feature register fields
> no longer advertise support for some system features:
> 
>    * ISAR4.SMC
>    * PFR1.{Virt_frac, Sec_frac, Virtualization, Security, ProgMod}
> 
> In which case, we don't need to emit "SANITY CHECK" failures for all of
> them.
> 
> Add logic to relax the strictness of individual feature register fields
> at runtime and use this for the fields above if 32-bit EL1 is not
> supported.
> 
> Signed-off-by: Will Deacon <will@kernel.org>

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
