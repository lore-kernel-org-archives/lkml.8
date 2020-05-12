Return-Path: <SRS0=0vny=62=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1E10BC54E4A
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id EDAE020752
	for <linux-kernel@archiver.kernel.org>; Tue, 12 May 2020 14:03:19 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="QQawiJ16"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730197AbgELODT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 12 May 2020 10:03:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728085AbgELODS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 May 2020 10:03:18 -0400
Received: from mail-qv1-xf44.google.com (mail-qv1-xf44.google.com [IPv6:2607:f8b0:4864:20::f44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76262C061A0C
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 07:03:18 -0700 (PDT)
Received: by mail-qv1-xf44.google.com with SMTP id x13so4444777qvr.2
        for <linux-kernel@vger.kernel.org>; Tue, 12 May 2020 07:03:18 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HdL0PoelnNwC+IbWuQ/qzw1k9SeDaMleYXr87Z/Ant4=;
        b=QQawiJ16cJoOdX0v2O/nrybNFbweTZ9aWk/wAttBFTUWRgH/uywBEmgJJ3u+gYjdHG
         dIPfgBZVU75hHbpayW0czEXxkxEh/A5qfr1ZsTdqgRWFiK9+8OC+AWGCyOzUQUcbVeLK
         tHy1StevFR2QW2LRSkYwbXwSIJz8ZyEyRyjeRFgKDl9WCS++62M7d9VDQYbZW8ZQiy4N
         8cn2evMhjL/a4EoYxDJEVZ72F+pdtNbnWyP+hHtRCCHCvn4NdY1ndpZBrX98ivNdAmNm
         UsrZjKOhnc6ozhKsb4K5sEE3WTthuFvFkcFoU1rmmii8PPNouLKmwZGVUUkRbQwXrbSb
         tI1g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HdL0PoelnNwC+IbWuQ/qzw1k9SeDaMleYXr87Z/Ant4=;
        b=Q0NBK5lHZsAcHvWtKSXeF4OMVAmj+MWvjZiX4XJroRAqc7VZotpDIXZeWV6STScnXP
         RM6VIWm9SpmFzXmSqK9rQhcOYbDaactyVyLnrvp14eIdd5NyY5OWtbQhjBDEONloJil7
         vRTV9LNVsrLhcipx1qDW0PIY6ttxDR6/0OdYfpWJob3KQJIsqB/QyEQcIQY3d0+q5Dg+
         Ep3utR74FocJBg661qJJjZxY6AFHyD+51ArER/VaN+3Jk3x3cnlj9DCDA9lBJ2/jvQIw
         pKSB67JfmLrhcZ4UB3oUMR4KOziMwH1Rdoy8YxiJIrfJuXRCl7QXfDIpBmnQEY1lN3QO
         PfnQ==
X-Gm-Message-State: AGi0PuaekFZNiKiQzHyV7BcSPwj0pytalqNHmdekZjyoLxskQNOCGEik
        j9zUnluJRLxQziDlOws7YhyO8tc/o7fFrSjrCwJR5g==
X-Google-Smtp-Source: APiQypLeYRdXP9XHSuSKifMwGDuYtaRqyPQRWpx7Vs6/N1ChFkyDoVmidHX3CJDHhIV3yP+8cu5pPFKpdHj7jZgor0Y=
X-Received: by 2002:ad4:4d06:: with SMTP id l6mr21334959qvl.34.1589292197432;
 Tue, 12 May 2020 07:03:17 -0700 (PDT)
MIME-Version: 1.0
References: <20200511023111.15310-1-walter-zh.wu@mediatek.com>
 <CACT4Y+YWNwTSoheJhc3nMdQi9m719F3PzpGo3TfRY3zAg9EwuQ@mail.gmail.com>
 <CACT4Y+bO1Zg_jgFHbOWgp7fLAADOQ_-AZmjEHz0WG7=oyOt4Gg@mail.gmail.com>
 <1589203771.21284.22.camel@mtksdccf07> <CACT4Y+aOkuH6Dn+L+wv1qVOLgXyCY_Ck4hecAMw3DgyBgC9qHw@mail.gmail.com>
 <1589254720.19238.36.camel@mtksdccf07>
In-Reply-To: <1589254720.19238.36.camel@mtksdccf07>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Tue, 12 May 2020 16:03:06 +0200
Message-ID: <CACT4Y+aibZEBR-3bos3ox5Tuu48TnHC20mDDN0AkWeRUKrT0aw@mail.gmail.com>
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

On Tue, May 12, 2020 at 5:38 AM Walter Wu <walter-zh.wu@mediatek.com> wrote:
> > Are you sure it will increase object size?
> > I think we overlap kasan_free_meta with the object as well. The only
> > case we don't overlap kasan_free_meta with the object are
> > SLAB_TYPESAFE_BY_RCU || cache->ctor. But these are rare and it should
> > only affect small objects with small redzones.
> > And I think now we simply have a bug for these objects, we check
> > KASAN_KMALLOC_FREE and then assume object contains free stack, but for
> > objects with ctor, they still contain live object data, we don't store
> > free stack in them.
> > Such objects can be both free and still contain user data.
> >
>
> Overlay kasan_free_meta. I see. but overlay it only when the object was
> freed. kasan_free_meta will be used until free object.
> 1). When put object into quarantine, it need kasan_free_meta.
> 2). When the object exit from quarantine, it need kasan_free_meta
>
> If we choose to overlay kasan_free_meta, then the free stack will be
> stored very late. It may has no free stack in report.

Sorry, I don't understand what you mean.

Why will it be stored too late?
In __kasan_slab_free() putting into quarantine and recording free
stack are literally adjacent lines of code:

static bool __kasan_slab_free(struct kmem_cache *cache, void *object,
      unsigned long ip, bool quarantine)
{
    ...
    kasan_set_free_info(cache, object, tag);
    quarantine_put(get_free_info(cache, object), cache);


Just to make sure, what I meant is that we add free_track to kasan_free_meta:

struct kasan_free_meta {
    struct qlist_node quarantine_link;
+  struct kasan_track free_track;
};

And I think its life-time and everything should be exactly what we need.

Also it should help to fix the problem with ctors: kasan_free_meta is
already allocated on the side for such objects, and that's exactly
what we need for objects with ctor's.
