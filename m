Return-Path: <SRS0=4zup=3T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 31D00C2D0DB
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:51:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 03955214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Jan 2020 19:51:18 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=chromium.org header.i=@chromium.org header.b="QQLpki6M"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727553AbgA3TvR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Jan 2020 14:51:17 -0500
Received: from mail-pl1-f193.google.com ([209.85.214.193]:45792 "EHLO
        mail-pl1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726267AbgA3TvQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jan 2020 14:51:16 -0500
Received: by mail-pl1-f193.google.com with SMTP id b22so1729038pls.12
        for <linux-kernel@vger.kernel.org>; Thu, 30 Jan 2020 11:51:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=TwjNbXymeOMhcl0LSyYVyfzACL3qLvRJ0ybZ68hQvaU=;
        b=QQLpki6MkN8PIxiN6Hz8Og58+QkkAVx/FfxeMuJaKICMKQuTkLkt08YKUjO15mTgvW
         hT8KtRFTuu+a8GmAzda75+NlKxKvclPjN3i/aw4X+euWpL9P3ov30l3ZXOz+C5WjpQeN
         Zi9eBmiT92RN3SglclboI4ukVWG4/oZyVf9oA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=TwjNbXymeOMhcl0LSyYVyfzACL3qLvRJ0ybZ68hQvaU=;
        b=W/bXqKCutv1hfVjddO14Hb+D3Qlqk7A1a4DqyPq8ZemUMZBbC5FwvZGY1Q2yBgAP43
         30jvvNU52Vil5RYJgFHgtKiqrUDVc/DGgaPldhNORH99Og3RM9FthngnM4bXIHYyPmD6
         dRdn+EYAz0NedRoDwQOWW/QvDD8XAkfN20DPHLWzaFsftabAw9mc9kdaJEXajJWuUBB9
         Mm+lRj+69HmGPHmDgcv85fzrkwEDxWoJeUeLtC2DdnjBRUZk5nfxjwJM3Q+bcpYUGtHW
         uvKD/qi77ViRJU7mhlNkTJ/tCvc5LOwz2JmV3lxPmIU4rMjLue3rIaTKc7ZhkYE6T7Fv
         j+JA==
X-Gm-Message-State: APjAAAUcFL/qR1Pz6sZqmX/PzSpi4mU697NH9LL9KnVOm7NUjqFHKPcY
        iDNZ0KQ+hQkhfGb1FvVgI0yrwA==
X-Google-Smtp-Source: APXvYqyhZuBuM2JGIWbCuMKd3tbNfRB9JWW1Pu8fptM7xp5ka5K5iK/17eLFumqFV2Di2UQVog+Fgw==
X-Received: by 2002:a17:902:9a8f:: with SMTP id w15mr6630467plp.30.1580413875978;
        Thu, 30 Jan 2020 11:51:15 -0800 (PST)
Received: from www.outflux.net (smtp.outflux.net. [198.145.64.163])
        by smtp.gmail.com with ESMTPSA id 2sm7197678pgo.79.2020.01.30.11.51.14
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Jan 2020 11:51:15 -0800 (PST)
Date:   Thu, 30 Jan 2020 11:51:14 -0800
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
Subject: Re: [PATCH 2/2] x86: Discard .note.gnu.property sections in vmlinux
Message-ID: <202001301143.288B55DCC1@keescook>
References: <20200124181819.4840-1-hjl.tools@gmail.com>
 <20200124181819.4840-3-hjl.tools@gmail.com>
 <202001271531.B9ACE2A@keescook>
 <CAMe9rOrVyzvaTyURc4RJJTHUXGG6uAC9KyQomxQFzWzrAN4nrg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMe9rOrVyzvaTyURc4RJJTHUXGG6uAC9KyQomxQFzWzrAN4nrg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 30, 2020 at 09:51:38AM -0800, H.J. Lu wrote:
> On Mon, Jan 27, 2020 at 3:34 PM Kees Cook <keescook@chromium.org> wrote:
> >
> > On Fri, Jan 24, 2020 at 10:18:19AM -0800, H.J. Lu wrote:
> > > With the command-line option, -mx86-used-note=yes, the x86 assembler
> > > in binutils 2.32 and above generates a program property note in a note
> > > section, .note.gnu.property, to encode used x86 ISAs and features.
> > > But x86 kernel linker script only contains a signle NOTE segment:
> > >
> > > PHDRS {
> > >  text PT_LOAD FLAGS(5);
> > >  data PT_LOAD FLAGS(6);
> > >  percpu PT_LOAD FLAGS(6);
> > >  init PT_LOAD FLAGS(7);
> > >  note PT_NOTE FLAGS(0);
> > > }
> > > SECTIONS
> > > {
> > > ...
> > >  .notes : AT(ADDR(.notes) - 0xffffffff80000000) { __start_notes = .; KEEP(*(.not
> > > e.*)) __stop_notes = .; } :text :note
> > > ...
> > > }
> > >
> > > which may not be incompatible with note.gnu.property sections.  Since

I don't understand this. "may not be incompatible"? Is there an error
generated? If so, what does it look like?

> > > note.gnu.property section in kernel image is unused, this patch discards
> > > .note.gnu.property sections in kernel linker script by adding
> > >
> > >  /DISCARD/ : {
> > >   *(.note.gnu.property)
> > >  }
> >
> > I think this is happening in the wrong place? Shouldn't this be in the
> > DISCARDS macro in include/asm-generic/vmlinux.lds.h instead?
> 
> Please read my commit message closely.   We can't discard .note.gnu.property
> sections by adding .note.gnu.property to default discarded sections
> since default
> discarded sections are placed AFTER .notes sections in x86 kernel
> linker scripts.

I see what you mean now, /DISCARD/ happens after the NOTES macro (now in
the RO_DATA macro). To this end, I think this should be in
include/asm-generic/vmlinux.lds.h in the NOTES macro? It's x86-specific
right now, but why not make this future-proof?

I'd like to avoid as much arch-specific linker stuff as we can. I spent
a lot of time trying to clean up NOTES specifically. :)

> +	/* .note.gnu.property sections should be discarded */

This comment should say _why_ -- the script already shows _what_ is
happening...

> +	/DISCARD/ : {
> +		*(.note.gnu.property)
> +	}

-Kees

-- 
Kees Cook
