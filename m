Return-Path: <SRS0=29cB=4T=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,
	MAILING_LIST_MULTI,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS autolearn=unavailable
	autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 8E43EC3F2D1
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:33:39 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 5B204246B4
	for <linux-kernel@archiver.kernel.org>; Mon,  2 Mar 2020 07:33:39 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="TtZmHYRh"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726758AbgCBHdi (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 2 Mar 2020 02:33:38 -0500
Received: from us-smtp-2.mimecast.com ([207.211.31.81]:30298 "EHLO
        us-smtp-delivery-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1725446AbgCBHdh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 Mar 2020 02:33:37 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1583134416;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=f/0vJrA0gSRXpSGqk2auYaBWDuiqdzsus4s2o4cmNQw=;
        b=TtZmHYRhXikv9HEKl9voE/A7Uich/dMq71dDFXESLbbuPQsOq+QqkTVYRNpKe3M34mD46C
        vPDptrhynQJbOeMNJbaEwiyAbGuW/By6vUxOUhydVab2JGFOsM/fBx+4Rlfo0q6eR02S6B
        vPEHNOYpOXWJFS1V/I+ftFTQhtaPLQM=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-465-Xu9wmJbdN0aVu9qOt9lCnw-1; Mon, 02 Mar 2020 02:33:35 -0500
X-MC-Unique: Xu9wmJbdN0aVu9qOt9lCnw-1
Received: by mail-wm1-f72.google.com with SMTP id g26so1652474wmk.6
        for <linux-kernel@vger.kernel.org>; Sun, 01 Mar 2020 23:33:35 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=f/0vJrA0gSRXpSGqk2auYaBWDuiqdzsus4s2o4cmNQw=;
        b=Q+gphpAAB8b3Y1R+zpLKU2s+zvGQDf0OWk/2rEXJbAletTjqCe/O6mwEF8Xg8JHpSC
         iiet61bOSD/hQAfZiO0Ija15NSnWGUrDSBTNZDmSq/+wgkhCK0MdGzRZdpAegnTRcY6z
         pCNaGYbKLQh921z08GpykdP1onWAulkYoZsPEQO3xz7ZKyt1e4Fbw7GFXTIh9iRVHllH
         /PIyXK7BNfzaoquM2EjoMM86eYpPutLX+zjY1ZWlfz+qlB9gfDgUkikkN1IH7DtKBynj
         hbbWilMyVmjlZii9vpZ/rr2MzFnoUenBaJrC74CKqNFyUDOAQ6RiosxylTpNtjyh3wBr
         bXWw==
X-Gm-Message-State: APjAAAWjNbfwd1XlKIwqUAH/5g1lBFK33kak7rsyF4r3g4iMcpXP2zAm
        DSoPnhPnlBZC1Ojju0DbVeGbdk1Vid40drSyBwymMca1PSKDK9khLwvffh/6mCFbAr0KIZr3YgF
        UAA/+IQL7ZzwympX/Aum0YlYp
X-Received: by 2002:a5d:4a10:: with SMTP id m16mr13624760wrq.333.1583134414204;
        Sun, 01 Mar 2020 23:33:34 -0800 (PST)
X-Google-Smtp-Source: APXvYqz/RlDZ/wAqfk74aj3rp7qtdfZnYqBJ07tcCbHIfQ3JwdzeVvOLfYGeLgpyzPQWX+NFfQSKtw==
X-Received: by 2002:a5d:4a10:: with SMTP id m16mr13624728wrq.333.1583134413960;
        Sun, 01 Mar 2020 23:33:33 -0800 (PST)
Received: from localhost (nat-pool-brq-t.redhat.com. [213.175.37.10])
        by smtp.gmail.com with ESMTPSA id c4sm14145502wml.7.2020.03.01.23.33.32
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 01 Mar 2020 23:33:33 -0800 (PST)
Date:   Mon, 2 Mar 2020 08:33:32 +0100
From:   Oleksandr Natalenko <oleksandr@redhat.com>
To:     Suren Baghdasaryan <surenb@google.com>
Cc:     Minchan Kim <minchan@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>, linux-api@vger.kernel.org,
        Tim Murray <timmurray@google.com>,
        Daniel Colascione <dancol@google.com>,
        Sandeep Patil <sspatil@google.com>,
        Sonny Rao <sonnyrao@google.com>,
        Brian Geffon <bgeffon@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Shakeel Butt <shakeelb@google.com>,
        John Dias <joaodias@google.com>,
        Joel Fernandes <joel@joelfernandes.org>, sj38.park@gmail.com,
        alexander.h.duyck@linux.intel.com, Jann Horn <jannh@google.com>
Subject: Re: [PATCH v6 6/7] mm/madvise: employ mmget_still_valid for write
 lock
Message-ID: <20200302073332.gn7lvhxmmv5pupyq@butterfly.localdomain>
References: <20200219014433.88424-1-minchan@kernel.org>
 <20200219014433.88424-7-minchan@kernel.org>
 <CAJuCfpE=7aqwegMb5i3EwWb=xcphXSNE33dCCUvt=WS0Sr-wfg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAJuCfpE=7aqwegMb5i3EwWb=xcphXSNE33dCCUvt=WS0Sr-wfg@mail.gmail.com>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello.

On Fri, Feb 28, 2020 at 03:19:55PM -0800, Suren Baghdasaryan wrote:
> On Tue, Feb 18, 2020 at 5:44 PM Minchan Kim <minchan@kernel.org> wrote:
> >
> > From: Oleksandr Natalenko <oleksandr@redhat.com>
> >
> > Do the very same trick as we already do since 04f5866e41fb. KSM hints
> > will require locking mmap_sem for write since they modify vm_flags, so
> > for remote KSM hinting this additional check is needed.
> >
> > Signed-off-by: Oleksandr Natalenko <oleksandr@redhat.com>
> > Signed-off-by: Minchan Kim <minchan@kernel.org>
> > ---
> >  mm/madvise.c | 3 +++
> >  1 file changed, 3 insertions(+)
> >
> > diff --git a/mm/madvise.c b/mm/madvise.c
> > index f6d9b9e66243..c55a18fe71f9 100644
> > --- a/mm/madvise.c
> > +++ b/mm/madvise.c
> > @@ -1118,6 +1118,8 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
> >         if (write) {
> >                 if (down_write_killable(&mm->mmap_sem))
> >                         return -EINTR;
> > +               if (current->mm != mm && !mmget_still_valid(mm))
> 
> mmget_still_valid() seems pretty light-weight, so why not just use
> that without checking that the mm belongs to the current process
> first?

I'd keep the checks separate to a) do not functionally change current->mm
== mm case; b) clearly separate the intention to call
mmget_still_valid() only for remote access (using mmget_still_valid()
for current->mm == mm does not make any sense here, IMO, since there's
no possibility of expecting a core dump at this point); c) ease the job for
reviewer once mmget_still_valid() is scheduled to be removed (I hope it
eventually goes away indeed).

> 
> > +                       goto skip_mm;
> >         } else {
> >                 down_read(&mm->mmap_sem);
> >         }
> > @@ -1169,6 +1171,7 @@ int do_madvise(struct task_struct *target_task, struct mm_struct *mm,
> >         }
> >  out:
> >         blk_finish_plug(&plug);
> > +skip_mm:
> >         if (write)
> >                 up_write(&mm->mmap_sem);
> >         else
> > --
> > 2.25.0.265.gbab2e86ba0-goog
> >
> 

-- 
  Best regards,
    Oleksandr Natalenko (post-factum)
    Principal Software Maintenance Engineer

