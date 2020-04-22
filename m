Return-Path: <SRS0=eifh=6G=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id DBA76C54FCB
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:42:33 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id B79CE2076E
	for <linux-kernel@archiver.kernel.org>; Wed, 22 Apr 2020 17:42:33 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="SXe+TpnW"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726557AbgDVRmd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 22 Apr 2020 13:42:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47600 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726100AbgDVRmb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Apr 2020 13:42:31 -0400
Received: from mail-qt1-x842.google.com (mail-qt1-x842.google.com [IPv6:2607:f8b0:4864:20::842])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BC945C03C1AA
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 10:42:31 -0700 (PDT)
Received: by mail-qt1-x842.google.com with SMTP id l13so2370801qtr.7
        for <linux-kernel@vger.kernel.org>; Wed, 22 Apr 2020 10:42:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=cjTwD6uKqnZZSCCcyV16R+WZpCxCW7qEmnrNY09I9TU=;
        b=SXe+TpnWHooh9QOLTZ6dPrc+kEXDChrdMWSwPBBvrbiuRWeGWW4hR03UNURAOWyCOp
         A1ivM3w+kYgYiUu+raGzagTVxzAhGDXYZcsTCw6/tsVAY3o4o96oA/5u0oHg7RjjMTq9
         tgPnfshzSvCpYaPzIkCLITPjO6AAJIMqP3Wky3w89IvCWzujBOauLENhuaU/X8CuKuFB
         8EledqZQwjMwAG0LDDP2CO649rhMDeXWU9lcZdD6RFJtGFZVkWheR2JO6HN7ol45mBUs
         vSj0lAKRCmXtbhp4BRu1PeJvtSagZIOT3/OIgRyEa/DVVTdkukHbVZO6fwxvfFVXDdCc
         7YlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=cjTwD6uKqnZZSCCcyV16R+WZpCxCW7qEmnrNY09I9TU=;
        b=rp9bqRvhG7k2POv2Wd8kVJEIPieSk56AaGViNMF2avAhZ837odxOTr9dXKcF74FKt1
         Jtpl3XQNjlSW6Td/jluK24qM6fQ0pqg15IdvZiCjpiCqwRwRgqvdUtHXk/zIEozMP/Qs
         Q3YoBG6d+ocX9cthXJj08Yi+nmxndAlqwRt5WS3urNvtBG2GyOQZZGuG6KQnuxRNx7sA
         HUpc/JPyUn1FoGIYl1L5jYkitphjmNC2Z/8vmvqvF0T9xuvAcZKvdhaAtCfFlKQtPOMx
         duO3FhCqXuMSQ6Qci2Sq2exbJ23bxlkQ/jJk2lUdZt1MfTtwcA+YJSi/NAA2Z11jPirK
         Ko2g==
X-Gm-Message-State: AGi0PubzCGgZdAFE/0J9xVulKDfY/ksx9GCwMzA7SAQZpNJyGrzaekHn
        sLIoFGoIJSgtBMN35DuyVg2Srg==
X-Google-Smtp-Source: APiQypLCRW4f/+7KFXIOLDocHwtHxj9EaXuX28tZn0XEH0wFojEsxjsXdo/ovxx6ossCISYPdzFDOQ==
X-Received: by 2002:ac8:23e3:: with SMTP id r32mr28222389qtr.268.1587577350782;
        Wed, 22 Apr 2020 10:42:30 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::921])
        by smtp.gmail.com with ESMTPSA id w42sm4577463qtj.63.2020.04.22.10.42.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 22 Apr 2020 10:42:30 -0700 (PDT)
Date:   Wed, 22 Apr 2020 13:42:29 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Shakeel Butt <shakeelb@google.com>
Cc:     Joonsoo Kim <js1304@gmail.com>,
        Alex Shi <alex.shi@linux.alibaba.com>,
        Hugh Dickins <hughd@google.com>,
        Michal Hocko <mhocko@suse.com>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Kernel Team <kernel-team@fb.com>
Subject: Re: [PATCH 02/18] mm: memcontrol: fix theoretical race in charge
 moving
Message-ID: <20200422174229.GD362484@cmpxchg.org>
References: <20200420221126.341272-1-hannes@cmpxchg.org>
 <20200420221126.341272-3-hannes@cmpxchg.org>
 <CALvZod4gFC1TDo8dtdaeQKj_ZEoOnQvRnw_dZANH7qQYCmnnGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALvZod4gFC1TDo8dtdaeQKj_ZEoOnQvRnw_dZANH7qQYCmnnGA@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 22, 2020 at 09:51:20AM -0700, Shakeel Butt wrote:
> On Mon, Apr 20, 2020 at 3:11 PM Johannes Weiner <hannes@cmpxchg.org> wrote:
> > @@ -5426,15 +5420,23 @@ static int mem_cgroup_move_account(struct page *page,
> >         }
> >
> >         /*
> > +        * All state has been migrated, let's switch to the new memcg.
> > +        *
> >          * It is safe to change page->mem_cgroup here because the page
> > -        * is referenced, charged, and isolated - we can't race with
> > -        * uncharging, charging, migration, or LRU putback.
> > +        * is referenced, charged, isolated, and locked: we can't race
> > +        * with (un)charging, migration, LRU putback, or anything else
> > +        * that would rely on a stable page->mem_cgroup.
> > +        *
> > +        * Note that lock_page_memcg is a memcg lock, not a page lock,
> > +        * to save space. As soon as we switch page->mem_cgroup to a
> > +        * new memcg that isn't locked, the above state can change
> > +        * concurrently again. Make sure we're truly done with it.
> >          */
> > +       smp_mb();
> 
> You said theoretical race in the subject but the above comment
> convinced me that smp_mb() is required. So, why is the race still
> theoretical?

Sorry about the confusion.

I said theoretical because I spotted it while thinking about the
code. I'm not aware of any real users that suffered the consequences
of this race condition. But they could exist in theory :-)

I think it's a real bug that needs fixing.
