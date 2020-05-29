Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 95141C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6955A2076B
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 23:54:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1590796496;
	bh=QKmkFma5ETpdF4f5TAhzH/+39zIBWDpmBvXLcOjqyLU=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=gP3FOCKO1os5jkfGTUQ/RFSLAAFQvyyEor8LNAbJLMp6wgZW7GfHUiMkcdieQLgyP
	 BlEQS9QWkoOnPhViCkhqhk7MyRZlCRJ+B8iIenA7tRqbFE+j4FsSfncHo2478CzDQO
	 1kWyvMdHfuCVfnKkjMlenYobLD5fcrbrLDuIKfiM=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728578AbgE2Xyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 19:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728293AbgE2Xyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 19:54:54 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 84089C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 16:54:54 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id k5so1287923lji.11
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 16:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5/D552LPCtYn3hG6mSDy6RFyAOe2Q9CIedgAxscSO/w=;
        b=TrTI7pxgWN2mRJvQkgrZJSOALr9y0VXSLbhGTXjJTOtPxbRpbuM221ekLHghLwRPKc
         4yruvpBjvjMt7Oc/t4BfFsds7Qc0MkS9/2zCmCg1DGzxkyZxxItJlKqSru+OURADfLEF
         pbowajAyg5bitEYsnjEo+hF/SUbK91s47IjLc=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5/D552LPCtYn3hG6mSDy6RFyAOe2Q9CIedgAxscSO/w=;
        b=kjcRzIcyeOJJ4EYvbR3dTD0ecya76E/YFpJl+8B7iPM1pnul/pas6WHhrIlG0CEeYf
         NXyNjI7Bh3xu26fD8hrCQd1Xkw6/fEXIbngBAml5iTdGBEJgIV6w/JCfUsXPIz4nz5Gq
         z8x7cJaf3hFKbhRpPfNleMIY003VGmzk1XXMvwQooTe6UW3AAOQdP2m19gMeQynk4Ioh
         AEHCEWT8t0qLZmCYZUF7xedHr65ZbjYh+g+SDJGQDNLYUkje6E18OgTrcBqQnWckl4we
         X3qIpuyhVNzLKH5TgEdvsMzfOflRg5X7obtHPp8bXssJlrHjPlSIofqgFW0q/g1KtzHj
         h8kg==
X-Gm-Message-State: AOAM530mLNE/OXxaX3IwY3+UlMvjsVUVq6WteF/B3XcPihG75kpSuQwj
        Rmc7B7D/DmkXPBXfLBO5bwz0Q84fIY8=
X-Google-Smtp-Source: ABdhPJzNc9aQL1m7IKN5eqNaA6b4LVeX4Mm4g8yYin0C+RsPBv/FpaD4P7d98HhK+rTgAeIPMoqNAw==
X-Received: by 2002:a2e:9455:: with SMTP id o21mr5259959ljh.415.1590796492507;
        Fri, 29 May 2020 16:54:52 -0700 (PDT)
Received: from mail-lj1-f178.google.com (mail-lj1-f178.google.com. [209.85.208.178])
        by smtp.gmail.com with ESMTPSA id z13sm2585810lfd.7.2020.05.29.16.54.51
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 29 May 2020 16:54:51 -0700 (PDT)
Received: by mail-lj1-f178.google.com with SMTP id c11so1352725ljn.2
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 16:54:51 -0700 (PDT)
X-Received: by 2002:a2e:b16e:: with SMTP id a14mr4908890ljm.70.1590796491384;
 Fri, 29 May 2020 16:54:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200528234025.GT23230@ZenIV.linux.org.uk> <20200529232615.GK23230@ZenIV.linux.org.uk>
In-Reply-To: <20200529232615.GK23230@ZenIV.linux.org.uk>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 29 May 2020 16:54:35 -0700
X-Gmail-Original-Message-ID: <CAHk-=wgzwp5U4csNhy6rz6CF6tDrnoNOM0tzg_6GhrCzBNRjXQ@mail.gmail.com>
Message-ID: <CAHk-=wgzwp5U4csNhy6rz6CF6tDrnoNOM0tzg_6GhrCzBNRjXQ@mail.gmail.com>
Subject: Re: [PATCHES] uaccess misc
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 4:26 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> The stuff that doesn't fit anywhere else.  Hopefully
> saner marshalling for weird 7-argument syscalls (pselect6()),

That looked fine to me, btw. Looks like an improvement even outside
the "avoid __get_user()" and double STAC/CLAC issue.

> low-hanging fruit in several binfmt, unsafe_put_user-based
> x86 cp_stat64(), etc. - there's really no common topic here.

My only complaint was that kvm thing that I think should have gone even further.

           Linus
