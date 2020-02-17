Return-Path: <SRS0=PfNx=4F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E6E3DC7619B
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 05:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id BC825206F4
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Feb 2020 05:08:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1581916119;
	bh=JM9jWkCDPYYzza1+V+NI8eULjB0Xvy2zTYjan55pPY8=;
	h=References:In-Reply-To:From:Date:Subject:To:Cc:List-ID:From;
	b=T3hUVddMyE+ZZxSZeAscztWeq4WTQQQZ8w0DiFDKf1+ZjveRuJXA3qQP0RAs9oJxJ
	 jl9HyWsyJu9y4bZuY1ZuHTs/hSrmywklt3VUJsfTLIQypLSyjq7cmuZBHwEhaOYe6J
	 cOE78S/orexHij0cIXPg2PiYJUd0hMlx6wiTeur8=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1725985AbgBQFIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Feb 2020 00:08:38 -0500
Received: from mail-lj1-f195.google.com ([209.85.208.195]:36193 "EHLO
        mail-lj1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725280AbgBQFIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Feb 2020 00:08:38 -0500
Received: by mail-lj1-f195.google.com with SMTP id r19so17268414ljg.3
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 21:08:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qcgi3kuYWT+F97MMSY9Af1xrTLZcSD8KEgx4I86REZQ=;
        b=V0CNo2wKtLMflqcZ3QN5b6cM5ItqRqI6/fRPOVs31VlDzbS/0QsFhAC1QURo5bQx5e
         pW2VLt3NagHcaRjpB1KmFY9gqBoy0kvZhm6PhTgwrOHIEgVxZWmnWmqvtCGkTmqt22gH
         q6oCMSYvx/Fg1m9ZdMSXVb/eP5Q/SmH5SrBtw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qcgi3kuYWT+F97MMSY9Af1xrTLZcSD8KEgx4I86REZQ=;
        b=m+GxHJ0NIt53q5af9mdxvcVmJedNHR8DI4Gd4Ya4YNHm0FuzlwPPTeomUVjlD5RpiH
         fnUAmd+vbNedu2hWtKQqVpCtVHREZCojB4MlhfCdl6ssdep//7fNJuMkgo3aslBe1+2D
         qid5oOXc5qqFYJAK7NMdii54mCo0hSnAWu8qiAvPOk+dlJF9K7WHscCwgfkgdy1LYJGW
         hRRGyGmat0UTke0CQ4Qd0e9DUjnLJ3kVVePo+sMXoDgaKrqDtmBerjJ2GJhT9omW3hAz
         ubs9jAT0iOlGEa/5fdL7uzBY+deAiyt1FRpxgGtRubgtDLBVDWrHkNCB09HfZjrOt9bL
         H51g==
X-Gm-Message-State: APjAAAWYLt+NhrVD2lZ08u6NabB3lT+0xZjgksGRys6IfxE5yzs8mB9+
        bYqtkHxBihvxSSIcIIBBcoY3ZFi6F6M=
X-Google-Smtp-Source: APXvYqwTLapBAj4AoKSVPBYxRHwqvQy+XNXURF+4rq4ZbRwxYARh5tiGXfgwZSL2qxPP9FUyTNSIiw==
X-Received: by 2002:a2e:3619:: with SMTP id d25mr8579383lja.231.1581916115569;
        Sun, 16 Feb 2020 21:08:35 -0800 (PST)
Received: from mail-lj1-f181.google.com (mail-lj1-f181.google.com. [209.85.208.181])
        by smtp.gmail.com with ESMTPSA id f9sm7812881ljp.62.2020.02.16.21.08.34
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 16 Feb 2020 21:08:34 -0800 (PST)
Received: by mail-lj1-f181.google.com with SMTP id d10so17285378ljl.9
        for <linux-kernel@vger.kernel.org>; Sun, 16 Feb 2020 21:08:34 -0800 (PST)
X-Received: by 2002:a2e:909a:: with SMTP id l26mr8503500ljg.209.1581916114301;
 Sun, 16 Feb 2020 21:08:34 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wgqwiBLGvwTqU2kJEPNmafPpPe_K0XgBU-A58M+mkwpgQ@mail.gmail.com>
 <20200217020840.GA24821@codemonkey.org.uk> <CAHk-=wg5AkQk-9By-QeyT+5H_t6DLZD=25uOz-ujnV8oEv1Y5Q@mail.gmail.com>
 <8025e1bf-4834-83c6-d12c-4e817f875776@toxicpanda.com>
In-Reply-To: <8025e1bf-4834-83c6-d12c-4e817f875776@toxicpanda.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 16 Feb 2020 21:08:18 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiG+wjLjuDDNiqfL3iLW25yqsMK_gNEWomyMH=8kxOLwQ@mail.gmail.com>
Message-ID: <CAHk-=wiG+wjLjuDDNiqfL3iLW25yqsMK_gNEWomyMH=8kxOLwQ@mail.gmail.com>
Subject: Re: Linux 5.6-rc2
To:     Josef Bacik <josef@toxicpanda.com>
Cc:     Dave Jones <davej@codemonkey.org.uk>,
        Filipe Manana <fdmanana@suse.com>,
        David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Feb 16, 2020 at 7:02 PM Josef Bacik <josef@toxicpanda.com> wrote:
>
> I assume Filipe wrote this based on my patch here
>
> https://git.kernel.org/pub/scm/linux/kernel/git/josef/btrfs-next.git/commit/?id=c821555d2b9733d8f483c9e79481c7209e1c1fb0
>
> which makes it so we can allocate safely in this context, but that patch hasn't
> made it's way to you yet.  Do you want it now?  It was prep for a much less safe
> patchset, but is fine by itself.  Thanks,

I assume it's either that, or revert 28553fa992cb and do it differently..

I'll leave that whole decision to the btrfs people who actually know
the code and the situations and what the alternative would look
like...

               Linus
