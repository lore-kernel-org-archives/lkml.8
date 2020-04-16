Return-Path: <SRS0=1dCa=6A=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-9.9 required=3.0 tests=DKIMWL_WL_MED,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS,USER_AGENT_SANE_1,USER_IN_DEF_DKIM_WL autolearn=no
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id A4965C2BB55
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 03:05:43 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 7E47B2072D
	for <linux-kernel@archiver.kernel.org>; Thu, 16 Apr 2020 03:05:43 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=google.com header.i=@google.com header.b="Jej/BoUU"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S2389623AbgDPDFm (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 15 Apr 2020 23:05:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-FAIL-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388679AbgDPDFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Apr 2020 23:05:38 -0400
Received: from mail-ot1-x343.google.com (mail-ot1-x343.google.com [IPv6:2607:f8b0:4864:20::343])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06EC2C061A0C
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 20:05:37 -0700 (PDT)
Received: by mail-ot1-x343.google.com with SMTP id i22so1857023otp.12
        for <linux-kernel@vger.kernel.org>; Wed, 15 Apr 2020 20:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20161025;
        h=date:from:to:cc:subject:in-reply-to:message-id:references
         :user-agent:mime-version;
        bh=Ny/fDBkxdwTaLeh6f3A963P77GPd8EJiQrLAHfr4rm0=;
        b=Jej/BoUUORsFXG/s5u/iKEhJ07/whIHtGVhl6gY2G329P86S3wsYUiobQuEyufBtuS
         4B7Vdk+bf/sob5IMhTGnR86uEQtd2I2qQlG7AhF97tSQIjOBuvJUFRxz/JFHnV+C6ama
         auWCfmMYFKc18E6KyxO8DAebV8v8y5ljVjvntmZ8/WgYAaHcJaxp2HSI7ep5WQnO9KmG
         GhGWow/SvKNJrZtnV9cqfAj4wJp4P5/7gBK/mudkZ725HMvosfNmlUuFPHReIqPAN8cz
         HnIp+CERVmmG9l4uKs2mXJds6dqbuTxxJ4aWPtPeaPSb5r+1pvC8CeRaJr1WFMshJ6EJ
         4D/Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:in-reply-to:message-id
         :references:user-agent:mime-version;
        bh=Ny/fDBkxdwTaLeh6f3A963P77GPd8EJiQrLAHfr4rm0=;
        b=gGjwFgE5VauxyXvVPzjLiyQFY5SjOqcMK8l8YRIYO66oN2bc+G5Sa3U7TVS3JFQAmK
         9TWUkjlsjUrKP4FCgXftmiXI5AHjgVQdrXBM5RCpRTXrlY/4SZ4mAdh7ULHOb6WZixre
         rN3XTd8JDIQPoEk76/ed6q087AEw5Lf3qnSA9gNGaLgDKX3KjAZPJdMm4Kckq5hfI3jU
         u2Zd/j+0PDfsVAODUv3cfwbL4i+w2mKkotseOvKaUX8XJt/p3fa5tJkw8Sp4liXNcLjc
         KLrtlUVGBmMOgwiyLXJYJaHLlGeVKSCz8pwZbY9ZkcQfypbo7ekxdNEF9Tboz3WMmBAh
         7fVg==
X-Gm-Message-State: AGi0PuYs4jAIpodpwY28COjO2S3taz69p9Yoxphhe0CTCMPBWm6Xroae
        t8+bLjgBGAjA/hE8lbr6hL0hlQ==
X-Google-Smtp-Source: APiQypJOYybfLvmQj+aPhVTPV4m3mLCrrKqgZ6Dmp2x7ATrdMhQw0iBT13NiGcBJ9UHVu4QYxvlabQ==
X-Received: by 2002:a05:6830:1054:: with SMTP id b20mr9869574otp.19.1587006336936;
        Wed, 15 Apr 2020 20:05:36 -0700 (PDT)
Received: from eggly.attlocal.net (172-10-233-147.lightspeed.sntcca.sbcglobal.net. [172.10.233.147])
        by smtp.gmail.com with ESMTPSA id d84sm6867362oig.33.2020.04.15.20.05.35
        (version=TLS1 cipher=ECDHE-ECDSA-AES128-SHA bits=128/128);
        Wed, 15 Apr 2020 20:05:36 -0700 (PDT)
Date:   Wed, 15 Apr 2020 20:05:13 -0700 (PDT)
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
In-Reply-To: <CAHbLzko3sFuFC800Mv3b2BiKhaC56TpRri1VCEhKWZMwLBNd4Q@mail.gmail.com>
Message-ID: <alpine.LSU.2.11.2004151925320.13357@eggly.anvils>
References: <000000000000e5838c05a3152f53@google.com> <CAHbLzkpJjpOjizxhG6oS1OsbdycwaRdLeA8nb1R4Y2C4F7nV+g@mail.gmail.com> <alpine.LSU.2.11.2004151828350.12919@eggly.anvils> <CAHbLzko3sFuFC800Mv3b2BiKhaC56TpRri1VCEhKWZMwLBNd4Q@mail.gmail.com>
User-Agent: Alpine 2.11 (LSU 23 2013-08-11)
MIME-Version: 1.0
Content-Type: TEXT/PLAIN; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 15 Apr 2020, Yang Shi wrote:
> On Wed, Apr 15, 2020 at 7:04 PM Hugh Dickins <hughd@google.com> wrote:
> > On Mon, 13 Apr 2020, Yang Shi wrote:
> > >
> > > It looks shmem_uncharge() is just called by __split_huge_page() and
> > > collapse_file(). The collapse_file() has acquired xa_lock with irq
> > > disabled before acquiring info->lock, so it is safe.
> > > __split_huge_page() is called with holding xa_lock with irq enabled,
> > > but lru_lock is acquired with irq disabled before acquiring xa_lock.
> > >
> > > So, it is unnecessary to acquire info->lock with irq disabled in
> > > shmem_uncharge(). Can syzbot try the below patch?
> >
> > But I disagree with the patch below.  You're right that IRQ-disabling
> > here is unnecessary, given its two callers; but I'm not sure that we
> > want it to look different from shmem_charge() and all other info->lock
> > takers; and, more importantly, I don't see how removing the redundant
> > IRQ-saving below could make it any less liable to deadlock.
> 
> Yes, I realized the patch can't suppress the lockdep splat. But,
> actually I didn't understand how this deadlock could happen because
> info_lock is acquired with IRQ disabled before acquiring
> user_shm_lock. So, interrupt can't come in at all if I didn't miss
> anything.

I think the story it's trying to tell is this (but, like most of us,
I do find Mr Lockdep embarrassingly difficult to understand; and I'm
not much good at drawing race diagrams either):

CPU0 was in user_shm_unlock(), it's got shmlock_user_lock, then an
interrupt comes in. It's an endio kind of interrupt, which goes off
to test_clear_page_writeback(), which wants the xa_lock on i_pages.

Meanwhile, CPU1 was doing some SysV SHM locking, it's got as far as
shmem_lock(), it has acquired info->lock, and goes off to user_shm_lock()
which wants shmlock_user_lock.

But sadly, CPU2 is splitting a shmem THP, calling shmem_uncharge()
that wants info->lock while outer level holds xa_lock on i_pages:
with interrupts properly disabled, but that doesn't help.

Now, that story doesn't quite hold up as a deadlock, because shmem
doesn't use writeback tags; and (unless you set shmem_enabled "force")
I don't think there's a way to get shmem THPs in SysV SHM (and are
they hole-punchable? maybe through MADV_REMOVE); so it looks like
we're talking about different inodes.

But lockdep is right to report it, and more thought might arrive at
a more convincing scenario.  Anyway, easily fixed and best fixed.

(But now I think my patch must wait until tomorrow.)

Hugh
