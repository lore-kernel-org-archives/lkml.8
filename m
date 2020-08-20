Return-Path: <SRS0=YvwE=B6=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-14.4 required=3.0 tests=BAYES_00,DKIMWL_WL_MED,
	DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 66BD1C433E1
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:17:17 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 321F52076E
	for <linux-kernel@archiver.kernel.org>; Thu, 20 Aug 2020 21:17:17 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ZuKqiQ3x"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728708AbgHTVRP (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 20 Aug 2020 17:17:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53432 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726781AbgHTVRO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Aug 2020 17:17:14 -0400
Received: from mail-lf1-x143.google.com (mail-lf1-x143.google.com [IPv6:2a00:1450:4864:20::143])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6522C061385
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 14:17:13 -0700 (PDT)
Received: by mail-lf1-x143.google.com with SMTP id b11so1659047lfe.10
        for <linux-kernel@vger.kernel.org>; Thu, 20 Aug 2020 14:17:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=dhaGrKUZGrplU3FJ6j8umgFZML1T4Qnjaml2sZz9odo=;
        b=ZuKqiQ3xaX3Lfh2PTU894rP8VOkqmdcx27cCOxnOBt7xEFAEjJ3CC+ln9bLTpy1WsS
         yTEtdUEhIi4Pea02zFDTl3ALkkvTjqUWMzXNZ27pIiYWx6639XGiDITdyKKBsKFk6WzV
         4T+Vrvw7laL+WCnbgP38MWDiqXy3tS1pSiGWzbDlvNJU0rOgM6+rqQf2Zsi8qxF+nezl
         yl0Qn5djgLqI+x4v39W8REzYFed8KfpkMY3tBiFZ3HIPBGmxHylg70foADv47+UiJqzG
         UK5kl+J9T4QE48lfZ5x5QZOXuJoapDUsHiQaoneEpuMBzXrlRbgMZKaIQN7LPkErMG7P
         TQaw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=dhaGrKUZGrplU3FJ6j8umgFZML1T4Qnjaml2sZz9odo=;
        b=UctBl0qxLqbZoa1jiIs1E0A76asbWOltoWtT6Kti1G16/FJS9vWtQNiXDTD2lx22qW
         WghFyDvzUZcE4dY0QywEfpEDda3YhnRe6fqOkLof6QWe6/o6SCb6M1XTCwfkZjpLYR3K
         9nLRsptS5RB8tFRFogijp49qhN8znKUtjsbYpsJBB5Gnc+paUtszeQrJ99WfqFZ+TOPc
         fEXfecBP0OamJxbMwjyJlLvI+qpcldc65dkzWN/cavKSgKl/OB6K/kUioLiWD5uMdPE7
         MHYhqTts4EgvZ9O4dQ6xNQYAiD6jcBQTNv4ZV96652taZ7GoTTXfLA6TENqYqoAfoGHd
         svrQ==
X-Gm-Message-State: AOAM5338Dysw0+UKJmszwBm55UYSDamJizRU5TJEjplYkUnhOtg0RtPn
        ozjAGn+LU9D8Ok8URGij1WvvGkMkDlB/poa7Dj0XrWhU82W48A==
X-Google-Smtp-Source: ABdhPJwFSgY1ZKwA4Xx16Cyag1R0mdXgDS8nZReXQnK4r2SqECPyVb9ZyAtyMuV+OsgI6PJwK+ZDUSEuRMX23LABV4M=
X-Received: by 2002:a19:c68b:: with SMTP id w133mr126684lff.189.1597958230344;
 Thu, 20 Aug 2020 14:17:10 -0700 (PDT)
MIME-Version: 1.0
References: <20200820130350.3211-1-longman@redhat.com> <20200820130350.3211-2-longman@redhat.com>
In-Reply-To: <20200820130350.3211-2-longman@redhat.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 20 Aug 2020 14:16:59 -0700
Message-ID: <CALvZod7=aENT98Lrm6UvDnUrtG8ZT5FosUNb=+EmCkZag3=8GA@mail.gmail.com>
Subject: Re: [PATCH 1/3] mm/memcg: Clean up obsolete enum charge_type
To:     Waiman Long <longman@redhat.com>
Cc:     Johannes Weiner <hannes@cmpxchg.org>,
        Michal Hocko <mhocko@kernel.org>,
        Vladimir Davydov <vdavydov.dev@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Tejun Heo <tj@kernel.org>, LKML <linux-kernel@vger.kernel.org>,
        Cgroups <cgroups@vger.kernel.org>, Linux MM <linux-mm@kvack.org>,
        Chris Down <chris@chrisdown.name>,
        Roman Gushchin <guro@fb.com>,
        Yafang Shao <laoar.shao@gmail.com>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Aug 20, 2020 at 6:04 AM Waiman Long <longman@redhat.com> wrote:
>
> Since commit 0a31bc97c80c ("mm: memcontrol: rewrite uncharge API") and
> commit 00501b531c47 ("mm: memcontrol: rewrite charge API") in v3.17, the
> enum charge_type was no longer used anywhere. However, the enum itself
> was not removed at that time. Remove the obsolete enum charge_type now.
>
> Signed-off-by: Waiman Long <longman@redhat.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
