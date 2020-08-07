Return-Path: <SRS0=KWFo=BR=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7DEF2C433E1
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:06:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5A65222C9F
	for <linux-kernel@archiver.kernel.org>; Fri,  7 Aug 2020 19:06:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="FWbrx8uq"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726167AbgHGTGk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 7 Aug 2020 15:06:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59820 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725893AbgHGTGj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Aug 2020 15:06:39 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54AFAC061756
        for <linux-kernel@vger.kernel.org>; Fri,  7 Aug 2020 12:06:39 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id t7so2430045otp.0
        for <linux-kernel@vger.kernel.org>; Fri, 07 Aug 2020 12:06:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zLv6z3MDMuVW61EC2fkzzHGi8++0GERRj/VmpMRNPpc=;
        b=FWbrx8uquzQVwqJv5hztOcbzXrnTCu9fqAAQ0IE1v+p9MlOGSWbUWhYbsm8hLaWK2m
         nQERO7jZSxSbFWWq5x4hgtMrGSVsEy09I7bwf1toeXEFZiEjBh+d9DfLBeNeFZMUjqyP
         d574AxHUn09Uvdm/XkzOb0pWhuP5oWkbtNRwfvw/33f74BZMLenW4ARUZKdAXL842Tjx
         BMk1sXYx071o9L0oAedbxZo1UrA3p1vbjHXiKAeLFeHjILX6Nz6Mshjh4iQcxNxlDmRG
         86F8KMhoX9f88cK29/CD3rrlo7kLHZ0xBJ7zlOv6LvifqvHhCeyBH1A+lXFaw9agT9sK
         MYJA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zLv6z3MDMuVW61EC2fkzzHGi8++0GERRj/VmpMRNPpc=;
        b=rAV8Hw16OKWoZnLe5sgEuRYsdsS5BwuMf/5Scu4lagvl4lVWPmcPCip51p8ZE5mujb
         +IRbhT+BXf9MhUhzGveAs+JaRGFGqRS1MhgUc2HVqO9/kOxhD22/5Q1dlH0JxLrDPpes
         I1h11n4SoKhMk2058awQPKgiJBf3/oX2I8BkTyqlhWf2Xa8Q4g9yK0JlyJXX42IoBUzd
         7L62/k0mFeSFW2U09osRYk0d3NSJpeiUJuCNZl/9NyNf/KBAh0xGBZi6yYCKxSnTArKI
         Y3r17d0nrfhrC8AZxfdcfccxQmSkaONjna+rgZZy+8vmeIeyYM/r4upezR5BvRT6dcj3
         TN8g==
X-Gm-Message-State: AOAM53245nRZIapEIRBwKpS7GUTLcvOj94ld9hF8E1gu8fWDIyxBr4MI
        I7BR66hMLYMMpwV6mqczAheWTQypA1A6XwSOpJg=
X-Google-Smtp-Source: ABdhPJwVJolOgJnLC9C2Rvy+MXOAFNwhTJiYKp2dL8jZ6mb7DyR3pYfGGW6b78hgfsbsIM705UNA1tVhZ20cEUAUBUE=
X-Received: by 2002:a9d:3d77:: with SMTP id a110mr13124283otc.11.1596827198586;
 Fri, 07 Aug 2020 12:06:38 -0700 (PDT)
MIME-Version: 1.0
References: <20200807160627.GA1420741@elver.google.com> <CAOJsxLGikg5OsM6v6nHsQbktvWKsy7ccA99OcknLWJpSqH0+pg@mail.gmail.com>
 <20200807171849.GA1467156@elver.google.com>
In-Reply-To: <20200807171849.GA1467156@elver.google.com>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Fri, 7 Aug 2020 22:06:22 +0300
Message-ID: <CAOJsxLEJtXdCNtouqNTFxYtm5j_nnFQHpMfTOsUL2+WrLbR39g@mail.gmail.com>
Subject: Re: Odd-sized kmem_cache_alloc and slub_debug=Z
To:     Marco Elver <elver@google.com>
Cc:     Alexander Potapenko <glider@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Christoph Lameter <cl@linux.com>,
        Kees Cook <keescook@chromium.org>, kasan-dev@googlegroups.com,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Marco and Kees,

On Fri, Aug 07, 2020 at 08:06PM +0300, Pekka Enberg wrote:
> > Anything interesting in your .config? The fault does not reproduce
> > with 5.8.0 + x86-64 defconfig.

On Fri, Aug 7, 2020 at 8:18 PM Marco Elver <elver@google.com> wrote:
> It's quite close to defconfig, just some extra options for my test
> environment. But none that I'd imagine change this behaviour -- but
> maybe I missed something. I've attached my config. Also, just in case,
> I'm on mainline from Tuesday: 2324d50d051ec0f14a548e78554fb02513d6dcef.

Yeah, it reproduces with defconfig too, as long as you remember to
pass "slub_debug=Z"... :-/

The following seems to be the culprit:

commit 3202fa62fb43087387c65bfa9c100feffac74aa6
Author: Kees Cook <keescook@chromium.org>
Date:   Wed Apr 1 21:04:27 2020 -0700

    slub: relocate freelist pointer to middle of object

Reverting this commit and one of it's follow up fixes from Kees from
v5.8 makes the issue go away for me. Btw, please note that caches with
size 24 and larger do not trigger this bug, so the issue is that with
small enough object size, we're stomping on allocator metadata (I
assume part of the freelist).

- Pekka
