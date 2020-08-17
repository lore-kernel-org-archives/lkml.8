Return-Path: <SRS0=ysYr=B3=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.8 required=3.0 tests=BAYES_00,DKIMWL_WL_HIGH,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 777F6C433DF
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:59:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 406DC20658
	for <linux-kernel@archiver.kernel.org>; Mon, 17 Aug 2020 19:59:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="WybhKnmc"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729529AbgHQT7U (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 17 Aug 2020 15:59:20 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:32285 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1729118AbgHQT7S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Aug 2020 15:59:18 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1597694357;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Akt231nbJT27WH5md9D56a/U0FCRNSIPTF5o4fM5va4=;
        b=WybhKnmcCi0rTAuvcZB17plFfKUaLqveWIby4onHUFQUQwPIrbxK6voQC+4ASj500y5ZC5
        rBGhhNYMGsLYdP703Sgf9FC5ewk0Vrk0P0aHQcfExD6C11dm4/Y04q64b0JMaG2r1BEC0V
        zoBI1xDy/jSP1goJ9NQ/28akfOPR+uw=
Received: from mail-oo1-f70.google.com (mail-oo1-f70.google.com
 [209.85.161.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-225-NYEHXarkPcKIVr2WXdzdHQ-1; Mon, 17 Aug 2020 15:59:15 -0400
X-MC-Unique: NYEHXarkPcKIVr2WXdzdHQ-1
Received: by mail-oo1-f70.google.com with SMTP id t20so8717664oot.7
        for <linux-kernel@vger.kernel.org>; Mon, 17 Aug 2020 12:59:15 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Akt231nbJT27WH5md9D56a/U0FCRNSIPTF5o4fM5va4=;
        b=dV9ODEpob9aTbeIFbrfOIZT4OXvJ6brhZTtIsFdngvOoArygi/hoAWWtwMRQv+4eEs
         5ALNrvmq9hf8zYnKqf/6WVhO+dJs4ybUfLA5w2tvZsI7HNV5ywEdMXKN9AOpaifCKGK+
         ZSL4EpLOEAupB15HASZ8kv99beJkO1qMOO3wihCbw2oD3kh5GctyS7QOm5LwnTIfdt7k
         Wy0GdpIvU//HVWN4bqWx5H15OlVLZlh0xhoCrLCtTaqaBuL/BIF8XjIonbPhl77yyMJF
         5Y8kPBUDB/3lBabhFAzkQYpnokqwUjjDP4IeubHm82TepeYU0tSdRY1g2uO1TcNalGH3
         ZLTg==
X-Gm-Message-State: AOAM531dXqWc82tfWrY07aSxr8uhDcTg7sVIw4kWkEZ2GDkaq0aFaX6S
        afwHIqZ+ECjjsYTwnMQcgCmRtghAwQySjUSJ/e8QJn35S7cLIYIEg5b76SqrVCfvvRJV2g1+MB0
        9vaMklybUssiQ5vMivPkSOuJnEfkXcISSzkKjgv9j
X-Received: by 2002:aca:5295:: with SMTP id g143mr10368058oib.178.1597694354775;
        Mon, 17 Aug 2020 12:59:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJzmcY/DzmE+N9edYr9NSQmMn/ATGYSyGPIuPTnoP9kH8BAGbpSJJujQxh70rkCiaDL/ZOBUm5KAokfBwmJLefg=
X-Received: by 2002:aca:5295:: with SMTP id g143mr10368042oib.178.1597694354548;
 Mon, 17 Aug 2020 12:59:14 -0700 (PDT)
MIME-Version: 1.0
References: <20200817143755.807583758@linuxfoundation.org> <20200817143802.211923175@linuxfoundation.org>
In-Reply-To: <20200817143802.211923175@linuxfoundation.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Mon, 17 Aug 2020 21:59:03 +0200
Message-ID: <CAHc6FU7-B6kpJSSz5JC-47qGVQEiSwB3oePr=R5QacHw_P=jcg@mail.gmail.com>
Subject: Re: [PATCH 5.4 129/270] iomap: Make sure iomap_end is called after iomap_begin
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        stable <stable@vger.kernel.org>, Christoph Hellwig <hch@lst.de>,
        "Darrick J. Wong" <darrick.wong@oracle.com>,
        Sasha Levin <sashal@kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Greg,

On Mon, Aug 17, 2020 at 6:06 PM Greg Kroah-Hartman
<gregkh@linuxfoundation.org> wrote:
> From: Andreas Gruenbacher <agruenba@redhat.com>
>
> [ Upstream commit 856473cd5d17dbbf3055710857c67a4af6d9fcc0 ]
>
> Make sure iomap_end is always called when iomap_begin succeeds.
>
> Without this fix, iomap_end won't be called when a filesystem's
> iomap_begin operation returns an invalid mapping, bypassing any
> unlocking done in iomap_end.  With this fix, the unlocking will still
> happen.
>
> This bug was found by Bob Peterson during code review.  It's unlikely
> that such iomap_begin bugs will survive to affect users, so backporting
> this fix seems unnecessary.

as said for 5.7 / 5.8 already, this patch doesn't need to be backported.

Thanks,
Andreas

> Fixes: ae259a9c8593 ("fs: introduce iomap infrastructure")
> Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> Reviewed-by: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Darrick J. Wong <darrick.wong@oracle.com>
> Signed-off-by: Sasha Levin <sashal@kernel.org>
> ---
>  fs/iomap/apply.c | 13 +++++++++----
>  1 file changed, 9 insertions(+), 4 deletions(-)
>
> diff --git a/fs/iomap/apply.c b/fs/iomap/apply.c
> index 54c02aecf3cd8..c2281a6a7f320 100644
> --- a/fs/iomap/apply.c
> +++ b/fs/iomap/apply.c
> @@ -41,10 +41,14 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
>         ret = ops->iomap_begin(inode, pos, length, flags, &iomap);
>         if (ret)
>                 return ret;
> -       if (WARN_ON(iomap.offset > pos))
> -               return -EIO;
> -       if (WARN_ON(iomap.length == 0))
> -               return -EIO;
> +       if (WARN_ON(iomap.offset > pos)) {
> +               written = -EIO;
> +               goto out;
> +       }
> +       if (WARN_ON(iomap.length == 0)) {
> +               written = -EIO;
> +               goto out;
> +       }
>
>         /*
>          * Cut down the length to the one actually provided by the filesystem,
> @@ -60,6 +64,7 @@ iomap_apply(struct inode *inode, loff_t pos, loff_t length, unsigned flags,
>          */
>         written = actor(inode, pos, length, data, &iomap);
>
> +out:
>         /*
>          * Now the data has been copied, commit the range we've copied.  This
>          * should not fail unless the filesystem has had a fatal error.
> --
> 2.25.1
>
>
>

