Return-Path: <SRS0=e3tL=6T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 455FAC47247
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:22:21 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 21429206FA
	for <linux-kernel@archiver.kernel.org>; Tue,  5 May 2020 14:22:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="WramJSl4"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730350AbgEEOWT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 5 May 2020 10:22:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1729273AbgEEOWQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 May 2020 10:22:16 -0400
Received: from mail-wm1-x343.google.com (mail-wm1-x343.google.com [IPv6:2a00:1450:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ECEF4C061A0F
        for <linux-kernel@vger.kernel.org>; Tue,  5 May 2020 07:22:15 -0700 (PDT)
Received: by mail-wm1-x343.google.com with SMTP id v4so2614994wme.1
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 07:22:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=YHnzzrHgTyHcjX/CeefsmIEudaBUoBiusDg0FK4q7VY=;
        b=WramJSl4+uskKedIHN68dPfXwQ/JWF+7d43lGgSUtg9uMCjB27RieYVrxRNCiESioY
         qQAjepPNqXaKLzvAd80rsaqCFeopkR4uGXt7IqAdCYXXu9pgquU5zI/UiGrDkc+yeh/T
         1CIy4eJHsTlDiebyEJu6B7BpqUnS6SjguezbmKJ2iuKyjeroDCACh63Avjg6X/WKNq8y
         VvJo8RcMTZPoZKGb1azBhV5ipKE7OtRG5tE93+24jqZG1M+GMUHOmPzJD/8cCntKFYMv
         27h5azse6AypM9z9xYtJOUU9+W2RBvRcU/L3QRlt/mZnHnaqiWCBInSRYqf61knVPmLc
         ApVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=YHnzzrHgTyHcjX/CeefsmIEudaBUoBiusDg0FK4q7VY=;
        b=BsErOsJnCFD/Cbv66rC1/fIJzPvkHZD6uGfyRWKSdbdxkO1WNkDhpt/vOwD0BERbIf
         uQEECAjQcLu3clY5mcSpTYyvn9LNZeszQrFXv1+8NDlmKX5/lN459BSvIJxF9zVXn8U0
         8SsBngfKIj8MkVapBg029FTb3W6zWVigNtfYpb5Rr+hPFE3wxwFzjyAFwN8vD0EMyQjV
         HThn8AJpG9jAkliTUtBvtlm9r02g2cWk7Zayn59CNTbO/mQXgTKf7+sTTiXc35R+rPGn
         SIdg0AUjuRoL6wz/4TlDNyr3nNgk3DSHAsQfxYRuzYPvR9lqdMVdVqYT0lyTvTKnYEUE
         LJMQ==
X-Gm-Message-State: AGi0PuZ3slKUZ4EQi45rDFrYpqhweuS29CcJ0Nq+S8AluLpZyEqeIsna
        nseebHVhPdrnkXTMdUqSJJTCgLOPm3arng==
X-Google-Smtp-Source: APiQypIYYxJUTLtY0WESmB6qxDcBGH0IJp2gBONDCsRvlDuzCDaiTDtCUBp5/jTtlYEeVlexqtQGJw==
X-Received: by 2002:a7b:c250:: with SMTP id b16mr3771611wmj.100.1588688132584;
        Tue, 05 May 2020 07:15:32 -0700 (PDT)
Received: from holly.lan (cpc141214-aztw34-2-0-cust773.18-1.cable.virginm.net. [86.9.19.6])
        by smtp.gmail.com with ESMTPSA id s6sm4023786wmh.17.2020.05.05.07.15.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 May 2020 07:15:31 -0700 (PDT)
Date:   Tue, 5 May 2020 15:15:29 +0100
From:   Daniel Thompson <daniel.thompson@linaro.org>
To:     Will Deacon <will@kernel.org>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Douglas Anderson <dianders@chromium.org>,
        Jason Wessel <jason.wessel@windriver.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        patches@linaro.org
Subject: Re: [PATCH v2] arm64: cacheflush: Fix KGDB trap detection
Message-ID: <20200505141529.2qb35fbqudtac3ys@holly.lan>
References: <20200504170518.2959478-1-daniel.thompson@linaro.org>
 <20200504204803.GA5657@willie-the-truck>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200504204803.GA5657@willie-the-truck>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 04, 2020 at 09:48:04PM +0100, Will Deacon wrote:
> On Mon, May 04, 2020 at 06:05:18PM +0100, Daniel Thompson wrote:
> > flush_icache_range() contains a bodge to avoid issuing IPIs when the kgdb
> > trap handler is running because issuing IPIs is unsafe (and not needed)
> > in this execution context. However the current test, based on
> > kgdb_connected is flawed: it both over-matches and under-matches.
> > 
> > The over match occurs because kgdb_connected is set when gdb attaches
> > to the stub and remains set during normal running. This is relatively
> > harmelss because in almost all cases irq_disabled() will be false.
> > 
> > The under match is more serious. When kdb is used instead of kgdb to access
> > the debugger then kgdb_connected is not set in all the places that the
> > debug core updates sw breakpoints (and hence flushes the icache). This
> > can lead to deadlock.
> > 
> > Fix by replacing the ad-hoc check with the proper kgdb macro. This also
> > allows us to drop the #ifdef wrapper.
> > 
> > Fixes: 3b8c9f1cdfc5 ("arm64: IPI each CPU after invalidating the I-cache for kernel mappings")
> > Signed-off-by: Daniel Thompson <daniel.thompson@linaro.org>
> > Reviewed-by: Douglas Anderson <dianders@chromium.org>
> > ---
> > 
> > Notes:
> >     v2: Improve the commit message based based on feedback from Doug
> >         Anderson
> > 
> >  arch/arm64/include/asm/cacheflush.h | 6 +++---
> >  1 file changed, 3 insertions(+), 3 deletions(-)
> > 
> > diff --git a/arch/arm64/include/asm/cacheflush.h b/arch/arm64/include/asm/cacheflush.h
> > index e6cca3d4acf7..ce50c1f1f1ea 100644
> > --- a/arch/arm64/include/asm/cacheflush.h
> > +++ b/arch/arm64/include/asm/cacheflush.h
> > @@ -79,7 +79,7 @@ static inline void flush_icache_range(unsigned long start, unsigned long end)
> >  	 * IPI all online CPUs so that they undergo a context synchronization
> >  	 * event and are forced to refetch the new instructions.
> >  	 */
> > -#ifdef CONFIG_KGDB
> > +
> >  	/*
> >  	 * KGDB performs cache maintenance with interrupts disabled, so we
> >  	 * will deadlock trying to IPI the secondary CPUs. In theory, we can
> > @@ -89,9 +89,9 @@ static inline void flush_icache_range(unsigned long start, unsigned long end)
> >  	 * the patching operation, so we don't need extra IPIs here anyway.
> >  	 * In which case, add a KGDB-specific bodge and return early.
> >  	 */
> > -	if (kgdb_connected && irqs_disabled())
> > +	if (in_dbg_master())
> 
> Does this imply that irqs are disabled?

Yes.

Assuming CONFIG_KGDB is enabled then in_dbg_master() expands to:

    (raw_smp_processor_id() == atomic_read(&kgdb_active))

kgdb_active is written to from exactly four locations in the kernel and
all are within a single function, albeit a very big function with control
flow the that could politely be called "quirky". I try not to think about
what it might be impolitely called.

kgdb_active is only ever set to a value other than -1 when we are
executing the kgdb exception handler and interrupts have been
explicitly disabled.


Daniel.
