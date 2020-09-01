Return-Path: <SRS0=b2Mh=CK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-12.1 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 29CB9C433E7
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 23:54:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 02E6320707
	for <linux-kernel@archiver.kernel.org>; Tue,  1 Sep 2020 23:54:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uz93oa+c"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726380AbgIAXyZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 1 Sep 2020 19:54:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47318 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726174AbgIAXyV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Sep 2020 19:54:21 -0400
Received: from mail-pg1-x544.google.com (mail-pg1-x544.google.com [IPv6:2607:f8b0:4864:20::544])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 830FEC061246
        for <linux-kernel@vger.kernel.org>; Tue,  1 Sep 2020 16:54:21 -0700 (PDT)
Received: by mail-pg1-x544.google.com with SMTP id e33so1587940pgm.0
        for <linux-kernel@vger.kernel.org>; Tue, 01 Sep 2020 16:54:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vr/GRpBoEYmMuCS63slKe/6FyD7UiqC7EOcVZHXrpYc=;
        b=uz93oa+cmzW9oTnATL428U6pMu17BMVfzmaMjK4fk6Pr50aa1EJBroz8GVphFXX1DC
         xakDt5YXF7xxpRdVUQJBBYUnHHokCsCzD409wTF48swCZaPGPBw8N/Eu1/iDvX+LwOHT
         /ZV87MKvTEGAyHhk5QguI3zXGk7KdqaDBxsVyNc8bquF02gR+FcCUuQtoqaAmY6eF1Ox
         YST9d4Rsw5ptQHBz/JbuP6UFlPBmOqzGa3RDnTuZedLKppgnemVaQeUSGg4TKX9/guQd
         sqjqZBf0mJY9HM1qcuiWhfcK+8/e7DJnSmsSSRZVq1yEjOyQ8y0mqq/E3jnqnuv8Tnfv
         itdA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vr/GRpBoEYmMuCS63slKe/6FyD7UiqC7EOcVZHXrpYc=;
        b=BjQoMn0uwb228pG+7FyWdfw0N38D65uTE2/PLeahxtOEhVldZqKACu8d1T0sXKcmqx
         kHm+zKU8TNV8QqXNxo4O+K5+6u9SHNnLjNqsAiNwz+Mt/7h0Y0BdPSaJoI05abG29psH
         nFVqGdcpoRvjH0r7/1bouXNqVcpcZfLI2X0i9EbmAUho39jgIAKDO7+j7ULOQIrVz5fU
         OB+FaXJOmTepyUyzOW4zNs7yPiVz3i4jt2oXbwEqEg2EPXw2zUWS3HC53A1cO24FX7ya
         To2N7IoGtb6o0Tnjj7vef+XSlDFlh9eAlaUKWUE98+D31eBstn6OvTUMI9oR9+tSW4sm
         3HMA==
X-Gm-Message-State: AOAM531SbGg85qv7/CI5/VfaqhR2dsSty7O6v/JUN2WUOzFByxhV1yRX
        5aAjTprmkVZVxas3EEM0c2GaiaL+/gTiJ1JjZH4cqw==
X-Google-Smtp-Source: ABdhPJxTACSixKp/ZU9Zg50XGHk3ByA89yXDEzS29Y6IrN6+Y6W0mcsXbJ1k3kHy2PmcQKLZUI3aPxQZ5rHcknTWv7M=
X-Received: by 2002:a62:19cd:: with SMTP id 196mr621969pfz.143.1599004460212;
 Tue, 01 Sep 2020 16:54:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200821194310.3089815-1-keescook@chromium.org>
 <202008311240.9F94A39@keescook> <20200901071133.GA3577996@gmail.com>
 <20200901075937.GA3602433@gmail.com> <20200901081647.GB3602433@gmail.com>
 <202009010816.80F4692@keescook> <CAKwvOdnn3wxYdJomvnveyD_njwRku3fABWT_bS92duihhywLJQ@mail.gmail.com>
 <202009011616.E6DC7D54EF@keescook>
In-Reply-To: <202009011616.E6DC7D54EF@keescook>
From:   Nick Desaulniers <ndesaulniers@google.com>
Date:   Tue, 1 Sep 2020 16:54:08 -0700
Message-ID: <CAKwvOdnDMvECAhKcTVEqcgM9QAUX05Gj27q7fZCbudANX-GWDg@mail.gmail.com>
Subject: Re: [PATCH v6 00/29] Warn on orphan section placement
To:     Kees Cook <keescook@chromium.org>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Masahiro Yamada <masahiroy@kernel.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@suse.de>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Ard Biesheuvel <ardb@kernel.org>,
        Peter Collingbourne <pcc@google.com>,
        James Morse <james.morse@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Russell King <linux@armlinux.org.uk>,
        Arvind Sankar <nivedita@alum.mit.edu>,
        Nathan Chancellor <natechancellor@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>,
        linux-arch <linux-arch@vger.kernel.org>,
        linux-efi <linux-efi@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 1, 2020 at 4:18 PM Kees Cook <keescook@chromium.org> wrote:
>
> On Tue, Sep 01, 2020 at 11:02:02AM -0700, Nick Desaulniers wrote:
> > Uh oh, the ppc vdso uses cc-ldoption which was removed! (I think by
> > me; let me send patches)  How is that not an error?  Yes, guilty,
> > officer.
> > commit 055efab3120b ("kbuild: drop support for cc-ldoption").
> > Did I not know how to use grep, or?  No, it is
> > commit f2af201002a8 ("powerpc/build: vdso linker warning for orphan sections")
> > that is wrong.
>
> Eek, yeah, the vdso needs fixing; whoops. Lucky for my series, I only need
> ld-option! ;)
>

I didn't cc everyone here on that thread, but here's the series I sent
for it: https://lore.kernel.org/lkml/20200901222523.1941988-1-ndesaulniers@google.com/T/#u
.
-- 
Thanks,
~Nick Desaulniers
