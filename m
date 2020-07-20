Return-Path: <SRS0=bl3x=A7=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4411DC433E2
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:46:13 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1A92C22BF5
	for <linux-kernel@archiver.kernel.org>; Mon, 20 Jul 2020 01:46:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1595209573;
	bh=9CMTCIaoKPSzdHPi/QcAOfkskF0XSZJLAgb8wK7crQ0=;
	h=References:In-Reply-To:From:Date:Subject:To:List-ID:From;
	b=YOBtFo3h/3NvEcd/LmD2GmEcLrutu30W1hgr9aZ2+wztjbNvH/8rnhzq6YmYAj7ED
	 YdCYcY5EzQM4B2KkQmJvZJPW2a6wyFM4u8pqX8YBRGh7nQd1f6WlKhrKQou8kLM7MN
	 35CkH+CUK6Ep6v0gcSqnIodccNTAtJrc241CiC4s=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726854AbgGTBqL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 19 Jul 2020 21:46:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726225AbgGTBqL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jul 2020 21:46:11 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FDBEC0619D2
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 18:46:11 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id t9so8859231lfl.5
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 18:46:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to;
        bh=YRv1ZMPeKloCXiGnvm9THeGZ4g4sw/J7xcl2dIGNecY=;
        b=BqRGNksrNI+sXQdAcQqOyxO9nFkkPMzCGvpq6AiHtUOzn+xgygcRiaN9/CSvE59mlH
         3wlUPCvpwcOl1DdyGJjL14JMFKPBRfj6lfHjLueEVsv78X1uJ/MD8J0RiL1d1C4znWG5
         XLdyEu8pWrkJh2BY8qeOgIUu7lcuIpD4nmic8=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to;
        bh=YRv1ZMPeKloCXiGnvm9THeGZ4g4sw/J7xcl2dIGNecY=;
        b=OgE9W/MBxB3Bt6WbLrV5y2cLJy0zfL1snuCKKMUvqBH3I2sUwZ2/A6YUWLI5L/ZLzU
         P9OpTuIsUidtZUWmAFgL+dAISqfODERt9gfs0uCFD02RvGN/8fgSxLI5Ao1tI/5Rave3
         wRPQlLMnkCoQipdtlogPDHMroY1CRpgOicrZ8qINAGvKCnZPiPJlzszI4jr5ELoJK9O0
         xPitJzqeNUbyZq8Mqvy4E9W02wfZY3WvkJct7VOD266MmgphaWZoBZKJcVa8sYa2UE2g
         oG/3RLv37k4mn7Plpc0vhf+2IxMlmNmIYQGP5I29pJc9rnz8PKkBia1dsoPTo6hSEobh
         PyKg==
X-Gm-Message-State: AOAM531ESWUNjOHJzlBtTJ47sHz2gsx5P4AoLOiJKHJ1RkfdsXWp3saN
        6CayWY4b6sGbVuGIyqnmzV694qwM9lM=
X-Google-Smtp-Source: ABdhPJyjLoXsfy8CgHGr1om7+BbLWxe7yel3LGlLR0M+w1kY/6s0EawpjiTqI7w8k7c9HEO41t0fAg==
X-Received: by 2002:a19:428c:: with SMTP id p134mr9188351lfa.70.1595209569261;
        Sun, 19 Jul 2020 18:46:09 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id h22sm2956379ljg.1.2020.07.19.18.46.08
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Jul 2020 18:46:08 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id e8so18499534ljb.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Jul 2020 18:46:08 -0700 (PDT)
X-Received: by 2002:a2e:760b:: with SMTP id r11mr9758613ljc.285.1595209567723;
 Sun, 19 Jul 2020 18:46:07 -0700 (PDT)
MIME-Version: 1.0
References: <CAHk-=wj_gy9xpqFx_aLTtLtFTCTKKLfV9E2bgE5J2GeKit3MCg@mail.gmail.com>
 <20200720004709.GA16677@Gentoo>
In-Reply-To: <20200720004709.GA16677@Gentoo>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Jul 2020 18:45:51 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjGTkHgJDrK8F7-OOu=mjVQ2bb4MsUu92E_Eo7TPOehdA@mail.gmail.com>
Message-ID: <CAHk-=wjGTkHgJDrK8F7-OOu=mjVQ2bb4MsUu92E_Eo7TPOehdA@mail.gmail.com>
Subject: Re: Oops build error...Linux 5.8-rc6
To:     Bhaskar Chowdhury <unixbhaskar@gmail.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Jul 19, 2020 at 5:47 PM Bhaskar Chowdhury <unixbhaskar@gmail.com> wrote:
>
>    CLEAN   arch/x86/entry/vdso
>    make[3]: *** arch/x86/platform/sfi/Makefile: Input/output error.
>    Stop.

That _sounds_ like filesystem corruption on your end. EIO isn't
exactly the usual "it won't compile" problem.

                Linus
