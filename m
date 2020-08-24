Return-Path: <SRS0=wYIT=CC=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.9 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PULL_REQUEST,
	MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56F0DC433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:46:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30ABD206BE
	for <linux-kernel@archiver.kernel.org>; Mon, 24 Aug 2020 07:46:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=linaro.org header.i=@linaro.org header.b="h1hMdmwJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726703AbgHXHqe (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 03:46:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726051AbgHXHqc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 03:46:32 -0400
Received: from mail-ot1-x342.google.com (mail-ot1-x342.google.com [IPv6:2607:f8b0:4864:20::342])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AE032C061573
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 00:46:32 -0700 (PDT)
Received: by mail-ot1-x342.google.com with SMTP id u16so3095436otj.10
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 00:46:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=gO8b4O8TpK8y9afKUQkLartHV1xAUGvXm6rGmn5Qr6o=;
        b=h1hMdmwJt/qgS0tHc5thOhPRzz0fVcSe2EfLWpsOa2B7tmqzCSb/8yitvfVX2nvLH0
         1SjzwnJm6CcMz6qcSWbwcY3Vt6r3mdiAoD6ko3r9TZ8X4ss6CkSCegvllZWNTIbPWnRE
         k3TjYia5vyX5Txd74fDG5JdtelMvwSPrnNuqN9OwoZDuReMAdnusiFYw5YxXjkSnk5vK
         BY2fAE54ylY030bRPItS6xkqhl7ussdMcmiV/ReCS8rRJzeqOj72RjToSGKhIeDlYxCz
         aAmUmdQrGW0ohgGN1jXzLVmMIA5tzwUIcHCzUlfMZWH21wic6kxPeEkJpohN6etL9Fwz
         KyfQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=gO8b4O8TpK8y9afKUQkLartHV1xAUGvXm6rGmn5Qr6o=;
        b=oJfPaxvoKbfuhSarsjMKwZjcwTROv+3JA6B3gch34Tl0aiER93Zb6lAc31JXs3d5u4
         Ve2+C8yTkA3wmVNIfXWxh5M9hra88WnD92tZWXHRQbIJeLrNTvebhPt2gc1rqgSEtxU0
         d2+ciNQrzgl+kXQe9AFzcvL2AKnsN2+BCZEeAlT/eAKtXTf75bpL7ZOZAAjN//vuC1D9
         01okdLpxM4Ougq3spoqybWPTZCw+4E6xhNSCVw6HxM95rDrdTyl7F2bF/vAsK6kuBzJ+
         ylCFDfTWofV7vVpnGTqOgApmJwFZnLnOxSnyv1HrzzqOulcbVfC3AOhDn7MYmQo90PrX
         74tQ==
X-Gm-Message-State: AOAM532c7NB6cgaDvQlBBTmZWWRDk4H2f6cRs/LqCdNe8JZzzYlnh06T
        wWMbSyp3W8Ju2/kdW4koSpgDA+5+G6vPqr8Pow0HIA==
X-Google-Smtp-Source: ABdhPJx1w7bGrkkLM+5Q/SMBCPoUlwsRiW8IIXFX35rTPeWkJ5A/xJQoQh0or88fJ+jXloRxlW46k+npNCoZeTrnRz4=
X-Received: by 2002:a05:6830:20c8:: with SMTP id z8mr2826170otq.324.1598255192051;
 Mon, 24 Aug 2020 00:46:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200526131259.GA97001@jade> <20200821184910.GB3407@lx2k>
 <f7c8bb6e-e732-2565-8b50-20f5504701c9@nvidia.com> <CAOesGMjKq3ECJuaMANq=AyDMLXYvorafMYS3LDr9YMH6M9VdYA@mail.gmail.com>
 <CAHUa44EGf1yayXhHUJLUmbNpueKMZ9jArT4narJLzOVWujHR9A@mail.gmail.com> <d757854b-577c-b8f2-8b67-526385101d68@nvidia.com>
In-Reply-To: <d757854b-577c-b8f2-8b67-526385101d68@nvidia.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 24 Aug 2020 09:46:21 +0200
Message-ID: <CAHUa44FrxidzSUOM_JchOTa5pF6P+j8uZJA5DpKfGLWaS6tCcw@mail.gmail.com>
Subject: Re: [GIT PULL] tee subsystem pin_user_pages for v5.8
To:     John Hubbard <jhubbard@nvidia.com>
List-Id: <soc.lore.kernel.org>
Cc:     Olof Johansson <olof@lixom.net>,
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

On Mon, Aug 24, 2020 at 9:18 AM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 8/23/20 11:51 PM, Jens Wiklander wrote:
> > On Fri, Aug 21, 2020 at 11:19 PM Olof Johansson <olof@lixom.net> wrote:
> >>
> >> On Fri, Aug 21, 2020 at 12:58 PM John Hubbard <jhubbard@nvidia.com> wrote:
> >>>
> >>> On 8/21/20 11:49 AM, Olof Johansson wrote:
> >>>> On Tue, May 26, 2020 at 03:12:59PM +0200, Jens Wiklander wrote:
> >>>>> Hello arm-soc maintainers,
> >>>>>
> >>>>> Please pull this small patch converting the tee subsystem to use
> >>>>> pin_user_pages() instead of get_user_pages().
> >>>>>
> >>>>> Thanks,
> >>>>> Jens
> >>>>>
> >>>>> The following changes since commit ae83d0b416db002fe95601e7f97f64b59514d936:
> >>>>>
> >>>>>     Linux 5.7-rc2 (2020-04-19 14:35:30 -0700)
> >>>>>
> >>>>> are available in the Git repository at:
> >>>>>
> >>>>>     git://git.linaro.org:/people/jens.wiklander/linux-tee.git tags/tee-pin-user-pages-for-5.8
> >>>>>
> >>>>> for you to fetch changes up to 37f6b4d5f47b600ec4ab6682c005a44a1bfca530:
> >>>>>
> >>>>>     tee: convert get_user_pages() --> pin_user_pages() (2020-05-26 10:42:41 +0200)
> >>>>
> >>>> Hi, I noticed this never got merged, but I don't see any follow-up here that
> >>>> retracts it. Is it still pending merge such that I should queue it for v5.10?
> >>>>
> >>>
> >>> I think so. I had marked it in my notes as "accepted, and the maintainer will
> >>> eventually merge it", and I left it at that. It's still desirable.
> >>>
> >>
> >> Looks like it conflicts with some of the later work. Jens, given the
> >> timelines here it's probably easiest all around if you rebase/respin
> >> and send a fresh pull request. I could fix it up but you'd still need
> >> to review that so the amount of work is probably less if you do it
> >> directly.
> >
> > Agree, I'll send a fresh pull request once we have this rebased.
> > The conflict is with the recently added call to get_kernel_pages()
> > when kernel memory is shared.
> > The conflict isn't trivial, I guess we need to handle the different
> > types of pages differently when releasing them.
> > John, would you mind rebasing and posting the patch again?
> >
>
> Sure. Should it be against 5.9-rc2, or something else? I can do this in the morning,
> about 10 hrs from now.

5.9-rc2 sounds good.

Thanks,
Jens
