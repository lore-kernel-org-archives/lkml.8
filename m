Return-Path: <SRS0=ABJN=6Z=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1EB2C47255
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:04:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 869A32070B
	for <linux-kernel@archiver.kernel.org>; Mon, 11 May 2020 17:04:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="hXA4IfAy"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730915AbgEKREn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 11 May 2020 13:04:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730624AbgEKREn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 May 2020 13:04:43 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACBE6C061A0C
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 10:04:42 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id g1so4450155ljk.7
        for <linux-kernel@vger.kernel.org>; Mon, 11 May 2020 10:04:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=/mo0sXYy7ZUcg8/iVmBIYTh3WKI/O9UKGDKgE3MM9OU=;
        b=hXA4IfAyZ9uCnsRj1IlyziglyHt+A5cuk0JFQeVBiCHd9zjCrgOVMcKJF9i9K0lFkZ
         2C0EBsUocyE95044XVsYOj08QZufGfYjnK/suq9vFsO1TFNcA80W1xcerX5ScCEXy/Nd
         rED/AjvLfeVqsG+lg/Wk/5lSefhgNEdmBo3xyC6+sfroM2hkmWMdZ5kWIcqa3QKqvpaB
         Aa7BOzwQIgN+bIV4VaIc6ltfDuEXR2FcLFZUJ/Ae8f349zSm2WFwFKOcEEsr/MHkGwZY
         v6Rqq7VlvrVt08JcUojJNTr2VpUFyNe8xJNCHsV3y/TTNw6ahQimGkRuXPJ+YIhcFJBf
         EKwA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=/mo0sXYy7ZUcg8/iVmBIYTh3WKI/O9UKGDKgE3MM9OU=;
        b=HE+0d4XlSmCvRm7CVHWezuSckyNVocYNHwpdna/zFupgotfZpOvvEQ3DOYyPnVVv/s
         OH8t8gebDTIvYwUyGXH9t27L3gCY75qVt7FFywDS448wfSx5fdroEdBA7UMqvzX++rRj
         tLCx/AYweRSCdgZ9Ax9BcwKYg7xBm+uPf2XU6k6rF6Ct/mpCO7CrWw3zVBark+lhJyj0
         nbaL6opH4Th3ERaD9X2nBxRrzxTZT0Z5n0EieSdbRnsMtY/e02OjBUvvH6/KpZd+1fkG
         swInmKRqmF01GNcqmS9t5VlmsY6iw+s8J+Wv7iUl4L+0b5ebV2u3jFVaiFezul96XuvL
         pEvQ==
X-Gm-Message-State: AOAM530FyjO1guEFjkhX7OPMWm6N76i/DlJf/RXHYbdapaW8sPo+pN0I
        lRYLq2Bex6Pk+KwZKGc7rge0/+VML/ylOIreKCws2Q==
X-Google-Smtp-Source: ABdhPJxgwHFVl1+McnRhXd3Gy7veJhg91K1rAcv5lPJNNEQ7CZDXxXmFozw0EfVRJSC/ejsFw2RnmMAQ5ErFRX3x/s8=
X-Received: by 2002:a2e:b0e3:: with SMTP id h3mr10987519ljl.69.1589216680793;
 Mon, 11 May 2020 10:04:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200504190526.84456-1-peterx@redhat.com> <20200505013929.GA17225@linux.intel.com>
 <20200505141245.GH6299@xz-x1> <20200511160537.GC24052@linux.intel.com>
In-Reply-To: <20200511160537.GC24052@linux.intel.com>
From:   Oliver Upton <oupton@google.com>
Date:   Mon, 11 May 2020 10:04:29 -0700
Message-ID: <CAOQ_Qsi-50zLtq8nKeUN8wYKkiq9TkX9fcNHwzZ_F5JX0qJp-g@mail.gmail.com>
Subject: Re: [PATCH] KVM: Fix a warning in __kvm_gfn_to_hva_cache_init()
To:     Sean Christopherson <sean.j.christopherson@intel.com>
Cc:     Peter Xu <peterx@redhat.com>, Paolo Bonzini <pbonzini@redhat.com>,
        kvm list <kvm@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Tony Cook <tony-cook@bigpond.com>, zoran.davidovac@gmail.com,
        euloanty@live.com
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 11, 2020 at 9:05 AM Sean Christopherson
<sean.j.christopherson@intel.com> wrote:
>
> +cc a few other people that have reported this at one time or another.
>
> On Tue, May 05, 2020 at 10:12:45AM -0400, Peter Xu wrote:
> > On Mon, May 04, 2020 at 06:39:29PM -0700, Sean Christopherson wrote:
> > > On Mon, May 04, 2020 at 03:05:26PM -0400, Peter Xu wrote:
> > > > GCC 10.0.1 gives me this warning when building KVM:
> > > >
> > > >   warning: =E2=80=98nr_pages_avail=E2=80=99 may be used uninitializ=
ed in this function [-Wmaybe-uninitialized]
> > > >   2442 |  for ( ; start_gfn <=3D end_gfn; start_gfn +=3D nr_pages_a=
vail) {
> > > >
> > > > It should not happen, but silent it.
> > >
> > > Heh, third times a charm?  This has been reported and proposed twice
> > > before[1][2].  Are you using any custom compiler flags?  E.g. -O3 is =
known
> > > to cause false positives with -Wmaybe-uninitialized.
> >
> > No, what I did was only upgrading to Fedora 32 (which will auto-upgrade=
 GCC),
> > so it should be using the default params of whatever provided.
> >
> > >
> > > If we do end up killing this warning, I'd still prefer to use
> > > uninitialized_var() over zero-initializing the variable.
> > >
> > > [1] https://lkml.kernel.org/r/20200218184756.242904-1-oupton@google.c=
om
> > > [2] https://bugzilla.kernel.org/show_bug.cgi?id=3D207173
> >
> > OK, I didn't know this is a known problem and discussions going on.  Bu=
t I
> > guess it would be good to address this sooner because it could become a=
 common
> > warning very soon after people upgrades gcc.
>
> Ya, others are hitting this as well.  It's especially painful with the
> existence of KVM_WERROR.
>
> Paolo, any preference on how to resolve this?  It would appear GCC 10 got
> "smarter".

Seems that doing absolutely nothing was the fix here :) See:

78a5255ffb6a ("Stop the ad-hoc games with -Wno-maybe-initialized")

--
Thanks,
Oliver
