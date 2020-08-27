Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.3 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66D13C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 11:47:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 495452177B
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 11:47:40 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728906AbgH0LrH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 07:47:07 -0400
Received: from mail.kernel.org ([198.145.29.99]:49446 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1728533AbgH0Lf1 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 07:35:27 -0400
Received: from gaia (unknown [46.69.195.127])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 39DEE22BF3;
        Thu, 27 Aug 2020 11:10:31 +0000 (UTC)
Date:   Thu, 27 Aug 2020 12:10:28 +0100
From:   Catalin Marinas <catalin.marinas@arm.com>
To:     Vincenzo Frascino <vincenzo.frascino@arm.com>
Cc:     Andrey Konovalov <andreyknvl@google.com>,
        Dmitry Vyukov <dvyukov@google.com>, kasan-dev@googlegroups.com,
        Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Marco Elver <elver@google.com>,
        Evgenii Stepanov <eugenis@google.com>,
        Elena Petrova <lenaptr@google.com>,
        Branislav Rankov <Branislav.Rankov@arm.com>,
        Kevin Brodsky <kevin.brodsky@arm.com>,
        Will Deacon <will.deacon@arm.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-arm-kernel@lists.infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 20/35] arm64: mte: Add in-kernel MTE helpers
Message-ID: <20200827111027.GJ29264@gaia>
References: <cover.1597425745.git.andreyknvl@google.com>
 <2cf260bdc20793419e32240d2a3e692b0adf1f80.1597425745.git.andreyknvl@google.com>
 <20200827093808.GB29264@gaia>
 <588f3812-c9d0-8dbe-fce2-1ea89f558bd2@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <588f3812-c9d0-8dbe-fce2-1ea89f558bd2@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 11:31:56AM +0100, Vincenzo Frascino wrote:
> On 8/27/20 10:38 AM, Catalin Marinas wrote:
> > On Fri, Aug 14, 2020 at 07:27:02PM +0200, Andrey Konovalov wrote:
> >> +void * __must_check mte_set_mem_tag_range(void *addr, size_t size, u8 tag)
> >> +{
> >> +	void *ptr = addr;
> >> +
> >> +	if ((!system_supports_mte()) || (size == 0))
> >> +		return addr;
> >> +
> >> +	tag = 0xF0 | (tag & 0xF);
> >> +	ptr = (void *)__tag_set(ptr, tag);
> >> +	size = ALIGN(size, MTE_GRANULE_SIZE);
> > 
> > I think aligning the size is dangerous. Can we instead turn it into a
> > WARN_ON if not already aligned? At a quick look, the callers of
> > kasan_{un,}poison_memory() already align the size.
> 
> The size here is used only for tagging purposes and if we want to tag a
> subgranule amount of memory we end up tagging the granule anyway. Why do you
> think it can be dangerous?

In principle, I don't like expanding the size unless you are an
allocator. Since this code doesn't control the placement of the object
it was given, a warn seems more appropriate.

> >> +/*
> >> + * Assign allocation tags for a region of memory based on the pointer tag
> >> + *   x0 - source pointer
> >> + *   x1 - size
> >> + *
> >> + * Note: size is expected to be MTE_GRANULE_SIZE aligned
> >> + */
> >> +SYM_FUNC_START(mte_assign_mem_tag_range)
> >> +	/* if (src == NULL) return; */
> >> +	cbz	x0, 2f
> >> +	/* if (size == 0) return; */
> > 
> > You could skip the cbz here and just document that the size should be
> > non-zero and aligned. The caller already takes care of this check.
> 
> I would prefer to keep the check here, unless there is a valid reason, since
> allocate(0) is a viable option hence tag(x, 0) should be as well. The caller
> takes care of it in one place, today, but I do not know where the API will be
> used in future.

That's why I said just document it in the comment above the function.

The check is also insufficient if the size is not aligned to an MTE
granule, so it's not really consistent. This function should end with a
subs followed by b.gt as cbnz will get stuck in a loop for unaligned
size.

-- 
Catalin
