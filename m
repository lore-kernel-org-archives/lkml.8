Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 63790C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 13:46:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3E96C23371
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 13:46:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="odvbi0Lp"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730018AbgFUNqu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 09:46:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54926 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729774AbgFUNqt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 09:46:49 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DD9A4C061794;
        Sun, 21 Jun 2020 06:46:48 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id g2so8134445lfb.0;
        Sun, 21 Jun 2020 06:46:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3j0kIvck3iasI2UkkkK/3yKkwAOt22SqCzg0IxsgEdw=;
        b=odvbi0LprxKmTzQyoHfve/7/GxlRSei7Ep8rCs1MN3Lx2hfcePZQvUbz3fZ6XdyO+o
         kcFbgGF7/56KJpLo2xuOqx7DwypsetwDn2m+oFSDc/n2utklQvl8KC3NEi383Fwz8VKH
         Bhqy7lEijUzpw7iKBojnF+itt/i79EhzE8TA6+m2wNiGJU8wj4cJu1P+Y4nN3En2jNtu
         903NEfhl9aVZLKx6PfEFNtFjyN1Td5tqzKqgKIK6m8l+UtDJCdGV52cOkSRhYsgsRVbV
         eZs79hJdYoMvIkjVOu7ozEx6r1kCfJkZA4vfVFR2yFftTdImkWLrYOJcVuI3SIIxxEqQ
         19uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3j0kIvck3iasI2UkkkK/3yKkwAOt22SqCzg0IxsgEdw=;
        b=NfTJwztrn/ltzFHeYGjBzObLQhF9IhkWm0fOdBVPE0+ZtF1pLlyCg2+olH2RU4GAZn
         PU02YKvSy0jp5Du3vLZnDdNODv5pIPa9VLBinOt/RJEz4Fe3WMhEU/erMEYXLM1Jpw3a
         g+SH9dYZ/h7KoIM89lsxD1skceSuilNpRJLiIdZbEfsUgKjj3t+EAWLlfl++gLZKHCma
         gi2Qu9UOTggf9ddfs55OpEx2P/JQkLfYf4MkLzC5BlyTJeS2x1AnHl2K6MsPM7ylEpss
         up4YpA6PBeCJMsxysH4XNVgbJYes9pzRSMOoB+9oWdgMqNofDT8GoyWnHsUFy8WhLlI7
         NiGw==
X-Gm-Message-State: AOAM533A555wkM2CoIzFzjE2grqiJN+YnvF7FwL4xk/iE1Z3+aUOWSSp
        wiBulCAe5lLt8HOF1NI5mPm8NNexXU0p8sHnMOo=
X-Google-Smtp-Source: ABdhPJwp+FL3qhHAfY0+CwxMSBao7NG+R4wzaIEcUUg2F1qlSdduvWUH/yGeYxAKLBwKZ/8ZfkFfzezDdG2ev/GVmsk=
X-Received: by 2002:a05:6512:31c5:: with SMTP id j5mr7312609lfe.26.1592747207435;
 Sun, 21 Jun 2020 06:46:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200621133630.46435-1-grandmaster@al2klimov.de>
In-Reply-To: <20200621133630.46435-1-grandmaster@al2klimov.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Sun, 21 Jun 2020 15:46:36 +0200
Message-ID: <CANiq72kA==S-G481VHx2qrKkJmaVK7ZOuYmin4xVr3XKB8x8ug@mail.gmail.com>
Subject: Re: [PATCH] Replace HTTP links with HTTPS ones: Documentation/process
To:     "Alexander A. Klimov" <grandmaster@al2klimov.de>
Cc:     Jonathan Corbet <corbet@lwn.net>,
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

Hi Alexander,

On Sun, Jun 21, 2020 at 3:37 PM Alexander A. Klimov
<grandmaster@al2klimov.de> wrote:
>
> Rationale:
> Reduces attack surface on kernel devs opening the links for MITM
> as HTTPS traffic is much harder to manipulate.
>
> Deterministic algorithm:
> For each file:
>   If not .svg:
>     For each line:
>       If doesn't contain `\bxmlns\b`:
>         For each link, `\bhttp://[^# \t\r\n]*(?:\w|/)`:
>           If both the HTTP and HTTPS versions
>           return 200 OK and serve the same content:
>             Replace HTTP with HTTPS.
>
> Signed-off-by: Alexander A. Klimov <grandmaster@al2klimov.de>
> ---

Looks fine, although it would be nice to have a link to the discussion
(using a `Link: ` line to `lore.kernel.org`). Also having the script
in the kernel would be nice for future re-runs (e.g. you could add it
as a first patch in the series).

Other than that:

Acked-by: Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>

Cheers,
Miguel
