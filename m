Return-Path: <SRS0=4r1w=5T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 57F16C43331
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 22:25:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 22406206A3
	for <linux-kernel@archiver.kernel.org>; Fri,  3 Apr 2020 22:25:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BWV9P3Pn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728359AbgDCWZB (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 3 Apr 2020 18:25:01 -0400
Received: from mail-oi1-f195.google.com ([209.85.167.195]:46384 "EHLO
        mail-oi1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727842AbgDCWZB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Apr 2020 18:25:01 -0400
Received: by mail-oi1-f195.google.com with SMTP id q204so7544453oia.13
        for <linux-kernel@vger.kernel.org>; Fri, 03 Apr 2020 15:25:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to:user-agent;
        bh=p7vow1gEKBI2UbbyxyrLH2O5cwwOy+c2MDmXXEWJLcc=;
        b=BWV9P3Pn9zdrvUQwgl/y9TA98YDFMffrBHVwqBDamg1L9SBKgP6Fa/NtEKXr75kuaj
         0pCJOQOHMrKMcKQGAK8X5upFoCLj1oeZ/5lMvV8IFn5QtaFD8faxveSHscy08lcvSZPc
         3GCGGV8WOvi2LsYHhh4mE08DRZI6GogcZtS03AOjfn1Ip81OyZC6dNYLZirZTMM8Ks70
         7PD0Lz/oRv/7XaFZWm00D0DdHmGchDxeNAYGdxMNj4+kvHut2uTjT3IYH1NdEp6Bf2O5
         R2g+Gxa0Xkvi2Yio5nzfXnWWjOVVa+8+EEAa5eq3/xN1xwWLJpI+vV/a2/hmUhj9aqA5
         3t8Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=p7vow1gEKBI2UbbyxyrLH2O5cwwOy+c2MDmXXEWJLcc=;
        b=RiG80zvxAHZ19JrZnRbR6v0FdNfhsBGx3xsc8SllEdnV+ZPLXF/9nqN4JhBdNTpDUE
         ff16ZbNQnwm4wW7RERt0sL21FuJJSqeA2DFMa/cqqHAScGh7xChMTyjJisKRR27cLmEX
         +QRj4UKLBk1AIbEfeoxtETkXY5dk+BOhj0t72y8TOszBAfhhH61wLuy6Y1k5f/6bCd/v
         47v2oBcWstDVPYqOVXLQrXOT+XRcmU5wQYe+M119SkgemSVwz5QK8loJlnqAMyrBoAxR
         8yWNASeqyImtxjJXloXxW1OT3F4+qycQ2MxMAGplhYiCKB629VjaXzjPt/z66JBgb8Zc
         v0eg==
X-Gm-Message-State: AGi0PuaDW7RKeFKYNmPegTrWbjwT467FFHoAao6bk2fEb3FFbzXjHMnv
        nMGBaw8KYh9t8bHv3L8Zooc=
X-Google-Smtp-Source: APiQypLvAY8T+49fxKi8SmjQqTrmDevfxPOsH28f+q/zUwXN8W7biAYkeW8LRBnPCetAxh8d0lALzA==
X-Received: by 2002:aca:4c57:: with SMTP id z84mr4817143oia.53.1585952700642;
        Fri, 03 Apr 2020 15:25:00 -0700 (PDT)
Received: from ubuntu-m2-xlarge-x86 ([2604:1380:4111:8b00::1])
        by smtp.gmail.com with ESMTPSA id k132sm2547380oih.9.2020.04.03.15.24.59
        (version=TLS1_2 cipher=ECDHE-RSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 03 Apr 2020 15:25:00 -0700 (PDT)
Date:   Fri, 3 Apr 2020 15:24:58 -0700
From:   Nathan Chancellor <natechancellor@gmail.com>
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        Ilie Halip <ilie.halip@gmail.com>,
        Vincenzo Frascino <vincenzo.frascino@arm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] elfnote: mark all .note sections SHF_ALLOC
Message-ID: <20200403222458.GA49554@ubuntu-m2-xlarge-x86>
References: <20200325231250.99205-1-ndesaulniers@google.com>
 <CAKwvOdm8tQaa6BW7EQAz4TxFZETnJCS3z9isY4HvcU7UYqWZUA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKwvOdm8tQaa6BW7EQAz4TxFZETnJCS3z9isY4HvcU7UYqWZUA@mail.gmail.com>
User-Agent: Mutt/1.9.4 (2018-02-28)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 03, 2020 at 03:13:34PM -0700, 'Nick Desaulniers' via Clang Built Linux wrote:
> dropping Jeremy; I got bounceback from the email address. Ping for review?
> 
> On Wed, Mar 25, 2020 at 4:13 PM Nick Desaulniers
> <ndesaulniers@google.com> wrote:
> >
> > ELFNOTE_START allows callers to specify flags for .pushsection assembler
> > directives.  All callsites but ELF_NOTE use "a" for SHF_ALLOC. For
> > vdso's that explicitly use ELF_NOTE_START and BUILD_SALT, the same
> > section is specified twice after preprocessing, once with "a" flag, once
> > without. Example:
> >
> > .pushsection .note.Linux, "a", @note ;
> > .pushsection .note.Linux, "", @note ;
> >
> > While GNU as allows this ordering, it warns for the opposite ordering,
> > making these directives position dependent. We'd prefer not to precisely
> > match this behavior in Clang's integrated assembler.  Instead, the non
> > __ASSEMBLY__ definition of ELF_NOTE uses
> > __attribute__((section(".note.Linux"))) which is created with SHF_ALLOC,
> > so let's make the __ASSEMBLY__ definition of ELF_NOTE consistent with C
> > and just always use "a" flag.
> >
> > This allows Clang to assemble a working mainline (5.6) kernel via:
> > $ make CC=clang AS=clang
> >
> > Link: https://github.com/ClangBuiltLinux/linux/issues/913
> > Cc: Jeremy Fitzhardinge <jeremy@xensource.com>
> > Debugged-by: Ilie Halip <ilie.halip@gmail.com>
> > Signed-off-by: Nick Desaulniers <ndesaulniers@google.com>

Reviewed-by: Nathan Chancellor <natechancellor@gmail.com>

> > ---
> > Ilie has further treewide cleanups:
> > https://github.com/ihalip/linux/commits/elfnote
> > This patch is the simplest to move us forwards.
> >
> >  include/linux/elfnote.h | 2 +-
> >  1 file changed, 1 insertion(+), 1 deletion(-)
> >
> > diff --git a/include/linux/elfnote.h b/include/linux/elfnote.h
> > index 594d4e78654f..69b136e4dd2b 100644
> > --- a/include/linux/elfnote.h
> > +++ b/include/linux/elfnote.h
> > @@ -54,7 +54,7 @@
> >  .popsection                            ;
> >
> >  #define ELFNOTE(name, type, desc)              \
> > -       ELFNOTE_START(name, type, "")           \
> > +       ELFNOTE_START(name, type, "a")          \
> >                 desc                    ;       \
> >         ELFNOTE_END
> >
> > --
> > 2.26.0.rc2.310.g2932bb562d-goog
> >
> 
> 
> -- 
> Thanks,
> ~Nick Desaulniers
 
