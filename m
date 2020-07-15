Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 158BFC433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:56:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D6EB420663
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 05:56:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="Ni/17QdY";
	dkim=permerror (0-bit key) header.d=linutronix.de header.i=@linutronix.de header.b="JmUnuZre"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728757AbgGOF4y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 01:56:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725811AbgGOF4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 01:56:54 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D3422C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 22:56:53 -0700 (PDT)
Date:   Wed, 15 Jul 2020 07:56:50 +0200
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1594792612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xEz6zpbt0xsuZlsRzMleqOaAxb08W357YybuYKHG9z8=;
        b=Ni/17QdYoBFRFr/T8jycotCbAOm4FkXTGT67Yy9HrBndnAE/DL7xUK+o7Fq6gWyV1Hs+DK
        eu//GM0u77nIcmo35qlqifkHlQHGlU8ZwCJ5zkaaqx3t9ZfATtEgoXv85n3PThNokoqYxa
        SlbTmZf1v7xQvKZ/xreZZOROSX34u2ukJjC33AhNE/ZUBidQ+a2ELrB2p7zEjhhhhYZ3Z4
        ycpiOngX9uws9ImJr4shWoVn+RsgwWv4SVe6gQU23qovvfDlPmpNY5dp4WXpwg9a8QpPrT
        XOrcReyLtoyESzLcQQkGbqfO8Ogffo7/1ei7WfBjS5nPO6Zd6s9aVvL+Z4Am/g==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1594792612;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=xEz6zpbt0xsuZlsRzMleqOaAxb08W357YybuYKHG9z8=;
        b=JmUnuZredCRHLaWI1Bu3Wun/oZSKmCV+haaRnFd3KXMuCXaOQkPXJ6KkPHc2B+K4X0nC1D
        urPjPt/1KTI1hEDg==
From:   "Ahmed S. Darwish" <a.darwish@linutronix.de>
To:     Leo Yan <leo.yan@linaro.org>, Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, Mark Rutland <mark.rutland@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Alexander Shishkin <alexander.shishkin@linux.intel.com>,
        Jiri Olsa <jolsa@redhat.com>,
        Namhyung Kim <namhyung@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Paul Cercueil <paul@crapouillou.net>,
        "Ben Dooks (Codethink)" <ben.dooks@codethink.co.uk>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Kan Liang <kan.liang@linux.intel.com>, jogness@linutronix.de,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2 1/6] sched_clock: Expose struct clock_read_data
Message-ID: <20200715055650.GB225020@debian-buster-darwi.lab.linutronix.de>
References: <20200715020512.20991-1-leo.yan@linaro.org>
 <20200715020512.20991-2-leo.yan@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200715020512.20991-2-leo.yan@linaro.org>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 15, 2020 at 10:05:07AM +0800, Leo Yan wrote:
> From: Peter Zijlstra <peterz@infradead.org>
>
...
>
> Provide struct clock_read_data and two (seqcount) helpers so that
> architectures (arm64 in specific) can expose the numbers to userspace.
>
...
>
> +struct clock_read_data *sched_clock_read_begin(unsigned int *seq)
> +{
> +	*seq = raw_read_seqcount(&cd.seq);
> +	return cd.read_data + (*seq & 1);
> +}
> +
...

Hmm, this seqcount_t is actually a latch seqcount. I know the original
code also used raw_read_seqcount(), but while at it, let's use the
proper read API for seqcount_t latchers: raw_read_seqcount_latch().

raw_read_seqcount_latch() has no read memory barrier though, and a
suspicious claim that READ_ONCE() pairs with an smp_wmb() (??). But if
its implementation is wrong, let's fix it there instead.

Thanks,

--
Ahmed S. Darwish
Linutronix GmbH
