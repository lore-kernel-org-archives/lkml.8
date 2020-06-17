Return-Path: <SRS0=qsSF=76=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.3 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 3EFE4C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:08:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 1E7CC2082E
	for <linux-kernel@archiver.kernel.org>; Wed, 17 Jun 2020 03:08:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="DeQCrD3h"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726720AbgFQDIt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 16 Jun 2020 23:08:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38800 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726275AbgFQDIs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Jun 2020 23:08:48 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 17869C061573
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 20:08:48 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id n23so1008426ljh.7
        for <linux-kernel@vger.kernel.org>; Tue, 16 Jun 2020 20:08:48 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+W5Siy2OxVYEhYRlfd+DiDo/+fekl/jChMoSNX4V14g=;
        b=DeQCrD3hTD9Z/DYXD3P61a6T4HMorNim4f/GPxjeuDZvkujXdlI+CbGIyAbOMrHKyZ
         MmOU0Co61YTL8W26JmYrxts7J7u7pz3YKnyPSakJIlpAPpYWdhHalEe9vi2CgQNPzovt
         1c33xl5HNn+KAGHB5HpxzAMNODPcBO70dca9ejE1MWWIw2mmL9PYZiWRS+DBint1y2aT
         fIuNfABnKRJQFEU0xVfWUSbyQKqLp+jmhGhDQcd6iSuHOAI5snUIS35KF+DUhciuMFhe
         7MqCgpfo+hpbn8sFkegWAotTrhUq6avHJp0f3H+JRFtzwSWrmV8rA0IorEMLmZQfl5nW
         Vsrg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+W5Siy2OxVYEhYRlfd+DiDo/+fekl/jChMoSNX4V14g=;
        b=T98qC9t9noWPqcX+uNeFYqx6ollIvw5l/CEqIXkRz/NKLUBCmUklLb6zgJEEcwr1XS
         XkPHcHI3K/IC30WyP4m1d5qd/a5Tz79a8U+HVjRmMOjrsYp4/i2NSkhPI1ZpOoLJPXOo
         2N0yjBYNNGL2aXy0S4Anq7OQP7AtqFxlr1mthMCJ+/0V9jtJnxdsAfL/fu9rV1trBbYk
         4yqbsHNHa2DK0BGWyiJAyYfx/Lr6H0rPSL46ZA55Gr78TlqErn99lSl9uSOwOUQ8f1Gh
         JQMyk0kaWbSQ3kwgugbRZs7e9vinKRWqX17iLmbroLQZMKO79rQa09L1ebUau2TN6mYg
         p2IA==
X-Gm-Message-State: AOAM530Dv+Pne3VO4Nx1UF9ons2U+x23wqCcN7lzcn1a5KNNNLyog/eq
        Es08yLe1rH8MXQqMrynFVvk9SmhzsaRjz9PFVAFmVA==
X-Google-Smtp-Source: ABdhPJw0MwYJjp160hEnPcW7WhsxusFiYyA9C+OseGgpU5rh5bXc8ZOnUplScqZyCx/mxcAsPg40clzB4r0Jrlwro7c=
X-Received: by 2002:a2e:8754:: with SMTP id q20mr2966383ljj.270.1592363326327;
 Tue, 16 Jun 2020 20:08:46 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-5-guro@fb.com>
In-Reply-To: <20200608230654.828134-5-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 16 Jun 2020 20:08:35 -0700
Message-ID: <CALvZod722TC8JqcMHjYqGE+PgW40d7nGRbAAtOtSvQk0t+ntfQ@mail.gmail.com>
Subject: Re: [PATCH v6 04/19] mm: slub: implement SLUB version of obj_to_index()
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
> This commit implements SLUB version of the obj_to_index() function,
> which will be required to calculate the offset of obj_cgroup in the
> obj_cgroups vector to store/obtain the objcg ownership data.
>
> To make it faster, let's repeat the SLAB's trick introduced by
> commit 6a2d7a955d8d ("[PATCH] SLAB: use a multiply instead of a
> divide in obj_to_index()") and avoid an expensive division.
>
> Vlastimil Babka noticed, that SLUB does have already a similar
> function called slab_index(), which is defined only if SLUB_DEBUG
> is enabled. The function does a similar math, but with a division,
> and it also takes a page address instead of a page pointer.
>
> Let's remove slab_index() and replace it with the new helper
> __obj_to_index(), which takes a page address. obj_to_index()
> will be a simple wrapper taking a page pointer and passing
> page_address(page) into __obj_to_index().
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Acked-by: Johannes Weiner <hannes@cmpxchg.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
