Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id C6594C433E1
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:40:57 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1B0F20B80
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 01:40:57 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="JI0RRpdx"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2388416AbgFXBk4 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Tue, 23 Jun 2020 21:40:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45350 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387780AbgFXBkz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Jun 2020 21:40:55 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5111AC061573
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 18:40:54 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id t9so404935lfl.5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Jun 2020 18:40:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7AXmVyb4ZR5anHjnEEP5lE07L2REc/wDlQONbF/NhLI=;
        b=JI0RRpdxirb+Gh2KoBXbz8SOkuA9b9Qo7D6Hqe8TJpvOVPbbFBzd7kgVtjuEAIaYQZ
         RmwROV6VluY7B6Hu+Ec5RslA2mQ3IlrQq3NoThLJur5WKMqcFrNudIjvhV/TeC2YR0Pw
         ReZbsLgQTLwj0aZobzD70P7hguTY+gnR4IQ1wN1GtQBF0ycbTG1PuJzxPYjd9bxXO7k3
         j6WieG4FTp2gmxZbOBMVNwBAjU4Mi1swYtN0eYouBPDUjyyswVYhqMa+39NLbPaaYhD0
         /Sd2D2cUJLkDlgk2871dKEnFbF6HsGmfJDVtAAWgC94PZyHXbJzB0H5chn+K+d7zPc4v
         P5Vw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7AXmVyb4ZR5anHjnEEP5lE07L2REc/wDlQONbF/NhLI=;
        b=tmvlAsPIBtfeZpLL8NqT8h2CayBva+3zQWDi65Imv8b/RviuIfo96S95Vp76PQ65RS
         QRIW4Pqc2ci3vg+bsM3NUy4iYpLhYn/YBVDz33oOqoAQTnoT3S/WadIEGnIlI6gdNeYG
         m2o1fvnfLlxNE6MqhQ7XDV3qkwBKswWiv5gw5LmiIGeMiHK9CjUng469DKGGeuISxG52
         i8bk0X0paFoAnXxmmVbi5qgqFyjjL49W3J75U/HCSPb49yf0rjzlEsbULZvw3sRKQ46+
         ODATyQM5beIO8hf8KZ+TariYi5zrj3v8THqgVUTrPl2ZSyyp7R4gTdPlUi+vFrCxU/uV
         QONg==
X-Gm-Message-State: AOAM532LUOi4bXKqoLE6YireATJKFUfMF1UVMgPVOWmhUFQaH5SekXXh
        GNGGtyrcZclo5WiIySLCOV/2ZMgp+4A2TrjYEeoesQ==
X-Google-Smtp-Source: ABdhPJxWV0QhUDCH+O/O+AiqN2PIezT/rgZ9bpzxIAFJ636PeSwft1lwnUGptprATVEp+aywmYkTADbjHiRqqXggxCI=
X-Received: by 2002:a19:8806:: with SMTP id k6mr13942713lfd.189.1592962852427;
 Tue, 23 Jun 2020 18:40:52 -0700 (PDT)
MIME-Version: 1.0
References: <20200623184515.4132564-1-guro@fb.com> <20200623184515.4132564-5-guro@fb.com>
In-Reply-To: <20200623184515.4132564-5-guro@fb.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Tue, 23 Jun 2020 18:40:41 -0700
Message-ID: <CALvZod5m+iK-UsTmrTuhpGyDg=nT3+f=DZUho02AsLGbP4AGsA@mail.gmail.com>
Subject: Re: [PATCH v3 4/5] mm: memcg: charge memcg percpu memory to the
 parent cgroup
To:     Roman Gushchin <guro@fb.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Dennis Zhou <dennis@kernel.org>, Tejun Heo <tj@kernel.org>,
        Christoph Lameter <cl@linux.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 23, 2020 at 11:47 AM Roman Gushchin <guro@fb.com> wrote:
>
> Memory cgroups are using large chunks of percpu memory to store vmstat
> data.  Yet this memory is not accounted at all, so in the case when there
> are many (dying) cgroups, it's not exactly clear where all the memory is.
>
> Because the size of memory cgroup internal structures can dramatically
> exceed the size of object or page which is pinning it in the memory, it's
> not a good idea to simple ignore it.  It actually breaks the isolation

*simply

> between cgroups.
>
> Let's account the consumed percpu memory to the parent cgroup.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>
> Acked-by: Dennis Zhou <dennis@kernel.org>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
