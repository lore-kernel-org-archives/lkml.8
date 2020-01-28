Return-Path: <SRS0=OrIQ=3R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A6051C35246
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 09:31:11 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7DE4D24688
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jan 2020 09:31:11 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=benyossef-com.20150623.gappssmtp.com header.i=@benyossef-com.20150623.gappssmtp.com header.b="sKfibvDG"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725988AbgA1JbJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 28 Jan 2020 04:31:09 -0500
Received: from mail-vs1-f68.google.com ([209.85.217.68]:37496 "EHLO
        mail-vs1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725880AbgA1JbI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jan 2020 04:31:08 -0500
Received: by mail-vs1-f68.google.com with SMTP id x18so7645319vsq.4
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jan 2020 01:31:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=benyossef-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=drtFf4BYqD16KtABSK9GXNjl2syyckGlTVrDm3GnTCM=;
        b=sKfibvDGOGsQEi8+DU56KeTpeAqC6oMr2xZa51isMZyqL3h5FmoUB4gAOKzWFxBhz3
         KOdDZBEJ8xNxwGwPU+oOyS7zsccP5/K/gsw/oPig30OKQkDizpEBFwGx/f2oSBwD5Q0m
         0Irwc7cDuUtmQf1byT/PmmPMH5UrVXt0BaFsUDCdEFUiulf/b94FyJb4yE5MV36g9cfh
         6UtVr3UbZI5HgqkKC0mA1UTZA2DTNpKdsbVqsAHnLoQlkYFdF1FQeKJBEzhaeUJgsUhd
         Y72Sto6VKJ9dLhyj1LPsxny83/6I1VNgsFzZzT2ZyZVyVBHxfAcnoN5j5DT6cDjLfCGu
         UW6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=drtFf4BYqD16KtABSK9GXNjl2syyckGlTVrDm3GnTCM=;
        b=VU3J0sAtkkOH1DHZQWpAQf3Zt+5clSQSbWYzooIrCzqF3Xha9UmvU0V1gim15RYWlx
         00g7aP1WCkTKmEmwQIqzccTQmWdnmWQ9MMYCoe8QVcrtwHoTWMYGY64IUyDO1ikLzGwb
         /WfNZgvp+cSDcmRvQcoc8/kValrmRNFelXACnxvkiu1LKraHzbywapbyqUKe2baI96fz
         BRgo+wATdqYogUrAXuYGsn9e8TJuTrjHeeGwv+37DnBizBi2N2LHBuryJVdOfIrfq8my
         OFQeSG01xKqhKvzcKDFr8OvzYhd0//mY4TIJRbtcpF9rz+mIpjHWC8vtSKalnLcSGCg3
         mLhA==
X-Gm-Message-State: APjAAAWmAfLAXP+ghisXlIPGwNVsCctZyZwEFTFJYb5s5ILUfVaurYZ6
        sYVcXMAvOFiBsV6PBJc/ck2bzFn5GKTTZ0q6DclUcQ==
X-Google-Smtp-Source: APXvYqxA5k/EGtUP6+d0kpO1feBId8g2JtzAgi/OYJYmYTvogHvW3SfxtiVoopXd9Oyp80KBxIM2MM57ebbafrpjpsQ=
X-Received: by 2002:a67:c90d:: with SMTP id w13mr12308705vsk.164.1580203867395;
 Tue, 28 Jan 2020 01:31:07 -0800 (PST)
MIME-Version: 1.0
References: <20200127150822.12126-1-gilad@benyossef.com> <CAMuHMdVFcsS9K=7+LfT_Tmmpz4LMS69=+EO+8_BkJoXCOfPzPA@mail.gmail.com>
 <20200128030107.GF960@sol.localdomain> <CAMuHMdWjUoHrqLqUV9F4LfRfSOxBoFONxjH=2HYMFfjf6cSZ6A@mail.gmail.com>
In-Reply-To: <CAMuHMdWjUoHrqLqUV9F4LfRfSOxBoFONxjH=2HYMFfjf6cSZ6A@mail.gmail.com>
From:   Gilad Ben-Yossef <gilad@benyossef.com>
Date:   Tue, 28 Jan 2020 11:30:54 +0200
Message-ID: <CAOtvUMeHiLUoRqOHWFfx=bZMjCEra2o3UbBa0baoB_ec_0ihhw@mail.gmail.com>
Subject: Re: [RFC v3] crypto: ccree - protect against short scatterlists
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Eric Biggers <ebiggers@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        Ofir Drang <ofir.drang@arm.com>,
        Linux Crypto Mailing List <linux-crypto@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 28, 2020 at 10:30 AM Geert Uytterhoeven
<geert@linux-m68k.org> wrote:
>
> Hi Eric,
>
> On Tue, Jan 28, 2020 at 4:01 AM Eric Biggers <ebiggers@kernel.org> wrote:
> > On Mon, Jan 27, 2020 at 04:22:53PM +0100, Geert Uytterhoeven wrote:
> > > On Mon, Jan 27, 2020 at 4:08 PM Gilad Ben-Yossef <gilad@benyossef.com> wrote:
> > > > Deal gracefully with the event of being handed a scatterlist
> > > > which is shorter than expected.
> > > >
> > > > This mitigates a crash in some cases due to
> > > > attempt to map empty (but not NULL) scatterlists with none
> > > > zero lengths.
> > > >
> > > > Signed-off-by: Gilad Ben-Yossef <gilad@benyossef.com>
> > > > Reported-by: Geert Uytterhoeven <geert@linux-m68k.org>
> > >
> > > Thank you, boots fine on Salvator-XS with R-Car H3ES2.0, and
> > > CONFIG_CRYPTO_MANAGER_DISABLE_TESTS=y.
> > >
> > > Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
> >
> > Note that you need to *unset* CONFIG_CRYPTO_MANAGER_DISABLE_TESTS to enable the
> > self-tests.
>
> Sorry, that's what I meant (too used to type "=y" to enable something ;-)
>
> > So to run the full tests, the following is needed:
> >
> > # CONFIG_CRYPTO_MANAGER_DISABLE_TESTS is not set
>
> With just this, it no longer crashes.
>
> > CONFIG_CRYPTO_MANAGER_EXTRA_TESTS=y
>
> With the extra tests enabled, it still crashes :-(
>

That's fine - this is the second issue I was talking about.
The patch I sent before was not really a fix - more a stop gap
designed to see if I understand the issue you are seeing.

I will send out a patch fixing the root cause of both and this should
resolve both issues.
I just want to run it through some internal tests to make sure it did
not break something else first.

Thanks!
Gilad
