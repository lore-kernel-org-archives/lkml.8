Return-Path: <SRS0=1j9/=3N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6554C2D0DB
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:05:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B61102072C
	for <linux-kernel@archiver.kernel.org>; Fri, 24 Jan 2020 17:05:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="McZaGI6v"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730380AbgAXRFj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 24 Jan 2020 12:05:39 -0500
Received: from mail-pf1-f194.google.com ([209.85.210.194]:37164 "EHLO
        mail-pf1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726454AbgAXRFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jan 2020 12:05:39 -0500
Received: by mail-pf1-f194.google.com with SMTP id p14so1415830pfn.4
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jan 2020 09:05:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OkgBXD4HoXPiY/eoWfExnajwU8sKoQVfDOiDrJRorLo=;
        b=McZaGI6vyq1BWIQC6oi0i4XR1wu9ZgLauYAINexyUbPdvtYF5zHeiukPw0Vg6kpZj/
         ZB1lFF+v2Y30ZdT3HV6KN8gYssTjoZRAHyEeFlmW8BZT0Y2x9j6HAU8a2sTQ945qFXym
         SbVlXsD4jyKsMHc08K1Vi2b1qaxxC9njRxvSruGCLOTCYZvK32BkKYEN3Mv11i2Y1MO5
         yOmC1V5bcTh/mHyn9W+qRzAReSaoJpZXWkEhxqaGNiBbiqMRJChcs7l+AQE0BR7xnKLd
         J36Ol2u2ZqJth00o0Y1sOZHe3K7OsOD+2Fl5Lg9f4b0o4+okVVsUI2uxTtvkB+el7xQQ
         555A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OkgBXD4HoXPiY/eoWfExnajwU8sKoQVfDOiDrJRorLo=;
        b=NfhVugyMWcLD+F6vKEChKcY/9Ua7g5mtRv2De56J5SIWfGQ5F82A18wbKX1cKNBjXp
         X6W6V/NB+T1gBKN+a1SRKll6jAnBNvVBnbjsx9cqtE0nJgQdq4JPS2GZa8T59oJJ7UmJ
         nSIstBmy4ymL1+z+VTYQ5JIagc1fssRSVRsqHqGKCZTN+2pCxc5CxN/6bAiBfYcpjK4l
         f479+JFeF8nwNrRN16Yphvdck1MdQ9utXRQj5CS1z08shQJ7UXT0LsNybcWByrwYPr9m
         awp2efKZQdDatKn33PFojpn33ZU8VFDcmCVaCUIl5oJRlhwaZJKitEwTLfkgEZibJY6d
         5JvQ==
X-Gm-Message-State: APjAAAW5Z+W41GfEAiA+QIpht7cPDsHsu/y5kUopZ58YpFLT1RVpMwEk
        dGi0X7F1N5LCuF9M1oS3Bdu11lyXg8SS1l3cuUKvkw==
X-Google-Smtp-Source: APXvYqzgkx6QXwnBzvxRHKvAZa1GjV9zApqlw7PX8mk9SON/0IorTfzK9SaNo/bIyx9KtPnlmJz/q3pUOkhUvFVoxx8=
X-Received: by 2002:aa7:946a:: with SMTP id t10mr4146497pfq.165.1579885538456;
 Fri, 24 Jan 2020 09:05:38 -0800 (PST)
MIME-Version: 1.0
References: <20200123153341.19947-1-will@kernel.org> <20200123153341.19947-10-will@kernel.org>
 <CAKwvOd=Bp+FWXHUKZnk+_dN=jTYZGdc_QVhErC3N-Frpk4mssQ@mail.gmail.com> <20200124082637.GZ14914@hirez.programming.kicks-ass.net>
In-Reply-To: <20200124082637.GZ14914@hirez.programming.kicks-ass.net>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Fri, 24 Jan 2020 09:05:27 -0800
Message-ID: <CAKwvOdmFMnCgr3rP5vNkj_H1SnBJ6drdBP1RSGxzfYzSiWGfLg@mail.gmail.com>
Subject: Re: [PATCH v2 09/10] compiler/gcc: Raise minimum GCC version for
 kernel builds to 4.8
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Will Deacon <will@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        kernel-team <kernel-team@android.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Segher Boessenkool <segher@kernel.crashing.org>,
        Christian Borntraeger <borntraeger@de.ibm.com>,
        Luc Van Oostenryck <luc.vanoostenryck@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Peter Oberparleiter <oberpar@linux.ibm.com>,
        Masahiro Yamada <masahiroy@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 24, 2020 at 12:26 AM Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Thu, Jan 23, 2020 at 10:36:37AM -0800, Nick Desaulniers wrote:
> > On Thu, Jan 23, 2020 at 7:34 AM Will Deacon <will@kernel.org> wrote:
> > >
> > > It is very rare to see versions of GCC prior to 4.8 being used to build
> > > the mainline kernel. These old compilers are also know to have codegen
> > > issues which can lead to silent miscompilation:
> > >
> > > https://gcc.gnu.org/bugzilla/show_bug.cgi?id=58145
> > >
> > > Raise the minimum GCC version for kernel build to 4.8 and remove some
> > > tautological Kconfig dependencies as a consequence.
> > >
> > > Cc: Nick Desaulniers <ndesaulniers@google.com>
> >
> > Thanks for the patch.
> > Reviewed-by: Nick Desaulniers <ndesaulniers@google.com>
> > I wouldn't mind if this patch preceded the earlier one in the series
> > adding the warning, should the series require a v2 and if folks are
> > generally ok with bumping the min version.
>
> If I hadn't actually read your reply, I would have never spotted that
> reviewed-by tag, hidden in a blob of text like that.
>
> Adding some whitespace before and after, such that it stands out a
> little more, might avoid such issues.

Ack. Do maintainers have tools for fetching patch series and
automating collecting Reviewed-by tags, or is it all extremely manual?

-- 
Thanks,
~Nick Desaulniers
