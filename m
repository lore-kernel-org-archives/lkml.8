Return-Path: <SRS0=vr6t=BV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E9E56C433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:24:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A29E6206C3
	for <linux-kernel@archiver.kernel.org>; Tue, 11 Aug 2020 21:24:16 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="O5TFLtXz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726609AbgHKVYP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Aug 2020 17:24:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726506AbgHKVYL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Aug 2020 17:24:11 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39013C061787
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:24:11 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id k18so8298649pfp.7
        for <linux-kernel@vger.kernel.org>; Tue, 11 Aug 2020 14:24:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=kqht+PsiNX+zyGZeHAYGB2UWY8/X41SdJyxsW0UZbF0=;
        b=O5TFLtXzqubWc2LMU0S988p9kCFx/y51UcYFHXw4QNWqNoSDkB96fDgVvsky9VDFt9
         HpRhz6VKXflyL3vQfrm3G9KOTRII5LLyQOkmzG0rd5y4GlqiciOK60zTkHtZFY/IB7qU
         rnCfEI6DP1uHluLA1uJdEpQ+8q7De5J69v9aM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=kqht+PsiNX+zyGZeHAYGB2UWY8/X41SdJyxsW0UZbF0=;
        b=j5ZGDcPT1czc/LWpboWKrRIKHQFjT2b/MN5wjrHCBYr1otzJs+Jt1aDjCekwzIszeT
         1CIqU06D2Mt6sV29m2zGuY2BeWTM6POcFb+IQsKy1z0AurWBfc+PEIjud+C4fe7eouEy
         SVm0u2fGMrcRi2lPGAYQMCKGResImL/sud7zEj4UDAlqfNTVLJlMfVP0eQnivTd360WW
         cj3K8CsT6OSe7114Aj3ekDp0dPGvYRGgzcZKOBcOS8XcXEUHuEvC6bO+Vb04myaVBvfN
         +AXhubs3cx08RSL6B4WUqLIme5Kh08rlsTxEMUz5dahI+mr38WEczuzhgTofmn5j5haI
         Z6EA==
X-Gm-Message-State: AOAM5339po53/IhOBvVsYDmwHcjIrGYMzA5vGbNM9bzUzKpZb7oJHxLO
        F5m9iyqow4j27CCCBHsl+IuNRA==
X-Google-Smtp-Source: ABdhPJw7BoxFC+re3YdTRwhz6gvNUVGhppfCdRLT2HtMXSKsXslu+2fFJxkA4hJ0XOYJE9cVukTJjA==
X-Received: by 2002:a62:520b:: with SMTP id g11mr8269993pfb.168.1597181050681;
        Tue, 11 Aug 2020 14:24:10 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y7sm3818672pjm.3.2020.08.11.14.24.09
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 11 Aug 2020 14:24:09 -0700 (PDT)
Date:   Tue, 11 Aug 2020 14:24:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org, linux-doc@vger.kernel.org
Subject: Re: [PATCH] mailmap: Update comments for with format and more detalis
Message-ID: <202008111423.DC2F758@keescook>
References: <202008080013.58EBD83@keescook>
 <20200811104614.07754282@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200811104614.07754282@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 11, 2020 at 10:46:14AM -0600, Jonathan Corbet wrote:
> On Sat, 8 Aug 2020 00:14:36 -0700
> Kees Cook <keescook@chromium.org> wrote:
> 
> > Without having first read the git-shortlog man-page first, the format
> > of .mailmap may not be immediately obvious. Add comments with pointers
> > to the man-page, along with other details.
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Applied, thanks.  I did take the liberty of removing the redundant "first"
> from the changelog, though :)

It seems I can only edit other people's writing. ;)

Thank you!

-- 
Kees Cook
