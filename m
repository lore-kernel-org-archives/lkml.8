Return-Path: <SRS0=TsDl=7R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 001CDC433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 21:52:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D239E206E6
	for <linux-kernel@archiver.kernel.org>; Thu,  4 Jun 2020 21:52:05 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="nvCBfgRF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728415AbgFDVwF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 4 Jun 2020 17:52:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725943AbgFDVwC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Jun 2020 17:52:02 -0400
Received: from mail-pg1-x543.google.com (mail-pg1-x543.google.com [IPv6:2607:f8b0:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D3B4C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  4 Jun 2020 14:52:02 -0700 (PDT)
Received: by mail-pg1-x543.google.com with SMTP id w20so4111121pga.6
        for <linux-kernel@vger.kernel.org>; Thu, 04 Jun 2020 14:52:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AVPTbQ8NFmXxqrUWzxefqxjRddWDIP1x9mYNjqrmPjE=;
        b=nvCBfgRFWPPl3m6Bthhk0OWoXZRMMIM+TK/2J+9C4SQ0piWaVE9ZVnk8WiFbpsbRT/
         /g29RqVU8fUG9ThA2iqChW/8MiSP+ZFwEPslOSU0ICuby2DV5HBeUOs5LDQMbQDatIgj
         6uG1WrRWePfyjCUmkYEfSxiAWCdHEBunPK80I=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AVPTbQ8NFmXxqrUWzxefqxjRddWDIP1x9mYNjqrmPjE=;
        b=dKcnWAvooyinYtP5DFs6vKotcr3CVJYbaZc6zYG5WdIf2C1cIA+UwLuswvJ3seKb5V
         /yQHuo94+KyUyahn1puYikMFyKa9ZrpyqfSLMgLbZlC9YF9FlETKbf6ZIs4ohSLL5YsX
         uL8QqMmxfM0xr5rhY+qMZ/Bk8MJQZjJ0KCT8fTojoOlpBx+Ore/AFDSkQcIG/gw56ID7
         igbIlA7zwKAEM+TMP13uFcuVAq4KJSiz5NrDBIApLBX5qh6fc+p4WvR9x4y/sZQus3Tp
         iOaF/tE556CeZB7O/Y9WKEYJK5r++hePrwCcDVfMQ5KPRMRA/5FRfYeL4gsK3dT5d2C6
         6AFA==
X-Gm-Message-State: AOAM531LWYv+kQSvsab6li0dLOpPtp92y/oDHZf9aLrLls9ZlN6mBMrz
        /fOGSEy0g/GubgDoqGadwQOdaA==
X-Google-Smtp-Source: ABdhPJzl+XR3LgR5r+6XiLd36g6PDrxYDguA3/nHf6QujkMv8ETocNSKltDFZQ8341Fl+XxZA922iw==
X-Received: by 2002:a63:d918:: with SMTP id r24mr6439147pgg.119.1591307522152;
        Thu, 04 Jun 2020 14:52:02 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id z138sm5469147pfc.70.2020.06.04.14.52.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 04 Jun 2020 14:52:01 -0700 (PDT)
Date:   Thu, 4 Jun 2020 14:52:00 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Joe Perches <joe@perches.com>
Cc:     Uwe =?iso-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Michael Ellerman <mpe@ellerman.id.au>,
        Benjamin Herrenschmidt <benh@kernel.crashing.org>,
        Paul Mackerras <paulus@samba.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>
Subject: Re: [PATCH] pwm: Add missing "CONFIG_" prefix
Message-ID: <202006041451.19491ECA@keescook>
References: <202006031539.4198EA6@keescook>
 <b08611018fdb6d88757c6008a5c02fa0e07b32fb.camel@perches.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <b08611018fdb6d88757c6008a5c02fa0e07b32fb.camel@perches.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 03, 2020 at 04:04:31PM -0700, Joe Perches wrote:
> On Wed, 2020-06-03 at 15:40 -0700, Kees Cook wrote:
> > The IS_ENABLED() use was missing the CONFIG_ prefix which would have
> > lead to skipping this code.
> > 
> > Fixes: 3ad1f3a33286 ("pwm: Implement some checks for lowlevel drivers")
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> > ---
> >  drivers/pwm/core.c | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> > 
> > diff --git a/drivers/pwm/core.c b/drivers/pwm/core.c
> > index 9973c442b455..6b3cbc0490c6 100644
> > --- a/drivers/pwm/core.c
> > +++ b/drivers/pwm/core.c
> > @@ -121,7 +121,7 @@ static int pwm_device_request(struct pwm_device *pwm, const char *label)
> >  		pwm->chip->ops->get_state(pwm->chip, pwm, &pwm->state);
> >  		trace_pwm_get(pwm, &pwm->state);
> >  
> > -		if (IS_ENABLED(PWM_DEBUG))
> > +		if (IS_ENABLED(CONFIG_PWM_DEBUG))
> >  			pwm->last = pwm->state;
> >  	}
> >  
> > -- 
> > 2.25.1
> > 
> 
> more odd uses (mostly in comments)
> 
> $ git grep -P -oh '\bIS_ENABLED\s*\(\s*\w+\s*\)'| \
>   sed -r 's/\s+//g'| \
>   grep -v '(CONFIG_' | \
>   sort | uniq -c | sort -rn
>       7 IS_ENABLED(DEBUG)
>       4 IS_ENABLED(DRM_I915_SELFTEST)
>       4 IS_ENABLED(cfg)
>       2 IS_ENABLED(opt_name)
>       2 IS_ENABLED(DEBUG_PRINT_TRIE_GRAPHVIZ)
>       2 IS_ENABLED(config)
>       2 IS_ENABLED(cond)
>       2 IS_ENABLED(__BIG_ENDIAN)
>       1 IS_ENABLED(x)
>       1 IS_ENABLED(STRICT_KERNEL_RWX)
>       1 IS_ENABLED(PWM_DEBUG)
>       1 IS_ENABLED(option)
>       1 IS_ENABLED(ETHTOOL_NETLINK)
>       1 IS_ENABLED(DEBUG_RANDOM_TRIE)
>       1 IS_ENABLED(DEBUG_CHACHA20POLY1305_SLOW_CHUNK_TEST)
> 
> STRICT_KERNEL_RWX is misused here in ppc
> 
> ---
> 
> Fix pr_warn without newline too.
> 
>  arch/powerpc/mm/book3s64/hash_utils.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
> 
> diff --git a/arch/powerpc/mm/book3s64/hash_utils.c b/arch/powerpc/mm/book3s64/hash_utils.c
> index 51e3c15f7aff..dd60c5f2b991 100644
> --- a/arch/powerpc/mm/book3s64/hash_utils.c
> +++ b/arch/powerpc/mm/book3s64/hash_utils.c
> @@ -660,11 +660,10 @@ static void __init htab_init_page_sizes(void)
>  		 * Pick a size for the linear mapping. Currently, we only
>  		 * support 16M, 1M and 4K which is the default
>  		 */
> -		if (IS_ENABLED(STRICT_KERNEL_RWX) &&
> +		if (IS_ENABLED(CONFIG_STRICT_KERNEL_RWX) &&
>  		    (unsigned long)_stext % 0x1000000) {
>  			if (mmu_psize_defs[MMU_PAGE_16M].shift)
> -				pr_warn("Kernel not 16M aligned, "
> -					"disabling 16M linear map alignment");
> +				pr_warn("Kernel not 16M aligned, disabling 16M linear map alignment\n");
>  			aligned = false;
>  		}

Joe, I was going to send all of the fixes for these issues, but your
patch doesn't have a SoB. Shall I add one for the above patch?

-- 
Kees Cook
