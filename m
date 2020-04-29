Return-Path: <SRS0=ObIu=6N=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8BA86C83004
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:19:49 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 5F49321775
	for <linux-kernel@archiver.kernel.org>; Wed, 29 Apr 2020 14:19:49 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="sM10OsRR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727925AbgD2OTt (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 29 Apr 2020 10:19:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726701AbgD2OTs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Apr 2020 10:19:48 -0400
Received: from mail-qk1-x743.google.com (mail-qk1-x743.google.com [IPv6:2607:f8b0:4864:20::743])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BA08CC03C1AD
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:19:47 -0700 (PDT)
Received: by mail-qk1-x743.google.com with SMTP id t3so2114299qkg.1
        for <linux-kernel@vger.kernel.org>; Wed, 29 Apr 2020 07:19:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=WY+s1xElLyYapOX+xyVfCwGq2ouDJfw9qAn8e1SedMM=;
        b=sM10OsRR0LNY4pcjhbdJnhoISXS/L4LnoeViGpuwZ2v+5WA8cDi0zGpia6vF/Lnywe
         9yDC5Ysp9d3GxBOYO/Jy5r525crsR9ZR6Pel0O38S0Xl0kMiRfmh7zpL/aA3BBu81rMm
         tmR84XZpKOhWYZyP9PUd9L+TFewI/8EMjEjYSUpVDVJ6+3CAapKUaVFTXct61QYcva81
         gvSR+ox35ebLokYCKn2R0DeTO0+BRyx56hxhXWqLfCHar8ss9urE1ne3VXSINkkEOwdA
         5+q38c+uJC7z15wq2a3UQbl+6dVrM4vvJ4ZWX9Y2UXi2JxONkL/tF3icTij/9A/Vqv9y
         GtaQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=WY+s1xElLyYapOX+xyVfCwGq2ouDJfw9qAn8e1SedMM=;
        b=D/tcV/OORcy31asP/z9Hp21DPbhTOZ8KIpeupx7KjbCjh6pgXlswlB8UEfzPKF8ePO
         kuuWxvUkWV8uCG5+/itvbh52ZuoR0YfpVAJuELkhAtCA+xMmljZZT3GgDWIZkhkW4JLp
         cBTPwxT9pvCI4/NkCNXQBD55UTwv2QZK7fQOFfWGjuaM0qcFa4zJFvZjz51DJj/Tpw4m
         RxmUOUsZvKKfENlwjHkQhs6JoWa4hLSFr95LEycf4q8+rhImbz9KnfjmYGU61tzdAdQC
         U7hOLBNEyG3ePGibtQfPNt7NXyyRfUPJFp/UP6VZuMoPkJN8QQP/oY7Onb2EYLITqmgV
         f7Tg==
X-Gm-Message-State: AGi0Pua8jEAZuGObMNouiUxMBUh8gbXXncwBh6O+Z+zqir52bpwjY0Lp
        vuWTvIlvWJ1Uv/CWjPuCAK/IKA==
X-Google-Smtp-Source: APiQypKY1jxWzFUg/BqBWREV5gw+gcRj3d3DZwN6IsgBLMzwfxKXzASR4TlcBVu5Uaa4l1Z070vJPQ==
X-Received: by 2002:a37:5102:: with SMTP id f2mr16575684qkb.18.1588169986863;
        Wed, 29 Apr 2020 07:19:46 -0700 (PDT)
Received: from localhost (70.44.39.90.res-cmts.bus.ptd.net. [70.44.39.90])
        by smtp.gmail.com with ESMTPSA id k33sm15552796qtd.22.2020.04.29.07.19.45
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 29 Apr 2020 07:19:46 -0700 (PDT)
Date:   Wed, 29 Apr 2020 10:19:45 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Yafang Shao <laoar.shao@gmail.com>
Cc:     Michal Hocko <mhocko@kernel.org>,
        Chris Down <chris@chrisdown.name>,
        Andrew Morton <akpm@linux-foundation.org>,
        Roman Gushchin <guro@fb.com>, Linux MM <linux-mm@kvack.org>,
        Cgroups <cgroups@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 1/2] mm, memcg: Avoid stale protection values when cgroup
 is above protection
Message-ID: <20200429141945.GB5054@cmpxchg.org>
References: <cover.1588092152.git.chris@chrisdown.name>
 <d454fca5d6b38b74d8dc35141e8519b02089a698.1588092152.git.chris@chrisdown.name>
 <20200429101510.GA28637@dhcp22.suse.cz>
 <CALOAHbAosoU=+iPgD+TeU_iDXTV7W_WcFdKCi2fdwwyvutG2zQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CALOAHbAosoU=+iPgD+TeU_iDXTV7W_WcFdKCi2fdwwyvutG2zQ@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 29, 2020 at 06:53:03PM +0800, Yafang Shao wrote:
> On Wed, Apr 29, 2020 at 6:15 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Tue 28-04-20 19:26:47, Chris Down wrote:
> > > From: Yafang Shao <laoar.shao@gmail.com>
> > >
> > > A cgroup can have both memory protection and a memory limit to isolate
> > > it from its siblings in both directions - for example, to prevent it
> > > from being shrunk below 2G under high pressure from outside, but also
> > > from growing beyond 4G under low pressure.
> > >
> > > Commit 9783aa9917f8 ("mm, memcg: proportional memory.{low,min} reclaim")
> > > implemented proportional scan pressure so that multiple siblings in
> > > excess of their protection settings don't get reclaimed equally but
> > > instead in accordance to their unprotected portion.
> > >
> > > During limit reclaim, this proportionality shouldn't apply of course:
> > > there is no competition, all pressure is from within the cgroup and
> > > should be applied as such. Reclaim should operate at full efficiency.
> > >
> > > However, mem_cgroup_protected() never expected anybody to look at the
> > > effective protection values when it indicated that the cgroup is above
> > > its protection. As a result, a query during limit reclaim may return
> > > stale protection values that were calculated by a previous reclaim cycle
> > > in which the cgroup did have siblings.
> > >
> > > When this happens, reclaim is unnecessarily hesitant and potentially
> > > slow to meet the desired limit. In theory this could lead to premature
> > > OOM kills, although it's not obvious this has occurred in practice.
> >
> > Thanks this describes the underlying problem. I would be also explicit
> > that the issue should be visible only on tail memcgs which have both
> > max/high and protection configured and the effect depends on the
> > difference between the two (the smaller it is the largrger the effect).
> >
> > There is no mention about the fix. The patch resets effective values for
> > the reclaim root and I've had some concerns about that
> > http://lkml.kernel.org/r/20200424162103.GK11591@dhcp22.suse.cz.
> > Johannes has argued that other races are possible and I didn't get to
> > think about it thoroughly. But this patch is introducing a new
> > possibility of breaking protection.
> 
> Agreed with Michal that more writes will cause more bugs.
> We should operate the volatile emin and elow as less as possible.

That's not a technical argument.

If races are a problem, it doesn't matter that they're rare. If
they're not a problem, it doesn't matter that they're frequent.

> >  If we want to have a quick and
> > simple fix that would be easier to backport to older kernels then I
> > would feel much better if we simply workedaround the problem as
> > suggested earlier http://lkml.kernel.org/r/20200423061629.24185-1-laoar.shao@gmail.com
> 
> +1
> 
> This should be the right workaround to fix the current issue and it is
> worth to be backported to the stable kernel.

From Documentation/process/stable-kernel-rules.rst:

 - It must fix a real bug that bothers people (not a, "This could be a
   problem..." type thing).

There hasn't been a mention of this affecting real workloads in the
submission history of this patch, so it doesn't qualify for -stable.
