Return-Path: <SRS0=xNW4=3S=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 19937C2D0DB
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:57:05 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E821020716
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Jan 2020 18:57:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1580324225;
	bh=QVkOfB7nsGoEW5a0YOAU5P7+rR7VIkpSo/vuFHwbejI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=ONh0rNRh3OYL8Apc6VEznjZ945ROxjEkaQoMDjfsQDmPY8+8m5kFnl5sEI90QhHcl
	 72sZA0I1ilq2P43qaz6gpPmg88v1Qn0tnPwVVVfwF6asKKK343ocktNaAobULa8Bv/
	 kIEsNdVBP92fUwMO4QWF+el4wvsrUAh/p+UOPk9U=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727476AbgA2S5E (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Jan 2020 13:57:04 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:45714 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727381AbgA2S5D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jan 2020 13:57:03 -0500
Received: by mail-lj1-f195.google.com with SMTP id f25so470346ljg.12
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 10:57:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Kt/onILVvy3siSsrsjMSVPmmSoKHbXFLDm/xtlxyIdU=;
        b=gw89R93Df31kvvY6qjBoDp+1iFzrbhp4Gz7yszsm0S8FcTcqhX8yLXVxEt+ITA16bo
         7r4STLyzJej9+piOwPciaWn/TUdmedObMmuyzaa8rePR2rYLDa2VKGWOpWrngrc+RUzM
         LXs7fWZf+3BkLqK4v59mXFbXhM0wgsxc+Yec4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Kt/onILVvy3siSsrsjMSVPmmSoKHbXFLDm/xtlxyIdU=;
        b=tzgRvGcs0d7LAWMzM29srv09DVpUKT2408LMFv4o3zYuRnArSkED7fxgWVWrwvCqh1
         gjNeJGbpvXk4li6PrVerBGgOwiJvUx5szjRUpy1vJI+1uBB3Kkjue/K/BeuYa1e4/PuA
         uoEGywoUsfuLX2bgFP8nu62aQ4yK0+gvnK0xsn0rXrLZhZ3uAezZCOaiBKu3aZAiwUzt
         uQdnV3ihL9ofat/7aukcKCD2Qgk44y1M4xqmE/I7On5WoC5/53sffzLRRehU8ucNKoR0
         +l6coHHrkHw4j4+PMHE8+lgp/Db+PRiee1CDH+tCQiXM8ibFkrbVKgj4GQuibjnT58xH
         WWyA==
X-Gm-Message-State: APjAAAUos16dS4Qsz8kjVWhjryi/0ifQb95Bm6BGdd31eV3LK86f5idE
        FAo8hpJnhlZcjAcZKPLB08JNTg2AB/o=
X-Google-Smtp-Source: APXvYqxFZQrPHRnh4VIDAPPXL/kvbUFTycu7bWXerArZxZxVi5RBpvf4zp93o2F8uXxgO7A0xUPpCw==
X-Received: by 2002:a05:651c:232:: with SMTP id z18mr343419ljn.85.1580324221093;
        Wed, 29 Jan 2020 10:57:01 -0800 (PST)
Received: from mail-lj1-f169.google.com (mail-lj1-f169.google.com. [209.85.208.169])
        by smtp.gmail.com with ESMTPSA id c8sm1477120lfm.65.2020.01.29.10.56.59
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 29 Jan 2020 10:57:00 -0800 (PST)
Received: by mail-lj1-f169.google.com with SMTP id r19so537488ljg.3
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jan 2020 10:56:59 -0800 (PST)
X-Received: by 2002:a2e:9d92:: with SMTP id c18mr336525ljj.265.1580324219652;
 Wed, 29 Jan 2020 10:56:59 -0800 (PST)
MIME-Version: 1.0
References: <20200128165906.GA67781@gmail.com> <CAHk-=wgm+2ac4nnprPST6CnehHXScth=A7-ayrNyhydNC+xG-g@mail.gmail.com>
 <CAHk-=wi=otQxzhLAofWEvULLMk2X3G3zcWfUWz7e1CFz+xYs2Q@mail.gmail.com>
 <20200129132618.GA30979@zn.tnic> <20200129170725.GA21265@agluck-desk2.amr.corp.intel.com>
 <CAHk-=wgns2Tvph77XZWN=r_qAtUwxrTzDXNffi8nGKz1mLZNHw@mail.gmail.com> <20200129183404.GB30979@zn.tnic>
In-Reply-To: <20200129183404.GB30979@zn.tnic>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Wed, 29 Jan 2020 10:56:43 -0800
X-Gmail-Original-Message-ID: <CAHk-=wh62anGKKEeey8ubD+-+3qSv059z7zSWZ4J=CoaOo4j_A@mail.gmail.com>
Message-ID: <CAHk-=wh62anGKKEeey8ubD+-+3qSv059z7zSWZ4J=CoaOo4j_A@mail.gmail.com>
Subject: Re: [GIT PULL] x86/asm changes for v5.6
To:     Borislav Petkov <bp@suse.de>
Cc:     "Luck, Tony" <tony.luck@intel.com>, Ingo Molnar <mingo@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Borislav Petkov <bp@alien8.de>,
        Peter Zijlstra <a.p.zijlstra@chello.nl>,
        Andrew Morton <akpm@linux-foundation.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 29, 2020 at 10:34 AM Borislav Petkov <bp@suse.de> wrote:
>
> On Wed, Jan 29, 2020 at 09:40:58AM -0800, Linus Torvalds wrote:
>
> > So I'm just hand-waving. Maybe there was some simpler explanation
> > (like me just picking the wrong instructions when I did the rough
> > conversion and simply breaking things with some stupid bug).
>
> Looks like it. So I did this:

Ahh, yeah, good spotting.

And I wonder if we should just make that

        movq %rdx, %rcx

unconditional, because all the cases basically want it anyway (the
"label 4" case does it after the jump).

It might even make sense to move it to the top of __memmove, depending
on how well those early instructions decode.

                     Linus
