Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E1B2FC433E1
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:00:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B842D206D7
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 12:00:34 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="aZbV28BZ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729333AbgG1MAd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jul 2020 08:00:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728433AbgG1MAb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jul 2020 08:00:31 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6452DC061794
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jul 2020 05:00:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=65mlISD8+bvHJLtdL7W7KVUZ5VfPrEhV6z6gSzVVTg8=; b=aZbV28BZ0X2XqFcpgcOgwDE9V1
        jnCH26zniMVRZEZPNUoO3YEbDpWTpogbpz4M+nFohIFIdkB6reqoz5dHcf/OI9+HHLI/qRhFmTQzv
        I5Rl8DwLavwxMQFgQ3/fXfrBL6G4Xq1NJPF4DcgroIk2fE7ihgBX7M3itN2oxgaDfo/02s4za5NI/
        bg6wdWwNVxdTkCChoq5NtIjhElha1Iq4D+UImYv5kPCUfotj//o7CQbrqmodJg8zrpFf2pMQdQqhZ
        EADDtHECf/P9N+42U2Xc4DuiTzr5ZlrNdcRgWjA6OZehLJVTnaD1gMJszvZhK2sWSAKcsaHwPAxnz
        fHbgCz4g==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k0OHU-0000Ru-4I; Tue, 28 Jul 2020 12:00:28 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 36501300238;
        Tue, 28 Jul 2020 14:00:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1A2502BB5575B; Tue, 28 Jul 2020 14:00:27 +0200 (CEST)
Date:   Tue, 28 Jul 2020 14:00:27 +0200
From:   peterz@infradead.org
To:     Vincent Donnefort <vincent.donnefort@arm.com>
Cc:     mingo@redhat.com, vincent.guittot@linaro.org,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        lukasz.luba@arm.com, valentin.schneider@arm.com
Subject: Re: [PATCH] sched/fair: provide u64 read for 32-bits arch helper
Message-ID: <20200728120027.GN43129@hirez.programming.kicks-ass.net>
References: <1595847564-239957-1-git-send-email-vincent.donnefort@arm.com>
 <20200727123801.GJ119549@hirez.programming.kicks-ass.net>
 <20200727152303.GA301827@e120877-lin.cambridge.arm.com>
 <20200728111302.GV119549@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200728111302.GV119549@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 28, 2020 at 01:13:02PM +0200, peterz@infradead.org wrote:
> On Mon, Jul 27, 2020 at 04:23:03PM +0100, Vincent Donnefort wrote:
> 
> > For 32-bit architectures, both min_vruntime and last_update_time are using
> > similar access. This patch is simply an attempt to unify their usage by
> > introducing two macros to rely on when accessing those. At the same time, it
> > brings a comment regarding the barriers usage, as per the kernel policy. So
> > overall this is just a clean-up without any functional changes.
> 
> Ah, I though there was perhaps the idea to make use of armv7-lpae
> instructions.
> 
> Aside of that, I think we need to spend a little time bike-shedding the
> API/naming here:
> 
> > +# define u64_32read(val, copy) (val)
> > +# define u64_32read_set_copy(val, copy) do { } while (0)
> 
> How about something like:
> 
> #ifdef CONFIG_64BIT
> 
> #define DEFINE_U64_U32(name)	u64 name
> #define u64_u32_load(name)	name
> #define u64_u32_store(name, val)name = val
> 
> #else
> 
> #define DEFINE_U64_U32(name)			\
> 	struct {				\
> 		u64 name;			\
> 		u64 name##_copy;		\
> 	}
> 
> #define u64_u32_load(name)			\
> 	({					\
> 		u64 val, copy;			\
> 		do {				\
> 			val = name;		\
> 			smb_rmb();		\
> 			copy = name##_copy;	\
> 		} while (val != copy);		\

wrong order there; we should first read _copy and then the regular one
of course.

> 		val;
> 	})
> 
> #define u64_u32_store(name, val)		\
> 	do {					\
> 		typeof(val) __val = (val);	\
> 		name = __val;			\
> 		smp_wmb();			\
> 		name##_copy = __val;		\
> 	} while (0)
> 
> #endif

The other approach is making it a full type and inline functions I
suppose.
