Return-Path: <SRS0=F+sq=6U=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.7 required=3.0 tests=HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A1107C28CBC
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:55:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 895412073A
	for <linux-kernel@archiver.kernel.org>; Wed,  6 May 2020 06:55:54 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728229AbgEFGzx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 6 May 2020 02:55:53 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:39342 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727984AbgEFGzx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 May 2020 02:55:53 -0400
Received: by mail-oi1-f195.google.com with SMTP id b18so849721oic.6
        for <linux-kernel@vger.kernel.org>; Tue, 05 May 2020 23:55:52 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=bgUSLoJuM5DPVh+NQpkVplTKRIpBSrk34ApBf+33zi8=;
        b=Wg+I2+Z1n2g7iAQx1GSUePUp6LQC4fuEsjkzn7+lTUVugSNJwOJEFg7GOPetCZrPUQ
         TVXdZCclyO6d5UauIevhkwW71hfvORXDxP4OzBvpcVplQEusOD7GjM9E62jMg9YrNBru
         cZEWPsSTm5l16sxA2Mgsg965gXfwdYVsfi4o0dW5GWnNj0SB4FPxSOIlolnam6AUskJZ
         g9mx34G1gyMdJFwySd921+EUFJ8rmCiW4Zl2UF+Aj3HhlWqFgx+WduYROcd6wLa9nkni
         zfcsS9cAJlTd4XTxIhtvxNm0yJdtYwn0bOOWALDEPJGLkXNVlDK9KwCYV3Kucpt05upW
         9xgQ==
X-Gm-Message-State: AGi0PuZWI/xyRcqTHCS9eOaLoiNAEnvb5Zis52Hw1/iAgo3+brcZabeT
        nIoFBTsLoicpcHVVy1ijPhiQAJbCd9aMDSjW+t0=
X-Google-Smtp-Source: APiQypJwJNgj7OfGOU+Mf5StigPAciWs5ltb9Ib23PqaY7Paii3TFN7Z0SO0uIYr3zR/uUMdbjRkdNnprd/qWs/UOWU=
X-Received: by 2002:aca:895:: with SMTP id 143mr1592485oii.153.1588748152304;
 Tue, 05 May 2020 23:55:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200505132613.17452-1-geert+renesas@glider.be> <20200505121805.cb29ea992ec3e3b445f4b707@linux-foundation.org>
In-Reply-To: <20200505121805.cb29ea992ec3e3b445f4b707@linux-foundation.org>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 6 May 2020 08:55:40 +0200
Message-ID: <CAMuHMdU4mfEMi+XfXGSG5_deNtD50e7mTz6s89=5en=N-nn_9Q@mail.gmail.com>
Subject: Re: [PATCH v2] checkpatch: use patch subject when reading from stdin
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Geert Uytterhoeven <geert+renesas@glider.be>,
        Andy Whitcroft <apw@canonical.com>,
        Joe Perches <joe@perches.com>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        "users@linux.kernel.org" <users@linux.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andrew,

On Tue, May 5, 2020 at 9:18 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> On Tue,  5 May 2020 15:26:13 +0200 Geert Uytterhoeven <geert+renesas@glider.be> wrote:
> > While "git am" can apply an mbox file containing multiple patches (e.g.
> > as created by b4[1], or a patch bundle downloaded from patchwork),
> > checkpatch does not have proper support for that.  When operating on an
> > mbox, checkpatch will merge all detected tags, and complain falsely
> > about duplicates:
> >
> >     WARNING: Duplicate signature
> >
> > As modifying checkpatch to reset state in between each patch is a lot of
> > work, a simple solution is splitting the mbox into individual patches,
> > and invoking checkpatch for each of them.  Fortunately checkpatch can read
> > a patch from stdin, so the classic "formail" tool can be used to split
> > the mbox, and pipe all individual patches to checkpatch:
> >
> >     formail -s scripts/checkpatch.pl < my-mbox
> >
> > However, when reading a patch file from standard input, checkpatch calls
> > it "Your patch", and reports its state as:
> >
> >     Your patch has style problems, please review.
> >
> > or:
> >
> >     Your patch has no obvious style problems and is ready for submission.
>
> Showing the proposed "after patch" output would be helpful.  It seems
> that it will be
>
>         "checkpatch: use patch subject when reading from stdin" has no obvious style problems and is ready for submission.
>
> yes?

Almost right:

"[PATCH v2] checkpatch: use patch subject when reading from stdin" has
no obvious style problems and is ready for submission.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
