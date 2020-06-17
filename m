Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 907D8C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:59:55 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 6EAC520810
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 02:59:55 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RfewTiqW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726714AbgFQC7y (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 22:59:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726494AbgFQC7x (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 22:59:53 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606AEC061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 19:59:53 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id n23so990662ljh.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 19:59:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9GfV+ZXZWePD6gD12mFz6es4uCAjN6eHVRqAeOqRsdY=;
        b=RfewTiqWuglwR2QisfOQvMIk5qFFV8JrErSpa1Kp+mCpPw2sknAYvfoie+N+mJEBnw
         dYc3fksFYaJjAaNrdHTwFzppGz3tzzH2cx9OrzmaE6+3jnvgerdlFddBM7D/oPf7lO5C
         ADei0paNwpcqaoDOKCB0aJumCDTvyxaySEz10CTvLCDf5l7beANMeTW7rLJCq7/qbJK8
         NbzffFoXynF2utqxWU0EdDL0dOWNYJXbBESPkC/EEPL0OVXZpalG99iriycULr1RGT6I
         24fuPz3Nj0+7/63JJ3mYNcAiJDr0BALijCKtbh7oLVfA7bkXcoXdvN1TH4GMnzgH9ul7
         /eQg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9GfV+ZXZWePD6gD12mFz6es4uCAjN6eHVRqAeOqRsdY=;
        b=dRafKSdvK4hfcOlTXwjBSu8lermH5+ER+MGZOWqZ8qwOEmRAGirNeVjC4maoMzboek
         ZjqDi7R/CNJCJkd8IFiMAHzXodqBo6Jwm6tZ2ByxQ3GqIfRX1dPZg7aHbocgrmeycP8J
         NNyOfYTxrnD9oASnqTGA2GeCFP8edIhfMkFSHkluUMpTV74Ey/yjjFFEQBqGmavmCDsT
         dR/KHk5ct0wSeR71je7tWdxRFdLvB478nr2FBuJLpWyVY7yQiTwCO6q4//40qucb0hi3
         zrbC3gUMpU36TrfKWAibcfy0Js+tphOYhgxyay6dl4jfNx30ukY1fGqftnlpYDbqRtQ+
         AHhw==
X-Gm-Message-State: AOAM530Vobg95j4bRNNxqLs+R64pUdgwx9ArCZhW+nYVAylfGyvyEdQM
        ZqhjhDeRRgSJO6sWHxZjJZ4fPictrE9fExbeYoaE5g==
X-Google-Smtp-Source: ABdhPJzh0ExlhSPOX4d0I4ToEKHqUmEelceXDff6dHdAACXsJe4MEttb5Th6rn0PQUr1sPC5FPSjGMt+1D8Vj3FA4DI=
X-Received: by 2002:a2e:910c:: with SMTP id m12mr3005693ljg.332.1592362791622;
 Tue, 16 Jun 2020 19:59:51 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-2-guro@fb.com>
 <CALvZod7yPUMuakhmaKV8Z0DVr0RO1pyw9vW7YOkmDH=oW3xyDA@mail.gmail.com> <20200617025014.GB10812@carbon.lan>
In-Reply-To: <20200617025014.GB10812@carbon.lan>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 16 Jun 2020 19:59:40 -0700
Message-ID: <CALvZod5CiU8qKNCo7gjh5O=BSGkM8Hj3Jr9ppmoWq+YY7w19Nw@mail.gmail.com>
Subject: Re: [PATCH v6 01/19] mm: memcg: factor out memcg- and lruvec-level
 changes out of __mod_lruvec_state()
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 16, 2020 at 7:50 PM Roman Gushchin <guro@fb.com> wrote:
>
> On Tue, Jun 16, 2020 at 06:52:09PM -0700, Shakeel Butt wrote:
> > On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
> > >
> > > To convert memcg and lruvec slab counters to bytes there must be
> > > a way to change these counters without touching node counters.
> > > Factor out __mod_memcg_lruvec_state() out of __mod_lruvec_state().
> > >
> > > Signed-off-by: Roman Gushchin <guro@fb.com>
> > > Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> > > Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> > > ---
> > >  include/linux/memcontrol.h | 17 +++++++++++++++
> > >  mm/memcontrol.c            | 43 +++++++++++++++++++++-----------------
> > >  2 files changed, 41 insertions(+), 19 deletions(-)
> > >
> > > diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> > > index bbf624a7f5a6..93dbc7f9d8b8 100644
> > > --- a/include/linux/memcontrol.h
> > > +++ b/include/linux/memcontrol.h
> > > @@ -679,11 +679,23 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
> > >         return x;
> > >  }
> > >
> > > +void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
> > > +                             int val);
> > >  void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
> > >                         int val);
> > >  void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val);
> > >  void mod_memcg_obj_state(void *p, int idx, int val);
> > >
> > > +static inline void mod_memcg_lruvec_state(struct lruvec *lruvec,
> > > +                                         enum node_stat_item idx, int val)
> >
> > Is this function used in later patches? Any benefit introducing it
> > here instead of in the patch where it is used for the first time?
>
> Yes, it's used in "mm: memcg/slab: charge individual slab objects instead of pages".
>
> It's a fairly large patchset with many internal dependencies, so there is
> always a trade-off between putting everything into a single patch, which is
> hard to review, and splitting out some changes, which make not much sense
> without seeing the whole picture.
>
> In this particular case splitting out a formal and easy-to-verify change makes
> the actual non-trivial patch smaller and hopefully easier for a review.
>
> But of course it's all subjective.
>
> Thanks!

I am fine with that.

Reviewed-by: Shakeel Butt <shakeelb@google.com>
