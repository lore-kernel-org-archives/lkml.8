Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A66AEC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:40:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7189E2072D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 12:40:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="xB4UytO7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729756AbgGMMkI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 08:40:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726586AbgGMMkH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 08:40:07 -0400
Received: from merlin.infradead.org (merlin.infradead.org [IPv6:2001:8b0:10b:1231::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7101AC061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 05:40:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=merlin.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=qz2Jv/ggSypwc0uJUR+d7mBt/eDO9LlrpJONIT78xfg=; b=xB4UytO71//Pna0dWhCyanNjbh
        aFxl8OHX2P+qf5CbnDBiRkxYkgPDUAt7R8rej9YA8miyY8zOEJYaM69AvxXtW/3pNNLC5MljBPvMq
        eBe5gclv5669CepzpmcbICsop/nzWCn3loAi1ojzoFCE7D79vdxpNqm0UMafSxknzfuniJW4TWO7T
        Rf0M1luzNSuTTt7UZXuI1eBZMN2PHHU0bgwceAigCPdHgcLMsszqQeuaVuZpAnA/U9c4xSvUy/FWV
        EMCZqemGtSgGV0dG1uv4A6EQEveiV/aW7QZtC+Bk06L4Zukb1Rw5+KFJeVHf5TRJCURMl+93vAmaE
        TwbPXCuw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by merlin.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1juxkY-0000um-Kw; Mon, 13 Jul 2020 12:40:02 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id C5557300DB4;
        Mon, 13 Jul 2020 14:39:59 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id AD69420D27C7E; Mon, 13 Jul 2020 14:39:59 +0200 (CEST)
Date:   Mon, 13 Jul 2020 14:39:59 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     linux-kernel@vger.kernel.org, mingo@kernel.org,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com
Subject: Re: [PATCH v3 6/7] sched/topology: Introduce SD metaflag for flags
 needing > 1 groups
Message-ID: <20200713123959.GI10769@hirez.programming.kicks-ass.net>
References: <20200701190656.10126-1-valentin.schneider@arm.com>
 <20200701190656.10126-7-valentin.schneider@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200701190656.10126-7-valentin.schneider@arm.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 01, 2020 at 08:06:54PM +0100, Valentin Schneider wrote:
> +/* Generate a mask of SD flags with the SDF_NEEDS_GROUPS metaflag */
> +#define SD_FLAG(name, idx, mflags) (BIT(idx) * (((mflags) & SDF_NEEDS_GROUPS) / SDF_NEEDS_GROUPS)) |

#define SD_FLAGS(name, idx, mflags) (!!((mflags) & SDF_NEEDS_GROUPS) * BIT(idx))

> +static const int SD_DEGENERATE_GROUPS_MASK =
> +#include<linux/sched/sd_flags.h>
> +0;
> +#undef SD_FLAG
> +
>  #ifdef CONFIG_SCHED_DEBUG
>  #define SD_FLAG(_name, idx, mflags) [idx] = {.meta_flags = mflags, .name = #_name},
>  static const struct {
> -- 
> 2.27.0
> 
