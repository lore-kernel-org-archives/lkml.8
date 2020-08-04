Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7AF43C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:16:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 61716207FC
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 11:16:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="dRv1njrB"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730233AbgHDLQW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 07:16:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55642 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730118AbgHDLPB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 07:15:01 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D85CEC061756
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 04:08:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=LB7jmCFC/W82958r6LEZ1hABD4alrUzDqK9eGecST54=; b=dRv1njrB5aKGteUDUCZASxt1Zh
        gFAL4j55c1Gidy+tKtz925jDMtqOVwJ57cHkQXCw64b3c62e64mtMwhM/H1km9ElWrbaYmw1OSbvZ
        e8Hg9hiEhcil16aW5/7lVXXLZCfTBmImymyMVireG4j1PdMUfS4avU3npPFZN0PZzJUUT80LLCC9L
        5F+v/wSwg+2tabk4EXiqJpvb6DHUEVgu26jXHVAEqczSniFInexPVZLPVDqVlc/NDebCOndMwZHhb
        txgBRFbrlnwx0K41rla2CK7yxPt97Un5Oj5Y/7jZWAquoXc+RQRv8LJmIpt2fy3hTsvjFBKZGqdou
        WWyXwPdg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1k2uoC-0003wm-Tu; Tue, 04 Aug 2020 11:08:41 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3F3A3301A66;
        Tue,  4 Aug 2020 13:08:40 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 1DEA62BE64848; Tue,  4 Aug 2020 13:08:40 +0200 (CEST)
Date:   Tue, 4 Aug 2020 13:08:40 +0200
From:   peterz@infradead.org
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, Quentin Perret <qperret@google.com>
Subject: Re: [PATCH v4 05/10] sched/topology: Define and assign sched_domain
 flag metadata
Message-ID: <20200804110840.GF2657@hirez.programming.kicks-ass.net>
References: <20200731115502.12954-1-valentin.schneider@arm.com>
 <20200731115502.12954-6-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200731115502.12954-6-valentin.schneider@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 12:54:57PM +0100, Valentin Schneider wrote:
> +/*
> + * Domain members share CPU capacity (i.e. SMT)
> + *
> + * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
> + * CPU capacity.
> + */
> +SD_FLAG(SD_SHARE_CPUCAPACITY,   6, SDF_SHARED_CHILD)
> +
> +/*
> + * Domain members share CPU package resources (i.e. caches)
> + *
> + * SHARED_CHILD: Set from the base domain up until spanned CPUs no longer share
> + * the same cache(s).
> + */
> +SD_FLAG(SD_SHARE_PKG_RESOURCES, 7, SDF_SHARED_CHILD)

We should probably rename these to SD_SHARE_CORE / SD_SHARE_CACHE or
something, but let me first go through this series (and hopefully apply)
before we go make more changes.


.. onwards!
