Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 74F7FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:08:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 498D420656
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 08:08:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="cJZB4FIC"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729119AbgFHIIR (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 04:08:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729011AbgFHIIQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 04:08:16 -0400
Received: from mail-pg1-x542.google.com (mail-pg1-x542.google.com [IPv6:2607:f8b0:4864:20::542])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A9E3C08C5C3;
        Mon,  8 Jun 2020 01:08:16 -0700 (PDT)
Received: by mail-pg1-x542.google.com with SMTP id r10so8380827pgv.8;
        Mon, 08 Jun 2020 01:08:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OQDiv2NQbfMFJBkZJYSSq2jlEX3XxrJprRPlx/0KuQA=;
        b=cJZB4FICUu3KsUPclLgz/uUu9TPtFp4piP137A9Lv5d8DYmn1XRjo2GjBJn1PROuLq
         pTaYVALsOneSrraQy7CMEMAlU3iD3eUJ7XHdtJpjk9jUcFtHgYXjLhAcmI0OlAGBLGoM
         owk4Qrum1QXMnoGftHPouzD3Oc2z+xyKcpGQj+nHMmLvB6RJXTPn2Yo5ZroAkVz0JTdE
         ioDXm7we3uIiuhmXRESW1krIjKkIXCCI+p9JgOHfS1BwwJm1wVxtlcdbMMlMKbCAAXLf
         9EROpC/EdB3Y/AKA7Y7a+xqjKRmUzUDLpPRHy/zImk4VtD4lyQGgBNz1LVLBM+o290iS
         fbyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OQDiv2NQbfMFJBkZJYSSq2jlEX3XxrJprRPlx/0KuQA=;
        b=rw2TUEP07niXyE3/jCb/rHTRjkNxPYdpFGkUylfIBqxwiTic3UxQ6u5yEIKijCggBb
         zgx95bgFeFqLJiLFFc+U7TmiAp8cykdGA8wh8wrZiL6oMb5DzVqzABOK0pP1efpf1BFT
         yKuz8m7IwaTGF7bjZq2BYLisjDWZfg8LwLs14Vqb7n0zRB7NjrkPjXZcmTrGCscglv5l
         rDTAwMjViJChsBppjR+RV+W1UJi+DATOyHS+i7aVAZgDzh44T8x9XPJG29IL64/EfdxW
         666DpvR4kRnWvDhqKKzaWDp3jmpI6+HX0Uvx5Lf8Op163lvIRdpTQWBPwwUN9wNM/o9o
         dmxw==
X-Gm-Message-State: AOAM530SSM109qNQrVOMQLe96Nsf+w+3npHV5B7Msz54A/ce+5CUxJVq
        fKFtLk89wDaI/sPgqTmRYR7II7B1tF3ulCZJBP0=
X-Google-Smtp-Source: ABdhPJw8yo32VMFfOf+qydZX7AWKmqRBPNNvHvXY+mNOaOmuCInQJcfkrMcPBmvj8z/TZ2eNPtVGyZliBlNwQ957eLc=
X-Received: by 2002:a62:3103:: with SMTP id x3mr3642722pfx.130.1591603695940;
 Mon, 08 Jun 2020 01:08:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200604233003.GA102768@rikard> <20200607203411.70913-1-rikard.falkeborn@gmail.com>
 <20200607203411.70913-2-rikard.falkeborn@gmail.com>
In-Reply-To: <20200607203411.70913-2-rikard.falkeborn@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Jun 2020 11:08:04 +0300
Message-ID: <CAHp75Vd94PKFSYNQ6h+ju40TwtPvLpi5gt0kCec=SJJOcM3GYQ@mail.gmail.com>
Subject: Re: [PATCH v2 2/2] bits: Add tests of GENMASK
To:     Rikard Falkeborn <rikard.falkeborn@gmail.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Arnd Bergmann <arnd@arndb.de>,
        Emil Velikov <emil.l.velikov@gmail.com>,
        Kees Cook <keescook@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Linux-Arch <linux-arch@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        kbuild test robot <lkp@intel.com>,
        Syed Nayyar Waris <syednwaris@gmail.com>,
        William Breathitt Gray <vilhelm.gray@gmail.com>,
        Masahiro Yamada <yamada.masahiro@socionext.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jun 7, 2020 at 11:34 PM Rikard Falkeborn
<rikard.falkeborn@gmail.com> wrote:
>
> Add tests of GENMASK and GENMASK_ULL.
>
> A few test cases that should fail compilation are provided under ifdef.
>

Thank you very much!

> * New patch. First time I wrote a KUnittest so may be room for
>   improvements...

Have you considered to unify them with existing test_bitops.h?

-- 
With Best Regards,
Andy Shevchenko
