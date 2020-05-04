Return-Path: <SRS0=VwT+=6S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6764C3A5A9
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:48:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 78BFE20707
	for <linux-kernel@archiver.kernel.org>; Mon,  4 May 2020 20:48:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588625290;
	bh=uhstx6i6VStcX5tnxEtH4iTtQS0OGgGawfl0YTLt7FM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=t6BJ9gl87wuGHL0DCgLSz5R4f86+Ddjo92DV31osQWQifAmAgUxwJVZSVzMuu5ktS
	 daaZIMKOZgDCRhI64A8RK7X7yOjrcTX8jAD4quQ5yYqs979n/EQ6uUjXhsvUnasMEu
	 fOF1qyFbIj0ZIkP5Yvhbmdd6T/dO6VA5kHrebJbY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727839AbgEDUsJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 4 May 2020 16:48:09 -0400
Received: from mail.kernel.org ([198.145.29.99]:52716 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726433AbgEDUsJ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 May 2020 16:48:09 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id B7E01206A4;
        Mon,  4 May 2020 20:48:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588625289;
        bh=uhstx6i6VStcX5tnxEtH4iTtQS0OGgGawfl0YTLt7FM=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=xWVk+KqavPLzos8trQkkwJKJqC1RRw0zo6X3ZZmPzXdB1Z3iDAZMvN0af3UToUUiF
         FeBKcul0IpAF/yLlCvP3KXWqB79UXjuFKubP6LkstHKFXB/97OeV862n3tG8I19fFc
         4KFxgu7ymxHTr0OJVpfzNHafDm1zUTDqmKi4dFCo=
Date:   Mon, 4 May 2020 21:48:04 +0100
From:   Will Deacon <will@kernel.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: Re: [PATCH v2] arm64: cacheflush: Fix KGDB trap detection
Message-ID: <20200504204803.GA5657@willie-the-truck>
References: <20200504170518.2959478-1-daniel.thompson@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504170518.2959478-1-daniel.thompson@linaro.org>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 06:05:18PM +0100, Daniel Thompson wrote:
> flush_icache_range() contains a bodge to avoid issuing IPIs when the kgdb
> trap handler is running because issuing IPIs is unsafe (and not needed)
> in this execution context. However the current test, based on
> kgdb_connected is flawed: it both over-matches and under-matches.
> 
> The over match occurs because kgdb_connected is set when gdb attaches
> to the stub and remains set during normal running. This is relatively
> harmelss because in almost all cases irq_disabled() will be false.
> 
> The under match is more serious. When kdb is used instead of kgdb to access
> the debugger then kgdb_connected is not set in all the places that the
> debug core updates sw breakpoints (and hence flushes the icache). This
> can lead to deadlock.
> 
> Fix by replacing the ad-hoc check with the proper kgdb macro. This also
> allows us to drop the #ifdef wrapper.
> 
> Fixes: 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache for kernel mappings")
> Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> Reviewed-by: Douglas Anderson <dianders@chromium.org>
> ---
> 
> Notes:
>     v2: Improve the commit message based based on feedback from Doug
>         Anderson
> 
>  arch/arm64/include/asm/cacheflush.h | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
> index e6cca3d4acf7..ce50c1f1f1ea 100644
> --- a/arch/arm64/include/asm/cacheflush.h
> +++ b/arch/arm64/include/asm/cacheflush.h
> @@ -79,7 +79,7 @@ static inline void flush_icache_range(unsigned long start, unsigned long end)
>  	 * IPI all online CPUs so that they undergo a context synchronization
>  	 * event and are forced to refetch the new instructions.
>  	 */
> -#ifdef CONFIG_KGDB
> +
>  	/*
>  	 * KGDB performs cache maintenance with interrupts disabled, so we
>  	 * will deadlock trying to IPI the secondary CPUs. In theory, we can
> @@ -89,9 +89,9 @@ static inline void flush_icache_range(unsigned long start, unsigned long end)
>  	 * the patching operation, so we don't need extra IPIs here anyway.
>  	 * In which case, add a KGDB-specific bodge and return early.
>  	 */
> -	if (kgdb_connected && irqs_disabled())
> +	if (in_dbg_master())

Does this imply that irqs are disabled?

Will
