Return-Path: <SRS0=2JZx=64=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C651BC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 23:25:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 986242065D
	for <linux-kernel@archiver.kernel.org>; Thu, 14 May 2020 23:25:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=zx2c4.com header.i=@zx2c4.com header.b="eWAkImsQ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728030AbgENXZa (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 14 May 2020 19:25:30 -0400
Received: from mail.zx2c4.com ([192.95.5.64]:53061 "EHLO mail.zx2c4.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1726037AbgENXZ3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 May 2020 19:25:29 -0400
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTP id 3476cbec;
        Thu, 14 May 2020 23:11:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha1; c=relaxed; d=zx2c4.com; h=mime-version
        :references:in-reply-to:from:date:message-id:subject:to:cc
        :content-type; s=mail; bh=4zgiU9dnx9i8w6ld/C+6GY5/mWw=; b=eWAkIm
        sQ2Wot0vLDjssflFyKihccdVqZEYkMLSdO1EmFcf//zETz74GfbOcxF5nwO3cJ5O
        4tAtkOEoTnimRMezpqEdAU+MllzPJ6UoHzY/6nLXzF9Yuz03YYb0jFXzkPOEqx7a
        lP4ZDPbGSgqhHJ3scwAAIbY+OMY3btSaunLerubgqS54oYm8tZPKCMuaCTxBSoEH
        +yci+mer5HzA4f4iy21xk7bjE+qpYHbpVdrPtxximKncapF+FRcBHbamQESMs9j5
        mWHRBn1fXyEovPXDrmZ/IMjt3cAaFe41OEJrXz0gehQ73zjd6S6qN8FTH1DspGAS
        Yp4aNjss40d5u/8w==
Received: by mail.zx2c4.com (ZX2C4 Mail Server) with ESMTPSA id 83d998ed (TLSv1.3:TLS_AES_256_GCM_SHA384:256:NO);
        Thu, 14 May 2020 23:11:39 +0000 (UTC)
Received: by mail-io1-f53.google.com with SMTP id o5so665732iow.8;
        Thu, 14 May 2020 16:25:24 -0700 (PDT)
X-Gm-Message-State: AOAM533DHCba2bqPgkA0K3PhiifKoc8O7ZV9lP4JW66JEPD5bPVsnyVb
        JVEohcmG/JG3YPfzL7rt+sWzQ9kcMO0XUj8TKJ4=
X-Google-Smtp-Source: ABdhPJyEhc284v3d39Rbre2XkYfiAqngEPStmsmAOUBAmUVYL/c08WcJVJgiPw89VCSuVSHUKBRTGWcz7w8bztUH93Y=
X-Received: by 2002:a05:6602:2c45:: with SMTP id x5mr489271iov.80.1589498724137;
 Thu, 14 May 2020 16:25:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200514143055.1f71ba68@canb.auug.org.au> <CAHmME9osYhwzFEyGUELqSSNexgK56NJrOrWTi3vnyDft8tv-hw@mail.gmail.com>
 <3672488.1589458306@warthog.procyon.org.uk> <CAK7LNASMnHJi+42NUABD-FJQ1tTF2y6qaN=vcS9wEr11+7LVTg@mail.gmail.com>
In-Reply-To: <CAK7LNASMnHJi+42NUABD-FJQ1tTF2y6qaN=vcS9wEr11+7LVTg@mail.gmail.com>
From:   "Jason A. Donenfeld" <Jason@zx2c4.com>
Date:   Thu, 14 May 2020 17:25:13 -0600
X-Gmail-Original-Message-ID: <CAHmME9rhUJJc7ffG=pYHXSgaRXjUcic9RAvNgVqffuY15YP6Tw@mail.gmail.com>
Message-ID: <CAHmME9rhUJJc7ffG=pYHXSgaRXjUcic9RAvNgVqffuY15YP6Tw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the keys tree
To:     Masahiro Yamada <masahiroy@kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 14, 2020 at 6:35 AM Masahiro Yamada <masahiroy@kernel.org> wrote:
>
> On Thu, May 14, 2020 at 9:11 PM David Howells <dhowells@redhat.com> wrote:
> >
> > Jason A. Donenfeld <Jason@zx2c4.com> wrote:
> >
> > > Your touch might be helpful here. CRYPTO_LIB_CHACHA20POLY1305 is a
> > > tristate and depends on as well as selects other things that are
> > > tristates.
> > >
> > > Meanwhile BIG_KEYS is a bool, which needs to select
> > > CRYPTO_LIB_CHACHA20POLY1305. However, it gets antsy if the the symbol
> > > its selecting has =m items in its hierarchy.
> > >
> > > Any suggestions? The ideal thing to happen would be that the select of
> > > CRYPTO_LIB_CHACHA20POLY1305 in BIG_KEYS causes all of the descendants
> > > to become =y too.
> >
> > I think that select is broken in its behaviour - it doesn't propagate the
> > selection enforcement up the tree.  You could try changing it to a depends on
> > or you could put in a select for every dependency.
>
> I agree.
> 'depends on' will be cleaner.

That's fine, but also makes it more annoying for people to select
big_keys, and I don't know how David feels in that regard.

Seems like it'd be useful to have something that means "select X and
all the things X needs to not be broken", though satisfiability
problems like that can get really complicated quite fast.
