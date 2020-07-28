Return-Path: <SRS0=jZ1s=BH=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B9CB7C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 01:39:53 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 858CE20838
	for <linux-kernel@archiver.kernel.org>; Tue, 28 Jul 2020 01:39:53 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=tfz-net.20150623.gappssmtp.com header.i=@tfz-net.20150623.gappssmtp.com header.b="MOlNb8No"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726247AbgG1Bjv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 27 Jul 2020 21:39:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726196AbgG1Bju (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jul 2020 21:39:50 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 69AD2C061794
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 18:39:50 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id o8so15756607wmh.4
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jul 2020 18:39:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=tfz-net.20150623.gappssmtp.com; s=20150623;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rwOY8YxgZ5QpwLDyDAZDf7H1P9wljCLWGMd+2npKJBM=;
        b=MOlNb8NoPIUUfR8CTs/ijaub4q4xeQjXKnkBHNwAa14H1Dd6e/nDvqfYG9o76lQVTE
         eAN0QcUHn/mXk3a71B+PWIt9/gyiGSnOU1mN2wYJE6kh+h2qjacUezbquyuNrABVzXGr
         2QLQ7KWLtjy25fICkWKA7l0pBVUCODm17o5Vp3lYiGfMzJqqNzf0DG14wxBfstEAmW4w
         ef45SGrtTuk/3ZQVdOje7MzvLNAcbx6trAY/fDCNNSL1jPk3GLbPjvMLt0+ZrMnVCHax
         IcGaQ9njibv6jtOsowO4CK5auxqop1215tyGOOckvqNwdSmb+hRtJlhMbNxuLczCHj0L
         K4fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rwOY8YxgZ5QpwLDyDAZDf7H1P9wljCLWGMd+2npKJBM=;
        b=ubwGG5+q0BMnwI1oqYBCn5N4Oj4kzsb80tcUR8eGqdbMPACogHWQFWFkFFvBcxq4Rb
         UUZADvZsEurh+/QDXscblip4tgo1kEaBfr8XMWQWY1+6BM+VUYqSba+quQdDa1jwOzYf
         R4bS5PLiSpBv3FUQxo7D6Ntik9tb6mYdWcCfOS02aeY8ZLM9/0Kc13jgUS0AhdiMLDkK
         BqfJA+2GxGcn4fYlbKxXDyaoYwyz38zVNSxAjHu2DH1Vv09FR/BTK79pU1Ew085ohn6l
         yWcngkh581nVAk6rUZkFBKGEXNO/scYlhnD72az7ZXhWoVjnnIUC+DZWuPq2lCZ1jKgP
         YkLw==
X-Gm-Message-State: AOAM530t9hQwGkI12Zb/wC9JAbT+qAXvBw/BLc4k+NtX0PvwMy2b8QpO
        fjc4ujGv2PvKHGeBt7jq4ByjrUPUrQW8jWcaoKU3+Q==
X-Google-Smtp-Source: ABdhPJyfsdGe7F0N2iM9sCVzuKHum+2IPBFDtR0asF99pcKFoFTZqL9MHOFO1v31etobWXHbS/fk+qTwgQt0rP17V80=
X-Received: by 2002:a7b:cd0d:: with SMTP id f13mr1606237wmj.40.1595900389021;
 Mon, 27 Jul 2020 18:39:49 -0700 (PDT)
MIME-Version: 1.0
References: <20200725045921.2723-1-kalou@tfz.net> <20200725052236.4062-1-kalou@tfz.net>
 <20200727142140.GA116567@localhost.localdomain>
In-Reply-To: <20200727142140.GA116567@localhost.localdomain>
From:   Pascal Bouchareine <kalou@tfz.net>
Date:   Mon, 27 Jul 2020 18:39:38 -0700
Message-ID: <CAGbU3_nkBfrJK55-ZiCc6ve1F+CZBeuSmm6Dike0kkKja-RmVg@mail.gmail.com>
Subject: Re: [PATCH v3] proc,fcntl: introduce F_SET_DESCRIPTION
To:     Alexey Dobriyan <adobriyan@gmail.com>
Cc:     linux-kernel@vger.kernel.org, linux-fsdevel@vger.kernel.org,
        linux-api@vger.kernel.org, Al Viro <viro@zeniv.linux.org.uk>,
        Jeff Layton <jlayton@poochiereds.net>,
        "J. Bruce Fields" <bfields@fieldses.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks for reviewing, I added some questions inline below

On Mon, Jul 27, 2020 at 7:21 AM Alexey Dobriyan <adobriyan@gmail.com> wrote:
> > +     d = strndup_user(desc, MAX_FILE_DESC_SIZE);
>
> This should be kmem accounted because allocation is persistent.
> To make things more entertaining, strndup_user() doesn't have gfp_t argument.

I had to look it up so I might be very far from it, but is that
__GFP_ACCOUNT and would it be correct to assume memdup_user() should
use it unconditionally?

Otherwise my simple option would be to implement the logic in the
set_description, but the benefit would be very local.

Please let me know what you think is best, happy to read more doc if
there's a more productive way to address that

>
> > +     if (IS_ERR(d))
> > +             return PTR_ERR(d);
> > +
> > +     spin_lock(&file->f_lock);
> > +     kfree(file->f_description);
> > +     file->f_description = d;
> > +     spin_unlock(&file->f_lock);
>
> Generally kfree under spinlock is not good idea.
> You can replace the pointer and free without spinlock.

Sorry I also need some pointers here - do you suggest I move the kfree
out of the locked section or that there is a safe way other than
spinlock?

> struct file is nicely aligned to 256 bytes on distro configs.
> Will this break everything?
>
>         $ cat /sys/kernel/slab/filp/object_size

Indeed on the config I'm using here this jumped to 264 bytes

Would it be better to move this to the inode struct? I don't know the
implications of this - any other option?

Thanks!
