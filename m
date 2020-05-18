Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 85289C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:44:07 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 594A52083E
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 16:44:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1589820247;
	bh=Ru5daAPvYMUtBQ4maN6kK+37JBdLU14AaRx0g9PrqZ8=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=LTrFbneFLDVei5PR/+abvS9R8vocbMLbLXd5LpnCZ8CC+hD6EHzmLBBy7u0+Dpfh9
	 Djg/Wsa7Dlf0ENd1WDqcjeFVxYvDpz+EtvQsV/N6em1XcAPYADW6dQNRuBuLDyqsZ8
	 SzVwBTtDVNJimDPafA9IwBO/kPCbFNzTpoYMxZ0s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728485AbgERQoG (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 12:44:06 -0400
Received: from mail.kernel.org ([198.145.29.99]:37910 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726958AbgERQoF (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 12:44:05 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 74C4620809;
        Mon, 18 May 2020 16:44:03 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1589820245;
        bh=Ru5daAPvYMUtBQ4maN6kK+37JBdLU14AaRx0g9PrqZ8=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=theqyDgFVl5bFmNcFXgQZicSZ6Z2380vxQ5nm1wFr9KS/LDPa9VFUQ6w67VYLiqMV
         iI82AhyjYi4bUTlsDEpdSwxtwWB7PGx17GFYGv/TVl6SMlPW6MJ2e01qxRmXTJoZc2
         Zu3/OUoEWjBZZfOKQM30rLEB074F3IgmiavbiAvo=
Date:   Mon, 18 May 2020 17:44:00 +0100
From:   Will Deacon <will@kernel.org>
To:     Kees Cook <keescook@chromium.org>
Cc:     Mark Rutland <mark.rutland@arm.com>, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@am.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@android.com
Subject: Re: [PATCH 4/6] scs: Move scs_overflow_check() out of architecture
 code
Message-ID: <20200518164359.GQ32394@willie-the-truck>
References: <20200515172756.27185-1-will@kernel.org>
 <20200515172756.27185-5-will@kernel.org>
 <20200518121210.GD1957@C02TD0UTHF1T.local>
 <20200518132346.GD32394@willie-the-truck>
 <20200518133231.GC2787@C02TD0UTHF1T.local>
 <202005180823.A9C8925ED@keescook>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <202005180823.A9C8925ED@keescook>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 08:31:49AM -0700, Kees Cook wrote:
> On Mon, May 18, 2020 at 02:32:31PM +0100, Mark Rutland wrote:
> > On Mon, May 18, 2020 at 02:23:47PM +0100, Will Deacon wrote:
> > > This is something I would like to revisit, but we need more
> > > information from Sami about why Android rejected the larger allocation
> > > size, since I don't think there's an awful lot of point merging this
> > > series if Android doesn't pick it up.
> > 
> > Indeed. I'd certainly prefer the robustness of a VMAP'd SCS if we can do
> > that.
> 
> For smaller devices, the memory overhead was too high. (i.e. 4x more
> memory allocated to kernel stacks -- 4k vs 1k per thread.)

I just don't see an extra 3k per thread as being a real issue (the main
stack is 16k already). Even just the CPU register state is around 1k.

But I'd be very keen to see numbers/performance data that proves me wrong.

Will
