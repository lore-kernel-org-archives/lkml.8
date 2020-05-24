Return-Path: <SRS0=XgUW=7G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0E182C433DF
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 22:28:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id D900820787
	for <linux-kernel@archiver.kernel.org>; Sun, 24 May 2020 22:28:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590359330;
	bh=xG1s6sJdInNTx2vBPXk4s1yNKlu8cFhyrCOtsCkrcNU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=DMViItybyVIBSf6Hlkjb8wsBlFYcaCxMuzUtDaJ/1XZ1RXW0vkOIecMnC1UN3lKk5
	 9MTid3rSKZAWZeLBdg2RlFusl78j5eO+kQ4k+ro8H3P2ZEQsicZkK+oEHS0fa6AIzm
	 OD8ctKrIZM+4OVX8aCofA/PAoeuprZjiA5x6jYoI=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388528AbgEXW2u (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 24 May 2020 18:28:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388229AbgEXW2t (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 May 2020 18:28:49 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29540C061A0E
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 15:28:49 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id x22so9511401lfd.4
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 15:28:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=kAqabt4OR5c4yrPXL5ECf7rkFYVLN0cT+oP5V8EGnJw=;
        b=RGjwnc+bQ2Y64T16esul8H4tmcVEu60xFCc5yhqZq3JpidUlIufKFDfrr0QZNTehsw
         +76HMYLXrQbvEN59BSyTiGj37Mi03lYbEEVagLs+n2X2L5quy/y2wgOgXsPIx9SUxEPA
         7cOCDHzKW47RRwu4GWZZUz5o/RciKT76bL3yU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=kAqabt4OR5c4yrPXL5ECf7rkFYVLN0cT+oP5V8EGnJw=;
        b=kELeiapJZMK9DHPbLj5ULqgzJCWQuRrI+COumCmNB0+UbsJfPPu5uC9eYbEZzq3Hpz
         5B5gmKUEnY9aPlw9+EGDHIhjVamkctiSaaADhuXh3k/+L47k6GjS8lYPrD14IsHBN0/k
         tx/icTe3qyLmcCuNeKGEDcGR/HFZrKT5ALb5JuwpLB8fFuQHRgD31MyVgt5k9a0jNdpq
         1O9LVdWgYG6E5bhHd7x7GHrBZuSExkSAR7YiTBDzxbghFzHBI7Lmv3zpRyIEsjEkcyK/
         8Betz39QFU+QrOg5noeAsLqY1lQVs55u7Xtyd2vFj/IrrF8zU+L/cwYTxh3FoIuVw1Sx
         /ROw==
X-Gm-Message-State: AOAM532LitQ15tMTcu9Uv+NZTVg6J/Qpzw6dLkQomyLTxzQ27Rfn8V7K
        IYYssVXRduq6pASUmYLk/qy91H0qHl0=
X-Google-Smtp-Source: ABdhPJx/Q68S6sy+r+hhOz7obY/qddpSQCY4JOeSMKDCto76/ByysoFxfmLVGY9xo2aae27I8Fd5dQ==
X-Received: by 2002:ac2:48a3:: with SMTP id u3mr9140754lfg.115.1590359327078;
        Sun, 24 May 2020 15:28:47 -0700 (PDT)
Received: from mail-lj1-f170.google.com (mail-lj1-f170.google.com. [209.85.208.170])
        by smtp.gmail.com with ESMTPSA id y17sm4203348lfa.77.2020.05.24.15.28.45
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 24 May 2020 15:28:45 -0700 (PDT)
Received: by mail-lj1-f170.google.com with SMTP id l15so18438340lje.9
        for <linux-kernel@vger.kernel.org>; Sun, 24 May 2020 15:28:45 -0700 (PDT)
X-Received: by 2002:a2e:7e0a:: with SMTP id z10mr10170612ljc.314.1590359325216;
 Sun, 24 May 2020 15:28:45 -0700 (PDT)
MIME-Version: 1.0
References: <20200523131759.GA55886@kroah.com> <20200523152922.GA224858@kroah.com>
 <CAHk-=wih_B_8a48Au=6B+gwFcYnM7qF02dGX3R0QN_2bzVcjVA@mail.gmail.com>
 <20200524150018.GB11262@kroah.com> <CAHk-=wh4bZdCkhng3EsJCDhHLxHT6x4S66v5JQvusihVfYrc5Q@mail.gmail.com>
 <20200524194550.GV33628@sasha-vm> <20200524211221.GW33628@sasha-vm>
In-Reply-To: <20200524211221.GW33628@sasha-vm>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 24 May 2020 15:28:29 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjdf_jR1TriXQWZpS+bs9RhdV_E_VD9_SXc_yQXC+yzFA@mail.gmail.com>
Message-ID: <CAHk-=wjdf_jR1TriXQWZpS+bs9RhdV_E_VD9_SXc_yQXC+yzFA@mail.gmail.com>
Subject: Re: [GIT PULL] Driver core fixes for 5.7-rc7 - take 2
To:     Sasha Levin <sashal@kernel.org>
Cc:     Greg KH <gregkh@linuxfoundation.org>,
        Heikki Krogerus <heikki.krogerus@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Stephen Rothwell <sfr@canb.auug.org.au>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, May 24, 2020 at 2:12 PM Sasha Levin <sashal@kernel.org> wrote:
>
> (and I'd like to see the reverts too, so that I could apply that revert
> to Stable trees as well. If a revert doesn't show up in git log we might
> miss doing a backport of it).

Plain "git log" never simplifies anything at all.

Only when you ask for simplification will "git log" start skipping things.

That's things like "--grep=XYZ" to only ask for something that has a
pattern in the commit log. Or asking for a certain author. That's the
simplest kind of log simplification.

But saying "I'm only interested in changes to this pathname" is
another "please give me simplified history, only as it is relevant to
this pathname". And then it does exactly that. Including pruning out
whole branches that aren't relevant.

Trust me, it's the behavior you want. There's a reason we have
"--full-history", but it's not enabled by default.

But if you do want full history, you can still say so.

              Linus
