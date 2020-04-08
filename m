Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C930C2D0EA
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:24:47 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 513422072A
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 15:24:47 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="aOEDvUXt"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728523AbgDHPYq (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 11:24:46 -0400
Received: from us-smtp-delivery-1.mimecast.com ([207.211.31.120]:40066 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726687AbgDHPYp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 11:24:45 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1586359484;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=4M0R2TUDL0FW7W8mhxFMRc43IX6CRXZXscv7hpRRXn8=;
        b=aOEDvUXtg2u1lQtS29wzKPfJGwVNbx+DVjZ7rUyGj1H+ZxHVofSgJH3JGyBJIdXft00eDB
        t0eWjTbo3wU+LxmWB9Usd9mwI5ca/jUTFphRZsN7oZFvOnkx9zkcNUoS7scLQge9Lgi7mx
        vGZhwGbLGe1JqhCP/rPGfwpj3uTmGbo=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-453-vmdbBi_rMqCND9VjJPR56g-1; Wed, 08 Apr 2020 11:24:41 -0400
X-MC-Unique: vmdbBi_rMqCND9VjJPR56g-1
Received: by mail-wr1-f72.google.com with SMTP id f15so1330097wrj.2
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 08:24:40 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=4M0R2TUDL0FW7W8mhxFMRc43IX6CRXZXscv7hpRRXn8=;
        b=Botu2DjXlSpHeq0sVNHU0icdHba6H3wAcQdx8Byp2PFW7WBI8rqUqC8tjJFNf2FLde
         pLYc7QXBXWf/8CGoz174II/WHODh6kfUw2HRv7cj7Ix+5/Y6xXkhmDe5VbE4ijjAJM6v
         1FoOnDKel1OneZqXyAwE1qKbBIbsVFuwycyOzI8uWcb8VLb5IhTL1s5mQPn9M70FlFCQ
         PMIr9yFAzmjmXi9WBZo/oaFnWDkZ776PYgGlkzxyvH60JxzslwH42m8Y/BARYyBrdoDX
         OGsc674HVoWEwFh2roq0SJmQCjj9Wd3r1hPXRJcd5CEqnbdwDyWfSk49ZeXgsysMIE8R
         zA8A==
X-Gm-Message-State: AGi0Pub0rzPR27OjmA1sYQumQX/5iIdj2uyN/kVe2ZsZpnVneBdbua7s
        ru+yTjGbllIdmQtaCgnscSig71O9eJg1eQ1gYNlDKnM/Dm1gsfAzjhxnpDVAPN463zarjIVSSgz
        N3d2hR8LHoU7t/libRfTRrVHd
X-Received: by 2002:a5d:5112:: with SMTP id s18mr9134914wrt.306.1586359479936;
        Wed, 08 Apr 2020 08:24:39 -0700 (PDT)
X-Google-Smtp-Source: APiQypL1pXMVDZTx0i8mCb/v654TPggeYA1381CLrlgmNWfUraWzr9F914m7RAB844wSPjXLHuK3zQ==
X-Received: by 2002:a5d:5112:: with SMTP id s18mr9134893wrt.306.1586359479685;
        Wed, 08 Apr 2020 08:24:39 -0700 (PDT)
Received: from xz-x1 ([2607:9880:19c0:32::3])
        by smtp.gmail.com with ESMTPSA id o67sm7628108wmo.5.2020.04.08.08.24.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 08:24:38 -0700 (PDT)
Date:   Wed, 8 Apr 2020 11:24:35 -0400
From:   Peter Xu <peterx@redhat.com>
To:     Michal Hocko <mhocko@kernel.org>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] mm/mempolicy: Allow lookup_node() to handle fatal
 signal
Message-ID: <20200408152435.GH66033@xz-x1>
References: <20200408014010.80428-1-peterx@redhat.com>
 <20200408014010.80428-2-peterx@redhat.com>
 <20200408102128.GX18914@dhcp22.suse.cz>
 <20200408142039.GD66033@xz-x1>
 <20200408143024.GZ18914@dhcp22.suse.cz>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20200408143024.GZ18914@dhcp22.suse.cz>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 08, 2020 at 04:30:24PM +0200, Michal Hocko wrote:
> On Wed 08-04-20 10:20:39, Peter Xu wrote:
> > On Wed, Apr 08, 2020 at 12:21:28PM +0200, Michal Hocko wrote:
> > > On Tue 07-04-20 21:40:09, Peter Xu wrote:
> > > > lookup_node() uses gup to pin the page and get node information.  It
> > > > checks against ret>=0 assuming the page will be filled in.  However
> > > > it's also possible that gup will return zero, for example, when the
> > > > thread is quickly killed with a fatal signal.  Teach lookup_node() to
> > > > gracefully return an error -EFAULT if it happens.
> > > > 
> > > > Meanwhile, initialize "page" to NULL to avoid potential risk of
> > > > exploiting the pointer.
> > > > 
> > > > Reported-by: syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com
> > > > Fixes: 4426e945df58 ("mm/gup: allow VM_FAULT_RETRY for multiple times")
> > > 
> > > I am not familiar with thic commit but shouldn't gup return ERESTARTSYS
> > > on a fatal signal?
> > 
> > Hi, Michal,
> > 
> > I do see quite a few usages on -ERESTARTSYS, but also some others,
> > majorly -EINTR, or even -EFAULT.  I think it could be a more general
> > question rather than a specific question to this patch only.
> 
> I am sorry but I was probably not clear enough. I was mostly worried
> that gup doesn't return ERESTARTSYS or EINTR when it backed off because
> of fatal signal pending. Your patch is checking for 0 an indicating that
> this is that condition.

Yeah I just noticed the fact, sorry!

Hillf just posted a fix there for recovering the behavior:

https://lore.kernel.org/lkml/20200408151213.GE66033@xz-x1/

Thanks,

-- 
Peter Xu

