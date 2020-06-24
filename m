Return-Path: <SRS0=sD2I=AF=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-13.1 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED,USER_AGENT_SANE_1,
	USER_IN_DEF_DKIM_WL autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 56B38C433DF
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:00:31 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 303EA206C0
	for <linux-kernel@archiver.kernel.org>; Wed, 24 Jun 2020 20:00:31 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="kU5gpx3Y"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2406364AbgFXUA3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 24 Jun 2020 16:00:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45456 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2406231AbgFXUA0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Jun 2020 16:00:26 -0400
Received: from mail-pj1-x1042.google.com (mail-pj1-x1042.google.com [IPv6:2607:f8b0:4864:20::1042])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 64D9AC061573
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:00:26 -0700 (PDT)
Received: by mail-pj1-x1042.google.com with SMTP id i4so1657410pjd.0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Jun 2020 13:00:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Ic2rSOyLLU92IxsDQa40KxAfIh3emFoAg8+8Z9zBZLk=;
        b=kU5gpx3Y6OC13BtuXk0HauEe4SnRRBl9UregNtADzr/gVODMa3X+K78kj9+PkS/hgo
         4kiLZcX362HZgzyKxa66ffF8DDThk+b3gALh3jMr8IeI1YmbuV2rqwc48cbGqgyZZY+Z
         Q11nijFgASra09QWSE4BfN8jWLfrmQKArbA+DY3BGeGaN9dHWNnifssKvCb/CLSaAEYw
         TDYKfzaTgGyYnjGj1ShJs/1psqC1fMCA5UWy7fhY5mezCojoQUUI35z0z6HIgKv6q8Ks
         F+4+zS9d6UXUNmMq3qeN0motW+18QfUJSU9wgFyzXIk1ht2AWohuQfZqlYCC7l6xiVh0
         qimA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Ic2rSOyLLU92IxsDQa40KxAfIh3emFoAg8+8Z9zBZLk=;
        b=FRggcAwDHLanSuzoH+zuNHWhM0S3gAdpZQNel0gCU3JxQdne4OaXt+SdvbLIl+IPlk
         wNaG8vnkeOoBC1KxEZQkOJ80Gvarp/NAWMd6hHxBg2kPs5y6xyu7bhShrVd1yoAJnwrS
         p0kHbOwP3a4KuxgeSaCrcJ7kv1IxVOdgaG224NVotziuhTJz2HfpB0BizpcjcD5c3jC4
         r7fHS8kSBUx28Jfj85DOmP61iDobEf6FrPbtEmKk5ASDD8bag+fyYX9QUYpZr2E3nbqg
         1J+FDK2XPmYIeduRa0t66FpXcAGfR1YCb5cJb5v8ycwKsMOTnWf0QWes270S2k2boTKF
         qYBQ==
X-Gm-Message-State: AOAM533wlZtUpkhbe2EReL4EEz6ilISzComZEwyuG0JF6L2u1yQFm91G
        j3X0fxh929Gy4/lV3sHWk6YCKuYGIzw=
X-Google-Smtp-Source: ABdhPJzDSRznzss3ODVL/uvo/3wIGFCth9XaDcjSZv7/h6ukRYzF+vCyOEh7wiGXl5K6d9IXb13qjQ==
X-Received: by 2002:a17:90a:62ca:: with SMTP id k10mr31534169pjs.87.1593028825742;
        Wed, 24 Jun 2020 13:00:25 -0700 (PDT)
Received: from [2620:15c:17:3:3a5:23a7:5e32:4598] ([2620:15c:17:3:3a5:23a7:5e32:4598])
        by smtp.gmail.com with ESMTPSA id fa13sm5948256pjb.39.2020.06.24.13.00.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 24 Jun 2020 13:00:25 -0700 (PDT)
Date:   Wed, 24 Jun 2020 13:00:24 -0700 (PDT)
From:   David Rientjes <rientjes@google.com>
X-X-Sender: rientjes@chino.kir.corp.google.com
To:     Minchan Kim <minchan@kernel.org>
cc:     Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Christian Brauner <christian.brauner@ubuntu.com>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        oleksandr@redhat.com, Suren Baghdasaryan <surenb@google.com>,
        Tim Murray <timmurray@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Jann Horn <jannh@google.com>,
        alexander.h.duyck@linux.intel.com, sj38.park@gmail.com,
        Arjun Roy <arjunroy@google.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jens Axboe <axboe@kernel.dk>,
        Daniel Colascione <dancol@google.com>,
        Kirill Tkhai <ktkhai@virtuozzo.com>,
        SeongJae Park <sjpark@amazon.de>, linux-man@vger.kernel.org
Subject: Re: [PATCH v8 2/4] pid: move pidfd_get_pid() to pid.c
In-Reply-To: <20200622192900.22757-3-minchan@kernel.org>
Message-ID: <alpine.DEB.2.22.394.2006241253190.35388@chino.kir.corp.google.com>
References: <20200622192900.22757-1-minchan@kernel.org> <20200622192900.22757-3-minchan@kernel.org>
User-Agent: Alpine 2.22 (DEB 394 2020-01-19)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 22 Jun 2020, Minchan Kim wrote:

> process_madvise syscall needs pidfd_get_pid function to translate pidfd to
> pid so this patch move the function to kernel/pid.c.
> 
> Link: http://lkml.kernel.org/r/20200302193630.68771-5-minchan@kernel.org
> Signed-off-by: Minchan Kim <minchan@kernel.org>
> Reviewed-by: Suren Baghdasaryan <surenb@google.com>
> Suggested-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Reviewed-by: Alexander Duyck <alexander.h.duyck@linux.intel.com>
> Acked-by: Christian Brauner <christian.brauner@ubuntu.com>
> Reviewed-by: Vlastimil Babka <vbabka@suse.cz>
> Cc: Jens Axboe <axboe@kernel.dk>
> Cc: Jann Horn <jannh@google.com>
> Cc: Brian Geffon <bgeffon@google.com>
> Cc: Daniel Colascione <dancol@google.com>
> Cc: Joel Fernandes <joel@joelfernandes.org>
> Cc: Johannes Weiner <hannes@cmpxchg.org>
> Cc: John Dias <joaodias@google.com>
> Cc: Kirill Tkhai <ktkhai@virtuozzo.com>
> Cc: Michal Hocko <mhocko@suse.com>
> Cc: Oleksandr Natalenko <oleksandr@redhat.com>
> Cc: Sandeep Patil <sspatil@google.com>
> Cc: SeongJae Park <sj38.park@gmail.com>
> Cc: SeongJae Park <sjpark@amazon.de>
> Cc: Shakeel Butt <shakeelb@google.com>
> Cc: Sonny Rao <sonnyrao@google.com>
> Cc: Tim Murray <timmurray@google.com>
> Cc: Christian Brauner <christian.brauner@ubuntu.com>
> Cc: <linux-man@vger.kernel.org>

Acked-by: David Rientjes <rientjes@google.com>
