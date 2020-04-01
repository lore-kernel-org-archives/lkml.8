Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 872F7C43331
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:19:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 548F621582
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 08:19:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="e0LTts26"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732078AbgDAITC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 04:19:02 -0400
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43390 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1731870AbgDAITB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 04:19:01 -0400
Received: by mail-lf1-f68.google.com with SMTP id n20so19630976lfl.10
        for <linux-kernel@vger.kernel.org>; Wed, 01 Apr 2020 01:19:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=3X5Ui3kFF/VqVsswCk+H6N1aAGKj9/qFdOpQH7o/fX0=;
        b=e0LTts26IJz9re0PtsdlTkKxXPqOwfZhRTuSGc4FDNgszP3/5igArFPJjoOgRLWGnZ
         tMQslUL+bzRbsSxpZxhnRq9vjS+Cl7Z1h/uamQ+GXW8A1+9+Wp7yqZsp9MRHRgXoW2a3
         S7RsG1hkx+GMFXkxuZ1P8NxXMd/DweplNQJwWJQGRaaJvqcPZTuNnp/OgjEpLUR7TIsM
         6dPemupP2KRzepkssvDiA8KVBzkPqBDk+VUd0PgoTHQ5gmnQuBHSGIceuuiY1r4EXI5L
         1WsUqU/LD3pxYP66SnCFNyj15lAAfVTu/kKm0YebFbhad5JpLwZyY81BXtMmBgtgovKs
         +1jA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=3X5Ui3kFF/VqVsswCk+H6N1aAGKj9/qFdOpQH7o/fX0=;
        b=b3lUlDaraO6F89ZP3lpM51vgCo7mf9RQVAnmBv3XE3dGZbiM5WbZbNRK4kqFbbIhcQ
         NwmnXZvic3I165bfl1D6aKe9/r30bjY6wfvhmzUJpszHGZgrSLprz2kgIbiGduRzvEZR
         OOvWWnT3K+qUQGqe12qcdvlnJeG2Wmisa611t67E4dXpUX9NDpiT6xqSY8pvt7l4haQF
         +wCWBMF9I44Caw7nLIPdUpcteTNNvRg4GJAFNR3FrKvCuFqZxGG7a4ZXPPZlphktxnSH
         s4/xIX+T3wV3c4gOzZi+fpWhUTbK4giaXsCJo87NoXpLkiCLsK8i/mZ2gLKU3yHISwjW
         QBEg==
X-Gm-Message-State: AGi0PuatYuU8qSKJijePDhheVLyYDik00aghvV9UJs00EWyEwvFgPWnT
        HrB4v6br3ls3aKv+pKljIHBNDj2WlSA2XK7tmSCbDg==
X-Google-Smtp-Source: APiQypIYt3HrVsUkJtt4Lm7oBM6f91bGNlBigjePb0aD8ENBx7WoHbbUlepDmqvOoaHvzYsmvLVS/FZ09CwwE4zAyyA=
X-Received: by 2002:ac2:5f75:: with SMTP id c21mr13715722lfc.194.1585729139654;
 Wed, 01 Apr 2020 01:18:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200401151904.6948af20@canb.auug.org.au> <CAMuHMdXFHWFucxZbChxaM6w4q9Gu5pccMBP46N4Av1E2rNKddA@mail.gmail.com>
In-Reply-To: <CAMuHMdXFHWFucxZbChxaM6w4q9Gu5pccMBP46N4Av1E2rNKddA@mail.gmail.com>
From:   Linus Walleij <linus.walleij@linaro.org>
Date:   Wed, 1 Apr 2020 10:18:48 +0200
Message-ID: <CACRpkdbP9gMLDnDSR6czN88Hjwu6HXSZ2jyYOo-iuq0W073Hbg@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the gpio tree
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 9:49 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:

> > +EXPORT_SYMBOL_GPL(of_pinctrl_get);
>
> As exporting symbols has its (space) cost, and of_pinctrl_get() is a tiny
> function, what about making it an inline function in
> include/linux/pinctrl/pinctrl.h instead?

I'm all for it! :)

Yours,
Linus Walleij
