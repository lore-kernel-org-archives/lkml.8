Return-Path: <SRS0=2gBQ=CN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 497E9C43461
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:02:48 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0D78920684
	for <linux-kernel@archiver.kernel.org>; Fri,  4 Sep 2020 19:02:47 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1599246168;
	bh=wWB6AsiBZV9B7oK5RdCYo+C8x0LDx0WC3n4aRLS96RI=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=YQsQSCwa1sI03krmqL6hsvpMtYBwZKwVnf2PwCRP3FxpDnB6c4rfKzNYYJWVn8OIf
	 bVpX2LHsw8FH3348/6upnKqU+LMI6QKGokMN3iUHJolVsW8Xs8CkYUlFXsl82nvSmp
	 tgtYDqLGfp6r+A4wWTkLF70WpCjumKQwFCjJULms=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726922AbgIDTCq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 4 Sep 2020 15:02:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46054 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726221AbgIDTCo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Sep 2020 15:02:44 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E7CDC061244
        for <linux-kernel@vger.kernel.org>; Fri,  4 Sep 2020 12:02:42 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id d2so4430281lfj.1
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 12:02:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7uUg6PoEyw6gZZ+b9cvN8OnBYQP4dXfhi5vW5L71sp4=;
        b=Bp9dBLRImFEFuBOvL8cmF4FJjs9ZKdU3TSSCwzYTyefntJCy1jPMS/1pik6rxe7p13
         AYSgb1uqemGd/+2bP3mpNLhOSvzhMS9Gw1K93F0ARpKI4mmCOxXinmdaZi8GFib9Uvil
         MWJ2XoxqXmHYrFtnySgiFspI3EtB5FQL+gY+k=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7uUg6PoEyw6gZZ+b9cvN8OnBYQP4dXfhi5vW5L71sp4=;
        b=WnHFBHKC49E2c7Frz/+GSJxGo/5Y8ybsMk4sFHfAQYhrm9x7neAtWZOOJfHOMlF/jJ
         RDvJBfvjv5uyeGGqYfc0kh00LU5knz1AtokWNUNq5eAiihg7+55upi4YorGs4FyUyR3d
         FiWfN8GlF+Xu3aKADi77JOcu7wVP+ANFX7kFCyvEdtSNakk87eQxg7Ow86TM/JGM8ADD
         7RuqNiq25UKT/58we1/XsKEmIBe38VrBBKqeZNBTPN7gkUAh2K/mx/eVe8ydYXTlq+ax
         3KSMMF3PTgmQxz0ZT8BtaT5DXELlxa16lXmlUdqqfK/D7jZg1BD5ljIRIQL5Mvwp/6IJ
         FgTg==
X-Gm-Message-State: AOAM533735FN4KNQ0BNb6lo289FV6UXaxwtEE7iYMTpK6Jw6EqiZ0lfP
        kBXGBB6TSl4iQNohGGTLTRg+l4Ks9eqIFQ==
X-Google-Smtp-Source: ABdhPJwqTZg18Nt4Zp5UYcvlr3t2lqVz5xLll8EfM55dL999URAKUbhh8tsXCpvfx4Obb2fz8X7Xxw==
X-Received: by 2002:a19:2d41:: with SMTP id t1mr4533891lft.9.1599246154879;
        Fri, 04 Sep 2020 12:02:34 -0700 (PDT)
Received: from mail-lj1-f176.google.com (mail-lj1-f176.google.com. [209.85.208.176])
        by smtp.gmail.com with ESMTPSA id k16sm1288654lja.3.2020.09.04.12.02.33
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 04 Sep 2020 12:02:33 -0700 (PDT)
Received: by mail-lj1-f176.google.com with SMTP id w14so9223955ljj.4
        for <linux-kernel@vger.kernel.org>; Fri, 04 Sep 2020 12:02:33 -0700 (PDT)
X-Received: by 2002:a05:651c:32e:: with SMTP id b14mr2189883ljp.314.1599246152917;
 Fri, 04 Sep 2020 12:02:32 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9tz0whDeamM+k_8Wu8TVzz0TDr+qMNMXo8rKeeNRKxBuiQ@mail.gmail.com>
In-Reply-To: <CAPM=9tz0whDeamM+k_8Wu8TVzz0TDr+qMNMXo8rKeeNRKxBuiQ@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 4 Sep 2020 12:02:17 -0700
X-Gmail-Original-Message-ID: <CAHk-=wh2EH9DKRpJQ7+X+NWjjduLPy_Ncv1GzxnXBg-3mTn0Fw@mail.gmail.com>
Message-ID: <CAHk-=wh2EH9DKRpJQ7+X+NWjjduLPy_Ncv1GzxnXBg-3mTn0Fw@mail.gmail.com>
Subject: Re: [git pull] drm fixes for 5.9-rc4
To:     Dave Airlie <airlied@gmail.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Sep 3, 2020 at 8:53 PM Dave Airlie <airlied@gmail.com> wrote:
>
> Not much going on this week, nouveau has a display hw bug workaround,
> amdgpu has some PM fixes and CIK regression fixes, one single radeon
> PLL fix, and a couple of i915 display fixes.

Any movement on the i915 relocation issue? I've only seen the one
report for the 64-bit case, but clearly there was more going on than
just the missing page table flush on 32-bit..

              Linus
