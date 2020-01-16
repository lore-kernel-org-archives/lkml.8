Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 1C83BC33CAF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:43:59 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E9BD724741
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 17:43:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579196639;
	bh=S6F2RyWON3pc/koe7YbLweurnYZyhS5ITZzGf+Fo9Tk=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=UJfD1xWSZHe7xKaG8hiwUoHDQYnsfLUfQGHm4v78jDXxEmC39WxNBDLeOcjtI+kEw
	 NqvNMfd0Umjk+yFh7yyBI6jUMtTSo70HaAt/hQbJekO19aL9jp2LQQUxWp0S89zu9A
	 rPMJgXQvJjtNjlBVfjBr+3rh5OV6kw5nQwM319zY=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2394042AbgAPRn6 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 12:43:58 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:34691 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2393948AbgAPRng (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 12:43:36 -0500
Received: by mail-wm1-f65.google.com with SMTP id w5so7660016wmi.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 09:43:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=9MY7ONfav8khW1lJ/3uShsqH56KYxPDNgzIDEH/X/z0=;
        b=ppCi5EpILTtT3D/81/v8r3Zcn8vW3n1q1jL5PRqU+ggkPwKkwWAEs3YHPVmMA6a+3f
         xFjIgP6ixBYZFoebu6pDe4iBN/dbrSVBG0/KxQeQWGosFoevL4bATXMVrZbj4cefD1kP
         2uhATgKx2doFrKNzejV6gc4Oj4Xg8WdKL+6Md5odOqVvC+wBz7r91GOTC7xOPT5e0afO
         vTEqHoaHbA30FnZD55c9aiD71DHX5gvVftiEaXO9U+0c+1qAknZlqgXCeH1c8AOea5oA
         M5DouhoZUOkMCY+ekgCN+3NAmpWh+QgQNZXFjWf3dbJlfK9o+hIr5oV99V3a5YYDJKfj
         a8kw==
X-Gm-Message-State: APjAAAW3FWyBY6Q8jkpCu3P9LeUyhNVHKgkBkVa6wXwiUJGXP0OAoR4b
        aZjjGnTG/tFkBSzUGl50rCc=
X-Google-Smtp-Source: APXvYqxbr0QGqGVKoGE7VIJlOoZQRh4NxgUUDikKHVS27nzBAhKrFqcfAbnbG11fYe09SRvzzyVLmA==
X-Received: by 2002:a05:600c:141:: with SMTP id w1mr166948wmm.61.1579196614741;
        Thu, 16 Jan 2020 09:43:34 -0800 (PST)
Received: from localhost (ip-37-188-146-105.eurotel.cz. [37.188.146.105])
        by smtp.gmail.com with ESMTPSA id i11sm30995465wrs.10.2020.01.16.09.43.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 09:43:33 -0800 (PST)
Date:   Thu, 16 Jan 2020 18:43:31 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Qian Cai <cai@lca.pw>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Sergey Senozhatsky <sergey.senozhatsky.work@gmail.com>,
        pmladek@suse.com, rostedt@goodmis.org, peterz@infradead.org,
        david@redhat.com, linux-mm@kvack.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH -next v3] mm/hotplug: silence a lockdep splat with
 printk()
Message-ID: <20200116174331.GC19428@dhcp22.suse.cz>
References: <20200115172916.16277-1-cai@lca.pw>
 <20200116142827.GU19428@dhcp22.suse.cz>
 <162DFB9F-247F-4DCA-9B69-535B9D714FBB@lca.pw>
 <20200116155434.GB19428@dhcp22.suse.cz>
 <D469AA91-FF6A-49B8-B894-1FA04C59AA3B@lca.pw>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <D469AA91-FF6A-49B8-B894-1FA04C59AA3B@lca.pw>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16-01-20 11:05:07, Qian Cai wrote:
> 
> 
> > On Jan 16, 2020, at 10:54 AM, Michal Hocko <mhocko@kernel.org> wrote:
> > 
> > On Thu 16-01-20 09:53:13, Qian Cai wrote:
> >> 
> >> 
> >>> On Jan 16, 2020, at 9:28 AM, Michal Hocko <mhocko@kernel.org> wrote:
> >>> 
> >>> On Wed 15-01-20 12:29:16, Qian Cai wrote:
> >>>> It is guaranteed to trigger a lockdep splat if calling printk() with
> >>>> zone->lock held because there are many places (tty, console drivers,
> >>>> debugobjects etc) would allocate some memory with another lock
> >>>> held which is proved to be difficult to fix them all.
> >>> 
> >>> I am still not happy with the above much. What would say about something
> >>> like below instead?
> >>> "
> >>> It is not that hard to trigger lockdep splats by calling printk from
> >>> under zone->lock. Most of them are false positives caused by lock chains
> >>> introduced early in the boot process and they do not cause any real
> >>> problems. There are some console drivers which do allocate from the
> >>> printk context as well and those should be fixed. In any case false
> >>> positives are not that trivial to workaround and it is far from optimal
> >>> to lose lockdep functionality for something that is a non-issue.
> >>> <An example of such a false positive goes here>
> >>> "
> >> 
> >> I feel like I repeated myself too many times. A call trace for one lock dependency
> >> is sometimes from early boot process because lockdep will save the first one it
> >> encountered, but it does not mean the lock dependency will only not happen in
> >> early boot. I spent some time to study those early boot call traces in the given
> >> lockdep splats, and it looks to me the lock dependency is also possible after
> >> the boot.
> > 
> > Then state it explicitly with an example of the trace and explanation
> > that the deadlock is real. If the deadlock is real then it shouldn't be
> > really terribly hard to notice even without lockdep splats which get
> > disabled after the first false positive, right?
> 
> A deadlock could be really hard to trigger though which needs a perfect
> timing between multiple threads.

All I am saying is: Do not speculate in changelog. Make clear arguments.
So far we have seen many false positives and that is stated in the
wording I have suggested. It is also explained why those suck. There is
also a note that _some_ consoles might indeed deadlock. Compare that to
the original changelog which doesn't really saying anything useful about
those lockdep splats.

I obviously do not insist on my wording but please make the changelog
clear on the actual problem and stick to facts.

Thanks!
-- 
Michal Hocko
SUSE Labs
