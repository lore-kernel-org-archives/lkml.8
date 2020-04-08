Return-Path: <SRS0=8dav=5Y=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-1.1 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A797AC2BA2B
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:30:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 7768920780
	for <linux-kernel@archiver.kernel.org>; Wed,  8 Apr 2020 14:30:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1586356230;
	bh=y9Avibwqc8kKKIBqDGAiMVmjYunX2XTcej5SPcrjL/w=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=ZU+7kLkBZlV9dsLdnRtC2FbQMadIXvn4ymXZ3nsAZDAS3dWJO5WXzTQAT1zlZah+j
	 dqk+geex3mT+23ujdyNmjj60XHWLPzmpr5aXT7WtmdzU9fYQIj6YeWqAqea2sf6j96
	 r/sc+3Ed+msCG1XxDQrj4VBaiPEElvO7R0OzXrtQ=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728775AbgDHOa3 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 8 Apr 2020 10:30:29 -0400
Received: from mail-wm1-f65.google.com ([209.85.128.65]:56118 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726774AbgDHOa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Apr 2020 10:30:28 -0400
Received: by mail-wm1-f65.google.com with SMTP id e26so94020wmk.5
        for <linux-kernel@vger.kernel.org>; Wed, 08 Apr 2020 07:30:27 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nL8cPG0DZ29ZLKFrUfdbtamt4Cn3OPj56HGn9oNpqJY=;
        b=JgalBiFQosIfwoomRbsNSePfxGA/Sk+oxILnuRroQQDzT2RuT5jkkoRWLw2Uxucxad
         zgNRIvvBx71/QpHh0Iia0/UCNApET+0lbutQdyfvzxhJMnvSFqQR1HdmOlfIVGfSYKJ3
         h5Zp7sUaZdHBN8C+CV+eO+20aC6FaXPzSA5dOSAykzpALzgM4y5B6xJexI7h4n/fJGdh
         iwepJszBfMkBuoJS94u+TbZHhFlacMvvy+M6cS6hR/2l9CdYB23Uno9wlJ8Oypw9Vjgv
         REIy+sNP5Wcevr97LO9NlC1XKrF9kp0oVogu/2ekTameqsKG/0i4So6NlSe5c3kh+IIe
         O1JA==
X-Gm-Message-State: AGi0PubRf1jrY88bprlq4Ipd/tnJ5V23ecixoB1ZCphKuDK+N3g1j9ul
        nP9AGwi+E/xfGuVzH4QAZ2Y=
X-Google-Smtp-Source: APiQypL28mHffic4DQSxyy7qJ3TxkU/ZG5jsJF1QzPF79fr/2EZmD/5HKZHHKOOKeRXW74AVNd+/5g==
X-Received: by 2002:a05:600c:2f88:: with SMTP id t8mr4844535wmn.46.1586356226769;
        Wed, 08 Apr 2020 07:30:26 -0700 (PDT)
Received: from localhost (ip-37-188-180-223.eurotel.cz. [37.188.180.223])
        by smtp.gmail.com with ESMTPSA id j10sm18707191wru.85.2020.04.08.07.30.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Apr 2020 07:30:25 -0700 (PDT)
Date:   Wed, 8 Apr 2020 16:30:24 +0200
From:   Michal Hocko <mhocko@kernel.org>
To:     Peter Xu <peterx@redhat.com>
Cc:     linux-kernel@vger.kernel.org,
        Linus Torvalds <torvalds@linux-foundation.org>,
        linux-mm@kvack.org, Andrew Morton <akpm@linux-foundation.org>,
        syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com
Subject: Re: [PATCH 1/2] mm/mempolicy: Allow lookup_node() to handle fatal
 signal
Message-ID: <20200408143024.GZ18914@dhcp22.suse.cz>
References: <20200408014010.80428-1-peterx@redhat.com>
 <20200408014010.80428-2-peterx@redhat.com>
 <20200408102128.GX18914@dhcp22.suse.cz>
 <20200408142039.GD66033@xz-x1>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200408142039.GD66033@xz-x1>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 08-04-20 10:20:39, Peter Xu wrote:
> On Wed, Apr 08, 2020 at 12:21:28PM +0200, Michal Hocko wrote:
> > On Tue 07-04-20 21:40:09, Peter Xu wrote:
> > > lookup_node() uses gup to pin the page and get node information.  It
> > > checks against ret>=0 assuming the page will be filled in.  However
> > > it's also possible that gup will return zero, for example, when the
> > > thread is quickly killed with a fatal signal.  Teach lookup_node() to
> > > gracefully return an error -EFAULT if it happens.
> > > 
> > > Meanwhile, initialize "page" to NULL to avoid potential risk of
> > > exploiting the pointer.
> > > 
> > > Reported-by: syzbot+693dc11fcb53120b5559@syzkaller.appspotmail.com
> > > Fixes: 4426e945df58 ("mm/gup: allow VM_FAULT_RETRY for multiple times")
> > 
> > I am not familiar with thic commit but shouldn't gup return ERESTARTSYS
> > on a fatal signal?
> 
> Hi, Michal,
> 
> I do see quite a few usages on -ERESTARTSYS, but also some others,
> majorly -EINTR, or even -EFAULT.  I think it could be a more general
> question rather than a specific question to this patch only.

I am sorry but I was probably not clear enough. I was mostly worried
that gup doesn't return ERESTARTSYS or EINTR when it backed off because
of fatal signal pending. Your patch is checking for 0 an indicating that
this is that condition.
-- 
Michal Hocko
SUSE Labs
