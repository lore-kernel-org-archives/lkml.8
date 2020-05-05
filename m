Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D76F9C47254
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:09:23 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F5D6207DD
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 15:09:23 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1588691363;
	bh=wehOs7TzzSRDwsIiBrb11QEbyguhnDAUrPFjehEcsWw=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=r5z5PdzUxIlSY9/pVwqEx4KJX33onmraFmVSFE18nJDcX6TnQoh7OHKGMyOPu7CF2
	 Z2BXmmILcpW96gOe7N1eGV7zFaBUSRp8lYwRwzup5QYDB2OCAulYBFN3ub438kT5zj
	 eXxhGAgmMKGIjvs6riYl141z682+3/WKMQNR1VJ0=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729801AbgEEPJW (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 11:09:22 -0400
Received: from mail.kernel.org ([198.145.29.99]:37492 "EHLO mail.kernel.org"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1729320AbgEEPJW (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 11:09:22 -0400
Received: from willie-the-truck (236.31.169.217.in-addr.arpa [217.169.31.236])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by mail.kernel.org (Postfix) with ESMTPSA id 3E4DF2078D;
        Tue,  5 May 2020 15:09:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=default; t=1588691361;
        bh=wehOs7TzzSRDwsIiBrb11QEbyguhnDAUrPFjehEcsWw=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=EyaqCaFCUiFGU75ZiQ7lP/igTsu2wIlIHWUSD6+l2UJXUc/h+OJW+8gTjIs0ZICMo
         Py1MVzr2BsXo41HNEwcnLiGZG8HI3+eUekL+yTwId7gnF4Oz26D6m9Q74+aSJFNItE
         BmSem2l5jrxSksyLXkKfBJgNDYKiYzBrc4IxcT7Q=
Date:   Tue, 5 May 2020 16:09:16 +0100
From:   Will Deacon <will@kernel.org>
To:     Daniel Thompson <daniel.thompson@linaro.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: Re: [PATCH v2] arm64: cacheflush: Fix KGDB trap detection
Message-ID: <20200505150916.GC24239@willie-the-truck>
References: <20200504170518.2959478-1-daniel.thompson@linaro.org>
 <20200504204803.GA5657@willie-the-truck>
 <20200505141529.2qb35fbqudtac3ys@holly.lan>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505141529.2qb35fbqudtac3ys@holly.lan>
User-Agent: Mutt/1.10.1 (2018-07-13)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 03:15:29PM +0100, Daniel Thompson wrote:
> On Mon, May 04, 2020 at 09:48:04PM +0100, Will Deacon wrote:
> > On Mon, May 04, 2020 at 06:05:18PM +0100, Daniel Thompson wrote:
> > > diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
> > > index e6cca3d4acf7..ce50c1f1f1ea 100644
> > > --- a/arch/arm64/include/asm/cacheflush.h
> > > +++ b/arch/arm64/include/asm/cacheflush.h
> > > @@ -79,7 +79,7 @@ static inline void flush_icache_range(unsigned long start, unsigned long end)
> > >  	 * IPI all online CPUs so that they undergo a context synchronization
> > >  	 * event and are forced to refetch the new instructions.
> > >  	 */
> > > -#ifdef CONFIG_KGDB
> > > +
> > >  	/*
> > >  	 * KGDB performs cache maintenance with interrupts disabled, so we
> > >  	 * will deadlock trying to IPI the secondary CPUs. In theory, we can
> > > @@ -89,9 +89,9 @@ static inline void flush_icache_range(unsigned long start, unsigned long end)
> > >  	 * the patching operation, so we don't need extra IPIs here anyway.
> > >  	 * In which case, add a KGDB-specific bodge and return early.
> > >  	 */
> > > -	if (kgdb_connected && irqs_disabled())
> > > +	if (in_dbg_master())
> > 
> > Does this imply that irqs are disabled?
> 
> Yes.
> 
> Assuming CONFIG_KGDB is enabled then in_dbg_master() expands to:
> 
>     (raw_smp_processor_id() == atomic_read(&kgdb_active))

Aha, so this can drop the raw_ prefix and call smp_processor_id() instead?
I can queue the arm64 patch regardless.

Cheers,

Will
