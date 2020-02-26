Return-Path: <SRS0=/Zd0=4O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3B0ADC4BA2C
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:57:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 108E924653
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Feb 2020 21:57:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="CVWa98Uw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727746AbgBZV5A (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Feb 2020 16:57:00 -0500
Received: from mail-pf1-f196.google.com ([209.85.210.196]:46360 "EHLO
        mail-pf1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727584AbgBZV5A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Feb 2020 16:57:00 -0500
Received: by mail-pf1-f196.google.com with SMTP id o24so167609pfp.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Feb 2020 13:56:58 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=agTSg4xTvTJ902v/wRSeSnCJDmYFaVhC2jp/Gq4x83M=;
        b=CVWa98Uw4W2DSuAZ6nw8SSnOHBSkNazKVCAoUkannuWdT6ct919lXMS1jGfBN/0TGA
         vi1r29dNanFqfnfQjHgMsWQeCfa8dPlKyRhtjdPBabDi/YdPfx1Nd5hK0amb+n6+XDYz
         3A6pmEuOxzK9cvXLOsHwTn/z5Ld4PVK8tO180=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=agTSg4xTvTJ902v/wRSeSnCJDmYFaVhC2jp/Gq4x83M=;
        b=DPV7d4Fmiusk6kf9icHfHFjlR0KcX15RY2qJFZ46GIWXN4rf/d8/+ZgytCsLLuG6h2
         4GxGOHNpiJ/6gTlmTM5/RplaPivMng7xueoi9bGMZPRrWCa2FjdpW+C/Mg3UZrSjX2ZI
         NS2jmw0GY/cbU6pZmjz+kBC4Hj42ddiJfx8h8AMYYqaZ3vTLqgvtTkp0osrdOrwojV32
         Ygy+eySbqRPO3m23Wn+NntPKIToCWHY8xtq3ORxHYv8dLh6RSiGbZmlmPFSXJNWxf0Hf
         LgKktm19kXk9fCtn2XSeb3EXnb8SWMe+j86EvMb/4GH/8iXWI7Oc5379cNJh/z5WFO6p
         DwVA==
X-Gm-Message-State: APjAAAXV6zAUidSUNVKKRCl6AjKtYcvJ4CK7Dp7nLUf/1gsrFic0rw6k
        0eednmBHbBWjJ3t+wdaAPh5pWg==
X-Google-Smtp-Source: APXvYqyJGeL4QW5uWg6MxaWO+Pm23Yck/xgVU4oSTq3yCWFAC8LuFM9MWFMSX+jv/vuaDnFk8SNXQA==
X-Received: by 2002:aa7:95b0:: with SMTP id a16mr688779pfk.253.1582754217916;
        Wed, 26 Feb 2020 13:56:57 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id j38sm616348pgi.51.2020.02.26.13.56.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 26 Feb 2020 13:56:57 -0800 (PST)
Date:   Wed, 26 Feb 2020 13:56:56 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Daniel Axtens <dja@axtens.net>
Cc:     Daniel Micay <danielmicay@gmail.com>,
        Kernel Hardening <kernel-hardening@lists.openwall.com>,
        Linux-MM <linux-mm@kvack.org>,
        kernel list <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: Re: [PATCH 5/5] [RFC] mm: annotate memory allocation functions with
 their sizes
Message-ID: <202002261356.B632368@keescook>
References: <20200120074344.504-1-dja@axtens.net>
 <20200120074344.504-6-dja@axtens.net>
 <CA+DvKQJ6jRHZeZteqY7q-9sU8v3xacSPj65uac3PQfst4cKiMA@mail.gmail.com>
 <202002251035.AD29F84@keescook>
 <87wo89rieh.fsf@dja-thinkpad.axtens.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wo89rieh.fsf@dja-thinkpad.axtens.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 26, 2020 at 05:07:18PM +1100, Daniel Axtens wrote:
> Kees Cook <keescook@chromium.org> writes:
> 
> > On Fri, Feb 07, 2020 at 03:38:22PM -0500, Daniel Micay wrote:
> >> There are some uses of ksize in the kernel making use of the real
> >> usable size of memory allocations rather than only the requested
> >> amount. It's incorrect when mixed with alloc_size markers, since if a
> >> number like 14 is passed that's used as the upper bound, rather than a
> >> rounded size like 16 returned by ksize. It's unlikely to trigger any
> >> issues with only CONFIG_FORTIFY_SOURCE, but it becomes more likely
> >> with -fsanitize=object-size or other library-based usage of
> >> __builtin_object_size.
> >
> > I think the solution here is to use a macro that does the per-bucket
> > rounding and applies them to the attributes. Keep the bucket size lists
> > in sync will likely need some BUILD_BUG_ON()s or similar.
> 
> I can have a go at this but with various other work projects it has
> unfortunately slipped way down the to-do list. So I've very happy for
> anyone else to take this and run with it.

Sounds good. I've added the above note from Micay to the KSPP bug tracker:
https://github.com/KSPP/linux/issues/5

Thanks for bringing this topic back up!

-- 
Kees Cook
