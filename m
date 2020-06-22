Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 53E2FC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:03:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30ED020707
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:03:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="UWl5j4Pm"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729918AbgFVRDs (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:03:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52788 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729785AbgFVRDs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:03:48 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACE2FC061573;
        Mon, 22 Jun 2020 10:03:47 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id i3so20197505ljg.3;
        Mon, 22 Jun 2020 10:03:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=BEWXpHZI1JNpxufz3AD/YY06ImwhKqXlN9PTm0SkH0c=;
        b=UWl5j4PmsVeqIp7pxADS1TLgigavsDAjSQWrXHxXVwzWLys5qSSdv3IMkvedSYW5A3
         sZN1WozAuqEfSxNBBhDDQsN5GLr6SlBLLkKT3jfzfdwmABDEPsCp1N3kge0q/FhNKLp2
         6C0O1fuZxTvD2RTFrIsBOlkhzf8y7M+/VQoy1grFGo65GqKNL17hz+eq7i/ZLaLGKNAj
         aY5oTe5oZTCeXIe2IrjTR5xw+OjTjlmqjmIY0fBmzGm9WAcxQ39PYmyrZ+ZLUYWtdjb2
         63uGaQJHML/V45cqpNhItSgLLgjROQKDzw7VQLlb3h37xGjNZvwaG9Q9vw+5VmS8iq2o
         QPsw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=BEWXpHZI1JNpxufz3AD/YY06ImwhKqXlN9PTm0SkH0c=;
        b=OLymURGqVTh8H0y/fxkH1UWbuzHEIftXlm7pqtRntHS7YdeGNpwJijubbXzxHc6sdR
         UMMvq2e3FX9j2MR+DG7vg+Dbl0IIrmtXQT2F9oKDkqCN938ERUdrrBYC0iKeYOYSuqAi
         3YE45y2S3/uKUp+zGhFG8xG/bfkL9pT6UddECh/oe2JcFEin+IPgC8r5kOLslNN3otWQ
         r5PpAjKTnrYKD+OxuheHW+xEcdNoRndQpIToEUrOvZG+s4iEZU/IEY62PhBsixFCIX6j
         io/T98pkCVv3xhpmdlnKQxV7/h00/U5IB1oQKvopboYDUUtld3GdEsM4lif8zRUTzvva
         rgyg==
X-Gm-Message-State: AOAM530mwIYkhemMy4ilhCIdUUIWgVyfYIS5m73ZlI4j0OckKj0UbmtN
        zL9RPArzCsDu+/t/FEDvQW6jN7NO+9OhxVskGV8=
X-Google-Smtp-Source: ABdhPJx1MVCXNYj7IaF26tUY85+8T0vvTM7RLowI3DMe7KnXObkGohj4ZPuB15GmxNpD1DnJJsKqDC/60/ThFg/UHSo=
X-Received: by 2002:a2e:9e86:: with SMTP id f6mr8180394ljk.95.1592845426164;
 Mon, 22 Jun 2020 10:03:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200621133630.46435-1-grandmaster@al2klimov.de>
 <CANiq72kA==S-G481VHx2qrKkJmaVK7ZOuYmin4xVr3XKB8x8ug@mail.gmail.com>
 <b7ba0047-8993-d3bf-327c-1fb70bc0282c@al2klimov.de> <CANiq72=Y+beqZ8Dmieo_GKbyaLN8Nf1n3bVntj_o90Cn-nADRQ@mail.gmail.com>
 <20200622070623.086f1623@lwn.net>
In-Reply-To: <20200622070623.086f1623@lwn.net>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 22 Jun 2020 19:03:34 +0200
Message-ID: <CANiq72m6BNYe2ETNXJ2oLc6Jzad6kBBJK7_dz+BwZCeqYFXZqg@mail.gmail.com>
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: Documentation/process
To:     Jonathan Corbet <corbet@lwn.net>
Cc:     "Alexander A. Klimov" <grandmaster@al2klimov.de>,
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
        Joe Perches <joe@perches.com>,
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

On Mon, Jun 22, 2020 at 3:06 PM Jonathan Corbet <corbet@lwn.net> wrote:
>
> As has been noted elsewhere, checkpatch.pl seems like the appropriate
> place to make this check.  As for "the entire tree"...if this job gets
> completed, "git grep" should be a fine way to do that.

`checkpatch` is not really enforced in many subsystems, no? Further,
some existing and future HTTP links may support HTTPS later on.

As for `git grep`, agreed if we reach near 100%. Otherwise, no. In the
general case, including the code for a task that has some likelihood
of needing repetition is a safe bet, which is why I suggested it. The
same script could be also used to check for broken links and related
maintenance.

Cheers,
Miguel
