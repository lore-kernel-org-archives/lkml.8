Return-Path: <SRS0=bWCJ=AA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 364FDC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:12:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0C1C6207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 19 Jun 2020 14:12:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ow02Xl8F"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732844AbgFSOMl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 19 Jun 2020 10:12:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726008AbgFSOMk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Jun 2020 10:12:40 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 817A9C06174E
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 07:12:40 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id dp18so10344697ejc.8
        for <linux-kernel@vger.kernel.org>; Fri, 19 Jun 2020 07:12:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=P8Ayf9ltxS+pfH19OKDWTpDtAf+hqQzXQbxNUzkX6og=;
        b=Ow02Xl8FLGIRIoGYfHWH4WlUlH6w5LlCPeuRphbEAfmtJiDEWFb3gidW2dml9pJhzo
         CSY6Mz6RGRmBMqgjFPyYZBL25/OZY5gPqMNuteaOixeA85yRckgCUusJO6KnoWPb1wF3
         eu6ustwcOnkv+wQl0Fz42DkErY1Qr7CUnr8o1ENeBc3b92hUiteAX+MGT7Gw+4TbfFLh
         Y5VH7B7BZ9BKK4UjgZB82X1f6OJ9ipnmjlNIpQbLlygh3oqUm0CrAbYpNXmQHxcJkgp2
         CcFx5ebFZiJNQdzxxhdFBy+BXl33ECAwYwzz4wL1oISfGsHPPIE/2dz3YDOnpTA7jKOn
         TduQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=P8Ayf9ltxS+pfH19OKDWTpDtAf+hqQzXQbxNUzkX6og=;
        b=SfHpSRIjlAzPPSKylu9rG155xrqnIgbblLRPeTE1fsJotOXDY5omHKOBO5BCQYZxe+
         oRxL/mwRVAZ+au0N1LW6Bomp5wph1qUj/B8xb91YOF3BVA4aTKwzBgMOmPQRQtQHqRKs
         tBUbCU8g6ffleT3R1YVJ4ppVgwYeVFLwLDR/bVKq+fgmEf2VFKT7HCyXwpKciSJf9jCy
         bmfZndhLlZsLdmMqkm80lDko7yLyp78cj5Kn5i5BndNUGoRmZxDrMnCzcmwvGLknJwHn
         ggMFxd4NNiN4fpJ70EYTI+dv1NsJt9c6Pa2BBqcT//JYzGxMU/gvMEG/WIXo1pkNyJEK
         Bw/g==
X-Gm-Message-State: AOAM530gqdXswxR1KDzgQV4L5JkiMjI6XfVW4jBh4hPZHKbdu+P00FFU
        p1SkNBjrEyL6cB0WNQWkSbE=
X-Google-Smtp-Source: ABdhPJwwyM43eQ6ECiXYT7HX3JqBoSfTuenbEwvqkMWJvZCC4Z87l4O7vqlNbvp3luModL+FmepEAQ==
X-Received: by 2002:a17:906:3a43:: with SMTP id a3mr3736171ejf.121.1592575959273;
        Fri, 19 Jun 2020 07:12:39 -0700 (PDT)
Received: from ltop.local ([2a02:a03f:b7f9:7600:904f:be8d:1d92:9974])
        by smtp.gmail.com with ESMTPSA id d11sm4582310edy.79.2020.06.19.07.12.38
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Jun 2020 07:12:38 -0700 (PDT)
Date:   Fri, 19 Jun 2020 16:12:37 +0200
From:   Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
To:     Marco Elver <elver@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        linux-kernel@vger.kernel.org, Borislav Petkov <bp@suse.de>,
        Will Deacon <will@kernel.org>
Subject: Re: [PATCH] sparse: use the _Generic() version of
 __unqual_scalar_typeof()
Message-ID: <20200619141237.onwjhjbc7ni7rrev@ltop.local>
References: <20200618222620.5069-1-luc.vanoostenryck@gmail.com>
 <20200619095105.GA222848@elver.google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200619095105.GA222848@elver.google.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 19, 2020 at 11:51:05AM +0200, Marco Elver wrote:
> On Fri, Jun 19, 2020 at 12:26AM +0200, Luc Van Oostenryck wrote:
> > If the file is being checked with sparse, use the version of
> > __unqual_scalar_typeof() using _Generic(), leaving the unoptimized
> > version only for the oldest versions of GCC.
> > 
> > This reverts commit
> >   b398ace5d2ea ("compiler_types.h: Use unoptimized __unqual_scalar_typeof for sparse")
> > 
> > Note: a recent version of sparse will be needed (minimum v0.6.2-rc2
> >        or later than 2020-05-28).
> > 
> > Cc: Marco Elver <elver@google.com>
> > Cc: Borislav Petkov <bp@suse.de>
> > Cc: Will Deacon <will@kernel.org>
> > Link: https://marc.info/?l=linux-sparse&m=159233481816454
> > Signed-off-by: Luc Van Oostenryck <luc.vanoostenryck@gmail.com>
> 
> Definitely support this change, so in principle:
> 
> 	Acked-by: Marco Elver <elver@google.com>
> 
> But, I think sparse still isn't entirely happy with all legal uses of
> _Generic. Running latest sparse on:

Indeed.

> Whereas GCC or Clang accept this as expected. I can't find the
> standardese right now, but in [1] we have:
> 
> 	"[...] The conversion is performed in type domain only: it
> 	discards the top-level cvr-qualifiers and atomicity and applies
> 	array-to-pointer/function-to-pointer transformations to the type
> 	of the controlling expression [...]"
> 
> [1] https://en.cppreference.com/w/c/language/generic

Yes, these are the rules following the resolution of DR481, which
are now used for C17 and also by gcc & clang for C11 but were not
present the C11 standard.

This should be fixed now but I'm waiting for the tests results.

Thanks for reporting this.
-- Luc
