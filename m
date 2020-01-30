Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E93D9C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:58:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BA8E220708
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:58:59 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QqLDILrz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727380AbgA3T67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:58:59 -0500
Received: from mail-pl1-f194.google.com ([209.85.214.194]:39446 "EHLO
        mail-pl1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726514AbgA3T66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 14:58:58 -0500
Received: by mail-pl1-f194.google.com with SMTP id g6so1750435plp.6
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 11:58:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=nuZRnP6UqnW4avEUhneKXXkjHvfMUjP2ZDJ4PulKqqQ=;
        b=QqLDILrzrhQk+7d3tEZQHCNfh+FgnoPCqnnfyZ7DeZznVwiXusJzis6+VLINE1hN0P
         /AGEsrrTjBuoRzINldutvYP5QLCEswfHSegkRH6YydXhaAUruANy2BrMrWt+vdIePY19
         HOdHlKxtN7qTuNhdcy91xrxibM0jj8PZHvhbM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nuZRnP6UqnW4avEUhneKXXkjHvfMUjP2ZDJ4PulKqqQ=;
        b=joiVdRfx1eI+IxOvdGdVmhql+8e/FWuNPDAVcYn1T17tLc4ZfkDVVfW94p0g5rgvxZ
         L5ikPBuGFaxyHc92T6O2Jkd0IQ3idD4AnM6LgoILolXHUiMrjQRxVAe3kyLnwaS+7eqB
         BISmbvBkYb10QvbD0H/zxaq7V+H/f7DO872x88GhGfunTuGkzJ1WjhbD3UUkWAqsFGBl
         ndsHfJFIxy1iCy5tQZYqWY/ClJxxxwBcbKDhUQ6eYueQ5Xn2bPYmgC9ZL5enEf4PBxuC
         7z3S9is/1L/7XXIF3eVsZCKK+NV65SWvuF2+Lh3GEd5atOJys+U2Qgf03t6DW76m0HvI
         /cHg==
X-Gm-Message-State: APjAAAUyFfBWWC/Ez6U87mxlxcTZEFjoqJ+BqIyQZWTPjXypMJZxEWBD
        aLU3YDGvZ1ZgLjCTAoAuTQ6eAw==
X-Google-Smtp-Source: APXvYqzrB3EsH2ErCz1lmdRkG7rlqSY6t2HUgiywFLiVgkuvylRNh0x/Wk+74zjZpqYgVHOKQgf1SQ==
X-Received: by 2002:a17:90a:d34c:: with SMTP id i12mr7865690pjx.18.1580414336488;
        Thu, 30 Jan 2020 11:58:56 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id y75sm7830321pfb.116.2020.01.30.11.58.55
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 11:58:55 -0800 (PST)
Date:   Thu, 30 Jan 2020 11:58:54 -0800
From:   Kees Cook <keescook@chromium.org>
To:     "H.J. Lu" <hjl.tools@gmail.com>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Andy Lutomirski <luto@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Thomas Lendacky <Thomas.Lendacky@amd.com>,
        Sami Tolvanen <samitolvanen@google.com>,
        Heiko Carstens <heiko.carstens@de.ibm.com>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H . Peter Anvin" <hpa@zytor.com>,
        the arch/x86 maintainers <x86@kernel.org>,
        Yu-cheng Yu <yu-cheng.yu@intel.com>
Subject: Re: [PATCH] x86: Don't discard .exit.text and .exit.data at link-time
Message-ID: <202001301152.DF108B6CC@keescook>
References: <20200130180048.2901-1-hjl.tools@gmail.com>
 <202001301139.F8859A4@keescook>
 <CAMe9rOrrrZFWgVpsKAWjHKzVh3ZziFLs2ua0m0Ewymrjs-b+EA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMe9rOrrrZFWgVpsKAWjHKzVh3ZziFLs2ua0m0Ewymrjs-b+EA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 11:45:15AM -0800, H.J. Lu wrote:
> On Thu, Jan 30, 2020 at 11:40 AM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Thu, Jan 30, 2020 at 10:00:48AM -0800, H.J. Lu wrote:
> > > Since .exit.text and .exit.data sections are discarded at runtime, we
> > > should undefine EXIT_TEXT and EXIT_DATA to exclude .exit.text and
> > > .exit.data sections from default discarded sections.
> >
> > This is just a correctness fix, yes? The EXIT_TEXT and EXIT_DATA were
> > already included before the /DISCARD/ section here, so there's no
> > behavioral change with this patch, correct?
> 
> That is correct.  I was confused by EXIT_TEXT and EXIT_DATA in generic
> DISCARDS.   My patch just makes it more explicit.

Okay, so to that end and because this isn't arch-specific, I'd like to
see this be a behavioral flag, and then the generic DISCARDS macro can
be adjusted. This lets all architectures implement this without having
to scatter undef/define lines in each arch.

Something like this:

diff --git a/include/asm-generic/vmlinux.lds.h b/include/asm-generic/vmlinux.lds.h
index e00f41aa8ec4..f242d3b4814d 100644
--- a/include/asm-generic/vmlinux.lds.h
+++ b/include/asm-generic/vmlinux.lds.h
@@ -894,11 +894,17 @@
  * section definitions so that such archs put those in earlier section
  * definitions.
  */
-#define DISCARDS							\
-	/DISCARD/ : {							\
+#ifdef RUNTIME_DISCARD_EXIT
+#define EXIT_DISCARDS
+#else
+#define EXIT_DISCARDS							\
 	EXIT_TEXT							\
 	EXIT_DATA							\
-	EXIT_CALL							\
+	EXIT_CALL
+#endif
+#define DISCARDS							\
+	/DISCARD/ : {							\
+	EXIT_DISCARDS							\
 	*(.discard)							\
 	*(.discard.*)							\
 	*(.modinfo)							\

Then x86 and all other architectures that do this can just use
#define RUNTIME_DISCARD_EXIT
at the top (like EMITS_PT_NOTE, etc).

-Kees

> > > --- a/arch/x86/kernel/vmlinux.lds.S
> > > +++ b/arch/x86/kernel/vmlinux.lds.S
> > > @@ -416,6 +416,12 @@ SECTIONS
> > >       STABS_DEBUG
> > >       DWARF_DEBUG
> > >
> > > +     /* Sections to be discarded.  EXIT_TEXT and EXIT_DATA discard at runtime.
> > > +      * not link time.  */
> > > +#undef EXIT_TEXT
> > > +#define EXIT_TEXT
> > > +#undef EXIT_DATA
> > > +#define EXIT_DATA
> > >       DISCARDS
> > >       /DISCARD/ : {
> > >               *(.eh_frame)

-- 
Kees Cook
