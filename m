Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1110DC83009
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:07:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E40862186A
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 08:07:32 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="enelnxuf"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727123AbgD3IHb (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 04:07:31 -0400
Received: from us-smtp-2.mimecast.com ([205.139.110.61]:60506 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726689AbgD3IH3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 04:07:29 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1588234047;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=gdooSi8kzNzLUkGPoOY/gSrvbDZtHNpV4mw4hssBG2A=;
        b=enelnxuf1qDBkgUxyCCBHrWElzbCRCNajnzy6TfCAUWcu+ziqJPAGPeopocUp5/zgoEGLf
        nxizfwRhgvvOM9B44APg+H7NZAqxbwAlGTjwJg0VTlzoYpmMGh/9kX0BOt7MKBu0jVeGEL
        r7kaPV+rZpLkNIehT4K9H5tT04ogN0Y=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-144-8Qrzqyp4PWOcug6gblnwSw-1; Thu, 30 Apr 2020 04:07:26 -0400
X-MC-Unique: 8Qrzqyp4PWOcug6gblnwSw-1
Received: by mail-wr1-f70.google.com with SMTP id g7so3445061wrw.18
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 01:07:26 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=gdooSi8kzNzLUkGPoOY/gSrvbDZtHNpV4mw4hssBG2A=;
        b=HNgpZrGt0Tp1CRfNJ83zGEa2lN85ui4RKNYCJpiqccBOT0kpfAxb1SsY9pECOjHQi9
         h+h0uw8Wetwu/Fi6rXw33D3mswvEOMYt4bhyRLrqxTgoATHLG+1SL9vr09AN3Uw/s+yb
         7Z0g4DcfH1RQqZUapk1BoWE2lDU0CVJdKg7CKpKE3Bhk1pi7qiOFXGciisSpjdC9fQk/
         DW8ZZ6KNxPKMx/wgyr9IafmyJ2B07sZltn7aGEp4swJg36maVMEwh4IR2xHPEB/Dl7US
         um9+QZq8B+VjwLgfyysI4bxfuPov5KNV2CemygoHDP9uzhkhg1xhA70WfIemoOn9sWSI
         srbQ==
X-Gm-Message-State: AGi0PubZAxSzXP9b3hoM9I8UXzz5XuAYpxg92mtygD0MVs65z03ExfUs
        ak4sNfIGJP8xkVxnF0nikVv/Bchk3KIAqDQW5b6nfNry6v7IljBYIgYJMjpzDQ6nwH9MnB6z2SU
        wfau6mBXZRFGNxtXwqdswc1vx
X-Received: by 2002:adf:ce02:: with SMTP id p2mr2401476wrn.173.1588234045016;
        Thu, 30 Apr 2020 01:07:25 -0700 (PDT)
X-Google-Smtp-Source: APiQypKz0zSjPZHjTj9qCN/S+Ro7syFoCI8JaW4cIB/I7GfLhunASC+45CCYaKVkcAeN/Q5Me5j2UQ==
X-Received: by 2002:adf:ce02:: with SMTP id p2mr2401448wrn.173.1588234044664;
        Thu, 30 Apr 2020 01:07:24 -0700 (PDT)
Received: from localhost.localdomain ([151.29.179.209])
        by smtp.gmail.com with ESMTPSA id i17sm11338242wml.23.2020.04.30.01.07.23
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 01:07:23 -0700 (PDT)
Date:   Thu, 30 Apr 2020 10:07:21 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Michel Lespinasse <walken@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Ingo Molnar <mingo@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Oleg Nesterov <oleg@redhat.com>, irogers@google.com,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [RFC][PATCH 1/7] rbtree: Add generic add and find helpers
Message-ID: <20200430080721.GC68379@localhost.localdomain>
References: <20200429153258.563269446@infradead.org>
 <20200429153549.006661686@infradead.org>
 <20200430072847.GA68379@localhost.localdomain>
 <CANN689FBczsBm=bYPfs1saUEeUq+oxLWnr8xfwtOstQkvJmwOA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CANN689FBczsBm=bYPfs1saUEeUq+oxLWnr8xfwtOstQkvJmwOA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 30/04/20 00:51, Michel Lespinasse wrote:
> On Thu, Apr 30, 2020 at 12:28 AM Juri Lelli <juri.lelli@redhat.com> wrote:
> > > --- a/include/linux/rbtree.h
> > > +++ b/include/linux/rbtree.h
> > > @@ -141,12 +141,18 @@ static inline void rb_insert_color_cache
> > >       rb_insert_color(node, &root->rb_root);
> > >  }
> > >
> > > -static inline void rb_erase_cached(struct rb_node *node,
> > > +static inline bool rb_erase_cached(struct rb_node *node,
> > >                                  struct rb_root_cached *root)
> > >  {
> > > -     if (root->rb_leftmost == node)
> > > +     bool leftmost = false;
> > > +
> > > +     if (root->rb_leftmost == node) {
> > >               root->rb_leftmost = rb_next(node);
> >
> > Think we need
> >
> >  if (root->rb_leftmost)
> >
> > > +             leftmost = true;
> >
> > DEADLINE crashes w/o that.
> 
> I think Peter's code is correct; after removing the only node in an
> rbtree rb_leftmost should be NULL.

Indeed, I've only got the idea that Peter was thinking of using
rb_erase_cached return value as an indication that new rb_leftmost is
not NULL (and for example perform an update in DEADLINE earliest_dl).

I also had the impression that DEADLINE is actually the only consumer of
that return value and so we were able to define its semantic.

> The issue appears to be in dequeue_pushable_dl_task unconditionally
> dereferencing the pointer returned by rb_first_cached(), which may be
> NULL. I'm not sure what the correct behavior is though, i.e. what
> dl_rq->earliest_dl.next should be set to if the rbtree ends up empty.
> Current code (before Peter's changes) preserves the existing
> dl_rq->earliest_dl.next value in that case, which seems very weird to
> me (and worthy of a comment if it's correct).

But, yeah. Fixing things in DEADLINE code works for me as well. We could
reset it to 0 (initial value), but I now actually wonder if places where
that is consumed are actually OK. Different discussion, though. :-)

Thanks,

Juri

