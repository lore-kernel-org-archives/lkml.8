Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EFC9DC433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:40:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BCE7920C56
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 22:40:41 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594680041;
	bh=LngYbj1Kf7uDVAe2CfAZmM9u775CIEXPDx/Jo0cAFDY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=VFcMz6k5HdYS4wVz0AP+MgyPzbyOWVS/CBs/g9OsWU1gECXSFaIswfyPyqbF32HeU
	 O4CK5vl+BWlOLBNVJkycJ+Ki0fqp+pcQ1xOGYgsQ17MJH7eSLzQkaNC8H8CshzvxaL
	 zxiShXMa8jAyzJ5A9vZVz7tpM71cPCwYffXdaFJI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726582AbgGMWkk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 18:40:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49180 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726356AbgGMWkj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 18:40:39 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8AC67C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:40:39 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id y18so10147555lfh.11
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:40:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HnJWx12hVJg3iJ15gjLaMo6h/qhb59V4NN6hR9JaCZg=;
        b=eb+hINqXmN77iclaBvgzj7oKTDFR5ZM04xBhfglNmVlDSPcSKYlOucCKVU/Y+fOqyF
         q7nuuQfOytXG4TvlsZs3ifjK68z+xAf23viuOENQPIWTMHJ6tagpGQvg7HjmxfsByic+
         LLxLOg4FvHKTAVeuFcSKe4/SW5iR44uDXKk+4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HnJWx12hVJg3iJ15gjLaMo6h/qhb59V4NN6hR9JaCZg=;
        b=pQR5l7mMNHdrjhw+e1D9eG8dOfOHv14i/sHVE7j39YUE1+10926VOwaJ6GY70+6t3r
         J2lQDWPE9HNkRfVqbUnitwY4vOz9sOSm6SqL8uiWIamyzLXRqHa64LI1XcbXG8cuGafi
         iAJAB0TuKoBfVuWbHR/ZYW/InTk0E+JEOsKlk9qmGRbZvLpB6fVAESwQHdwRy3gHDmQt
         7vtwcR1OKLByqgZxYVYZjpfxGnHhgCcNQrZlRSXx17ct9xa/c71DuqMqTPieJAI1FTgi
         o72Mx8rJMWnWwLjO7Ib3wcs3/zQDeY/FNOgwSiFmn0oHnXReb5+5YqrbQiT82ITy/vYC
         hN2w==
X-Gm-Message-State: AOAM532NrKShSV3KDX224gIkjzANeRgVc1b1nmBqU/DjW/oAGR1pyJbl
        f+AQhfpA3sSgc7UZTtc4ANNONNqt9Ik=
X-Google-Smtp-Source: ABdhPJxLCS/fWZ+/aN8Lz37xeAuot5ujmcfLlrIMxbn0X6CxYUEIvqVkkR9FufaPhZJ41ZLcuibCgw==
X-Received: by 2002:ac2:5e6e:: with SMTP id a14mr636611lfr.79.1594680037482;
        Mon, 13 Jul 2020 15:40:37 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id s4sm4872521lfc.71.2020.07.13.15.40.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 13 Jul 2020 15:40:35 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id f5so20048582ljj.10
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 15:40:35 -0700 (PDT)
X-Received: by 2002:a2e:760b:: with SMTP id r11mr877324ljc.285.1594680035133;
 Mon, 13 Jul 2020 15:40:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200530221127.459704-1-brgerst@gmail.com> <CAKwvOdn7Ugu_687b9CnOnL8RA9hbi+ONCb10gS=3VqtkTsmduw@mail.gmail.com>
 <CAKwvOdm4gMe_-DcB_H4mDGm8Yy++_7G20sg9xuZoom-rF2j1Sw@mail.gmail.com> <CAKwvOdmGtZtqF5f-5x0n4GNCWLOnrk2r6e3X2XHGmoOL7f7u0g@mail.gmail.com>
In-Reply-To: <CAKwvOdmGtZtqF5f-5x0n4GNCWLOnrk2r6e3X2XHGmoOL7f7u0g@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 13 Jul 2020 15:40:19 -0700
X-Gmail-Original-Message-ID: <CAHk-=winDAeDTAe33QVoRvTJELMDjQpYPqSPcNwSk+SwPrav=g@mail.gmail.com>
Message-ID: <CAHk-=winDAeDTAe33QVoRvTJELMDjQpYPqSPcNwSk+SwPrav=g@mail.gmail.com>
Subject: Re: [PATCH v2 00/10] x86: Clean up percpu operations
To:     Nick Desaulniers <ndesaulniers@google.com>
Cc:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@kernel.org>, Borislav Petkov <bp@alien8.de>,
        LKML <linux-kernel@vger.kernel.org>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H . Peter Anvin" <hpa@zytor.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Brian Gerst <brgerst@gmail.com>,
        Dmitry Golovin <dima@golovin.in>,
        Alistair Delva <adelva@google.com>,
        Steven Rostedt <rostedt@goodmis.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 3:24 PM Nick Desaulniers
<ndesaulniers@google.com> wrote:
>
> Otherwise, is there any additional feedback on this series or is it good to go?

I've lost sight of the series. I'm sure it is fine, but maybe you can
resend it to me (in private, if it's already been going out on the
mailing lists and everybody else is completely fed up with it).

And no, pointing to the "plus this hunk" with a web link isn't what I
was looking for ;)

             Linus
