Return-Path: <SRS0=Xj+s=AD=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0EAD9C433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:36:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DEFA220767
	for <linux-kernel@archiver.kernel.org>; Mon, 22 Jun 2020 17:36:36 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="h+1YTyO0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730103AbgFVRgf (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 22 Jun 2020 13:36:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1729886AbgFVRgf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Jun 2020 13:36:35 -0400
Received: from mail-lj1-x244.google.com (mail-lj1-x244.google.com [IPv6:2a00:1450:4864:20::244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B5142C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 10:36:34 -0700 (PDT)
Received: by mail-lj1-x244.google.com with SMTP id 9so20279545ljv.5
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 10:36:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=+uMOcYRhR3VQERG3cveMu1d/XmkJLee7HKQWW5pciSU=;
        b=h+1YTyO0jwHDlXsWEXi7dChxTynVwk13+1BfbQGc8Gu/VEhzSeG4hxWV2R//d6poCh
         lnc/eX4VCK+n3HQpWw8jv+0V9kzm753mr4iHTkihl2yFsk4zQ3SP7akUXo9czn6UxM2u
         GV/ztdnXvpXxXDORP2nD+7/tMj/Av0wGLdmL8JZr6hGK7c4c104vBcbqhPZfsL2jzOku
         Vn+Z+RVHFJYRjLAbdGnD5+VWMZVcDmfjtBOkGt/HmlfxauUZesS4mB/jR36yiqH6Cp4y
         R0CEuskHVx7PrlCBhtlTYyNarxRge9zbRBRroGixw6xWuzz1zMOoEqIq3l9nFHgzaYMZ
         V1pQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=+uMOcYRhR3VQERG3cveMu1d/XmkJLee7HKQWW5pciSU=;
        b=dHopws73HbXYcrk8A2I6Rzr8h2aHB8Mva749hTLA2o7mOFHIkgsdXjw9T5M8e7S0XQ
         P0Zq6cb5027rwR7sHdWR3IV7tAMAF3pZorReVthmfgcxsqXHJx8ehrU0SDB4PQ3CTsTJ
         abPzAbGI/46YBwXMOyUiNv2CENcrHiFper+s1ZXJer0o0TJUJB27JBg3eLaA+oi2C7aA
         sU18pwYgUVxqnp4/ozVFgwZ8Ylw1pdGIqmcnFwca+n/HdEBHCqXqfPZocLSwzKo+yRFG
         A/I6EsXQFt1QFDA+KXArG1ysHPX2oaFjlk4xyH0oR5msDQTKnzie+13OuygDViTf+N/W
         bBQg==
X-Gm-Message-State: AOAM5300Smm+h/zdYB6ViiWXtaynA9VN3mOa4sTn+xeFvnt3WjLDuPBA
        YKFySLvFak5LgbYzS9Lh9n1uUsNjuuQI8LFE/yQYBA==
X-Google-Smtp-Source: ABdhPJz0GXP4YiIJPJAEmUOBfeBrF2UiDL/A+GdRn3H3Q6ZDFWO17mrlWSqZkyZUKyAhH+b51fbW3e9Gp4fwsYLNXHA=
X-Received: by 2002:a2e:8754:: with SMTP id q20mr9339481ljj.270.1592847392932;
 Mon, 22 Jun 2020 10:36:32 -0700 (PDT)
MIME-Version: 1.0
References: <20200608230654.828134-1-guro@fb.com> <20200608230654.828134-16-guro@fb.com>
In-Reply-To: <20200608230654.828134-16-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 22 Jun 2020 10:36:21 -0700
Message-ID: <CALvZod6drr_eQS7iv9toFJcz9xSL5qxdfBw09D4NxUwq2aG55A@mail.gmail.com>
Subject: Re: [PATCH v6 15/19] mm: memcg/slab: deprecate slab_root_caches
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
> Currently there are two lists of kmem_caches:
> 1) slab_caches, which contains all kmem_caches,
> 2) slab_root_caches, which contains only root kmem_caches.
>
> And there is some preprocessor magic to have a single list
> if CONFIG_MEMCG_KMEM isn't enabled.
>
> It was required earlier because the number of non-root kmem_caches
> was proportional to the number of memory cgroups and could reach
> really big values. Now, when it cannot exceed the number of root
> kmem_caches, there is really no reason to maintain two lists.
>
> We never iterate over the slab_root_caches list on any hot paths,
> so it's perfectly fine to iterate over slab_caches and filter out
> non-root kmem_caches.
>
> It allows to remove a lot of config-dependent code and two pointers
> from the kmem_cache structure.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
