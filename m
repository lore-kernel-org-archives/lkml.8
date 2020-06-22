Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 36182C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:13:02 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1148E20707
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:13:02 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="aEK0cKVi"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729876AbgFVRNA (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:13:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729782AbgFVRNA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:13:00 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99BF3C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 10:12:59 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id e4so20213187ljn.4
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 10:12:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=MczyUKnr4KWUAWPoNy99bqHhQdcxqPt73wnuGURBYbQ=;
        b=aEK0cKViZ7S0ph9kpZzVfQ8A5ynsiYQa5Ts9xIn8wvCwAjTrINbnY8Byk4x5iPjnzi
         0f5U3r+rzHHR+UgvV3vizeA9X+il3u/h+WckB5KVVg0HTFJ6hBT6RQIzbULIczNgw2TG
         JPGAvh8TP5j0jkbZJhlJ0T1X0+O0QjBCuUNiETb0lo5MRGcIb055JksnVkM2kUmooeqj
         /3k8TZrUdya8ulEA7Gqc2fiZZ0wyB+IpsmEqOz9/k/qrTX1zaqyhc2QbdlmOipvZ4YQ8
         l/8kfFRLCxb4SoYGvY9E4D9vtmEloxBLuTQJ+Xfn+eMPqykXBHVK/GEU95kaavsusBqI
         ia0g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=MczyUKnr4KWUAWPoNy99bqHhQdcxqPt73wnuGURBYbQ=;
        b=fZnUOMdZEHrEXBt5CjzaDj4WXCcMZqWcZhGNJJo4+b2Ky/T0GYNRWAVAWhvRASLKmU
         wuqLS7vhvLd6Ze6GbexFOlGNTWgTcJA5kL78UK42TeZm24TmdnMbtdb762SA9pdIyPY9
         Kc4IEkOiOBRh9stSfWP6hHg/kWA+bOBrk4RkyB9OfbZsKPGnl/MLuAS2g2WsP9hxeLat
         M9g3KAtaxwqqfT+u1w4dTOzb0MfsbDEVnW34LJ+JbEY0f2bMsemt9ttojv0VXj+Lknmz
         sQXvSA3xjBO0sLtsg7KeCnUSyx+e4xs42d/xovK1ymyUQviGWgaDX3geqcGMGrnTcFEs
         /qOA==
X-Gm-Message-State: AOAM532LG+H6tek1pDLiVexYpTMTpBxQ4uefp5r/17+FpiKt6iO9lU/k
        EbW8plcPV63ylGDfD973aZStw2Xtea1IyLNE/KX+rw==
X-Google-Smtp-Source: ABdhPJzz/cwMqUCaSL9gP+/s5pE/WjebWsM0Egj2WRCtgz8ZOXxoB5kYkg/zYWM8ANzketpHei1+R4XnkESbxhA0b3g=
X-Received: by 2002:a2e:910c:: with SMTP id m12mr9512410ljg.332.1592845977819;
 Mon, 22 Jun 2020 10:12:57 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-11-guro@fb.com>
In-Reply-To: <20200608230654.828134-11-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 22 Jun 2020 10:12:46 -0700
Message-ID: <CALvZod4Bfx3j+=spRSct5_cBL4U+XFF228iZt3EdkGqf4kokrQ@mail.gmail.com>
Subject: Re: [PATCH v6 10/19] mm: memcg/slab: deprecate memory.kmem.slabinfo
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
> Deprecate memory.kmem.slabinfo.
>
> An empty file will be presented if corresponding config options are
> enabled.
>
> The interface is implementation dependent, isn't present in cgroup v2,
> and is generally useful only for core mm debugging purposes. In other
> words, it doesn't provide any value for the absolute majority of users.
>
> A drgn-based replacement can be found in tools/cgroup/slabinfo.py .
> It does support cgroup v1 and v2, mimics memory.kmem.slabinfo output
> and also allows to get any additional information without a need
> to recompile the kernel.
>
> If a drgn-based solution is too slow for a task, a bpf-based tracing
> tool can be used, which can easily keep track of all slab allocations
> belonging to a memory cgroup.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Hi Roman,

I am not against removing the memory.kmem.slabinfo interface but I
would like to have an alternative solution more accessible than
tools/cgroup/slabinfo.py.

In our case, we don't have ssh access and if we need something for
debugging, it is much more preferable to provide a file to read to
SREs. After the review, that file will be added to a whitelist and
then we can directly read that file through automated tools without
approval for each request.

I am just wondering if a file interface can be provided for whatever
tools/cgroup/slabinfo.py is providing.

Shakeel
