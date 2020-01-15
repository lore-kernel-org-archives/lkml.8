Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id B1E0CC33CB1
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:03:20 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 802FB214AF
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 15:03:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579100600;
	bh=UKP/54ds3teDMM31odY7FcuND94buMhhQIUinStOOnM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=wXVBcdfVMCnNNTBnUmuQ+Hd+NEMd86udJF1+JVzNkh84/F3HYzdEgMIzweInkUEYO
	 2j32WAOuccKxcISLYBt8xORQuHm5eGs5LB9ma6c5Yt0pDWtAiRvamdiyBMTTzuyuHD
	 nbfYcz9gkxr4WPiu/SIlMCTWCp599qRlJ29ZE5a4=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729057AbgAOPDT (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 10:03:19 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:36653 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726132AbgAOPDT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 10:03:19 -0500
Received: by mail-wm1-f65.google.com with SMTP id p17so217080wma.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 07:03:18 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=S/ouc2MXlGxf8UxOAl84uHXMGJR02tyST/oeJfnJMFY=;
        b=A+00HuB+vXRvNJc8HQ+Aa4RD2IppB5AP4ZF6XtRmDQcxI7jmLKMghOZCRm71HQXfT+
         NfgU423pIcgq6x3nabz+U4FH2PQ9tNZO4Wcst1qGgJTbBTPiFjx+vvbDjJew5AUrKUQp
         QEMWZpW4bFCQMhezjaYyRYhQUVOt+K91SYsxa6QmAfOQp3asQm/qrLy3HZeIOoPJQwxg
         QT5J1X24JmjI2qC/tmPWEbajSZcBVZbszDtTce80MXXYPbvijuq61CdHDaznVyiBzoDF
         eC+MKZ9l1QFhwKvp/7zTFHNYY00hOVZNezM00k+JJA2uOLgWXqDzL6QyuTlJBu4uwq5u
         CrFA==
X-Gm-Message-State: APjAAAWWD3WfMhDrHQsZrhDxDpJvnWVXmxT0diGZFPRPpoZ+9LKSuKI3
        0Mcgi+FMHpelDc2MF2HwBDk=
X-Google-Smtp-Source: APXvYqzAVHygrGoNV/p3sqwpqXELKzU9BAFm5zX1t/aq6Hw6nJqv5hcOWlmnEUJPYPR7P+hxgHTFQA==
X-Received: by 2002:a1c:cc06:: with SMTP id h6mr197947wmb.118.1579100597451;
        Wed, 15 Jan 2020 07:03:17 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id d8sm25548532wre.13.2020.01.15.07.03.16
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 07:03:16 -0800 (PST)
Date:   Wed, 15 Jan 2020 16:03:15 +0100
From:   Michal Hocko <mhocko@kernel.org>
To:     Dmitry Vyukov <dvyukov@google.com>
Cc:     Vlastimil Babka <vbabka@suse.cz>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Lee Schermerhorn <lee.schermerhorn@hp.com>,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        syzbot <syzbot+e64a13c5369a194d67df@syzkaller.appspotmail.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Hugh Dickins <hughd@google.com>,
        syzkaller-bugs <syzkaller-bugs@googlegroups.com>,
        Al Viro <viro@zeniv.linux.org.uk>, yang.shi@linux.alibaba.com
Subject: Re: [PATCH] mm/mempolicy.c: Fix out of bounds write in
 mpol_parse_str()
Message-ID: <20200115150315.GH19428@dhcp22.suse.cz>
References: <20200115055426.vdjwvry44nfug7yy@kili.mountain>
 <d31f6069-bda7-2cdb-b770-0c9cddac7537@suse.cz>
 <CACT4Y+YF9kYEppMMg3oRkeo+OvhMS1hoKT6EqXCv1jRmA2dz3w@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+YF9kYEppMMg3oRkeo+OvhMS1hoKT6EqXCv1jRmA2dz3w@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-01-20 13:57:47, Dmitry Vyukov wrote:
> On Wed, Jan 15, 2020 at 1:54 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> >
> > On 1/15/20 6:54 AM, Dan Carpenter wrote:
> > > What we are trying to do is change the '=' character to a NUL terminator
> > > and then at the end of the function we restore it back to an '='.  The
> > > problem is there are two error paths where we jump to the end of the
> > > function before we have replaced the '=' with NUL.  We end up putting
> > > the '=' in the wrong place (possibly one element before the start of
> > > the buffer).
> >
> > Bleh.
> >
> > > Reported-by: syzbot+e64a13c5369a194d67df@syzkaller.appspotmail.com
> > > Fixes: 095f1fc4ebf3 ("mempolicy: rework shmem mpol parsing and display")
> > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> >
> > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> >
> > CC stable perhaps? Can this (tmpfs mount options parsing AFAICS?) become
> > part of unprivileged operation in some scenarios?
> 
> Yes, tmpfs can be mounted by any user inside of a user namespace.

Huh, is there any restriction though? It is certainly not nice to have
an arbitrary memory allocated without a way of reclaiming it and OOM
killer wouldn't help for shmem.
-- 
Michal Hocko
SUSE Labs
