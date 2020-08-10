Return-Path: <SRS0=LKJ9=BU=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.0 required=3.0 tests=BAYES_00,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 68375C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3451822EBD
	for <linux-kernel@archiver.kernel.org>; Mon, 10 Aug 2020 15:32:37 +0000 (UTC)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729224AbgHJPcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 10 Aug 2020 11:32:36 -0400
Received: from mail-ot1-f67.google.com ([209.85.210.67]:44195 "EHLO
        mail-ot1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729078AbgHJPaZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Aug 2020 11:30:25 -0400
Received: by mail-ot1-f67.google.com with SMTP id h22so7564421otq.11
        for <linux-kernel@vger.kernel.org>; Mon, 10 Aug 2020 08:30:25 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=EGXr1Q0HM/qo5dJWVUAaDwFLJRLFuaiaXBoFgMVJkVQ=;
        b=ZHbqDf1Omd+MkmBmSIZZwsMe8MQlaFN1uACQ84nxk1xxwXTPgw89t6IzICqRA/7yJn
         IrHTlAIDuvAt979oVzO6CEScnbdR9M8/HDkvBRE+GivOWn7AEVkgx1NOZcjPF1/WCbsq
         wY5zflc8s5iZEWJegBPkwDC6jt4qhKi4D3uIK5ufDecc4C/dhrGKLC/Y0YOcMNRN5yBv
         bWokotfXMRKrsZEwgmW4PO2hIOfn43xpCCD/uxCqdMZgiALVdkamtTGWM8WhFKfNC/hL
         0YIF2awdadFtHW7zosWHisEDG64/JELHHGeoxqEdDqeR51seJsE7z03vrCe6qMk8zwiU
         7N0Q==
X-Gm-Message-State: AOAM532qhklmWkDhS0Ns5Sqj0IeT3P1QbVjCFZc1BBlGmEF8jl4EYmnb
        1YJXsoJKXQz8GhEL4T4MoJjQpgVd9wD0HATam+c=
X-Google-Smtp-Source: ABdhPJxkSUjUVue6l2Kb8qruxmuLEjfMHX2XY/gqPS1Y7BnQy62fmtLXDJozjrz938tbOW7O7dT8GP+A8G/V5yYCN6s=
X-Received: by 2002:a9d:1b62:: with SMTP id l89mr1187198otl.145.1597073424726;
 Mon, 10 Aug 2020 08:30:24 -0700 (PDT)
MIME-Version: 1.0
References: <CA+icZUUGO0__SEZ7YvuQzfSdaWfTnCHW=73-3W4X=Vz51wHd+w@mail.gmail.com>
 <CAHk-=wiR+uHUyp3=Nf1aiNjmg0ZekaQJupLRguFNZ=MreuGhfg@mail.gmail.com> <CA+icZUXRjrX+1NAZy4As_ficD4aHRAZWHRj5hrE+D6E5zEKXHw@mail.gmail.com>
In-Reply-To: <CA+icZUXRjrX+1NAZy4As_ficD4aHRAZWHRj5hrE+D6E5zEKXHw@mail.gmail.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Mon, 10 Aug 2020 17:30:13 +0200
Message-ID: <CAMuHMdU-XugrkfM-9tQLrOJ_E1Of1Zf-DJZeSXJwkhw0Q9YoPA@mail.gmail.com>
Subject: Re: Linux 5.8-rc6
To:     Sedat Dilek <sedat.dilek@gmail.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Sedat,

On Tue, Jul 21, 2020 at 10:19 AM Sedat Dilek <sedat.dilek@gmail.com> wrote:
> You happen to know if I can configure in my ~/.gitconfig to pull
> linux-git stuff from two repositories - check first git.kernel.org
> then GitHub.
>
> Some days ago GitHub had some maintenance issues and I was not able to pull.
> Means I trust more the security and integrity concept of git.kernel.org.
>
> To pull from GitHub - saved 15-16mins of my life-time - meant
> 15-16mins go earlier to sleep - as said I started my build 01:02a.m.
> (German local-time).

Assumed your cloned from kernel.org:

    git remote add github https://github.com/torvalds/linux

After that:
  1. "git remote update" will fetch data from both origin and github,
  2. "git merge $(git tag | grep -v rc | sort -n | tail -1)" will
     merge in the latest release, if you don't have it merged already.

Gr{oetje,eeting}s,

                        Geert

-- 
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
