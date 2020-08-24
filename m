Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D6C16C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 06:51:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id AF2052067C
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 06:51:20 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="thY/ZBCP"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgHXGvT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 02:51:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725730AbgHXGvS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 02:51:18 -0400
Received: from mail-oo1-xc42.google.com (mail-oo1-xc42.google.com [IPv6:2607:f8b0:4864:20::c42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9908C061573
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 23:51:18 -0700 (PDT)
Received: by mail-oo1-xc42.google.com with SMTP id k63so1684775oob.1
        for <linux-kernel@vger.kernel.org>; Sun, 23 Aug 2020 23:51:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=PpxiLXTGal/wt3ks6BO05b4YlWK5pFB0UQ1qa3viVm4=;
        b=thY/ZBCPhvnCSfiETySrPCkEtlwF3IA4JcEb7+CvArxtKe42Nm8ATYMoU3SM07dIca
         +viAwtfw7spoq+oQu/5KgngzQqddDvW9QMP4dPQBvVJSScCMU0RozcVFsExAVsFXv5pk
         MYrTbyfxr74tKSqd757P/hwmx6T3hvsfJe/iJ7+Q55FcLg1dauWTnrmyGixeRg88Sbf5
         Chxw13aO/9h9HHUa7G6dsVn7i5WgUrDqLOoiF5+5bNtjhA+Rd/Uuxc5rdjtZozliNdDm
         cxDBROoFbxmOeHAslfKOm8hU4iKYea2PtepHME2LYEot8P+MlH8dQiYI6LrmxU2VQ0F1
         cClw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=PpxiLXTGal/wt3ks6BO05b4YlWK5pFB0UQ1qa3viVm4=;
        b=EcG9sqA9G9oqLx5LylZE3GAogT+MrXv7HfnlfOpvAgTL0dCVkpr+Ne2PrtzkED78dH
         eMSYXNvNCclEYMsLCqXsVXpM3kRTlR7IAA6tHowvQb6LBYQhFuywOEzbx6OsPYtmSelj
         bjeGNPj/NsYDfsJAqP4EjWInUuo2e5/8zO+VQhLQj/fFRzDBMKv2noV4PPnxgHI00Fju
         +JddgHVodNj9RzZGK9C2vorCBNvgKiLB6ukhlow3V62cQ/u6XW8009OY1VElF7HCXQTV
         XuGRDSerMASAVm+M6vDeWD7VxLzp9Ti33WDnPnv0w1MVOK725Or5YJF+s/HC/mVQDzf4
         niaw==
X-Gm-Message-State: AOAM531DD1Icz6m2pSrI8+7b2gG7OfkNM27O4R4a3ok6cqg1drUD2qIB
        pTdOSnSc5aqD/OMTEyUCKIw58CUqpXXQJdx4iXCAgw==
X-Google-Smtp-Source: ABdhPJx+Pj9zYdHc0o9HEQP/cnQvVo4D2yJy70EETkyBnkGfnjDIhe/IXjscXff+atY7613QMCnz/jk5xwktqR01AhQ=
X-Received: by 2002:a4a:e88c:: with SMTP id g12mr2812812ooe.49.1598251877951;
 Sun, 23 Aug 2020 23:51:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200526131259.GA97001@jade> <20200821184910.GB3407@lx2k>
 <f7c8bb6e-e732-2565-8b50-20f5504701c9@nvidia.com> <CAOesGMjKq3ECJuaMANq=AyDMLXYvorafMYS3LDr9YMH6M9VdYA@mail.gmail.com>
In-Reply-To: <CAOesGMjKq3ECJuaMANq=AyDMLXYvorafMYS3LDr9YMH6M9VdYA@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 24 Aug 2020 08:51:06 +0200
Message-ID: <CAHUa44EGf1yayXhHUJLUmbNpueKMZ9jArT4narJLzOVWujHR9A@mail.gmail.com>
Subject: Re: [GIT PULL] tee subsystem pin_user_pages for v5.8
To:     Olof Johansson <olof@lixom.net>
List-Id: <soc.lore.kernel.org>
Cc:     John Hubbard <jhubbard@nvidia.com>,
        ARM-SoC Maintainers <arm@kernel.org>,
        SoC Team <soc@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "tee-dev @ lists . linaro . org" <tee-dev@lists.linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 11:19 PM Olof Johansson <olof@lixom.net> wrote:
>
> On Fri, Aug 21, 2020 at 12:58 PM John Hubbard <jhubbard@nvidia.com> wrote:
> >
> > On 8/21/20 11:49 AM, Olof Johansson wrote:
> > > On Tue, May 26, 2020 at 03:12:59PM +0200, Jens Wiklander wrote:
> > >> Hello arm-soc maintainers,
> > >>
> > >> Please pull this small patch converting the tee subsystem to use
> > >> pin_user_pages() instead of get_user_pages().
> > >>
> > >> Thanks,
> > >> Jens
> > >>
> > >> The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:
> > >>
> > >>    Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)
> > >>
> > >> are available in the Git repository at:
> > >>
> > >>    git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/tee-pin-user-pages-for-5.8
> > >>
> > >> for you to fetch changes up to 37f6b4d5f47b600ec4ab6682c005a44a1bfca530:
> > >>
> > >>    tee: convert get_user_pages() --> pin_user_pages() (2020-05-26 10:42:41 +0200)
> > >
> > > Hi, I noticed this never got merged, but I don't see any follow-up here that
> > > retracts it. Is it still pending merge such that I should queue it for v5.10?
> > >
> >
> > I think so. I had marked it in my notes as "accepted, and the maintainer will
> > eventually merge it", and I left it at that. It's still desirable.
> >
>
> Looks like it conflicts with some of the later work. Jens, given the
> timelines here it's probably easiest all around if you rebase/respin
> and send a fresh pull request. I could fix it up but you'd still need
> to review that so the amount of work is probably less if you do it
> directly.

Agree, I'll send a fresh pull request once we have this rebased.
The conflict is with the recently added call to get_kernel_pages()
when kernel memory is shared.
The conflict isn't trivial, I guess we need to handle the different
types of pages differently when releasing them.
John, would you mind rebasing and posting the patch again?

Thanks,
Jens
