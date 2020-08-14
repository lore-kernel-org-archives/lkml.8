Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 319DFC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 02:26:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F95C20855
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 02:26:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="oUAvIzwf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726683AbgHNC0f (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 22:26:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39720 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726632AbgHNC0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 22:26:35 -0400
Received: from mail-il1-x144.google.com (mail-il1-x144.google.com [IPv6:2607:f8b0:4864:20::144])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48847C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 19:26:35 -0700 (PDT)
Received: by mail-il1-x144.google.com with SMTP id z17so7251852ill.6
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 19:26:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=cHegjZcU0XOaLxA3426H5gnc8atFuiYj+6kFdWj5ljE=;
        b=oUAvIzwfnyXhMrJXp9A1vBkMDzpBeKwIYiT7rg6agknOuVfhVMJP0WmQblYydOyP+b
         1IRkiAOB0rQ4pQzNUisgFR1hKz7Zc+hyJhyKG5tC/FXKkQN2GmcVbGwa1VomkiJIMxvs
         YhPvJgcLkgQRgawrhNj6YVc5JN6kSN3vZQ29JHPKzYL3F42gyW8RgLALkytlLfSRGTnu
         Ih5DH3tkN9u5X000+VwM1UJ8vVesRQpuHqEzgvR+/tLzU3931gw5zlIV9CmjGnvWtHQu
         2LSo2uOWbTiXtcsFsvsz2Zk3j+Ey6qWwtwtIQrkr/iZUt4v/KphL7F3OdzripTaL4A1S
         GlbQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=cHegjZcU0XOaLxA3426H5gnc8atFuiYj+6kFdWj5ljE=;
        b=Bwpn6hRFcAQOI9Dy6prtRe273PdJ19JKzUtQoZHqHCnTFoUpCiRxX3csAbogRAZ0UO
         5zqWSUN7fo3MEbOopg7RFdlpa99ylTS0uBRlacGQ6gJUUDhRKZFu57uwYOaiSBwLOo10
         MjRNql4pXyGDDsbWFhUrI0dFCaNk9Sxwr88tSnEqmld2rF0d6ivQcn4fGWyNPdawH/Fw
         lXYKvwh5Ur4IL4BM1ipZrOJ6gCnum/FH2M/MPlBgjetDAY6ZLX7vBiRDuz9Tmcpq3C4V
         14CR+GGGJJMK3j7nvuWySLrd4bNxzDEYbtGl+yYrPNkDs4ENHPlJUaOnxikyCMjwp0OJ
         5ogQ==
X-Gm-Message-State: AOAM533LAeo+U3bwKBiQr+qn7q0JOQ+ZOKIKmeS26Gz8RbgowdSEz88z
        KXWDT4punUXMCK6ZDcAqmsyk81+8vrhKBHMPsdg=
X-Google-Smtp-Source: ABdhPJySR/ElNUPu/PRuA5+q877G96Zj8p+NIBqU+6fXRvhBw3ZZPj6G1VvyjexkX1gnKj4evN8mvAzRBGHG5aS5gxA=
X-Received: by 2002:a92:6904:: with SMTP id e4mr702536ilc.83.1597371994666;
 Thu, 13 Aug 2020 19:26:34 -0700 (PDT)
MIME-Version: 1.0
References: <1597368611-7631-1-git-send-email-zhaoyang.huang@unisoc.com>
 <20200814014355.GS17456@casper.infradead.org> <20200814020700.GT17456@casper.infradead.org>
 <CAGWkznEkTeTq4-wPKBcNsF2vF5SVaFc3xoZmceKSwg34vpkqbg@mail.gmail.com>
In-Reply-To: <CAGWkznEkTeTq4-wPKBcNsF2vF5SVaFc3xoZmceKSwg34vpkqbg@mail.gmail.com>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 14 Aug 2020 10:26:23 +0800
Message-ID: <CAGWkznGUBp+dHk3NugBzfftObosjH7Gg4s8C-AwkQBr5fM6-gw@mail.gmail.com>
Subject: Re: [PATCH] mm : update ra->ra_pages if it's NOT equal to bdi->ra_pages
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Roman Gushchin <klamm@yandex-team.ru>,
        Andrew Morton <akpm@linux-foundation.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 10:20 AM Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
> On Fri, Aug 14, 2020 at 10:07 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Fri, Aug 14, 2020 at 02:43:55AM +0100, Matthew Wilcox wrote:
> > > On Fri, Aug 14, 2020 at 09:30:11AM +0800, Zhaoyang Huang wrote:
> > > > file->f_ra->ra_pages will remain the initialized value since it opend, which may
> > > > be NOT equal to bdi->ra_pages as the latter one is updated somehow(etc,
> > > > echo xxx > /sys/block/dm/queue/read_ahead_kb).So sync ra->ra_pages to the
> > > > updated value when sync read.
> > >
> > > It still ignores the work done by shrink_readahead_size_eio()
> > > and fadvise(POSIX_FADV_SEQUENTIAL).
> >
> > ... by the way, if you're trying to update one particular file's readahead
> > state, you can just call fadvise(POSIX_FADV_NORMAL) on it.
> >
> > If you want to update every open file's ra_pages by writing to sysfs,
> > then just no.  We don't do that.
> No, What I want to fix is the file within one process's context  keeps
> using the initialized value when it is opened and not sync with new
> value when bdi->ra_pages changes.
So you mean it is just the desired behavior as having the opened file
use the initialized value even if bdi->ra_pages changed via sysfs?
> >
> > You haven't said what problem you're facing, so I really can't be more
> > helpful.
