Return-Path: <SRS0=8wH5=AU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C31E5C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:13:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9C80A207DA
	for <linux-kernel@archiver.kernel.org>; Thu,  9 Jul 2020 18:13:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1594318433;
	bh=/eIkOXQXm+AYixzqCrQtja5osHWK5ZsC1fLBCcQbdmc=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=L82aUoSV69PjpyH+lfnvoRoZzGFdk/jIeM59VZiOL4hHzTB2dIK4dGmzStT79RYwf
	 //P0lSnN85+/3HtguTp9mymyIbcYMMWfntjcrnjj+ayCkfYA6xTbdwZ0cI6W7gz5Pz
	 5YXJmB2OEfiCztduw7OtCaWynM8Q0/HlZ6Ny+d2Q=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726786AbgGISNw (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 9 Jul 2020 14:13:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53242 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726684AbgGISNv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jul 2020 14:13:51 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72177C08C5DC
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jul 2020 11:13:51 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id f5so3450627ljj.10
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 11:13:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QQ4MFwKX0KeW+zmPJf6dh6Z4HEUniPj2BzYhpEhaY5c=;
        b=H4yZEP+ReHmnQ8pPy85R6Z5AGImyoEWgzVC2r2MdX2eTlEN06eDA4bs8kmZRPf8ir7
         nONwubENi3D4CIY0RGHiJrUqJ5uDrjE78F1DvfhsN5lZUpuci6eD15V+qTw0bDmuQk3U
         UFPBqV2teYZxvPtlwDGq03SOGObHpMBpQnzm0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QQ4MFwKX0KeW+zmPJf6dh6Z4HEUniPj2BzYhpEhaY5c=;
        b=KGn91q1nOGObu8AQ5s2wyFtLaklcwNTPOKT0n/L9NOswh8SVR5QUrQYYovq5eG6JTf
         glPFyP720jclfMbqUPXA3MFmLLEah8AoMDd8EoQbl8Tiu52k5eUnRCRh45ChNFFBXiNx
         wZlQwKOamqxorv2z2YHDJsklCG3/e8SV0ydo6RijtVOKmkRbUj5K5TcVT1VrRy9u6bZh
         TEWPLTo8Md4j0r/OylxtgO568eUPD56s3hc5wR34c2g2wQNVcRfI4bCc8FXYU7tapJqB
         qqpo+yE2tM9b9VdwPxQgQmgQKjykenqyEhKRAu6t5gI++5lJ5LvrqC7v6bqgH0q0GJDD
         nObA==
X-Gm-Message-State: AOAM531DCxzrXFfBsUkfKkXp2YWSAffQwqoGGYv+aAFle4j3jwrWbuWK
        hn8ngcixycwvM46dEtp6KGQiccvqrF0=
X-Google-Smtp-Source: ABdhPJzfBBq3zOlHbJiK/OhtPWrTi/60jIrqO7imUBlMCt5YvX5X81647l30eTokJZDaznOSYoZBPA==
X-Received: by 2002:a2e:80cc:: with SMTP id r12mr32459160ljg.344.1594318429631;
        Thu, 09 Jul 2020 11:13:49 -0700 (PDT)
Received: from mail-lf1-f51.google.com (mail-lf1-f51.google.com. [209.85.167.51])
        by smtp.gmail.com with ESMTPSA id w4sm1048172ljw.16.2020.07.09.11.13.47
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 09 Jul 2020 11:13:48 -0700 (PDT)
Received: by mail-lf1-f51.google.com with SMTP id k17so1720851lfg.3
        for <linux-kernel@vger.kernel.org>; Thu, 09 Jul 2020 11:13:47 -0700 (PDT)
X-Received: by 2002:a05:6512:3f1:: with SMTP id n17mr40988629lfq.125.1594318427258;
 Thu, 09 Jul 2020 11:13:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200621054210.14804-1-rikard.falkeborn@gmail.com> <20200709123011.GA18734@gondor.apana.org.au>
In-Reply-To: <20200709123011.GA18734@gondor.apana.org.au>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 9 Jul 2020 11:13:31 -0700
X-Gmail-Original-Message-ID: <CAHk-=wibAAcH2+hk+X9mBp0h1B6oYv+Pjzq1XB+EXJhgshu-Xg@mail.gmail.com>
Message-ID: <CAHk-=wibAAcH2+hk+X9mBp0h1B6oYv+Pjzq1XB+EXJhgshu-Xg@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] linux/bits.h: fix unsigned less than zero warnings
To:     Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        Arnd Bergmann <arnd@arndb.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        linux-arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kernel test robot <lkp@intel.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jul 9, 2020 at 5:30 AM Herbert Xu <herbert@gondor.apana.org.au> wrote:
>
> I'm still getting the same warning even with the patch, for example:

Are you building with W=1?

There's a patch to move that broken -Wtype-limits thing to W=2.

    https://lore.kernel.org/lkml/20200708190756.16810-1-rikard.falkeborn@gmail.com/

does that work for you?

              Linus
