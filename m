Return-Path: <SRS0=/EmK=CQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 356F6C433E2
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:55:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id ECC072080A
	for <linux-kernel@archiver.kernel.org>; Mon,  7 Sep 2020 17:55:40 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=bgdev-pl.20150623.gappssmtp.com header.i=@bgdev-pl.20150623.gappssmtp.com header.b="nSd/soCN"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729554AbgIGRzj (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 7 Sep 2020 13:55:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42498 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728849AbgIGLWK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Sep 2020 07:22:10 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E78F4C0617A3
        for <linux-kernel@vger.kernel.org>; Mon,  7 Sep 2020 04:05:10 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id r9so13599668ioa.2
        for <linux-kernel@vger.kernel.org>; Mon, 07 Sep 2020 04:05:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=D7L/Q4DJFDyy3wME7bzPuJcv0cvFqGwJhESn1U89F5s=;
        b=nSd/soCN0apStHfecRk/s8TMfk39mqUYPzh0zB/X6CwR4xUJSFFU0FnKp+tCRk7Dxr
         dxSOcRUml8zVB79Fm2ThAGwZhIwsZ9OPmOav7mp6gqCv2iIgBSeA1XcFFigkWUwrAK5g
         9ndJPPydL6JRbTIBSOe3jO9NlRlqGqnPBFwmtIdWaVf0VLsqOiLVD+eqxcWPZTRO07W7
         is0PyDyIhur30ZJJ3E4ZHzRu488xo7wU4cH2gwBwuSF1nT5thgx8mQqsqsWBwrJymYo4
         fK3WRuZDjVxGovSSlKSdckuotXq/ExsbHzIplL+6mbf3IlXZbkQt1rlDd+5u09yoRPvf
         zCdQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=D7L/Q4DJFDyy3wME7bzPuJcv0cvFqGwJhESn1U89F5s=;
        b=r5Eyp3/jIonHMq9cadcVe6ByZNqbayJopDtYem6zcBLlaGLQOyLtcQ4SAFyxDdoMVS
         45xv9bAfsvzbxgYZWVjzIUuQigQJtWF9C67MyCeSznEE/s6zYO5uIbrZPFEo40ElSQC+
         fUvGnSVBeVAciuEMEi+mMPIVEMR+HlbMxT66VAbGr/N5A9Uwcc0JLIPblh+Yyp9LX7eU
         b8WJZeLu3EL38tOa8IDv6y1GIdL2O00dSVl+nkY+QX5XBj/VBCIHG/5NuyYdUNCaWIhR
         wu1OkBl1ZfGqCVrK7FMr+8n/3y9cZ3oS7atHRYynKeNNhKoVWRLtZtR+BVur8Mayc0TQ
         nBVg==
X-Gm-Message-State: AOAM532pGYny5fxGEQSy1cMAtTcdbVSg4icJ4CQNA7Bls285rm2qgMDQ
        IeVjedCy8zmaxn4apgY0eq1abo/wLwcrDOn41MA7Fw==
X-Google-Smtp-Source: ABdhPJz3NFAUNOM8h+eBu94NlN0+qbyZT3uPxFzJlrWhGBVdmuhRiYP3jSvAoS1qQWhXj2axsT/rlnUltkSo/hZcc5c=
X-Received: by 2002:a02:7817:: with SMTP id p23mr8145520jac.57.1599476710278;
 Mon, 07 Sep 2020 04:05:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200904154547.3836-1-brgl@bgdev.pl> <20200904154547.3836-11-brgl@bgdev.pl>
 <20200904170028.GG1891694@smile.fi.intel.com>
In-Reply-To: <20200904170028.GG1891694@smile.fi.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Mon, 7 Sep 2020 13:04:59 +0200
Message-ID: <CAMRc=Mc3V_BJ88CrB_q0uTHjvqVf5XEkm6BJZwrVjnVhPjiYaQ@mail.gmail.com>
Subject: Re: [PATCH 10/23] gpio: mockup: fix resource leak in error path
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Mika Westerberg <mika.westerberg@linux.intel.com>,
        Kent Gibson <warthog618@gmail.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        linux-doc <linux-doc@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-acpi@vger.kernel.org,
        Bartosz Golaszewski <bgolaszewski@baylibre.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Sep 4, 2020 at 7:00 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> On Fri, Sep 04, 2020 at 05:45:34PM +0200, Bartosz Golaszewski wrote:
> > From: Bartosz Golaszewski <bgolaszewski@baylibre.com>
> >
> > If the module init function fails after creating the debugs directory,
> > it's never removed. Add proper cleanup calls to avoid this resource
> > leak.
>
> Does it fix existing bug?

You mean - should it go into stable? The bug is quite unlikely but
yeah, probably.

Bart
