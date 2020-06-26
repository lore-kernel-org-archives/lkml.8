Return-Path: <SRS0=rtH4=AH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 86EDFC433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:09:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 62BE6207E8
	for <linux-kernel@archiver.kernel.org>; Fri, 26 Jun 2020 14:09:28 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="ffgz/EKA"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729051AbgFZOJ1 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 26 Jun 2020 10:09:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728920AbgFZOJ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Jun 2020 10:09:26 -0400
Received: from mail-pl1-x643.google.com (mail-pl1-x643.google.com [IPv6:2607:f8b0:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 287C6C03E979;
        Fri, 26 Jun 2020 07:09:26 -0700 (PDT)
Received: by mail-pl1-x643.google.com with SMTP id x8so3426759plm.10;
        Fri, 26 Jun 2020 07:09:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=nVcE6JZwaiOpCfvw6QaISNFoFXQ9vpyfQxkKFtpxiO8=;
        b=ffgz/EKAhIoZtQe8N/0D1lqGXGbAsbyaCVw3ZpHgmelpr+8gITxZFC3lbbeUOr6KBG
         PefAdZxl571J9LzZ/3pciLZkIX9dGehHSGAJ2sZKzzdBI0GLTb1ObZ1blBOoMgsWLQws
         u8tgY8DC8eSLOqj5aa7vGR52VT5VeTpzVmDLT3sYuG3f+eB6dqexQBwgSeiUGuWoLhyA
         pz9XnlPL3RtbfQZjsOE391pTetqfX6tw4bPteve039ub00BGm3wRa0/jjTHERToZC8WV
         4wGywfJFGTHIl3mgLDQfXMd5vRqamN5TAL2prs+9vJKLEt4Ye60SA13YFlATatLgD8tA
         ymiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=nVcE6JZwaiOpCfvw6QaISNFoFXQ9vpyfQxkKFtpxiO8=;
        b=b2lnFS5+zcGnWFckxl4WS5LlIVZjYt0YV0dwY/YhZtcROxd+LRgNHxLOXPt3xuGCQV
         JagKU8nz4zwl+RlvZbUi7yA7+AuSfUNyqMeX4gemZCtwe5q3+I8Ttf+jgppLJWV65lI/
         jw7YM4f2Wv7bhwV37UZzqEJl01Yi/+QO4kVsVB5GuFUUYI+KE2QZ7tMkMRcn9JoS++bZ
         ym8SJWMJuvh/a5CyZtfrhYQ6zet2ngnc6fNI5H5E1zr8JRgbbW9ac7LV1Iv6+4t9knqI
         ThrKjuSUkXvluUDTuLYHsEy1ZLiLCG7zMseBBLXE8Bp6hw5HwcE5sXCz522IapW0pv1n
         HFGw==
X-Gm-Message-State: AOAM530pWq0wNcKE0KEaAKVhPonDWk6zz+tMwzmaJyNYzhoDjPybVWwc
        aOzWh4erQB1iM74kaBKKgoUwbRumEXPH69IxFHg=
X-Google-Smtp-Source: ABdhPJxOcrGuBrjFXG3Y82onEudQH4jwuXE0m2thhCpRMKDr2i7mImfOitw8ws6EFZQqF17S/O2k0uErcLUJsYNyygY=
X-Received: by 2002:a17:90a:220f:: with SMTP id c15mr3869185pje.129.1593180565616;
 Fri, 26 Jun 2020 07:09:25 -0700 (PDT)
MIME-Version: 1.0
References: <20200625202807.b630829d6fa55388148bee7d@linux-foundation.org>
 <20200626032946._LJ_E6G66%akpm@linux-foundation.org> <CAHk-=wiZrhVUq3N17=GVzMQNQUKi65x=-djTM2A+fz8UdQxgEg@mail.gmail.com>
 <CADRDgG6SXwngT5gS2EY1Y0xnPdYth-FicQyTnPyqiwpmw52eQg@mail.gmail.com>
 <CAHp75Ve2x9dEqaHSue5UAftsJw+U3n8K9YEXBy5QFGJHgkQ3DA@mail.gmail.com> <CAK8P3a3doveL3DxjcyiAqxNve07WfXYNTXK77Pbm70Dvyowg2w@mail.gmail.com>
In-Reply-To: <CAK8P3a3doveL3DxjcyiAqxNve07WfXYNTXK77Pbm70Dvyowg2w@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 26 Jun 2020 17:09:12 +0300
Message-ID: <CAHp75Vfr8sFydbH=G7U+wXoUftT9RnsfSSLi4RXNyR-3sApR3w@mail.gmail.com>
Subject: Re: [patch 10/32] linux/bits.h: fix unsigned less than zero warnings
To:     Arnd Bergmann <arnd@arndb.de>
Cc:     Rikard Falkeborn <rikard.falkeborn@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
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

On Fri, Jun 26, 2020 at 5:03 PM Arnd Bergmann <arnd@arndb.de> wrote:
> On Fri, Jun 26, 2020 at 3:24 PM Andy Shevchenko
> <andy.shevchenko@gmail.com> wrote:
> > On Fri, Jun 26, 2020 at 2:37 PM Rikard Falkeborn
> > <rikard.falkeborn@gmail.com> wrote:
> > > Den fre 26 juni 2020 08:32Linus Torvalds <torvalds@linux-foundation.org> skrev:
> >
> > ...
> >
> > > I'll just say no and point to this email next time someone complains instead.
> >
> > "No" is not constructive here. People can be annoyed with warning
> > messages, but the real issue here are the various CI systems which
> > send a lot of spam because of that. As a maintainer I would need to
> > drop CI in order to see a good patch. If Linus considers that warning
> > useless, then probably you can change your patch to do what he
> > proposed.
>
> How about moving that warning from W=1 to W=2? Generally speaking
> I'd expect W=1 warnings to be in a category of "it's generally better to
> address this in the code, but we can't turn it on by default because the
> output gets too noisy", as opposed to W=2 meaning "this sometimes
> finds a real problem, but fixing the warning often makes code worse."

It would work for me if it had been
a) documented (I didn't check if it had been already done, though);
b) understood by all CIs in the same way (see a) as well :-).

That said, I like any compromise that will reduce unneeded spam for
submitted patches from CIs and, as a bonus, get rid of warnings in my
local compilations (yes, I usually do W=1).

-- 
With Best Regards,
Andy Shevchenko
