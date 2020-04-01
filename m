Return-Path: <SRS0=sqB7=5R=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D2509C10F26
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:30:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id A3C882078C
	for <linux-kernel@archiver.kernel.org>; Wed,  1 Apr 2020 12:30:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="urSlPGEX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732351AbgDAMaA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 1 Apr 2020 08:30:00 -0400
Received: from mail-pj1-f67.google.com ([209.85.216.67]:50562 "EHLO
        mail-pj1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726901AbgDAMaA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Apr 2020 08:30:00 -0400
Received: by mail-pj1-f67.google.com with SMTP id v13so2656560pjb.0;
        Wed, 01 Apr 2020 05:29:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RlDkOyuOAJsKXQQ9CrWy31Tr8dpkweJ/O9gIxlGAyoY=;
        b=urSlPGEXG7DPfXBkPUxu99kn9ugBbU7w+DZr/aJ7NZQNAmgwsEDE2rQkNgj2H2jEwu
         tMn3B45NTsYak/KOfiYNVAH3A6sK0crckmN+Xga1fNcF8PyqPHhG6mz8/5cGOQgeDwjT
         nCrJNtHk6RamYqzwQ755kZM+m4MIgOOSmgOMu5QLK5UDhCio6qI8qaesShJ75PqKVp5n
         xq9I4I5l+qoxESQNWCo+TV7i1ilwT+6DFHdNkNTupJvh4uqSbocn5+t0og8uT194xkXm
         Sx1m8bXcDlkv2c1bmAVWIFm+jVFrIzIKLcPxTqqF8hFwnxlLQ3MketVP0Hx2gkaRqZ4/
         SvnQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RlDkOyuOAJsKXQQ9CrWy31Tr8dpkweJ/O9gIxlGAyoY=;
        b=pbG2Qeof8RbfXU0vLU8jcofkyg7Wt0bNQ43LDi0/0ltP5WbwWNlmOVMkNW37F7bnDz
         QKiZ3g1qmrUSQT3zX1iWfy9eFIJeLTxWJ1U18Ej9Tt0SIdUtdUjPmH9sNunHdwF0oRVl
         GGmH3sNbvUyGYmNu2hd7L+jXGjEIl0gc4XEB+Co5nEaYbJIPkjX9XP7VetNrvhHyTa2i
         FZbsnqpPJGQA9Xgg5Dl6b20BGNNqeGxKnClwqyNB4r4+oUeZcFewRr6InDo1ujpQvHw3
         7N6xrH3SWa2DOAXBCori/pHtT85NMs22qz8pbt/PwEx06LytYsYkapnrwXcuGQIqQrla
         dxhg==
X-Gm-Message-State: AGi0PuZ19dRyhxLEkTIs5nE8xqCcyF2KmxWpKmdDUlY4gQXzFLihXFSp
        LpO0qAZnLoL8/K3dQuI34T5mXnekS3Z8VhP9PEFoVkO1vH8=
X-Google-Smtp-Source: APiQypLpPaDJ3Xp6efMI+lOEcpMxFOqcVkCnWNP6Umcuu+yNiJfA4TA9o09BS+SJjWwu05CsKv3ce4x4N3OxzzgR0WM=
X-Received: by 2002:a17:90a:3602:: with SMTP id s2mr4488511pjb.143.1585744199172;
 Wed, 01 Apr 2020 05:29:59 -0700 (PDT)
MIME-Version: 1.0
References: <20200401151904.6948af20@canb.auug.org.au> <CAMuHMdXFHWFucxZbChxaM6w4q9Gu5pccMBP46N4Av1E2rNKddA@mail.gmail.com>
 <CACRpkdbP9gMLDnDSR6czN88Hjwu6HXSZ2jyYOo-iuq0W073Hbg@mail.gmail.com> <CAMuHMdXPCwdd2-Hn0_N7nLgBatS8smnvLnxZD06Qsk+qGJKc7A@mail.gmail.com>
In-Reply-To: <CAMuHMdXPCwdd2-Hn0_N7nLgBatS8smnvLnxZD06Qsk+qGJKc7A@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 1 Apr 2020 15:29:52 +0300
Message-ID: <CAHp75VfOTVHFWw16XXtuWN64Ug8Bt5AqxBTy_p78fQfknh6tnw@mail.gmail.com>
Subject: Re: linux-next: build failure after merge of the gpio tree
To:     Geert Uytterhoeven <geert@linux-m68k.org>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thierry Reding <treding@nvidia.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 1, 2020 at 11:26 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> On Wed, Apr 1, 2020 at 10:19 AM Linus Walleij <linus.walleij@linaro.org> wrote:
> > On Wed, Apr 1, 2020 at 9:49 AM Geert Uytterhoeven <geert@linux-m68k.org> wrote:
> > > > +EXPORT_SYMBOL_GPL(of_pinctrl_get);
> > >
> > > As exporting symbols has its (space) cost, and of_pinctrl_get() is a tiny
> > > function, what about making it an inline function in
> > > include/linux/pinctrl/pinctrl.h instead?
> >
> > I'm all for it! :)
>
> Want me to send a patch?
> Which base?

Wouldn't we need to export the inside function in that case?
If so, we need a better name for it.

-- 
With Best Regards,
Andy Shevchenko
