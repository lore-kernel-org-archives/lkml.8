Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_2 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AA75C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:23:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 254C42074F
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 13:23:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586957013;
	bh=OGayslbKapewkz6Bc/D54llvfloiJR74nivh6TEICRI=;
	h=Date:From:To:Cc:Subject:In-Reply-To:References:List-ID:From;
	b=r4nZ/9F4aiHy6STmmBqcGaZG+5Y50XKqDNsR1zld6gehS2uIEyJyTH9ppURzw8Nju
	 /ZA4IMdi6K3jDOslLM+hdvaK7BEUhyyERBOfWDp86F29g509zXzzf79F1z07epPxeM
	 kOlvD86L5lgBw2yk8NC4TGiQKD0aQyUAKRXUnWXo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2636022AbgDONXa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 09:23:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:58766 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2506354AbgDONWl (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 09:22:41 -0400
Received: from disco-boy.misterjones.org (disco-boy.misterjones.org [51.254.78.96])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 044662074F;
        Wed, 15 Apr 2020 13:22:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586956961;
        bh=OGayslbKapewkz6Bc/D54llvfloiJR74nivh6TEICRI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=vWzSb68xwI0CVPV2HbKsVakamCAe0aYTaQk3f9Bd14jLx9xVSI5wY/PSKQg033/D1
         Syn57itZL+GUSzKjCjZA/qhALbKdusg/OVryuLj7PyY4VLJT3nL+W1XLMwwhNZ8eAC
         mIx0zlZq4xY2rpZXbHdJhktAh1vwHXBt+rt5MbdM=
Received: from 78.163-31-62.static.virginmediabusiness.co.uk ([62.31.163.78] helo=why)
        by disco-boy.misterjones.org with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <maz@kernel.org>)
        id 1jOhzz-003XXy-2k; Wed, 15 Apr 2020 14:22:39 +0100
Date:   Wed, 15 Apr 2020 14:22:37 +0100
From:   Marc Zyngier <maz@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     will@kernel.org, linux-arm-kernel@lists.infradead.org,
        kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org,
        mark.rutland@arm.com, anshuman.khandual@arm.com,
        catalin.marinas@arm.com, saiprakash.ranjan@codeaurora.org,
        dianders@chromium.org, kernel-team@android.com
Subject: Re: [PATCH 3/8] arm64: cpufeature: Add CPU capability for AArch32
 EL1 support
Message-ID: <20200415142237.651114f7@why>
In-Reply-To: <7978a5a9-463e-5e96-7ea9-d8472b7b051c@arm.com>
References: <20200414213114.2378-1-will@kernel.org>
        <20200414213114.2378-4-will@kernel.org>
        <a83a19eb-9051-0a43-0bac-353f67d93d79@arm.com>
        <20200415101444.GC12621@willie-the-truck>
        <7978a5a9-463e-5e96-7ea9-d8472b7b051c@arm.com>
Organization: Approximate
X-Mailer: Claws Mail 3.17.5 (GTK+ 2.24.32; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-SA-Exim-Connect-IP: 62.31.163.78
X-SA-Exim-Rcpt-To: suzuki.poulose@arm.com, will@kernel.org, linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu, linux-kernel@vger.kernel.org, mark.rutland@arm.com, anshuman.khandual@arm.com, catalin.marinas@arm.com, saiprakash.ranjan@codeaurora.org, dianders@chromium.org, kernel-team@android.com
X-SA-Exim-Mail-From: maz@kernel.org
X-SA-Exim-Scanned: No (on disco-boy.misterjones.org); SAEximRunCond expanded to false
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020 14:15:51 +0100
Suzuki K Poulose <suzuki.poulose@arm.com> wrote:

> On 04/15/2020 11:14 AM, Will Deacon wrote:
> > On Wed, Apr 15, 2020 at 11:13:54AM +0100, Suzuki K Poulose wrote:  
> >> On 04/14/2020 10:31 PM, Will Deacon wrote:  
> >>> Although we emit a "SANITY CHECK" warning and taint the kernel if we
> >>> detect a CPU mismatch for AArch32 support at EL1, we still online the
> >>> CPU with disastrous consequences for any running 32-bit VMs.
> >>>
> >>> Introduce a capability for AArch32 support at EL1 so that late onlining
> >>> of incompatible CPUs is forbidden.
> >>>
> >>> Signed-off-by: Will Deacon <will@kernel.org>  
> >>
> >> One of the other important missing sanity check for KVM is the VMID width
> >> check. I will code something up.  
> > 
> > Cheers! Do we handle things like the IPA size already?  
> 
> Good point. No, we don't. I will include this too.

There is also the question of the ARMv8.5-GTG extension. I have a patch
that treats it as non-strict, but that approach would fail with KVM if
we online a late CPU without support for the right page size at S2.

	M.
-- 
Jazz is not dead. It just smells funny...
