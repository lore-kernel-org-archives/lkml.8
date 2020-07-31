Return-Path: <SRS0=S/iQ=BK=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.6 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DE04CC433DF
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 17:21:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id BDE2922B3F
	for <linux-kernel@archiver.kernel.org>; Fri, 31 Jul 2020 17:21:22 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="O6eLa1Ii"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1733302AbgGaRVV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jul 2020 13:21:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48928 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1732793AbgGaRVU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jul 2020 13:21:20 -0400
Received: from mail-il1-x141.google.com (mail-il1-x141.google.com [IPv6:2607:f8b0:4864:20::141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 92C13C061574
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 10:21:20 -0700 (PDT)
Received: by mail-il1-x141.google.com with SMTP id j9so22566931ilc.11
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jul 2020 10:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=CjnDRWhzh4EQDemiUKG1D36APM9tw49b0yekL5D351Y=;
        b=O6eLa1IixT5kqe1AFaE+bcjnOe1UcPBmwrKRiFbR0M+ApxONaIjOgTgH0qPy1e+mfI
         BrJYF48+BZ9GpnD7otmkXOlDe7LuJF5xrz4fXbebvy9H4yWGNQFWtSAOZy/YzdiydJnI
         a5ogGROvvL52W54SrDcABtpl9OJHBspk06/53PKLOXweg+kONWzZqz92EIoGP7E57tYi
         dfHR0UsbgWj1gmT6XveGJQ9D1sQUndrUnftF4ByLAeHaJktep1m5xer6vWVXk0Hz47m/
         d5I/vhBaQdxcNZBNGoMpqxGjEU+JqlRykRNRCHM9n0pzeWiwocwZ5b35DGHbQpFCf8PK
         vePQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=CjnDRWhzh4EQDemiUKG1D36APM9tw49b0yekL5D351Y=;
        b=f+kNswAjw3snaVQLpfVo0Baa1J+XHA3zd2SDkGTDgiEKO5tDbPJbs9pJGDYjqJD75J
         EGn/d03sYBKRjVvmBq/Rc8qOYW4b8kYQ4Kape6cq1zq2/tHBaiCxg0ycEtd/JbTQHm0M
         e1tZkdwMJq95/Vw0qZX/vVhQTEc97fzaKBslYGmr60Hk4uUuaydajCdYsBbCMvmR4NO9
         61Kvuo0m9q/sgVuYqVv5WlJGWVbwdyN4DFpSohHAxjegOh92I27Rv4bUWX93mHXR393I
         hotFewYTNWc4o+JM1+WlJiGT15qVqjiEWP/UIj5SaDOxl/8xQ1dI+jdUzugLj6Q0WnJj
         v4EQ==
X-Gm-Message-State: AOAM530LKMbYRo22cUjHyiwk+5cAqX5DWhf3XDIE1fyK2Pyqy1zKwJVN
        Rx9mmODUUuIkq8J0Ax0eywWLMCGOKlF2kdRxw2OZ+A==
X-Google-Smtp-Source: ABdhPJyH2hwJl5Ig5ekwoTRKbYJlGW0zPP/krcQsTHZWN/txgmrTTT+uY5eC/VjlHBlg3SLatIfbujlwpFw3F+gQYbk=
X-Received: by 2002:a92:c608:: with SMTP id p8mr4865557ilm.137.1596216079403;
 Fri, 31 Jul 2020 10:21:19 -0700 (PDT)
MIME-Version: 1.0
References: <20200730015755.1827498-1-edumazet@google.com> <20200731171714.GA513060@nvidia.com>
In-Reply-To: <20200731171714.GA513060@nvidia.com>
From:   Eric Dumazet <edumazet@google.com>
Date:   Fri, 31 Jul 2020 10:21:08 -0700
Message-ID: <CANn89i+SwhK8XKDqKKvL1svnBWKxv28iKzD2nEf2g0pOO0+0qQ@mail.gmail.com>
Subject: Re: [PATCH net] RDMA/umem: add a schedule point in ib_umem_get()
To:     Jason Gunthorpe <jgg@nvidia.com>
Cc:     Doug Ledford <dledford@redhat.com>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Eric Dumazet <eric.dumazet@gmail.com>,
        linux-rdma <linux-rdma@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jul 31, 2020 at 10:17 AM Jason Gunthorpe <jgg@nvidia.com> wrote:
>
> On Wed, Jul 29, 2020 at 06:57:55PM -0700, Eric Dumazet wrote:
> > Mapping as little as 64GB can take more than 10 seconds,
> > triggering issues on kernels with CONFIG_PREEMPT_NONE=y.
> >
> > ib_umem_get() already splits the work in 2MB units on x86_64,
> > adding a cond_resched() in the long-lasting loop is enough
> > to solve the issue.
> >
> > Note that sg_alloc_table() can still use more than 100 ms,
> > which is also problematic. This might be addressed later
> > in ib_umem_add_sg_table(), adding new blocks in sgl
> > on demand.
>
> I have seen some patches in progress to do exactly this, the
> motivation is to reduce the memory consumption if a lot of pages are
> combined.

Nice ;)

>
> > Signed-off-by: Eric Dumazet <edumazet@google.com>
> > Cc: Doug Ledford <dledford@redhat.com>
> > Cc: Jason Gunthorpe <jgg@ziepe.ca>
> > Cc: linux-rdma@vger.kernel.org
> > ---
> >  drivers/infiniband/core/umem.c | 1 +
> >  1 file changed, 1 insertion(+)
>
> Why [PATCH net] ?

Sorry, I used a script that I normally use for net submissions, forgot
to remove this tag ;)

>
> Anyhow, applied to rdma for-next

Thanks !

>
> Thanks,
> Jason
