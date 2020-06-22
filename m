Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7EDF0C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5615E20767
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 20:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="PwPu1Itn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730495AbgFVUG3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 16:06:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53196 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728683AbgFVUG0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 16:06:26 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2725C061573;
        Mon, 22 Jun 2020 13:06:25 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id t74so10384706lff.2;
        Mon, 22 Jun 2020 13:06:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8ErtUVrdJpAbz3pd9Rfcv2rTfSjq1rTMRt5MW6xhVzE=;
        b=PwPu1Itn22Czcra35Wl9y+HPNG5b6dE6oFFiVLBWzfkauq+K01m5h9jAeD8zkFbNHx
         6k6K2m6bgqrqYG3UzINXlpH3kTPJgeG6dF195AuwewOFJ4rHnyW/WeLFrlG4vAwBiew9
         xpJZHwTMDaPWMJ7Y94DaH7zs94yBdU1ooRkgN4uvFpAnALdwl23IPrJRG5twjM8YpUZv
         WTW3Kxv4OipMrH6+ab/jQW5c3O5LPCelTrdDYOo+uGsYDeLFDb+3xIRswmJ3uJyC4N3H
         2TdQtWf6mGArjpXK5HQYNdD876NUHwvPEA7wUiru0wIQuvJQ1Z80gCV6lMCPmRyrTkZd
         431A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8ErtUVrdJpAbz3pd9Rfcv2rTfSjq1rTMRt5MW6xhVzE=;
        b=Ev5mxY97E7nZUEgk5D/CaqMnlQ3FV1oQeXzsriZDMmpo/tVYyK+irJgY2cDk3nmLQT
         vOY2KUw4gEua9izGJbbEY5FkpDCli19sPNDiJD3eSXzyDpKlYfbGBHvjGTC59y2mbQkn
         3HeVn8fvoEzaqcbZRtuurp9ZNQ2LUVXLn0gEx9MNt5JoHsZ3ubl0STu7MCKKJWWCFNdC
         E50Xa5rSB40ycyYKMw8ZW8AIbCyeVY62+jesCtOnVaTTEFzcJfN9Q4a08uHRtDofwhpo
         YPVoTHhj1/jivqB6CjDeBPZILMyQsldnXqGBPo44e5NHbu/V9oEInM6bgYjQu8I3AhEz
         CNoQ==
X-Gm-Message-State: AOAM5332RwRG4h2kHajnAvQ0C/PA90vzwxcAEYBgSPUJO8z6ouJw4YDq
        FVBP/VjI4TQoVAEad1yD+2zBpb5plalYOt9dPuc=
X-Google-Smtp-Source: ABdhPJzzTxdtaswIHUw4TPj2KWjh68BJOmFYPczOXd8+/J2FzZJRxNHcgmTVZuXvfsSr1vnZBg/jlieyCaiBLSNXA5s=
X-Received: by 2002:ac2:5093:: with SMTP id f19mr10773563lfm.10.1592856384425;
 Mon, 22 Jun 2020 13:06:24 -0700 (PDT)
MIME-Version: 1.0
References: <20200621133630.46435-1-grandmaster@al2klimov.de>
 <CANiq72kA==S-G481VHx2qrKkJmaVK7ZOuYmin4xVr3XKB8x8ug@mail.gmail.com>
 <b7ba0047-8993-d3bf-327c-1fb70bc0282c@al2klimov.de> <CANiq72=Y+beqZ8Dmieo_GKbyaLN8Nf1n3bVntj_o90Cn-nADRQ@mail.gmail.com>
 <20200622070623.086f1623@lwn.net> <CANiq72m6BNYe2ETNXJ2oLc6Jzad6kBBJK7_dz+BwZCeqYFXZqg@mail.gmail.com>
 <adf85348dcbfbf64157e6519115b3a0c9f35df55.camel@perches.com>
In-Reply-To: <adf85348dcbfbf64157e6519115b3a0c9f35df55.camel@perches.com>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 22 Jun 2020 22:06:13 +0200
Message-ID: <CANiq72mSz+LWLwOCa=9YtzKaD+NjhjZdRdwFiZ-gLMbjYd=QzA@mail.gmail.com>
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: Documentation/process
To:     Joe Perches <joe@perches.com>
Cc:     Jonathan Corbet <corbet@lwn.net>,
        "Alexander A. Klimov" <grandmaster@al2klimov.de>,
        Randy Dunlap <rdunlap@infradead.org>,
        Tony Fischetti <tony.fischetti@gmail.com>,
        Chris Packham <chris.packham@alliedtelesis.co.nz>,
        Mauro Carvalho Chehab <mchehab+samsung@kernel.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        Borislav Petkov <bp@suse.de>, Will Deacon <will@kernel.org>,
        "Chang S. Bae" <chang.seok.bae@intel.com>,
        Pankaj Bharadiya <pankaj.laxminarayan.bharadiya@intel.com>,
        Kees Cook <keescook@chromium.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Jacob Huisman <jacobhuisman@kernelthusiast.com>,
        Federico Vaga <federico.vaga@vaga.pv.it>,
        =?UTF-8?Q?Jonathan_Neusch=C3=A4fer?= <j.neuschaefer@gmx.net>,
        Konstantin Ryabitsev <konstantin@linuxfoundation.org>,
        Linux Doc Mailing List <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        clang-built-linux <clang-built-linux@googlegroups.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 22, 2020 at 7:29 PM Joe Perches <joe@perches.com> wrote:
>
> scripts/get_maintainer.pl --self-test=links has a reachability test
> using wget.
>
> Perhaps a script like that could be used for http:// vs https://

+1

Not sure about `--no-check-certificate` if the goal is to move to
"proper HTTPS". Perhaps we can try first without it and if that fails,
print a warning and try with `--no-check-certificate` etc.

Cheers,
Miguel
