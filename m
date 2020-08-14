Return-Path: <SRS0=KEJG=BY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4A589C433E1
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 02:45:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 183732078B
	for <linux-kernel@archiver.kernel.org>; Fri, 14 Aug 2020 02:45:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="iItyAXbV"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726623AbgHNCpt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 13 Aug 2020 22:45:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726568AbgHNCpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Aug 2020 22:45:49 -0400
Received: from mail-io1-xd44.google.com (mail-io1-xd44.google.com [IPv6:2607:f8b0:4864:20::d44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 189E7C061757
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 19:45:49 -0700 (PDT)
Received: by mail-io1-xd44.google.com with SMTP id q75so9508680iod.1
        for <linux-kernel@vger.kernel.org>; Thu, 13 Aug 2020 19:45:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V67boQdxUh+EKnHxjdSvNlWThBzPWn7l76Hn+22xKwY=;
        b=iItyAXbV4AtTVB/A1XLrODCdqoj3hNd0mtqFqafBesCMzP0JneEhDnMDeck0jmFAh2
         VbAlECWw8BvsK7ymoeea0C3gUUroE4/gQy07gHiZoJbCTySpkZsgoB797bTGJRrr2uW/
         fe6H+M45kvlp6amw/Zfd1DHOpKYCC1tXxgVbb/GsdcCfKkeMw6Ss8t++Ls6DO552Qfvm
         HJmwXyFdd1XzHCrxehmBr21bFd+81TrtHuotW0pBYhjBeNNzCdAsRLoftze9H9ld8i4Z
         sKvdLFvaNsIGnID//lsgKMq5yoO3LlOfh8+rxuASi2lcxpNUZnneJ2TuRZGM7aTPn4E5
         VnrQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V67boQdxUh+EKnHxjdSvNlWThBzPWn7l76Hn+22xKwY=;
        b=DfCbMaodXuDxaAW4zH5eqDbd1d440OFivCYfQXoprSDYX7x0QQYJcptpG+6yJ9TK7U
         66H63U0VCX+QbFTtEspGuebjhVcayuVj4D16djfpcjf+fibWN5zmrl6/ciRqW9fr6eTu
         OLTmJoBd4Ttf90G2ScvIvipg1TQfxAAPr3o0OCBmwONiIL3u8vqB5+ybeapCu+4iDaAx
         RoxyzZyxP3x1RzCZDaIoKRJVyt5JAUSMSY8dbAtIyUfUcn1sVRHZB33wj3RHuH6HzUqe
         rZJ+eq6LxDefibav0XESlB2oCxv+yMyVoHrE1DbVgZ1ImBr/KA9FqgVg+ytep5y96NYb
         P52A==
X-Gm-Message-State: AOAM530/GfJKlSxJuv8cpApyKZalnQr7Rjap9D4Urglpwmc43feTBBLV
        Sd3Tmhct38M9yU52GpqY8+QQFM9IRn5eJUAkI/D9uPnn
X-Google-Smtp-Source: ABdhPJxv78dDDcGjM7FjjbGQA9N/soymYwMvLhLNYrnON0VXAb7bUhjWYnq7xWSjAnw4aa1BnsqNVBpVUFE9CSfeBdM=
X-Received: by 2002:a05:6602:2fcf:: with SMTP id v15mr468637iow.78.1597373148326;
 Thu, 13 Aug 2020 19:45:48 -0700 (PDT)
MIME-Version: 1.0
References: <1597368611-7631-1-git-send-email-zhaoyang.huang@unisoc.com>
 <20200814014355.GS17456@casper.infradead.org> <20200814020700.GT17456@casper.infradead.org>
 <CAGWkznEkTeTq4-wPKBcNsF2vF5SVaFc3xoZmceKSwg34vpkqbg@mail.gmail.com> <20200813193307.d5597367b7964d95f63e4580@linux-foundation.org>
In-Reply-To: <20200813193307.d5597367b7964d95f63e4580@linux-foundation.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Fri, 14 Aug 2020 10:45:37 +0800
Message-ID: <CAGWkznFwDnrSqt68oMp+rcNFT_EgN3ke7-e0Tb1xfXreVXgHYw@mail.gmail.com>
Subject: Re: [PATCH] mm : update ra->ra_pages if it's NOT equal to bdi->ra_pages
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Roman Gushchin <klamm@yandex-team.ru>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 10:33 AM Andrew Morton
<akpm@linux-foundation.org> wrote:
>
> On Fri, 14 Aug 2020 10:20:11 +0800 Zhaoyang Huang <huangzhaoyang@gmail.com> wrote:
>
> > On Fri, Aug 14, 2020 at 10:07 AM Matthew Wilcox <willy@infradead.org> wrote:
> > >
> > > On Fri, Aug 14, 2020 at 02:43:55AM +0100, Matthew Wilcox wrote:
> > > > On Fri, Aug 14, 2020 at 09:30:11AM +0800, Zhaoyang Huang wrote:
> > > > > file->f_ra->ra_pages will remain the initialized value since it opend, which may
> > > > > be NOT equal to bdi->ra_pages as the latter one is updated somehow(etc,
> > > > > echo xxx > /sys/block/dm/queue/read_ahead_kb).So sync ra->ra_pages to the
> > > > > updated value when sync read.
> > > >
> > > > It still ignores the work done by shrink_readahead_size_eio()
> > > > and fadvise(POSIX_FADV_SEQUENTIAL).
> > >
> > > ... by the way, if you're trying to update one particular file's readahead
> > > state, you can just call fadvise(POSIX_FADV_NORMAL) on it.
> > >
> > > If you want to update every open file's ra_pages by writing to sysfs,
> > > then just no.  We don't do that.
> > No, What I want to fix is the file within one process's context  keeps
> > using the initialized value when it is opened and not sync with new
> > value when bdi->ra_pages changes.
>
> So you're saying that
>
>         echo xxx > /sys/block/dm/queue/read_ahead_kb
>
> does not affect presently-open files, and you believe that it should do
> so?
>
> I guess that could be a reasonable thing to want - it's reasonable for
> a user to expect that writing to a global tunable will take immediate
> global effect.  I guess.
>
> But as Matthew says, it would help if you were to explain why this is
> needed.  In full detail.  What operational problems is the present
> implementation causing?
The real scenario is some system(like android) will turbo read during
startup via expanding the readahead window and then set it back to
normal(128kb as usual). However, some files in the system process
context will keep to be opened since it is opened up and has no chance
to sync with the updated value as it is almost impossible to change
the files attached to the inode(processes are unaware of these
things). we have to fix it from a kernel perspective.
