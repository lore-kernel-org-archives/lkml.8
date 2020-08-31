Return-Path: <SRS0=8grS=CJ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-10.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5B385C433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 06:16:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3560920738
	for <linux-kernel@archiver.kernel.org>; Mon, 31 Aug 2020 06:16:13 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=sifive.com header.i=@sifive.com header.b="TALpIUmS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726687AbgHaGQC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 31 Aug 2020 02:16:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53394 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725848AbgHaGPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Aug 2020 02:15:50 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3377FC061755
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 23:15:49 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id e23so4402583otk.7
        for <linux-kernel@vger.kernel.org>; Sun, 30 Aug 2020 23:15:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=sifive.com; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3I5LujjeL7ILNQ6KrieN1i8IkA5pY4H5QUa+PdQ4xo0=;
        b=TALpIUmSCxI7Jz57R5opGXjDzPhTyBi2ccZqW6mkMTR9Lhw2WKffUsymErhXFASqja
         0m7Qo+5ZOr8mTAd1KfyJCF7vFwAv1pTGuWrWRRgAU46crjjMEMmRwCzX+Qp78EO6MkSI
         tg8u5OD7cc3yrJ5RLKJPeu1svFziTglA6HiLz/eCgszj13q26MYYRFvgswSjDVg5JzbC
         vpVAiKNs8klDevVbSoz3IR0jojJz8fuCw9sPjimwpwrbNYKDaZW/ky/ObnkVYkH1+Vu4
         VMmu9gD0XvTMnWjYQtp+6N+EKC019+CdpLmoQf+SZJQgapzramZamBYoB7+Z2rt1TNLG
         ARCw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3I5LujjeL7ILNQ6KrieN1i8IkA5pY4H5QUa+PdQ4xo0=;
        b=ppVuW6NBTdD65tVtdtgtocB/9ug8GLlswlZe7x8pRZ33x3qkT4b3peitcpoGb92Hx2
         ls6MZNyG+SAnMQgA9+6TTCwt8MrnNzq9bBFxpz41+6DaVnVq7Wb2dYlgP80QEVbYKJtT
         E7eVx3HRm8uMbK4yQOSQZ9lmQa4ABzQmykUAEEcBs/kRTyFxdEzYNXETkIcqTgAQ+nkk
         wrhvF8hgvFjjHfLXXx+4SmDs49EtZetwS4B0vOAMdm2yLk5v+v7e/w5pKMkVouXt2lXr
         n8NcPmZ3APwtPLp5abOwVEyG6wcJeurH0XztFp7779NVH39yh1MGXcgVefatN4VhhVb+
         R1XA==
X-Gm-Message-State: AOAM533S55sgq8YicowODYZQZKB80yKb99WqTjACVn5lp1E4ez02kBPy
        95WGguzdjxcNnBnWSFS+PCK/wDknD7lU5dDne17AzA==
X-Google-Smtp-Source: ABdhPJwX2YDWFxt6ejUMKcV0WG4NR1WX2+KgVIHXy4QQlll2wDglV/Uc3bKraQavw2X0aKcsmmwO8e8qxp3lnpN3Y9c=
X-Received: by 2002:a05:6830:1d94:: with SMTP id y20mr83892oti.129.1598854548582;
 Sun, 30 Aug 2020 23:15:48 -0700 (PDT)
MIME-Version: 1.0
References: <cover.1598598459.git.zong.li@sifive.com> <3f1f693147f0b62f19f4a44b8e8ef3d5bde23352.1598598459.git.zong.li@sifive.com>
 <CAOJsxLHOvvt8WGQUynGkLxZCA4OQQ+KgxxJJD7s_iP8Pxf-Omg@mail.gmail.com>
In-Reply-To: <CAOJsxLHOvvt8WGQUynGkLxZCA4OQQ+KgxxJJD7s_iP8Pxf-Omg@mail.gmail.com>
From:   Zong Li <zong.li@sifive.com>
Date:   Mon, 31 Aug 2020 14:15:38 +0800
Message-ID: <CANXhq0r2jg_fVZJE0shquGc25QNgenL+Qq6HRUBXEYPSf=QcFQ@mail.gmail.com>
Subject: Re: [PATCH v3 1/3] riscv: Set more data to cacheinfo
To:     Pekka Enberg <penberg@gmail.com>
Cc:     Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        David Abdurachmanov <david.abdurachmanov@sifive.com>,
        linux-riscv <linux-riscv@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 30, 2020 at 3:54 PM Pekka Enberg <penberg@gmail.com> wrote:
>
> Hi,
>
> On Fri, Aug 28, 2020 at 10:09 AM Zong Li <zong.li@sifive.com> wrote:
> >
> > Set cacheinfo.{size,sets,line_size} for each cache node, then we can
> > get these information from userland through auxiliary vector.
> >
> > Signed-off-by: Zong Li <zong.li@sifive.com>
> > ---
> >  arch/riscv/kernel/cacheinfo.c | 59 ++++++++++++++++++++++++++---------
> >  1 file changed, 44 insertions(+), 15 deletions(-)
> >
> > diff --git a/arch/riscv/kernel/cacheinfo.c b/arch/riscv/kernel/cacheinfo.c
> > index bd0f122965c3..8b85abfbd77a 100644
> > --- a/arch/riscv/kernel/cacheinfo.c
> > +++ b/arch/riscv/kernel/cacheinfo.c
> > @@ -25,12 +25,46 @@ cache_get_priv_group(struct cacheinfo *this_leaf)
> >         return NULL;
> >  }
> >
> > -static void ci_leaf_init(struct cacheinfo *this_leaf,
> > -                        struct device_node *node,
> > -                        enum cache_type type, unsigned int level)
> > +static void ci_leaf_init(struct cacheinfo *this_leaf, enum cache_type type,
> > +                        unsigned int level, unsigned int size,
> > +                        unsigned int sets, unsigned int line_size)
> >  {
> >         this_leaf->level = level;
> >         this_leaf->type = type;
> > +       this_leaf->size = size;
> > +       this_leaf->number_of_sets = sets;
> > +       this_leaf->coherency_line_size = line_size;
> > +
> > +       /*
> > +        * If the cache is fully associative, there is no need to
> > +        * check the other properties.
> > +        */
> > +       if (!(sets == 1) && (sets > 0 && size > 0 && line_size > 0))
>
> Can you explain what this is attempting to do? AFAICT, the if
> expression can be reduced to "sets > 1 && size > 0 && size > 0", but
> what do you mean with the comment about fully associative caches?

If the sets is one, it means that the cache is fully associative, then
we don't need to fill the ways number, just keep way number as zero,
so here we want to find the fully associative case first and make the
if expression fail at the beginning. We might also rewrite it as
follow:

/* Fully associative */
if (sets == 1)
    return;

/* n-ways associative, make sure all properties are big than zero, it
is meaningless when one of them are zero.  Full associative case is
filtered by the condition above, so we don't need to consider sets ==
1 again. */
if (sets > 0 && size > 0 && line_size >0)
    this_leaf->ways_of_associativity = (size / sets) / line_size;

>
> > +               this_leaf->ways_of_associativity = (size / sets) / line_size;
> > +}
