Return-Path: <SRS0=maQP=AN=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-11.6 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 20AE8C433DF
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:02:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id F078F207D4
	for <linux-kernel@archiver.kernel.org>; Thu,  2 Jul 2020 16:02:46 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="RqGpjMEF"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726257AbgGBQCp (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 2 Jul 2020 12:02:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33892 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725379AbgGBQCp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jul 2020 12:02:45 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DA3D9C08C5C1
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jul 2020 09:02:44 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id b25so29319641ljp.6
        for <linux-kernel@vger.kernel.org>; Thu, 02 Jul 2020 09:02:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qL79Nq3oCLFzOTMGpWbet7Io9CHFHxAF6y2OIH7P7B4=;
        b=RqGpjMEFoC3lPt7KB5/BrJPpVJGiDboNINqnwfCYmwDrhIvPjrU8U25m/Sjjsza80o
         gwFlMK3yYzKmar3WB1+skx2vfiyQIUhmkGMckZnhQOgw7kQFuXw7s26o6FwmY5Ialcq9
         mRWAxhnwDxCbuZPYuVI8jOPnzFzUVRGvsygQtP+VMypMmGE0tvuJwmlp1vbGuhgq8To0
         /pmULktjB/VuQnV8+bwdvvgkTOpuiMJ5UN7U7K44+WoZ1bJ1fy9SSpt3I9WYn9K6vMPC
         RXG5tl9aFn5Dl0iSVKQxdnoVYpGRdYuF1bThn0bYrsmSotKsa4hU4euoPK4GC/XCGbr4
         dRTw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qL79Nq3oCLFzOTMGpWbet7Io9CHFHxAF6y2OIH7P7B4=;
        b=bkcE9dxSNIxY4YoBZhig1JpMlK17XviKu93b0UCp/cFSODvOgiR5OvV1RROCXKezlX
         pk8UaRienwZoXUsP7yeppvZcdBiQUr2hkGaPFI+c/rikcSOetROkh/C05nKZMVT0s7aq
         xiR3UH7rDC7iSQhlNeQWsNqv+Ib3Q3jmr0CaEL1bt9+eBcZBZwaKtsnOaE3ouQ6HdR+t
         3ri+N94w8sETyUvjcoeotYeKMMYA6KnuKWtaH2WjXLtbcHq/xw0uxW4eo4zl3M+lRfs6
         mCqzr5l7sa1ksfGtly+MT+INEAuGnK5RiRKbLNDLFZf644/9h6kCD39YugEcoBd62QPw
         jw2Q==
X-Gm-Message-State: AOAM530B7f4wLu8QznkBU023iY+Nhohdqmvbmi9+nJINx342u2W4RpS1
        Gb+OKjTzR5BVHyw+mUJh+n1Q2AFazntnbOpsn1ADLw==
X-Google-Smtp-Source: ABdhPJzCSv9gW+kUPkCq9nD0isczBmSZEYe52kFZeGBvtWJCQvuyMUHN2aap+/6Q57WOe2Z+S0BUzBeDFfKgGNHmdBI=
X-Received: by 2002:a2e:8e36:: with SMTP id r22mr16765350ljk.77.1593705763073;
 Thu, 02 Jul 2020 09:02:43 -0700 (PDT)
MIME-Version: 1.0
References: <CA+G9fYs=3UG3k-2trqQuB-gJh9D1YygkNQ4qWiHtcaRMSWTmrQ@mail.gmail.com>
 <20200701082904.GM2369@dhcp22.suse.cz> <20200701184552.GA61684@carbon.DHCP.thefacebook.com>
In-Reply-To: <20200701184552.GA61684@carbon.DHCP.thefacebook.com>
From:   Shakeel Butt <shakeelb@google.com>
Date:   Thu, 2 Jul 2020 09:02:31 -0700
Message-ID: <CALvZod6hZ4R=pZsURg4zKYNO2GTOsCumiQc32cvWUQe01ZB0vw@mail.gmail.com>
Subject: Re: BUG: Bad page state in process - page dumped because: page still
 charged to cgroup
To:     Roman Gushchin <guro@fb.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Naresh Kamboju <naresh.kamboju@linaro.org>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-mm <linux-mm@kvack.org>,
        open list <linux-kernel@vger.kernel.org>,
        lkft-triage@lists.linaro.org, Chris Down <chris@chrisdown.name>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jul 1, 2020 at 11:46 AM Roman Gushchin <guro@fb.com> wrote:
...
> --
>
> From c97afecd32c0db5e024be9ba72f43d22974f5bcd Mon Sep 17 00:00:00 2001
> From: Roman Gushchin <guro@fb.com>
> Date: Wed, 1 Jul 2020 11:05:32 -0700
> Subject: [PATCH] mm: kmem: make memcg_kmem_enabled() irreversible
>
> Historically the kernel memory accounting was an opt-in feature, which
> could be enabled for individual cgroups. But now it's not true, and
> it's on by default both on cgroup v1 and cgroup v2.  And as long as a
> user has at least one non-root memory cgroup, the kernel memory
> accounting is on. So in most setups it's either always on (if memory
> cgroups are in use and kmem accounting is not disabled), either always
> off (otherwise).
>
> memcg_kmem_enabled() is used in many places to guard the kernel memory
> accounting code. If memcg_kmem_enabled() can reverse from returning
> true to returning false (as now), we can't rely on it on release paths
> and have to check if it was on before.
>
> If we'll make memcg_kmem_enabled() irreversible (always returning true
> after returning it for the first time), it'll make the general logic
> more simple and robust. It also will allow to guard some checks which
> otherwise would stay unguarded.
>
> Signed-off-by: Roman Gushchin <guro@fb.com>

Reviewed-by: Shakeel Butt <shakeelb@google.com>
