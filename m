Return-Path: <SRS0=6raZ=AQ=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 37F11C433E0
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 15:08:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 0F1E52075D
	for <linux-kernel@archiver.kernel.org>; Sun,  5 Jul 2020 15:08:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="Shsz8lRn"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727793AbgGEPIi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Sun, 5 Jul 2020 11:08:38 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:28226 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726826AbgGEPIh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Jul 2020 11:08:37 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1593961715;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=Ew/OdjOd95BOa3dKjs/VTo1bRUIFHTAarG64/Xhncjs=;
        b=Shsz8lRn2yRDOqpfG+/oDgTNsosY0pyQIu6+9acraUzyNpffGHywwQkxCtc1feDXR9UA1H
        +Jzul8mZkcGVYplwWW4WwLhsHW17BSS+SbSi5zk1nWAnbbNndi8p68bP9/LKvESY11xtoI
        P9BcWNOllj0uBG9tgpy2uA2bTclnAjE=
Received: from mail-ot1-f70.google.com (mail-ot1-f70.google.com
 [209.85.210.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-4-2lVNwlNzMr2_LVBjPu2yOw-1; Sun, 05 Jul 2020 11:08:34 -0400
X-MC-Unique: 2lVNwlNzMr2_LVBjPu2yOw-1
Received: by mail-ot1-f70.google.com with SMTP id 10so13820304otp.20
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jul 2020 08:08:33 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ew/OdjOd95BOa3dKjs/VTo1bRUIFHTAarG64/Xhncjs=;
        b=jtXxkzXEzZl5nn3dq8brFxeXdhjvW947j+K++BTb92RorYUooj08cnHU0aashpoZ/5
         HxDl57CFUxrQba4rKGEkHOEChFJqCS72Nu6A0IAYy/wHfd4pR66jOfPW2SfbirydmsVC
         kW0w7Cs1AbyzyT/BudqgTMTlTAhGpggxaklwreNJn37DzxmMGLVjbYUKcSzeonbDrJ1T
         KAtZexGxUqLowc7vBnzY1pWFOUrkbk0yySU1UYEbrxOqYD0uY5L+i/2AhU7eXTaE/ish
         Cw2/MKIZ/1UozAw9+B0p0vc9/JOBlWchdima7GZmOJMuFSzkIBXHNrSGdctSx8Z3oq6E
         FnVw==
X-Gm-Message-State: AOAM53040R6yBnGcHWEj71BuBUB/AUdzD1QQOnRwjPhvtwHXzqN8De1t
        9yNoj0wc0y6jCI2RG7qrjMaGV3lfKpeOymEiv/2w5gyzVCgyq+lXfHET1oBCczDcOHUeweiPlRw
        n7sJHDZOv1h2/wgLFB8jo7bY7GwEojVaBWIPeJodS
X-Received: by 2002:a05:6830:1c6e:: with SMTP id s14mr33097428otg.58.1593961713306;
        Sun, 05 Jul 2020 08:08:33 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJxRg3eAq/NtdI3fapt+nPvYFvGVXas6I8K/gwkuEhNAnNsRgfDspzv3RMomr27ExhtxybgWpGD6uUv4bO06Ei4=
X-Received: by 2002:a05:6830:1c6e:: with SMTP id s14mr33097413otg.58.1593961713041;
 Sun, 05 Jul 2020 08:08:33 -0700 (PDT)
MIME-Version: 1.0
References: <20200703095325.1491832-1-agruenba@redhat.com> <20200703095325.1491832-2-agruenba@redhat.com>
 <20200703114108.GE25523@casper.infradead.org>
In-Reply-To: <20200703114108.GE25523@casper.infradead.org>
From:   Andreas Gruenbacher <agruenba@redhat.com>
Date:   Sun, 5 Jul 2020 17:08:21 +0200
Message-ID: <CAHc6FU7HvPqpBSRQJfbgBgQpjFzYfWfTwq+F-tOUq+-Jc8efQg@mail.gmail.com>
Subject: Re: [RFC v2 1/2] fs: Add IOCB_NOIO flag for generic_file_read_iter
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Dave Chinner <david@fromorbit.com>,
        linux-fsdevel <linux-fsdevel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 3, 2020 at 1:41 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Fri, Jul 03, 2020 at 11:53:24AM +0200, Andreas Gruenbacher wrote:
> > Add an IOCB_NOIO flag that indicates to generic_file_read_iter that it
> > shouldn't trigger any filesystem I/O for the actual request or for
> > readahead.  This allows to do tentative reads out of the page cache as
> > some filesystems allow, and to take the appropriate locks and retry the
> > reads only if the requested pages are not cached.
> >
> > Signed-off-by: Andreas Gruenbacher <agruenba@redhat.com>
>
> Reviewed-by: Matthew Wilcox (Oracle) <willy@infradead.org>
>
> > @@ -2249,9 +2253,18 @@ EXPORT_SYMBOL_GPL(generic_file_buffered_read);
> >   *
> >   * This is the "read_iter()" routine for all filesystems
> >   * that can use the page cache directly.
> > + *
> > + * The IOCB_NOWAIT flag in iocb->ki_flags indicates that -EAGAIN shall
> > + * be returned when no data can be read without waiting for I/O requests
> > + * to complete; it doesn't prevent readahead.
> > + *
> > + * The IOCB_NOIO flag in iocb->ki_flags indicates that -EAGAIN shall be
> > + * returned when no data can be read without issuing new I/O requests,
> > + * and 0 shall be returned when readhead would have been triggered.
>
> s/shall/may/ -- if we read a previous page then hit a readahead page,
> we'll return a positive value.  If the first page we hit is a readahead
> page, then yes, we'll return zero.

How about this?

 * The IOCB_NOIO flag in iocb->ki_flags indicates that no new I/O
 * requests shall be made for the read or for readahead.  When no data
 * can be read, -EAGAIN shall be returned.  When readahead would be
 * triggered, a short read (possibly of length 0) shall be returned.

> Again, I'm happy for the patch to go in as-is without this nitpick.

Thanks,
Andreas

