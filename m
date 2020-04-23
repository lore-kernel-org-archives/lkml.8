Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 00120C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:20:58 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id CAF4620781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:20:58 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="tXHk9KyW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728277AbgDWNU6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:20:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726753AbgDWNU5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 09:20:57 -0400
Received: from mail-il1-x142.google.com (mail-il1-x142.google.com [IPv6:2607:f8b0:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D751C08E934
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 06:20:57 -0700 (PDT)
Received: by mail-il1-x142.google.com with SMTP id x2so5461456ilp.13
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 06:20:57 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NgS2H/D6EFVvTgVCCRzMf0kZXkLuo7JGo1bOkKa4VT4=;
        b=tXHk9KyW4695SjgQh6Gf5ACKijIKr4ExQm2aGyvyaSiH2lLWOJvTiGW1WUVVctTYPX
         4OFK9aiX6pSBVHNm5vehFA9nFKY49p1yBac9tl+pVVJo7zpt4Ts2/q4/6f//NmZUJhri
         A4bWwwh0IrvE3QZnOw+sf2r2TSWsPhs+YmPlQ=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NgS2H/D6EFVvTgVCCRzMf0kZXkLuo7JGo1bOkKa4VT4=;
        b=lbDHOZIIE8HCAfiEGcOM1qijf+O/ZtJhnuQYvyMlGDWzB4r/ebfxOF+xoSFez3INyx
         AkhvTy9fYnlArUihGl9PBD4V3wossZJMQguLNbIGtECfcf+UwNtiau9iWEh7U3UoqrDH
         frQPllZmSpjKO4TEk9IdEAkEj0y91qwkvCcwwu0w5MBsBLmTj8kQnVMQro0rb3I1V7UY
         Rv7RLcW7RtGMaxyd3v5vLXaGzgZfnIF9Mt/ucoMz3o5ZGz7kP1t+6oUrC5DUzgE01A7T
         DW9N4ckKQVD6qCcsyjwb1Ui9yMH94fZaJtnDaOukfgDwEHu5+gjZHCEVVYNCIT8lVrPV
         ypvQ==
X-Gm-Message-State: AGi0Pub2S6D7l7/f6rzm7WGUNGjRGByOtSBniUDixFBIxX7bUj2l52mZ
        j54budrStLuKnbNbBwtscE3V9Ae+Mep0WlEekRSdew==
X-Google-Smtp-Source: APiQypLms0zA6WvQAmVajcVRHgGwKdiDMidAforqu2S1QdJ4CrC95Xeb65YBLvCVe4Hc058EHhVGldBcSMl+12/fOWY=
X-Received: by 2002:a05:6e02:80e:: with SMTP id u14mr3522969ilm.176.1587648056689;
 Thu, 23 Apr 2020 06:20:56 -0700 (PDT)
MIME-Version: 1.0
References: <20200423044050.162093-1-joel@joelfernandes.org> <20200423114008.GB13910@bombadil.infradead.org>
In-Reply-To: <20200423114008.GB13910@bombadil.infradead.org>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 23 Apr 2020 09:20:45 -0400
Message-ID: <CAEXW_YTwHApBgUBS1-GBUQ4i7iNHde1k5CxVVEqHPQfAV+51HQ@mail.gmail.com>
Subject: Re: [RFC] fs: Use slab constructor to initialize conn objects in fsnotify
To:     Matthew Wilcox <willy@infradead.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Amir Goldstein <amir73il@gmail.com>, Jan Kara <jack@suse.cz>,
        Linux FS Devel <linux-fsdevel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 23, 2020 at 7:40 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> On Thu, Apr 23, 2020 at 12:40:50AM -0400, Joel Fernandes (Google) wrote:
> > While reading the famous slab paper [1], I noticed that the conn->lock
> > spinlock and conn->list hlist in fsnotify code is being initialized
> > during every object allocation. This seems a good fit for the
> > constructor within the slab to take advantage of the slab design. Move
> > the initializtion to that.
>
> The slab paper was written a number of years ago when CPU caches were
> not as they are today.  With this patch, every time you allocate a
> new page, we dirty the entire page, and then the dirty cachelines will
> gradually fall out of cache as the other objects on the page are not used
> immediately.  Then, when we actually use one of the objects on the page,
> we bring those cachelines back in and dirty them again by initialising
> 'type' and 'obj'.  The two stores to initialise lock and list are almost
> free when done in fsnotify_attach_connector_to_object(), but are costly
> when done in a slab constructor.

Thanks a lot for this reasoning. Basically, you're saying when a slab
allocates a page, it would construct all objects which end up dirtying
the entire page before the object is even allocated. That makes sense.

There's one improvement (although probably verys small) that the paper mentions:
Also according to the paper you referenced, the instruction cache is
what would also benefit. Those spinlock and hlist initialization
instructions wouldn't cost L1 I-cache footprint for every allocation.

> There are very few places where a slab constructor is justified with a
> modern CPU.  We've considered removing the functionality before.

I see, thanks again for the insights.

 - Joel

>
> > @@ -479,8 +479,6 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
> >       conn = kmem_cache_alloc(fsnotify_mark_connector_cachep, GFP_KERNEL);
> >       if (!conn)
> >               return -ENOMEM;
> > -     spin_lock_init(&conn->lock);
> > -     INIT_HLIST_HEAD(&conn->list);
> >       conn->type = type;
> >       conn->obj = connp;
> >       /* Cache fsid of filesystem containing the object */
> > --
> > 2.26.1.301.g55bc3eb7cb9-goog
