Return-Path: <SRS0=sqqi=7C=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.9 required=3.0 tests=DKIMWL_WL_HIGH,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,
	SPF_HELO_NONE,SPF_PASS autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 0BE7EC433E0
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:47:22 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id C61C5207D3
	for <linux-kernel@archiver.kernel.org>; Wed, 20 May 2020 18:47:21 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (1024-bit key) header.d=redhat.com header.i=@redhat.com header.b="hl2Fd0li"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726846AbgETSrV (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Wed, 20 May 2020 14:47:21 -0400
Received: from us-smtp-delivery-1.mimecast.com ([205.139.110.120]:44546 "EHLO
        us-smtp-1.mimecast.com" rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org
        with ESMTP id S1726650AbgETSrU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 May 2020 14:47:20 -0400
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1590000438;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=jSG/oozEGBB+wreBtcOAcaklJS2J1XYJf5hXt9QTC0I=;
        b=hl2Fd0liDzoWxhm0jNqiqiV2ESCxTYNGI+qNlypmh4y7BVrBftKSqrGxU8gvPuKCqihK/P
        6S3t14ABDzp5cEEw+0aJS5Ox6Iya+q2yVqhclpDRQ5ZtWhkGd/NJxVBvCyaeeeZa0wnjkH
        2QDLTXj7EjlPFECowEqAc71PI5D+LDI=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) (Using TLS) by relay.mimecast.com with ESMTP id
 us-mta-424-dhM2DisFOkyZ3EHAJxPJCQ-1; Wed, 20 May 2020 14:47:16 -0400
X-MC-Unique: dhM2DisFOkyZ3EHAJxPJCQ-1
Received: by mail-wr1-f71.google.com with SMTP id c14so621344wrm.15
        for <linux-kernel@vger.kernel.org>; Wed, 20 May 2020 11:47:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=jSG/oozEGBB+wreBtcOAcaklJS2J1XYJf5hXt9QTC0I=;
        b=Mn1OUIWvkmvaFvE8iG+0xbQUMkJQYj+OXKhEuGO5HbatFR8GDOHrkYsqCQD8B4XDao
         otHszhkYRzxkBIPDiEvTDZVPxRo7u9wZQr2IZnY92BUd0uGmyZbn/rfxsVfZ7FdBQxtu
         x4Xft7cdM6XB7hHh+7fJTgoAwdIwOvAFlP+I1S1ZbcVve/xLHxDRvAB4uiIeeRb73vXH
         DRXAzi/x0PZtFxvq0jj6g4uo13sksGBAgrtNXNN6tnxBhsR8vuvVGO7cq3mTiKx3XLwe
         siwz3n9jLHUKF8LKHA0lqKzob8EIvTaYUqdd/lzdz0h7q/pxsknX0jiRFq12GB5sL5Sa
         MuTA==
X-Gm-Message-State: AOAM5319E+BIx0TU0KnmhkojIE07sePdoGSB+gl80njEdKeoKk3YdaQM
        IHKb0PRgkq9txgQx9T7Z31KinUt7QXWAvu8jZ3+36jACJ+WZ8q/dMr37ESCt/GIpC2Ww0jYDIMd
        7awmHcVU0W6qgDrD69MxXYYGK
X-Received: by 2002:adf:e707:: with SMTP id c7mr1623845wrm.131.1590000434925;
        Wed, 20 May 2020 11:47:14 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx/444M6gu2lvxnsKEHp57G+dEY7Zs3tO1KVHc9YAOP3hFZ7wUijx67VIx/qTzNLIBRBH2vFA==
X-Received: by 2002:adf:e707:: with SMTP id c7mr1623828wrm.131.1590000434600;
        Wed, 20 May 2020 11:47:14 -0700 (PDT)
Received: from localhost.localdomain ([151.68.137.74])
        by smtp.gmail.com with ESMTPSA id j2sm3642693wrp.47.2020.05.20.11.47.13
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 May 2020 11:47:13 -0700 (PDT)
Date:   Wed, 20 May 2020 20:47:10 +0200
From:   Juri Lelli <juri.lelli@redhat.com>
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     fweisbec@gmail.com, tglx@linutronix.de, mingo@kernel.org,
        linux-rt-users@vger.kernel.org, peterz@infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH] tick/sched: update full_nohz status after SCHED dep
 is cleared
Message-ID: <20200520184710.GO10078@localhost.localdomain>
References: <20200520140402.358880-1-juri.lelli@redhat.com>
 <20200520162400.GA8800@lenoir>
 <20200520164925.GM10078@localhost.localdomain>
 <20200520170215.GB8800@lenoir>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20200520170215.GB8800@lenoir>
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 20/05/20 19:02, Frederic Weisbecker wrote:
> On Wed, May 20, 2020 at 06:49:25PM +0200, Juri Lelli wrote:
> > On 20/05/20 18:24, Frederic Weisbecker wrote:
> > 
> > Hummm, so I enabled 'timer:*', anything else you think I should be
> > looking at?
> 
> Are you sure you also enabled timer_expire_entry?
> Because:

I run with

trace-cmd record -e sched_switch -e sched_wakeup -e sched_migrate_task \
-e 'timer:*' -e 'irq_vectors:*' -e 'irq:softirq*' \
-e 'irq:irq_handler*' taskset --cpu-list 4-35 ./sysjitter/sysjitter \
--runtime 10 200

And

$ grep ' timer_expire_entry:' trace.txt | wc -l
1173

seems to confirm that the event was indeed enabled, e.g.

ksoftirqd/11-100   [011]   159.270023: timer_expire_entry:   timer=0xffff9807df8a5a60 function=delayed_work_timer_fn now=4294826418 baseclk=4294825984

> 
> > 
> > ...
> > ksoftirqd/13-117   [013]   148.265945: softirq_entry:        vec=1 [action=TIMER]
> 
> ...the timer softirq keep triggering without any timer callback executed. If that's the
> case, we may be dealing with an interesting issue.
> 
> Thanks.
> 
> > ksoftirqd/13-117   [013]   148.265947: softirq_exit:         vec=1 [action=TIMER]
> > ksoftirqd/13-117   [013]   148.265948: softirq_entry:        vec=7 [action=SCHED]
> > ksoftirqd/13-117   [013]   148.265950: softirq_exit:         vec=7 [action=SCHED]
> > ksoftirqd/13-117   [013]   148.265952: sched_switch:         ksoftirqd/13:117 [120] S ==> sysjitter:2536 [120]
> >    sysjitter-2536  [013]   148.266912: local_timer_entry:    vector=236
> >    sysjitter-2536  [013]   148.266914: hrtimer_cancel:       hrtimer=0xffff9807df91bee0
> >    sysjitter-2536  [013]   148.266916: hrtimer_expire_entry: hrtimer=0xffff9807df91bee0 now=148249107837 function=tick_sched_timer/0x0
> >    sysjitter-2536  [013]   148.266918: softirq_raise:        vec=1 [action=TIMER]
> >    sysjitter-2536  [013]   148.266920: softirq_raise:        vec=7 [action=SCHED]
> >    sysjitter-2536  [013]   148.266922: hrtimer_expire_exit:  hrtimer=0xffff9807df91bee0
> >    sysjitter-2536  [013]   148.266924: hrtimer_start:        hrtimer=0xffff9807df91bee0 function=tick_sched_timer/0x0 expires=148250105422 softexpires=148250105422
> >    sysjitter-2536  [013]   148.266926: local_timer_exit:     vector=236
> >    sysjitter-2536  [013]   148.266930: sched_wakeup:         ksoftirqd/13:117 [120] success=1 CPU:013
> >    sysjitter-2536  [013]   148.266932: tick_stop:            success=0 dependency=SCHED
> >    sysjitter-2536  [013]   148.266934: irq_work_entry:       vector=246
> >    sysjitter-2536  [013]   148.266936: irq_work_exit:        vector=246
> >    sysjitter-2536  [013]   148.266937: tick_stop:            success=0 dependency=SCHED
> >    sysjitter-2536  [013]   148.266940: sched_switch:         sysjitter:2536 [120] R ==> ksoftirqd/13:117 [120]
> > ksoftirqd/13-117   [013]   148.266943: softirq_entry:        vec=1 [action=TIMER]
> > ksoftirqd/13-117   [013]   148.266946: softirq_exit:         vec=1 [action=TIMER]
> > ksoftirqd/13-117   [013]   148.266946: softirq_entry:        vec=7 [action=SCHED]
> > ksoftirqd/13-117   [013]   148.266948: softirq_exit:         vec=7 [action=SCHED]
> > ksoftirqd/13-117   [013]   148.266950: sched_switch:         ksoftirqd/13:117 [120] S ==> sysjitter:2536 [120]
> >    sysjitter-2536  [013]   148.267912: local_timer_entry:    vector=236
> >    sysjitter-2536  [013]   148.267914: hrtimer_cancel:       hrtimer=0xffff9807df91bee0
> >    sysjitter-2536  [013]   148.267916: hrtimer_expire_entry: hrtimer=0xffff9807df91bee0 now=148250107750 function=tick_sched_timer/0x0
> >    sysjitter-2536  [013]   148.267918: softirq_raise:        vec=1 [action=TIMER]
> >    sysjitter-2536  [013]   148.267920: softirq_raise:        vec=7 [action=SCHED]
> >    sysjitter-2536  [013]   148.267922: hrtimer_expire_exit:  hrtimer=0xffff9807df91bee0
> >    sysjitter-2536  [013]   148.267924: hrtimer_start:        hrtimer=0xffff9807df91bee0 function=tick_sched_timer/0x0 expires=148251105422 softexpires=148251105422
> >    sysjitter-2536  [013]   148.267926: local_timer_exit:     vector=236
> >    sysjitter-2536  [013]   148.267929: sched_wakeup:         ksoftirqd/13:117 [120] success=1 CPU:013
> >    sysjitter-2536  [013]   148.267931: tick_stop:            success=0 dependency=SCHED
> >    sysjitter-2536  [013]   148.267934: irq_work_entry:       vector=246
> >    sysjitter-2536  [013]   148.267936: irq_work_exit:        vector=246
> >    sysjitter-2536  [013]   148.267937: tick_stop:            success=0 dependency=SCHED
> >    sysjitter-2536  [013]   148.267940: sched_switch:         sysjitter:2536 [120] R ==> ksoftirqd/13:117 [120]
> > ksoftirqd/13-117   [013]   148.267943: softirq_entry:        vec=1 [action=TIMER]
> > ksoftirqd/13-117   [013]   148.267945: softirq_exit:         vec=1 [action=TIMER]
> > ksoftirqd/13-117   [013]   148.267946: softirq_entry:        vec=7 [action=SCHED]
> > ksoftirqd/13-117   [013]   148.267947: softirq_exit:         vec=7 [action=SCHED]
> > ksoftirqd/13-117   [013]   148.267949: sched_switch:         ksoftirqd/13:117 [120] S ==> sysjitter:2536 [120]
> >    sysjitter-2536  [013]   148.268865: call_function_single_entry: vector=251
> >    sysjitter-2536  [013]   148.268867: call_function_single_exit: vector=251
> >    sysjitter-2536  [013]   148.268870: tick_stop:            success=1 dependency=NONE
> >    sysjitter-2536  [013]   148.268872: hrtimer_cancel:       hrtimer=0xffff9807df91bee0
> >    sysjitter-2536  [013]   148.268876: call_function_single_entry: vector=251
> >    sysjitter-2536  [013]   148.268878: call_function_single_exit: vector=251
> > ...
> > 
> > it looks like tick sched timer is kept armed until tick_stop
> > succedes (because of the check performed after _single_exit)?
> > 
> > Thanks for your quick reply!
> > 
> 

