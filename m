Return-Path: <SRS0=dAmO=AZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5D56EC433E2
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:14:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 33DCD212CC
	for <linux-kernel@archiver.kernel.org>; Tue, 14 Jul 2020 20:14:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="signature verification failed" (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nokt7LIb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730334AbgGNUOz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 14 Jul 2020 16:14:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52246 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725955AbgGNUOz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 14 Jul 2020 16:14:55 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E4B59C061755
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:14:54 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id h17so8133613qvr.0
        for <linux-kernel@vger.kernel.org>; Tue, 14 Jul 2020 13:14:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=sender:from:date:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=silub4DOGA8GuQ3gUgAw0FDhfAcGw7RP0i5WpLCBKYo=;
        b=nokt7LIb/Ew2YURAQfbsivmX6H+mtWuJK6RlTiJEyK7e04lcnk+qTsKZ6emmGUm4pb
         6F/wPW+WuysZje9FSKTUrMXNErgkb6JfuXqDmQZLIKfdQV7sHy395iPzuGgh/qZ6FU07
         r5C5+lVKAuRzjPR0t7UbVzlNp9O8HQZoxjfQt7YxV15eZwYceAF9hISleK6640NyXJyY
         Bt0Ra4mqjwpcvgVxLhLAHqrNWZMWQcRjCmQDPlOgsSk/O/rYhlm2UsGkpV0CajgMJCvx
         A7rreqttsDuUqjxFr2n7MzklkjaOXod3rVN1W9yRAVitmh/nXMrLfDNuJOyLGmN4Zkpt
         g7Kg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:sender:from:date:to:cc:subject:message-id
         :references:mime-version:content-disposition:in-reply-to;
        bh=silub4DOGA8GuQ3gUgAw0FDhfAcGw7RP0i5WpLCBKYo=;
        b=oI6QerRDfbnBvu/kfZJ54kvjjlo0iTu5ELi/R4UzQcJ9h1vKac6c8g5Op3GmAe9lpY
         iBT30mm1TsOdI2WX+jddFJrEKn6ll5yADSF6jAM7PVOHCKvh6dlw3+zDbiNPMoxefCv+
         LjMMq8tjWYmszdweT2oQLOSMWssaTRuLdbGwo+T+6ryawSuYIl3Qso7V+F1mck/APBts
         PtNhPV85BlGtfiny1J8iDS3XybRxmhTLI7gUncOl2uk8qXMfmbgY5b0bCyuDil/nxwoJ
         Lm+S4DsvvGeVbycy6To/Pb+4x4pcTJuTTN6R41unzeOANg3mo3dihAvBjjmSi6gBDEVY
         fuYQ==
X-Gm-Message-State: AOAM530F80dBiG4vh9t1qDQ+ActxyU9QY6ja4Com/80T24LdyWLpguIR
        JxjUW/SGK4lKd8H9ixAzmYA=
X-Google-Smtp-Source: ABdhPJx7Z9ElEzluXjmqKA5T3K+cglH0cCNwReblW9eo0gpop9NPv7e4ibBfWzbdJ3DQlojakgXazw==
X-Received: by 2002:ad4:5307:: with SMTP id y7mr6471482qvr.63.1594757694088;
        Tue, 14 Jul 2020 13:14:54 -0700 (PDT)
Received: from rani.riverdale.lan ([2001:470:1f07:5f3::b55f])
        by smtp.gmail.com with ESMTPSA id h197sm24314615qke.51.2020.07.14.13.14.53
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 14 Jul 2020 13:14:53 -0700 (PDT)
From:   Arvind Sankar <nivedita@alum.mit.edu>
X-Google-Original-From: Arvind Sankar <arvind@rani.riverdale.lan>
Date:   Tue, 14 Jul 2020 16:14:51 -0400
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Arvind Sankar <nivedita@alum.mit.edu>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>, x86@kernel.org,
        Nick Desaulniers <ndesaulniers@google.com>,
        Fangrui Song <maskray@google.com>,
        Dmitry Golovin <dima@golovin.in>,
        Clang-Built-Linux ML <clang-built-linux@googlegroups.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Daniel Kiper <daniel.kiper@oracle.com>,
        Kees Cook <keescook@chromium.org>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "H . J . Lu" <hjl@sourceware.org>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 0/7] x86/boot: Remove runtime relocations from
 compressed kernel
Message-ID: <20200714201451.GA902932@rani.riverdale.lan>
References: <20200629140928.858507-1-nivedita@alum.mit.edu>
 <20200714023836.2310569-1-nivedita@alum.mit.edu>
 <CA+icZUXSPfybFtzQB3wKn9spQmEPnQu_iGPWkRisAmRQbJLWXA@mail.gmail.com>
 <20200714141550.GA329060@rani.riverdale.lan>
 <CA+icZUU88wYmyycthW7AQUZ72HGa9RWPZmxVS5Gm6UW=6ES9kA@mail.gmail.com>
 <CA+icZUWHdsk9+wkTZOdDghM7pRZyk2vHgxpYx62vPooqohzbYw@mail.gmail.com>
 <20200714192956.GA689174@rani.riverdale.lan>
 <CA+icZUXoZzhUMRsVVexazd=oFK4vKa1KJN5=_KXz+fcYxcA4Rw@mail.gmail.com>
 <20200714200728.GA894572@rani.riverdale.lan>
 <CA+icZUV9_ox9q+yANQQ-6X41fRb5K7mMn3NSh0_E9R1hO4oC4g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CA+icZUV9_ox9q+yANQQ-6X41fRb5K7mMn3NSh0_E9R1hO4oC4g@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 10:10:14PM +0200, Sedat Dilek wrote:
> On Tue, Jul 14, 2020 at 10:07 PM Arvind Sankar <nivedita@alum.mit.edu> wrote:
> >
> > On Tue, Jul 14, 2020 at 09:53:19PM +0200, Sedat Dilek wrote:
> > >
> > > Hmm, you might be right with moving to LDFLAGS_vmlinux.
> > >
> > > Attached are my linux-config and dmesg-output.
> > >
> > > - Sedat -
> >
> > Which tree are you building against? I notice you have KERNEL_ZSTD
> > enabled, which hasn't been merged yet.
> >
> > Are you using Nick's series [v7]?
> >
> > Also from the naming -- are you using LLVM_IAS=1 with some patches to
> > make it work?
> >
> > [v7] https://lore.kernel.org/lkml/20200708185024.2767937-1-nickrterrell@gmail.com/
> 
> Sorry for not telling you the full story.
> Yes, I have some additional patches like Nick T. "zstd-v7" which
> should IMHO not touch this area.
> 
> - Sedat -

That series does touch boot/compressed, since the point is to add
support for zstd-compressed kernels. I'll need to test it out, the
__DISABLE_EXPORTS he's now using must not be working for some reason.
