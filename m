Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EAE9CC28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:06:15 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5CC02076D
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 15:06:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="npqa6IgL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729374AbgEFPGO (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 11:06:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729048AbgEFPGO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 11:06:14 -0400
Received: from mail-wr1-x443.google.com (mail-wr1-x443.google.com [IPv6:2a00:1450:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B1118C061A0F
        for <linux-kernel@vger.kernel.org>; Wed,  6 May 2020 08:06:13 -0700 (PDT)
Received: by mail-wr1-x443.google.com with SMTP id x17so2615430wrt.5
        for <linux-kernel@vger.kernel.org>; Wed, 06 May 2020 08:06:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=XkU2IfxEMFIBK8H+k9ssjVS2oIzqzYZTgrhsr6AigAM=;
        b=npqa6IgLiZJF6NVdHMawWGS9zek/ZPPNICAvxHyZcerAg3LlKC3hp7NMVz4DdDPrmj
         TgU2PQvtrtLz6M4/UJ53N5ClhyptBhtKVUEbWQtugGXrz0N8ZXiDpQzCQlQPQpAMEZFa
         Po46nJE+RclPLc6A5M0b+q04reLnoXvFxZmJrfpGi+oSxBrSh1UrBza+ZB1MMWfGE45e
         1SizfD5twDyO6jVjIDEaXfPPArRul2pqGMmuZirCcO7Lzz6IdV13LCJOVPJJpCbdmS9T
         pS+4o90sWVv+3W+cn113tu1BAk+vlThVcB1XqCjY1ri89el1HO9etl6PYmzfWAg544Jd
         rfJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XkU2IfxEMFIBK8H+k9ssjVS2oIzqzYZTgrhsr6AigAM=;
        b=S9+wegk5Tv4+mFbKGA+SZ5b6z1EIej07aXR9yzkTaC3sEhrWB0WBcslwPe8Qn8vDcB
         kV0Tgza+c3kq8kMrlRFKyyHRgSRXjqj7S0EqHgi9XFKxIwVkL95GG0ydyYtlr4FmwJo5
         EC1vMJpdbhQH2pVLz/V+0BbM7zhYPBFfjfr3UyrczQk4bAhWod0Rhz+weWc2rahSucfw
         CTXBXRFzVXUahIBW9xMFTiyA7ykBcv2zfdKAotf146Q1auyFpUEB9eU4/ZrNHP3QiMqh
         Gs3+mH/pLEqGmCFSByFE2aGXdBvodlL/Ltq1lSlCwikDyUkzzhpFGix6zyGJFJuwgI6G
         sgkA==
X-Gm-Message-State: AGi0PubIWnGEPNlb2eo35t3b21BQ8YWMbMY/VqrpNfh+ZIlShPmoxiuJ
        uMuaSirGt13vAix/XzJtCt9FfQ==
X-Google-Smtp-Source: APiQypJsiRqkKLp7nVfuEm6QRdUvRTQVYCCMh+alAFwNSHkEzDiZiewVAFCAZezDpAesFLQQwnHImQ==
X-Received: by 2002:adf:f4d1:: with SMTP id h17mr9632031wrp.69.1588777572367;
        Wed, 06 May 2020 08:06:12 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id c190sm3591094wme.10.2020.05.06.08.06.11
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 May 2020 08:06:11 -0700 (PDT)
Date:   Wed, 6 May 2020 16:06:09 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: Re: [PATCH v2] arm64: cacheflush: Fix KGDB trap detection
Message-ID: <20200506150609.kya3nygfvdwvimad@holly.lan>
References: <20200504170518.2959478-1-daniel.thompson@linaro.org>
 <20200504204803.GA5657@willie-the-truck>
 <20200505141529.2qb35fbqudtac3ys@holly.lan>
 <20200505150916.GC24239@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200505150916.GC24239@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 05, 2020 at 04:09:16PM +0100, Will Deacon wrote:
> On Tue, May 05, 2020 at 03:15:29PM +0100, Daniel Thompson wrote:
> > On Mon, May 04, 2020 at 09:48:04PM +0100, Will Deacon wrote:
> > > On Mon, May 04, 2020 at 06:05:18PM +0100, Daniel Thompson wrote:
> > > > diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
> > > > index e6cca3d4acf7..ce50c1f1f1ea 100644
> > > > --- a/arch/arm64/include/asm/cacheflush.h
> > > > +++ b/arch/arm64/include/asm/cacheflush.h
> > > > @@ -79,7 +79,7 @@ static inline void flush_icache_range(unsigned long start, unsigned long end)
> > > >  	 * IPI all online CPUs so that they undergo a context synchronization
> > > >  	 * event and are forced to refetch the new instructions.
> > > >  	 */
> > > > -#ifdef CONFIG_KGDB
> > > > +
> > > >  	/*
> > > >  	 * KGDB performs cache maintenance with interrupts disabled, so we
> > > >  	 * will deadlock trying to IPI the secondary CPUs. In theory, we can
> > > > @@ -89,9 +89,9 @@ static inline void flush_icache_range(unsigned long start, unsigned long end)
> > > >  	 * the patching operation, so we don't need extra IPIs here anyway.
> > > >  	 * In which case, add a KGDB-specific bodge and return early.
> > > >  	 */
> > > > -	if (kgdb_connected && irqs_disabled())
> > > > +	if (in_dbg_master())
> > > 
> > > Does this imply that irqs are disabled?
> > 
> > Yes.

Except for bugs...


> > 
> > Assuming CONFIG_KGDB is enabled then in_dbg_master() expands to:
> > 
> >     (raw_smp_processor_id() == atomic_read(&kgdb_active))
> 
> Aha, so this can drop the raw_ prefix and call smp_processor_id() instead?

We need to allow in_dbg_master() to be called from preemptible contexts
(because its job it to disclose information about our executions
context) but given irqs are always disabled when we in_dbg_master()
then I think we can make this and rely on short-circuit eval to
avoid PREEMPT_DEBUG errors:

    (irqs_disabled() && (smp_processor_id() == atomic_read(&kgdb_active)))


> I can queue the arm64 patch regardless.

I don't want to hide anything... when I looked closer I realized
that the above change also eliminates a small window where the original
macro can spuriously evaluate to true.

Specifically if we migrate to a new core after reading the processor
id and the previous core takes a breakpoint then we would evaluate
true if we read kgdb_active before we get the IPI to bring us to halt.

Sorry for overlooking this in my reply yesterday! I'll have a patch out
for this shortly.


Daniel.
