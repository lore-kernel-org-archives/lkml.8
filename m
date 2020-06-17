Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 97E20C433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 01:52:26 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 722B620C09
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 01:52:26 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HeT5Exh5"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726639AbgFQBwZ (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 21:52:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55436 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726253AbgFQBwX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 21:52:23 -0400
Received: from mail-lj1-x241.google.com (mail-lj1-x241.google.com [IPv6:2a00:1450:4864:20::241])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B01D4C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 18:52:22 -0700 (PDT)
Received: by mail-lj1-x241.google.com with SMTP id n24so837189lji.10
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 18:52:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Hs8Cat8bZTOs/g3e5u5zu4I8c3QADLQ9ogPtTS3pDjQ=;
        b=HeT5Exh5fEtOJpP//JnKtRjulLeFEmNguq4snh/ycH/k8l1/xgJXSTeONIWqNrNwbk
         Dh3R7WwjUOPd8YAXlE/2Syp+7ZZD8ajyyrTVPP92h2pfUclYacudqJ1MycXtqx6DS6lP
         j1XMVtKsUdK9PPBqtzue5nI1/AjJmuCaoY0RaD2GX3IqM8kK6V47CiCLddl1pgjJI/y1
         I9o5eYIsVGMh47jO0kTMI7z9cAwZ4NQlhYH0KIn/qGVGBIWWmw1ItXIf156cwVzZFEzv
         0TEU6ez+9EnAtjUOyAewoI1Hw4fdOoL2q1Qn80o9FklGP6ot7ds1gDAQ0K5wAeiDVgFu
         mBpQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Hs8Cat8bZTOs/g3e5u5zu4I8c3QADLQ9ogPtTS3pDjQ=;
        b=JK+sCn3YMZ7ukPIdMKHFfaWj9kjiZO0Rkx6hSHy8BA6sQkVJQOjcm8Ya8n3W2skq5V
         omUbXnhFnYA008oioVzBU6OkfllwtbAiwckGEDp19Q/vWTkXjGkPlc40GZNaPShCMcda
         DoqgQUs4h6blhEvOXORlCNL8R/7Dk7OM0UKgMYDjzKnfJbsbuMk603pzhKgZmZRNWGIO
         ACy3c9aDcvlFaeCEoKCeftmixHlWvcB34GTapzqpbOTl97vy2aDJKQR4Bo7dIvunOJYV
         sOr6RpQRvgRKlHTY9K9MYkmdY+HyQX4rTpsFeB3C8hHb835ghMeTIQxXvMn/7NUrD5R2
         9OrA==
X-Gm-Message-State: AOAM531sAzv17jFmItaY56tzOmQdzcQO1OKdTATMZWZKbSl26mYk+DGK
        NHzxOwS42EgxQFE1+aWpjcCa8iTqD4T8rpeqEIdEig==
X-Google-Smtp-Source: ABdhPJwDS8HadRR7DfyOCxHk13sgCYSWmuDmmAtr6leoevRVwgAlb9iHKtjEpLx/xEhXbTWRULjmZcUEwC6nURs67GU=
X-Received: by 2002:a2e:9ac4:: with SMTP id p4mr3013566ljj.446.1592358740700;
 Tue, 16 Jun 2020 18:52:20 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-2-guro@fb.com>
In-Reply-To: <20200608230654.828134-2-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 16 Jun 2020 18:52:09 -0700
Message-ID: <CALvZod7yPUMuakhmaKV8Z0DVr0RO1pyw9vW7YOkmDH=oW3xyDA@mail.gmail.com>
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

On Mon, Jun 8, 2020 at 4:07 PM Roman Gushchin <guro@fb.com> wrote:
>
> To convert memcg and lruvec slab counters to bytes there must be
> a way to change these counters without touching node counters.
> Factor out __mod_memcg_lruvec_state() out of __mod_lruvec_state().
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---
>  include/linux/memcontrol.h | 17 +++++++++++++++
>  mm/memcontrol.c            | 43 +++++++++++++++++++++-----------------
>  2 files changed, 41 insertions(+), 19 deletions(-)
>
> diff --git a/include/linux/memcontrol.h b/include/linux/memcontrol.h
> index bbf624a7f5a6..93dbc7f9d8b8 100644
> --- a/include/linux/memcontrol.h
> +++ b/include/linux/memcontrol.h
> @@ -679,11 +679,23 @@ static inline unsigned long lruvec_page_state_local(struct lruvec *lruvec,
>         return x;
>  }
>
> +void __mod_memcg_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
> +                             int val);
>  void __mod_lruvec_state(struct lruvec *lruvec, enum node_stat_item idx,
>                         int val);
>  void __mod_lruvec_slab_state(void *p, enum node_stat_item idx, int val);
>  void mod_memcg_obj_state(void *p, int idx, int val);
>
> +static inline void mod_memcg_lruvec_state(struct lruvec *lruvec,
> +                                         enum node_stat_item idx, int val)

Is this function used in later patches? Any benefit introducing it
here instead of in the patch where it is used for the first time?

> +{
> +       unsigned long flags;
> +
> +       local_irq_save(flags);
> +       __mod_memcg_lruvec_state(lruvec, idx, val);
> +       local_irq_restore(flags);
> +}
> +
[...]
