Return-Path: <SRS0=3e5Q=77=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 98728C433E0
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:52:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6625620786
	for <linux-kernel@archiver.kernel.org>; Thu, 18 Jun 2020 19:52:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="X8DNTsRL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729965AbgFRTwz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 18 Jun 2020 15:52:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727024AbgFRTwy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Jun 2020 15:52:54 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0E36FC06174E
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 12:52:54 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y17so2885244plb.8
        for <linux-kernel@vger.kernel.org>; Thu, 18 Jun 2020 12:52:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=wsf73Z126ojkOygBCc4JE/v/5dFQpgMKkylOyorJWhk=;
        b=X8DNTsRLlcjwcpnPXZ02CYGLyhuDa/Coid1MS0YeJwE+St1uYtDvyvpIQ4/eg2qvSq
         UVcCngx+X5B3YckTemLUfFSMNMXMHxHgSET2XcP3pa7R8iSLRGY7O8KhHyPVLQ35LzCy
         k2F7pI7wVFoOJO8abEXZyKjMSv6vhtyajlG/Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=wsf73Z126ojkOygBCc4JE/v/5dFQpgMKkylOyorJWhk=;
        b=lAYGN1ws2lHK8wqJqd7bZafUx5AEmJ2kgygaKVJTPRpvdZOn3To9cIVDFHjnBYpK8d
         n/1Umm7fnneM9sxUWlBQdHJ9/gEXnf043dI8Qr1ed58ThDPapITxy0yp6XrrMCzx9oAH
         FyL53ScykhsCe8ViqmI4CG7AjtWZSYvuTcSVqsd7QwSW9d9icY/XXw9QZIjhfFoeg5Xb
         x+P9HBGrMPO9cYG8xkObGEZGj33sNVHZE+OwcHPH0irZK2p2bc7T+CG5GCUJZceQ1Bar
         YscmrB1f8RHuNDfGMjjP1HpKDt/u1fRHZQ81RDUZJ/unoNU5/DRSaBblRGH93uZ7lkQO
         gORQ==
X-Gm-Message-State: AOAM532flCNojLiQG9ThyBlo9SJmDYV8EjmLi2TX/dd0Ftee9JNZy6yd
        JkjFr7c40fWWwK1Y4NRGlVPwrLTCxl4=
X-Google-Smtp-Source: ABdhPJwchlPIfFZyBKCfWdWEuuZp6G9OPnXNNpMt6mchv2BAzKIeqvUM/wOIuYeL6wGs5Dio7uSDtw==
X-Received: by 2002:a17:90a:1b23:: with SMTP id q32mr7712pjq.14.1592509972918;
        Thu, 18 Jun 2020 12:52:52 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id p5sm3839923pfg.162.2020.06.18.12.52.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 18 Jun 2020 12:52:51 -0700 (PDT)
Date:   Thu, 18 Jun 2020 12:52:50 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Julia Lawall <julia.lawall@inria.fr>
Cc:     Julia Lawall <Julia.Lawall@lip6.fr>, cocci@systeme.lip6.fr,
        linux-kernel@vger.kernel.org
Subject: Re: [Cocci] [PATCH] coccinelle: misc: add array_size_dup script to
 detect missed overlow checks
Message-ID: <202006181249.8B826D9@keescook>
References: <20200615102045.4558-1-efremov@linux.com>
 <202006171103.327F86B1C@keescook>
 <alpine.DEB.2.22.394.2006172051280.3083@hadrien>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <alpine.DEB.2.22.394.2006172051280.3083@hadrien>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 17, 2020 at 08:54:03PM +0200, Julia Lawall wrote:
> 
> 
> On Wed, 17 Jun 2020, Kees Cook wrote:
> 
> > On Mon, Jun 15, 2020 at 01:20:45PM +0300, Denis Efremov wrote:
> > > +@as@
> > > +expression E1, E2;
> > > +@@
> > > +
> > > +array_size(E1, E2)
> >
> > BTW, is there a way yet in Coccinelle to match a fully qualified (?)
> > identifier? For example, if I have two lines in C:
> >
> > A)
> > 	array_size(variable, 5);
> > B)
> > 	array_size(instance->member.size, 5);
> > C)
> > 	array_size(instance->member.size + 1, 5);
> > D)
> > 	array_size(function_call(variable), 5);
> >
> >
> > This matches A, B, C, and D:
> >
> > @@
> > expression ARG1;
> > expression ARG2;
> > @@
> >
> > array_size(ARG1, ARG2);
> >
> >
> > This matches only A:
> >
> > @@
> > identifier ARG1;
> > expression ARG2;
> > @@
> >
> > array_size(ARG1, ARG2);
> >
> >
> > How do I get something to match A and B but not C and D (i.e. I do not
> > want to match any operations, function calls, etc, only a variable,
> > which may be identified through dereference, array index, or struct
> > member access.)
> 
> \(i\|e.fld\|e->fld\)
> 
> would probably do what you want.  It will also match cases where e is a
> function/macr call, but that is unlikely.
> 
> If you want a single metavariable that contains the whole thing, you can
> have an expression metavariable E and then write:
> 
> \(\(i\|e.fld\|e->fld\) \& E\)

Can you give an example of how that would look for an @@ section?

The problem I have is that I don't know the depth or combination of such
metavariables. There are a lot of combinations:

a
	a.b
		a.b.c
			a.b.c.d
			a.b.c->d
		a.b->c
			a.b->c.d
			a.b->c->d
	a->b
		a->b.c
			a->b.c.d
			a->b.c->d
		a->b->c
			a->b->c.d
			a->b->c->d
...


-- 
Kees Cook
