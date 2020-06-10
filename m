Return-Path: <SRS0=CVC0=7X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 84548C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:17:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4A9992064C
	for <linux-kernel@archiver.kernel.org>; Wed, 10 Jun 2020 10:17:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XZIgDoS8"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728226AbgFJKRm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 10 Jun 2020 06:17:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726533AbgFJKRl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 10 Jun 2020 06:17:41 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C44BC03E96B
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 03:17:41 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id v10so34321pgi.8
        for <linux-kernel@vger.kernel.org>; Wed, 10 Jun 2020 03:17:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=czDYLwZNL6pjdON+4UzyuH3LlHKWcXqKlMhabBB8xHA=;
        b=XZIgDoS8IWWqHyL/xzWRouCyK63VOQtER6cI6Kz1CuWJ4b4aUHK6w3dxjDaqfcT28m
         gwWU4MKe4yhS3sn1v+Fi3gkafryuha/4THdfK8jgzlrrlOFZiN19/wb9A/l4wu24B4sz
         gPzYM9WIU3ja0SOB/rjevmFG2cuPu3R22OGX1Fmsmt53q4F/7G5kI8JLq8zhlHpnqK6I
         4nf8y8JNd+twUhSgOS/MdsdeiC/q2lzda1F2z75k4XxfyZcJXtySaRlgZXqa3K3vDKPc
         C9a+mj9t2Zv4928f3v5T+fyT101sdz2noGqo/0eistRJv1k7yCrYepXwcuW2g+lR7a14
         eJ8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=czDYLwZNL6pjdON+4UzyuH3LlHKWcXqKlMhabBB8xHA=;
        b=k7I4BBIF052fPtCFOivTXUxqUXN7r5CSc6QgeeG98YS6Sh/kQGDFVEJrwRGj2d5dvD
         nwZwm1yIyeM5GvelPQn7AHdWSt/hcMypFuORLIxGC/rS0FzqF/kQl+E1WMHT23DUqW2E
         4At2DD8oirzlg1un3C+lIrpIRKmGDmz210z6ETWTnjMlIakLrJYK+L3nrVvB5uYGVOtj
         iel/Ifi7ShFvDjvN8zr7DDMoOXuUIIsh9azvyLoitN+D6umRnFTZYhr2e0aIJoCWtANP
         AVbIvFDrCjuZZTwsYpvpBSS4AFWix/N/DE6g11oANt/Xm5ksZDP2tT1j3pY7gP0sooc5
         sYGQ==
X-Gm-Message-State: AOAM533S1vBjcI/VMD7Cjv/w+CE244qsH/0mVkZ6AW1iw/ciD92/m2Hl
        JxWSLiW4VHsU0w9kDpKDtMO9PYgmIMaSzwLsQgCVgHJsxPo=
X-Google-Smtp-Source: ABdhPJxv6Y4d86vsehGlj5awW5Wd8NpXcXq+J0sWLJnzz4utal3mfd+YAZ5lzEllhbcqdKxh7QSvKL7mVxk50T+J764=
X-Received: by 2002:a62:3103:: with SMTP id x3mr2035588pfx.130.1591784260226;
 Wed, 10 Jun 2020 03:17:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200602223728.32722-1-richard.weiyang@gmail.com>
 <CAMuHMdUfnmm4bXVRvFOmG5DFYR+LtcZ1UviDszr9bByiN=DO+Q@mail.gmail.com>
 <20200604122805.d2ndjmkmti6wl3nz@master> <CAMuHMdXnLUS8F4nWJBqDjoKhBmF2_ihfwe4jTGxuZ1e_WKRNPQ@mail.gmail.com>
 <20200605230610.bizp2j23ivyma5rn@master> <20200605171629.d931068c1a4d720d8faa2704@linux-foundation.org>
 <20200608223112.ftncszh7hfnmqj3m@master> <20200609091649.GX2428291@smile.fi.intel.com>
 <20200609230241.gdqebrspmucnru5k@master>
In-Reply-To: <20200609230241.gdqebrspmucnru5k@master>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 10 Jun 2020 13:17:28 +0300
Message-ID: <CAHp75VdVUNqUsfr19jKHjba8CPTQhbSK+WfTKwZFtCfK0JtRCw@mail.gmail.com>
Subject: Re: [Patch v2] lib: test get_count_order/long in test_bitops.c
To:     Wei Yang <richard.weiyang@gmail.com>
Cc:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Geert Uytterhoeven <geert@linux-m68k.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jun 10, 2020 at 2:06 AM Wei Yang <richard.weiyang@gmail.com> wrote:
> On Tue, Jun 09, 2020 at 12:16:49PM +0300, Andy Shevchenko wrote:
> >On Mon, Jun 08, 2020 at 10:31:12PM +0000, Wei Yang wrote:
> >> On Fri, Jun 05, 2020 at 05:16:29PM -0700, Andrew Morton wrote:
> >
> >...
> >
> >> The test on 64bit machine pass. Since I don't have a 32bit machine by hand,
> >
> >Out of curiosity what that machine is?
> >
>
> It is a Intel Xeon Gold CPU.

I suppose it's x86 (and not ia64).
In this case you can always build an i386 configuration and test on a
32-bit "machine".

-- 
With Best Regards,
Andy Shevchenko
