Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 43E75C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:50:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29FE82073B
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 15:50:20 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729479AbgEDPuT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 11:50:19 -0400
Received: from foss.arm.com ([217.140.110.172]:47742 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726641AbgEDPuS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 11:50:18 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 880281FB;
        Mon,  4 May 2020 08:50:18 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.4.172])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B41913F68F;
        Mon,  4 May 2020 08:50:16 -0700 (PDT)
Date:   Mon, 4 May 2020 16:50:13 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     linux-arm-kernel@lists.infradead.org,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>, Mark Brown <broonie@kernel.org>,
        Suzuki Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] arm64/cpuinfo: Drop boot_cpu_data
Message-ID: <20200504155013.GG73375@C02TD0UTHF1T.local>
References: <1588595400-4560-1-git-send-email-anshuman.khandual@arm.com>
 <20200504124321.GA73375@C02TD0UTHF1T.local>
 <224296d1-086a-5516-95a8-8f4ad5c533d9@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <224296d1-086a-5516-95a8-8f4ad5c533d9@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 08:23:08PM +0530, Anshuman Khandual wrote:
> 
> 
> On 05/04/2020 06:13 PM, Mark Rutland wrote:
> > On Mon, May 04, 2020 at 06:00:00PM +0530, Anshuman Khandual wrote:
> >> A global boot_cpu_data is not really required. Lets drop this.
> > 
> > I don't think it's true that this isn't required today.
> > 
> > One reason that we have both boot_cpu_data and a cpu_data variable for
> > CPU0 is that CPU0 itself can be hotplugged out then back in, and this
> > allows us to detect if CPU0's features have changed (e.g. due to FW
> > failing to configure it appropriately, or real physical hotplug
> > occurring).
> 
> Understood. After hotplug, CPU0 will come back via secondary_start_kernel()
> where it's current register values will be checked against earlier captured
> values i.e boot_cpu_data.
> 
> But wondering why should CPU0 be treated like any other secondary CPU. IOW
> in case the fresh boot CPU register values dont match with boot_cpu_data,
> should not the online process just be declined ? AFAICS, current approach
> will let the kernel run with taint in case of a mismatch.

I don't follow. When CPU0 is hotplguged back in it'll follow the
secondary boot path, so it can be rejected as with any other secondary
CPU.

If I'm missing a case, could you please point that out more
specifically?

> > So NAK to the patch as it stands. If we're certain we capture all of
> > those details even without boot_cpu_data, then we should make other
> > changes to make that clear (e.g. removing it as an argument to
> > update_cpu_features()).
> 
> There might not be another way, unless we can override CPU0's cpu_data
> variable when the boot CPU comes back in after vetting against existing
> values. Is there any particular reason to store the very first boot CPU0
> info for ever ?

The reason is so that we can log the values for comparison. Otherwise
we'll have to choose some arbitrary CPU's value in order to do so.

> Passing on CPU0's cpu_data variable in update_cpu_features() for secondary
> CPUs during boot still make sense. It helps in finalizing register values.
> Re-entering CPU0's test against boot_cpu_data seems different.

I think that practically this means we should leave this as-is. If we
need to keep it around for CPU, then we may as well keep it around and
use it consitently for all secondary CPUs.

I'd prefer to leave this as-is given it's simple to reason about.

Thanks,
Mark.
