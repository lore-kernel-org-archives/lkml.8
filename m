Return-Path: <SRS0=SogR=6O=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.8 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id AB8E5C4724C
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:31:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 8A5CD20656
	for <linux-kernel@archiver.kernel.org>; Thu, 30 Apr 2020 19:31:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=cmpxchg-org.20150623.gappssmtp.com header.i=@cmpxchg-org.20150623.gappssmtp.com header.b="vzffAZXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726817AbgD3TbC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 30 Apr 2020 15:31:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51938 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726486AbgD3TbC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Apr 2020 15:31:02 -0400
Received: from mail-qt1-x844.google.com (mail-qt1-x844.google.com [IPv6:2607:f8b0:4864:20::844])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EB67DC035494
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:31:01 -0700 (PDT)
Received: by mail-qt1-x844.google.com with SMTP id b1so6092931qtt.1
        for <linux-kernel@vger.kernel.org>; Thu, 30 Apr 2020 12:31:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=cmpxchg-org.20150623.gappssmtp.com; s=20150623;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=d1RAIbvoo2s7JffYGXt74NgzLodAkoT3ooI15LWHF58=;
        b=vzffAZXtvSvTwq5dKjdHWx63DCplLMxMCM5nmf/g/K/RG0YfleeYDmRvgKuHb4ZBAd
         w2YgrTnrZz0xNEdHNQvnr7Rr9/lSsOBtgCIVzJqTwCkFrrJTKZfScnqXAh9N/HKrOH5p
         KDqWBDqRw8t0gcyIWMhcT6dVIVWd5hyJ0rx8dtXwXNRdAbkhSU9h1IjLTpcwxaWWEZ2W
         j4Zq1oNj1y0SZjQ8iuchSaNHjfge8ycZcukkuoKnOhqvm6D39kHQPGmFg2cEjgxGWAI0
         hvKc8DOcxkrD73j0wcVJDnqYPs/j7QqmM26IJdQVHb4T3TCVOqF6M9Jzr4l4JQqJO4lb
         SgXw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=d1RAIbvoo2s7JffYGXt74NgzLodAkoT3ooI15LWHF58=;
        b=YrykQMf6wP2j6srHHHQAP7vqeW+BC9BTq14Oa+c9ZtCnIXctLOHqeejvJgRtvN5YtV
         InsFwqcIyOo7THi3TeTEG2kwOaziybc08h5sCdWXe1OnrpFzXQchbj4sZXC4jDt8GXPz
         pwMB86WbIDiHBQ2Rs3fZS/jsu+wmHlLOyfJCkbHhq40MeL0sfXklRPUMtCvmmcrsixjm
         1j0LaKvsul6B3uofhpTpPyDJCn8BlRXZ4fKHL2Ju140tvBbp/Xf3/xfJjZ+qiVEJg3wz
         QmvZvmtLwPgRt486CeoZfUIHzFLR4YA9SioXp4q81rbFv0Q3tgXyR7Hlio0eigQBKTk+
         wNsA==
X-Gm-Message-State: AGi0PuaFGzqZiR5SEBV5JB+EVETRvDHHMmSCvfJPS2JpEzFfXpgmnIvI
        kbEmV80Uud4d8eYc50HiGy/+aw==
X-Google-Smtp-Source: APiQypIx7o4Zv6JH1perddiK9QWDjW2RaNOmskvWp/qHUnEBVu3UEMz5Ag7jwSSF0QO4zYLd5nuZ3A==
X-Received: by 2002:ac8:46d1:: with SMTP id h17mr92523qto.72.1588275061021;
        Thu, 30 Apr 2020 12:31:01 -0700 (PDT)
Received: from localhost ([2620:10d:c091:480::1:63a7])
        by smtp.gmail.com with ESMTPSA id o43sm600444qtb.49.2020.04.30.12.30.59
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 30 Apr 2020 12:31:00 -0700 (PDT)
Date:   Thu, 30 Apr 2020 15:30:49 -0400
From:   Johannes Weiner <hannes@cmpxchg.org>
To:     Roman Gushchin <guro@fb.com>
Cc:     Shakeel Butt <shakeelb@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Greg Thelen <gthelen@google.com>,
        Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        cgroups@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] memcg: oom: ignore oom warnings from memory.max
Message-ID: <20200430193049.GB2436@cmpxchg.org>
References: <20200430182712.237526-1-shakeelb@google.com>
 <20200430190610.GD339283@carbon.dhcp.thefacebook.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200430190610.GD339283@carbon.dhcp.thefacebook.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 30, 2020 at 12:06:10PM -0700, Roman Gushchin wrote:
> On Thu, Apr 30, 2020 at 11:27:12AM -0700, Shakeel Butt wrote:
> > @@ -6106,7 +6107,7 @@ static ssize_t memory_max_write(struct kernfs_open_file *of,
> >  		}
> >  
> >  		memcg_memory_event(memcg, MEMCG_OOM);
> > -		if (!mem_cgroup_out_of_memory(memcg, GFP_KERNEL, 0))
> > +		if (!mem_cgroup_out_of_memory(memcg, GFP_KERNEL, 0, true))
> 
> I wonder if we can handle it automatically from the oom_killer side?
> We can suppress warnings if oc->memcg is set and the cgroup scanning
> showed that there are no belonging processes?

Note that we do remote charging for certain consumers, where memory
gets charged from the outside of the cgroup.

We would want to know if these cause OOMs on an empty cgroup, rather
than force-charge the allocations quietly.
