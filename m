Return-Path: <SRS0=K2g5=43=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E68AFC18E5B
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:22:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B81D621D7E
	for <linux-kernel@archiver.kernel.org>; Tue, 10 Mar 2020 19:22:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="MmjLu5wl"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727273AbgCJTWZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 10 Mar 2020 15:22:25 -0400
Received: from mail-pj1-f68.google.com ([209.85.216.68]:38476 "EHLO
        mail-pj1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726546AbgCJTWZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 Mar 2020 15:22:25 -0400
Received: by mail-pj1-f68.google.com with SMTP id a16so854107pju.3
        for <linux-kernel@vger.kernel.org>; Tue, 10 Mar 2020 12:22:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=Vrf8fXIC1r2+JvlXlYgJWxCM5oPrpq5MZD/CQnIzo+w=;
        b=MmjLu5wlCm1KVWVg8MptJtFwJswJGmrA7TNTK6MlBe1QSv/l6sU0nu+xKUKFI5me9o
         88d+/cMpF6gvVKH5e38OY0sZpb0yCnFMSTlBQPQcLhTCOcS96CUUksnCUaHuQvU1WaFN
         06B+kAybXERrT5cBsw8iPIopCKaMFgckQdHZI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=Vrf8fXIC1r2+JvlXlYgJWxCM5oPrpq5MZD/CQnIzo+w=;
        b=GEJt2YpORNcjjJVTJEU7s015ubOAiwdHCiBJjixUXT4pABxjy/M5tyolX53F+WOQXt
         lyJw50bddyL+/ErAW9sLFZJD/fAYDR657CHuBubcyAbMNhbPri6FXaNLMq3FsPFEz5AC
         a8FnZh3k/eEF9g8AJ9ozfVDHGzJZbeY7H1gvhJwgUINoA0LLBxsZuPePpOa4J1TRDm3V
         +6v80VWAvG1E8ESBwF4+k0gYSWkS49etIr2JVA6B2jyW91YvYQlDnUMOJnivgURwfzaJ
         ToPql+iIEk5y5m4WUFkFXi83I8S9gFAcLt5AU8bR+9AlQ20CYPPcBHBdaeGO6VawLvCv
         209w==
X-Gm-Message-State: ANhLgQ2Igyq5hNvphpGgyN/y4lrfjtPNa8cpoI6PtUkpja+00gGG4rNa
        dRlNZ8OLTL7U/HTh93l6iryuFg==
X-Google-Smtp-Source: ADFU+vsysRpDn6XtMDd6KeAEkYr65mpcbz9mvFMHbNITyDJ6Jk+4GBWwtp+4wEdTCClVX71+QtvaoQ==
X-Received: by 2002:a17:902:8a81:: with SMTP id p1mr21836886plo.284.1583868143955;
        Tue, 10 Mar 2020 12:22:23 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id o66sm35070452pfb.93.2020.03.10.12.22.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 10 Mar 2020 12:22:22 -0700 (PDT)
Date:   Tue, 10 Mar 2020 12:22:21 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     Joe Perches <joe@perches.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        "Gustavo A. R. Silva" <gustavo@embeddedor.com>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] docs: deprecated.rst: Clean up fall-through details
Message-ID: <202003101221.A1388D0C@keescook>
References: <202003041102.47A4E4B62@keescook>
 <20200310112356.1b5b32f2@lwn.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200310112356.1b5b32f2@lwn.net>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 10, 2020 at 11:23:56AM -0600, Jonathan Corbet wrote:
> On Wed, 4 Mar 2020 11:03:24 -0800
> Kees Cook <keescook@chromium.org> wrote:
> 
> > Add example of fall-through, list-ify the case ending statements, and
> > adjust the markup for links and readability. While here, adjust
> > strscpy() details to mention strscpy_pad().
> > 
> > Signed-off-by: Kees Cook <keescook@chromium.org>
> 
> Applied, thanks.  But ...
> 
> > ---
> >  Documentation/process/deprecated.rst | 48 +++++++++++++++++-----------
> >  1 file changed, 29 insertions(+), 19 deletions(-)
> > 
> > diff --git a/Documentation/process/deprecated.rst b/Documentation/process/deprecated.rst
> > index 179f2a5625a0..f9f196d3a69b 100644
> > --- a/Documentation/process/deprecated.rst
> > +++ b/Documentation/process/deprecated.rst
> > @@ -94,8 +94,8 @@ and other misbehavior due to the missing termination. It also NUL-pads the
> >  destination buffer if the source contents are shorter than the destination
> >  buffer size, which may be a needless performance penalty for callers using
> >  only NUL-terminated strings. The safe replacement is :c:func:`strscpy`.
> > -(Users of :c:func:`strscpy` still needing NUL-padding will need an
> > -explicit :c:func:`memset` added.)
> > +(Users of :c:func:`strscpy` still needing NUL-padding should instead
> > +use strscpy_pad().)
> 
> :c:func: usage should really be stomped on when we encounter it.  There's
> a few in this file; I'll tack on a quick patch making them go away.

Oops, yes, I meant to do another pass for that. I will double-check
future patches!

-- 
Kees Cook
