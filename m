Return-Path: <SRS0=kRID=5C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 52422C1975A
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:02:10 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 2C83920724
	for <linux-kernel@archiver.kernel.org>; Tue, 17 Mar 2020 22:02:10 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726988AbgCQWCJ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 17 Mar 2020 18:02:09 -0400
Received: from mail-oi1-f196.google.com ([209.85.167.196]:36178 "EHLO
        mail-oi1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726934AbgCQWCI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 Mar 2020 18:02:08 -0400
Received: by mail-oi1-f196.google.com with SMTP id k18so23591457oib.3
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 15:02:08 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ya5i9h9BDB0gF/4044yCkDpgVppUSZpZ2zck8bl6SA0=;
        b=QmYjnUPcDxvYRxj7vbmJYt+oc+xLi7TnR/p0KC8LlCCkCnfuyhVWDhk/Mo2NwJTruP
         jNzl5AEDGmzJsHMDYZPemHTbaK2j39iCb7SHL0Ml28F8mDSXyYZp66EU6ZH3x9vlCYFn
         uQGXaA3gDTvJ3i+CFQ3AisbS22uGBZAx7cch9HwdGyi05P/DnEEfQGVIgfjgXFHj1SuK
         diEbnbcVwok0HbVxSxwLgMVc+GMMoEiilDqK2vUv4ZVfBlNTzfxLlbb7DjmqiGgCu17s
         IazAwZbiRmcexFwbjL2rF9T8ar5neXg0+DpAq6Wwpm9D7jVSQK9vNdxQi0GqtL1E0uXX
         XIHQ==
X-Gm-Message-State: ANhLgQ17d0GgtILGytfVEOQOACPa2V2aRD7B9/QOUiKzLYS37oO3ydLz
        5XgSXnmLjOg5OCBFbkX5mOd8/awm
X-Google-Smtp-Source: ADFU+vsxDuTqjMCAsEYDHcrPvTvo4S/sp9twj6Q2+i3ThotxWouvuSLvxrjc39AH3M4l7/DnDm0vig==
X-Received: by 2002:a54:4e13:: with SMTP id a19mr868065oiy.108.1584482527353;
        Tue, 17 Mar 2020 15:02:07 -0700 (PDT)
Received: from mail-ot1-f45.google.com (mail-ot1-f45.google.com. [209.85.210.45])
        by smtp.gmail.com with ESMTPSA id a73sm1450422oib.16.2020.03.17.15.02.07
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 17 Mar 2020 15:02:07 -0700 (PDT)
Received: by mail-ot1-f45.google.com with SMTP id e19so2361035otj.7
        for <linux-kernel@vger.kernel.org>; Tue, 17 Mar 2020 15:02:07 -0700 (PDT)
X-Received: by 2002:a9d:7607:: with SMTP id k7mr1220783otl.205.1584482526826;
 Tue, 17 Mar 2020 15:02:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200312222827.17409-1-leoyang.li@nxp.com> <20200312222827.17409-7-leoyang.li@nxp.com>
 <b9c5a514-18c1-e36c-1595-2b86c9bfcff1@rasmusvillemoes.dk>
In-Reply-To: <b9c5a514-18c1-e36c-1595-2b86c9bfcff1@rasmusvillemoes.dk>
From:   Li Yang <leoyang.li@nxp.com>
Date:   Tue, 17 Mar 2020 17:01:55 -0500
X-Gmail-Original-Message-ID: <CADRPPNT2vRNU6uddqhqUcmyNVOpFbEUz+F5giCSfm9q5ZdYH5A@mail.gmail.com>
Message-ID: <CADRPPNT2vRNU6uddqhqUcmyNVOpFbEUz+F5giCSfm9q5ZdYH5A@mail.gmail.com>
Subject: Re: [PATCH 6/6] soc: fsl: qe: fix sparse warnings for ucc_slow.c
To:     Rasmus Villemoes <linux@rasmusvillemoes.dk>
Cc:     Timur Tabi <timur@kernel.org>, Zhao Qiang <qiang.zhao@nxp.com>,
        "moderated list:ARM/FREESCALE IMX / MXC ARM ARCHITECTURE" 
        <linux-arm-kernel@lists.infradead.org>,
        linuxppc-dev <linuxppc-dev@lists.ozlabs.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Mar 16, 2020 at 4:08 PM Rasmus Villemoes
<linux@rasmusvillemoes.dk> wrote:
>
> On 12/03/2020 23.28, Li Yang wrote:
> > Fixes the following sparse warnings:
> >
> [snip]
> >
> > Also removed the unneccessary clearing for kzalloc'ed structure.
>
> Please don't mix that in the same patch, do it in a preparatory patch.
> That makes reviewing much easier.

Thanks for the review.

One of the few lines removed are actually causing sparse warning,
that's why I changed this together with the sparse fixes.  I can add
all the lines removed in the log for better record.

>
> >
> >       /* Get PRAM base */
> >       uccs->us_pram_offset =
> > @@ -231,24 +224,24 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
> >               /* clear bd buffer */
> >               qe_iowrite32be(0, &bd->buf);
> >               /* set bd status and length */
> > -             qe_iowrite32be(0, (u32 *)bd);
> > +             qe_iowrite32be(0, (u32 __iomem *)bd);
>
> It's cleaner to do two qe_iowrite16be to &bd->status and &bd->length,
> that avoids the casting altogether.

It probably is cleaner, but also slower for the bd manipulation that
can be in the hot path.  The QE code has been using this way to
access/update the bd status and length together for a long time.  And
I remembered that it could help to prevent synchronization issues for
accessing status and length separately.

It is probably cleaner to change the data structure to use union for
accessing status and length together.  But that will need a big change
to update all the current users of the structure which I don't have
the time to do right now.

>
> >               bd++;
> >       }
> >       /* for last BD set Wrap bit */
> >       qe_iowrite32be(0, &bd->buf);
> > -     qe_iowrite32be(cpu_to_be32(T_W), (u32 *)bd);
> > +     qe_iowrite32be(T_W, (u32 __iomem *)bd);
>
> Yeah, and this is why. Who can actually keep track of where that bit
> ends up being set with that casting going on. Please use
> qe_iowrite16be() with an appropriately modified constant to the
> appropriate field instead of these games.
>
> And if the hardware doesn't support 16 bit writes, the definition of
> struct qe_bd is wrong and should have a single __be32 status_length
> field, with appropriate accessors defined.

Same comment as above.

>
> >       /* Init Rx bds */
> >       bd = uccs->rx_bd = qe_muram_addr(uccs->rx_base_offset);
> >       for (i = 0; i < us_info->rx_bd_ring_len - 1; i++) {
> >               /* set bd status and length */
> > -             qe_iowrite32be(0, (u32 *)bd);
> > +             qe_iowrite32be(0, (u32 __iomem *)bd);
>
> Same.
>
> >               /* clear bd buffer */
> >               qe_iowrite32be(0, &bd->buf);
> >               bd++;
> >       }
> >       /* for last BD set Wrap bit */
> > -     qe_iowrite32be(cpu_to_be32(R_W), (u32 *)bd);
> > +     qe_iowrite32be(R_W, (u32 __iomem *)bd);
>
> Same.
>
> >       qe_iowrite32be(0, &bd->buf);
> >
> >       /* Set GUMR (For more details see the hardware spec.). */
> > @@ -273,8 +266,8 @@ int ucc_slow_init(struct ucc_slow_info * us_info, struct ucc_slow_private ** ucc
> >       qe_iowrite32be(gumr, &us_regs->gumr_h);
> >
> >       /* gumr_l */
> > -     gumr = us_info->tdcr | us_info->rdcr | us_info->tenc | us_info->renc |
> > -             us_info->diag | us_info->mode;
> > +     gumr = (u32)us_info->tdcr | (u32)us_info->rdcr | (u32)us_info->tenc |
> > +            (u32)us_info->renc | (u32)us_info->diag | (u32)us_info->mode;
>
> Are the tdcr, rdcr, tenc, renc fields actually set anywhere (the same
> for the diag and mode, but word-grepping for those give way too many
> false positives)? They seem to be a somewhat pointless split out of the
> bitfields of gumr_l, and not populated anywhere?. That's not directly
> related to this patch, of course, but getting rid of them first (if they
> are indeed completely unused) might make the sparse cleanup a little
> simpler.

I would agree with you that is not neccessary to create different enum
types for these bits in the same register in the first place.  But I
would like to prevent aggressive cleanups of this driver for old
hardware that is becoming harder and harder to be thoroughly tested
right now.  These fields are probably not used by the in tree ucc_uart
driver right now.  But as a generic library for QE, I think it is
harmless to keep these simple code there for potentially customized
version of the uart driver or other ucc slow drivers.

Regards,
Leo
