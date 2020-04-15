Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.2 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 308D6C2BB55
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:09:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1670F20768
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:09:16 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896209AbgDOKJO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:09:14 -0400
Received: from foss.arm.com ([217.140.110.172]:41362 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896152AbgDOKJI (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:09:08 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BE24F1063;
        Wed, 15 Apr 2020 03:09:07 -0700 (PDT)
Received: from [10.37.12.1] (unknown [10.37.12.1])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 7E07D3F68F;
        Wed, 15 Apr 2020 03:09:05 -0700 (PDT)
Subject: Re: [PATCH 3/8] arm64: cpufeature: Add CPU capability for AArch32 EL1
 support
To:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu
Cc:     linux-kernel@vger.kernel.org, mark.rutland@arm.com, maz@kernel.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        saiprakash.ranjan@codeaurora.org, dianders@chromium.org,
        kernel-team@android.com
References: <20200414213114.2378-1-will@kernel.org>
 <20200414213114.2378-4-will@kernel.org>
From:   Suzuki K Poulose <suzuki.poulose@arm.com>
Message-ID: <a83a19eb-9051-0a43-0bac-353f67d93d79@arm.com>
Date:   Wed, 15 Apr 2020 11:13:54 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:52.0) Gecko/20100101
 Thunderbird/52.7.0
MIME-Version: 1.0
In-Reply-To: <20200414213114.2378-4-will@kernel.org>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/14/2020 10:31 PM, Will Deacon wrote:
> Although we emit a "SANITY CHECK" warning and taint the kernel if we
> detect a CPU mismatch for AArch32 support at EL1, we still online the
> CPU with disastrous consequences for any running 32-bit VMs.
> 
> Introduce a capability for AArch32 support at EL1 so that late onlining
> of incompatible CPUs is forbidden.
> 
> Signed-off-by: Will Deacon <will@kernel.org>

One of the other important missing sanity check for KVM is the VMID 
width check. I will code something up.

Reviewed-by: Suzuki K Poulose <suzuki.poulose@arm.com>
