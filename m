Return-Path: <SRS0=7RkH=3E=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id F27EEC33CB3
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:05:34 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id CD3142084D
	for <linux-kernel@archiver.kernel.org>; Wed, 15 Jan 2020 19:05:34 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579115134;
	bh=E86tYwGI8/D8YKzb3RI+Ddi4KPlu1ClbHJ+QKIFD3LM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=QinoJebMc8e2ls1gpNDlxo6NNolKgX9gG0HCdDNnKyobrTgPnexjPEOv4kqIO7kvQ
	 jFEU7HMgfZHx0IYvpjFDGMvBpPOirHvVkz7RSN1lwuYYAywf9MszI5vZ7VfPFc+cZS
	 iJ40hAJcJRUV+6qM4tMNAzxIv6g1OJGTM2t4nySo=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729186AbgAOTFd (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Jan 2020 14:05:33 -0500
Received: from mail-wm1-f65.google.com ([209.85.128.65]:51998 "EHLO
        mail-wm1-f65.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1728928AbgAOTFd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jan 2020 14:05:33 -0500
Received: by mail-wm1-f65.google.com with SMTP id d73so1161828wmd.1
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 11:05:31 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=Kfwb/DZbMO5EaYi5yWox5Vryq+/ETLE5snZCjP2eywQ=;
        b=h0YKd51125wPklLM1Ylll3wWa2YVFuMyajiXzQVmSotnWGws+ogvCNh4C6YPEuEiPL
         Rv17vDbpfeH6YQOktOhLX2MPXWpreIg+fRScIfXmy45fcF/ZsKdWPepUELsrpMoog8YZ
         EBGkoSc4VJw2OcP7JJv7aPfWfwNEkSlr4NoMESAYVYYcIgJmJmQfwPGkCR5ac894Bkgx
         IlWfNTCtEq/TeF4m4y+UVfTukaNFCLkKbKBtPRk2VLiTdb92nfclKASVkT/sDWSW7Xtm
         S3ZnvVitrNrJB0Y04SPWxaGWgoEzY0/3nWoo0paRm3AFew2ChWcvcSLNmblblJDpo4Sx
         SOPg==
X-Gm-Message-State: APjAAAWISBPMPIhRBQbf45oUZu4eJ7kOXtstrIMKeYGxqjHE42cN12B5
        EXshjkAFOaCJ4kzCXDpmcIvQwEfm
X-Google-Smtp-Source: APXvYqyEayzAKYxBWIJJ/I7qBVThKmTHCboTdK3s1+ClUSqTP9KOo5fJvW8ncHfof05ooT4KueQ1Cg==
X-Received: by 2002:a7b:c386:: with SMTP id s6mr1450184wmj.105.1579115131271;
        Wed, 15 Jan 2020 11:05:31 -0800 (PST)
Received: from localhost (ip-37-188-146-105.eurotel.cz. [37.188.146.105])
        by smtp.gmail.com with ESMTPSA id d14sm27023531wru.9.2020.01.15.11.05.29
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 11:05:30 -0800 (PST)
Date:   Wed, 15 Jan 2020 20:05:28 +0100
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
Message-ID: <20200115190528.GJ19428@dhcp22.suse.cz>
References: <20200115055426.vdjwvry44nfug7yy@kili.mountain>
 <d31f6069-bda7-2cdb-b770-0c9cddac7537@suse.cz>
 <CACT4Y+YF9kYEppMMg3oRkeo+OvhMS1hoKT6EqXCv1jRmA2dz3w@mail.gmail.com>
 <20200115150315.GH19428@dhcp22.suse.cz>
 <CACT4Y+Z6xW130JGcZE9X7wDCLamJA_s-STs2imnmW29SzQ-NyQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+Z6xW130JGcZE9X7wDCLamJA_s-STs2imnmW29SzQ-NyQ@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 15-01-20 16:14:43, Dmitry Vyukov wrote:
> On Wed, Jan 15, 2020 at 4:03 PM Michal Hocko <mhocko@kernel.org> wrote:
> >
> > On Wed 15-01-20 13:57:47, Dmitry Vyukov wrote:
> > > On Wed, Jan 15, 2020 at 1:54 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> > > >
> > > > On 1/15/20 6:54 AM, Dan Carpenter wrote:
> > > > > What we are trying to do is change the '=' character to a NUL terminator
> > > > > and then at the end of the function we restore it back to an '='.  The
> > > > > problem is there are two error paths where we jump to the end of the
> > > > > function before we have replaced the '=' with NUL.  We end up putting
> > > > > the '=' in the wrong place (possibly one element before the start of
> > > > > the buffer).
> > > >
> > > > Bleh.
> > > >
> > > > > Reported-by: syzbot+e64a13c5369a194d67df@syzkaller.appspotmail.com
> > > > > Fixes: 095f1fc4ebf3 ("mempolicy: rework shmem mpol parsing and display")
> > > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > >
> > > > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > > >
> > > > CC stable perhaps? Can this (tmpfs mount options parsing AFAICS?) become
> > > > part of unprivileged operation in some scenarios?
> > >
> > > Yes, tmpfs can be mounted by any user inside of a user namespace.
> >
> > Huh, is there any restriction though? It is certainly not nice to have
> > an arbitrary memory allocated without a way of reclaiming it and OOM
> > killer wouldn't help for shmem.
> 
> The last time I checked there were hundreds of ways to allocate
> arbitrary amounts of memory without any restrictions by any user. The
> example at hand was setting up GB-sized netfilter tables in netns
> under userns. It's not subject to ulimit/memcg.

That's bad!

> Most kmalloc/vmalloc's are not accounted and can be abused.

Many of those should be bound to some objects and if those are directly
controllable by userspace then we should account at least. And if they
are not bound to a process life time then restricted.

> Is tmpfs even worse than these?

Well, tmpfs is accounted and restricted by memcg at least. The problem
is that it the memory is not really bound to a process life time which
makes it effectively unreclaimable once the swap space is depleted.
Still bad.
-- 
Michal Hocko
SUSE Labs
