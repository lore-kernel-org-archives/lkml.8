Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4090EC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:31:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0E987206C3
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 11:31:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="KN1z/W/Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729556AbgFHLbQ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 07:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42982 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729310AbgFHLbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 07:31:14 -0400
Received: from mail-pf1-x443.google.com (mail-pf1-x443.google.com [IPv6:2607:f8b0:4864:20::443])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89BC6C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 04:31:14 -0700 (PDT)
Received: by mail-pf1-x443.google.com with SMTP id h185so8424758pfg.2
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 04:31:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9/XB7kXQLS1xVYDySLVP5Kn15kvrdx0ZXmrSl6/6z94=;
        b=KN1z/W/Ywx5Qd3mhA9Cl8XpFmYFnCTvyskPW4FRIrn+Yn+BZfB30wBzs78gsVnAZwn
         XVitIU30H9dY21Dg5XlUUE3tPEgVpXjRN99wIZ4mQtElKFGdZ5VFJLzNdagmb6u1o0Ng
         Hehj81EGCJy+3gmSBWg3S9SZB43VWSaOQNSMtVNtKZy0wDwYvIaYRhYc7ldB//e35kTu
         odJhhsufZU2HQS0rsmbbsRMqNYnqRI7vgJuPgpXO4wkipdlyT3C5Z71aIoMzI7Z+X6Dw
         11laijqRx6T8bBGu8YaG2xBjJyl/GR4RBlhBJxpjDwqTvp9qDHZgIhCOt56T13EaelaC
         wQZQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9/XB7kXQLS1xVYDySLVP5Kn15kvrdx0ZXmrSl6/6z94=;
        b=nTcMoBBayOhXpu6KpFE4zHuLuFeVOP9BFP52m7YqrX3R91dj4Mzuxo8+3O0IK7N5tX
         ge1afFil8u+fwhZyZAv3UugymY5ljhz0KGLdd/gxqSDF6h9UiOGpEUpaSH12WvukqZHv
         8tlRluaYXCsWaFC3uacRGOi6yvbbkk1HthkGMaK1qftj2HIc0ZosbfeQ0AXsHgw3c7FE
         iFHJD46jUx41xwv8+WKsvN9FQDa//gSxV8Yyvv4Beegw9WXRj0SXPBDoVRYjR8yDNx5p
         GgxcirgjlbtokxwzihleB5PimiRquNHUdUwxenOyl959DVw9WQO9u9ZM8hiawsVUz8vB
         QcIw==
X-Gm-Message-State: AOAM53325IbrO3ku9sF0zgWQckn8SEqw5P2i3m6+0ksffM6NsgVW5Oae
        B3sMl0ObxhCs92AaONTXSAN78xFNvWsEgsivdAIO9JfTQh8=
X-Google-Smtp-Source: ABdhPJy5+ofbvJZACN8tT6jas5hqFxmFROlc2dGZrbOMVQCxop1vEXLWE5JrJv60E/y6n3IayYIRoMyu0CVGCY6buwI=
X-Received: by 2002:a63:545a:: with SMTP id e26mr19504943pgm.4.1591615874015;
 Mon, 08 Jun 2020 04:31:14 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1591606281.git.sbrivio@redhat.com> <3e3ab7a4756df2ecf8fb012f16c375d4cd714552.1591606281.git.sbrivio@redhat.com>
 <20200608101214.GE2428291@smile.fi.intel.com> <20200608122702.034c8c80@redhat.com>
In-Reply-To: <20200608122702.034c8c80@redhat.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Jun 2020 14:31:02 +0300
Message-ID: <CAHp75Vfvx6wKJUKfgDjyEcPthT9BicoZqfZmaS8eKMFwgvVphg@mail.gmail.com>
Subject: Re: [PATCH 2/2] lib: Add test for bitmap_cut()
To:     Stefano Brivio <sbrivio@redhat.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Yury Norov <yury.norov@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Rasmus Villemoes <linux@rasmusvillemoes.dk>,
        Pablo Neira Ayuso <pablo@netfilter.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 8, 2020 at 1:29 PM Stefano Brivio <sbrivio@redhat.com> wrote:
> On Mon, 8 Jun 2020 13:12:14 +0300
> Andy Shevchenko <andriy.shevchenko@linux.intel.com> wrote:
> > On Mon, Jun 08, 2020 at 11:13:29AM +0200, Stefano Brivio wrote:
> > > Based on an original patch by Yury Norov: introduce a test for
> > > bitmap_cut() that also makes sure functionality is as described for
> > > partially overlapping src and dst.
> >
> > > Co-authored-by: Yury Norov <yury.norov@gmail.com>
> >
> > Co-developed-by (and it requires Yury's SoB as well).
>
> Oops, sorry, I didn't remember this part from submitting-patches.rst
> correctly. Thanks for pointing this out.
>
> Yury, let me know if I should re-post with both Co-authored-by: and

Co-developed-by: :-)

> Signed-off-by: you -- otherwise I'll repost without both.

...

> > > +           if (!bitmap_equal(out, t->expected, t->nbits)) {
> > > +                   pr_err("bitmap_cut failed: expected %*pb, got %*pb\n",
> > > +                          t->nbits, t->expected, t->nbits, out);
> > > +           }
> >
> > Perhaps
> >
> >       if (bitmap_equal(...))
> >               continue;
> >
> >       ...
> >
> > ?
>
> That's five lines instead of four (I can't get pr_err() on one line
> anyway) and it looks less straightforward: "if it doesn't match we have
> an error" vs. "if it matches go to next case. We have an error". Any
> specific reason I'm missing?

Actually, please use one of suitable expect_eq_*() macro or add your
own. Because above has an inconsistent format with the rest.

-- 
With Best Regards,
Andy Shevchenko
