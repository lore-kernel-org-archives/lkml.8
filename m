Return-Path: <SRS0=pusq=BO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BD55C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 18:52:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 560FE20792
	for <linux-kernel@archiver.kernel.org>; Tue,  4 Aug 2020 18:52:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=ffwll.ch header.i=@ffwll.ch header.b="OkEy528n"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728252AbgHDSwK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 4 Aug 2020 14:52:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726883AbgHDSwJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Aug 2020 14:52:09 -0400
Received: from mail-wm1-x341.google.com (mail-wm1-x341.google.com [IPv6:2a00:1450:4864:20::341])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F162AC06174A
        for <linux-kernel@vger.kernel.org>; Tue,  4 Aug 2020 11:52:08 -0700 (PDT)
Received: by mail-wm1-x341.google.com with SMTP id c19so2777719wmd.1
        for <linux-kernel@vger.kernel.org>; Tue, 04 Aug 2020 11:52:08 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ffwll.ch; s=google;
        h=date:from:to:cc:subject:message-id:mail-followup-to:references
         :mime-version:content-disposition:in-reply-to;
        bh=MCVmVRayFgOyaW9uuCCMHJef4rtIhxIeTcJ1ltWDm/A=;
        b=OkEy528nzR32O6we06l7wDwUKcc5IZrp1dQiVRT5RGX8EW2P73GifpBRvHpw7mL1m1
         YlRJV3nBmEJn+mqIOYS4yt0TTlbLlgU/D/VBkJ5goc0Jyb47Vlu5OhIRxA1rKPMnyv0S
         dCClQwuB6Bc7p7fYiuMhYmWWBpZ0IWmnBvYrg=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id
         :mail-followup-to:references:mime-version:content-disposition
         :in-reply-to;
        bh=MCVmVRayFgOyaW9uuCCMHJef4rtIhxIeTcJ1ltWDm/A=;
        b=Z6RdhqMbQthLa6srSyEeI2xsjTnpDpiJ9TJCLbCXHe5CVQ2ewtUO5VIlGsPdaErr3K
         rF6qns00U+3ZrFCFMRFOATcGgSeOq7TmJrpsRDFEfeM1WEYiJKXuvur9VK+Et5PEUQ1F
         pohKvep3JalIEkxSCc68OU5CO+2M172sJU3h2YLGzpUbMZRJIu3tT1sFUo7xdHfjH7Dz
         fMVdjK7K4Sl2s5v9L8R0JEROhiRqt073IcermPUm+3EzeUFYjnEoyjNOXIWCR4BsZDIE
         1fZ3T3z8LiSiRJst9/+xXbIR+EKnmeDC7QnOFikkX0RrFrNQoPYe92ahYCFdfMpEjO2w
         aQjw==
X-Gm-Message-State: AOAM531oMyPhc4WGL4Bdm8tJjYH6ZSi92vo2FWp9fD0FghduNtEMNy8Q
        fKdqyo2kyA+OVlz8heVQdRJIIg==
X-Google-Smtp-Source: ABdhPJy3Xn6Jn/uDSiI+K7xVLnN2zx5fRbdJC5qoyUtSF0wZycX2SF7js/q8hiQY608lCKDsDYlYYA==
X-Received: by 2002:a05:600c:2157:: with SMTP id v23mr5047228wml.38.1596567127744;
        Tue, 04 Aug 2020 11:52:07 -0700 (PDT)
Received: from phenom.ffwll.local ([2a02:168:57f4:0:efd0:b9e5:5ae6:c2fa])
        by smtp.gmail.com with ESMTPSA id a10sm31360640wro.35.2020.08.04.11.52.06
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 04 Aug 2020 11:52:07 -0700 (PDT)
Date:   Tue, 4 Aug 2020 20:52:05 +0200
From:   daniel@ffwll.ch
To:     DRI Development <dri-devel@lists.freedesktop.org>
Cc:     Jessica Yu <jeyu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
Subject: Re: [PATCH 8/8] modules: inherit TAINT_PROPRIETARY_MODULE
Message-ID: <20200804185205.GR6419@phenom.ffwll.local>
Mail-Followup-To: DRI Development <dri-devel@lists.freedesktop.org>,
        Jessica Yu <jeyu@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        linux-kernel@vger.kernel.org (open list)
References: <20200730061027.29472-1-hch@lst.de>
 <20200730061027.29472-9-hch@lst.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200730061027.29472-9-hch@lst.de>
X-Operating-System: Linux phenom 5.7.0-1-amd64 
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 30, 2020 at 08:10:27AM +0200, Christoph Hellwig wrote:
> If a TAINT_PROPRIETARY_MODULE exports symbol, inherit the taint flag
> for all modules importing these symbols, and don't allow loading
> symbols from TAINT_PROPRIETARY_MODULE modules if the module previously
> imported gplonly symbols.  Add a anti-circumvention devices so people
> don't accidentally get themselves into trouble this way.
> 
> Comment from Greg:
>  Ah, the proven-to-be-illegal "GPL Condom" defense :)
> 
> Signed-off-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>

If this helps to get the next gpu related entertainment at least cc'ed to
dri-devel, maybe even using an upstream driver, I'm all for it.

Acked-by: Daniel Vetter <daniel.vetter@ffwll.ch>

> ---
>  include/linux/module.h |  1 +
>  kernel/module.c        | 12 ++++++++++++
>  2 files changed, 13 insertions(+)
> 
> diff --git a/include/linux/module.h b/include/linux/module.h
> index 30b0f5fcdb3c37..e30ed5fa33a738 100644
> --- a/include/linux/module.h
> +++ b/include/linux/module.h
> @@ -389,6 +389,7 @@ struct module {
>  	unsigned int num_gpl_syms;
>  	const struct kernel_symbol *gpl_syms;
>  	const s32 *gpl_crcs;
> +	bool using_gplonly_symbols;
>  
>  #ifdef CONFIG_UNUSED_SYMBOLS
>  	/* unused exported symbols. */
> diff --git a/kernel/module.c b/kernel/module.c
> index afb2bfdd5134b3..04f993863ae417 100644
> --- a/kernel/module.c
> +++ b/kernel/module.c
> @@ -1456,6 +1456,18 @@ static const struct kernel_symbol *resolve_symbol(struct module *mod,
>  	if (!sym)
>  		goto unlock;
>  
> +	if (license == GPL_ONLY)
> +		mod->using_gplonly_symbols = true;
> +
> +	if (owner && test_bit(TAINT_PROPRIETARY_MODULE, &owner->taints)) {
> +		if (mod->using_gplonly_symbols) {
> +			sym = NULL;
> +			goto getname;
> +		}
> +		add_taint_module(mod, TAINT_PROPRIETARY_MODULE,
> +				 LOCKDEP_NOW_UNRELIABLE);
> +	}
> +
>  	if (!check_version(info, name, mod, crc)) {
>  		sym = ERR_PTR(-EINVAL);
>  		goto getname;
> -- 
> 2.27.0
> 

-- 
Daniel Vetter
Software Engineer, Intel Corporation
http://blog.ffwll.ch
