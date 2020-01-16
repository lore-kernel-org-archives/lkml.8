Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-2.6 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	USER_AGENT_SANE_1 autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 680EBC33CB1
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 11:51:30 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 32D472073A
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 11:51:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
	s=default; t=1579175490;
	bh=Uysjm6FCzvmwDdMnRuuUbGoLB/N18XLec0jvaEjWjkM=;
	h=Date:From:To:Cc:Subject:References:In-Reply-To:List-ID:From;
	b=aldFu76Edvhv/KyPOrmwrd688z23FlrpOlbruTyVfp4OtnYnPk6Z4oyMNLK+TgSuG
	 xMdFamrwkzoVTkP6gwO6+4GoZ1M+6olLJ1N5fFuvVr+/bysG7VQ/LycRUlNeI0hNd0
	 bA+h/4EmSgKI2CH2q9XTjYSAEqCh0DwU1C4D7JPc=
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726366AbgAPLv2 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 06:51:28 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:51189 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726018AbgAPLv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 06:51:28 -0500
Received: by mail-wm1-f66.google.com with SMTP id a5so3468896wmb.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 03:51:26 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to:user-agent;
        bh=hYwmGm3w13xInJD6NEJGeWujf8MPf8QQ9A7V+Wr5aVo=;
        b=Tz3CS4SVXKWpbEkS4H/4Gfd02hYuhXGj13pdyWtaEQyUdf1l2oZ7JxVxToTJxOhIxb
         /7XqDKhti/Lu4iqdJfIcfEotJfQvdGA80KQAqB35087f0+LAZHwxX0uM5fPKnUZDKhRf
         v3rjB4cFZiHNpgiDFdl38fncSSjLMXcDDSsE62pZxV5zrxwQeOtUs/ar5XqxmYcOGWa1
         ixK6FGEnm4cGNNbmKa+Ht9o87SwZaEgj/6/EUUoIovHh2ABJiI9cF4n1Tl0JNhHOqpQd
         VVEqetg/vn8mcKw/z7ziXE2/RVAFbL/F1lJ35oRW7MgQpbAipGO5sX42hqma8QzdhaE7
         7LzA==
X-Gm-Message-State: APjAAAXF7acc0lshVpj+UPwYmzBhE7tiFyef4eUuD9QVcBSowf3tswNS
        gEEkEgQm+XZ+0mD84VZO+q8=
X-Google-Smtp-Source: APXvYqwa5Y4lsai7TzHGC1APYB1sw7jRfp3hKLaz4b6IBV5KXaAQ3ddLOpt8gvdAhvxj6O+JnyPVmw==
X-Received: by 2002:a7b:c84a:: with SMTP id c10mr5829495wml.157.1579175486124;
        Thu, 16 Jan 2020 03:51:26 -0800 (PST)
Received: from localhost (prg-ext-pat.suse.com. [213.151.95.130])
        by smtp.gmail.com with ESMTPSA id l17sm27756852wro.77.2020.01.16.03.51.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 16 Jan 2020 03:51:24 -0800 (PST)
Date:   Thu, 16 Jan 2020 12:51:23 +0100
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
Message-ID: <20200116115123.GR19428@dhcp22.suse.cz>
References: <20200115055426.vdjwvry44nfug7yy@kili.mountain>
 <d31f6069-bda7-2cdb-b770-0c9cddac7537@suse.cz>
 <CACT4Y+YF9kYEppMMg3oRkeo+OvhMS1hoKT6EqXCv1jRmA2dz3w@mail.gmail.com>
 <20200115150315.GH19428@dhcp22.suse.cz>
 <CACT4Y+Z6xW130JGcZE9X7wDCLamJA_s-STs2imnmW29SzQ-NyQ@mail.gmail.com>
 <20200115190528.GJ19428@dhcp22.suse.cz>
 <CACT4Y+b5HJW9PhjkSZ+L09YqQt08ALCtudHV4m5x5qv+xH-2Yg@mail.gmail.com>
 <20200116073922.GL19428@dhcp22.suse.cz>
 <CACT4Y+aWNQxSMSnHn6ORkBNM2wWp_K6tPxthj=_FmnyOfO5huA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CACT4Y+aWNQxSMSnHn6ORkBNM2wWp_K6tPxthj=_FmnyOfO5huA@mail.gmail.com>
User-Agent: Mutt/1.12.2 (2019-09-21)
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 16-01-20 11:13:09, Dmitry Vyukov wrote:
> On Thu, Jan 16, 2020 at 8:39 AM Michal Hocko <mhocko@kernel.org> wrote:
[...]
> > > $ grep vmalloc\( net/netfilter/*.c
> > > net/netfilter/nf_tables_api.c: return kvmalloc(alloc, GFP_KERNEL);
> > > net/netfilter/x_tables.c: xt[af].compat_tab = vmalloc(mem);
> > > net/netfilter/x_tables.c: mem = vmalloc(len);
> > > net/netfilter/x_tables.c: info = kvmalloc(sz, GFP_KERNEL_ACCOUNT);
> > > net/netfilter/xt_hashlimit.c: /* FIXME: don't use vmalloc() here or
> > > anywhere else -HW */
> > > net/netfilter/xt_hashlimit.c: hinfo = vmalloc(struct_size(hinfo, hash, size));
> > >
> > > These are not bound to processes/threads as namespaces are orthogonal to tasks.
> >
> > I cannot really comment on those. This is for networking people to
> > examine and find out whether they allow an untrusted user to runaway.
> 
> Unless I am missing an elephant in this whole picture, kernel code
> contains 20K+ unaccounted allocations and if I am not mistaken few of
> them were audited and are intentionally unaccounted rather than
> unaccounted just because it's the default. So if we want DoS
> protection, it's really for every kernel developer/maintainer to audit
> and fix these allocation sites. And since we have a unikernel, a
> single unaccounted allocation may compromise the whole kernel. I
> assume we would need something like GFP_UNACCOUNTED to mark audited
> allocations that don't need accounting and then slowly reduce number
> of allocations without both ACCOUNTED and UNACCOUNTED.

This is the original approach which led to all sorts of problems and so
we switched the opt-out to opt-in. Have a look at a9bb7e620efd ("memcg:
only account kmem allocations marked as __GFP_ACCOUNT").
Our protection will never be perfect because that would require to
design the system with the protection in mind.
 
> > > Somebody told me that it's not good to use GFP_ACCOUNT if the
> > > allocation is not tied to the lifetime of the process. Is it still
> > > true?
> >
> > Those are more tricky. Mostly because there is no way to reclaim the
> > memory once the hard limit is hit. Even the memcg oom killer will not
> > help much. So a care should be taken when adding GFP_ACCOUNT for those.
> > On the other hand it would prevent an unbounded allocations at least
> > so the DoS would be reduced to the hard limited memcg.
> 
> What exactly is this care in practice?
> It seems that in a148ce15375fc664ad64762c751c0c2aecb2cafe you just
> added it and the allocation is not tied to the process. At least I
> don't see any explanation as to why that one is safe, while accounting
> other similar allocation is not...

My memory is dim but AFAIR the memcg accounting was compromise between
usability and the whole system stability. Really large tables could be
allocated by untrusted users and that was seen as a _real_ problem. The
previous solution added _some_ protection which led to regressions
even for reasonable cases though. Memcg accounting was deemed as
reasonable middle ground.

The result is that a completely depleted memcg requires an admin
intervention and the admin has to know what to do to tear it down.
Kernel cannot do anything about that. And that is the trickiness I've
had in mind. Listing page tables is something admins can do quite
easily, right? There are many other objects which are much harder to act
about. E.g. what are you going to do with tmpfs mounts? Are you going to
remove them and cause potential data loss? That being said some objects
really have to be limited even before they start consuming memory IMHO.

-- 
Michal Hocko
SUSE Labs
