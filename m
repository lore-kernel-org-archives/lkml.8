Return-Path: <SRS0=uMsS=BS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 100F7C433E0
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 22:49:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D4182206C3
	for <linux-kernel@archiver.kernel.org>; Sat,  8 Aug 2020 22:49:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="g9PMZbPi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726210AbgHHWs1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 8 Aug 2020 18:48:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59556 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725988AbgHHWsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Aug 2020 18:48:25 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5410C061756
        for <linux-kernel@vger.kernel.org>; Sat,  8 Aug 2020 15:48:25 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id g33so2860158pgb.4
        for <linux-kernel@vger.kernel.org>; Sat, 08 Aug 2020 15:48:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d5emEHeU0VdCmMZnn6BnVqQF21UzfzD0RJjo6t6lJzc=;
        b=g9PMZbPi3HkAE2ef1slA/FZbJQ9A2/ISneUIqXHRSvIm1a5w70I2P+5h5Ktq79OagY
         S4uQAS1NR3fzUHMv0T9MhrggEOZPUuR9fSojaM2gfbADEE2DwVv/cqGrXjpTKz2QhfWT
         dqWzqecB5usUAX8y0XyC8TfiPefmjqXDzWKZ8MkNTXTBavb/TCBxv0sIIztWphPu8Syx
         gn70nutP60p3GoIGrd9zkfmOKLfl2h8hoH+ORfJYWX1Im5ElFUBnpXPzJti7eol/gjgf
         1DRZE+d41xzqtx6RNwWQEjdvvJjTACKbjCC9Ui34beNGfydM4CGY4LWc1BKYnXElTl1F
         Hrlg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d5emEHeU0VdCmMZnn6BnVqQF21UzfzD0RJjo6t6lJzc=;
        b=kVIp7SUm3iLGsLKrP7Sfz6r33ofUMlxO14qezi+hjS9c6MtPLyCH2dYlzczXSHw+Re
         Oio+G5xZKUSL8NW4ICn49+R1Ui6rxfdKa+2CoOeF2WJ/h8bDktWJ6mPH+saJWY3xGeX7
         fz+dDcVwUfSDb+0K/0YfWdq2uHYGLr/pvvarMrz4oI9Pyp3fPc99jI7LPgMxipWmuMBV
         Y4DKBphfvZ7FEp3QXPDshjLkkQPPyNHS18uNJ9WVSkBr9AN1qYl7hSlWidaWRt22Hauf
         Nu8VnODplWYRcnlGBbyRE3FjLdoDV8rPEa64p9BqBtauzd2QgjCoyxgDdBalpn/7hmfd
         WawA==
X-Gm-Message-State: AOAM533FsZ8DlDB0CrWARwAoTrayCPxU23NbEyiiI9+AWZsxUDcn20UG
        4fCvkBgrctm3jNOeuhVyKl0=
X-Google-Smtp-Source: ABdhPJyW+c0znNsTBfE45CVaHIji2Gh8vNc+nD2vRkQ22H3TrwRYUDFv2Wd5Uz3Gi12LlxGVC1HqVA==
X-Received: by 2002:a65:4044:: with SMTP id h4mr16591152pgp.371.1596926904997;
        Sat, 08 Aug 2020 15:48:24 -0700 (PDT)
Received: from localhost (g223.115-65-55.ppp.wakwak.ne.jp. [115.65.55.223])
        by smtp.gmail.com with ESMTPSA id f20sm19340786pfk.36.2020.08.08.15.48.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 08 Aug 2020 15:48:24 -0700 (PDT)
Date:   Sun, 9 Aug 2020 07:48:22 +0900
From:   Stafford Horne <shorne@gmail.com>
To:     Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        openrisc@lists.librecores.org
Subject: Re: [PATCH v2 5/6] openrisc: signal: Fix sparse address space
 warnings
Message-ID: <20200808224822.GQ80756@lianli.shorne-pla.net>
References: <20200805210725.310301-1-shorne@gmail.com>
 <20200805210725.310301-6-shorne@gmail.com>
 <20200806190449.xqflhmbiiv5btusf@ltop.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200806190449.xqflhmbiiv5btusf@ltop.local>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 06, 2020 at 09:04:49PM +0200, Luc Van Oostenryck wrote:
> On Thu, Aug 06, 2020 at 06:07:24AM +0900, Stafford Horne wrote:
> > ---
> >  arch/openrisc/kernel/signal.c | 14 +++++++-------
> >  1 file changed, 7 insertions(+), 7 deletions(-)
> > 
> > diff --git a/arch/openrisc/kernel/signal.c b/arch/openrisc/kernel/signal.c
> > index 4f0754874d78..7ce0728412f6 100644
> > --- a/arch/openrisc/kernel/signal.c
> > +++ b/arch/openrisc/kernel/signal.c
> > @@ -76,7 +76,7 @@ asmlinkage long _sys_rt_sigreturn(struct pt_regs *regs)
> >  	 * then frame should be dword aligned here.  If it's
> >  	 * not, then the user is trying to mess with us.
> >  	 */
> > -	if (((long)frame) & 3)
> > +	if (((__force unsigned long)frame) & 3)
> >  		goto badframe;
> 
> Same as patch 6, the __force is not needed.

Thanks,  I thought this was complaining before, I tested now and there is no
problem so I must have been mixed up with something else.

-Stafford
