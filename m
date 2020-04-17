Return-Path: <SRS0=3W8M=6B=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 9A3EBC2BA2B
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 00:20:08 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 76BF821841
	for <linux-kernel@archiver.kernel.org>; Fri, 17 Apr 2020 00:20:08 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="b7b+mYhR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1728022AbgDQAUC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 16 Apr 2020 20:20:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44694 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S1726245AbgDQAUB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Apr 2020 20:20:01 -0400
Received: from mail-oi1-x243.google.com (mail-oi1-x243.google.com [IPv6:2607:f8b0:4864:20::243])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0865C061A0C
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 17:20:01 -0700 (PDT)
Received: by mail-oi1-x243.google.com with SMTP id k133so568808oih.12
        for <linux-kernel@vger.kernel.org>; Thu, 16 Apr 2020 17:20:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=thOqoeUHNa8nm/nAkMJNqT4+ado+3DKRxJPNfHmOJgE=;
        b=b7b+mYhRh7/JSsY7PVsVxFpRfDl9fUnqJhTt41LRlYbLYCyeEJ8oJESMkG9A7xhLq8
         qqDFRibQ52QZC+t9zDTS/ueyEbIQ9r7dyjCmKqNTpk8VMJUKfSn9jYWU3/iPYB/JgxEP
         IzBUsHQ4yyTcKtGsi7071Or3Lqyst1OvX2I4kRqjbrAd3KLxYUWE69IAoSzwCX2KIiCq
         kAjLWc8o/dCTkm7IrZCQgDZv6eR0sBywNIEYvD/HRNyBKzZJsxpeVYT0viTVjxUakfLs
         oJax/+ot1j1mY7S/ii+9QBKDSgWMngGkxxghIO2LAefHkibanea+XkqJuxS/Y7cyHWyl
         VXIQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=thOqoeUHNa8nm/nAkMJNqT4+ado+3DKRxJPNfHmOJgE=;
        b=npX1mSox3sDbBKjXzdMV0XQY5alDm5YoExLl5nf3zzpXhAtzkGjbyo2c5Fj5xh/knM
         YQy8isQH/i2bse1ku4kjBYFaKaI1Npze+1YMWARe3AQgCiVYg18EbpIFOlweap1P3dhE
         bVyArt4ROiLmTZeiKvStkg89YhasLULXDnv5G5wD0bmmmU87aAzZdNrzA5bO1yrZIs+F
         czYakCMib+30GDbDJ04yN/35xsH7KKIvqU1PLVPM4SzETgcSyr55WaHR8xf2HFLImv/P
         4y+8jiMbVHo7qJQmEBGlnrOt3tFGEc7KY/Z0GjWBeAjYXvgeSPCOXiImbD1VshM+IiE1
         +E4A==
X-Gm-Message-State: AGi0PuYk+uwJxM0uZjKTsABex4Wxrwar/XrtuUj6LBVfzbicsk3YJL4e
        nL0VyZooi/8jo08wIyqb/UdBjlMRbzI=
X-Google-Smtp-Source: APiQypJHGAhKDQezHjIhhBwZzlYnpkNIUubGrWvHRQLNARJzU245nG0YzeOHyY2Bj6r7A3QGMufHFg==
X-Received: by 2002:a05:6808:d9:: with SMTP id t25mr497092oic.147.1587082800737;
        Thu, 16 Apr 2020 17:20:00 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id q7sm7526189otc.63.2020.04.16.17.19.59
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Thu, 16 Apr 2020 17:20:00 -0700 (PDT)
Date:   Thu, 16 Apr 2020 17:19:43 -0700 (PDT)
From:   Hugh Dickins <hughd@google.com>
X-X-Sender: hugh@eggly.anvils
To:     Yang Shi <shy828301@gmail.com>
cc:     Hugh Dickins <hughd@google.com>,
        syzbot <syzbot+c8a8197c8852f566b9d9@syzkaller.appspotmail.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>, syzkaller-bugs@googlegroups.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: possible deadlock in shmem_uncharge
In-Reply-To: <alpine.LSU.2.11.2004151925320.13357@eggly.anvils>
Message-ID: <alpine.LSU.2.11.2004161718030.16488@eggly.anvils>
References: <000000000000e5838c05a3152f53@google.com> <CAHbLzkpJjpOjizxhG6oS1OsbdycwaRdLeA8nb1R4Y2C4F7nV+g@mail.gmail.com> <alpine.LSU.2.11.2004151828350.12919@eggly.anvils> <CAHbLzko3sFuFC800Mv3b2BiKhaC56TpRri1VCEhKWZMwLBNd4Q@mail.gmail.com>
 <alpine.LSU.2.11.2004151925320.13357@eggly.anvils>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020, Hugh Dickins wrote:
> On Wed, 15 Apr 2020, Yang Shi wrote:
> > On Wed, Apr 15, 2020 at 7:04 PM Hugh Dickins <hughd@google.com> wrote:
> > > On Mon, 13 Apr 2020, Yang Shi wrote:
> > > >
> > > > It looks shmem_uncharge() is just called by __split_huge_page() and
> > > > collapse_file(). The collapse_file() has acquired xa_lock with irq
> > > > disabled before acquiring info->lock, so it is safe.
> > > > __split_huge_page() is called with holding xa_lock with irq enabled,
> > > > but lru_lock is acquired with irq disabled before acquiring xa_lock.
> > > >
> > > > So, it is unnecessary to acquire info->lock with irq disabled in
> > > > shmem_uncharge(). Can syzbot try the below patch?
> > >
> > > But I disagree with the patch below.  You're right that IRQ-disabling
> > > here is unnecessary, given its two callers; but I'm not sure that we
> > > want it to look different from shmem_charge() and all other info->lock
> > > takers; and, more importantly, I don't see how removing the redundant
> > > IRQ-saving below could make it any less liable to deadlock.
> > 
> > Yes, I realized the patch can't suppress the lockdep splat. But,
> > actually I didn't understand how this deadlock could happen because
> > info_lock is acquired with IRQ disabled before acquiring
> > user_shm_lock. So, interrupt can't come in at all if I didn't miss
> > anything.
> 
> I think the story it's trying to tell is this (but, like most of us,
> I do find Mr Lockdep embarrassingly difficult to understand; and I'm
> not much good at drawing race diagrams either):
> 
> CPU0 was in user_shm_unlock(), it's got shmlock_user_lock, then an
> interrupt comes in. It's an endio kind of interrupt, which goes off
> to test_clear_page_writeback(), which wants the xa_lock on i_pages.
> 
> Meanwhile, CPU1 was doing some SysV SHM locking, it's got as far as
> shmem_lock(), it has acquired info->lock, and goes off to user_shm_lock()
> which wants shmlock_user_lock.
> 
> But sadly, CPU2 is splitting a shmem THP, calling shmem_uncharge()
> that wants info->lock while outer level holds xa_lock on i_pages:
> with interrupts properly disabled, but that doesn't help.
> 
> Now, that story doesn't quite hold up as a deadlock, because shmem
> doesn't use writeback tags; and (unless you set shmem_enabled "force")
> I don't think there's a way to get shmem THPs in SysV SHM (and are
> they hole-punchable? maybe through MADV_REMOVE); so it looks like
> we're talking about different inodes.
> 
> But lockdep is right to report it, and more thought might arrive at
> a more convincing scenario.  Anyway, easily fixed and best fixed.
> 
> (But now I think my patch must wait until tomorrow.)

https://lore.kernel.org/lkml/alpine.LSU.2.11.2004161707410.16322@eggly.anvils/
