Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 940C1C2D0B1
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:52:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 69F74206CC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 11:52:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="R5Xlq0RI"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727630AbgBFLw5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 06:52:57 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:45230 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727111AbgBFLw5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 06:52:57 -0500
Received: by mail-oi1-f195.google.com with SMTP id v19so4255662oic.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 03:52:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=QoBuf+g4Xxni6UvGzXiTkNzIActsAJcHEvJL0GRcYx8=;
        b=R5Xlq0RIQQTLqUa8qKTou4rSksjpBBz9TjP86XXO7E4Tuwiieo96zVVhZlH+93zGUD
         bzlD31tE81BY9v+0GAYnBV5v+V5sXbyvABDV4DA88MsG+3PLxSee4lU73cccmps87FQN
         cCxYxdTQRfEpxBAhyyx8hTq7URx4/raEeFZkM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=QoBuf+g4Xxni6UvGzXiTkNzIActsAJcHEvJL0GRcYx8=;
        b=S7Cu9aU4zjA1CBNfah8uwySKDVvYmtvK2yNMW9yhiQ1XtQbamvsG2b2xerViEmkjEb
         qZ8aY1lO2wBNJKH4oCWBN97b74Nn+jCjgmHAQRnjPxzNTablVAhDFecf8S+JWeyz1/ds
         WNPvezrbrFQ4tm1h4k3S2I9t1inhBMPuSNEnRc12N4HGQgJysmpGOJ0I+6J+qMWAiyH9
         2hulSc50uVy+iQ59A7p5tIBLk2XsowfSVlscUbdQirtY6JGZA9xeX2i43Jh7/58Z5n6s
         IdLzLrtL9jLbg985qT1AFNjcsAbOO/pZsUlFnOSP7cyU23qjxXkoBJQndTRjF+d9ej4G
         NNbw==
X-Gm-Message-State: APjAAAWKfYw+HwNKVOvPwTKEZnV125Jk0Jv0ShEkI6AxTGEBVPSpqOP4
        hFa7DSy4Iy9g+sXL4c1JSiwwAg==
X-Google-Smtp-Source: APXvYqyvEG2esL/xfTcmuUFiEIXQPPyBLna4U/YdvgcHle0HS3e+pc6RLhK/cy8xnBBDz95dp3rg6Q==
X-Received: by 2002:a05:6808:b29:: with SMTP id t9mr6587780oij.69.1580989976311;
        Thu, 06 Feb 2020 03:52:56 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id k192sm821809oib.55.2020.02.06.03.52.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 06 Feb 2020 03:52:55 -0800 (PST)
Date:   Thu, 6 Feb 2020 03:52:54 -0800
From:   Kees Cook <keescook@chromium.org>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Kristen Carlson Accardi <kristen@linux.intel.com>,
        tglx@linutronix.de, mingo@redhat.com, bp@alien8.de, hpa@zytor.com,
        arjan@linux.intel.com, rick.p.edgecombe@intel.com, x86@kernel.org,
        linux-kernel@vger.kernel.org, kernel-hardening@lists.openwall.com
Subject: Re: [RFC PATCH 05/11] x86: Makefile: Add build and config option for
 CONFIG_FG_KASLR
Message-ID: <202002060348.7543F4D5@keescook>
References: <20200205223950.1212394-1-kristen@linux.intel.com>
 <20200205223950.1212394-6-kristen@linux.intel.com>
 <20200206103055.GV14879@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200206103055.GV14879@hirez.programming.kicks-ass.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 06, 2020 at 11:30:55AM +0100, Peter Zijlstra wrote:
> On Wed, Feb 05, 2020 at 02:39:44PM -0800, Kristen Carlson Accardi wrote:
> > Allow user to select CONFIG_FG_KASLR if dependencies are met. Change
> > the make file to build with -ffunction-sections if CONFIG_FG_KASLR
> > 
> > Signed-off-by: Kristen Carlson Accardi <kristen@linux.intel.com>
> > ---
> >  Makefile         |  4 ++++
> >  arch/x86/Kconfig | 13 +++++++++++++
> >  2 files changed, 17 insertions(+)
> > 
> > diff --git a/Makefile b/Makefile
> > index c50ef91f6136..41438a921666 100644
> > --- a/Makefile
> > +++ b/Makefile
> > @@ -846,6 +846,10 @@ ifdef CONFIG_LIVEPATCH
> >  KBUILD_CFLAGS += $(call cc-option, -flive-patching=inline-clone)
> >  endif
> >  
> > +ifdef CONFIG_FG_KASLR
> > +KBUILD_CFLAGS += -ffunction-sections
> > +endif
> [...]
> In particular:
> 
>   "They prevent optimizations by the compiler and assembler using
>   relative locations inside a translation unit since the locations are
>   unknown until link time."

I think this mainly a feature of this flag, since it's those relocations
that are used to do the post-shuffle fixups. But yes, I would imagine
this has some negative impact on code generation.

> I suppose in practise this only means tail-calls are affected and will
> no longer use JMP.d8. Or are more things affected?

It's worth looking at. I'm also curious to see how this will interact
with Link Time Optimization.

-- 
Kees Cook
