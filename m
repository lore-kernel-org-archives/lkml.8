Return-Path: <SRS0=4xmc=56=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.1 required=3.0 tests=DKIM_INVALID,DKIM_SIGNED,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5CBD6C352BE
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:44:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2CB96206A2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Apr 2020 21:44:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=infradead.org header.i=@infradead.org header.b="GLXZ6cso"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2634089AbgDNVo1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Apr 2020 17:44:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2633992AbgDNVlC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Apr 2020 17:41:02 -0400
Received: from bombadil.infradead.org (bombadil.infradead.org [IPv6:2607:7c80:54:e::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A98DC061A0F;
        Tue, 14 Apr 2020 14:41:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=bombadil.20170209; h=In-Reply-To:Content-Type:MIME-Version
        :References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=6fW3z+0t6iwTFLSm5U6E4jEaZgRMxQt5XSHRbl0FIRU=; b=GLXZ6cso7/Kc9otHNvl8xNFk/k
        3UnSjYeKFsTUOkbVxZK/gCzgj1My1hl1o3jN3fQjv1wk+Wcz3SnclnAqLfm/yckHoXM7vds9UZWPk
        HiZCwOWAXCGu8TV0dcePkHD5azQHaMnHr6dltqVKK1OESvty+X5Zwsy+1hg+KF9s7e5rRTJNd4stR
        xTkUdigirsUtpJxm86+4YWDYH6VbuvVVqnjwGKKd3UI3rC3yG4o+c77Yq0+n46YXKePWcmCaf5IzP
        fVUyWu0XWZWK4NiaUttgeKRC2lNfWOK5+c1qSqDnVzPX1/Na7uCSAF0p8QPY6a5B1GiPXQCNwLED9
        2svhZsBQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by bombadil.infradead.org with esmtpsa (Exim 4.92.3 #3 (Red Hat Linux))
        id 1jOTIY-00026w-Rw; Tue, 14 Apr 2020 21:40:51 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 8BF8F981086; Tue, 14 Apr 2020 23:40:48 +0200 (CEST)
Date:   Tue, 14 Apr 2020 23:40:48 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     linux-kernel@vger.kernel.org, linux-edac@vger.kernel.org,
        x86@kernel.org, arnd@arndb.de, srinivas.pandruvada@linux.intel.com,
        bberg@redhat.com, bp@suse.de,
        "Rafael J. Wysocki" <rjw@rjwysocki.net>
Subject: Re: [PATCH 3/3] x86/mce/therm_throt: allow disabling the thermal
 vector altogether
Message-ID: <20200414214048.GL2483@worktop.programming.kicks-ass.net>
References: <20200407063345.4484-1-Jason@zx2c4.com>
 <20200407063345.4484-3-Jason@zx2c4.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200407063345.4484-3-Jason@zx2c4.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Apr 07, 2020 at 12:33:45AM -0600, Jason A. Donenfeld wrote:
> The thermal IRQ handler uses 1.21% CPU on my system when it's hot from
> compiling things. Indeed looking at /proc/interrupts reveals quite a lot
> of events coming in. Beyond logging them, the existing drivers on the
> system don't appear to do very much that I'm interested in. So, add a
> way to disable this entirely so that I can regain precious CPU cycles.

Why is this MCE code?!? hysterical raisins?

Anyway, I wonder if this is something we should hook up to
SCHED_THERMAL_PRESSURE, Rafael?

> diff --git a/arch/x86/kernel/cpu/mce/intel.c b/arch/x86/kernel/cpu/mce/intel.c
> index f996ffb887bc..d14f1922fb49 100644
> --- a/arch/x86/kernel/cpu/mce/intel.c
> +++ b/arch/x86/kernel/cpu/mce/intel.c
> @@ -511,7 +511,8 @@ static void intel_ppin_init(struct cpuinfo_x86 *c)
>  
>  void mce_intel_feature_init(struct cpuinfo_x86 *c)
>  {
> -	intel_init_thermal(c);
> +	if (IS_ENABLED(CONFIG_X86_THERMAL_VECTOR))
> +		intel_init_thermal(c);
>  	intel_init_cmci();
>  	intel_init_lmce();
>  	intel_ppin_init(c);
> -- 
> 2.26.0
> 
