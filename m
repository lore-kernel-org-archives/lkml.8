Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AA919C433DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:12:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 834C3206DF
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 07:12:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="j0BlwJ+u"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730106AbgGHHMR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 03:12:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726292AbgGHHMQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 03:12:16 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CBB3C061755
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 00:12:16 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id dp18so49226289ejc.8
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 00:12:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kdsNHpxkoZR0fNVD9KrCnenPHEfoVj8EUtIv2TOWsWM=;
        b=j0BlwJ+uXyhLTpoVaN9qRQHNt/ExEKP8IoksaMZqa2G/4XGDzEBG5CZ1XP1Hg7T47g
         UD3XFVWzblYT5t/ms/jZ/kOSQDXI062J4zcoI12zRT7aKk05gmg3mBK/5uwnG4gOmOY+
         JQ1UGkqzSM9SWpLf/7bMNZL0JSG2St4X/qH93fSqqcwVUBhXtKiHJnGZ76C775HY3BKP
         ExyyJaWhSRs3DVhVUlCRJOXBM4ACpFKinoaruMVhQcrWFHvuHiXDEsLtWEOrd3087JhD
         kQQphm2hwLoHiTGTDO85/ZMqrHirIr8UGk6TnfJLnAZEr7oPnJJXSQkIzcmYgFyGv879
         eomA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kdsNHpxkoZR0fNVD9KrCnenPHEfoVj8EUtIv2TOWsWM=;
        b=Yp5xTBFX3rPDJgZnGLfqiEJwK14GceZyTgrRok5ySybEOgj4hzBy95s5v8svZnaUrz
         hoKV5b9KNDcmu2Y/PdNeAp8Sspn+/EKUhqMwN3zT6vRk/YlNeM+Q5ofnorb3fVQUsIa4
         Noyy0E/5KNVGWIeqUtcFPOcldF+IG08umfACOFw1DN0FpUUkscmqa0sM9gVinrto97xg
         rbo4nPX+As8Rt6dTRSooFhDCNXhB8VCPNtQnbtueVw1nZW+DeLIKoilbViR9b+NBbHAP
         lkvBq/YnUyAxg++anbo6at+lXYiOtjsEfX4+hc0HGlL4p38qM7QK0FrB32EPq+7Uys/H
         dd7Q==
X-Gm-Message-State: AOAM533khDNkqbAAHryWhWMkizDvC+g56tlIl3HeHEW9MAigRRcqXtpk
        Ck2IqDqqHNLRgTQ5VJBFx9lCyKkO9H6S16JYFcYq/g==
X-Google-Smtp-Source: ABdhPJwTblcoIWxEvyJM9MnbL5UwKKNnULlprxGqQYwvDI3+GFPGWhnQgZuUdY2+rUS7JmbetQhGNgiTigGaAcnTS+0=
X-Received: by 2002:a17:906:6d56:: with SMTP id a22mr52231269ejt.440.1594192335322;
 Wed, 08 Jul 2020 00:12:15 -0700 (PDT)
MIME-Version: 1.0
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200707065612.8239-1-sjpark@amazon.com>
In-Reply-To: <20200707065612.8239-1-sjpark@amazon.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 8 Jul 2020 00:12:03 -0700
Message-ID: <CAPcyv4ggm50tMnaCtMZJRz0j6ZO15buNUmTfk4sLf3AYkxS12w@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
To:     SeongJae Park <sjpark@amazon.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org,
        Chris Mason <clm@fb.clm>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 11:56 PM SeongJae Park <sjpark@amazon.com> wrote:
>
> Hello,
>
> On Sat, 04 Jul 2020 13:02:51 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
>
> > Recent events have prompted a Linux position statement on inclusive
> > terminology. Given that Linux maintains a coding-style and its own
> > idiomatic set of terminology here is a proposal to answer the call to
> > replace non-inclusive terminology.
>
> I'm glad to see this patch.
>
> >
> > Cc: Jonathan Corbet <corbet@lwn.net>
> > Cc: Kees Cook <keescook@chromium.org>
> > Signed-off-by: Chris Mason <clm@fb.clm>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
>
> Acked-by: SeongJae Park <sjpark@amazon.de>
>
> > ---
> >  Documentation/process/coding-style.rst          |   12 ++++
> >  Documentation/process/inclusive-terminology.rst |   64 +++++++++++++++++++++++
> >  Documentation/process/index.rst                 |    1
> >  3 files changed, 77 insertions(+)
> >  create mode 100644 Documentation/process/inclusive-terminology.rst
> >
> > diff --git a/Documentation/process/coding-style.rst b/Documentation/process/coding-style.rst
> > index 2657a55c6f12..4b15ab671089 100644
> > --- a/Documentation/process/coding-style.rst
> > +++ b/Documentation/process/coding-style.rst
> > @@ -319,6 +319,18 @@ If you are afraid to mix up your local variable names, you have another
> >  problem, which is called the function-growth-hormone-imbalance syndrome.
> >  See chapter 6 (Functions).
> >
> > +For symbol names, avoid introducing new usage of the words 'slave' and
> > +'blacklist'. Recommended replacements for 'slave' are: 'secondary',
> > +'subordinate', 'replica', 'responder', 'follower', 'proxy', or
> > +'performer'.  Recommended replacements for blacklist are: 'blocklist' or
> > +'denylist'.
>
> I have submitted a couple of patches for automated encouragement of the the
> inclusive terms and those merged in the -next tree[1,2] now.  Nonetheless, the
> version says only "please consider using 'denylist' and 'allowlist' instead of
> 'blacklist' and 'whitelist'" for now.  I think we could add more terms in there
> based on this discussion.  I could do that after this patch is merged, or you
> could do that yourself in the next spin of this patch.  Please do whatever you
> feel comfort.
>
> [1] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=7d0bea01dec27195d95d929c1ee49a4a74dd6671
> [2] https://git.kernel.org/pub/scm/linux/kernel/git/next/linux-next.git/commit/?id=95a94258ceb27052f00b7e51588a128d20bf05ed
>

Thank you for stepping up to take this on, much appreciated.

I think I'll leave it to you to fixup checkpatch after the final
version of this patch is merged. It may be as simple as "See section 4
'Naming' in coding-style for suggested replacements".
