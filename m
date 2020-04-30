Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 5A256C83001
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:51:19 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 30EC22082E
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 07:51:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kqSSjeZ+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726554AbgD3HvS (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 03:51:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726358AbgD3HvR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 03:51:17 -0400
Received: from mail-yb1-xb44.google.com (mail-yb1-xb44.google.com [IPv6:2607:f8b0:4864:20::b44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9FC76C035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:51:17 -0700 (PDT)
Received: by mail-yb1-xb44.google.com with SMTP id e16so496037ybn.7
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 00:51:17 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pLDutk4wbmpMCH/umkH9WAYAlTySTFnkRecmVU+0E0s=;
        b=kqSSjeZ+rI8gARW5nI9FUaRItjm5CqM0fjB5XI6W+lEAOiIkavNEQoguWYtY1vtJTE
         tSQg1dAfckJKYYcqEmELyk7FoGt4b5fHt2oVsRrBVT+CV39NIQwRObSDJwV/hTaGh9C3
         pjqB2w6Uk4Ax3XPNbh5hczFlpH7xshwCWI0i2X7/S2lduFTY/PRHRtV4ZY3Rjl3Okj9a
         3g0Z685XhVwmIO6Y5Mhu9JJrKzHuf2I9EEIShxkLltG1anSirqdZOvQaUUTVfNdQlCLS
         hZI5GleQ5MLfCOHux7SHLBKKGdc4bMHLzbBTPVlolyXibu61qM5jWF/2xaJBSFvG2KIW
         80nw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pLDutk4wbmpMCH/umkH9WAYAlTySTFnkRecmVU+0E0s=;
        b=tKyitpxaqoXMZc4Whgj6bG/oyf4Qx5/w7SJlY0eGDiQEzeT7177dnrFAwHDhTv70Pf
         LwLJBsPSYqDtlS2HbcZyEKrnsQsqdeBx/Hm38VBmxLPGQnfmXKQKbp/dzV1YQJkvwk5v
         GqDzPPwQ+lOSUhkIRQeajdSkfKB4QmPafUniA33OyaK/BOPpXTx8lFIQNiZWw9rq1w96
         pb0CfE+hArJMGzpLmGDgh2BFv45CmXjo//srXS4nQqA5rCKeiq31iuwN3rK+a+8iW2zj
         HQWXmYzXMb0Z+8YNUrkTmwnprQj7du81uOuqcj6FrJhMAlKg6cSnQ6581ZvjEPB3XZ/y
         6c3A==
X-Gm-Message-State: AGi0PuapmXx/Jr2vbqVlDXKPMWsqUlYgcj5MkF4kcO5UzLl5+1W+5QHB
        SeW8Ky1QKpQcITpBxpjIKiSsRlTFfk2B+lRS3qXj2Q==
X-Google-Smtp-Source: APiQypL9xoaDexzU2qRGlah8MaT3KWLw5PWZgxIrA3ayldIjYdnzEP3H/kY4CliMPoeXPlv8gEqDrkGjpTPHpNgFYoo=
X-Received: by 2002:a25:cc48:: with SMTP id l69mr3629847ybf.459.1588233075137;
 Thu, 30 Apr 2020 00:51:15 -0700 (PDT)
MIME-Version: 1.0
References: <20200429153258.563269446@infradead.org> <20200429153549.006661686@infradead.org>
 <20200430072847.GA68379@localhost.localdomain>
In-Reply-To: <20200430072847.GA68379@localhost.localdomain>
From:   Michel Lespinasse <walken@google.com>
Date:   Thu, 30 Apr 2020 00:51:02 -0700
Message-ID: <CANN689FBczsBm=bYPfs1saUEeUq+oxLWnr8xfwtOstQkvJmwOA@mail.gmail.com>
Subject: Re: [RFC][PATCH 1/7] rbtree: Add generic add and find helpers
To:     Juri Lelli <juri.lelli@redhat.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>, irogers@google.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 12:28 AM Juri Lelli <juri.lelli@redhat.com> wrote:
> > --- a/include/linux/rbtree.h
> > +++ b/include/linux/rbtree.h
> > @@ -141,12 +141,18 @@ static inline void rb_insert_color_cache
> >       rb_insert_color(node, &root->rb_root);
> >  }
> >
> > -static inline void rb_erase_cached(struct rb_node *node,
> > +static inline bool rb_erase_cached(struct rb_node *node,
> >                                  struct rb_root_cached *root)
> >  {
> > -     if (root->rb_leftmost == node)
> > +     bool leftmost = false;
> > +
> > +     if (root->rb_leftmost == node) {
> >               root->rb_leftmost = rb_next(node);
>
> Think we need
>
>  if (root->rb_leftmost)
>
> > +             leftmost = true;
>
> DEADLINE crashes w/o that.

I think Peter's code is correct; after removing the only node in an
rbtree rb_leftmost should be NULL.

The issue appears to be in dequeue_pushable_dl_task unconditionally
dereferencing the pointer returned by rb_first_cached(), which may be
NULL. I'm not sure what the correct behavior is though, i.e. what
dl_rq->earliest_dl.next should be set to if the rbtree ends up empty.
Current code (before Peter's changes) preserves the existing
dl_rq->earliest_dl.next value in that case, which seems very weird to
me (and worthy of a comment if it's correct).
