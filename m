Return-Path: <SRS0=ro3C=3X=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 70CA5C35247
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:17:38 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 3D6AC20838
	for <linux-kernel@archiver.kernel.org>; Mon,  3 Feb 2020 22:17:38 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="SbVTeyH0"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727105AbgBCWRh (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 3 Feb 2020 17:17:37 -0500
Received: from mail-qt1-f193.google.com ([209.85.160.193]:35389 "EHLO
        mail-qt1-f193.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726331AbgBCWRh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 3 Feb 2020 17:17:37 -0500
Received: by mail-qt1-f193.google.com with SMTP id n17so11638536qtv.2
        for <linux-kernel@vger.kernel.org>; Mon, 03 Feb 2020 14:17:36 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=7nbsRe9ehLMfWGvfOHL9zb0jkuuI1wfL2Migha++yQA=;
        b=SbVTeyH0jWeUvwcbOwHxeL/U4EYlstFMrHfUxlptJVC/x08zYVy/LBkBaVMUS3FAC0
         0iaaho26of8xq9TxzDi4Ux+axihJ1GxubZuLXWGzLHXaKHzA8pqfh0f8HqfZj4tBBjui
         CcsMl2R6A8voAvUaI+EdF20SHYbYZVnFdzsr9uRkEmiJk8/kCNdUlIyiJL7UichY7ETd
         VUK8YunVFmrMv+xZNnsrwapvsHwHB2c8aUPn6ixn6XSCvB6VrfEW8eaG42aa/CK8KwGl
         xV6a38TFFd7So2mOSIus2kcAANQUYw4TmimnetfuKBcN6gF5MiKD3sAI8xpN1kVTdSg1
         P3ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=7nbsRe9ehLMfWGvfOHL9zb0jkuuI1wfL2Migha++yQA=;
        b=kpO7z0r2CVMInln1rbcoMsXZZmKf39qtFov8QBJcTVHm6UU3ywy5QqNVAGJDrhfmlc
         tXACSfcaeE87WDuIL8sLePUh3iGB76sJuMnaJmZ5VhfKA50Rra6ZUCN4sQZMcvZA6xmW
         tw0JwQ0k1ZxXoz6kaMkvtIDFYS+D3jCbBmgHR0p/LWQxjKABwT41STZECdWbiIxKI1Sw
         jVjw+ZrcQchpV+CdcxZB8RpRhGrgagBIi6qKM5GQoQ39tAxKoA4wTFAexRpZQPSKKP0Q
         m/tvtW8pigFj5zhw+fNahmbp7FTau90gT1kCe/nRDdIgTPGpGxbsRSPW9FLZZvHRuYcY
         l/mQ==
X-Gm-Message-State: APjAAAUE08tumaY8448y3GVoqRLqtVH+YXS2coBwrG5UvE6yBoR6cFF/
        ml4VdosaNws1lFt25d2yAgCPlw==
X-Google-Smtp-Source: APXvYqyivR9bISqGY7Z3QHyWVwyvcGwhlONq0j36FG/kub59wyK//WJ3+ZqWtgEFGzqLvl5Idmyr8g==
X-Received: by 2002:aed:2a05:: with SMTP id c5mr25871682qtd.361.1580768255822;
        Mon, 03 Feb 2020 14:17:35 -0800 (PST)
Received: from localhost ([2620:10d:c091:500::2:6320])
        by smtp.gmail.com with ESMTPSA id d9sm10307558qtw.32.2020.02.03.14.17.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 03 Feb 2020 14:17:35 -0800 (PST)
Date:   Mon, 3 Feb 2020 17:17:34 -0500
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Shakeel Butt <shakeelb@google.com>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        linux-kernel@vger.kernel.org, kernel-team@fb.com,
        Bharata B Rao <bharata@linux.ibm.com>,
        Yafang Shao <laoar.shao@gmail.com>
Subject: Re: [PATCH v2 21/28] mm: memcg/slab: use a single set of kmem_caches
 for all memory cgroups
Message-ID: <20200203221734.GA7345@cmpxchg.org>
References: <20200127173453.2089565-1-guro@fb.com>
 <20200127173453.2089565-22-guro@fb.com>
 <20200203195048.GA4396@cmpxchg.org>
 <20200203205834.GA6781@xps.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200203205834.GA6781@xps.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 03, 2020 at 12:58:34PM -0800, Roman Gushchin wrote:
> On Mon, Feb 03, 2020 at 02:50:48PM -0500, Johannes Weiner wrote:
> > On Mon, Jan 27, 2020 at 09:34:46AM -0800, Roman Gushchin wrote:
> > > This is fairly big but mostly red patch, which makes all non-root
> > > slab allocations use a single set of kmem_caches instead of
> > > creating a separate set for each memory cgroup.
> > > 
> > > Because the number of non-root kmem_caches is now capped by the number
> > > of root kmem_caches, there is no need to shrink or destroy them
> > > prematurely. They can be perfectly destroyed together with their
> > > root counterparts. This allows to dramatically simplify the
> > > management of non-root kmem_caches and delete a ton of code.
> > 
> > This is definitely going in the right direction. But it doesn't quite
> > explain why we still need two sets of kmem_caches?
> > 
> > In the old scheme, we had completely separate per-cgroup caches with
> > separate slab pages. If a cgrouped process wanted to allocate a slab
> > object, we'd go to the root cache and used the cgroup id to look up
> > the right cgroup cache. On slab free we'd use page->slab_cache.
> > 
> > Now we have slab pages that have a page->objcg array. Why can't all
> > allocations go through a single set of kmem caches? If an allocation
> > is coming from a cgroup and the slab page the allocator wants to use
> > doesn't have an objcg array yet, we can allocate it on the fly, no?
> 
> Well, arguably it can be done, but there are few drawbacks:
> 
> 1) On the release path you'll need to make some extra work even for
>    root allocations: calculate the offset only to find the NULL objcg pointer.
> 
> 2) There will be a memory overhead for root allocations
>    (which might or might not be compensated by the increase
>    of the slab utilization).

Those two are only true if there is a wild mix of root and cgroup
allocations inside the same slab, and that doesn't really happen in
practice. Either the machine is dedicated to one workload and cgroups
are only enabled due to e.g. a vendor kernel, or you have cgrouped
systems (like most distro systems now) that cgroup everything.

> 3) I'm working on percpu memory accounting that resembles the same scheme,
>    except that obj_cgroups vector is created for the whole percpu block.
>    There will be root- and memcg-blocks, and it will be expensive to merge them.
>    I kinda like using the same scheme here and there.

It's hard to conclude anything based on this information alone. If
it's truly expensive to merge them, then it warrants the additional
complexity. But I don't understand the desire to share a design for
two systems with sufficiently different constraints.

> Upsides?
> 
> 1) slab utilization might increase a little bit (but I doubt it will have
>    a huge effect, because both merging sets should be relatively big and well
>    utilized)

Right.

> 2) eliminate memcg kmem_cache dynamic creation/destruction. it's nice,
>    but there isn't so much code left anyway.

There is a lot of complexity associated with the cache cloning that
isn't the lines of code, but the lifetime and synchronization rules.

And these two things are the primary aspects that make my head hurt
trying to review this patch series.

> So IMO it's an interesting direction to explore, but not something
> that necessarily has to be done in the context of this patchset.

I disagree. Instead of replacing the old coherent model and its
complexities with a new coherent one, you are mixing the two. And I
can barely understand the end result.

Dynamically cloning entire slab caches for the sole purpose of telling
whether the pages have an obj_cgroup array or not is *completely
insane*. If the controller had followed the obj_cgroup design from the
start, nobody would have ever thought about doing it like this.

From a maintainability POV, we cannot afford merging it in this form.
