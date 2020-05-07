Return-Path: <SRS0=0sZ+=6V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0A30AC38A24
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:00:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id DC43D2173E
	for <linux-kernel@archiver.kernel.org>; Thu,  7 May 2020 17:00:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="ibg8qmwW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726811AbgEGRAV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 7 May 2020 13:00:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44616 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726222AbgEGRAU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 May 2020 13:00:20 -0400
Received: from mail-lj1-x243.google.com (mail-lj1-x243.google.com [IPv6:2a00:1450:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5BBBEC05BD43
        for <linux-kernel@vger.kernel.org>; Thu,  7 May 2020 10:00:20 -0700 (PDT)
Received: by mail-lj1-x243.google.com with SMTP id j3so7096680ljg.8
        for <linux-kernel@vger.kernel.org>; Thu, 07 May 2020 10:00:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=9a51Q0KJvE3zrPblIKzTSl+tjTR3Bde3DH99HzeKLKI=;
        b=ibg8qmwWjVbS3FUiaxBOHr54QL17/uXAfjcKOSAWUMg75VnfQ93AsgVqCEi9PMtWa9
         HLbY16J7t69k2RWxnYhd/nFAHBX8h3Z1/xTqVnT0oYVo74D17A5Y3MTeNlGz7fBMpBG+
         gIkD5dglHn0fGdlGpiGoATeuiRXrUnkhRv3NyDPc1iSW2Qf4f/L7pnSVxV7/3Jf6IesD
         QsrAE1xP8S7h0EEY6/UjSupjkRjY7AKKm3ZQRAphuMi58y8g3fwNHfqtC76KvN2c5JHo
         J8kqfHofQwpOmg+u3p8lOMam4gk5lYN/2zzv/jGpP+lwgauKVKvj70nyhy4XNmrlLN6i
         QWAQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=9a51Q0KJvE3zrPblIKzTSl+tjTR3Bde3DH99HzeKLKI=;
        b=JrDEUiyfx2skROMXVHN8CJqlsol74hnzGIFoByOQ7Aj4YUGtXGghXhDN4Gp070Avs3
         wgNoRgHNsj1vVd3LAA0ORCNs+Njo7zp4IqbMAJUU/34lSHSZqdTHTP3wcteC7ulqjkih
         /tDLh8CzCwkOqNA0/rbfU1YHkeD8VlIkENJbBL+tFdH2rEEc4qhRvp3UI33w3iZTHys6
         m14jHLIy2//w4bsG1L908Wmm+S6sGMjx+Me+aszdm2agluHnU+Te4iz4qmLHYbgZgYW+
         F7ZLmy6N6snGGTk6q2KP8APGCAg2ySMNIWGiLlnMJRg3akdwft3t5nQkhGiNZo2+QO99
         qFrQ==
X-Gm-Message-State: AGi0PuYxXjx39wsMaCfRQgQkiKI7MMGXmVE1FlKiSZLvWqnZ7vBZMJJi
        aNWIN79b2mJB/Wc8JjwCGsNYVNueYfKy4YNnQlo1Pw==
X-Google-Smtp-Source: APiQypIyhbO51v7FfjXwxImM/+MjAA3HzPk6zunC+xStgsr9vkliLLFc7Iea0dnB3vM4lCl1ShWZ4lFbSgpYKbYdzdE=
X-Received: by 2002:a2e:9713:: with SMTP id r19mr9127689lji.89.1588870818402;
 Thu, 07 May 2020 10:00:18 -0700 (PDT)
MIME-Version: 1.0
References: <20200507163301.229070-1-shakeelb@google.com> <20200507164653.GM6345@dhcp22.suse.cz>
In-Reply-To: <20200507164653.GM6345@dhcp22.suse.cz>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 7 May 2020 10:00:07 -0700
Message-ID: <CALvZod5TmAnDoueej1nu5_VV9rQa6VYVRXqCYuh63P5HN-o9Sw@mail.gmail.com>
Subject: Re: [PATCH] memcg: effective memory.high reclaim for remote charging
To:     Michal Hocko <mhocko@kernel.org>
Cc:     Johannes Weiner <hannes@cmpxchg.org>, Roman Gushchin <guro@fb.com>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, May 7, 2020 at 9:47 AM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 07-05-20 09:33:01, Shakeel Butt wrote:
> [...]
> > @@ -2600,8 +2596,23 @@ static int try_charge(struct mem_cgroup *memcg, gfp_t gfp_mask,
> >                               schedule_work(&memcg->high_work);
> >                               break;
> >                       }
> > -                     current->memcg_nr_pages_over_high += batch;
> > -                     set_notify_resume(current);
> > +
> > +                     if (gfpflags_allow_blocking(gfp_mask))
> > +                             reclaim_over_high(memcg, gfp_mask, batch);
> > +
> > +                     if (page_counter_read(&memcg->memory) <=
> > +                         READ_ONCE(memcg->high))
> > +                             break;
>
> I am half way to a long weekend so bear with me. Shouldn't this be continue? The
> parent memcg might be still in excess even the child got reclaimed,
> right?
>

The reclaim_high() actually already does this walk up to the root and
reclaim from ones who are still over their high limit. Though having
'continue' here is correct too.

> > +                     /*
> > +                      * The above reclaim might not be able to do much. Punt
> > +                      * the high reclaim to return to userland if the current
> > +                      * task shares the hierarchy.
> > +                      */
> > +                     if (current->mm && mm_match_cgroup(current->mm, memcg)) {
> > +                             current->memcg_nr_pages_over_high += batch;
> > +                             set_notify_resume(current);
> > +                     } else
> > +                             schedule_work(&memcg->high_work);
> >                       break;
> >               }
> >       } while ((memcg = parent_mem_cgroup(memcg)));
> > --
> > 2.26.2.526.g744177e7f7-goog
> >
>
> --
> Michal Hocko
> SUSE Labs
