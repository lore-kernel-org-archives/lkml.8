Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 91D79C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:36:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6E67E206C0
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 07:36:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589441780;
	bh=IXHEXF16rU/BSTFK9nrncTfh3TEkux3JqpB15nAsJQA=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=JJdEQ+GENXFl161zMNV1V+kwYbDFB1Fc7SmkMfeOZIxrsrvJ945ZL+UaMbgEWJOIv
	 W9WRhNGu3YzHEpbMjVc1S5snNCgDIrxYO0NSpyvbHW2uaYX4Z/HwXshyd57HD3j49u
	 MP9GU6Mem2VmQ7GHX2lPjZrpB1+N+3D47nwh+AP4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726066AbgENHgT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 03:36:19 -0400
Received: from mail.kernel.org ([198.145.29.99]:36690 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725946AbgENHgT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 03:36:19 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id D1927206BE;
        Thu, 14 May 2020 07:36:16 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589441778;
        bh=IXHEXF16rU/BSTFK9nrncTfh3TEkux3JqpB15nAsJQA=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=XxirtXwsu8vpXp4zzU02/RsjtslmALTiUWbZRwJFPlsgFZ5FBknRCs1fNJcfyi308
         C73AzidmlE2O+eXroCd+aQR4+7pOtgXzMr43MU3W0Yf19IahA6CHTkljDJfsgtJYap
         H7X4dOo6J5M+loGaqtYZ33z4HpquU/5E/OElF1PA=
Date:   Thu, 14 May 2020 08:36:13 +0100
From:   Will Deacon <will@kernel.org>
To:     Anshuman Khandual <anshuman.khandual@arm.com>
Cc:     Dave Martin <Dave.Martin@arm.com>,
        linux-arm-kernel@lists.infradead.org,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Suzuki K Poulose <suzuki.poulose@arm.com>,
        linux-kernel@vger.kernel.org, Mark Brown <broonie@kernel.org>,
        Ard Biesheuvel <ardb@kernel.org>
Subject: Re: [PATCH V2] arm64/cpuinfo: Move HWCAP name arrays alongside their
 bit definitions
Message-ID: <20200514073613.GB4280@willie-the-truck>
References: <1588858150-26823-1-git-send-email-anshuman.khandual@arm.com>
 <20200513150405.GS21779@arm.com>
 <0999fa28-3ee7-3f02-4def-a0c6013ec6dd@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <0999fa28-3ee7-3f02-4def-a0c6013ec6dd@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 07:14:58AM +0530, Anshuman Khandual wrote:
> On 05/13/2020 08:34 PM, Dave Martin wrote:
> > On Thu, May 07, 2020 at 06:59:10PM +0530, Anshuman Khandual wrote:
> >> diff --git a/arch/arm64/include/asm/hwcap.h b/arch/arm64/include/asm/hwcap.h
> >> index 0f00265248b5..589ac02e1ddd 100644
> >> --- a/arch/arm64/include/asm/hwcap.h
> >> +++ b/arch/arm64/include/asm/hwcap.h
> >> @@ -8,18 +8,27 @@
> >>  #include <uapi/asm/hwcap.h>
> >>  #include <asm/cpufeature.h>
> >>  
> >> +#define COMPAT_HWCAP_SWP	(1 << 0)
> >>  #define COMPAT_HWCAP_HALF	(1 << 1)
> >>  #define COMPAT_HWCAP_THUMB	(1 << 2)
> >> +#define COMPAT_HWCAP_26BIT	(1 << 3)
> >>  #define COMPAT_HWCAP_FAST_MULT	(1 << 4)
> >> +#define COMPAT_HWCAP_FPA	(1 << 5)
> >>  #define COMPAT_HWCAP_VFP	(1 << 6)
> >>  #define COMPAT_HWCAP_EDSP	(1 << 7)
> >> +#define COMPAT_HWCAP_JAVA	(1 << 8)
> >> +#define COMPAT_HWCAP_IWMMXT	(1 << 9)
> >> +#define COMPAT_HWCAP_CRUNCH	(1 << 10)
> >> +#define COMPAT_HWCAP_THUMBEE	(1 << 11)
> >>  #define COMPAT_HWCAP_NEON	(1 << 12)
> >>  #define COMPAT_HWCAP_VFPv3	(1 << 13)
> >> +#define COMPAT_HWCAP_VFPV3D16	(1 << 14)
> >>  #define COMPAT_HWCAP_TLS	(1 << 15)
> >>  #define COMPAT_HWCAP_VFPv4	(1 << 16)
> >>  #define COMPAT_HWCAP_IDIVA	(1 << 17)
> >>  #define COMPAT_HWCAP_IDIVT	(1 << 18)
> >>  #define COMPAT_HWCAP_IDIV	(COMPAT_HWCAP_IDIVA|COMPAT_HWCAP_IDIVT)
> >> +#define COMPAT_HWCAP_VFPD32	(1 << 19)
> >>  #define COMPAT_HWCAP_LPAE	(1 << 20)
> >>  #define COMPAT_HWCAP_EVTSTRM	(1 << 21)
> > 
> > With the possible exception of SWP (does the swp emulation allow us to
> > report this as supported?), I think all these weren't mentioned because
> > they aren't included in ARMv8 and so can never be reported.
> > 
> > If we find ourselves reporting them, there's a bug somewhere.
> > 
> > So, can we just default all obsolete string entries to NULL?
> > 
> > When generating the cpuinfo strings we could WARN and just emit an empty
> > string for that hwcap.
> 
> All these above will be a change in the existing user visible behavior on
> the system and this patch never intended to create one.

Why is it a change? We've never reported e.g. "java" on an arm64 kernel, so
I agree with Dave that we shouldn't be adding this string. If it /ever/ ends
up in userspace it's because something has gone horribly wrong. NULL would
be much better. Couldn't you achieve that by simply omitting these entries?
e.g. deleting things like:

	[COMPAT_KERNEL_HWCAP(JAVA)]     = "java",

completely (including the COMPAT_HWCAP_JAVA definition)?

> Hence, I will just defer this to maintainers on whether we should change
> existing /proc/cpuinfo output (including non-practically-possible ones on
> ARMv8) or even treat swap emulation as SWP.

SWP is fine because we emulate it and so userspace can use it. Removing that
*would* be a change in behaviour. I don't think the compat ABI is broken
here, so please don't change it without good reason.

Will
