Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 2C07BC2BA1A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:26:44 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 04649206F5
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:26:44 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586359604;
	bh=GfzTfu8XrLCvHid5q3uid13peEeJYxijsaBcqbnPvek=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=BHpm6sA3hDw5932M84dHfXgNSYsH6zVxDWbLVwGGPR9jK/yq0Kpyas7PYXwne3/D3
	 h9+jPI/Yk4wChayPIdnLPWcbHpKE8cL1BSNSVHOJXywvQJkQ8KxdVpWFEnPTp/1y19
	 EYuUVTZpIzdtlVwS4C1kSDSDoFcPgWMQ0ollfNII=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728336AbgDHP0m (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:26:42 -0400
Received: from mail-wm1-f67.google.com ([209.85.128.67]:37272 "EHLO
        mail-wm1-f67.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727192AbgDHP0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:26:42 -0400
Received: by mail-wm1-f67.google.com with SMTP id z6so334679wml.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 08:26:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=FaARG6XZkrL693jomz9D6POM95NcKN5ZYfjmCHYqtH8=;
        b=nkzj3ggpZ0/jeCgFKgVRQyxOYM2dxyOerjmOsOmfFHIHXY2DKRS1KBARRjTOMQpVL6
         2hAzdFMiHaxGd0HJJc4tvKyDvffHC9mlBWhOrrcV18ZPnTU5uuuWIJjjubK365YPIwn6
         pPD+2aCcN3XVLmCM88WuuzICX+W//oP528t5vN66jNO4mML6F+DzZ/mgyE9tUgcCHxok
         5S5aOSW3nc59gGlrn5CVrqmFgzWSUFMDPkKWwRYs1szyZBRnbBAyUq7UY6yPzRJYxmqu
         9iC3K0U5tt0s6PCfWuUzw0qFKT+oyfuh22IOfB3C0TwkzkHlJ7iKZ9NEZXcP/gCzpWnj
         18xw==
X-Gm-Message-State: AGi0PuaHVoUmnTEtiZEAz54KoPbMgpuiBphMT1SMmWBX9Hc8AkYJT4r6
        7CTTkSvb22dWwJkZC3hLW7sw9YaL
X-Google-Smtp-Source: APiQypLbvH8t4KrmuhPNvl2VlWY6JHSFAytcIzG4bMsvc7U2Aw/qM+mYKQPaFxmiYumDG/IYgux5Vw==
X-Received: by 2002:a1c:e203:: with SMTP id z3mr5374024wmg.71.1586359594251;
        Wed, 08 Apr 2020 08:26:34 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id p7sm3142652wrf.31.2020.04.08.08.26.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 08:26:32 -0700 (PDT)
Date:   Wed, 8 Apr 2020 17:26:30 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] mm/mempolicy: Allow lookup_node() to handle fatal
 signal
Message-ID: <20200408152630.GA18914@dhcp22.suse.cz>
References: <20200408014010.80428-1-peterx@redhat.com>
 <20200408014010.80428-2-peterx@redhat.com>
 <20200408102128.GX18914@dhcp22.suse.cz>
 <20200408142039.GD66033@xz-x1>
 <20200408143024.GZ18914@dhcp22.suse.cz>
 <20200408152435.GH66033@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408152435.GH66033@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08-04-20 11:24:35, Peter Xu wrote:
> On Wed, Apr 08, 2020 at 04:30:24PM +0200, Michal Hocko wrote:
> > On Wed 08-04-20 10:20:39, Peter Xu wrote:
> > > On Wed, Apr 08, 2020 at 12:21:28PM +0200, Michal Hocko wrote:
> > > > On Tue 07-04-20 21:40:09, Peter Xu wrote:
> > > > > lookup_node() uses gup to pin the page and get node information.  It
> > > > > checks against ret>=0 assuming the page will be filled in.  However
> > > > > it's also possible that gup will return zero, for example, when the
> > > > > thread is quickly killed with a fatal signal.  Teach lookup_node() to
> > > > > gracefully return an error -EFAULT if it happens.
> > > > > 
> > > > > Meanwhile, initialize "page" to NULL to avoid potential risk of
> > > > > exploiting the pointer.
> > > > > 
> > > > > Reported-by: syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com
> > > > > Fixes: 4426e945df58 ("mm/gup: allow VM_FAULT_RETRY for multiple times")
> > > > 
> > > > I am not familiar with thic commit but shouldn't gup return ERESTARTSYS
> > > > on a fatal signal?
> > > 
> > > Hi, Michal,
> > > 
> > > I do see quite a few usages on -ERESTARTSYS, but also some others,
> > > majorly -EINTR, or even -EFAULT.  I think it could be a more general
> > > question rather than a specific question to this patch only.
> > 
> > I am sorry but I was probably not clear enough. I was mostly worried
> > that gup doesn't return ERESTARTSYS or EINTR when it backed off because
> > of fatal signal pending. Your patch is checking for 0 an indicating that
> > this is that condition.
> 
> Yeah I just noticed the fact, sorry!
> 
> Hillf just posted a fix there for recovering the behavior:
> 
> https://lore.kernel.org/lkml/20200408151213.GE66033@xz-x1/

yeah, that is the proper fix.
-- 
Michal Hocko
SUSE Labs
