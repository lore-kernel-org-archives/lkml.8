Return-Path: <SRS0=DSTS=3V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-5.5 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MALFORMED_FREEMAIL,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=ham
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7FA68C33CB7
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 00:27:14 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 536C020674
	for <linux-kernel@archiver.kernel.org>; Sat,  1 Feb 2020 00:27:14 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="hbioWkVb"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726761AbgBAA1N (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 31 Jan 2020 19:27:13 -0500
Received: from mail-wm1-f66.google.com ([209.85.128.66]:34325 "EHLO
        mail-wm1-f66.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726347AbgBAA1N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 31 Jan 2020 19:27:13 -0500
Received: by mail-wm1-f66.google.com with SMTP id s144so9930471wme.1
        for <linux-kernel@vger.kernel.org>; Fri, 31 Jan 2020 16:27:11 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=from:date:to:cc:subject:in-reply-to:message-id:references
         :mime-version;
        bh=Y+ewkjjQnNvN5AqdkSue50MrVf1Ij6jiDgCKX04Fynw=;
        b=hbioWkVbE5gbqCiBobw0TnFfkGmtTRaPYBNr+a6FNSyw5Q/vhEx6lHAi0t3MJTUWFr
         rr6KXC5cPY+Rhqvjo7W4eoJ7InkyVOhCN0nyUWvXS4SX3Tv/0zvceRAF3i634OEqz9hs
         Dor6MPNAhfxneR8tS4QdBGuyz2QOLVGNignqgHEFQbsMzdNRrtPXUf7hRbkNvEpRjqhq
         Jc7dg4Fecrm11+Ikje5oOaHfkLK/DbhYYZXqJqI35ENi9YQvoI0/Fd7bQXLxCWfKWmve
         d3qfIzvNILGMFiaEg4qre2Nr0arSird4h7ov/GPD0NUuA60S+bnQzPTl98IMmYyUNrDj
         icUQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:from:date:to:cc:subject:in-reply-to:message-id
         :references:mime-version;
        bh=Y+ewkjjQnNvN5AqdkSue50MrVf1Ij6jiDgCKX04Fynw=;
        b=QXXwgj02BYu1O+hApNoFqnpJdLOk5oTjk9S6QxdtLrrJ3AJ/EHW5a4x9FTqGvY/eq9
         hUxPO8L8O2tsEZS8Ps14aGkliVGGE42E6+AvWoNYp/19KJvUuooRDqz1WReTcORjL8mT
         QjL3BF8eIGLC34S5UaLdnI4L8A/fTgVj/wUI2+XYOgeLxmHc/QRc8girSuGZI6wcwVjZ
         SmQgGgi91UE5/0Kg2C5qHitftFu6ZI7xf9lVPeUIJ0WtllqZppOLuDTYMONZOAKDXAs1
         8c+ARpGgre5s4GreTxXwjU4/c0m/SMqrDmkoDUuezcPdAqVauE5OPl5q68b+h/ImjizP
         G0wQ==
X-Gm-Message-State: APjAAAXSpwH+8PlB6gI1SNikNC/BehApdsTJC65/7za93nWb82danUj9
        ZrjL93W+RONo4T7UZ+GKhA==
X-Google-Smtp-Source: APXvYqyB8SvoavmGLtKP3CS3Bfi5Pk9b1qm0X3a/f7l7kU0q5JMP4VTbSMJ5NaeyJYK0uKmSqWtGRw==
X-Received: by 2002:a7b:cc6a:: with SMTP id n10mr14654326wmj.170.1580516831043;
        Fri, 31 Jan 2020 16:27:11 -0800 (PST)
Received: from ninjahub.lan (host-2-102-13-223.as13285.net. [2.102.13.223])
        by smtp.gmail.com with ESMTPSA id m3sm14216772wrs.53.2020.01.31.16.27.05
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 31 Jan 2020 16:27:10 -0800 (PST)
From:   Jules Irenge <jbi.octave@gmail.com>
X-Google-Original-From: Jules Irenge <maxx@ninjahub.org>
Date:   Sat, 1 Feb 2020 00:27:02 +0000 (GMT)
To:     Peter Zijlstra <peterz@infradead.org>
cc:     Jules Irenge <jbi.octave@gmail.com>, boqun.feng@gmail.com,
        Ingo Molnar <mingo@redhat.com>, Will Deacon <will@kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 3/3] mutex: Add missing annotations
In-Reply-To: <20200127085118.GJ14914@hirez.programming.kicks-ass.net>
Message-ID: <alpine.LFD.2.21.2002010020350.3466@ninjahub.org>
References: <0/3> <cover.1579893447.git.jbi.octave@gmail.com> <8e8d93ee2125c739caabe5986f40fa2156c8b4ce.1579893447.git.jbi.octave@gmail.com> <20200127085118.GJ14914@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Thanks for the feedback, I did not have a thorough analyse.

I just realised it. Yes, some warnings generated after are 
pointless others look genuine. Next time I will 
have a thorough analyse and test before sending. 

I apologise for this.  

I really appreciate your feedback.

Kind regards,
Jules

On Mon, 27 Jan 2020, Peter Zijlstra wrote:

> On Fri, Jan 24, 2020 at 08:12:20PM +0000, Jules Irenge wrote:
> > Sparse reports false warnings and hide real warnings
> > where mutex_lock() and mutex_unlock() are used within the kernel
> > An example is within the kernel cgroup files
> > where the below warnings are found
> > |warning: context imbalance in cgroup_lock_and_drain_offline()
> > | - wrong count at exit
> > |warning: context imbalance in cgroup_procs_write_finish()
> > |- wrong count at exit
> > |warning: context imbalance in cgroup_procs_write_start()
> > |- wrong count at exit.
> > 
> > To fix these,
> > an __acquires(lock) is added to mutex_lock() declaration
> > a __releases(lock) to mutex_unlock() declaration
> > 
> > Signed-off-by: Jules Irenge <jbi.octave@gmail.com>
> > ---
> >  include/linux/mutex.h | 4 ++--
> >  1 file changed, 2 insertions(+), 2 deletions(-)
> > 
> > diff --git a/include/linux/mutex.h b/include/linux/mutex.h
> > index aca8f36dfac9..a8ab4029913e 100644
> > --- a/include/linux/mutex.h
> > +++ b/include/linux/mutex.h
> > @@ -162,7 +162,7 @@ do {									\
> >  } while (0)
> >  
> >  #else
> > -extern void mutex_lock(struct mutex *lock);
> > +extern void mutex_lock(struct mutex *lock) __acquires(lock);
> >  extern int __must_check mutex_lock_interruptible(struct mutex *lock);
> >  extern int __must_check mutex_lock_killable(struct mutex *lock);
> >  extern void mutex_lock_io(struct mutex *lock);
> > @@ -181,7 +181,7 @@ extern void mutex_lock_io(struct mutex *lock);
> >   * Returns 1 if the mutex has been acquired successfully, and 0 on contention.
> >   */
> >  extern int mutex_trylock(struct mutex *lock);
> > -extern void mutex_unlock(struct mutex *lock);
> > +extern void mutex_unlock(struct mutex *lock) __releases(lock);
> >  
> >  extern int atomic_dec_and_mutex_lock(atomic_t *cnt, struct mutex *lock);
> 
> *groan*, I despise these sparse things.
> 
> The proposed patch only annotates a tiny part of the mutex interface,
> and will thereby generate a flood of new (pointless) warnings. Worse,
> annotating them all properly will require that __cond_lock() trainwreck.
> 
> 
