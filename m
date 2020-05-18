Return-Path: <SRS0=RE5T=7A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CBF0EC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:37:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A84BC206D4
	for <linux-kernel@archiver.kernel.org>; Mon, 18 May 2020 13:37:26 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728177AbgERNh0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 09:37:26 -0400
Received: from foss.arm.com ([217.140.110.172]:40820 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728148AbgERNhW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 09:37:22 -0400
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9C84A101E;
        Mon, 18 May 2020 06:37:21 -0700 (PDT)
Received: from C02TD0UTHF1T.local (unknown [10.57.29.34])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 28C743F305;
        Mon, 18 May 2020 06:37:18 -0700 (PDT)
Date:   Mon, 18 May 2020 14:37:16 +0100
From:   Mark Rutland <mark.rutland@arm.com>
To:     Will Deacon <will@kernel.org>
Cc:     linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Sami Tolvanen <samitolvanen@google.com>,
        Kees Cook <keescook@chromium.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@am.com>,
        Jann Horn <jannh@google.com>, Ard Biesheuvel <ardb@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>, kernel-team@android.com
Subject: Re: [PATCH 6/6] scs: Move DEFINE_SCS macro into core code
Message-ID: <20200518133716.GD2787@C02TD0UTHF1T.local>
References: <20200515172756.27185-1-will@kernel.org>
 <20200515172756.27185-7-will@kernel.org>
 <20200518121441.GE1957@C02TD0UTHF1T.local>
 <20200518132612.GE32394@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200518132612.GE32394@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 02:26:12PM +0100, Will Deacon wrote:
> On Mon, May 18, 2020 at 01:14:41PM +0100, Mark Rutland wrote:
> > On Fri, May 15, 2020 at 06:27:56PM +0100, Will Deacon wrote:
> > > Defining static shadow call stacks is not architecture-specific, so move
> > > the DEFINE_SCS() macro into the core header file.
> > > 
> > > Signed-off-by: Will Deacon <will@kernel.org>
> > 
> > I think that we'll have to pull this back into arch code if/when we deal
> > with VMAP'd stacks, so I'm not sure this is worthwhile given the
> > diffstat is balanced.
> 
> I dunno, if another architecture wants to use this then having the stuff
> in the core code makes sense to me. I also want to kill asm/scs.h entirely
> and move our asm macros somewhere else where they're not mixed up with the
> C headers.

Thinking about it a bit further, we'd have to make bigger changes anyhow
(to dynamically allocate), but given we can do that for regular stacks
we can probably do something similar here.

So no strong feelings either way on this patch.

Reviewed-by: Mark Rutland <mark.rutland@arm.com>

Mark.
