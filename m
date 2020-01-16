Return-Path: <SRS0=CsDi=3F=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-8.4 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_IN_DEF_DKIM_WL autolearn=no autolearn_force=no
	version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A9B4DC33CB6
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 12:41:54 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 74919214AF
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Jan 2020 12:41:54 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="HzD292mX"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726535AbgAPMlx (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Jan 2020 07:41:53 -0500
Received: from mail-qt1-f195.google.com ([209.85.160.195]:34679 "EHLO
        mail-qt1-f195.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726082AbgAPMlx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jan 2020 07:41:53 -0500
Received: by mail-qt1-f195.google.com with SMTP id 5so18727681qtz.1
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jan 2020 04:41:52 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=66dhlEQDrHSjOUhcN0J+RlWrYRnqNftWeH9/h19zJqE=;
        b=HzD292mXDA4Uc2YDOUBTPcMfo/4DPQYugXWdaX0Yi9oDHGyOawgFsfjrJnciVl53XG
         N/9xPwd7/xURu9rmTLDJ4o7iFkqwmWgcuq4WYfZ7YWsfe5+ncb/gbF8lwtiWczyS8pBE
         zFWGWhiIKaA49W3q/ddLP/gfrcaEY1MVHagHGUtJrxZynWAisjz/nIbhKttj/05Jtp7N
         mTX82v4s8OHRSyQOUfg8kWJR8F8AhDaJBZKx+s7xccailZvaTFfr5jgqFNLYjrhIsJEn
         We4p5fcrx7UXVIVCV/VoQLn9rE/DWbO0xYR0YVtTKPuyggnVxBVsFrD7mvl4uXAicqQZ
         0EOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=66dhlEQDrHSjOUhcN0J+RlWrYRnqNftWeH9/h19zJqE=;
        b=ZUNQP2M/euK47AZhgVtyVkPvx74k9n2SHD6n1MDe6FiVp9tclqxjZSRvcWc2Nv3/cq
         UPYIYSvra4d2UWasMzyHXw50VTVQrsL+2fpR1t/AAfW47ZcDWaP5pik2CAVF3niWlth4
         u9TEDcbjBiIH6bdU7lih62Jf93xQF99Tr6WJ2j8I6BzuNYoQ1SWA+NDBPmmAKmq/NO6v
         cp2bqGEJFy4C7K9IgWP7mDVcpeXcdinIABiJybmRgUDEAlVAnlQm0JmovFGtORhroJ0H
         Zq1zwMGttpd9Kv1TsRwYjm9tJIpmf3CLGwmj4sw2Y7Yxx/qJPxzPUrmxIPOwVOAtK1bz
         5rFg==
X-Gm-Message-State: APjAAAXHAQXcH0qaakU82mLR450LKhaACp5GtwsdKpncyI5afTpfVJ01
        rNyQcFdwt5zSCbpPRbn+KJ4+szn3SZL33tjx1qtt0Q==
X-Google-Smtp-Source: APXvYqxlejRZxmLuXJnWJ9cauttbfHc/ZXgeSpho6vFMKkro/9rq9op8xw3jfRMleIFBY5zU+IuVxq4wfSxhn1I8kRc=
X-Received: by 2002:aed:2465:: with SMTP id s34mr2116794qtc.158.1579178511854;
 Thu, 16 Jan 2020 04:41:51 -0800 (PST)
MIME-Version: 1.0
References: <20200115055426.vdjwvry44nfug7yy@kili.mountain>
 <d31f6069-bda7-2cdb-b770-0c9cddac7537@suse.cz> <CACT4Y+YF9kYEppMMg3oRkeo+OvhMS1hoKT6EqXCv1jRmA2dz3w@mail.gmail.com>
 <20200115150315.GH19428@dhcp22.suse.cz> <CACT4Y+Z6xW130JGcZE9X7wDCLamJA_s-STs2imnmW29SzQ-NyQ@mail.gmail.com>
 <20200115190528.GJ19428@dhcp22.suse.cz> <CACT4Y+b5HJW9PhjkSZ+L09YqQt08ALCtudHV4m5x5qv+xH-2Yg@mail.gmail.com>
 <20200116073922.GL19428@dhcp22.suse.cz> <CACT4Y+aWNQxSMSnHn6ORkBNM2wWp_K6tPxthj=_FmnyOfO5huA@mail.gmail.com>
 <20200116115123.GR19428@dhcp22.suse.cz>
In-Reply-To: <20200116115123.GR19428@dhcp22.suse.cz>
From:   Dmitry Vyukov <dvyukov@google.com>
Date:   Thu, 16 Jan 2020 13:41:39 +0100
Message-ID: <CACT4Y+b_ybuMRJBtqFnttTv+vfNVKivUH-UmhHtuHh06tVxB_g@mail.gmail.com>
Subject: Re: [PATCH] mm/mempolicy.c: Fix out of bounds write in mpol_parse_str()
To:     Michal Hocko <mhocko@kernel.org>
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
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 16, 2020 at 12:51 PM Michal Hocko <mhocko@kernel.org> wrote:
>
> On Thu 16-01-20 11:13:09, Dmitry Vyukov wrote:
> > On Thu, Jan 16, 2020 at 8:39 AM Michal Hocko <mhocko@kernel.org> wrote:
> [...]
> > > > $ grep vmalloc\( net/netfilter/*.c
> > > > net/netfilter/nf_tables_api.c: return kvmalloc(alloc, GFP_KERNEL);
> > > > net/netfilter/x_tables.c: xt[af].compat_tab = vmalloc(mem);
> > > > net/netfilter/x_tables.c: mem = vmalloc(len);
> > > > net/netfilter/x_tables.c: info = kvmalloc(sz, GFP_KERNEL_ACCOUNT);
> > > > net/netfilter/xt_hashlimit.c: /* FIXME: don't use vmalloc() here or
> > > > anywhere else -HW */
> > > > net/netfilter/xt_hashlimit.c: hinfo = vmalloc(struct_size(hinfo, hash, size));
> > > >
> > > > These are not bound to processes/threads as namespaces are orthogonal to tasks.
> > >
> > > I cannot really comment on those. This is for networking people to
> > > examine and find out whether they allow an untrusted user to runaway.
> >
> > Unless I am missing an elephant in this whole picture, kernel code
> > contains 20K+ unaccounted allocations and if I am not mistaken few of
> > them were audited and are intentionally unaccounted rather than
> > unaccounted just because it's the default. So if we want DoS
> > protection, it's really for every kernel developer/maintainer to audit
> > and fix these allocation sites. And since we have a unikernel, a
> > single unaccounted allocation may compromise the whole kernel. I
> > assume we would need something like GFP_UNACCOUNTED to mark audited
> > allocations that don't need accounting and then slowly reduce number
> > of allocations without both ACCOUNTED and UNACCOUNTED.
>
> This is the original approach which led to all sorts of problems and so
> we switched the opt-out to opt-in. Have a look at a9bb7e620efd ("memcg:
> only account kmem allocations marked as __GFP_ACCOUNT").
> Our protection will never be perfect because that would require to
> design the system with the protection in mind.

I don't mean to switch the default. I mean adding a way to distinguish
between reviewed and intentionally unaccounted allocation and
unreviewed allocation which is unaccounted just because that's the
default. This would allow to progress incrementally, rather than redo
the same work again and again.

> > > > Somebody told me that it's not good to use GFP_ACCOUNT if the
> > > > allocation is not tied to the lifetime of the process. Is it still
> > > > true?
> > >
> > > Those are more tricky. Mostly because there is no way to reclaim the
> > > memory once the hard limit is hit. Even the memcg oom killer will not
> > > help much. So a care should be taken when adding GFP_ACCOUNT for those.
> > > On the other hand it would prevent an unbounded allocations at least
> > > so the DoS would be reduced to the hard limited memcg.
> >
> > What exactly is this care in practice?
> > It seems that in a148ce15375fc664ad64762c751c0c2aecb2cafe you just
> > added it and the allocation is not tied to the process. At least I
> > don't see any explanation as to why that one is safe, while accounting
> > other similar allocation is not...
>
> My memory is dim but AFAIR the memcg accounting was compromise between
> usability and the whole system stability. Really large tables could be
> allocated by untrusted users and that was seen as a _real_ problem. The
> previous solution added _some_ protection which led to regressions
> even for reasonable cases though. Memcg accounting was deemed as
> reasonable middle ground.
>
> The result is that a completely depleted memcg requires an admin
> intervention and the admin has to know what to do to tear it down.
> Kernel cannot do anything about that. And that is the trickiness I've
> had in mind. Listing page tables is something admins can do quite
> easily, right? There are many other objects which are much harder to act
> about. E.g. what are you going to do with tmpfs mounts? Are you going to
> remove them and cause potential data loss? That being said some objects
> really have to be limited even before they start consuming memory IMHO.

Interesting. But there is really no admin today, or at least nothing
should rely on one in any way. Either because of the scale (you have
thousands/millions of machines and spending human time on each of them
individually is not going to fly) and/or because there is nobody
qualified enough around (e.g. who is an admin of a median android
phone? and what does they know about tearing down namespaces and
mounts) or there is nobody interested enough (it's fun sometimes, but
not always)... but I agree that retrofitting this level of resource
control into a large existing complex system is close to impossible.

Thank a lot for bearing with me and answering my questions. I have a
better understanding of this now.
