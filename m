Return-Path: <SRS0=NqQd=7Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 55595C433DF
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 03:12:42 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2464E206FA
	for <linux-kernel@archiver.kernel.org>; Thu, 11 Jun 2020 03:12:42 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="oEKLqBth"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726387AbgFKDMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 23:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40264 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726312AbgFKDMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 23:12:40 -0400
Received: from mail-pj1-x1044.google.com (mail-pj1-x1044.google.com [IPv6:2607:f8b0:4864:20::1044])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B8B3C08C5C1
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 20:12:39 -0700 (PDT)
Received: by mail-pj1-x1044.google.com with SMTP id h95so1775109pje.4
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 20:12:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=E/BV7QCKbs58GW28of5JsI/VaBszSvteviKF6A2dE0w=;
        b=oEKLqBth/WTLkHxALaI4JdTFChNPI2SunsTjFLTUKmZ0zFV+wh1VcAJZ8I/SLPxNue
         1MGreEQAXcWYXKjYVrO48BFfZ8dlEHzTSJHAegPOKP4HFGisAVpGydxhlCwBQm6dPVdH
         1nrOckOjDwP34JbMjBWbZmmI7tHrA5iv5Kx0Q=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=E/BV7QCKbs58GW28of5JsI/VaBszSvteviKF6A2dE0w=;
        b=LfzvmIZ8zY0pAu61WKzhi/OL7EDEArlOBKA/2K9bClsWPJmeONNhcMTL0CVpTQx9yv
         ut7pmAgIdbXfIOAEQaU2F+js8KysPScsIIm0JYO7ybTrqR/ZcLMshxalF3LyTo+YCvTk
         NDTBVN5aU/0XujlOyEcPTAe3YzbhFdSE/07AmX7GA0V2V9Ma7J/xCOUAU/V1BXXb1Dwj
         VM1nB5RdSKp6oUweieRUcyQ5kscIsoQhbvq20FjkJ+gE3trLSn1hM+lHwQl4sRPxNQIl
         zu8rWlwg9w5p9JRACg2B2m0otS6/ImsY+uPCBXPeCwJ7/DHkrhpkH56cbkypvGEKiS4S
         VVWQ==
X-Gm-Message-State: AOAM530i7UBpmjdixswj/MXLTePRnZWZlzqD0SOeTG0Sigo13BDY2nHc
        WUZLKVXlnBC+w34bUZVF89w1Ew==
X-Google-Smtp-Source: ABdhPJyQ6PZEg7hRQ5CFYpuwfmPSmaUGl5e/8ZFwr5nUlnezbtTiQNs2FBCn6F3/uod1YNH+Wl4seQ==
X-Received: by 2002:a17:90b:307:: with SMTP id ay7mr6091054pjb.48.1591845158693;
        Wed, 10 Jun 2020 20:12:38 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id h5sm1336786pfb.120.2020.06.10.20.12.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Jun 2020 20:12:37 -0700 (PDT)
Date:   Wed, 10 Jun 2020 20:12:36 -0700
From:   Kees Cook <keescook@chromium.org>
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Federico Vaga <federico.vaga@vaga.pv.it>,
        Jonathan Corbet <corbet@lwn.net>,
        Mauro Carvalho Chehab <mchehab+huawei@kernel.org>,
        David Sterba <dsterba@suse.com>,
        Randy Dunlap <rdunlap@infradead.org>,
        Theodore Ts'o <tytso@mit.edu>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Jacob Huisman <jacobhuisman@kernelthusiast.com>,
        Jonathan =?iso-8859-1?Q?Neusch=E4fer?= <j.neuschaefer@gmx.net>,
        Rob Herring <robh@kernel.org>, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, clang-built-linux@googlegroups.com
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones:
 Documentation/translations/it_IT
Message-ID: <202006102009.CB14D7F@keescook>
References: <20200609201241.81518-1-grandmaster@al2klimov.de>
 <4235548.LvFx2qVVIh@harkonnen>
 <cd260d03-27a4-7794-f58f-21e8e0be9755@al2klimov.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <cd260d03-27a4-7794-f58f-21e8e0be9755@al2klimov.de>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 08:11:39PM +0200, Alexander A. Klimov wrote:
> Am 10.06.20 um 10:57 schrieb Federico Vaga:
> > On Tuesday, June 9, 2020 10:12:41 PM CEST Alexander A. Klimov wrote:
> > > Rationale:
> > > Reduces attack surface on kernel devs opening the links for MITM
> > > as HTTPS traffic is much harder to manipulate.
> > > 
> > > Deterministic algorithm:
> > > For each file:
> > >    For each line:
> > >      If doesn't contain `\bxmlns\b`:
> > >        For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
> > >          If both the HTTP and HTTPS versions
> > >          return 200 OK and serve the same content:
> > >            Replace HTTP with HTTPS.

Is this script somewhere we can read it? (It's easier usually to review
the code for bulk changes than the bulk changes themselves.)

> > > 
> > > Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> > > ---
> > >   .../translations/it_IT/admin-guide/README.rst      |  2 +-
> > >   .../translations/it_IT/doc-guide/parse-headers.rst |  2 +-
> > >   .../translations/it_IT/doc-guide/sphinx.rst        | 10 +++++-----
> > >   .../translations/it_IT/process/2.Process.rst       | 12 ++++++------
> > >   .../translations/it_IT/process/3.Early-stage.rst   |  2 +-
> > >   .../translations/it_IT/process/4.Coding.rst        |  4 ++--
> > >   .../it_IT/process/7.AdvancedTopics.rst             |  8 ++++----
> > >   .../translations/it_IT/process/8.Conclusion.rst    | 14 +++++++-------
> > >   .../translations/it_IT/process/adding-syscalls.rst |  4 ++--
> > >   .../translations/it_IT/process/changes.rst         |  6 +++---
> > >   .../translations/it_IT/process/clang-format.rst    |  2 +-
> > >   .../translations/it_IT/process/coding-style.rst    |  2 +-
> > >   Documentation/translations/it_IT/process/howto.rst |  2 +-
> > >   .../it_IT/process/maintainer-pgp-guide.rst         |  2 +-
> > >   .../it_IT/process/submitting-patches.rst           |  4 ++--
> > >   .../it_IT/process/volatile-considered-harmful.rst  |  4 ++--
> > >   16 files changed, 40 insertions(+), 40 deletions(-)
> > > 
> > 
> > 
> > > diff --git a/Documentation/translations/it_IT/doc-guide/sphinx.rst
> > > b/Documentation/translations/it_IT/doc-guide/sphinx.rst index
> > > f1ad4504b734..0aaeb0297661 100644
> > > --- a/Documentation/translations/it_IT/doc-guide/sphinx.rst
> > > +++ b/Documentation/translations/it_IT/doc-guide/sphinx.rst
> > > @@ -14,7 +14,7 @@ Per generare la documentazione in HTML o PDF, usate
> > > comandi ``make htmldocs`` o ``make pdfdocs``. La documentazione così
> > > generata sarà disponibile nella cartella ``Documentation/output``.
> > > 
> > > -.. _Sphinx: http://www.sphinx-doc.org/
> > > +.. _Sphinx: https://www.sphinx-doc.org/
> > >   .. _reStructuredText: http://docutils.sourceforge.net/rst.html
> > 
> > It is not part of the deterministic algorithm but you may consider this as
> > well

Why did it not match?

> > 
> > -.. _reStructuredText: http://docutils.sourceforge.net/rst.html
> > +.. _reStructuredText: https://docutils.sourceforge.io/rst.html
> > 
> I'll think about analyzing such almost-matches, extending the algo and
> supplying a second round of patches once all [1] of this round arrive in
> torvalds/master.
> 
> [1]:
> 
> ➜  linux git:(feature/https-links-3) ✗ git diff --shortstat
>  1963 files changed, 2882 insertions(+), 2882 deletions(-)
> ➜  linux git:(feature/https-links-3) ✗

Is there a reason to do this one language at a time instead of just
doing everything in one go?

-- 
Kees Cook
