Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D70DCC433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 02:20:25 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A966220639
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 02:20:25 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="XndHlTSw"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726597AbgHNCUY (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 22:20:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726522AbgHNCUX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 22:20:23 -0400
Received: from mail-il1-x143.google.com (mail-il1-x143.google.com [IPv6:2607:f8b0:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 472CBC061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 19:20:23 -0700 (PDT)
Received: by mail-il1-x143.google.com with SMTP id z3so7267276ilh.3
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 19:20:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CkLV7ie2J+t0XB/OSS4F8NU6METCllJZJy8f/Ga/ZDk=;
        b=XndHlTSw0ANSubbW8BKu8mD78kMKS5Qyf/8xvUa+nMg1KbyYxoSvlncSkfVjuSXxTE
         5oHqXT5V9gn0jyP+ku7ucfdiIorKlvcvcd4OXxdmNvvzUuKIsR9ymd59jm0prhSd4p4I
         RIZminFBDB7ASFwA8EUTSQKE22N23umlFPzQXDIsMAqT3CdnhNfXeKJyHkX2eP4EY3bZ
         lohLxsW3twdgUlkhrvwIYPbCyhs83B2cc1Yuldc/G6sekQRvpDlsvBS39yrnAtq5fO0m
         8x7elm3WasH3RUpbtEJMfVrm93XaiI4IWlquk9NZb50PHWEgo1puRB5eTN1ZbNI6Ca+p
         l4Zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CkLV7ie2J+t0XB/OSS4F8NU6METCllJZJy8f/Ga/ZDk=;
        b=oIB38RO8IPiTuKhrl62auKDEBzpxSLoYgN74xxdaIs9H/rLx6DNHND7xvs1mfD424e
         rX8z+2MEENi1K67s+H+CWCtRG8sfIC55kreBP23HjSrcpZGR5bvth6cHtzfWlG6ZeaJa
         qIC9YOP/rjOUZ/OKnlw+MEZmMnYr9/O35tgSAZM4hHJp33/Kmf1/voGxbKSW+fyjV33T
         w6Dsf8xdP2DAFbWgSEAteRoMGpxqMgbURSolS5kLuUMJHa9AwVyIZjy5soILS2fEB2BL
         QgWz30fuYNBv4U2rtYL1o4Zi3jFe2l5q/xpP1mMQ3yb/7sNB90ZmlHVZwv3g0fnbyhwJ
         tgLw==
X-Gm-Message-State: AOAM532zwRovQhd1RUzcM7rPjrBehIrN4NeGIUsTdZ5a09b73TFHVwOU
        ZPI/N2XGHb0Y/Z45Bk7fAEi+XUP++7Z/5kJ1A8A=
X-Google-Smtp-Source: ABdhPJxS1ITSn4yt2q6cxPjycgYcLi8b2Fdp+jxRcd1zrznyP+kc2U7fWY+HD+9qxKlI+W8jvhG/CAhDhkS8E3lLnCM=
X-Received: by 2002:a92:6904:: with SMTP id e4mr684998ilc.83.1597371622512;
 Thu, 13 Aug 2020 19:20:22 -0700 (PDT)
MIME-Version: 1.0
References: <1597368611-7631-1-git-send-email-zhaoyang.huang@unisoc.com>
 <20200814014355.GS17456@casper.infradead.org> <20200814020700.GT17456@casper.infradead.org>
In-Reply-To: <20200814020700.GT17456@casper.infradead.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 14 Aug 2020 10:20:11 +0800
Message-ID: <CAGWkznEkTeTq4-wPKBcNsF2vF5SVaFc3xoZmceKSwg34vpkqbg@mail.gmail.com>
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

On Fri, Aug 14, 2020 at 10:07 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Aug 14, 2020 at 02:43:55AM +0100, Matthew Wilcox wrote:
> > On Fri, Aug 14, 2020 at 09:30:11AM +0800, Zhaoyang Huang wrote:
> > > file->f_ra->ra_pages will remain the initialized value since it opend, which may
> > > be NOT equal to bdi->ra_pages as the latter one is updated somehow(etc,
> > > echo xxx > /sys/block/dm/queue/read_ahead_kb).So sync ra->ra_pages to the
> > > updated value when sync read.
> >
> > It still ignores the work done by shrink_readahead_size_eio()
> > and fadvise(POSIX_FADV_SEQUENTIAL).
>
> ... by the way, if you're trying to update one particular file's readahead
> state, you can just call fadvise(POSIX_FADV_NORMAL) on it.
>
> If you want to update every open file's ra_pages by writing to sysfs,
> then just no.  We don't do that.
No, What I want to fix is the file within one process's context  keeps
using the initialized value when it is opened and not sync with new
value when bdi->ra_pages changes.
>
> You haven't said what problem you're facing, so I really can't be more
> helpful.
