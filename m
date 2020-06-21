Return-Path: <SRS0=0j3N=AC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6632C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 23:43:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A08A0252F9
	for <linux-kernel@archiver.kernel.org>; Sun, 21 Jun 2020 23:43:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hNJtisAx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730914AbgFUXnZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 21 Jun 2020 19:43:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726433AbgFUXnZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 21 Jun 2020 19:43:25 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B86A3C061794;
        Sun, 21 Jun 2020 16:43:24 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id t74so8565112lff.2;
        Sun, 21 Jun 2020 16:43:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=UWYK99IQmZVG/8JvsyPASoCIo4JVfhtAHl2NOeIaFVA=;
        b=hNJtisAxXCrlYdnljPea34aTiXxz+eLH5OKYmOJiJ37bBpeRfQC1Y681O1EqEID/l/
         N/2sNuAIV267L+aQnHV+5GHQQCNum8Ka5xtQcN8pNtMA3L7mQuIbAl79Zl0J3TqJymXc
         G8RUpgoBnKUnK/RXjRuvR7C2kvaEQ4utK9FF0GP4uW4hnijG8CTaBc2RmODxwbptoFnz
         h72PrTY0EJ22eAr7e2x5LNmM1a+F1acS1CTC+piQ6R6aqULjm8PxuOMTgX7cIllJQPxV
         GzrUY4RdiN3cYFswFc8tr+m7Xlse1ePh9engjffxIdDzBHxpseRGk1YvVFev5DDOO7W3
         WsVA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=UWYK99IQmZVG/8JvsyPASoCIo4JVfhtAHl2NOeIaFVA=;
        b=LdoSi1QPS+yCcM/+sops/MwaQUFFjKl2+hJlR4Nle29b/yhwqUdyxKw5c5ZnWMe1WR
         gTXz90qjGzooU5M3vW6hpuoznmVw4MNw9AaALAI6kjFnrrS76qqOgMtdgj1xx2oFRSPR
         JiYTQHmS31bogS7BqX8v7gwyoct48Hnr7hzrTPWlxn3AZq6eemY5ivwL+8TQWfbGIYwO
         cwEWHkeE9wFA1SFWp72oGryMCMTNA+QqcSO0Y6Mu1OC8mlNHszaxj60aP9b9o4bwmyYk
         TY5u1J/j+f1nhc9ThJyOezr7IA7CafMJEZJUPSBJ/dC2uHWgi/Uq+Wu+Loq+dft6JghY
         fKuw==
X-Gm-Message-State: AOAM5326TZqxkMWAvi2QXNFIjegB1e1eDmeu03fNnzM4xCG1VvDXru3O
        2w/BBUxd09T8Bh4DwnN4eu48spOuaQOxB+ZYZj8=
X-Google-Smtp-Source: ABdhPJzXbzdsFP5J5Y8SEid4elA20z5Q0GHBxwKnVKyjzktoMtKswb8D8Ihmo4q6bXPnt6E9kipfqLPfMiQFGhdnzz4=
X-Received: by 2002:a19:22d6:: with SMTP id i205mr8200290lfi.50.1592783003103;
 Sun, 21 Jun 2020 16:43:23 -0700 (PDT)
MIME-Version: 1.0
References: <20200621133630.46435-1-grandmaster@al2klimov.de>
 <CANiq72kA==S-G481VHx2qrKkJmaVK7ZOuYmin4xVr3XKB8x8ug@mail.gmail.com> <b7ba0047-8993-d3bf-327c-1fb70bc0282c@al2klimov.de>
In-Reply-To: <b7ba0047-8993-d3bf-327c-1fb70bc0282c@al2klimov.de>
From:   Miguel Ojeda <miguel.ojeda.sandonis@gmail.com>
Date:   Mon, 22 Jun 2020 01:43:12 +0200
Message-ID: <CANiq72=Y+beqZ8Dmieo_GKbyaLN8Nf1n3bVntj_o90Cn-nADRQ@mail.gmail.com>
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

On Sun, Jun 21, 2020 at 4:30 PM Alexander A. Klimov
<grandmaster@al2klimov.de> wrote:
>
> Which discussion? 93431e0607e5 ? IMAO the patches don't depend on each
> other.

The one we had the other day. It does not matter that the patches
depend on each other. It is information for whoever sees this commit.

> IMAO:
>
> * The script should not be neccessary once all of my changes[1] arrive
> in torvalds/master. Instead reviewers should say like C'mon dude, what's
> this new plain-HTTP link doing in your patch? We have 2020! Look at e.g.
> 93431e0607e5 .

In an ideal world, yes, but that won't happen unless enforced somehow.

Nevertheless, even in such a case, it would be best to have a script
to check the entire tree from time to time.

> * The program language agnostic algo description of mine should be
> enough. If it's not enough, I shall improve the description.

Then you are asking the next person to re-do the work.

> * Today I've added "If not .svg:". Imagine Torvalds merges the script,
> closes the merge window *and then* someone runs it on a random subsystem
> and discovers a missing condition. Do they have to patch the script,
> wait for the patch to arrive in torvalds/master *and then* patch the
> (other) subsystem, so they can refer to the now patched script? W/o a
> such central "rule on how to HTTPSify links" they'd just describe
> *their* algo. Or (even better) there wouldn't be much more insecure
> links, so the algo could be omitted.

I don't follow. They can patch the script if they want (or not), but
even if they do patch it, they don't need to wait for the patch to land.

> After all please show me one of the big bosses (Torvalds, K-H, ...)
> who'd tolerate to have a...
>
> * written w/o focus on maintainability
> * not documented at all
> * *Golang* file
>
> ... in the kernel tree.

It is a script, not part of the kernel building process. We already
have Perl, Python, C++, Makefile, Coccinelle...

But yes, it would be better to write it in a language that we already
have rather than add another. In particular, there is no need for a
compiled language for a script.

> If I correctly understand, you kernel devs write code so that if even
> the maintainer leaves the project, another one could just take over.
>
> How many kernel devs would read and understand (all of them I guess)
> *and maintain that Go script* of mine?

What is the problem reading and maintaining a Go script
(notwithstanding the point above)?

Cheers,
Miguel
