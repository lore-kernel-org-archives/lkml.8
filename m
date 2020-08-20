Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E3B84C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:19:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDC302075E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 16:19:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1597940360;
	bh=k7UTghznDIvNHHNYmXPJxMEr2kXchS6BRl1vW7rDTDA=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=2DTrgyKZBp1T2iQ+xgd4KUvs3hqEif0PCWso9hPmCWU0+fzxIxY8ka+xWdRBIZpUu
	 RiDZcDVKysKulgZoHzvPJNQhY3dtsZn9HIntmjzoKet4TOn/rxdmuw2hUQ3DDGHjVC
	 E1H16LHu5k20dqW+IkfWHqc8PVqNdEkQHCGeQNsA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729938AbgHTQTL (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 12:19:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729675AbgHTQRN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 12:17:13 -0400
Received: from mail-lf1-x144.google.com (mail-lf1-x144.google.com [IPv6:2a00:1450:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C484DC061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 09:16:38 -0700 (PDT)
Received: by mail-lf1-x144.google.com with SMTP id c15so1232104lfi.3
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 09:16:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5xeIwLlcwmJre/+GlBmcVZ7Sd7o8tK/OUft1ViF+Bxg=;
        b=VP2o2XQxdH6lx+R+XdDm4NWPrnmnUd3eVwSmAxyehr3UxgL2fLZ64Hq67rzqibjkHR
         J3skI4G4+0Ol2U/jGF4Zv+XZemL2A5VVx+QpRmHnPvprIPX5bZbcGHCaNWMxJr6awKbI
         0eS766tO419YaS+Ky3cNYc6/GJDlKEHHHcyoU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5xeIwLlcwmJre/+GlBmcVZ7Sd7o8tK/OUft1ViF+Bxg=;
        b=eQ5h7U+K+i74YyokzC4uRwx7vhQKKwxs4yAUMQbeos3zYIP/wkPqUAfD9YuDd+tise
         MoX2XbOZAWakEXyJcaYVFRzone+6Z8FEmqCgTVSpfI02PjFYZtUbWRncekhoZF8qC2u7
         D0BDQFmS91bNdntQ8yQqKI1DxQSuSTQsgKaZAUe4PXK2KPxza8H1AMinWJaqE+44lh4d
         FJEW1llRXDjWzOvhoxD41Q1wC6+UkBbhtW+vYTS+bU9GPZbYWchVQGxz1DqmKWUSR9eC
         cKDAerc3BbwrXGO0FSfeOlgvY+L+avFGDorGQliUf0zKj8GzStvhdPstRnrvq9zBOQDr
         0kPQ==
X-Gm-Message-State: AOAM5339MD3XxPdM68ipRGQ93FxcW8Asd0m619xW8MJtcn2Is9DoZqKW
        n65BcYyoKbDpFP0gCyxPvA9g7XT5n+99Ag==
X-Google-Smtp-Source: ABdhPJzWoXZeFKeWb5UgPb55wqz9C9W6W8GscFEnJovbdX/mqgWAv1fYCO5h2HOhkDU7IY4Dgc490Q==
X-Received: by 2002:a05:6512:14d:: with SMTP id m13mr1965521lfo.173.1597940196684;
        Thu, 20 Aug 2020 09:16:36 -0700 (PDT)
Received: from mail-lj1-f175.google.com (mail-lj1-f175.google.com. [209.85.208.175])
        by smtp.gmail.com with ESMTPSA id o1sm533378ljc.3.2020.08.20.09.16.35
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 20 Aug 2020 09:16:35 -0700 (PDT)
Received: by mail-lj1-f175.google.com with SMTP id h19so2702393ljg.13
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 09:16:35 -0700 (PDT)
X-Received: by 2002:a2e:2e04:: with SMTP id u4mr1858085lju.102.1597940195085;
 Thu, 20 Aug 2020 09:16:35 -0700 (PDT)
MIME-Version: 1.0
References: <20200817161132.GA4711@amd> <CAHk-=wh6_eWwvpL=AhOeY0btf_dkpu+0joNzPZWfbBWgAeAhMA@mail.gmail.com>
 <CAPM=9tw8LVWsuA6m_nkUDgm00iz2txYRNZY0b0WWZbyiUVzLEw@mail.gmail.com>
 <CAHk-=wg34bw1ude07nC_XCPOJHZ21-v6117p4574d5S7iP4gxw@mail.gmail.com> <20200820092349.GA3792@amd>
In-Reply-To: <20200820092349.GA3792@amd>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Thu, 20 Aug 2020 09:16:18 -0700
X-Gmail-Original-Message-ID: <CAHk-=wjX=ck_u8uvp=PjGCQ3M9igE-yqyRPsJ54th1gQWpwMnA@mail.gmail.com>
Message-ID: <CAHk-=wjX=ck_u8uvp=PjGCQ3M9igE-yqyRPsJ54th1gQWpwMnA@mail.gmail.com>
Subject: Re: [Intel-gfx] 5.9-rc1: graphics regression moved from -next to mainline
To:     Pavel Machek <pavel@ucw.cz>
Cc:     Dave Airlie <airlied@gmail.com>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Joonas Lahtinen <joonas.lahtinen@linux.intel.com>,
        Rodrigo Vivi <rodrigo.vivi@intel.com>,
        Daniel Vetter <daniel.vetter@ffwll.ch>,
        Chris Wilson <chris@chris-wilson.co.uk>,
        Matthew Auld <matthew.auld@intel.com>,
        intel-gfx <intel-gfx@lists.freedesktop.org>,
        kernel list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 2:23 AM Pavel Machek <pavel@ucw.cz> wrote:
>
> Yes, it seems they make things work. (Chris asked for new patch to be
> tested, so I am switching to his kernel, but it survived longer than
> it usually does.)

Ok, so at worst we know how to solve it, at best the reverts won't be
needed because Chris' patch will fix the issue properly.

So I'll archive this thread, but remind me if this hasn't gotten
sorted out in the later rc's.

             Linus
