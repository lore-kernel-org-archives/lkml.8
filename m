Return-Path: <SRS0=shi3=4A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8899BC35242
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 01:03:24 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5D9792070A
	for <linux-kernel@archiver.kernel.org>; Wed, 12 Feb 2020 01:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581469404;
	bh=I1KoEB2fG4nytg4dHf2NGPU53q0vfjTuTQg4v8g1oEY=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=UWqzB40EmlwSiezP7lfQC2eGdEStRIXwif9RSfd34wDeCt6TMkmQDY8tEy/ogxMIB
	 XX0VwGlBPG5aBtSDe/M7jodOzPJdI6E2KBfwgI0ppe1QTJ7X5cxPrFuUiTaSxP0d8N
	 zwfgRtMZDeV/IegVuSnWUHq+MNKui7JF35XGafes=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728198AbgBLBDX (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 11 Feb 2020 20:03:23 -0500
Received: from mail-lf1-f68.google.com ([209.85.167.68]:43618 "EHLO
        mail-lf1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728120AbgBLBDX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 11 Feb 2020 20:03:23 -0500
Received: by mail-lf1-f68.google.com with SMTP id 9so287476lfq.10
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 17:03:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=zy6kGEEkqAsEiZzWHqRtvxnsI6DtM6n9AdiuD2GudTU=;
        b=fBxG1HcrByKfPtNty2DhtyD54YlVBt8nIN51NK2VPpgZ7L26CoMAQYrrNez+Edd1Gn
         KLAHlVWkm3Q8uZOGQqKfncW351w+GkpekQ1AxurxF26lO2WmqXR1y7xwYNvUiRUf7dX7
         p/ZI6Bsp5G+eMc0JFhnEsMBjvUERkEUAYwFn4=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=zy6kGEEkqAsEiZzWHqRtvxnsI6DtM6n9AdiuD2GudTU=;
        b=ZKWadedcZD7fAVq3sV07DzLHxvvzXPviicDhNaQvTuRPHnVnAeGAYX7InJrEVHJw15
         gA1oVUAKnm98uAluu8hBMCO6Z8N70YH5KJ8+WSDNGbGVFp5nKj2fG6b0MznAMh63RJUl
         d4NId4yrDVFVG13OvMe9bS4ZipQ0AuC9vTnxdT7tjcGu4mChlogbyVOUJpqfc80tEucY
         RWfy00N68xmoRId77nNkg4oqVoeVn1SV06bjhlcNkdhUb3Ry0PfCC3t4dWg4GA8SdXZ+
         nnhiBJ+ij6AEZQG26j8EzMqczw0TtAFuGYkpMoBY0IIWedh2rLyLQM8tC8cte/wXeDM/
         G4dA==
X-Gm-Message-State: APjAAAUfE0olNAaZr/IWuevBWVhOEhTFbCT3RyTOKFXzIyIimAZ9Qbwj
        0c/+v+qIywgahyuJ6kNqBS8y27fPfuE=
X-Google-Smtp-Source: APXvYqwZ6Q1zdaKgFPmmBgS/4YPfvd0M4L1YbdQ+VSwHzessMM5cGPgjachiTZf8ZTIuqaT/navcQA==
X-Received: by 2002:a19:48c5:: with SMTP id v188mr5257655lfa.100.1581469400021;
        Tue, 11 Feb 2020 17:03:20 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id y29sm2944267ljd.88.2020.02.11.17.03.18
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 11 Feb 2020 17:03:19 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id y6so334724lji.0
        for <linux-kernel@vger.kernel.org>; Tue, 11 Feb 2020 17:03:18 -0800 (PST)
X-Received: by 2002:a2e:580c:: with SMTP id m12mr6104508ljb.150.1581469398565;
 Tue, 11 Feb 2020 17:03:18 -0800 (PST)
MIME-Version: 1.0
References: <20200211175507.178100-1-hannes@cmpxchg.org> <29b6e848ff4ad69b55201751c9880921266ec7f4.camel@surriel.com>
 <20200211193101.GA178975@cmpxchg.org> <20200211154438.14ef129db412574c5576facf@linux-foundation.org>
 <CAHk-=wiGbz3oRvAVFtN-whW-d2F-STKsP1MZT4m_VeycAr1_VQ@mail.gmail.com> <20200211164701.4ac88d9222e23d1e8cc57c51@linux-foundation.org>
In-Reply-To: <20200211164701.4ac88d9222e23d1e8cc57c51@linux-foundation.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Tue, 11 Feb 2020 17:03:02 -0800
X-Gmail-Original-Message-ID: <CAHk-=wg1ZDADD3Vuw_sXhmBOrQ2xsp8YWxmtWiA6vG0RT-ZQ+A@mail.gmail.com>
Message-ID: <CAHk-=wg1ZDADD3Vuw_sXhmBOrQ2xsp8YWxmtWiA6vG0RT-ZQ+A@mail.gmail.com>
Subject: Re: [PATCH] vfs: keep inodes with page cache off the inode shrinker LRU
To:     Andrew Morton <akpm@linux-foundation.org>,
        Russell King <linux@armlinux.org.uk>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        Catalin Marinas <catalin.marinas@arm.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Dave Chinner <david@fromorbit.com>,
        Yafang Shao <laoar.shao@gmail.com>,
        Michal Hocko <mhocko@suse.com>, Roman Gushchin <guro@fb.com>,
        Al Viro <viro@zeniv.linux.org.uk>, kernel-team@fb.com
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 11, 2020 at 4:47 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> What's the situation with highmem on ARM?

Afaik it's exactly the same as highmem on x86 - only 32-bit ARM ever
needed it, and I was ranting at some people for repeating all the
mistakes Intel did.

But arm64 doesn't need it, and while 32-bit arm is obviosuly still
selling, I think that in many ways the switch-over to 64-bit has been
quicker on ARM than it was on x86. Partly because it happened later
(so all the 64-bit teething pains were dealt with), but largely
because everybody ended up actively discouraging 32-bit on the Android
side.

There were a couple of unfortunate early 32-bit arm server attempts,
but they were - predictably - complete garbage and nobody bought them.
They don't exist any more.

So at least my gut feel is that the arm people don't have any big
reason to push for maintaining HIGHMEM support either.

But I'm adding a couple of arm people and the arm list just in case
they have some input.

[ Obvious background for newly added people: we're talking about
making CONFIG_HIGHMEM a deprecated feature and saying that if you want
to run with lots of memory on a 32-bit kernel, you're doing legacy
stuff and can use a legacy kernel ]

              Linus
