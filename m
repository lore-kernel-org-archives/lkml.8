Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98D5EC10F29
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:43:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 58ED820768
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 12:43:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1584449011;
	bh=JS5Tz+SUrQ/bCk5HMtBNTJnu0kaZhX025LXI2/e1w48=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=pOOEVGIWu+iOJwv/uShgLfE7g9CcYD+kcFO7DX6hOD6mfgb2wWXxQfl5ASO+eSxq8
	 Fw+r6/vwiEL3RO9CW9R/Qohf9MbEatjZOLA5R6XGRosmzatbMVW5bHVIuDg0SydpOs
	 uTHQmp2GAlK9sd4Dx8E37LX3jNIDXVOLSQaZ9KQc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726741AbgCQMna (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 08:43:30 -0400
Received: from mail.kernel.org ([198.145.29.99]:59760 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1725906AbgCQMn3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 08:43:29 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id ED97820752;
        Tue, 17 Mar 2020 12:43:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1584449009;
        bh=JS5Tz+SUrQ/bCk5HMtBNTJnu0kaZhX025LXI2/e1w48=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=lG8WcZgiMNnoyQju0x5QfLGR+BIUZZBJ06YhibAgvuYU08e2AQAGHmc65gS5T3d1Q
         JGgBp4tstvBayCv4BF7TgFwxLECSAZtbggMZ2aRJ8leuo6QKn+ufyX8QWXWXktFyP3
         SMR2xWGWzVLH/ckpMG/XQhKaa1MC6GPNh5hzB0hk=
Date:   Tue, 17 Mar 2020 12:43:24 +0000
From:   Will Deacon <will@kernel.org>
To:     Mark Rutland <mark.rutland@arm.com>
Cc:     Hongbo Yao <yaohongbo@huawei.com>, broonie@kernel.org,
        linux-kernel@vger.kernel.org, catalin.marinas@arm.com,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [RFC PATCH] arm64: fix the missing ktpi= cmdline check in
 arm64_kernel_unmapped_at_el0()
Message-ID: <20200317124323.GA16200@willie-the-truck>
References: <20200317114708.109283-1-yaohongbo@huawei.com>
 <20200317121050.GH8831@lakrids.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200317121050.GH8831@lakrids.cambridge.arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 17, 2020 at 12:10:51PM +0000, Mark Rutland wrote:
> [Adding Catalin and LAKML]
> 
> Mark.
> 
> On Tue, Mar 17, 2020 at 07:47:08PM +0800, Hongbo Yao wrote:
> > Kpti cannot be disabled from the kernel cmdline after the commit
> > 09e3c22a("arm64: Use a variable to store non-global mappings decision").
> > 
> > Bring back the missing check of kpti= command-line option to fix the
> > case where the SPE driver complains the missing "kpti-off" even it has
> > already been set.
> > 
> > Signed-off-by: Hongbo Yao <yaohongbo@huawei.com>
> > ---
> >  arch/arm64/include/asm/mmu.h | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> > 
> > diff --git a/arch/arm64/include/asm/mmu.h b/arch/arm64/include/asm/mmu.h
> > index 3c9533322558..ebbc0d3ac2f7 100644
> > --- a/arch/arm64/include/asm/mmu.h
> > +++ b/arch/arm64/include/asm/mmu.h
> > @@ -34,7 +34,8 @@ extern bool arm64_use_ng_mappings;
> >  
> >  static inline bool arm64_kernel_unmapped_at_el0(void)
> >  {
> > -	return arm64_use_ng_mappings;
> > +	return arm64_use_ng_mappings &&
> > +		cpus_have_const_cap(ARM64_UNMAP_KERNEL_AT_EL0);
> >  }

This probably isn't the right fix, since this will mean that early mappings
will be global and we'll have to go through the painful page-table rewrite
logic when the cap gets enabled for KASLR-enabled kernels.

Maybe a better bodge is something like:

diff --git a/arch/arm64/kernel/cpufeature.c b/arch/arm64/kernel/cpufeature.c
index 0b6715625cf6..ad10f55b7bb9 100644
--- a/arch/arm64/kernel/cpufeature.c
+++ b/arch/arm64/kernel/cpufeature.c
@@ -1085,6 +1085,8 @@ static bool unmap_kernel_at_el0(const struct arm64_cpu_capabilities *entry,
 		if (!__kpti_forced) {
 			str = "KASLR";
 			__kpti_forced = 1;
+		} else if (__kpti_forced < 0) {
+			arm64_use_ng_mappings = false;
 		}
 	}
 

Will
