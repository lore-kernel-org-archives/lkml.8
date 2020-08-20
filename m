Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-3.6 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D819FC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:06:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B493620724
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 14:06:30 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="OefLEHD7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727956AbgHTOG2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 10:06:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728107AbgHTOC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 10:02:28 -0400
Received: from mail-ot1-x344.google.com (mail-ot1-x344.google.com [IPv6:2607:f8b0:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77BF9C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 07:02:28 -0700 (PDT)
Received: by mail-ot1-x344.google.com with SMTP id k12so1545050otr.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 07:02:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7V8Nr2ZLqIB6Fm+9YdweCl6lFef8zjHx+W/eb65CZWQ=;
        b=OefLEHD7/gsOkGowHqibgIn2BvXcvuSIL22NvNVC0MKMv5EA1gcTDshdsOrsDs6R9v
         tTBVEFdNJQzdjBtZFcFFOolTJQv6VHaN/ASR/ZWU/Vnct1lKzJOXm/QY4/cW47+Rf24o
         vG7ZfKsIiBMwzpeADcDKuYghAGbkKoLTOIuziuJDtDZHeX9Az+QoghHLruquO3FLGu9J
         dhE4yJGGdbNtSP2y9SGBr/zu5pwOLpX4PVQqgdir1/JPbfDUNl2FtZdCw0yUtJCv6pis
         5NnlORyNniDGHK6wXeynz+OE7rcy/1+jngd7A5uPpyV0Cuy44m/qZMlsEh/FBRJeoukR
         OGGw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7V8Nr2ZLqIB6Fm+9YdweCl6lFef8zjHx+W/eb65CZWQ=;
        b=WOP1Wc1R+AtqutZhnK1rwbFR5Un4Z+zd+fa+PqWZ3xktHPew76QsZ0oqE0nQ21XlsR
         goyx9/DHhRTkvv8+EMdS1XtiQrtbn8NdcGvKANkdiY8kjTrX1oFl1SQ5a38sUZa2fVtL
         KBudG8n9jlCPqU4UarO2LoFk3vcRYQ+nKsP7b9a323RzoLkf/5fZZ+U9N5ifpmqDAYAW
         xHycggJ0fmnfNjyoNUihQkYuWRmTs0T61Sx6wmbA0Lcl2/UVYX5G+iqQgMcneR2j7zTE
         vKkPHZYZr+xrL/rfl+TZ/tLv//KK2GtCG0Onkv693StDZ+eATR0/RPMMXHhg7ajz5EFm
         j++Q==
X-Gm-Message-State: AOAM531YMdU/HrVkgA/HuhojyAqJtSEwn+uIeuABFkuLtpVJ0G18Wtdw
        wQd6S1G5l365Pger5ge/1Si8tUNEmeb6fw7UaQpY7x2fX5F6Pg==
X-Google-Smtp-Source: ABdhPJxNrSm5Cym3X45sROT/6O/6U1GXm4ggcTQuxN/It21oRPEZksIOUhBRINM1ziaOxCi0/LAwp6fjhlakocSZPfI=
X-Received: by 2002:a9d:20c4:: with SMTP id x62mr2038263ota.99.1597932147885;
 Thu, 20 Aug 2020 07:02:27 -0700 (PDT)
MIME-Version: 1.0
References: <1597061872-58724-1-git-send-email-xlpang@linux.alibaba.com>
In-Reply-To: <1597061872-58724-1-git-send-email-xlpang@linux.alibaba.com>
From:   Pekka Enberg <penberg@gmail.com>
Date:   Thu, 20 Aug 2020 17:02:10 +0300
Message-ID: <CAOJsxLE9SkLY5V=D=Ot1oyLkbAORagfozYqxk1iNDW6b7QZrwg@mail.gmail.com>
Subject: Re: [PATCH v2 0/3] mm/slub: Fix count_partial() problem
To:     Xunlei Pang <xlpang@linux.alibaba.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>, Christoph Lameter <cl@linux.com>,
        Wen Yang <wenyang@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>,
        Konstantin Khlebnikov <khlebnikov@yandex-team.ru>,
        David Rientjes <rientjes@google.com>,
        LKML <linux-kernel@vger.kernel.org>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Aug 10, 2020 at 3:18 PM Xunlei Pang <xlpang@linux.alibaba.com> wrote:
>
> v1->v2:
> - Improved changelog and variable naming for PATCH 1~2.
> - PATCH3 adds per-cpu counter to avoid performance regression
>   in concurrent __slab_free().
>
> [Testing]
> On my 32-cpu 2-socket physical machine:
> Intel(R) Xeon(R) CPU E5-2650 v2 @ 2.60GHz
> perf stat --null --repeat 10 -- hackbench 20 thread 20000
>
> == original, no patched
>       19.211637055 seconds time elapsed                                          ( +-  0.57% )
>
> == patched with patch1~2
>  Performance counter stats for 'hackbench 20 thread 20000' (10 runs):
>
>       21.731833146 seconds time elapsed                                          ( +-  0.17% )
>
> == patched with patch1~3
>  Performance counter stats for 'hackbench 20 thread 20000' (10 runs):
>
>       19.112106847 seconds time elapsed                                          ( +-  0.64% )
>
>
> Xunlei Pang (3):
>   mm/slub: Introduce two counters for partial objects
>   mm/slub: Get rid of count_partial()
>   mm/slub: Use percpu partial free counter
>
>  mm/slab.h |   2 +
>  mm/slub.c | 124 +++++++++++++++++++++++++++++++++++++++++++-------------------
>  2 files changed, 89 insertions(+), 37 deletions(-)

We probably need to wrap the counters under CONFIG_SLUB_DEBUG because
AFAICT all the code that uses them is also wrapped under it.

An alternative approach for this patch would be to somehow make the
lock in count_partial() more granular, but I don't know how feasible
that actually is.

Anyway, I am OK with this approach:

Reviewed-by: Pekka Enberg <penberg@kernel.org>

You still need to convince Christoph, though, because he had
objections over this approach.

- Pekka
