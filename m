Return-Path: <SRS0=pNjS=57=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91E93C2BA19
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:16:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62689208FE
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Apr 2020 10:16:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586945778;
	bh=Ewe88LkPUS4nDP5Snumb3J4za5bNTQxjgtEZIyIztSo=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=xcMVRpFgtBYSB50+q+fkjieyWNClXUn/AwRWHx5KLtQK27WXeo72Mu1T/WNB0fxkg
	 TaRXjyuEI1Y+bKjFrgL8Og0x/MuizlcSZhZgW8aWy7B/MvcFCLDVLP+Xasyp0Xblpu
	 hCM8PrUv+Mzut9OvQieZk49BGjW2F0XHyF5KE0WA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2896392AbgDOKPx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 06:15:53 -0400
Received: from mail.kernel.org ([198.145.29.99]:55472 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S2896377AbgDOKOu (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 06:14:50 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 6205720775;
        Wed, 15 Apr 2020 10:14:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1586945690;
        bh=Ewe88LkPUS4nDP5Snumb3J4za5bNTQxjgtEZIyIztSo=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=Kkl3LAbhH971rT3Xs2uaG7Qc+MzCHl/Er5SfyO2GRjpi48vKSiZYzeVByfeEmfaQi
         sldSSCkeeqEbyKQbDyhJ/fqSzw51uj802Xt9qlxBt7KgIeNTyL1vaXj9HEkBPzk92R
         HvSpTRRNTIh7aeiIK8grfDhBjW97uTkH90J1t0cA=
Date:   Wed, 15 Apr 2020 11:14:44 +0100
From:   Will Deacon <will@kernel.org>
To:     Suzuki K Poulose <suzuki.poulose@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org, kvmarm@lists.cs.columbia.edu,
        linux-kernel@vger.kernel.org, mark.rutland@arm.com, maz@kernel.org,
        anshuman.khandual@arm.com, catalin.marinas@arm.com,
        saiprakash.ranjan@codeaurora.org, dianders@chromium.org,
        kernel-team@android.com
Subject: Re: [PATCH 3/8] arm64: cpufeature: Add CPU capability for AArch32
 EL1 support
Message-ID: <20200415101444.GC12621@willie-the-truck>
References: <20200414213114.2378-1-will@kernel.org>
 <20200414213114.2378-4-will@kernel.org>
 <a83a19eb-9051-0a43-0bac-353f67d93d79@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a83a19eb-9051-0a43-0bac-353f67d93d79@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 15, 2020 at 11:13:54AM +0100, Suzuki K Poulose wrote:
> On 04/14/2020 10:31 PM, Will Deacon wrote:
> > Although we emit a "SANITY CHECK" warning and taint the kernel if we
> > detect a CPU mismatch for AArch32 support at EL1, we still online the
> > CPU with disastrous consequences for any running 32-bit VMs.
> > 
> > Introduce a capability for AArch32 support at EL1 so that late onlining
> > of incompatible CPUs is forbidden.
> > 
> > Signed-off-by: Will Deacon <will@kernel.org>
> 
> One of the other important missing sanity check for KVM is the VMID width
> check. I will code something up.

Cheers! Do we handle things like the IPA size already?

Will
