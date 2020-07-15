Return-Path: <SRS0=kup7=A2=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-4.0 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,
	SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id ADAC9C433E4
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:54:56 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8CEE120672
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jul 2020 16:54:56 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="FBdUKu4Z"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726384AbgGOQyz (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jul 2020 12:54:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45826 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725834AbgGOQyy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jul 2020 12:54:54 -0400
Received: from mail-qk1-x741.google.com (mail-qk1-x741.google.com [IPv6:2607:f8b0:4864:20::741])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03ADBC061755
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 09:54:53 -0700 (PDT)
Received: by mail-qk1-x741.google.com with SMTP id 80so2450546qko.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jul 2020 09:54:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=IGEOdfM2hRlmbqp8sPRSn3puPERfLRnlbCIsoJ2WegI=;
        b=FBdUKu4ZqFwKdKPqP5xEzhJHNM74kc6s4VEdepCUCGgTjRFE3AtXMmZ2hS5rVF2e1L
         m9IeJuX0bWDhMp+OGVyI7sTsCuhDDiBZzIoyq+ekaze/9E09bSWYOp3etnk7kM82RZtN
         cTY2LB4aAt6pLWE0+leOyfZgo+2hnraY7tw6uk0vrcS8EMA8wVkmja0pflTayZlU9UhV
         d+xF6vlAjul4fyOd+P4AfKyZlOXd/957OqJfXz7rmeX+WduUZm+w7hQ2+ujWGyzmF/SS
         JOCrxuS9FKTiYF03lR/vvB6HXE8zoygLtjHUh0dQPEa9QAsSssinSDoF5+U9TVLcvvv0
         Lp1Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=IGEOdfM2hRlmbqp8sPRSn3puPERfLRnlbCIsoJ2WegI=;
        b=uDP7/Sjn8N7ZCGO2jWIkzAr3vwIBXa2ewtIhOGn8raqfqHuw0GhWSsgorbKH3pepbz
         IqIelFglR0/i1RRO4qOOOw/LdTD7Cxf1dhpux4sfphOWHFsUy2RtnoT+5R8V+AigEsbG
         xxk3flBpxOwnO++SFJwbYAwx4pmuetl/5cWHGQlgfBV3pPDISzpwNMifS2mHh969UEA7
         5h+QEUXzcV6yobpBZaSm8uX2af8V8aiS3+85O0krBGMZTTI6JwOU7JKnpcWkzk9HR0VH
         AOm5pyoksPlQ15KiWC34mL2Y5dST29KT/c4rIswHEZsTLK+Gin0hZdg4l5hQx1ETAqXh
         XcTA==
X-Gm-Message-State: AOAM533k9sleD761TXnM42ACQ2vWT2aGtM7D7+8dICwQx6LVSFdZ3dSN
        r+O03JhsRHObXbduasr4sT2mqA==
X-Google-Smtp-Source: ABdhPJw+BsB1V/WidzAtPATnw4VY3l9AFfLmdy3RNQXztS/qL3uXKFijMY4CqdSI3ebgB3bNyHuGUw==
X-Received: by 2002:a05:620a:1282:: with SMTP id w2mr14411qki.196.1594832092927;
        Wed, 15 Jul 2020 09:54:52 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:6e7a])
        by smtp.gmail.com with ESMTPSA id m14sm3246229qke.99.2020.07.15.09.54.51
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jul 2020 09:54:51 -0700 (PDT)
Date:   Wed, 15 Jul 2020 12:54:02 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Yang Shi <yang.shi@linux.alibaba.com>,
        Roman Gushchin <guro@fb.com>, Michal Hocko <mhocko@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        Kernel Team <kernel-team@fb.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Domas Mituzas <domas@fb.com>, Tejun Heo <tj@kernel.org>,
        Chris Down <chris@chrisdown.name>
Subject: Re: [PATCH] mm: memcontrol: avoid workload stalls when lowering
 memory.high
Message-ID: <20200715165402.GA232052@cmpxchg.org>
References: <20200709194718.189231-1-guro@fb.com>
 <20200710122917.GB3022@dhcp22.suse.cz>
 <CALvZod6Yk8QoZjbNkGE8-qeOD187Nu-+VwasoROGZs_UsMgbEQ@mail.gmail.com>
 <20200710184205.GB350256@carbon.dhcp.thefacebook.com>
 <CALvZod45_zVaFhvw-wc9b6-Fth=fZo5Fo6xCwRVkrWC6ZprYyw@mail.gmail.com>
 <20200714153817.GA215857@cmpxchg.org>
 <CALvZod5n+KF9c6VCMVVrdYqwk+PY6K0AoQQU+mDEk85Ozz_NJg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod5n+KF9c6VCMVVrdYqwk+PY6K0AoQQU+mDEk85Ozz_NJg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 14, 2020 at 10:06:32AM -0700, Shakeel Butt wrote:
> On Tue, Jul 14, 2020 at 8:39 AM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > The way we do this right now is having the reclaimer daemon in a
> > dedicated top-level cgroup with memory.min protection.
> >
> > This works well because we have a comprehensive cgroup setup anyway
> > and need to protect this daemon (it's oomd - the proactive reclaimer,
> > senpai, is a plugin) for other reasons as well. But it's probably a
> > royal pain to use if you don't have all of that infrastructure.
> >
> > One possible idea to make this simpler would be to have a limit knob
> > that has a psi/pressure blowout valve. This way you could specify your
> > tolerances for paging and what constitutes "cold" memory, and the
> > limit unsets itself when pressure moves into harmful territory. This
> > would make it safe to use when the reclaimer becomes unresponsive or
> > dies altogether, which makes it safe to use from within the
> > cgroup. And being separate from max and high means we can delegate it.
> 
> I like this idea and agree with having a separate interface from max
> and high. Though why do we want to think of this interface as a limit
> interface. Are there additional benefits or use-cases which can
> benefit from this semantic?

I'm not saying we have to.

But one benefit of having a limit rather than a reclaim command knob
is that you can prevent cache-polluting scans through file data from
unnecessarily exploding the memory footprint of the cgroup.

It may be useful to compile a list of applications and goals for such
a knob, i.e. the reasons we want to do proactive reclaim in the first
place.
