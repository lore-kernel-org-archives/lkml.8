Return-Path: <SRS0=QAx1=7P=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 67EB4C433E0
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:56:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 3D24D206E2
	for <linux-kernel@archiver.kernel.org>; Tue,  2 Jun 2020 21:56:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1591134998;
	bh=TmpNi98QSpR8J5l77ZYLbeltn2+SqC6oRKmsevpJJ8Q=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=XmjNU8YGKc0UCHW+JDxspSwrx9IFSj0qtBHmKCr5U57Ag+DqnFfZ26FUQtL7J44aU
	 VWvtOqdz+HX+jbTqvG6HwBbanhI5QY1suC5c8QRx0ZZnwHBw9fl51Bezv7JhrjnqL4
	 JarfmeV+Dl60Za/ShTb3IedN/e0rsVHybXTousqE=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728306AbgFBV4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 2 Jun 2020 17:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43890 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728012AbgFBV4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 2 Jun 2020 17:56:36 -0400
Received: from mail-lf1-x141.google.com (mail-lf1-x141.google.com [IPv6:2a00:1450:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 361BFC08C5C0
        for <linux-kernel@vger.kernel.org>; Tue,  2 Jun 2020 14:56:35 -0700 (PDT)
Received: by mail-lf1-x141.google.com with SMTP id u16so7131557lfl.8
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 14:56:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZFXpnaRfbFT4qc2OekIf1wIsAFI+MC0nu33d3pEpk/o=;
        b=Pf6ZCcMfs32paMZ+A6vyBAKHYfskO6g12cXyNDwWKdXTZNYfCWP+/YD2fqEFUY6Gcg
         Y7/ubm/9l0oGkth8a9i638SVf7dkUsymUnILaERjpeZ6Rlj7YWZ3VcjcwI7yaO72bFxi
         wjqFS1hTYv6TNtQz1j1Md+NMh+Ni8RqnIN8ro=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZFXpnaRfbFT4qc2OekIf1wIsAFI+MC0nu33d3pEpk/o=;
        b=mk4M1KvsPLvAbos5co/UrNjWYzFCyBU4naJogtWWzo8I16K2RI8bfq9dMl+E23Q/pv
         OMAr4j0584llJup1BhYRLAU3LI4YZ1kjvW7KLChpkfeySXFj6xkEup4DVdUcEJWAwQTs
         qAMTgHnZayeW4MwPaBfm8h8jx2F34Li1kgkbszYW9zgkt4UWr+DFojNmD5CjcLA2mciL
         dvwwH6SQoVlh6xFKVQwZSpYmJdH144wWfAqY64Dr4PtJS0SyKyUKaBWHof4aaEn5q6aD
         lpYKLdQ5vrVvSyOCQFgLMMk6UoVhI0kp2TRr/5lgAxPnfXqQiZDb+KqZ69gK43XQSzpT
         82yA==
X-Gm-Message-State: AOAM533T6ZlqzKt6esFALXqWwAfIPIlMArhLjc5iyAzM2xEdCfjmxkFz
        0pr4h31G/81p4sdUtqZ7HmsXZJwVneo=
X-Google-Smtp-Source: ABdhPJyOyiYVN0CPfij7kWkRqw43E714ZrWXnIH3/OjDTPohUQLrSM3VxwNGMo7Oli+h51mbFSNEyg==
X-Received: by 2002:ac2:4a75:: with SMTP id q21mr709343lfp.190.1591134993273;
        Tue, 02 Jun 2020 14:56:33 -0700 (PDT)
Received: from mail-lj1-f180.google.com (mail-lj1-f180.google.com. [209.85.208.180])
        by smtp.gmail.com with ESMTPSA id i8sm73028lfo.62.2020.06.02.14.56.31
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 02 Jun 2020 14:56:32 -0700 (PDT)
Received: by mail-lj1-f180.google.com with SMTP id z9so108820ljh.13
        for <linux-kernel@vger.kernel.org>; Tue, 02 Jun 2020 14:56:31 -0700 (PDT)
X-Received: by 2002:a2e:974e:: with SMTP id f14mr526774ljj.102.1591134991617;
 Tue, 02 Jun 2020 14:56:31 -0700 (PDT)
MIME-Version: 1.0
References: <CAPM=9txGww+omvateOTizZRV9_wLdAbq6uAz3DRa_S6bn1jQuQ@mail.gmail.com>
 <CAHk-=wjvVjei5d45D=GQMsFMssD8knSFWqxMbd4bH8qSgXk-Lg@mail.gmail.com>
In-Reply-To: <CAHk-=wjvVjei5d45D=GQMsFMssD8knSFWqxMbd4bH8qSgXk-Lg@mail.gmail.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 2 Jun 2020 14:56:15 -0700
X-Gmail-Original-Message-ID: <CAHk-=wiug3vS=J7obQsyCLp+6qQvT5v6ctOddHRXbVgsLFTLwQ@mail.gmail.com>
Message-ID: <CAHk-=wiug3vS=J7obQsyCLp+6qQvT5v6ctOddHRXbVgsLFTLwQ@mail.gmail.com>
Subject: Re: [git pull] drm for 5.8-rc1
To:     Dave Airlie <airlied@gmail.com>,
        Tomi Valkeinen <tomi.valkeinen@ti.com>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Laurent Pinchart <laurent.pinchart@ideasonboard.com>,
        Jyri Sarha <jsarha@ti.com>
Cc:     Daniel Vetter <daniel.vetter@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 2, 2020 at 2:21 PM Linus Torvalds
<torvalds@linux-foundation.org> wrote:
>
> I'm still working through the rest of the merge, so far that was the
> only one that made me go "Whaa?".

Hmm. I'm also ending up effectively reverting the drm commit
b28ad7deb2f2 ("drm/tidss: Use simple encoder") because commit
9da67433f64e ("drm/tidss: fix crash related to accessing freed
memory") made the premise of that simply encoder commit no longer be
true.

If there is a better way to sort that out (ie something like "use
simple encoder but make it free things at destroy time"), I don't know
of it.

I'll let you guys fight it out (added people involved with those
commits to the participants,

                    Linus
