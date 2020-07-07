Return-Path: <SRS0=aTFg=AS=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 33BE0C433DF
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 04:17:50 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 075B420708
	for <linux-kernel@archiver.kernel.org>; Tue,  7 Jul 2020 04:17:50 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=intel-com.20150623.gappssmtp.com header.i=@intel-com.20150623.gappssmtp.com header.b="XWtOj3kU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726889AbgGGERt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 7 Jul 2020 00:17:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725825AbgGGERs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jul 2020 00:17:48 -0400
Received: from mail-ej1-x644.google.com (mail-ej1-x644.google.com [IPv6:2a00:1450:4864:20::644])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 438E2C061755
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jul 2020 21:17:48 -0700 (PDT)
Received: by mail-ej1-x644.google.com with SMTP id n26so31261408ejx.0
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jul 2020 21:17:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=intel-com.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc:content-transfer-encoding;
        bh=zYTy3waLkAM1ABF2vWyYrOhBD9lnFcrHQX68YskH13U=;
        b=XWtOj3kU8q/nU8kSfl3gtvSQ0lX/WPPcaajW3FlBA/UOfpjuxa55aw58aJUmSQ1KbP
         gi9ZdG4YzS91HUDzh+IvUsgz5ysUoz1SJh+GgfTjK9u31xPXtgAkQQRupWlIRnEL129+
         CH74fw5oAJyMhFjWb4yqn+gbfmdFxVRfu2cPiaj4xLb7fLdojIxhlyvg5i45rkdC+yFM
         NSkzzoaZuyWM2nZNHg3UU1AEJhVyEUOBClL1Kw1NqBCpJ1lGWtEHCtGfRAayFfOB/S19
         66bEWJacaXh8KQVAbsqyXZbTXq2QHVG5IzDLU4mFcXfRLUKr+pmZdo0pZNuwSBjpd6e4
         2bvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=zYTy3waLkAM1ABF2vWyYrOhBD9lnFcrHQX68YskH13U=;
        b=niTgpwuTHJndVPWNGyR1gQ3DtvbqrVAuLYGLGL5txUCBe2uq/MJ8hLZvqf+q44SUVy
         IRNoArBFxnSH3YEEj7kWukusypneqK0Kb2l+una3xIgSH6etCq97PDpwLaIKhajUNwY6
         DjOAV4GYll/E9t+/N+H0rg/J2w0opkw63CuPd15JAraK3jWYCF4RKFd1qiWyiZxlzbrT
         z3dotYb3mfwToHqhnbd0y5te2tNGN0ctR4SRUy5GVksJJorfo00r+PnW84yUlE3I+vCm
         WhKX9qaj0XG6PpVqRtwCBWy3JG2CuheBMIpoOWvc0/Nxgce6x4MOk+3YetpCkB+dhQQe
         Jb2w==
X-Gm-Message-State: AOAM531aOFhvKHHE2xX/s17QX04ao/V6BacyisLyemy9CCXL/gEgLLb6
        pFSRmXEsZAabPxAfbTtS7Ph1j2BWCLbob07hdj9uTlug
X-Google-Smtp-Source: ABdhPJzsLvlVwtsyuyKqGLl/kTnW5SvfmDXSs+fEuBVHBXLqWJWD4hT1uqx/N0vUhdkRZ7VHgSc3uvd9dLQ3ZLrY9YA=
X-Received: by 2002:a17:906:b888:: with SMTP id hb8mr45453987ejb.124.1594095466811;
 Mon, 06 Jul 2020 21:17:46 -0700 (PDT)
MIME-Version: 1.0
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200705045505.GA2962@1wt.eu> <798B0FBF-D7A8-4631-8581-5D199DA50FF9@fb.com> <20200706160638.GG2999146@linux.ibm.com>
In-Reply-To: <20200706160638.GG2999146@linux.ibm.com>
From:   Dan Williams <dan.j.williams@intel.com>
Date:   Mon, 6 Jul 2020 21:17:35 -0700
Message-ID: <CAPcyv4jXJAYM7kQxzrv0AOhFGnN+=SOvhWxoJr6a09AnvF6cPg@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     Chris Mason <clm@fb.com>,
        "ksummit-discuss@lists.linuxfoundation.org" 
        <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "tech-board-discuss@lists.linuxfoundation.org" 
        <tech-board-discuss@lists.linuxfoundation.org>,
        Chris Mason <clm@fb.clm>, Willy Tarreau <w@1wt.eu>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 6, 2020 at 9:07 AM Mike Rapoport <rppt@linux.ibm.com> wrote:
>
> Hi Chris,
>
> On Mon, Jul 06, 2020 at 12:45:34PM +0000, Chris Mason via Ksummit-discuss=
 wrote:
> > On 5 Jul 2020, at 0:55, Willy Tarreau wrote:
> >
> > > On Sat, Jul 04, 2020 at 01:02:51PM -0700, Dan Williams wrote:
> > >> +Non-inclusive terminology has that same distracting effect which is
> > >> why
> > >> +it is a style issue for Linux, it injures developer efficiency.
> > >
> > > I'm personally thinking that for a non-native speaker it's already
> > > difficult to find the best term to describe something, but having to
> > > apply an extra level of filtering on the found words to figure whethe=
r
> > > they are allowed by the language police is even more difficult.
> >
> > Since our discussions are public, we=E2=80=99ve always had to deal with
> > comments from people outside the community on a range of topics.  But
> > inside the kernel, it=E2=80=99s just a group of developers trying to he=
lp each
> > other produce the best quality of code.  We=E2=80=99ve got a long histo=
ry
> > together and in general I think we=E2=80=99re pretty good at assuming g=
ood
> > intent.
>
> I don't think anybody doubts your intentions. But they say, the road to
> hell is paved with good intentions.
>
> I had a "privilege" to live in the USSR and back there Newspeak was not a
> fiction but a reality.
>
> And despite the good intent, I have a really strong feeling that this
> could be a step in a wrong direction...

I've experienced some professional training classes for visiting other
countries and they tell you helpful things like "avoid making jokes
about X" or "Y topic is sensitive". It's not about censoring it's more
about how to keep discussion focused on the job at hand. So I'm hoping
this is more of the mundane advice of "what's the best way to
communicate my point efficiently to the widest possible audience" and
not a "step in a wrong direction"... time will tell.
