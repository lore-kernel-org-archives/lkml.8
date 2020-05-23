Return-Path: <SRS0=zXkI=7F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E939AC433E0
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 04:07:46 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C5196206F6
	for <linux-kernel@archiver.kernel.org>; Sat, 23 May 2020 04:07:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="DzeaLolo"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2387589AbgEWEHq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sat, 23 May 2020 00:07:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:25873 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1725294AbgEWEHp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 May 2020 00:07:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590206864;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=F1bhCGQtRl8cBs0zYrkz/5FLXJrqBYq5wZlx9jEG8Uc=;
        b=DzeaLolomh708EMfB9sr7hfe8y9wLr9050wX6hOBFVK6zLO9Z4yDGDBbKMivh3wjSXvkK9
        iLlYU/TI2wYyB6/MfBKPcY+YjqMNtsJDRxnNJGGQZrApmXjdTV5fU0x8e/68br9JPe1I4t
        Kqe1LGhGyfl1dObozmAGl27Yh+InJZE=
Received: from mail-qt1-f199.google.com (mail-qt1-f199.google.com
 [209.85.160.199]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-494-BxYPg-3LPIm3itgG48LKyQ-1; Sat, 23 May 2020 00:07:40 -0400
X-MC-Unique: BxYPg-3LPIm3itgG48LKyQ-1
Received: by mail-qt1-f199.google.com with SMTP id v17so13984904qtp.15
        for <linux-kernel@vger.kernel.org>; Fri, 22 May 2020 21:07:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F1bhCGQtRl8cBs0zYrkz/5FLXJrqBYq5wZlx9jEG8Uc=;
        b=N/B8/ZFLk+8/32TqC0Q32PCmr7E5wt4+o6UJt7c70/GeLjw2qxGapLUVRxhjHufIm2
         CmLI2UPS23Dz4Pk8so4jdwM+f4Tc8OxHWqavAn8PSxIo8lKIE7DBCjPO9ko7jYwxgxY0
         VEEXE7h3G6fJIqz0481Mjd2+ZJf93J0jNMEHrKct7HDSQBjN+BqgnYVIUoDlQQ7oxUR+
         UqsHpYT5glESvROpXmq6yioSlCx3ERSAzv3+tAs0X25ZD/Tz2lnZ36cUgZyCnaNIXVRf
         xmYz30YylHgynm0Xj9wxauJso6FpcOYhP04TfmxKOVpTb0dHaYGPqlb9O10aXRxG6U5Z
         TDvQ==
X-Gm-Message-State: AOAM533td9STlbWGnaW/rlar8yR8Me5wyCQG77fwA3V28l1v81LWXuWj
        c+i0WRy6GVrXRpEYR8QtlxSGHaJ3zAF4UnZVBp8/rTyT5V0R54YzkG87eJay41iF0mTLwEseh05
        wBG7zqqRn8F+BQI9tXXuzTpK1HoilzsBSKp0T1tOa
X-Received: by 2002:a37:270a:: with SMTP id n10mr17623768qkn.288.1590206860004;
        Fri, 22 May 2020 21:07:40 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxqucE/BLDWAWbsUb5BS4pFv+/cIpYb0lPmqP/rcpvyVgWQsH8wbXFsAUfUqER06Q9HPajqCxqlT56dHPAxYvs=
X-Received: by 2002:a37:270a:: with SMTP id n10mr17623751qkn.288.1590206859751;
 Fri, 22 May 2020 21:07:39 -0700 (PDT)
MIME-Version: 1.0
References: <20200522085723.29007-1-mszeredi@redhat.com> <20200522160815.GT23230@ZenIV.linux.org.uk>
 <CAOssrKcpQwYh39JpcNmV3JiuH2aPDJxgT5MADQ9cZMboPa9QaQ@mail.gmail.com>
 <CAOQ4uxi80CFLgeTYbnHvD7GbY_01z0uywP1jF8gZe76_EZYiug@mail.gmail.com>
 <CAOssrKfXgpRykVN94EiEy8xT4j+HCedN96i31j9iHomtavFaLA@mail.gmail.com> <20200522195626.GV23230@ZenIV.linux.org.uk>
In-Reply-To: <20200522195626.GV23230@ZenIV.linux.org.uk>
From:   Miklos Szeredi <mszeredi@redhat.com>
Date:   Sat, 23 May 2020 06:07:28 +0200
Message-ID: <CAOssrKcpWj=ACbNfy0iBjGDRogouDZAv-LT3P91XaXY3HD=jBA@mail.gmail.com>
Subject: Re: [PATCH] ovl: make private mounts longterm
To:     Al Viro <viro@zeniv.linux.org.uk>
Cc:     Amir Goldstein <amir73il@gmail.com>,
        overlayfs <linux-unionfs@vger.kernel.org>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        lkml <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 22, 2020 at 9:56 PM Al Viro <viro@zeniv.linux.org.uk> wrote:
>
> On Fri, May 22, 2020 at 08:53:49PM +0200, Miklos Szeredi wrote:

> > Right, we should just get rid of ofs->upper_mnt and ofs->upperdir_trap
> > and use ofs->layers[0] to store those.
>
> For that you'd need to allocate ->layers before you get to ovl_get_upper(),
> though.  I'm not saying it's a bad idea - doing plain memory allocations
> before anything else tends to make failure exits cleaner; it's just that
> it'll take some massage.  Basically, do ovl_split_lowerdirs() early,
> then allocate everything you need, then do lookups, etc., filling that
> stuff.

That was exactly the plan I set out.

> Regarding this series - the points regarding the name choice and the
> need to document the calling conventions change still remain.

Agreed.

Thanks,
Miklos

