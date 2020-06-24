Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 59F9BC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:35:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 350BB20738
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 17:35:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="cRrtCW2+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2405538AbgFXRfn (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 13:35:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2404908AbgFXRfn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 13:35:43 -0400
Received: from mail-qv1-xf42.google.com (mail-qv1-xf42.google.com [IPv6:2607:f8b0:4864:20::f42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E49B6C061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 10:35:41 -0700 (PDT)
Received: by mail-qv1-xf42.google.com with SMTP id u8so1410419qvj.12
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 10:35:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ee0wVFvE5SzpiD441Nwixx4nQdFPexSgrXG3lD5Yu9Y=;
        b=cRrtCW2+8/AxUuCXozd5kPDFFxGFCIt77Av+dzOFVallbJi0ZAe3ouAGQNvazzutf7
         dRyGMHBrkulboAhmQTol0sb3APJU+gCBYkYAoHr9gc45dp2h2MVZ6QHsNML/4to0bQO5
         zHFNWpah0M9/FG2+JKuPQXai31Lqmin6txJ04t+Gsl7kiPNOaOZedMTX70GLMv9TV9uY
         5vsioxyDn2rDe4WVSEGu76cxMlcSFgc4x2wVxfjjzmQ88Q8KMJi2g7+1UJG7x2hEhIbF
         wTaLtiNb+c92DArV3IWwOs8GXDwp8pQw4AkUwubr3j0s0LG+FdjYJiXVaKK837uXbWOa
         4GbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ee0wVFvE5SzpiD441Nwixx4nQdFPexSgrXG3lD5Yu9Y=;
        b=flE3+d5nD1/Z1+g4A/BUDgQL6fQEsZn32OGot2JPebOnlusG++Dw8vF8XPRPIPJr9a
         osGh8utCuQp0PB1+XVQ1FD6pLfyB+e1cIkHyOjfmeqh6ctZFm7Llx/eHEb/3rhI5g3n0
         XglmmCrBJ14qQ0suc8iT1YHpme+NhnMyPljjueMr9cvi6Ha4OpsUhvigDqjk37zKMMxA
         VsaeSMI7O4zTY3F2QOSXrKU6Sk0v2YcpKvxPdNCN0jCc/mO+B/aIxz5hGRwZ79+dY9GY
         usoq4v//O8K+bU5d0ogffhX/Zm9qqqcDCCI1StDreZR3cYFDGz9+OFaBsFUFmSU3TT+0
         CjCg==
X-Gm-Message-State: AOAM532Q5mvcXt3vcXKcFghEEfamwx/FirF6lOrwA7XafjVIYwv/YiCS
        jd86SWfybE0Bb6wUOjVuIZrLjK9hXz92a0MCgeERqQ==
X-Google-Smtp-Source: ABdhPJzm6xUc7VY+6eB/N06UgfE7+m0MxB0tf02A+14NnkyQmws70cjguIluGb512oWICf+CASf1i0lfXnSW+Aev3Zc=
X-Received: by 2002:a0c:efcf:: with SMTP id a15mr32652655qvt.108.1593020140793;
 Wed, 24 Jun 2020 10:35:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200610151818.1.I666ecd9c6f3c6405bd75831a21001b8109b6438c@changeid>
 <20200612125250.7bwjfnxhurdf5bwj@e107158-lin.cambridge.arm.com>
 <CAD=FV=WuYZRO=sv4ODr0SFk0gTtvCW0dNQXbFGrBDqRgjYv-jA@mail.gmail.com>
 <20200619153851.vigshoae3ahiy63x@e107158-lin.cambridge.arm.com>
 <CAD=FV=XursDFUWL=aGUwFgXc4BugUMdT5e+Fwwo5w2gReCjUaQ@mail.gmail.com>
 <20200623164021.lcrnwpli7wdlsn5i@e107158-lin.cambridge.arm.com>
 <CAJWu+ooXdgqSGisZXnHBtYLo9oQBiaNR=HhKseBN+YFGz-L6Xg@mail.gmail.com> <20200624165500.idrugfgplqgi654v@e107158-lin.cambridge.arm.com>
In-Reply-To: <20200624165500.idrugfgplqgi654v@e107158-lin.cambridge.arm.com>
From:   Joel Fernandes <joelaf@google.com>
Date:   Wed, 24 Jun 2020 13:35:28 -0400
Message-ID: <CAJWu+oqHUq6fvkfRgAx4qx8x1dm-J-h6moeVskCU3gkRybCPqQ@mail.gmail.com>
Subject: Re: [PATCH] cros_ec_spi: Even though we're RT priority, don't bump
 cpu freq
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Doug Anderson <dianders@chromium.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Benson Leung <bleung@chromium.org>,
        Enric Balletbo i Serra <enric.balletbo@collabora.com>,
        hsinyi@chromium.org, Nicolas Boichat <drinkcat@chromium.org>,
        Gwendal Grignou <gwendal@chromium.org>,
        Quentin Perret <qperret@google.com>, ctheegal@codeaurora.org,
        Guenter Roeck <groeck@chromium.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 24, 2020 at 12:55 PM Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 06/24/20 11:49, Joel Fernandes wrote:
> > On Tue, Jun 23, 2020 at 12:40 PM Qais Yousef <qais.yousef@arm.com> wrote:
> > >
> > > On 06/22/20 11:21, Doug Anderson wrote:
> > >
> > > [...]
> > >
> > > > > If you propose something that will help the discussion. I think based on the
> > > > > same approach Peter has taken to prevent random RT priorities. In uclamp case
> > > > > I think we just want to allow driver to opt RT tasks out of the default
> > > > > boosting behavior.
> > > > >
> > > > > I'm a bit wary that this extra layer of tuning might create a confusion, but
> > > > > I can't reason about why is it bad for a driver to say I don't want my RT task
> > > > > to be boosted too.
> > > >
> > > > Right.  I was basically just trying to say "turn my boosting off".
> > > >
> > > > ...so I guess you're saying that doing a v2 of my patch with the
> > > > proper #ifdef protection wouldn't be a good way to go and I'd need to
> > > > propose some sort of API for this?
> > >
> > > It's up to Peter really.
> > >
> > > It concerns me in general to start having in-kernel users of uclamp that might
> > > end up setting random values (like we ended having random RT priorities), that
> > > really don't mean a lot outside the context of the specific system it was
> > > tested on. Given the kernel could run anywhere, it's hard to rationalize what's
> > > okay or not.
> > >
> > > Opting out of default RT boost for a specific task in the kernel, could make
> > > sense though it still concerns me for the same reasons. Is this okay for all
> > > possible systems this can run on?
> > >
> > > It feels better for userspace to turn RT boosting off for all tasks if you know
> > > your system is powerful, or use the per task API to switch off boosting for the
> > > tasks you know they don't need it.
> > >
> > > But if we want to allow in-kernel users, IMO it needs to be done in
> > > a controlled way, in a similar manner Peter changed how RT priority can be set
> > > in the kernel.
> > >
> > > It would be good hear what Peter thinks.
> >
> > It seems a bit of a hack, but really the commit message says the
>
> Which part is the hack, the userspace control? It is how Linux expects things
> to work AFAIU. But I do agree there's a hole for general purpose userspace that
> wants to run and manage a diverse range of hardware.

I meant to say, this patch is a necessary hack of sorts.

> > driver is not expected to take a lot of CPU capacity so it should be
> > expected to work across platforms. It is likely to behave better than
> > how it behaves now.
>
> Doing the in-kernel opt-out via API should be fine, I think. But this will
> need to be discussed in the wider circle. It will already clash with this for
> example
>
> https://lore.kernel.org/lkml/20200619172011.5810-1-qais.yousef@arm.com/

Have not yet looked closer at that patch, but are you saying this
patch clashes with that work? Sorry I am operating on 2 hours of sleep
here.
