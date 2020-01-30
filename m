Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 88121C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:45:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B63F20707
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:45:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="kQYeNRAt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727370AbgA3Tpw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:45:52 -0500
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46686 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgA3Tpw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 14:45:52 -0500
Received: by mail-oi1-f195.google.com with SMTP id a22so4780700oid.13
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 11:45:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f8hZFGlLTOiZ14sFBn3OoXEqPA4HMonB7kti9m+30ek=;
        b=kQYeNRAte3gfs+B1GcxxRLsm18wbhTvcvWKv4aCz1QfYnlEDTwoguGxiFIRZc2mNx9
         zQTENXdC6pQuujM+vpIhvUGRK9iVQzTm6/uZCXdtDTat8BUMiCef9iIbJGOHSXEMlLe9
         bPhKT9Pfxon8xOQXFPv3C/HACOWB5r72vn/zlMx0oAxcTo5RQlHvx3kot9HXnpju5Qvt
         t6oi3q7tl+UjJO8qcJGbSfLo43Q9e4dq7AkeAGfnBHaIKwgV/nLIJhclkZzW8UvgUwgz
         zXmRmC6d4O5977s7wva+dv9yB8KG+cjOjetr4pKnIF6XYz4GnmnfejHRGncGxzerGqy1
         aiMQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f8hZFGlLTOiZ14sFBn3OoXEqPA4HMonB7kti9m+30ek=;
        b=e1wKKmTy9K2HIK1fBVrEdBLsaE/GqV3gPWrMNvav8drmneP+wpcIoOZ/bceDF6IP6r
         Dbfs6bZxJSmZIfajR1iuLJbwCkdjO+SeuEjwPEsIK06ItATH2S7chFTLnObIyFK/I+cx
         NHy8CIq5ufjRstfA7QNn4havWfVNxYOI4UPeNW2bVhUP+0mOj+pOMUckQIc1IZnrRCLO
         JyHelgTWgBPui0RQYIgWNvPgXGJya/CUPq/i3YhPI65Yb2pHt656ns0MqGH01w0YlopV
         BamnpNyKAo6wgKTTh2OUq+ymk+AR+tV4jx3f9OYfEU9axYhDNETGuU7CJWGGMfHD+w44
         ld8Q==
X-Gm-Message-State: APjAAAU6eHb4w1jTXnEJSGJ7vNmGD8DSaDEQiR875eKCAX7u7xMEsC5r
        kfdPcTyhmxoNjAIQMmkXeDJkeeIZs/TKyKKQaaM=
X-Google-Smtp-Source: APXvYqxUTAVCmHWVNgGoJYg+JG6p0r0nHd6FarDU9z3SPuwFG6bWMLdVShopzAMgfZNfCYfn4h5xt5LqHPwi5+9ORac=
X-Received: by 2002:aca:4dca:: with SMTP id a193mr3996208oib.156.1580413551278;
 Thu, 30 Jan 2020 11:45:51 -0800 (PST)
MIME-Version: 1.0
References: <20200130180048.2901-1-hjl.tools@gmail.com> <202001301139.F8859A4@keescook>
In-Reply-To: <202001301139.F8859A4@keescook>
From:   "H.J. Lu" <hjl.tools@gmail.com>
Date:   Thu, 30 Jan 2020 11:45:15 -0800
Message-ID: <CAMe9rOrrrZFWgVpsKAWjHKzVh3ZziFLs2ua0m0Ewymrjs-b+EA@mail.gmail.com>
Subject: Re: [PATCH] x86: Don't discard .exit.text and .exit.data at link-time
To:     Kees Cook <keescook@chromium.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 11:40 AM Kees Cook <keescook@chromium.org> wrote:
>
> On Thu, Jan 30, 2020 at 10:00:48AM -0800, H.J. Lu wrote:
> > Since .exit.text and .exit.data sections are discarded at runtime, we
> > should undefine EXIT_TEXT and EXIT_DATA to exclude .exit.text and
> > .exit.data sections from default discarded sections.
>
> This is just a correctness fix, yes? The EXIT_TEXT and EXIT_DATA were
> already included before the /DISCARD/ section here, so there's no
> behavioral change with this patch, correct?

That is correct.  I was confused by EXIT_TEXT and EXIT_DATA in generic
DISCARDS.   My patch just makes it more explicit.

> -Kees
>
> >
> > Signed-off-by: H.J. Lu <hjl.tools@gmail.com>
> > ---
> >  arch/x86/kernel/vmlinux.lds.S | 6 ++++++
> >  1 file changed, 6 insertions(+)
> >
> > diff --git a/arch/x86/kernel/vmlinux.lds.S b/arch/x86/kernel/vmlinux.lds.S
> > index d1b942365d27..fb2c45cb1d1f 100644
> > --- a/arch/x86/kernel/vmlinux.lds.S
> > +++ b/arch/x86/kernel/vmlinux.lds.S
> > @@ -416,6 +416,12 @@ SECTIONS
> >       STABS_DEBUG
> >       DWARF_DEBUG
> >
> > +     /* Sections to be discarded.  EXIT_TEXT and EXIT_DATA discard at runtime.
> > +      * not link time.  */
> > +#undef EXIT_TEXT
> > +#define EXIT_TEXT
> > +#undef EXIT_DATA
> > +#define EXIT_DATA
> >       DISCARDS
> >       /DISCARD/ : {
> >               *(.eh_frame)
> > --
> > 2.24.1
> >
>
> --
> Kees Cook



-- 
H.J.
