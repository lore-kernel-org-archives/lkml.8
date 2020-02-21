Return-Path: <SRS0=1210=4J=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 6BEFBC35666
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 20:19:36 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4146D24650
	for <linux-kernel@archiver.kernel.org>; Fri, 21 Feb 2020 20:19:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="uEcpgNIx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727515AbgBUUTf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 21 Feb 2020 15:19:35 -0500
Received: from mail-ot1-f68.google.com ([209.85.210.68]:34058 "EHLO
        mail-ot1-f68.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726725AbgBUUTe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Feb 2020 15:19:34 -0500
Received: by mail-ot1-f68.google.com with SMTP id j16so3198239otl.1
        for <linux-kernel@vger.kernel.org>; Fri, 21 Feb 2020 12:19:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OfpZw+eQB6iSYwMvRBzJaMRaqdbsGid5gEGpxbg9sSM=;
        b=uEcpgNIxyzARyyktOQSbbTIs3P/w6TgKfs9rTrYnQfUyOtw+Y/jWrbLk7GkpTw92F7
         YHwCKs5T5uF+WI5VOd8W3VJSXefpdWblnH2gBQoZnI+NHI3YMXR7Z3urY25D/8f0kt+5
         ettm551MbN+59D/LxW/SLaMiPedHQ9kOlXA3X8v3r5noGfJwngzmXCWszw3mqnCjIzvo
         r7Z6FaMc9KsSbykj/UPyzOLNB2wYbJqvXWsCv08JWsILT0TMm+92HS6wbrXIHvqew/Kd
         4mh4l1iYel1wAbHtHlNBjxSVzH58UCi+aOlqSAai7VkXTKw6DzwAqSLjD83fek6LJzR4
         Swfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OfpZw+eQB6iSYwMvRBzJaMRaqdbsGid5gEGpxbg9sSM=;
        b=PiYvK7jWde7GVBcXZfIv5uKm3qH30Vvqcp3ae2m/lJCYTgb1B4L+alET+g8DqL63en
         eP4S32XDF4n2mVC3a6xTjCxFl2V5jK4NqI9jAIDSS3hyeutyiKSpJC4qJtj0vOoWdvvW
         KHB8U9GHytyzEIerqCDRRX8/th01wFnqZz7JJUxISQTXgjGF5jHPwvqHKKDK8AbcRd3j
         l1u9rCNwsivD4osO92te1MT1cnkmrIQCXyBghALpKMw2A9TY2G9WcUoyJx/cgqA/3fM8
         DI2PqYdYNZFaGoZfrVICPuzCQRQ+OIzbu5AJxi3h8XmVk01CP4IHwjcb9sv3c+8R25aZ
         l1rA==
X-Gm-Message-State: APjAAAX0NLYdxaYjq2RZv20j0IiIBivUO8La4+gQF3YztauRAC/UTvyt
        K1nWYfojebPd3CIDdOKoQtuqDTDxBEJ0ejdvW7KLEA==
X-Google-Smtp-Source: APXvYqyx/RGSX2qyoU/QNIJeZF7dI+U24Dxth1TtmWp8pOZPVerHNA8pMkzSW7LFvniRoOIoJ5G9d1IhZP3X8SA4R3Y=
X-Received: by 2002:a9d:518b:: with SMTP id y11mr28357211otg.349.1582316373221;
 Fri, 21 Feb 2020 12:19:33 -0800 (PST)
MIME-Version: 1.0
References: <20200211213128.73302-1-almasrymina@google.com>
 <20200211151906.637d1703e4756066583b89da@linux-foundation.org>
 <CAHS8izPUFQWq3PzhhRzp7u11173_-cmRkNuQWEswS51Xz6ZM0Q@mail.gmail.com> <20200219130648.83e6810848774c6fd649c445@linux-foundation.org>
In-Reply-To: <20200219130648.83e6810848774c6fd649c445@linux-foundation.org>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 21 Feb 2020 12:19:22 -0800
Message-ID: <CAHS8izPB1vwuZVFha+5_ca9gKC7UceDdJFJZe9eb-T43a6GF8A@mail.gmail.com>
Subject: Re: [PATCH v12 1/9] hugetlb_cgroup: Add hugetlb_cgroup reservation counter
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>, shuah <shuah@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Greg Thelen <gthelen@google.com>,
        open list <linux-kernel@vger.kernel.org>, linux-mm@kvack.org,
        linux-kselftest@vger.kernel.org, cgroups@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 19, 2020 at 1:06 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed, 19 Feb 2020 11:05:41 -0800 Mina Almasry <almasrymina@google.com> wrote:
>
> > On Tue, Feb 11, 2020 at 3:19 PM Andrew Morton <akpm@linux-foundation.org> wrote:
> > >
> > > On Tue, 11 Feb 2020 13:31:20 -0800 Mina Almasry <almasrymina@google.com> wrote:
> > >
> > > > These counters will track hugetlb reservations rather than hugetlb
> > > > memory faulted in. This patch only adds the counter, following patches
> > > > add the charging and uncharging of the counter.
> > >
> > > We're still pretty thin on review here, but as it's v12 and Mike
> > > appears to be signed up to look at this work, I'll add them to -next to
> > > help move things forward.
> > >
> >
> > Hi Andrew,
> >
> > Since the patches were merged into -next there have been build fixes
> > and test fixes and some review comments. Would you like me to submit
> > *new* patches to address these, or would you like me to squash the
> > fixes into my existing patch series and submit another iteration of
> > the patch series?
>
> What you did worked OK ;)
>
> Please check the end result next time I release a kernel.

Hey Andrew,

Thanks for taking in the patset and fixes. Only pending change in the
latest -next tree is this one:
https://lore.kernel.org/linux-mm/20200219233610.13808-1-almasrymina@google.com/

It's reviewed by Mike here:
https://lore.kernel.org/linux-mm/a0d7b8e1-cb43-3b43-68c3-55631f2ce199@oracle.com/
