Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 64BCEC433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:14:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3B974206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 15:14:44 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="chhZELv0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730091AbgGHPOn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 11:14:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729206AbgGHPOm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 11:14:42 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 597DAC061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 08:14:40 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id n26so37032248ejx.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 08:14:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+wc9AMwrEbeNMpcYWmQkk0DMLNxE+2xQRYkLjlCn58k=;
        b=chhZELv0EVMHzIvL8iY2Ojn8KoNPlOkgGrHSzPggYp9J6IwJyZT704GOCvomH/ZLSl
         dPKpiE5d4lW1bYKlsa2Xr+Qi71L1d5tpQXOknrf5yowP09mP5/gT4uIxNVnkOegPPHhH
         nSKMNEoPwDiz/1PkHXC6iAzlBm607d5/Y3f9khJY5XbtkKydSK5NdoIiB9QlsXWTH2QB
         SyqZt5+5SjFKLuNt+qa0JabcaaoEEpdZ2in1uYFvxwCOg6b49QVLwcR58Je0ntEa5aio
         LTcpDol25SoPyDuEddaynpnTb1WgO/4+SDpHOSDqJ6HRWEtwU6xOoHz7fmWhmsWZxwDX
         H8Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+wc9AMwrEbeNMpcYWmQkk0DMLNxE+2xQRYkLjlCn58k=;
        b=DoArlau+/WVAIvAtQ/XNQtYNhE3PRQuTcAYVBQbQpLSQriMTQTvPMwgFHNI/FQA9IY
         LtTOxn3ht+q6z7Dd2JDEOtNdGtbfLUgDd5Z8PHyndnGX0LB9fHB5hygjLe8ergI2FSO5
         e3PdxegZYLDa6IdeqS1MYuR3l168PegbEthdcWQmKEv8vxS2nMM1tM++fBQ+nwenfI3o
         CIWOgOuTb6wL3NDj1xhyGiCGBGOPzfKVAPFVee6IL0ICc1KnJOlp+u4UmsBUiyzqD17K
         GmZ5IGIqcHXzi34GbIgjJ175OK3BbZdb693oijvDo60K0Ob1osNALKiSd+FimuAdkVhx
         DywA==
X-Gm-Message-State: AOAM530qRkrH8ShdblJU2UM6bmnu+QkzAMpTr/x7WyEjVZZrLJ9Q+Jnj
        WOLyYbwjuf+H/IVkTTVvBh33v7qvZ8vfqVAypGrRMw==
X-Google-Smtp-Source: ABdhPJz67JZnPq+/eyLYBt7UGeM8LX5m9PzhzZsm/9Fo7nGPbQhNjZiijJ2GI+iTn4p9FoR/SisPh4NaNaz2+UyCBD8=
X-Received: by 2002:a17:906:1a54:: with SMTP id j20mr51363389ejf.455.1594221279045;
 Wed, 08 Jul 2020 08:14:39 -0700 (PDT)
MIME-Version: 1.0
References: <159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com>
 <b15e2652aba06dbe244f5ed447e6e96f12302198.camel@perches.com>
In-Reply-To: <b15e2652aba06dbe244f5ed447e6e96f12302198.camel@perches.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 8 Jul 2020 08:14:27 -0700
Message-ID: <CAPcyv4iz6TzMhMvDzSvOgOvuu68z2YpxHeOycXrrjOfjaceHwQ@mail.gmail.com>
Subject: Re: [PATCH v2] CodingStyle: Inclusive Terminology
To:     Joe Perches <joe@perches.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dave Airlie <airlied@redhat.com>,
        Kees Cook <keescook@chromium.org>,
        SeongJae Park <sjpark@amazon.de>,
        Olof Johansson <olof@lixom.net>, Chris Mason <clm@fb.clm>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 8, 2020 at 4:05 AM Joe Perches <joe@perches.com> wrote:
>
> On Wed, 2020-07-08 at 00:23 -0700, Dan Williams wrote:
> > Linux maintains a coding-style and its own idiomatic set of terminology.
> > Update the style guidelines to recommend replacements for the terms
> > master/slave and blacklist/whitelist.
> >
> > Link: http://lore.kernel.org/r/159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Acked-by: Randy Dunlap <rdunlap@infradead.org>
> > Acked-by: Dave Airlie <airlied@redhat.com>
> > Acked-by: Kees Cook <keescook@chromium.org>
> > Acked-by: SeongJae Park <sjpark@amazon.de>
> > Signed-off-by: Olof Johansson <olof@lixom.net>
> > Signed-off-by: Chris Mason <clm@fb.clm>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> > Changes since v1 [1]
> > - Drop inclusive-terminology.rst, it is in the lore archives if the
> >   arguments are needed for future debates, but otherwise no pressing
> >   need to carry it in the tree (Linus, James)
>
> Where did Linus publicly state this was unnecessary?

James suggested dropping the document, Linus agreed, I agreed.

>
> > diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> []
> > @@ -319,6 +319,19 @@ If you are afraid to mix up your local variable names, you have another
> >  problem, which is called the function-growth-hormone-imbalance syndrome.
> >  See chapter 6 (Functions).
> >
> > +For symbol names, avoid introducing new usage of 'master/slave' (or
> > +'slave' independent of 'master') and 'blacklist/whitelist'. Recommended
> > +replacements for 'master/slave' are: 'main/{secondary,subordinate}',
> > +'primary/replica', '{initiator,requester}/{target,responder}',
> > +'host/{device,proxy}', or 'leader/{performer,follower}'. Recommended
> > +replacements for 'blacklist/whitelist' are: 'denylist/allowlist' or
> > +'blocklist/passlist'.
>
> Adding a reference to SeongJae Park's introduction of
> scripts/deprecated_terms.txt or the like might help
> make this list unnecessary if more terms are added.

Per his last mail he's going to update his checker to refer to coding-style.

> > +Exceptions for introducing new usage is to maintain a userspace ABI/API,
> > +or when updating code for an existing (as of 2020) hardware or protocol
> > +specification that mandates those terms. For new specifications
> > +translate specification usage of the terminology to the kernel coding
> > +standard where possible.
>
> I believe any existing code should not be changed,
> not just code that is required to be maintained
> for userspace.

We have existing practices around coding-style changes that can be
applied here. Some subsystems are open to modernizing their code with
respect to the latest coding style recommendations and others,
especially those with ancient drivers don't want the churn. So, I
would hold these cleanups to the same standard.
