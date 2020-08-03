Return-Path: <SRS0=5bHT=BN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DCF7AC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:41:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E6824207FC
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Aug 2020 21:41:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="cP3b+JMQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728829AbgHCVlK (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Aug 2020 17:41:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728815AbgHCVlK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Aug 2020 17:41:10 -0400
Received: from mail-pl1-x644.google.com (mail-pl1-x644.google.com [IPv6:2607:f8b0:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 177E6C061756
        for <linux-kernel@vger.kernel.org>; Mon,  3 Aug 2020 14:41:10 -0700 (PDT)
Received: by mail-pl1-x644.google.com with SMTP id o1so21704716plk.1
        for <linux-kernel@vger.kernel.org>; Mon, 03 Aug 2020 14:41:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=AoXxxzPdcjWwfJPdErgifOsTsvhhfF5cKu6R8ZrrXiE=;
        b=cP3b+JMQBwVvMgicWaLrhYHCtWd5xoSj8dj2pYNIWtzEsYYJHvm6UFtv4fCjHWdqV/
         80FE7JTPA3xE9NC1kzqojZBRfaL8sYYxgslYAa7F69WcFl+x2nosPcFZb2Ok+yHsL99p
         qpAG8+RGZRwE8k74YOkvNHoo5nYxA1SiGOgV8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=AoXxxzPdcjWwfJPdErgifOsTsvhhfF5cKu6R8ZrrXiE=;
        b=r1ZCyz7T24gPn5001vo87xKzrdU+GHKu+x4eyHoIpzZxKh+OAz9bdt6Uh0LsMTQWc8
         SUFskD4h9pz/y2krJkih93pX4sGoTJMYdzOiVjTEE9kN+ap3uW1/ozXpUkqo8B8Wh05e
         +7brcSutvbH3iJX2mk1Z68044Aq5CqJM0uE92kK3ReD1Xg0QDoJ1SOYeKmbPn0NPr33o
         jYlJgHfroNaVLebvZD3KWlWhVb5JzrO/2zzVKYQAj+cheAK9/kn5tmtpnIzoNS6kH0G/
         LVHo+alaoiv050yUVsCqfJjJCHUW0JzJJcdnic3b6UGDzxoQ8Rk6F3BytVH8bzAPwqyk
         rr1w==
X-Gm-Message-State: AOAM533QTrdu9r86R7pEzNDcCvDipuEwPpfk7LiQdLfyi+2Lr4JIHjOj
        8T4JEviv5BaoXZCK+lc4/J8KpQ==
X-Google-Smtp-Source: ABdhPJzKfOSTGggKfBY9ChUZm4EGBh+2aAyWRhVuvypuYHUArV91N1Rdgtgk5e2SPvx0o4R9ZogITA==
X-Received: by 2002:a17:90a:6d96:: with SMTP id a22mr1158690pjk.26.1596490869599;
        Mon, 03 Aug 2020 14:41:09 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y65sm20383337pfb.155.2020.08.03.14.41.08
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Aug 2020 14:41:08 -0700 (PDT)
Date:   Mon, 3 Aug 2020 14:41:07 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Frank Ch. Eigler" <fche@redhat.com>
Cc:     Joe Lawrence <joe.lawrence@redhat.com>,
        Evgenii Shatokhin <eshatokhin@virtuozzo.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        Miroslav Benes <mbenes@suse.cz>, tglx@linutronix.de,
        mingo@redhat.com, bp@alien8.de, arjan@linux.intel.com,
        x86@kernel.org, linux-kernel@vger.kernel.org,
        kernel-hardening@lists.openwall.com, rick.p.edgecombe@intel.com,
        live-patching@vger.kernel.org,
        Josh Poimboeuf <jpoimboe@redhat.com>,
        Jessica Yu <jeyu@kernel.org>
Subject: Re: [PATCH v4 00/10] Function Granular KASLR
Message-ID: <202008031439.F1399A588@keescook>
References: <20200717170008.5949-1-kristen@linux.intel.com>
 <alpine.LSU.2.21.2007221122110.10163@pobox.suse.cz>
 <e9c4d88b-86db-47e9-4299-3fac45a7e3fd@virtuozzo.com>
 <202008031043.FE182E9@keescook>
 <fc6d2289-af97-5cf8-a4bb-77c2b0b8375c@redhat.com>
 <20200803193837.GB30810@redhat.com>
 <202008031310.4F8DAA20@keescook>
 <20200803211228.GC30810@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200803211228.GC30810@redhat.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 03, 2020 at 05:12:28PM -0400, Frank Ch. Eigler wrote:
> Hi -
> 
> On Mon, Aug 03, 2020 at 01:11:27PM -0700, Kees Cook wrote:
> > [...]
> > > Systemtap needs to know base addresses of loaded text & data sections,
> > > in order to perform relocation of probe point PCs and context data
> > > addresses.  It uses /sys/module/...., kind of under protest, because
> > > there seems to exist no MODULE_EXPORT'd API to get at that information
> > > some other way.
> > 
> > Wouldn't /proc/kallsysms entries cover this? I must be missing
> > something...
> 
> We have relocated based on sections, not some subset of function
> symbols accessible that way, partly because DWARF line- and DIE- based
> probes can map to addresses some way away from function symbols, into
> function interiors, or cloned/moved bits of optimized code.  It would
> take some work to prove that function-symbol based heuristic
> arithmetic would have just as much reach.

Interesting. Do you have an example handy? It seems like something like
that would reference the enclosing section, which means we can't just
leave them out of the sysfs list... (but if such things never happen in
the function-sections, then we *can* remove them...)

-- 
Kees Cook
