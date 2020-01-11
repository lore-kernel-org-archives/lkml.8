Return-Path: <SRS0=GvTR=3A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id E5E26C33CA4
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 00:24:06 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id B9FBD20721
	for <linux-kernel@archiver.kernel.org>; Sat, 11 Jan 2020 00:24:06 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="SmX5zYon"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727779AbgAKAYF (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 10 Jan 2020 19:24:05 -0500
Received: from mail-ot1-f65.google.com ([209.85.210.65]:44854 "EHLO
        mail-ot1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727560AbgAKAYF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jan 2020 19:24:05 -0500
Received: by mail-ot1-f65.google.com with SMTP id h9so3678781otj.11
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jan 2020 16:24:04 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=G+JPdmbTt0+yq7xgA9xx/1MNE9mXhCi0WakjpzpM0nc=;
        b=SmX5zYon81AqjnJHQ1JB7Z6jxf/3WEnK/r/U/nn1ND9UafXh5g0ELEG7BdenRw2RY3
         Pjd1GOb7XIg6KX8hTpQTR/go8DHP2oNuTpTp0IbxUiZgxUi6B/lPi0ThzHyYCggkO792
         wNr1u+U5ynqq4lvRN+tbjH267PhKt1cpSTkBxrVkoAhNUORfZK+2kotsa9ahK9UXx+Yo
         XmWZfaFoZCpJHWkFGhjwLandR+StNjAYlUF449qiEt/hAdLs55rNyd0Phr18YhLEj+ar
         WCEOPcC+s0MHKE95JAxH6t3UMch0u3nv+vGU2cpuNM308mK6t94yQl4jAEi1ocqmeMhb
         Thqg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=G+JPdmbTt0+yq7xgA9xx/1MNE9mXhCi0WakjpzpM0nc=;
        b=WHMPIzjGwyP4gPyBQMZx9QWqAT/CCDR8xc1HB7trL7iaR3tnQyzP8rzFUjh8dGqrjs
         F5/KmY971sEG2Sv2ZbOA+7SctRCOf41Z6v1c6/72NK46KyL2tU3U8+TKdR3YASHvdkqN
         NNF+mhoBSVwDU17mTsEEN0iWUIhNPcjt9SpMdS9XW9e4XgvUTOpfWo2512YQAO+UAhK7
         whBf1Pi5rzILJ4M0XuvQqVK5+bhOjpM+/3+cDThM7AeXXT5z0j3hv+hMXhnRW4qVeFPA
         M06+vF0iSfMCPnclCrf7TAzOoQce0t2uZ1QdXjmX660I9xK/uyyxww3lqnd9W+Pl8Nr9
         UKnQ==
X-Gm-Message-State: APjAAAXLkCFq01wdt91NXvxCOeB2+fXleKPUX8StbkqjZTnLGYTYZW+y
        Gvimm4pvCV++rAOg2/EllDq2Q73RqaAnFY7aHvIRZjPTIiA=
X-Google-Smtp-Source: APXvYqw6Iqeg5rAtrOp7nb+NJ5t/jmryneW6ZegFOQPCpITX53S1be5+B5cO0snmqu9Lml6auQPWlV8+8HVX5eeOulg=
X-Received: by 2002:a9d:7c90:: with SMTP id q16mr5014707otn.191.1578702243840;
 Fri, 10 Jan 2020 16:24:03 -0800 (PST)
MIME-Version: 1.0
References: <20200109202659.752357-1-guro@fb.com> <20200109202659.752357-3-guro@fb.com>
In-Reply-To: <20200109202659.752357-3-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Fri, 10 Jan 2020 16:23:52 -0800
Message-ID: <CALvZod59FA78-cgg1_T+qg6S-YW=VGu1Lj=j+uzWS9LzjAu1Xw@mail.gmail.com>
Subject: Re: [PATCH v2 2/6] mm: kmem: cleanup memcg_kmem_uncharge_memcg() arguments
To:     Roman Gushchin <guro@fb.com>
Cc:     Linux MM <linux-mm@kvack.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@kernel.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 9, 2020 at 12:27 PM Roman Gushchin <guro@fb.com> wrote:
>
> Drop the unused page argument and put the memcg pointer at the first
> place. This make the function consistent with its peers:
> __memcg_kmem_uncharge_memcg(), memcg_kmem_charge_memcg(), etc.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Why not squash this patch in the previous one?

Reviewed-by: Shakeel Butt <shakeelb@google.com>
