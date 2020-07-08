Return-Path: <SRS0=/IhT=AT=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.7 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D08D5C433E0
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 14:44:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ABBDE20786
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Jul 2020 14:44:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="Th0XJc6W"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729888AbgGHOoB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Jul 2020 10:44:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729635AbgGHOoA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jul 2020 10:44:00 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83608C061A0B
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jul 2020 07:44:00 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id p20so50786769ejd.13
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jul 2020 07:44:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xb0I2RYd0Xq5lHyYzv75SJprFPpXAlY3yqWxTTq8ERk=;
        b=Th0XJc6W1FFDmfXlzq1ofFkJvJekBX7zuXGDikGiUjkBMOlogYquNwNS+vDbyRld8C
         LhmCCn8+R4L8aqvauTPdax14LGVHZlnRbxbFJUFk5kGwgekZ9TMHuaCW0xJelAITcZlc
         bTkGqQhrOc4opTVDlF0pxBjYG3sq0LPbVZdatyc9330fOkC85GWl8K2dSLV8Jpbs/9cp
         TsbZP+UEqSPgDclqmwmlP6MwPu3Lle6OFkH2akseeprKhD6GAEX1lQ89u9UnPvr3Meob
         D7JUXToS++1OjP0Y1tqs8PSm01a73keowt+TJ7L/kCHjHuia/yfaEqeyz1gDG4bd4zoY
         TpAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xb0I2RYd0Xq5lHyYzv75SJprFPpXAlY3yqWxTTq8ERk=;
        b=oMMEwWhwoSJFA3pJTN//wAOP9tSqBVEorNwYSaTHaIzAqISzVKOBf3xPfc0t3pWLnE
         iIGrKkcwqzib0p75oJUrVxa8bgK61OOKBoHESmam2t1loOf7rFw4iPkrstWM6iA3MGsZ
         ceHarAaggnVE8Di7XfvkhR694Jsq8mc1hIOlyyhFAgepuV5QhnfI8hckPi4DcX12b/9l
         7XyNqGDFn6IDqu5t624bWqeRP9ECVYeTWe3BNZQLy94Yx01AhNgJH1KdPdPV+z843XqU
         bxuQnrt2ECvgdRdGHE/jk1/u79F+FAarIPNQEYhNFIm6MdisJ8X/OiXM9C/cbWc3fFXQ
         EjPw==
X-Gm-Message-State: AOAM531YLOfjea6GtjKkEhUtfR2O9n4tvACFjcoiocgf63Dy7qbikYK1
        /kzxfouoLZe9+lfhyy2mc3475pKbpIddyi4XIQYBSw==
X-Google-Smtp-Source: ABdhPJw+kb55V3s0r2zHR9x2KWpKo58dCyUw71gkL9ZFxqoE83rgP6HV9RmtJmzsq9Lyp7rkyPUBX/xTtQTGt0qr+PM=
X-Received: by 2002:a17:906:1a54:: with SMTP id j20mr51228103ejf.455.1594219439236;
 Wed, 08 Jul 2020 07:43:59 -0700 (PDT)
MIME-Version: 1.0
References: <159419296487.2464622.863943877093636532.stgit@dwillia2-desk3.amr.corp.intel.com>
 <202007080108.454C937@keescook>
In-Reply-To: <202007080108.454C937@keescook>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Wed, 8 Jul 2020 07:43:48 -0700
Message-ID: <CAPcyv4hmsjKqKWhYYSyCx6fp9P_5GPr+XSVN5xFHxE6Ft2Q7fw@mail.gmail.com>
Subject: Re: [PATCH v2] CodingStyle: Inclusive Terminology
To:     Kees Cook <keescook@chromium.org>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        Randy Dunlap <rdunlap@infradead.org>,
        Dave Airlie <airlied@redhat.com>,
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

On Wed, Jul 8, 2020 at 1:22 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Wed, Jul 08, 2020 at 12:23:59AM -0700, Dan Williams wrote:
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
> > Signed-off-by: Chris Mason <clm@fb.com>
> > Signed-off-by: Greg Kroah-Hartman <gregkh@linuxfoundation.org>
> > Signed-off-by: Dan Williams <dan.j.williams@intel.com>
> > ---
> > Changes since v1 [1]
> > - Drop inclusive-terminology.rst, it is in the lore archives if the
> >   arguments are needed for future debates, but otherwise no pressing
> >   need to carry it in the tree (Linus, James)
> >
> > - Update the recommended terms to include replacement for 'master' and
> >   'whitelist' (Kees, Andy)
> >
> > - Add 'target' as a replacement (Andy)
> >
> > - Add 'device' as a replacement (Mark)
> >
> > - Collect acks and signed-off-bys. Yes, the sign-offs are not reflective
> >   of a submission chain, but I kept "Signed-off-by" if people offered
> >   it.
>
> In that case, I will "upgrade" my Ack. ;)
>
> Signed-off-by: Kees Cook <keescook@chromium.org>
>
> :)

Noted.

>
> > - Non-change: I did not add explicit language as to what to do with
> >   existing usages. My personal inclination is to prioritize this
> >   coding-style cleanup higher than others, but the coding-style document
> >   has typically not indicated policy on how cleanups are handled by
> >   subsystems. It will be a case by case effort and consideration.
>
> While I'd like to have published guidance on fixing existing language
> (which is already underway[1]), I agree: let's start here.
>
> > [...]
> > +For symbol names, avoid introducing new usage of 'master/slave' (or
>
> For symbol names, comments, documentation, and other language, avoid
> introducing ...

How about "symbol names and documentation" because I'm struggling to
think of an example of where this terminology would leak in outside
those broad categories.

> > +'slave' independent of 'master') and 'blacklist/whitelist'. Recommended
> > +replacements for 'master/slave' are: 'main/{secondary,subordinate}',
> > +'primary/replica', '{initiator,requester}/{target,responder}',
>
> the main and primary should be merged, IMO:
>
>         '{primary,main}/{secondary,replica,subordinate}'

Ok.

>
> > +'host/{device,proxy}', or 'leader/{performer,follower}'. Recommended
>
> leader/performer does not track for me. Split it out?
>
>         'leader/follower', 'director/performer'

Sounds good.

> I have also seen:
>
>         'controller/worker'

Will add.

Thanks Kees.
