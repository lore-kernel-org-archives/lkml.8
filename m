Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.8 required=3.0 tests=BAYES_00,DKIM_INVALID,
	DKIM_SIGNED,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id EF7FFC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:14:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7FB9420738
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 16:14:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=fail reason="key not found in DNS" (0-bit key) header.d=szeredi.hu header.i=@szeredi.hu header.b="jZ8C1lVM"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729851AbgGMQOc (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 12:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45896 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729027AbgGMQOb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 12:14:31 -0400
Received: from mail-ed1-x541.google.com (mail-ed1-x541.google.com [IPv6:2a00:1450:4864:20::541])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0BA35C061755
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 09:14:31 -0700 (PDT)
Received: by mail-ed1-x541.google.com with SMTP id z17so14146886edr.9
        for <linux-kernel@vger.kernel.org>; Mon, 13 Jul 2020 09:14:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=szeredi.hu; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=A7J/dIrjZFio1lV9NcYy8QCYPiQ6BKOzuPMbzTW6hKs=;
        b=jZ8C1lVMF7Tzy4ozH3eARzBxNxa9AIKbhB4vTgGwEfjvMCcNh0hz1RIR3OcaIj7wTk
         6EtwLWhVjnRBWdizDDwNsRm9wBP+TfCyFgZ+dA+7hP13C8kt0HVbfG5jOOt7NrVOSZPz
         wsAwP1yxi6uvhgjRVGawUaT1ZuygIX8yggZUQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=A7J/dIrjZFio1lV9NcYy8QCYPiQ6BKOzuPMbzTW6hKs=;
        b=gSpbC/j/KUL0GnowjBq88+HbA/Z5AE5Hc9Hje1k1s1KhPrJq2+FSeuSvXRtHh+bKY0
         D1lTf+G17g2LCigs7h6nPKAK9RyCteefQvSdc2DdBwZ7bUjcud0V1w257IU1dgrSITr7
         3JpB0NFDIvyJdhWI05o13KuhiXqNnneE8uMgB06z++aDPKRDdj2kfVHu6r9r/LNDSynf
         6stiT+ksf72JCBO+jqV9Se2FKuTuxHdyNxL9TTuFoZogwyDTAaDZNXuYyKKoCUge+3bU
         /tLSFoIuE9hoUp8s6sZwszPpCpNuw7hGC2BskP6uFt9yvNPcNXTfD8RgA2YD8tDtcOtm
         4TzA==
X-Gm-Message-State: AOAM5323ZKg3nfiXfvBhbBRI5tpD507AhB0wfKVZUVCu9WLVhCYm7wHC
        yYtx8DxCMo1JIf7X3ImOdFxtMV7mE7GKqJx5K/JG3Q==
X-Google-Smtp-Source: ABdhPJzXRGJE3TcK5wECCdKKfoKHfG85l1u/aM1eJ1RxfsXlJyiUiSBf3ojXMDQKJF70SFgMqKDXfR09Gt/l9JKhYqY=
X-Received: by 2002:a50:f413:: with SMTP id r19mr165397edm.17.1594656869606;
 Mon, 13 Jul 2020 09:14:29 -0700 (PDT)
MIME-Version: 1.0
References: <2733b41a-b4c6-be94-0118-a1a8d6f26eec@virtuozzo.com>
 <d6e8ef46-c311-b993-909c-4ae2823e2237@virtuozzo.com> <CAJfpegupeWA_dFi5Q4RBSdHFAkutEeRk3Z1KZ5mtfkFn-ROo=A@mail.gmail.com>
 <8da94b27-484c-98e4-2152-69d282bcfc50@virtuozzo.com>
In-Reply-To: <8da94b27-484c-98e4-2152-69d282bcfc50@virtuozzo.com>
From:   Miklos Szeredi <miklos@szeredi.hu>
Date:   Mon, 13 Jul 2020 18:14:16 +0200
Message-ID: <CAJfpegvU2JQcNM+0mcMPk-_e==RcT0xjqYUHCTzx3g0oCw6RiA@mail.gmail.com>
Subject: Re: [PATCH] fuse_writepages_fill() optimization to avoid WARN_ON in tree_insert
To:     Vasily Averin <vvs@virtuozzo.com>
Cc:     linux-fsdevel@vger.kernel.org, Maxim Patlasov <maximvp@gmail.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jul 13, 2020 at 10:02 AM Vasily Averin <vvs@virtuozzo.com> wrote:
>
> On 7/11/20 7:01 AM, Miklos Szeredi wrote:
> > On Thu, Jun 25, 2020 at 11:02 AM Vasily Averin <vvs@virtuozzo.com> wrote:
> >>
> >> In current implementation fuse_writepages_fill() tries to share the code:
> >> for new wpa it calls tree_insert() with num_pages = 0
> >> then switches to common code used non-modified num_pages
> >> and increments it at the very end.
> >>
> >> Though it triggers WARN_ON(!wpa->ia.ap.num_pages) in tree_insert()
> >>  WARNING: CPU: 1 PID: 17211 at fs/fuse/file.c:1728 tree_insert+0xab/0xc0 [fuse]
> >>  RIP: 0010:tree_insert+0xab/0xc0 [fuse]
> >>  Call Trace:
> >>   fuse_writepages_fill+0x5da/0x6a0 [fuse]
> >>   write_cache_pages+0x171/0x470
> >>   fuse_writepages+0x8a/0x100 [fuse]
> >>   do_writepages+0x43/0xe0
> >>
> >> This patch re-works fuse_writepages_fill() to call tree_insert()
> >> with num_pages = 1 and avoids its subsequent increment and
> >> an extra spin_lock(&fi->lock) for newly added wpa.
> >
> > Looks good.  However, I don't like the way fuse_writepage_in_flight()
> > is silently changed to insert page into the rb_tree.  Also the
> > insertion can be merged with the search for in-flight and be done
> > unconditionally to simplify the logic.  See attached patch.
>
> Your patch looks correct for me except 2 things:

Thanks for reviewing.

> 1) you have lost "data->wpa = NULL;" when fuse_writepage_add() returns false.

This is intentional, because this is in the !data->wpa branch.

> 2) in the same case old code did not set data->orig_pages[ap->num_pages] = page;

That is also intentional, in this case the origi_pages[0] is either
overwritten with the next page or discarded due to data->wpa being
NULL.

I'll write these up in the patch header.

Thanks,
Miklos
