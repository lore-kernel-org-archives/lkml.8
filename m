Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 18C5EC433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 02:56:40 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EAE6320936
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 02:56:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="B4Zl3xGH"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728231AbgGEC4h (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 4 Jul 2020 22:56:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39838 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728004AbgGEC4g (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 4 Jul 2020 22:56:36 -0400
Received: from mail-ed1-x543.google.com (mail-ed1-x543.google.com [IPv6:2a00:1450:4864:20::543])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35666C061794
        for <linux-kernel@vger.kernel.org>; Sat,  4 Jul 2020 19:56:36 -0700 (PDT)
Received: by mail-ed1-x543.google.com with SMTP id e22so31630172edq.8
        for <linux-kernel@vger.kernel.org>; Sat, 04 Jul 2020 19:56:36 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=vBRoyIDDEXWuOdpKocJGfyLVUig4XuQim58BgYt5AW4=;
        b=B4Zl3xGH6a9uCdz1vSO6zx/aNHbXpsWUt8vWTJ5Krm1HzMg8CAN/BFWnHDOCaDmET0
         uAU1hhXbUfdKLPDcOI3/Ah1ui0QeLjz1f5HIow0Zpu+oUK/nnu+YiqQ8XDND4Odm4hnZ
         yABCGSQIbZtvKQCUeOyFXc/64ukaqwyge6uXTdiQGCHm0MS2Bl68ezENCMy6ZO4V/6w6
         Jjyj9wHfIBPN6JXyZn+iMZ7n0gWkyMREyOXa0EdxJEo0QPbfTSxDLJDc2EUqtQAuyKw4
         13nmOZaNiWnNtWHGRXiPjR8+9dOyi8vZ2Hr/P3UD9xmLunmJ3QM++aozNg9m+MQ3Y4IB
         U6QA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=vBRoyIDDEXWuOdpKocJGfyLVUig4XuQim58BgYt5AW4=;
        b=j1zFEq0zonmihFiKt+K08QkNxOoevqZUUC1h2ThXXNDJZ+hKIVvjwLZQPUZBUlkUwr
         QYgLqyS5bTGst0PsiGbR4BcV+FgYWsOiXz2W86XZNuEBL0B8Sx4aba0ep96c+4vP8xVv
         BzHNR1oW4PmGvA3jZiuY+Lvi5JWga+vJ8NDtywIeyGwbfD++G7PgqklAV7YrobuVpGo1
         vhjg7FXW4gqP14qiEZnagotP6DnIKyRDQjmmM5EDquBKFofwC04s4L7afeRDcFAdObFe
         KyUPulZL6ePFsyibcvm3r8Tvv66WrvX8AysNoyrhV5xJw05LMz/KZZXsGuF4elG2dRWD
         uHhw==
X-Gm-Message-State: AOAM530QbwRDLeYXCVszCv5GdoPYwf2Hnps7w5awlY7pWt7wcLQmzGBN
        T1MTNRu0zvXR9JjMwCTJkyTjq8/dPOGlc3zjFwbHx5QU
X-Google-Smtp-Source: ABdhPJwqBqdhktxvnACOO8QFCSHxYt2PEzHgR/vybRWWfR8D9Gqp/tUd4idtWY5ESjf64gys/SOtFc2NeN2pKWzosz4=
X-Received: by 2002:a50:f08c:: with SMTP id v12mr47609189edl.119.1593917794873;
 Sat, 04 Jul 2020 19:56:34 -0700 (PDT)
MIME-Version: 1.0
References: <159389297140.2210796.13590142254668787525.stgit@dwillia2-desk3.amr.corp.intel.com>
 <20200705064348.71d4d51f@canb.auug.org.au> <CAPM=9txOgRYc7RM3fzohB4=Ejcp_xMGLBX_OOCOD=r+W6D678A@mail.gmail.com>
 <20200705121216.2ce2dd46@canb.auug.org.au>
In-Reply-To: <20200705121216.2ce2dd46@canb.auug.org.au>
From:   Dave Airlie <airlied@gmail.com>
Date:   Sun, 5 Jul 2020 12:56:23 +1000
Message-ID: <CAPM=9txud3xg+++205X9s9R5wnxobpNSJWLUu=bp8BOhnX_8hQ@mail.gmail.com>
Subject: Re: [Ksummit-discuss] [PATCH] CodingStyle: Inclusive Terminology
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Dan Williams <dan.j.williams@intel.com>,
        ksummit <ksummit-discuss@lists.linuxfoundation.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        tech-board-discuss@lists.linuxfoundation.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 5 Jul 2020 at 12:12, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi Dave,
>
> On Sun, 5 Jul 2020 09:34:57 +1000 Dave Airlie <airlied@gmail.com> wrote:
> >
> > On Sun, 5 Jul 2020 at 06:45, Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> > >
> > > On Sat, 04 Jul 2020 13:02:51 -0700 Dan Williams <dan.j.williams@intel.com> wrote:
> > > >
> > > > +The Linux kernel is a global software project, and in 2020 there was a
> > > > +global reckoning on race relations that caused many organizations to
> > > > +re-evaluate their policies and practices relative to the inclusion of
> > > > +people of African descent. This document describes why the 'Naming'
> > >
> > > I feel a need to point out that racial issues are wider than just
> > > people of African descent ...  Also, others have pointed out that
> > > slavery is not just restricted to those of African descent.
> >
> > The racial issues are wider than that, and even wider again I'm sure,
> > but in 2020 this is as good a place to start as any, and the trigger
> > as that sentence says was in 2020, there was a reckoning about it
> > mainly due to people of African descent. That trigger has had flow on
> > effects in other countries, but I'm not sure that sentence in any way
> > diminishes that, it's merely an introduction to why this change is
> > happening now.
>
> And reading it again in the (actual) light of day, I see you are right
> and I misinterpreted this.
>
> > As for the non-black slavery, others have never pointed this out
>
> (I did not say "non-black")
>

Sorry I misdirected what you said a bit, and I did misinterpret as
Australia also has it's own indigenous slavery issues,

I was trying to stop the "white slavery" is a thing crew from turning
up on this.

Apologies for accidentally implying something what you hadn't said.

Dave.
