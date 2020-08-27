Return-Path: <SRS0=OCv1=CF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,
	USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6DFEC433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 21:10:41 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A348F20848
	for <linux-kernel@archiver.kernel.org>; Thu, 27 Aug 2020 21:10:41 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="KzpCwIOJ"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726887AbgH0VKk (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 27 Aug 2020 17:10:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726120AbgH0VKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Aug 2020 17:10:40 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902AAC061264
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 14:10:39 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id w25so8005314ljo.12
        for <linux-kernel@vger.kernel.org>; Thu, 27 Aug 2020 14:10:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=IOB+ukv6Oi1rVoS9Jtq8hZfPPBX7UWWuimpCi5zIu4o=;
        b=KzpCwIOJ6XKv5A25ZlO6WjaxJ/4Q9tXt6334e1pXNuFjWzSEWv3subAtw6xJVC06Dc
         q8Kri7wQmYszddw4J1hy+EdCfgMWyRnr4Xe6Fb5M0Zvo+XZFvlqeVlueWeDLog1PlmgO
         wpHFX8ZibP3flcnv6/kK+9bI70I4k7kmpWns/DxDmVFrbWzh2/Z6uoq1Yz1VBp3gOk0/
         pjvzsebyGc5mrRU7wqZL11g+03X6cSIryrr6W7+5B92EhkT2TdYK6FF0v9EqyIvJKBjB
         9ypjEpp6Zpit2H6Q2nrc72Rkc/cUi5LwfiEyfbk73A4Z4+yqNTty6kHAAjBGHHZSlfRm
         FHuw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=IOB+ukv6Oi1rVoS9Jtq8hZfPPBX7UWWuimpCi5zIu4o=;
        b=e6DdqMKsAleiEZYfmrffwCdOZqxFGMK27Uicvl71V3IIBLmRUEb5i7MreLW3EmqcEa
         MstZ8fn+uI75pmTjAWJ1dL9WeM/wKnZLdF4BQmL/lhUVrfSj3e7mBtS6QYqHl985bry4
         1X1rGDBmX21kHsWa7w3j3TIM5JmueZDXZA+A2ar+WRW8q8lWRmnKVaQSGRAuzYF2TNA4
         rU/lrp/YZnTgpypU1d8QliwLbbyHWXX+jDQ40QggzKCPh9/ZOA2R0jvkB+OkIxmfyF1K
         n9p9DiNUaeHF67zKuBFdFVZVIHryyGqoiBCr2pC3MVCvakeprdc6NhO9+IH5Vqow1R5f
         urlw==
X-Gm-Message-State: AOAM533ZpCX9aaA5BTVu7hMpTBZs2imthOqnZAQCKiMX/GNXr8kLmSY/
        VTLvOymuTW5tHpAFCMPJN98ROokwbFnIzFvtQAw1Rw==
X-Google-Smtp-Source: ABdhPJyYYRMOID6xGYuzKse/5r8uqHanIEVrURITjHf94MPFmVFZ2us1By7rqfQ+rRKCOi1Ikg1dO8/hQ5O/ytuVXm4=
X-Received: by 2002:a2e:9396:: with SMTP id g22mr11519846ljh.446.1598562637711;
 Thu, 27 Aug 2020 14:10:37 -0700 (PDT)
MIME-Version: 1.0
References: <20200827175215.319780-1-guro@fb.com> <20200827175215.319780-3-guro@fb.com>
In-Reply-To: <20200827175215.319780-3-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 27 Aug 2020 14:10:26 -0700
Message-ID: <CALvZod6yAjobDQgrrDXxJ9X6RuQBWy=rEsic1b-f=N9i9kPWUQ@mail.gmail.com>
Subject: Re: [PATCH RFC 2/4] mm: kmem: remove redundant checks from get_obj_cgroup_from_current()
To:     Roman Gushchin <guro@fb.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 27, 2020 at 10:52 AM Roman Gushchin <guro@fb.com> wrote:
>
> There are checks for current->mm and current->active_memcg
> in get_obj_cgroup_from_current(), but these checks are redundant:
> memcg_kmem_bypass() called just above performs same checks.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
