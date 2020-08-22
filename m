Return-Path: <SRS0=ximN=CA=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 96CAAC433E1
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 01:47:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7386820735
	for <linux-kernel@archiver.kernel.org>; Sat, 22 Aug 2020 01:47:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Ua8TDynK"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726585AbgHVBrF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Aug 2020 21:47:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725935AbgHVBrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Aug 2020 21:47:02 -0400
Received: from mail-io1-xd41.google.com (mail-io1-xd41.google.com [IPv6:2607:f8b0:4864:20::d41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98DB3C061573
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 18:47:02 -0700 (PDT)
Received: by mail-io1-xd41.google.com with SMTP id 4so3527202ion.13
        for <linux-kernel@vger.kernel.org>; Fri, 21 Aug 2020 18:47:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dHF10WW8TJA1FQjc9LfnwaeL+wDisEs0yu/R1D6jHbg=;
        b=Ua8TDynKR0J3DZT3d+BCDJiRjd+RbJ0G8rSRCmUTr4oGXrovvNgWL6r6/bvMqgBEs5
         nRPAjd6SCJBzUacgYzce0zKaFCG94gjSd2SKIz3+PQGCfmWsiZikViw2fe88co7PCLNj
         vmtZLqnQ/hDeeLU5/Kr9m8+ahw/COiwkFHcZmcZlSYOTjGMmi77+KsBXnJyMm6gbsfsX
         jPWJdvsn2lXB/yF8MRI3BS3kKJ2pXWqORxzvmWd7CNuONYYxCYsQZVuNPQZg6IknTcPI
         5/8sj654xaI9/c5FLZKfRvqFgycyvw1Ac3M9vhjXt9f9+w0zrx9aldlr49EejUWnUEiM
         BPNg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dHF10WW8TJA1FQjc9LfnwaeL+wDisEs0yu/R1D6jHbg=;
        b=LpzizpHhuynWTbF7OT/S94AU1ZXBmqW0Nxwk/g/wFPtWpPXFO+U6SAhLh8n+ci1QR5
         8bNNxetO6JieSjOhm7Y/1Pz1vH5GdQ3k4sE0J7zqy+VKtANL+rq4gNS2mEIDyMFwp93n
         SVFgjuq3btphLJzhdPjxRYovdREZqpQsuId29Jb8o3vRq5At3p6A8pttELRVyRyUfwsc
         AC3V2ZTwlkllH1KbO8gdg6V1e1lPwOQdqH0o8DYV71cs/823TobEyft4iHC+oiPbuA4H
         gGzMKEEJ4bfVTbqmfVxTPptIcZ5SfhUu4t9d1vXSRAzGdAL+aSPdwUYd6nvYDGjmpZaC
         9JYg==
X-Gm-Message-State: AOAM533pnZOvrAuwLIZ+dYNNF4AT2U/Vq+E3A/ccujtT/c8BGrknexXO
        XRzRFiaCPSRFi+/+h9cbFnJvzBVtE63KhlMFd1Y=
X-Google-Smtp-Source: ABdhPJzGiy/wKZ94YT6A9lwKvuB4/ccSRaq6qp4J55Qgj7eUIuF+2DefNZ2aoPizwKOKnh8AZWr1AqoEoOjkuBRX+Q8=
X-Received: by 2002:a02:c9d5:: with SMTP id c21mr4885337jap.72.1598060821862;
 Fri, 21 Aug 2020 18:47:01 -0700 (PDT)
MIME-Version: 1.0
References: <1598001864-6123-1-git-send-email-zhaoyang.huang@unisoc.com>
 <CAGWkznGfc8g3SRd5vBq7sQGFLuc__98c7t21-3j4T1oAViHvgg@mail.gmail.com> <20200821115744.GP17456@casper.infradead.org>
In-Reply-To: <20200821115744.GP17456@casper.infradead.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Sat, 22 Aug 2020 09:46:50 +0800
Message-ID: <CAGWkznHx-wgp7t_iX5Y6H+kqV8cha1=QS9+2Kbh5M4ZQEbPitw@mail.gmail.com>
Subject: Re: [PATCH v2] mm : sync ra->ra_pages with bdi->ra_pages
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Minchan Kim <minchan@kernel.org>,
        Zhaoyang Huang <zhaoyang.huang@unisoc.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, chunyan.zhang@unisoc.com,
        Baolin Wang <baolin.wang7@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 21, 2020 at 7:57 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Aug 21, 2020 at 05:31:52PM +0800, Zhaoyang Huang wrote:
> > This patch has been verified on an android system and reduces 15% of
> > UNITERRUPTIBLE_SLEEP_BLOCKIO which was used to be caused by wrong
> > ra->ra_pages.
>
> Wait, what?  Readahead doesn't sleep on the pages it's requesting.
> Unless ... your file access pattern is random, so you end up submitting
> a readahead I/O that's bigger than needed, so takes longer for the page
> you actually wanted to be returned.  I know we have the LOTSAMISS
> logic, but that's not really enough.
actually, async read even if hitting the marker will also introduce
huge mount of read by wrong ra->ra_pages, which will be used as
req_size for ondemand_readahead.
>
> OK, assuming this problem is really about sync mmap (ie executables),
> this makes a bit more sense.  I think the real problem is here:
>
>         ra->start = max_t(long, 0, offset - ra->ra_pages / 2);
>         ra->size = ra->ra_pages;
>         ra->async_size = ra->ra_pages / 4;
>         ra_submit(ra, mapping, file);
>
> which actually skips all the logic we have in ondemand_readahead()
> for adjusting the readahead size.  Ugh, this is a mess.
>
> I think a quick fix to your problem will be just replacing ra->ra_pages
> with bdi->ra_pages in do_sync_mmap_readahead() and leaving ra->ra_pages
> alone everywhere else.
>
> We need a smarter readahead algorithm for mmap'ed files, and I don't have
> time to work on it right now.  So let's stick to the same dumb algorithm,
> but make it responsive to bdi ra_pages being reset.
