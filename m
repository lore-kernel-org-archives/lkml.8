Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,
	SPF_PASS,USER_AGENT_SANE_1 autolearn=unavailable autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 25E87C33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 07:39:28 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id E6A652075B
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 07:39:27 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579160368;
	bh=qAbgJUF+nApeddNlxmj8IpXtJFRIsaBWpOvKc0Zq1CY=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=Vtd51tCqxH4Uoo4/pdXhVDSrUI8/zyBQvZYwcqXxpR0gU5qUdLhOiMxA8hlkYU1Iy
	 7ZV6p+0ns/G0u/A6WZlihYiakfyadIefoyq9MKbkKTC+GQka8Wg+HXiG5MVZ+DYGCN
	 7NZNLcivi50AXD4toXwVXtqAq/OyRyf2iese8/fA=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729616AbgAPHj0 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 02:39:26 -0500
Received: from mail-wr1-f66.google.com ([209.85.221.66]:45203 "EHLO
        mail-wr1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726369AbgAPHj0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 02:39:26 -0500
Received: by mail-wr1-f66.google.com with SMTP id j42so18007811wrj.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jan 2020 23:39:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=bBIJdoOGcKT7ARa4hpF0Qzi9SqnNejpA2FdEIbbGlvw=;
        b=tgwbh8PXOknn6u3reRuTWQ/PUBTLfS1iv8p4SKXTsqhXBd719D4r2uRPY8+Q00JB/v
         P1tadnhjoMupankqDaSl9lZyP11kSFcbbQVE8UZoQJQY8pp2TdEcfFtuEluWPJhhzypa
         Kw0q3vUNfNJYagvjIDDlHfcJ/o0sb3WVS7t7ha5GMdnnWi8TwdZukIEhC9EslOaFHqHK
         i4CQ9EXGGHu70jzDsP8eTAlkTvvo2NyBDu7QxrgoTcaOKwd3smanVvsZOjwLMJyfLl//
         eUlTMxb8KqpDodPA74KMFjwSj1XkmzIMJ/z2CVf278pIs8EPDJcG718t+zcH8Nij1D4C
         F+GQ==
X-Gm-Message-State: APjAAAX5H7wxIemJTVzBtP7Z7c6TdtIVrskUohdq+FX9/KZz2pw0EVVp
        QiKKme3meuFQAHZEo88f0nA=
X-Google-Smtp-Source: APXvYqwh2du+d8lyfUMfq2pY8IgeVBXJR6/z7dzMr6nzR4sM0wycMNyDQKCEf8o2GNp7nNE6VT2Mxg==
X-Received: by 2002:adf:fe8c:: with SMTP id l12mr1598425wrr.215.1579160364410;
        Wed, 15 Jan 2020 23:39:24 -0800 (PST)
Received: from localhost (ip-37-188-146-105.eurotel.cz. [37.188.146.105])
        by smtp.gmail.com with ESMTPSA id m126sm1394332wmf.7.2020.01.15.23.39.22
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Jan 2020 23:39:23 -0800 (PST)
Date:   Thu, 16 Jan 2020 08:39:22 +0100
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
Message-ID: <20200116073922.GL19428@dhcp22.suse.cz>
References: <20200115055426.vdjwvry44nfug7yy@kili.mountain>
 <d31f6069-bda7-2cdb-b770-0c9cddac7537@suse.cz>
 <CACT4Y+YF9kYEppMMg3oRkeo+OvhMS1hoKT6EqXCv1jRmA2dz3w@mail.gmail.com>
 <20200115150315.GH19428@dhcp22.suse.cz>
 <CACT4Y+Z6xW130JGcZE9X7wDCLamJA_s-STs2imnmW29SzQ-NyQ@mail.gmail.com>
 <20200115190528.GJ19428@dhcp22.suse.cz>
 <CACT4Y+b5HJW9PhjkSZ+L09YqQt08ALCtudHV4m5x5qv+xH-2Yg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+b5HJW9PhjkSZ+L09YqQt08ALCtudHV4m5x5qv+xH-2Yg@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16-01-20 06:41:46, Dmitry Vyukov wrote:
> On Wed, Jan 15, 2020 at 8:05 PM Michal Hocko <mhocko@kernel.org> wrote:
> > > > > On Wed, Jan 15, 2020 at 1:54 PM Vlastimil Babka <vbabka@suse.cz> wrote:
> > > > > >
> > > > > > On 1/15/20 6:54 AM, Dan Carpenter wrote:
> > > > > > > What we are trying to do is change the '=' character to a NUL terminator
> > > > > > > and then at the end of the function we restore it back to an '='.  The
> > > > > > > problem is there are two error paths where we jump to the end of the
> > > > > > > function before we have replaced the '=' with NUL.  We end up putting
> > > > > > > the '=' in the wrong place (possibly one element before the start of
> > > > > > > the buffer).
> > > > > >
> > > > > > Bleh.
> > > > > >
> > > > > > > Reported-by: syzbot+e64a13c5369a194d67df@syzkaller.appspotmail.com
> > > > > > > Fixes: 095f1fc4ebf3 ("mempolicy: rework shmem mpol parsing and display")
> > > > > > > Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> > > > > >
> > > > > > Acked-by: Vlastimil Babka <vbabka@suse.cz>
> > > > > >
> > > > > > CC stable perhaps? Can this (tmpfs mount options parsing AFAICS?) become
> > > > > > part of unprivileged operation in some scenarios?
> > > > >
> > > > > Yes, tmpfs can be mounted by any user inside of a user namespace.
> > > >
> > > > Huh, is there any restriction though? It is certainly not nice to have
> > > > an arbitrary memory allocated without a way of reclaiming it and OOM
> > > > killer wouldn't help for shmem.
> > >
> > > The last time I checked there were hundreds of ways to allocate
> > > arbitrary amounts of memory without any restrictions by any user. The
> > > example at hand was setting up GB-sized netfilter tables in netns
> > > under userns. It's not subject to ulimit/memcg.
> >
> > That's bad!
> >
> > > Most kmalloc/vmalloc's are not accounted and can be abused.
> >
> > Many of those should be bound to some objects and if those are directly
> > controllable by userspace then we should account at least. And if they
> > are not bound to a process life time then restricted.
> 
> I see you actually added one GFP_ACCOUNT in netfilter in "netfilter:
> x_tables: do not fail xt_alloc_table_info too easilly". But it seems
> there are more:
> 
> $ grep vmalloc\( net/netfilter/*.c
> net/netfilter/nf_tables_api.c: return kvmalloc(alloc, GFP_KERNEL);
> net/netfilter/x_tables.c: xt[af].compat_tab = vmalloc(mem);
> net/netfilter/x_tables.c: mem = vmalloc(len);
> net/netfilter/x_tables.c: info = kvmalloc(sz, GFP_KERNEL_ACCOUNT);
> net/netfilter/xt_hashlimit.c: /* FIXME: don't use vmalloc() here or
> anywhere else -HW */
> net/netfilter/xt_hashlimit.c: hinfo = vmalloc(struct_size(hinfo, hash, size));
> 
> These are not bound to processes/threads as namespaces are orthogonal to tasks.

I cannot really comment on those. This is for networking people to
examine and find out whether they allow an untrusted user to runaway.

> Somebody told me that it's not good to use GFP_ACCOUNT if the
> allocation is not tied to the lifetime of the process. Is it still
> true?

Those are more tricky. Mostly because there is no way to reclaim the
memory once the hard limit is hit. Even the memcg oom killer will not
help much. So a care should be taken when adding GFP_ACCOUNT for those.
On the other hand it would prevent an unbounded allocations at least
so the DoS would be reduced to the hard limited memcg.
-- 
Michal Hocko
SUSE Labs
