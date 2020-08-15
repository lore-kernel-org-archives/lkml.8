Return-Path: <SRS0=qJsj=BZ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-17.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	USER_IN_DEF_DKIM_WL autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B0645C433E3
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:53:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 908142053B
	for <linux-kernel@archiver.kernel.org>; Sat, 15 Aug 2020 21:53:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="mRenq4I9"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729263AbgHOVxx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 15 Aug 2020 17:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45660 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729147AbgHOVwl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 15 Aug 2020 17:52:41 -0400
Received: from mail-ej1-x643.google.com (mail-ej1-x643.google.com [IPv6:2a00:1450:4864:20::643])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFFF7C0612F9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 21:30:45 -0700 (PDT)
Received: by mail-ej1-x643.google.com with SMTP id m22so11967082eje.10
        for <linux-kernel@vger.kernel.org>; Fri, 14 Aug 2020 21:30:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=B8hFqGgi3bQZQ1euyS6ai4tboC53ELWJOXqJtr0acco=;
        b=mRenq4I9snynCGp0vxFPiCVDkCCQNDXc/K6ZtcuZ9aYc14T6j4LfGTSL76W2C78FHj
         9ysuvUOmUjiz6BohSrUl1ZFUa5eGXkcM17ajneBnN2GAa8tE/1JmVhYYV003u/+TTXlB
         5PU+3MglxIYB4bcsy4marQapECsWL/JhzjQFTsjsiIjNr+2mM/fMS3fgTZ0kx87G81nr
         hjMVVfartF1/UQxG7+kBiDSLzNx3mQzTl7LQp/ThZ+EpXQwIC8ZZshUemWWPYxo9Lkph
         mqfWKo204vTbKUXYyDAOADh51HQQv8HQtHAqQewO+eDfKQ2tz7ztXDxJow4nwiBB2oN+
         R57g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=B8hFqGgi3bQZQ1euyS6ai4tboC53ELWJOXqJtr0acco=;
        b=O8SQG5kR6ECG3wV96iy5N7dwt8pUtDnPKyB5bxHQqd8T1ztGXSkT9pts34pNJWMcPp
         +zhptZL/NbW3b+q2Ydl3LzZWzyEBcSiz2oss1lUSfrUFbBTAryY3alQUe78/8tWws7PY
         7VIZ+odWOJdpDR0BQlyn8m23CaOigp1dUw3BlYhCP1jIypkGEkFpH8G0tIzyjFcG3wvW
         AnGxkiQcAIB2Irbwb8+ftY0DjXS9C94cEKMb5FwFfPYx/hWQJU492Uisv4yva0Q1XoK4
         po5NcYga8VTj0ZRdaBJuqfqCPtZTTkSL8TLnR5Fu23FCILIQFopFPAL7X5MDgU3OQu/+
         +Adg==
X-Gm-Message-State: AOAM533YiC4/0CahWBpcLg8i6xk7BjuNU1StVkrZqf4DJEZfhtX5msDt
        10x5bjgb1+ZpkSR/H52o1I3O52G+0I2ny851bK7Bgc1qG8x8+A==
X-Google-Smtp-Source: ABdhPJylzl07UeWh4gwKVqjg2TjJDuIdme0nwPFQc+XjZRIiG0e+NrtPPR3XvIZYEGtA5Fa+7F994QXhmXoARtLIYMI=
X-Received: by 2002:a17:907:41dc:: with SMTP id og20mr5670047ejb.183.1597465844100;
 Fri, 14 Aug 2020 21:30:44 -0700 (PDT)
MIME-Version: 1.0
References: <20200815035637.15319-1-phillip@squashfs.org.uk>
In-Reply-To: <20200815035637.15319-1-phillip@squashfs.org.uk>
From:   Guenter Roeck <groeck@google.com>
Date:   Fri, 14 Aug 2020 21:30:33 -0700
Message-ID: <CABXOdTcJDub=ffmwn4_Xn0chxdwwu4jNFrh9o3HVVH1Mzt4iSA@mail.gmail.com>
Subject: Re: [PATCH] squashfs: avoid bio_alloc() failure with 1Mbyte blocks
To:     Phillip Lougher <phillip@squashfs.org.uk>
Cc:     linux-kernel <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Philippe Liard <pliard@google.com>, hch@lst.de,
        adrien+dev@schischi.me, Guenter Roeck <groeck@chromium.org>,
        Daniel Rosenberg <drosen@google.com>,
        Nicolas Prochazka <nicolas.prochazka@gmail.com>,
        Tomoatsu Shimada <shimada@walbrix.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 14, 2020 at 8:57 PM Phillip Lougher <phillip@squashfs.org.uk> wrote:
>
> This is a regression introduced by the "migrate from ll_rw_block usage
> to BIO" patch.
>
> Bio_alloc() is limited to 256 pages (1 Mbyte).   This can cause a
> failure when reading 1 Mbyte block filesystems.  The problem is
> a datablock can be fully (or almost uncompressed), requiring 256
> pages, but, because blocks are not aligned to page boundaries, it
> may require 257 pages to read.
>
> Bio_kmalloc() can handle 1024 pages, and so use this for the
> edge condition.
>
> Reported-by: Nicolas Prochazka <nicolas.prochazka@gmail.com>
> Reported-by: Tomoatsu Shimada <shimada@walbrix.com>
> Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>

Fixes: 93e72b3c612a ("squashfs: migrate from ll_rw_block usage to BIO")
Reviewed-by: Guenter Roeck <groeck@chromium.org>

> ---
>  fs/squashfs/block.c | 6 +++++-
>  1 file changed, 5 insertions(+), 1 deletion(-)
>
> diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
> index 76bb1c846845..8a19773b5a0b 100644
> --- a/fs/squashfs/block.c
> +++ b/fs/squashfs/block.c
> @@ -87,7 +87,11 @@ static int squashfs_bio_read(struct super_block *sb, u64 index, int length,
>         int error, i;
>         struct bio *bio;
>
> -       bio = bio_alloc(GFP_NOIO, page_count);
> +       if (page_count <= BIO_MAX_PAGES)
> +               bio = bio_alloc(GFP_NOIO, page_count);
> +       else
> +               bio = bio_kmalloc(GFP_NOIO, page_count);
> +
>         if (!bio)
>                 return -ENOMEM;
>
> --
> 2.20.1
>
