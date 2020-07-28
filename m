Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4AC33C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:13:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2201B2065C
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 11:13:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="Reko/uz8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728982AbgG1LNJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 07:13:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33514 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728699AbgG1LNJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 07:13:09 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54F0EC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 04:13:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=PA/tyGEWDw6vKLglviCoSjcXo61IZIN6Uwk0RcC9WsI=; b=Reko/uz8yJAr/RR8GHuZPaRWeB
        sbVWUQ/RryMAKaEvyjVw02qYrg1SHdGYlbwhtV31VnkLzsGeigtJHMeeVlR0G+sA6ENcwIBeFp5q9
        j/om3venJu7sr6B+rbsmFTKdzTNDZ6mE8w4SDfWcZpBAluG+Gn6BVw/WeOUBOPeC7CAtO1y6rmO0K
        0INzjZt5XjAnZyJiweBfJXw3a28O6wQaT35b9+eTDoisoUifYdKrQvAjT6dvrYeo2HwncBC9iW6j2
        7ZYPPyQE/zc/8neMUJFnxlZC0vekz8pgNszfoBu7hR6cIiFKJfTN/MAvnKDC9hyWtM1ZciuSN08mk
        DZsOBIHA==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0NXd-0006HL-H8; Tue, 28 Jul 2020 11:13:05 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 1620430411F;
        Tue, 28 Jul 2020 13:13:03 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 00A762BE45AF1; Tue, 28 Jul 2020 13:13:02 +0200 (CEST)
Date:   Tue, 28 Jul 2020 13:13:02 +0200
From:   peterz@infradead.org
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        lukasz.luba@arm.com, valentin.schneider@arm.com
Subject: Re: [PATCH] sched/fair: provide u64 read for 32-bits arch helper
Message-ID: <20200728111302.GV119549@hirez.programming.kicks-ass.net>
References: <1595847564-239957-1-git-send-email-vincent.donnefort@arm.com>
 <20200727123801.GJ119549@hirez.programming.kicks-ass.net>
 <20200727152303.GA301827@e120877-lin.cambridge.arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200727152303.GA301827@e120877-lin.cambridge.arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 27, 2020 at 04:23:03PM +0100, Vincent Donnefort wrote:

> For 32-bit architectures, both min_vruntime and last_update_time are using
> similar access. This patch is simply an attempt to unify their usage by
> introducing two macros to rely on when accessing those. At the same time, it
> brings a comment regarding the barriers usage, as per the kernel policy. So
> overall this is just a clean-up without any functional changes.

Ah, I though there was perhaps the idea to make use of armv7-lpae
instructions.

Aside of that, I think we need to spend a little time bike-shedding the
API/naming here:

> +# define u64_32read(val, copy) (val)
> +# define u64_32read_set_copy(val, copy) do { } while (0)

How about something like:

#ifdef CONFIG_64BIT

#define DEFINE_U64_U32(name)	u64 name
#define u64_u32_load(name)	name
#define u64_u32_store(name, val)name = val

#else

#define DEFINE_U64_U32(name)			\
	struct {				\
		u64 name;			\
		u64 name##_copy;		\
	}

#define u64_u32_load(name)			\
	({					\
		u64 val, copy;			\
		do {				\
			val = name;		\
			smb_rmb();		\
			copy = name##_copy;	\
		} while (val != copy);		\
		val;
	})

#define u64_u32_store(name, val)		\
	do {					\
		typeof(val) __val = (val);	\
		name = __val;			\
		smp_wmb();			\
		name##_copy = __val;		\
	} while (0)

#endif


