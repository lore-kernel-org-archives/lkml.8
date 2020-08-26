Return-Path: <SRS0=kGB5=CE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AAE16C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 20:47:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7188E2078D
	for <linux-kernel@archiver.kernel.org>; Wed, 26 Aug 2020 20:47:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EeJGB+bN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726936AbgHZUrt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 26 Aug 2020 16:47:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33298 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726609AbgHZUrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 26 Aug 2020 16:47:49 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EFCF7C061574
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 13:47:48 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id w14so2981067eds.0
        for <linux-kernel@vger.kernel.org>; Wed, 26 Aug 2020 13:47:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sJF2r4IwmIZq99VWTXXWIszVLGDt1t4aH8Ksrukp3Co=;
        b=EeJGB+bNo+1YrRyoEXBzcdjN2ZxgpSGWFvAbLtBCq5WtZW3J8zvyYPAzmZh/RXTxif
         Uv3VY2qn8+UNkLd7X7F6GKARcIseUp5rr9YjbdLSiY91xIOTc0Hbi4edChbdrU0b2lJ9
         eHtA2XxVcTv92iCehank84Kkg1b+xtNFYZozTxbHyETLu5DyinT4hM+z8ZNcW5BYDZrC
         7HqAdUZsLOADX/pY4ex7UE1SfDObV1LDrgk6XdXukBHVtQRpwC6frws7d+3B920chJBx
         f74kXDRrlQPRmD9GNZ+7SEJWwZPPJ0daNmK1QTaZLU4n6V8o0dkcK15XvHfaRSeryPk/
         8uJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sJF2r4IwmIZq99VWTXXWIszVLGDt1t4aH8Ksrukp3Co=;
        b=O0mHvD6U7mOUYLD7OPPRNqCz2byHcZ/IEtbIrrpabA6PGS4y6iaaxB1HBR41SZqAYQ
         lxoAR/MbsFGZw5jeq3jKppouIY9Cn5pxQd0tMwaPMwA3kMUfGy5FO1jWdAFqdUNVtlOF
         kSOQOBJMcLqDWRdKtVSrMHLr1FwlbREok+Pq/7g/zWgzPTr8ynIIn987S2mr+6xIu7Sv
         pgmg7tTj7qBrH2syVmHw5jHUMjJumB1o5sWusJThjK4IuVW+j1ImCqs4MRsDDASn6rL6
         pMeax0PS8okj5AUjAs9yxnBfrgz/j1ShOdYEsGcfYixnwYGEfSJ2ONE4QISZwh7WoB3L
         2FjQ==
X-Gm-Message-State: AOAM53366lhI+uQCdDz5ltqc2+xDpSGFayqM7LdVxNB9ghDIxffnChMa
        IMjZZGDEbtixPInNwSF3eAVB4Pwdzfky/k51Cqw=
X-Google-Smtp-Source: ABdhPJytNY4HIDQTfjuIQjCyQCbpo8gj+Z9E8W5g4rNc8e+pOKq/H91bL6NDsdOkCUIGCKMYd/uG0mWsxx9BnrUq2TU=
X-Received: by 2002:aa7:dbd9:: with SMTP id v25mr11539936edt.78.1598474867612;
 Wed, 26 Aug 2020 13:47:47 -0700 (PDT)
MIME-Version: 1.0
References: <20200817161132.GA4711@amd> <CAHk-=wh6_eWwvpL=AhOeY0btf_dkpu+0joNzPZWfbBWgAeAhMA@mail.gmail.com>
 <CAPM=9tw8LVWsuA6m_nkUDgm00iz2txYRNZY0b0WWZbyiUVzLEw@mail.gmail.com>
 <CAHk-=wg34bw1ude07nC_XCPOJHZ21-v6117p4574d5S7iP4gxw@mail.gmail.com>
 <20200820092349.GA3792@amd> <CAHk-=wjX=ck_u8uvp=PjGCQ3M9igE-yqyRPsJ54th1gQWpwMnA@mail.gmail.com>
 <20200821091900.hzbivycs5ky5d3iw@duo.ucw.cz> <87tuwr59te.fsf@intel.com>
 <7efa547d-b7a4-b873-f1aa-4f19eb849fa3@skogtun.org> <CAHk-=wj3WskPCtHncCWLdaP6xVecLp8bDBTT57vyiU-0=Ld6QQ@mail.gmail.com>
 <d4db4a52-3001-cb02-4888-a9dfd55cdd7c@skogtun.org> <656b8f9f-d696-c75d-aef6-2b8b5170f2f6@skogtun.org>
 <CAHk-=wiAK=AiqTD47o-BFFZciQXpEC0SiiDnXLWJUcQtCo-Pig@mail.gmail.com> <101bff45-0ebd-8fb6-7c99-963aa4fcc588@skogtun.org>
In-Reply-To: <101bff45-0ebd-8fb6-7c99-963aa4fcc588@skogtun.org>
From:   Dave Airlie <airlied@gmail.com>
Date:   Thu, 27 Aug 2020 06:47:35 +1000
Message-ID: <CAPM=9twLvHu_XLJ89GVXpNo=PHPZLJuRpHggkfzvvuVf+xrwoA@mail.gmail.com>
Subject: Re: [Intel-gfx] 5.9-rc1: graphics regression moved from -next to mainline
To:     Harald Arnesen <harald@skogtun.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jani Nikula <jani.nikula@linux.intel.com>,
        Pavel Machek <pavel@ucw.cz>,
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

On Thu, 27 Aug 2020 at 06:44, Harald Arnesen <harald@skogtun.org> wrote:
>
> Linus Torvalds [26.08.2020 20:04]:
>
> > On Wed, Aug 26, 2020 at 2:30 AM Harald Arnesen <harald@skogtun.org> wrote:
> >> Somehow related to lightdm or xfce4? However, it is a regression, since
> >> kernel 5.8 works.
> > Yeah, apparently there's something else wrong with the relocation changes too.
> >
> > That said, does that patch at
> >
> >   https://lore.kernel.org/intel-gfx/20200821123746.16904-1-joro@8bytes.org/
> >
> > change things at all? If there are two independent bugs, maybe
> > applying that patch might at least give you an oops that gets saved in
> > the logs?
> >
> > (it might be worth waiting a bit after the machine locks up in case
> > the machine is alive enough so sync logs after a bit.. If ssh works,
> > that's obviously better yet)
>
> No, doesn't help. And I was wrong, ssh does not work at all when the
> display locks up.

Did you say what hw you had? is it the same hw as Pavel or different?

Dave.
