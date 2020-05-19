Return-Path: <SRS0=IaiW=7B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.9 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id CB27EC433E0
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:38:01 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 9BA8B206D4
	for <linux-kernel@archiver.kernel.org>; Tue, 19 May 2020 02:38:01 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=lca.pw header.i=@lca.pw header.b="Mh9PV2be"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727030AbgESCiA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 18 May 2020 22:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58822 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726302AbgESCiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 May 2020 22:38:00 -0400
Received: from mail-ej1-x642.google.com (mail-ej1-x642.google.com [IPv6:2a00:1450:4864:20::642])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D84C2C05BD09
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 19:37:58 -0700 (PDT)
Received: by mail-ej1-x642.google.com with SMTP id s21so10544028ejd.2
        for <linux-kernel@vger.kernel.org>; Mon, 18 May 2020 19:37:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=lca.pw; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=1cHkZoHQXI3aEuEjslUR4plc1ANHqu9wqQB4RG/kOcg=;
        b=Mh9PV2beR8kr3sxrsvtSNBQkdVdaxMDyWEAR2BMrKGoZGEcLEsnHv0wI4lF5m6XERu
         JvelpzFXtcY8ryrfqTkyQEGTQmv4WXI2Dh7AjkIKEytkAabZGXbXoTPk31UF9p6/tjlK
         LQaieh22LBBb9He/v+ecjLB0cQvCZ/TTiegmxZwkYTp7SptjPtEpPVKmYxbwwxGo4j6H
         PXQfoOTEvBRVFcUUkwhkowsJGWpLTkrTc93AG0Dyk2c6Kizmq3BsUbSgXap+UhHnOWfI
         bFuWi+hQxnmLCCP7Fa2oF9mX2/zuzfQTqydfJMT5u9z75zlp+ALwcqCBOeSUIXEUdQG8
         qkvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=1cHkZoHQXI3aEuEjslUR4plc1ANHqu9wqQB4RG/kOcg=;
        b=lfjPU2o7hF3r1MczKhLdJFbHlaiSpbG+CJhdGAoIguqXHo4YhCDtRz5OmQSNGfax3o
         CBlYJxo2abDs0ogMs/+Uv7bo7tMRs2VsCOOjFv9pAHDZMTn+jgeKBNHMO0mUY2UivpAg
         Nftypgzy5Vqm/zh17vo8qOU5OzjX00we6PKoncmIkl2+oVxl6xAyS5UqBtVTKOb9GSEF
         ne8cMNd9jghxHES/wLj3BbmeyieWvaXO8oNmfSD7NRVxjn1iEr8IxHBoEr3hwapzovJz
         6BPmJFUKEatwZQNDbCmdxzVV3exz6mvbdxVY2IJA+XQIrvgmaxKk1Mt0KQdg6Zgfw1PW
         EfJA==
X-Gm-Message-State: AOAM532K9ERRXI+m38lWk+1bCZlVE3K3B7CSwcFjrHTFZOwdNQ25munj
        dVENLPhnCAQNXNNFB2efeNvExUK7mdiRjykSLKgYWw==
X-Google-Smtp-Source: ABdhPJym++ET8pX585JqnYzfTr1oJlMw9Xvo0N1SCn5yizGiDgDmWwu0zC+WVLteLp6JBpx93hcYibSG+DSDA8Vu7Q8=
X-Received: by 2002:a17:906:af47:: with SMTP id ly7mr552521ejb.98.1589855877357;
 Mon, 18 May 2020 19:37:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200427235621.7823-4-longman@redhat.com> <F1FA6654-C07C-42FD-B497-61EB635B264C@lca.pw>
 <638f59c0-60f1-2279-fea6-28b2980720f4@redhat.com>
In-Reply-To: <638f59c0-60f1-2279-fea6-28b2980720f4@redhat.com>
From:   Qian Cai <cai@lca.pw>
Date:   Mon, 18 May 2020 22:37:46 -0400
Message-ID: <CAG=TAF78e=71-cUt2jaTgY8QZDmucRO2JRo-rEWALe+dGVxoQw@mail.gmail.com>
Subject: Re: [PATCH v2 3/4] mm/slub: Fix another circular locking dependency
 in slab_attr_store()
To:     Waiman Long <longman@redhat.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>,
        Juri Lelli <juri.lelli@redhat.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, May 18, 2020 at 6:05 PM Waiman Long <longman@redhat.com> wrote:
>
> On 5/16/20 10:19 PM, Qian Cai wrote:
> >
> >> On Apr 27, 2020, at 7:56 PM, Waiman Long <longman@redhat.com> wrote:
> >>
> >> It turns out that switching from slab_mutex to memcg_cache_ids_sem in
> >> slab_attr_store() does not completely eliminate circular locking dependency
> >> as shown by the following lockdep splat when the system is shut down:
> >>
> >> [ 2095.079697] Chain exists of:
> >> [ 2095.079697]   kn->count#278 --> memcg_cache_ids_sem --> slab_mutex
> >> [ 2095.079697]
> >> [ 2095.090278]  Possible unsafe locking scenario:
> >> [ 2095.090278]
> >> [ 2095.096227]        CPU0                    CPU1
> >> [ 2095.100779]        ----                    ----
> >> [ 2095.105331]   lock(slab_mutex);
> >> [ 2095.108486]                                lock(memcg_cache_ids_sem);
> >> [ 2095.114961]                                lock(slab_mutex);
> >> [ 2095.120649]   lock(kn->count#278);
> >> [ 2095.124068]
> >> [ 2095.124068]  *** DEADLOCK ***
> > Can you show the full splat?
> >
> >> To eliminate this possibility, we have to use trylock to acquire
> >> memcg_cache_ids_sem. Unlikely slab_mutex which can be acquired in
> >> many places, the memcg_cache_ids_sem write lock is only acquired
> >> in memcg_alloc_cache_id() to double the size of memcg_nr_cache_ids.
> >> So the chance of successive calls to memcg_alloc_cache_id() within
> >> a short time is pretty low. As a result, we can retry the read lock
> >> acquisition a few times if the first attempt fails.
> >>
> >> Signed-off-by: Waiman Long <longman@redhat.com>
> > The code looks a bit hacky and probably not that robust. Since it is the shutdown path which is not all that important without lockdep, maybe you could drop this single patch for now until there is a better solution?
>
> That is true. Unlike using the slab_mutex, the chance of failing to
> acquire a read lock on memcg_cache_ids_sem is pretty low. Maybe just
> print_once a warning if that happen.

That seems cleaner. If you are going to repost this series, you could
also mention that the series will fix slabinfo triggering a splat as
well.
