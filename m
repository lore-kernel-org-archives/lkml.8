Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 10CA2C433E4
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:14:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD8C82075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 00:14:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="GZgsINVj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727115AbgHTAOI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 19 Aug 2020 20:14:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728721AbgHTAOA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Aug 2020 20:14:00 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 38313C061383
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 17:14:00 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id y6so205949plt.3
        for <linux-kernel@vger.kernel.org>; Wed, 19 Aug 2020 17:14:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=fSEYrX5ACCj62ngKp36MmVum7AWiPuR/R+X34o+7xuE=;
        b=GZgsINVjA/iPVwpqT/wdawM2LvRnSYS0j70GlPgoxgV9M4sanwWBFOsmDMGbuAVIRa
         fInE81nFqMhoKq8aeK2wXF23ckv+8mvNAsIAMNsaEXyznMXVLd+MFeyWTryUYHfbHhoL
         kS9sYMtCAKiqoxBbxYxGEpzZdonBKqbwUdIwbuasbQS/1Reg518ZvopiGNEAOnVxezPZ
         0fc1L1znuoVPGemAh7QXesW7icu7VBfCaj9yWLu28K5Ix0mIvzQPh6O3AT9pCabC9Qlt
         bd32bNMb1gX+jDIWkWEa7SXABnbuMe2PsEgAvpvtqbTRKy6kOBIF4TCyzYtrGbZrqAki
         rq8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=fSEYrX5ACCj62ngKp36MmVum7AWiPuR/R+X34o+7xuE=;
        b=AoZsqWxKccKreyCfRWbjz4yjb1YaYbp63kSO7vh1NQu77DDvYhPRCVf5LFIGAu0L9B
         9dK0MddhmoSdQVE6ngDo80DEaB6WJN0zaL9DUF+8eSzMMnt510n90lqeNrYACiGC4enf
         4dLGevI8tf30MrUyacBpUsA5GqMt8L0DXs25p3jOgk1FhzYAngmwLTNy4k3Tk1HJTEcg
         GplRGTTnQQBY8ktoZptlIMJ0aIbM6ke3jL/mE7+LUrZxaQReU2WkxBHdn/y6ziCH/jc0
         HEQqgkdA/PLgA7uGmAlBItXP2OMts4LmDEXpCSd6nfz4G3rPRnVNzExEHPrzQS0SAOD6
         ev6w==
X-Gm-Message-State: AOAM533H8GFqSOf1+JeeJ1x5VSZl4fRkGrXoDh606MiPe515Y5ECNb8n
        h0xBx/wBcFiVl+vEgJF0mEPU94mU1w3r0hVvgrQkgA==
X-Google-Smtp-Source: ABdhPJzl6F5E2iWMKn+8J0GL89vR8SvenD67R1x0TWLjRLW3Uw/3w3cewKL6RgzutABpZ4MtNfBH5ztYpmF9l9LEG8A=
X-Received: by 2002:a17:90a:a10c:: with SMTP id s12mr340778pjp.32.1597882439098;
 Wed, 19 Aug 2020 17:13:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200730205112.2099429-1-ndesaulniers@google.com>
 <20200730205112.2099429-3-ndesaulniers@google.com> <CAN=-Rxty=Ux5rj-VQSZH-ryj1RiNJvy7mRE7uyx_YAndGtcq7Q@mail.gmail.com>
 <CAKwvOdkNLK2cRfY+DA0u3KuY5PuEss5Qox6X3zzpL053pARfrA@mail.gmail.com>
In-Reply-To: <CAKwvOdkNLK2cRfY+DA0u3KuY5PuEss5Qox6X3zzpL053pARfrA@mail.gmail.com>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Wed, 19 Aug 2020 17:13:47 -0700
Message-ID: <CAKwvOdnDyUw7TZ-ZsWQ=d7ZNPM_ziFnimmbYoVAexWmg2DL36A@mail.gmail.com>
Subject: Re: [PATCH 2/4] ARM: backtrace-clang: add fixup for lr dereference
To:     Nathan Huckleberry <nhuck15@gmail.com>
Cc:     Russell King <linux@armlinux.org.uk>,
        Andrew Morton <akpm@linux-foundation.org>,
        Chunyan Zhang <zhang.lyra@gmail.com>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Dmitry Safonov <0x7f454c46@gmail.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mediatek@lists.infradead.org,
        Lvqiang Huang <lvqiang.huang@unisoc.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        Miles Chen <miles.chen@mediatek.com>,
        "# 3.4.x" <stable@vger.kernel.org>,
        Nathan Huckleberry <nhuck@google.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 3:33 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> On Thu, Aug 6, 2020 at 3:39 PM Nathan Huckleberry <nhuck15@gmail.com> wrote:
> >
> > Mostly looks good to me. Just a minor nit.
> >
> > On Thu, Jul 30, 2020 at 3:51 PM Nick Desaulniers
> > <ndesaulniers@google.com> wrote:
> > > +/*
> > > + * Accessing the address pointed to by the link register triggered an
> > > + * exception, don't try to unwind through it.
> > > + */
> > > +bad_lr:                mov     sv_fp, #0
> >
> > It might be nice to emit a warning here since we'll
> > only hit this case if something fishy is going on
> > with the saved lr.
>
> Yeah, something fishy is going on if that ever happens.  Let me create
> a V2 with an additional print.

FWIW, I ran into another bug on -next when trying to update this.

Report:
https://lore.kernel.org/lkml/20200811204729.1116341-1-ndesaulniers@google.com/
Fix:
https://lore.kernel.org/lkml/20200814212525.6118-1-john.ogness@linutronix.de/T/#t

Then I got bogged down in planning for plumbers and other fires. I
hope to revisit the series after plumbers.
-- 
Thanks,
~Nick Desaulniers
