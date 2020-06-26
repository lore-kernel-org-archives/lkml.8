Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E8ECC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:24:04 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9FB72075D
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 13:24:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="nIvZAqWz"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728065AbgFZNYC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 09:24:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725864AbgFZNYB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 09:24:01 -0400
Received: from mail-pg1-x529.google.com (mail-pg1-x529.google.com [IPv6:2607:f8b0:4864:20::529])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8EF8BC03E979;
        Fri, 26 Jun 2020 06:24:01 -0700 (PDT)
Received: by mail-pg1-x529.google.com with SMTP id l63so4932535pge.12;
        Fri, 26 Jun 2020 06:24:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yvghe+YJvfBBpsHE9IQK9ZmA6GHhfnKkqxkEHse9ZJI=;
        b=nIvZAqWzcO5B+zwUhbOt6k9nKlKwwPA2JF74E7Bm3pXCEGIMFE/+qtnG9+hY7ZzavW
         AXOjsSyLfwbTW5p/svkK+OgvkeinsIzL+avQgugiakfk4d5rJ3/t5PtU/XhyCeCusDvx
         tzD2T81eXwlg9iREn6r22OEHWC+P17PkkQq8MtV33C3+fm5V5LM4vq8MIpO53k7HEqEV
         qSJvs1xOLODkMOdxrYj+hR6esHD0HsA6S3eiIWNv5VI6Gv4XuARGUaUObQuP29G1pl2A
         a9hTZe0PtIt2570j46m860Wc+jhKFq+7VA8XRFWqa3UpWfAlMlaemmne7gu4sn9l43Bu
         Rd8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yvghe+YJvfBBpsHE9IQK9ZmA6GHhfnKkqxkEHse9ZJI=;
        b=aBQuYgApVyEgx93hyOQ914BHqRUKa611IjwaGJ+qkfnqrb3Ry8baFhryiJN7TGVL0v
         qYKrsEaQ+xzmeEbNVmnLSdKPzk/FhuRfDRMAva+FKcYCB1qiYCLy1iChe686jvhXoLbG
         3IBuFlOHNL1v7InN05wmWE94F2hCXcEud4EAS/jhAT8xSknR2mp6t/JNtopUFr81ZNjN
         5cTVPQTz80O09N1XE6LH+1l8RVCdOb0FdYtbnHMomx10BmMx6bcQgoBXK39xCKbjJol2
         dDbNG7ByWLbybAlQo74YXQQysiG+kObudrjpMV8QkMLXf7rFvLI/Z8dUP+Dfp2WrgMUl
         7GkQ==
X-Gm-Message-State: AOAM530uqDKUOImys5TeOy05mMFzHsSaEfLTrXBsx5dqERvhmEplR3VD
        8/2T7wfOqbtu7dgf57dkYqxPWPcvvJfA7YE+qUA=
X-Google-Smtp-Source: ABdhPJxxGoduce29UEKBLyvW+32TBXxVoSpPWIGDmc0x/y/Gk8u7EfpstcgTCKWjauboHDozp63JvBBGkkVmkWMb1SQ=
X-Received: by 2002:a62:1c46:: with SMTP id c67mr2721580pfc.170.1593177840985;
 Fri, 26 Jun 2020 06:24:00 -0700 (PDT)
MIME-Version: 1.0
References: <20200625202807.b630829d6fa55388148bee7d@linux-foundation.org>
 <20200626032946._LJ_E6G66%akpm@linux-foundation.org> <CAHk-=wiZrhVUq3N17=GVzMQNQUKi65x=-djTM2A+fz8UdQxgEg@mail.gmail.com>
 <CADRDgG6SXwngT5gS2EY1Y0xnPdYth-FicQyTnPyqiwpmw52eQg@mail.gmail.com>
In-Reply-To: <CADRDgG6SXwngT5gS2EY1Y0xnPdYth-FicQyTnPyqiwpmw52eQg@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Jun 2020 16:23:47 +0300
Message-ID: <CAHp75Ve2x9dEqaHSue5UAftsJw+U3n8K9YEXBy5QFGJHgkQ3DA@mail.gmail.com>
Subject: Re: [patch 10/32] linux/bits.h: fix unsigned less than zero warnings
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
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

On Fri, Jun 26, 2020 at 2:37 PM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
> Den fre 26 juni 2020 08:32Linus Torvalds <torvalds@linux-foundation.org> skrev:

...

> I'll just say no and point to this email next time someone complains instead.

"No" is not constructive here. People can be annoyed with warning
messages, but the real issue here are the various CI systems which
send a lot of spam because of that. As a maintainer I would need to
drop CI in order to see a good patch. If Linus considers that warning
useless, then probably you can change your patch to do what he
proposed.

-- 
With Best Regards,
Andy Shevchenko
