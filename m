Return-Path: <SRS0=mfLo=CD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9649AC433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 01:26:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 746FD2072D
	for <linux-kernel@archiver.kernel.org>; Tue, 25 Aug 2020 01:26:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="tEp/OEWL"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726189AbgHYB0H (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 24 Aug 2020 21:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725850AbgHYBZ6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Aug 2020 21:25:58 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C1E8C061796
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 18:25:58 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id b16so10834671ioj.4
        for <linux-kernel@vger.kernel.org>; Mon, 24 Aug 2020 18:25:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/BQ53bR9yzL5LCkQfVs+ALLFFuHnjhrGR7al0c4QWdM=;
        b=tEp/OEWL/eQB1zCKQeNoB5C1Gl7GMu1z02dU3GW78P8V9VwSwgXvgSVvQEA/zpLwca
         9LB7yPkk9kfrQ3T2YALjtlFFQCCNJPlxfTIGkBNM4RWVKYAkoBenhNi+d6iqMyil/9L4
         HagHEQGJf4blTAFb6VtuMF4h8Y8NJSKf9J4YAvdMMpzYPfFfSf/qM2O7Z+aAn9hYM1Af
         S2aDHrTZRu+jxrdKqdRNDuGjgZu+qt9prvyLOg5c3dnlJTsMzpOVYMmWwV41AdzqzA3q
         36/Q8ygp6O67P3xRn8CWhv3PigokqiJiKKCh31MXzFu195rf17UFxzV483RIjgxUhfPY
         9+XQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/BQ53bR9yzL5LCkQfVs+ALLFFuHnjhrGR7al0c4QWdM=;
        b=ZVZqr5xCSYHPXB2QwMYaTgGTBRDJutonBlEF5EYnDgp+hPkyb82JcI7pSeBPqPOxOt
         OGZQqxr9uAUpJqwppHGZ8Ao2lOayQqk4CYP2GPsHAPOdx4PReeqY5Jy1gCJtP83RRM7y
         NY83HQT1tS1rF4aqKq9GHOmK66uUq8aDhzjtUeUpOpNv4ipT/u1MQ8TtY+DGzHM6aBlA
         7zewhyQ1yb/HlgCNeUKE1vRoplnAWfvzoO8rTfGLDyZl4VeS9WAmtw3ozkWJ74DDrlGG
         QqOVzRnO2p7YueWa5tcoJKZMZlIo+dGeATQlgJfq2jldDW4E2iMcDxqWW+538gmxFlrn
         SZcA==
X-Gm-Message-State: AOAM532Ng1NmtI9Xu93DOM/JMltNOAATbEToNprSDXk4WXeoQnS/FIF0
        IPN/Vs3PLZNAsb43aiRWVeYLiS12TFOBhtO7MDU=
X-Google-Smtp-Source: ABdhPJw2xfStQ7PbjYeqOx6pCmz+i4QPf/M0ygzrEuKOnEsaqhaU71n3HeAHsNbaN9Ky+owM0M/ybADrcHNtON4O+fs=
X-Received: by 2002:a05:6638:298:: with SMTP id c24mr8439577jaq.20.1598318757876;
 Mon, 24 Aug 2020 18:25:57 -0700 (PDT)
MIME-Version: 1.0
References: <1598001864-6123-1-git-send-email-zhaoyang.huang@unisoc.com>
 <CAGWkznGfc8g3SRd5vBq7sQGFLuc__98c7t21-3j4T1oAViHvgg@mail.gmail.com> <20200821115744.GP17456@casper.infradead.org>
In-Reply-To: <20200821115744.GP17456@casper.infradead.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Tue, 25 Aug 2020 09:25:46 +0800
Message-ID: <CAGWkznGda_V5y99mODJse6STqCN31ADGnYaFBW50ZTzbW7ogyw@mail.gmail.com>
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
We can't just sync ra->ra_pages with bdi->ra_pages as eio and fadvise
will shrink or turbo it, that is why I introduce seq_read_fact in this
commit

> We need a smarter readahead algorithm for mmap'ed files, and I don't have
> time to work on it right now.  So let's stick to the same dumb algorithm,
> but make it responsive to bdi ra_pages being reset.
