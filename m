Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 954F6C433E1
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:29:45 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 29DA22073E
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:29:45 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="f8q5Ux28"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730036AbgFVR3n (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56812 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729605AbgFVR3n (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:29:43 -0400
Received: from mail-lf1-x142.google.com (mail-lf1-x142.google.com [IPv6:2a00:1450:4864:20::142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78972C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 10:29:42 -0700 (PDT)
Received: by mail-lf1-x142.google.com with SMTP id o4so10109220lfi.7
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 10:29:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OANw2HePj9Aqy4TDtb05tpT/a2lkwTwt5qwm1TtUltk=;
        b=f8q5Ux28j651L7cU7a9F3GxkuERNMlXyOG1vAbcoHRt7bY5wP8d4AnBs7q4KZJ1TVk
         Lq3oooFQPTad5cCt5EHm6dWnFkgakBdW/jNKUEDjtjTv8FUnkH8TES79xLkytIU3Q/DQ
         EEr7A4ZQWsOShJWcjqg1YBcskJnDjIA+ry7q/81HShry3PyWdmyY7TOX1YAgSPDagW17
         sziYJ8ZQ/5fZjxxCU5mmpXGvNKrPS/5Cn8GnNCe56CfqWQP/zSRxYBvQKrrcw/xOJKhk
         GjF/nhkuc7lWn1wcbdUnI0coeMxCOoiP7+0ENJYLkumKN15p4e0j9sgFDqj7JzqUPKXn
         c0Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OANw2HePj9Aqy4TDtb05tpT/a2lkwTwt5qwm1TtUltk=;
        b=YOF8VMI7ldzNG2OQzglAyUERMrqqUWq92Su0eixSFCxz0nVA3q5GN0HR/Qah6M7LKn
         G/qRSx/RD1qgOzTQnTpeKi1VY66INJoWDh80v605x+V3PJhb/6GhAYPVauuO8IYOtleH
         DoA8JdETcpl0WKkcNRs4jAzStTLouIulrszOYfhXdtCG6BY6Wjg0Usmexb2lSwk43ZMr
         h0JMl9WUDAh3WPhYehGQJs/1MKLysrmubG00dyt66gvj8plrFQL2fzaSHFE0DSsUEqhM
         xkJgA6+cPy0xUX9bBGcdykl8hixFaIxKeCbcbAkPecPkptGssmCmjyLjZj51cQFB6hDh
         vSNw==
X-Gm-Message-State: AOAM533wBfDXaKvZt0J4MtsECKcB2cW2gj5Dy92W7k0ef3tHt89HN06A
        z4PMJXrNJG2CTT1TIe6bV8D9YA1tjVbAxho30nUmWA==
X-Google-Smtp-Source: ABdhPJyAxkindXp2Sqxkfa1Otdo2vEKuaePNwSrArVAX4r9Ix5aY7qleOLvfVgUk4SFnDYX29zZnY6YysN+7N60B4R4=
X-Received: by 2002:a05:6512:482:: with SMTP id v2mr10277697lfq.3.1592846980702;
 Mon, 22 Jun 2020 10:29:40 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-14-guro@fb.com>
In-Reply-To: <20200608230654.828134-14-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 22 Jun 2020 10:29:29 -0700
Message-ID: <CALvZod50rUqhknV50zwvm4sLxdP=OWCLqFRKPPO_8Pff_v4EOg@mail.gmail.com>
Subject: Re: [PATCH v6 13/19] mm: memcg/slab: simplify memcg cache creation
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
> Because the number of non-root kmem_caches doesn't depend on the
> number of memory cgroups anymore and is generally not very big,
> there is no more need for a dedicated workqueue.
>
> Also, as there is no more need to pass any arguments to the
> memcg_create_kmem_cache() except the root kmem_cache, it's
> possible to just embed the work structure into the kmem_cache
> and avoid the dynamic allocation of the work structure.
>
> This will also simplify the synchronization: for each root kmem_cache
> there is only one work. So there will be no more concurrent attempts
> to create a non-root kmem_cache for a root kmem_cache: the second and
> all following attempts to queue the work will fail.
>
>
> On the kmem_cache destruction path there is no more need to call the
> expensive flush_workqueue() and wait for all pending works to be
> finished. Instead, cancel_work_sync() can be used to cancel/wait for
> only one work.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Why not pre-allocate the non-root kmem_cache at the kmem_cache
creation time? No need for work_struct, queue_work() or
cancel_work_sync() at all.
