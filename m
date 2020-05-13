Return-Path: <SRS0=g10L=63=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1A8C9C47077
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:16:16 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id E9DE020769
	for <linux-kernel@archiver.kernel.org>; Wed, 13 May 2020 09:16:15 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="A5K6VoJj"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1732469AbgEMJQP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 13 May 2020 05:16:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1730334AbgEMJQO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 May 2020 05:16:14 -0400
Received: from mail-qk1-x744.google.com (mail-qk1-x744.google.com [IPv6:2607:f8b0:4864:20::744])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D133C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 02:16:14 -0700 (PDT)
Received: by mail-qk1-x744.google.com with SMTP id f189so10916691qkd.5
        for <linux-kernel@vger.kernel.org>; Wed, 13 May 2020 02:16:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=itos8LHRnARIlzXTWR1kJY/omxPbBoUWPcSfUqjsoA4=;
        b=A5K6VoJjI1dL1KN/df5QAgoFGmJhl6hWdd6tZEPcPBTKXaPrdVWtwhgh8whNo4BjYe
         bm+xeV36/ASRg95TApfRBFZ6lB1iULFvHksmM/H4aSPXFYUIshFowGhO6YmjyogHCYkh
         0Q8LujaVHkcfsfLQDRh3E6L2ke6nGUOYrADpgIpAXMeMZOCIHCypUbWJFzyIPmN5Mq+x
         +1A4YD7OT1Xz0L1cZ/z848MWlGSbO3bosMDEeR9ZYiGZzzArSWG8X8G0pSWj1sYo6FZl
         MabnV+0zbmVxYJsgjX5/iHjXfmdXLBYwRV0OZzQ3T7Xn4UDHhm4a66yvWMlwC6HoKgcb
         2G6g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=itos8LHRnARIlzXTWR1kJY/omxPbBoUWPcSfUqjsoA4=;
        b=UafJaels1ZkwsVQyWNiW5VfCmKKfg868UqwSidiVq5cQxdu/DeKGMeAJdUPQb2VhPI
         KJuknSLGfwlGHbhRoQ/342dSJW+b7H2hqHyFL8WQIjHGbEvtwleT5LiO8UPxKk28vZNQ
         CmxcJlIVaDlEUf9bj2gk/Hyy7xiUGUXhhC1tsOaiKP4giOoarmp8N5QRWevRIxWbZ9b2
         VAzfla1h0dCm2n7oTJ8TI+m4+KKZgxZLK0TyBtajU87GDmg17j2kAKLQfXQiEXfy2FW3
         x6mKHN8t4zhzVquG2a9mbo52pAsSR3j88A+R2jXiWqWM9Q092OoY4xpN2FzPCHY+puei
         1ncg==
X-Gm-Message-State: AGi0PuY9YtT6lqShlUhW8d1xXRtTHC2vH7OY7iqOnDMvE1tvjsg9JMGT
        rwjuj0RyUGIGuLjowQoDGetikWmAeCp1PNqx7z6IMg==
X-Google-Smtp-Source: APiQypIE87rxAxLEvN7Ltlce+BhZ2RRfTe25rMKOww/RPsuGzoqNr6115x+MMkD1jTpUE32u2OzrCXzfozbHr3GSb/w=
X-Received: by 2002:a37:9d55:: with SMTP id g82mr21819383qke.407.1589361373420;
 Wed, 13 May 2020 02:16:13 -0700 (PDT)
MIME-Version: 1.0
References: <20200511023111.15310-1-walter-zh.wu@mediatek.com>
 <CACT4Y+YWNwTSoheJhc3nMdQi9m719F3PzpGo3TfRY3zAg9EwuQ@mail.gmail.com>
 <CACT4Y+bO1Zg_jgFHbOWgp7fLAADOQ_-AZmjEHz0WG7=oyOt4Gg@mail.gmail.com>
 <1589203771.21284.22.camel@mtksdccf07> <CACT4Y+aOkuH6Dn+L+wv1qVOLgXyCY_Ck4hecAMw3DgyBgC9qHw@mail.gmail.com>
 <1589254720.19238.36.camel@mtksdccf07> <CACT4Y+aibZEBR-3bos3ox5Tuu48TnHC20mDDN0AkWeRUKrT0aw@mail.gmail.com>
 <1589334472.19238.44.camel@mtksdccf07> <CACT4Y+Zv3rCZs8z56NHM0hHWMwQr_2AT8nx0vUigzMG2v3Rt8Q@mail.gmail.com>
 <1589360744.14554.10.camel@mtksdccf07>
In-Reply-To: <1589360744.14554.10.camel@mtksdccf07>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Wed, 13 May 2020 11:16:01 +0200
Message-ID: <CACT4Y+ZycfHeP5xqqkihRHx-aOoBhN9XdhUmzCdTfaYPXTCzAA@mail.gmail.com>
Subject: Re: [PATCH v2 1/3] rcu/kasan: record and print call_rcu() call stack
To:     Walter Wu <walter-zh.wu@mediatek.com>
Cc:     Andrey Ryabinin <aryabinin@virtuozzo.com>,
        Alexander Potapenko <glider@google.com>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Josh Triplett <josh@joshtriplett.org>,
        Mathieu Desnoyers <mathieu.desnoyers@efficios.com>,
        Lai Jiangshan <jiangshanlai@gmail.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        kasan-dev <kasan-dev@googlegroups.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, May 13, 2020 at 11:05 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
>
> On Wed, 2020-05-13 at 08:51 +0200, 'Dmitry Vyukov' via kasan-dev wrote:
> > On Wed, May 13, 2020 at 3:48 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > > > > > Are you sure it will increase object size?
> > > > > > I think we overlap kasan_free_meta with the object as well. The only
> > > > > > case we don't overlap kasan_free_meta with the object are
> > > > > > SLAB_TYPESAFE_BY_RCU || cache->ctor. But these are rare and it should
> > > > > > only affect small objects with small redzones.
> > > > > > And I think now we simply have a bug for these objects, we check
> > > > > > KASAN_KMALLOC_FREE and then assume object contains free stack, but for
> > > > > > objects with ctor, they still contain live object data, we don't store
> > > > > > free stack in them.
> > > > > > Such objects can be both free and still contain user data.
> > > > > >
> > > > >
> > > > > Overlay kasan_free_meta. I see. but overlay it only when the object was
> > > > > freed. kasan_free_meta will be used until free object.
> > > > > 1). When put object into quarantine, it need kasan_free_meta.
> > > > > 2). When the object exit from quarantine, it need kasan_free_meta
> > > > >
> > > > > If we choose to overlay kasan_free_meta, then the free stack will be
> > > > > stored very late. It may has no free stack in report.
> > > >
> > > > Sorry, I don't understand what you mean.
> > > >
> > > > Why will it be stored too late?
> > > > In __kasan_slab_free() putting into quarantine and recording free
> > > > stack are literally adjacent lines of code:
> > > >
> > > > static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
> > > >       unsigned long ip, bool quarantine)
> > > > {
> > > >     ...
> > > >     kasan_set_free_info(cache, object, tag);
> > > >     quarantine_put(get_free_info(cache, object), cache);
> > > >
> > > >
> > > > Just to make sure, what I meant is that we add free_track to kasan_free_meta:
> > > >
> > > > struct kasan_free_meta {
> > > >     struct qlist_node quarantine_link;
> > > > +  struct kasan_track free_track;
> > > > };
> > > >
> > >
> > > When I see above struct kasan_free_meta, I know why you don't understand
> > > my meaning, because I thought you were going to overlay the
> > > quarantine_link by free_track, but it seems like to add free_track to
> > > kasan_free_meta. Does it enlarge meta-data size?
> >
> > I would assume it should not increase meta-data size. In both cases we
> > store exactly the same information inside of the object: quarantine
> > link and free track.
> > I see it more as a question of code organization. We already have a
> > concept of "this data is placed inside of the freed object", we
> > already have a name for it (kasan_free_meta), we already have code to
> > choose where to place it, we already have helper functions to access
> > it. And your change effectively duplicates all of this to place the
> > free track.
> >
>
> I want to make a summary. Which of the following is the approach we
> want? or if I have some misunderstandings, please help me to correct.
> Thanks.
>
> 1) For different object, then it will has two ways.
> 1.a) When object are LAB_TYPESAFE_BY_RCU || cache->ctor, then store free
> stack into free track of struct kasan_free_meta.
> 2.b) Except 1.a), store free stack into freed object.
>
> or
>
> 2) We always store free stack into free track of struct kasan_free_meta

I meant 2): We always store free stack into free track of struct
kasan_free_meta.
I think it will do the same as other options but just with less code
(and simpler code).

Maybe I am missing something here?




> > > > And I think its life-time and everything should be exactly what we need.
> > > >
> > > > Also it should help to fix the problem with ctors: kasan_free_meta is
> > > > already allocated on the side for such objects, and that's exactly
> > > > what we need for objects with ctor's.
> > >
> > > I see.
