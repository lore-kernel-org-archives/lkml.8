Return-Path: <SRS0=gItQ=AO=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-7.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5C128C433DF
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:19:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2C2DD20836
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Jul 2020 09:19:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="MMNER+Jt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726616AbgGCJT5 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Jul 2020 05:19:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52068 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725796AbgGCJT5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Jul 2020 05:19:57 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3E0CEC08C5C1
        for <linux-kernel@vger.kernel.org>; Fri,  3 Jul 2020 02:19:57 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id 72so26250500otc.3
        for <linux-kernel@vger.kernel.org>; Fri, 03 Jul 2020 02:19:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=POSpsbTYYz1lTAOeuc7RHl8+ok2djC1/r4JffXq6xMY=;
        b=MMNER+JtA7FMAsMGC2/ws5PfqUn71jdqaX+6+hnhRxJtDnAtGWsqmXuhN6jmK+qHOH
         5OXxGL7mFU57/m6qHqFTyZL4Ne8Gl58RrhkfH0xXlmm1kah60OZgvUG0oZuihiPeA152
         ObjYEGTHWMXrQYJXdMydkcJK2HKSPYNts9ohiBW3MLNwvAPgnC4a2EkFVK3HJC4X4Gdo
         wcgzKYb52awe5C5jeHB/zA1/SeyUH7lUO+NIhQmAD4WPi899C/dVi61up+C7rZD0s8gP
         PAbviafe/w2Ig56lPho8Rzlc1q3mfuLWKPcwyN5P3U1UBfoziKKhqCMlIwAVVk2/82Wb
         wYxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=POSpsbTYYz1lTAOeuc7RHl8+ok2djC1/r4JffXq6xMY=;
        b=Ydtsk4CLz83DeNJ9bUWU1ZZA0nW53dE3jfCAD8z/eexRV0PjlGYeGbh2WoKetDBBzj
         BCFITImTO9GKjsKdktcbqXzpnWypvSACaDLWQKnNXrx4U44LrnwtdQBEz+2qAezT5bjc
         0jW6a+bgCBI2LvXJe/PR+m45iI0iE7y4Q7x9Zdkn6/QGoVN68vd7qxscFbTQ6rxpVqU0
         Od4x/DMhKYFDoD7YGqscUL5PEb79mBgk7C7GWlXeigyY0om6KC4T/bugtKb8683JfW1j
         s50NbX+ADAqYlHX73Xn4R4k0wAusmX5yy6U527dAB1O/cw5jDIgB7fT1iXPwDMZ4GEQe
         kOjA==
X-Gm-Message-State: AOAM532MLaLb8F+1vUppOLNTcl8uUs3jX+UzR+2Hwa5k/s2KAofWYY0J
        tKmW2N+W/D8FJYc165A2o4mKaqzVDFZ2aoBV1ZEfQg==
X-Google-Smtp-Source: ABdhPJwxkrXCcPDmweM4l1uFBEBVxyuKF+fbqKhEc6mAlh7QzUquzVrqoolh+uCYSPygJil3jQdxZ178z+58Ew25dxU=
X-Received: by 2002:a9d:3a36:: with SMTP id j51mr30860818otc.129.1593767996603;
 Fri, 03 Jul 2020 02:19:56 -0700 (PDT)
MIME-Version: 1.0
References: <050476a0ee608046569588936394159d650ab535.1593763492.git.zong.li@sifive.com>
 <80902e5d0d5ef752e71672e9c5794d0f5f9ccd15.camel@perches.com>
In-Reply-To: <80902e5d0d5ef752e71672e9c5794d0f5f9ccd15.camel@perches.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Fri, 3 Jul 2020 17:19:47 +0800
Message-ID: <CANXhq0p8S_n_yGQrrEJ5HBHcnbPZh+dNfTrtL2Kuepf8mtkn=g@mail.gmail.com>
Subject: Re: [PATCH] scripts/Lindent: increase the maximum line length to 100
To:     Joe Perches <joe@perches.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        "linux-kernel@vger.kernel.org List" <linux-kernel@vger.kernel.org>,
        Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 4:51 PM Joe Perches <joe@perches.com> wrote:
>
> On Fri, 2020-07-03 at 16:08 +0800, Zong Li wrote:
> > As the patch 'bdc48fa11e46 ("checkpatch/coding-style: deprecate
> > 80-column warning")', increase the default limit to 100 characters,
> > we also increase the maximum line length to 100 for indent script.
>
> I'd prefer to delete Lindent instead.
>
> Also any reformatting tool like this will
> _always_ use up to whatever the maximum
> line length is rather than use a preferred
> length of 80 and and only use the allowed
> maximum length of 100 when necessary for
> human readability.
>

Yes, as you mentioned, the reformatting tool uses up to the maximum line length,
it seems to me that we don't go this patch if you plan to post the
patch to delete it,
otherwise, we could consider to change it to 100.

> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  scripts/Lindent | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/scripts/Lindent b/scripts/Lindent
> > index 1688c44c2df6..11f14a4f2048 100755
> > --- a/scripts/Lindent
> > +++ b/scripts/Lindent
> > @@ -1,7 +1,7 @@
> >  #!/bin/sh
> >  # SPDX-License-Identifier: GPL-2.0
> >
> > -PARAM="-npro -kr -i8 -ts8 -sob -l80 -ss -ncs -cp1"
> > +PARAM="-npro -kr -i8 -ts8 -sob -l100 -ss -ncs -cp1"
> >
> >  RES=`indent --version | cut -d' ' -f3`
> >  if [ "$RES" = "" ]; then
>
