Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7CED6C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5B663207C4
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 18:03:24 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="Y8yS3TZ8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1731460AbgFPSDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 14:03:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730227AbgFPSDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 14:03:21 -0400
Received: from mail-pf1-x444.google.com (mail-pf1-x444.google.com [IPv6:2607:f8b0:4864:20::444])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6378CC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 11:03:21 -0700 (PDT)
Received: by mail-pf1-x444.google.com with SMTP id 23so9849639pfw.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 11:03:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=qg6/6CMY8n7dnVVzd/Y5tNDAB5f5iIduvPF8I6aFaCo=;
        b=Y8yS3TZ8PrhQXOs6mBuw4v2QGvvGfxHsE1fQ7xfnQHUyeW3t+dbyTbFSDDa+98l4UG
         9S7farLd0mOaXNW8mKYeschG/WM6J5RJd5VrsolvvCS7ZvOxgmeoJW346Ax+Yeq+UaEZ
         PSBERBsdM86nsYlrf4DzJ0E0+racCrQPjy/zY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=qg6/6CMY8n7dnVVzd/Y5tNDAB5f5iIduvPF8I6aFaCo=;
        b=IlHoZrPG+4EgygiTUJu2R65d1xHbC9nf44uqWO4Dn3D2rj8r3pIofkYS26vLtELsF+
         jp2MIV6mFaJ+m6i/xHlO9DONAVYDNw6OX46igIO7i20R0K25BSotIbdtMzZvQlRxwhoz
         MwVCOLLPrPHSt4CeY73Vwm5sQAgdT5tc9azPObaeWa+qhAAv2d91q2Hae2Jx/e9DqK5r
         4NFotlVgjOohjcOYgpq0qc6x/elXtThzoLgp7L+5fRxnfSSFNu4bcsqjNX+tOdRRx1Rl
         UB1aYoCQ/ZaeGk1u1eTvSwEQn6bWjBwhot/ofo693V7l/b2EuP2nLcgcWLJZGHJpzNgt
         zn0g==
X-Gm-Message-State: AOAM530Z7FiAl9D5yw5XkFuTKId0ZVp5YNAn58hlKiAGvIdjoH+adS/g
        2pjKEzZpGHLcDMbrhLXlhgkfPw==
X-Google-Smtp-Source: ABdhPJyXxWprGddlTKQxjwvOzOfzWbsCy/u2EM6/g368rwSGZfo6UsGRgcOsulhmI4axiemhv/6BFQ==
X-Received: by 2002:a63:b74f:: with SMTP id w15mr3104550pgt.314.1592330600769;
        Tue, 16 Jun 2020 11:03:20 -0700 (PDT)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id i10sm15257177pgq.36.2020.06.16.11.03.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 16 Jun 2020 11:03:19 -0700 (PDT)
Date:   Tue, 16 Jun 2020 11:03:18 -0700
From:   Kees Cook <keescook@chromium.org>
To:     Matt Helsley <mhelsley@vmware.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        "Steven Rostedt (VMware)" <rostedt@goodmis.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        "Naveen N. Rao" <naveen.n.rao@linux.vnet.ibm.com>,
        Kristen Carlson Accardi <kristen@linux.intel.com>,
        linux-kbuild@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] recordmcount: support >64k sections
Message-ID: <202006161101.34B26E6@keescook>
References: <20200422232417.72162-1-samitolvanen@google.com>
 <20200424193046.160744-1-samitolvanen@google.com>
 <20200424222214.GC9040@rlwimi.vmware.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200424222214.GC9040@rlwimi.vmware.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 24, 2020 at 03:22:14PM -0700, Matt Helsley wrote:
> On Fri, Apr 24, 2020 at 12:30:46PM -0700, Sami Tolvanen wrote:
> > When compiling a kernel with Clang and LTO, we need to run
> > recordmcount on vmlinux.o with a large number of sections, which
> > currently fails as the program doesn't understand extended
> > section indexes. This change adds support for processing binaries
> > with >64k sections.
> > 
> > Signed-off-by: Sami Tolvanen <samitolvanen@google.com>
> 
> Feel free to add
> 
> Reviewed-by: Matt Helsley <mhelsley@vmware.com>

Hi!

Can this patch please be applied and sent before -rc2? FGKASLR, LTO, and
link time improvements[1] all depend on this fix, and I'd really like
them all to be able to sanely rebase for the development window.

Thanks!

-Kees

[1] https://lore.kernel.org/lkml/CAK7LNARbZhoaA=Nnuw0=gBrkuKbr_4Ng_Ei57uafujZf7Xazgw@mail.gmail.com/

> 
> > ---
> > Changes in v2:
> >  - Switched to unsigned int for (old|new)_shnum in append_func.
> >  - Added set_shnum and find_symtab helper functions and moved
> >    the new logic there.
> > 
> > ---
> >  scripts/recordmcount.h | 98 +++++++++++++++++++++++++++++++++++++++---
> >  1 file changed, 92 insertions(+), 6 deletions(-)
> 
> <snip>

-- 
Kees Cook
