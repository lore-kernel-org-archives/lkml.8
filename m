Return-Path: <SRS0=dgGg=75=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74136C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:21:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4AD3320C56
	for <linux-kernel@archiver.kernel.org>; Tue, 16 Jun 2020 12:21:09 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="WCJ8C9Th"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728626AbgFPMVH (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 08:21:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42512 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725901AbgFPMVG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 08:21:06 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CAD81C08C5C2
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:21:06 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id b5so18582766iln.5
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 05:21:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2dyDpoLwIzV8Y2oUVWLUvllKR0lYbevMOUFT0R36afQ=;
        b=WCJ8C9ThcrJ9JyM+LwYLoP8teUs6OOqWzFt0B+WKUmQEDEJARfMFSYesiYcnxggBAO
         SL62uH4RsxB8ER24y/h+PA6x7JTVxMhOg82AcTYagDooAJo3f6UHmLWMlARu4z8y2MXE
         bg+RASloJPg/QWVzEyAuA+mQ4WSLUZ/NfgurTZYfatDjrt4aB7v1BSo8AvY0W5sy3/fb
         VtDpxR/N1pieOam7mj9O7r/vuPpWYEA7fthd7HnxpWgeUJU87sx3d2INqr+nBlfc+iTf
         bhZug5enKk5d8LgFHimwLSQamDALpuEszfYS7E2bz4CIH8K3GH/f1KbtgNHCeDJ8sxF9
         0yUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2dyDpoLwIzV8Y2oUVWLUvllKR0lYbevMOUFT0R36afQ=;
        b=KnhZ1HuEn9V4RDhZkeBoLk6Tow3KWtlz1JxslUjcljeaww8TnonL4/ouN8S5rVn3cW
         xWG8Ki8ML/HE3CkqvwcwiG1Ujnb3fULEau16XQdNTceSCpFYQzqBhucsqmB+BKVb0W2j
         Kt27LRoWbQStvhpOJylPX6qjloPVGT3BwDsS2ZNft8MaMsiN03PAoBF0jslw7oZFpQX6
         QY1n2B1UWW7q3llAT72LjMTc8EuSRIp0eO9eY04LER8yVWvl0NmdQec9jI86Jcycicrb
         YcYo02S2nVgMqVcLpLCZHATcLKidN5GSULXQy512CpMpIMmqavokMLCueXfhgELVEIQ+
         nz2A==
X-Gm-Message-State: AOAM53100cKN2He438VqWNwVqQvA1ysapAQgQnQjC57e+XNWK3G5/C8W
        PwXPs+oi1Vzc9i9e+J3s3jP3Hu3YtWrDHrTgFH0+iQ==
X-Google-Smtp-Source: ABdhPJxj/2UeGjR3VV5+VjjQqoipCAURYR0tK23aElL4GV7YqaJuZWLccb/peB86Plo7mlYW03p0aOiHACNJMDUEU0g=
X-Received: by 2002:a92:a112:: with SMTP id v18mr2615151ili.278.1592310065900;
 Tue, 16 Jun 2020 05:21:05 -0700 (PDT)
MIME-Version: 1.0
References: <20200616083435.223038-1-glider@google.com> <20200616100309.GA2614426@kroah.com>
 <CAG_fn=VYN6ynu2bnW96-p-QRi77NstHC6DXS+AN0r0bm5K2j7w@mail.gmail.com>
In-Reply-To: <CAG_fn=VYN6ynu2bnW96-p-QRi77NstHC6DXS+AN0r0bm5K2j7w@mail.gmail.com>
From:   =?UTF-8?Q?Maciej_=C5=BBenczykowski?= <maze@google.com>
Date:   Tue, 16 Jun 2020 05:20:54 -0700
Message-ID: <CANP3RGcvZ-TBoTo2MeCbF=TWoY2sGv21TQ5btJoh+952rscLKg@mail.gmail.com>
Subject: Re: [PATCH v2] [RFC] security: allow using Clang's zero
 initialization for stack variables
To:     Alexander Potapenko <glider@google.com>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Kees Cook <keescook@chromium.org>,
        James Morris <jmorris@namei.org>,
        Nick Desaulniers <ndesaulniers@google.com>,
        linux-security-module <linux-security-module@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

> We could make INIT_STACK_ALL_ZERO fall back to INIT_STACK_ALL_PATTERN
> if the compiler flag goes away - does this make sense?

No, I'm pretty sure failing to build, or at least not setting anything
is better.
AFAIK pattern actually introduces new bugs that aren't visible at all
with neither of these flags set.
(because in practice the default no flag behaviour seems to zero some
stuff [probably padding] that it doesn't with pattern)
