Return-Path: <SRS0=fR4S=7I=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 11E09C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:46:09 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DD7372065F
	for <linux-kernel@archiver.kernel.org>; Tue, 26 May 2020 21:46:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="lGzrocUg"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389326AbgEZVqI (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 26 May 2020 17:46:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2388915AbgEZVqH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 May 2020 17:46:07 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6416BC061A0F
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:46:07 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id d26so17598853otc.7
        for <linux-kernel@vger.kernel.org>; Tue, 26 May 2020 14:46:07 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eWK2mSOkygf8AQZHTNPf28u11TFo5EU8Br6utSWwfSk=;
        b=lGzrocUgQbICSeBaiwkyOOwLanI5L7Q7MrjZeR+bUe14CseJYeIEVoLpjK+78j0qVC
         xhoBmhvkTRqd06Jg9aL/KkKZAVKHrm8Iyt6BoY7ytzGLloFfNG29MXX64NRXKmaHZsHX
         DiHo5jhcCBMmFraQlreLqZrl0xckof3B8XMHPc5QsyDAD1GtqZ+lJ4aT7XnmteanYXOD
         XJrGNQSkmUjfh7gFTdz5WsYxJE0BHihrCxLof5ih+gHdE6GIhsOFuWjYXfH9xl1kwSSE
         +bN4/id8xLw6E6NNmu+sV6BwOzpVynZGYtPJvzR7VQmSLTuR5Ve1Qn/2GDq+B2JAOLe6
         bgYA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eWK2mSOkygf8AQZHTNPf28u11TFo5EU8Br6utSWwfSk=;
        b=gCvQrlL1xDzCN8SWyK49jHK9P9gBtOIxqMbLbj9FZAlrBVO4skpRCGlNupZUsV9Bs8
         6dcvkg1n3z3kZR0QUVBSr1BWKYu5sDrocBkrSxppGK0z3SKQILkY+tqVq4TEhIIolDry
         Pdm+I9k9csaWOv0m11yd0Ir0YYwJyWt9zEbWUhhOjLC42xMSiZ9czFScrUtAZV12le2b
         +wT9G+1LRMMKvayPTnFwu5BJWCZK/oWjvjzftTUIC1SYU/YmAnngTW3f+idEdvb+eZNY
         yjvGV6qWN8UrQS/ut6SMS43iNlNCVE9NgIANOYOC5eX3W2xsFVFnGe4PUFbkBCBcVqSq
         M8mg==
X-Gm-Message-State: AOAM531cYDTUiRZJi6OvUgGwtSWjBS4m/czI8B/1NJL8Qd8bZsOeFd5t
        Xv+x/Af/SS+SI1tUk7+6z4cPHsfAQ3bi1BXp2lvzBQ==
X-Google-Smtp-Source: ABdhPJzPTGKOjqqsvwMf/wIIySdzgXV5FeY89GRvQ/Ih68YSGjnmovyGBjPakunWc/BlcV9aF0nWKZ+eaConzS2tdRM=
X-Received: by 2002:a05:6830:18ec:: with SMTP id d12mr2527708otf.139.1590529566403;
 Tue, 26 May 2020 14:46:06 -0700 (PDT)
MIME-Version: 1.0
References: <20200526194328.258722-1-saravanak@google.com> <66f871c4c457d908ea86545c1aa871bf@walle.cc>
In-Reply-To: <66f871c4c457d908ea86545c1aa871bf@walle.cc>
From:   Saravana Kannan <saravanak@google.com>
Date:   Tue, 26 May 2020 14:45:30 -0700
Message-ID: <CAGETcx_jyE2UyP4ovT3KXhjOenRhpUPQAqDtTcgfgenW5NGQgA@mail.gmail.com>
Subject: Re: [PATCH v2] driver core: Update device link status correctly for
 SYNC_STATE_ONLY links
To:     Michael Walle <michael@walle.cc>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Android Kernel Team <kernel-team@android.com>,
        "Rafael J. Wysocki" <rafael.j.wysocki@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 26, 2020 at 2:13 PM Michael Walle <michael@walle.cc> wrote:
>
> Am 2020-05-26 21:43, schrieb Saravana Kannan:
> > When SYNC_STATE_ONLY support was added in commit 05ef983e0d65 ("driver
> > core: Add device link support for SYNC_STATE_ONLY flag"),
> > SYNC_STATE_ONLY links were treated similar to STATELESS links in terms
> > of not blocking consumer probe if the supplier hasn't probed yet.
> >
> > That caused a SYNC_STATE_ONLY device link's status to not get updated.
> > Since SYNC_STATE_ONLY device link is no longer useful once the
> > consumer probes, commit 21c27f06587d ("driver core: Fix
> > SYNC_STATE_ONLY device link implementation") addresses the status
> > update issue by deleting the SYNC_STATE_ONLY device link instead of
> > complicating the status update code.
> >
> > However, there are still some cases where we need to update the status
> > of a SYNC_STATE_ONLY device link. This is because a SYNC_STATE_ONLY
> > device link can later get converted into a normal MANAGED device link
> > when a normal MANAGED device link is created between a supplier and
> > consumer that already have a SYNC_STATE_ONLY device link between them.
> >
> > If a SYNC_STATE_ONLY device link's status isn't maintained correctly
> > till it's converted to a normal MANAGED device link, then the normal
> > MANAGED device link will end up with a wrong link status. This can
> > cause
> > a warning stack trace[1] when the consumer device probes successfully.
> >
> > This commit fixes the SYNC_STATE_ONLY device link status update issue
> > where it wouldn't transition correctly from DL_STATE_DORMANT or
> > DL_STATE_AVAILABLE to DL_STATE_CONSUMER_PROBE. It also resets the
> > status
> > back to DL_STATE_DORMANT or DL_STATE_AVAILABLE if the consumer probe
> > fails.
> >
> > [1] - https://lore.kernel.org/lkml/20200522204120.3b3c9ed6@apollo/
> > Fixes: 05ef983e0d65 ("driver core: Add device link support for
> > SYNC_STATE_ONLY flag")
> > Fixes: 21c27f06587d ("driver core: Fix SYNC_STATE_ONLY device link
> > implementation")
> > Reported-by: Michael Walle <michael@walle.cc>
> > Signed-off-by: Saravana Kannan <saravanak@google.com>
> > ---
> >
> > v1->v2:
> > - Added code to "revert" the link status if consumer probe fails
> >
> > Greg,
> >
> > I think this is the issue Michael ran into. I'd like him to test the
> > fix
> > before it's pulled in.
> >
> > Michael,
> >
> > If you can test this on the branch you saw the issue in and give a
> > Tested-by if it works, that'd be great.
>
> with v2 I'm triggering the
>    WARN_ON(!(link->status & DL_FLAG_SYNC_STATE_ONLY));
> in __device_links_no_driver().

Thanks for the logs! The WARNING is due to a dump typo in this line. I
should be checking link->flags, not link->status here. I'll send out a
v3, but you can test with this change too.

-Saravana
