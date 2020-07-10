Return-Path: <SRS0=2Lxt=AV=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,MENTIONS_GIT_HOSTING,
	SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2029EC433E4
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:15:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EB15D20748
	for <linux-kernel@archiver.kernel.org>; Fri, 10 Jul 2020 14:15:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="BI8hKdk5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728179AbgGJOPo (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jul 2020 10:15:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727003AbgGJOPo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jul 2020 10:15:44 -0400
Received: from mail-pj1-x1043.google.com (mail-pj1-x1043.google.com [IPv6:2607:f8b0:4864:20::1043])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 31F8FC08C5CE
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:15:44 -0700 (PDT)
Received: by mail-pj1-x1043.google.com with SMTP id ch3so2674136pjb.5
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jul 2020 07:15:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Np20KBV9uAuILvx/6WSz0515vYUEpXzeFH3JEsTBmro=;
        b=BI8hKdk5odB0XZTJVe9u7hyENje++L8s5m3m+2QRAKeMaT5p7ww6Xd2Q91myLFzP63
         +qeMBoCuiVS44MmhUEYrBUBHJ83ldlORQFxpKavoHlt55hoAokkclCsoye6wdf+8IH/D
         bLj91m/n9F4fpygp1P1FimXNgGOiKinC0DITm7cdHIQkM3CxWs60PlUkmthlFkyhNrqo
         OUrk2DLAWhEx3Q1zl/ei57LOQ8ItFBziEkfHlXsEm7cOJuLJVFmBltg+wvVGXlPlJ0jT
         G4/O2uwEgWj9lCjgd9326qFZzeYD3Z6NcQK1hnETesCHj7x9s6KrSussYIHcYuzPSWIq
         LL0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Np20KBV9uAuILvx/6WSz0515vYUEpXzeFH3JEsTBmro=;
        b=kCMQ2uH5jDer10pc3XUEmGToy/+YWg4zocNbSELyqAvCiDpuTV1ucZ51TwppE5C/PS
         Mab2LPwU3bmUp36PWkrRRICDKp7PhepYAxig+Y2a4A3VkKJiGCfqEl7nUXJnlmPny17a
         G1m6bW07d9FyVp23rF0iSLHeXwyCHlcvO0pTi+nDZ1YfNjAY7v86C2uQKE1gIqOmQOxy
         5T04Q1BijZZ4POJpA97f42bU3bbp6jlqsANX3xgOdWWHUbLqyuTyLnT9/GfLIsVM2jh8
         iedTWWNSuQZ9E8/qYO2DIYuZmEbehPbEQIoQqB080Ncp1VOoMrUfj19Tj5jpqkPimWFN
         PhlA==
X-Gm-Message-State: AOAM532B5mW5BxczqCjYR5OEa479h91/y6CLajp/qGPlsAYJh2VGH1XT
        6CNiuOzm9ds0vHGN++q2l8H3slkgOA18xzaFhaQ=
X-Google-Smtp-Source: ABdhPJx2U+o/XgGNmTpcxCpf4xQ8vT9sr8876SJOyCMzqMkthrlhTGqVJfmGSbU8lWCLU/U50JVoU21gyHn6frGBFH0=
X-Received: by 2002:a17:902:7288:: with SMTP id d8mr60676028pll.18.1594390543743;
 Fri, 10 Jul 2020 07:15:43 -0700 (PDT)
MIME-Version: 1.0
References: <20200708161232.17914-1-andriy.shevchenko@linux.intel.com>
 <20200708162117.GV4655@sirena.org.uk> <20200710100558.GI3703480@smile.fi.intel.com>
 <20200710110132.GA5653@sirena.org.uk> <20200710114622.GJ3703480@smile.fi.intel.com>
 <20200710120856.GD5653@sirena.org.uk> <20200710133233.GF5653@sirena.org.uk> <CAHp75VeWmWU6=ybDmQmv7ymwaHG+FxNBzZM9eBxp2Oie6MrZQw@mail.gmail.com>
In-Reply-To: <CAHp75VeWmWU6=ybDmQmv7ymwaHG+FxNBzZM9eBxp2Oie6MrZQw@mail.gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 10 Jul 2020 17:15:27 +0300
Message-ID: <CAHp75VcKSRem-eHi2FY89Y0yZcJrMVX_p_-OnF8+NuCrBSZfuA@mail.gmail.com>
Subject: Re: [PATCH v1] regmap: Switch to use fwnode instead of OF one
To:     Mark Brown <broonie@kernel.org>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 10, 2020 at 5:13 PM Andy Shevchenko
<andy.shevchenko@gmail.com> wrote:
>
> On Fri, Jul 10, 2020 at 4:36 PM Mark Brown <broonie@kernel.org> wrote:
> >
> > On Fri, Jul 10, 2020 at 01:08:56PM +0100, Mark Brown wrote:
> > > On Fri, Jul 10, 2020 at 02:46:22PM +0300, Andy Shevchenko wrote:
> >
> > > > You mean it's being synchronised with git.kernel.org, but not yet contains that
> > > > patch? Okay, I will monitor the regmap tree (as of now I didn't see any update).
> >
> > > 5cc2013bfeee756a1ee6da9bfbe42e52b4695035
> >
> > Oh, I see your patch covered a different bit of code without covering
> > the stuff in regmap-irq (which I'd just handled when your patch came in)
> > for some reason so the changelog made it sound like the same code, and
> > at the time you submitted it the patch was incomplete.
>
> Should I do anything to improve it?

Actually I think we can completely get rid of fwnode by switching to
device properties.
I'll send v2 soon.


-- 
With Best Regards,
Andy Shevchenko
