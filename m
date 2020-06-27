Return-Path: <SRS0=QqoS=AI=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C9548C433DF
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 22:07:18 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9F1A02081A
	for <linux-kernel@archiver.kernel.org>; Sat, 27 Jun 2020 22:07:18 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1593295638;
	bh=Vrwp9LlSSqt+PkzBn7Mss1gYfhswZqIsr4jc72AIC5E=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=LSY/jftefbQnEqkKJjZbWrPb6sOUYqIyTQ5s9tthQM7yr8tURppeA9vXA0UUwoKlU
	 tZAaSrBBlTrOcGjbc79uw64pgxLqiueynbypH1z9PEde7Z5PhDfwzc//FadrZUMGjW
	 0ZXevcVuC0Hgqms0BxZSvvdMkoAE5rpBuYQl8IBM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726807AbgF0WHR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 27 Jun 2020 18:07:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725940AbgF0WHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Jun 2020 18:07:15 -0400
Received: from mail-ej1-x641.google.com (mail-ej1-x641.google.com [IPv6:2a00:1450:4864:20::641])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FD85C061794
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 15:07:15 -0700 (PDT)
Received: by mail-ej1-x641.google.com with SMTP id y10so12653574eje.1
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 15:07:15 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=T23WU98K7DfgxGFmX90QFUixn3Yje6mK/5XDasGAeVc=;
        b=ZNtM25PmsQsusE0RMwt8rTRzvMaOEmTyBf1gCzGoYLJzTEHQ4rZRdRFZC26QdoRA5I
         WXi87xWufETnQM0xP+yJvROVCSrJMMujBnInqZJE7QGfzfnWS5dR4zWckwDc2/8lY4WL
         g/pvHw4QvT+aFYzaYYpdY90LP5+Mf2UNU8S8c=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=T23WU98K7DfgxGFmX90QFUixn3Yje6mK/5XDasGAeVc=;
        b=nIo0TFUZ72TYAjoXAYGqnQEPLXsBH3V12QIQA2Hm7775yuGOAZMLH+G4VeScmR1FtI
         SC6fy9oRsTPBkLNtcYjW/Wk3/Y1DjRn36ac4/m9bROHztQPrHeJkhuz3izEJJ4SOFBmU
         1EDfJrKJ2DZRPwNylR33nzBhodlYKVL67WzIxZU727gN/IBAYW3MHzSQzApHdfvKSI2A
         P9IzggaG0IsXLBKc97JDnIV3m8h2FFLRYtVYqoxpoM9rEApHshZnUarKNcSI10Qk90+o
         kxAgXl8EXjNL+6PFDByi6rrbSSgsd9Dxbs1ypUZ6q/ASbod/n6Q3Uq3souCSJzDuhTsp
         Ob9Q==
X-Gm-Message-State: AOAM533x9YGauQItHigaDtxitv7+AJJuvqBrVfPa8IALm4tWgNTFqwhe
        UVriudndLJnAdN3LzHQUKyaun3y/PJA=
X-Google-Smtp-Source: ABdhPJz4QgHO0VH5rXoYv1DT1pblxYGb1bpq7MmUxFLfzln9PMfjh+44i1OgTR1DSTH2kAsRIilTqA==
X-Received: by 2002:a17:906:f49:: with SMTP id h9mr8460511ejj.155.1593295633694;
        Sat, 27 Jun 2020 15:07:13 -0700 (PDT)
Received: from mail-ej1-f42.google.com (mail-ej1-f42.google.com. [209.85.218.42])
        by smtp.gmail.com with ESMTPSA id q14sm24650582edj.47.2020.06.27.15.07.13
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 27 Jun 2020 15:07:13 -0700 (PDT)
Received: by mail-ej1-f42.google.com with SMTP id l12so12600284ejn.10
        for <linux-kernel@vger.kernel.org>; Sat, 27 Jun 2020 15:07:13 -0700 (PDT)
X-Received: by 2002:a2e:9cd4:: with SMTP id g20mr4559628ljj.371.1593295287735;
 Sat, 27 Jun 2020 15:01:27 -0700 (PDT)
MIME-Version: 1.0
References: <20200625202807.b630829d6fa55388148bee7d@linux-foundation.org>
 <20200626032946._LJ_E6G66%akpm@linux-foundation.org> <CAHk-=wiZrhVUq3N17=GVzMQNQUKi65x=-djTM2A+fz8UdQxgEg@mail.gmail.com>
 <CADRDgG6SXwngT5gS2EY1Y0xnPdYth-FicQyTnPyqiwpmw52eQg@mail.gmail.com>
 <CAHp75Ve2x9dEqaHSue5UAftsJw+U3n8K9YEXBy5QFGJHgkQ3DA@mail.gmail.com> <CAK8P3a3doveL3DxjcyiAqxNve07WfXYNTXK77Pbm70Dvyowg2w@mail.gmail.com>
In-Reply-To: <CAK8P3a3doveL3DxjcyiAqxNve07WfXYNTXK77Pbm70Dvyowg2w@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 27 Jun 2020 15:01:11 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiKCXEWKJ9dWUimGbrVRo_N2RosESUw8E7m9AEtyZcu=w@mail.gmail.com>
Message-ID: <CAHk-=wiKCXEWKJ9dWUimGbrVRo_N2RosESUw8E7m9AEtyZcu=w@mail.gmail.com>
Subject: Re: [patch 10/32] linux/bits.h: fix unsigned less than zero warnings
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Andy Shevchenko <andy.shevchenko@gmail.com>,
        Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel test robot <lkp@intel.com>,
        mm-commits@vger.kernel.org,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 26, 2020 at 7:03 AM Arnd Bergmann <arnd@arndb.de> wrote:
>
> How about moving that warning from W=1 to W=2?

That sounds like the right thing to do, perhaps with some extra
warnings about W=2 (and W=3) being things that you definitely
shouldn't be running in automated environments (unless you are then
very very careful to look very critically at the warnings).

            Linus
