Return-Path: <SRS0=rw9U=6H=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS,URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36005C54FCB
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:21:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1180C20781
	for <linux-kernel@archiver.kernel.org>; Thu, 23 Apr 2020 13:21:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=joelfernandes.org header.i=@joelfernandes.org header.b="mzoaoaFg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728443AbgDWNVv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 23 Apr 2020 09:21:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1728122AbgDWNVu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Apr 2020 09:21:50 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8E05C08E934
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 06:21:50 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id u11so6353992iow.4
        for <linux-kernel@vger.kernel.org>; Thu, 23 Apr 2020 06:21:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=joelfernandes.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7pXepSPYzMMHMLgU540c61hPctFJN9vDrJKRud42zak=;
        b=mzoaoaFg6koBO2ACNovE9T8UIRIfNn3EpNy0K6v0cRYQjmk+wY3NSjDUc6VkXr2rPH
         UerHj3hi4Ba1PYKuuoavchDgqVqltc4p87CH+KRdL9lD8AeFZt7bo3EuW/hL4r+MNnV9
         iq9G6Nd+6yn53my9QEi8arrIlqqJC7Yl6Ug8E=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7pXepSPYzMMHMLgU540c61hPctFJN9vDrJKRud42zak=;
        b=VUOPWEwsejqJYpq9KF3bXO7+pVaicSi62+M5Xx7MeFoABknxjDfecyZSjbDRq8GMBB
         Za2xqDvjCzLDKMX5GJNaiDRk9luCeqcqqRNdrtHf1VLzFxwXKeiGkd0EJdH/PYqjbYTx
         5DX+dnkCmyJXtaKVU5dt4CzLBWMG355EQDO6ObBPAiWU8fmiHNR4urUtfroM9fdTFO6k
         P0/j/Ybdbo37njJ2QlRhWvaG6xHz3avLiYa+rb0L4wJsJ2hM18yhC2GpeTxpq8cr43O8
         xksK3OQDOT1tIlowsIlEWYD5ISBAhKKEb9xUxtHEN/95T+NZQknEeLozjh3VucW+acnV
         ZmNg==
X-Gm-Message-State: AGi0PubbRIism0Wi236LQ3/PmVyQAOjAq1cHjE929DAQMX5nzlaggyQ1
        GnGRPgnTfqYmiOj9Pu2drJV9vfCdJtRj+Y87r32W3Q==
X-Google-Smtp-Source: APiQypI0taFrwRk3OnD/St6Osfy28tOJknnldqFqCt2ZmHtIdhEoYQ8FT5xsuPuAnWbqTJ86reuAHtliGoYo6r55leU=
X-Received: by 2002:a02:7611:: with SMTP id z17mr3181791jab.42.1587648110030;
 Thu, 23 Apr 2020 06:21:50 -0700 (PDT)
MIME-Version: 1.0
References: <20200423044050.162093-1-joel@joelfernandes.org>
 <20200423114008.GB13910@bombadil.infradead.org> <CAEXW_YTwHApBgUBS1-GBUQ4i7iNHde1k5CxVVEqHPQfAV+51HQ@mail.gmail.com>
In-Reply-To: <CAEXW_YTwHApBgUBS1-GBUQ4i7iNHde1k5CxVVEqHPQfAV+51HQ@mail.gmail.com>
From:   Joel Fernandes <joel@joelfernandes.org>
Date:   Thu, 23 Apr 2020 09:21:39 -0400
Message-ID: <CAEXW_YTyw24aksUjgOcesEVHe5HjFVyVKCUpbf70yvqF13GrGA@mail.gmail.com>
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

On Thu, Apr 23, 2020 at 9:20 AM Joel Fernandes <joel@joelfernandes.org> wrote:
>
> On Thu, Apr 23, 2020 at 7:40 AM Matthew Wilcox <willy@infradead.org> wrote:
> >
> > On Thu, Apr 23, 2020 at 12:40:50AM -0400, Joel Fernandes (Google) wrote:
> > > While reading the famous slab paper [1], I noticed that the conn->lock
> > > spinlock and conn->list hlist in fsnotify code is being initialized
> > > during every object allocation. This seems a good fit for the
> > > constructor within the slab to take advantage of the slab design. Move
> > > the initializtion to that.
> >
> > The slab paper was written a number of years ago when CPU caches were
> > not as they are today.  With this patch, every time you allocate a
> > new page, we dirty the entire page, and then the dirty cachelines will
> > gradually fall out of cache as the other objects on the page are not used
> > immediately.  Then, when we actually use one of the objects on the page,
> > we bring those cachelines back in and dirty them again by initialising
> > 'type' and 'obj'.  The two stores to initialise lock and list are almost
> > free when done in fsnotify_attach_connector_to_object(), but are costly
> > when done in a slab constructor.
>
> Thanks a lot for this reasoning. Basically, you're saying when a slab
> allocates a page, it would construct all objects which end up dirtying
> the entire page before the object is even allocated. That makes sense.
>
> There's one improvement (although probably verys small) that the paper mentions:
> Also according to the paper you referenced, the instruction cache is

Correcting myself, the paper wasn't referenced by you but by a
colleague :) Apologies for mistyping :)

Thanks,

 - Joel


> what would also benefit. Those spinlock and hlist initialization
> instructions wouldn't cost L1 I-cache footprint for every allocation.
>
> > There are very few places where a slab constructor is justified with a
> > modern CPU.  We've considered removing the functionality before.
>
> I see, thanks again for the insights.
>
>  - Joel
>
> >
> > > @@ -479,8 +479,6 @@ static int fsnotify_attach_connector_to_object(fsnotify_connp_t *connp,
> > >       conn = kmem_cache_alloc(fsnotify_mark_connector_cachep, GFP_KERNEL);
> > >       if (!conn)
> > >               return -ENOMEM;
> > > -     spin_lock_init(&conn->lock);
> > > -     INIT_HLIST_HEAD(&conn->list);
> > >       conn->type = type;
> > >       conn->obj = connp;
> > >       /* Cache fsid of filesystem containing the object */
> > > --
> > > 2.26.1.301.g55bc3eb7cb9-goog
