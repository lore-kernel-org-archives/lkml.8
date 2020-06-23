Return-Path: <SRS0=AM+j=AE=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 4F211C433DF
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 05:19:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 2881020738
	for <linux-kernel@archiver.kernel.org>; Tue, 23 Jun 2020 05:19:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="jCOr62ye"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1730754AbgFWFTl (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 01:19:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728729AbgFWFTj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 01:19:39 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CB328C061573
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 22:19:38 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id i27so21880474ljb.12
        for <linux-kernel@vger.kernel.org>; Mon, 22 Jun 2020 22:19:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=m95VDq7vD4nelWbzJkHtAeoIzyCCp23MjAnbmWTbSGI=;
        b=jCOr62yeRNUdZ0UVcLguc83CENqg9FEukBdY4YKk7gENM0KS/aQL2ekCpjUfPukcvU
         2ZhXXypuEta5EKExrLrI5UPED8tKfhpCfY9Px1ciIETwh1wwlDN3Fs20svNTJEafG1NX
         L/IFKJ5si8iCl0lWMqWORyQqKM+fG2lz4ZxLrhfDhT3u9t4siE2c/oPP5tUWEohgZW5X
         3TAtzzpivXsuKhIe4+Cp8p/maHMYnYYmjeRHi1NO0GwN7csyHWEJ/+waHgqcpIOusTIQ
         ykP9zoJcveK5EIiNIgfCqKlRhKAO31K8xJ20LK/O53HnmWn7yXS4SNvGVYRArqyjwSj8
         S4DQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=m95VDq7vD4nelWbzJkHtAeoIzyCCp23MjAnbmWTbSGI=;
        b=OYCZUF598SWkYh4jmiwQGZPhI8YrGFsJO09guM+1KVktxHkc/J88wjhiodxddTwLiy
         fs/JxKwPYltyop27eBSDPbPXOcw/XNCeJJ1iBxFN205gt77DIy+pQN2RA/1boydehQxb
         BPGJ2t87bNx6nWw8AAtHfj48l6JgdijskMy0t7ruJBHl51pkTk9Bk9t+EXzUAOSt85Jb
         AWrHajvmYe42btsV9eaJqcjh8wbdI5uN6FqAjQiIYDUtudJGhrjh0WejSP6kZ94epSuo
         3yeH4wrdyINbg/xgaq7w7oc46zCt9P0ecvwEXzGeBUgAUg/6ZGvscDHQT2fmkz47vXFN
         V57g==
X-Gm-Message-State: AOAM532TUXFALbWz0jq2fWeXJUlRcfQtJ+AM+XWyeWsIvrjLnFYzAxhI
        468o66/TLpUCp6m826x/UcJf8KcgnnRe6tJebiCWvQ==
X-Google-Smtp-Source: ABdhPJzsReRxsBHVAFItMED09vw0+nP/ywSpWw3LzwYR129pYpbFLacCRwCH5/8rkhVYcZiWOll0wQ3YHigfKeW5UHk=
X-Received: by 2002:a2e:8754:: with SMTP id q20mr10480767ljj.270.1592889576802;
 Mon, 22 Jun 2020 22:19:36 -0700 (PDT)
MIME-Version: 1.0
References: <20200623015846.1141975-1-guro@fb.com> <20200623015846.1141975-10-guro@fb.com>
In-Reply-To: <20200623015846.1141975-10-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Mon, 22 Jun 2020 22:19:25 -0700
Message-ID: <CALvZod4jchG_4gvigzb=iAoi1ytX6HVJe0xCp8b8=cc4NiXENg@mail.gmail.com>
Subject: Re: [PATCH v7 09/19] mm: memcg/slab: charge individual slab objects
 instead of pages
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

On Mon, Jun 22, 2020 at 6:58 PM Roman Gushchin <guro@fb.com> wrote:
>
> Switch to per-object accounting of non-root slab objects.
>
> Charging is performed using obj_cgroup API in the pre_alloc hook.
> Obj_cgroup is charged with the size of the object and the size of
> metadata: as now it's the size of an obj_cgroup pointer.  If the amount of
> memory has been charged successfully, the actual allocation code is
> executed.  Otherwise, -ENOMEM is returned.
>
> In the post_alloc hook if the actual allocation succeeded, corresponding
> vmstats are bumped and the obj_cgroup pointer is saved.  Otherwise, the
> charge is canceled.
>
> On the free path obj_cgroup pointer is obtained and used to uncharge the
> size of the releasing object.
>
> Memcg and lruvec counters are now representing only memory used by active
> slab objects and do not include the free space.  The free space is shared
> and doesn't belong to any specific cgroup.
>
> Global per-node slab vmstats are still modified from
> (un)charge_slab_page() functions.  The idea is to keep all slab pages
> accounted as slab pages on system level.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> ---
[snip]
> +static inline struct kmem_cache *memcg_slab_pre_alloc_hook(struct kmem_cache *s,
> +                                               struct obj_cgroup **objcgp,
> +                                               size_t objects, gfp_t flags)
> +{
> +       struct kmem_cache *cachep;
> +
> +       cachep = memcg_kmem_get_cache(s, objcgp);
> +       if (is_root_cache(cachep))
> +               return s;
> +
> +       if (obj_cgroup_charge(*objcgp, flags, objects * obj_full_size(s))) {
> +               memcg_kmem_put_cache(cachep);

I think you forgot to put obj_cgroup_put(*objcgp) here again.

> +               cachep = NULL;
> +       }
> +
> +       return cachep;
> +}
> +

After the above fix:

Reviewed-by: Shakeel Butt <shakeelb@google.com>
