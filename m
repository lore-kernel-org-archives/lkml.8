Return-Path: <SRS0=LUA0=7L=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-6.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,SIGNED_OFF_BY,
	SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 740E9C433E0
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:59:00 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 4DEBA207BC
	for <linux-kernel@archiver.kernel.org>; Fri, 29 May 2020 14:59:00 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="sJlkUi+7"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727035AbgE2O67 (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Fri, 29 May 2020 10:58:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45050 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726845AbgE2O66 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 May 2020 10:58:58 -0400
Received: from mail-io1-xd42.google.com (mail-io1-xd42.google.com [IPv6:2607:f8b0:4864:20::d42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9341C03E969
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 07:58:58 -0700 (PDT)
Received: by mail-io1-xd42.google.com with SMTP id h10so2628866iob.10
        for <linux-kernel@vger.kernel.org>; Fri, 29 May 2020 07:58:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2ZNUzwRzufpLgGkVy9KUNe/+sjMPvjCspVPkrHqYE34=;
        b=sJlkUi+7C8as4aB3H8Xyz93LVngZU8TobP0/n4EkQU4dUr5DC76iaNtX3alX6D+o2k
         I2dgPzaAp7SY4hQ8oIw+wf8m9kLkOywLe0UPgpyjXG+LxFxE/MpMPPESTHv6RShNQXkP
         t0V5mcqb8s9r4RF6OrFQM2o08dFaGjkvddWqX5EB8IaP4y+uNSVwcET0skQB3+pbopLz
         sfPdn4qLbxbZYSbe2B1L4zXoFCAs2rVWv+p4h5GYhUxoE9Dwr2PL58FmoUwq26Rtp7/Q
         ahuJAjyXqJ6QWTrytx3mUhd627zqNkvR/kT8ERBSIKlwC2HL+WdMMdzZ5WgX/t8Tp9s4
         MnEA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2ZNUzwRzufpLgGkVy9KUNe/+sjMPvjCspVPkrHqYE34=;
        b=qtGzFTpxRWNevu6LpiXvM8a3vH9OUA+g6JYW+TN6e/sQELhrLCWcaTBeAaDAuEvz8g
         6fIhmslW0NL+QlHzi2uNvkKNQKqLxNJUOnUNpGhP+8R7E95hzyEteLNHozbIDxL4V3jX
         LVb4mWYATEbIYdfFM4zEieMgTToOfGzjgrSN8Wai9+I82fMNHsZL5u1HMKicoe/NcvDG
         i7jUe5dnSSvtCP00eoYZ2l+3CWT8Oh8kQ6aHtjaN45XpynIp2jzyGp4IyNvE30dgutCe
         698Nuc6Bx6s0xVf1Dllzu22w4HYla6QLl/VCvaUJNl2hxAdgxkGAmFLg6a6R9oaafxFR
         Vnvg==
X-Gm-Message-State: AOAM531o00sVlD2X0ECB4JhLouQunWLl/q83t1kDzayoYMHvJTsjzgri
        2vPHbSZRtYSAKiMMidquuGUp2KLcufN0Dlu/Un8=
X-Google-Smtp-Source: ABdhPJwXZ7RLA5tjAVRrQrFHDrsyMc7ICRHEw02q9oqrXLQ7VomPRisgweUtlR5Bl8HsC7c4sxURlYML4bGvCqUlrjo=
X-Received: by 2002:a02:95a6:: with SMTP id b35mr7395550jai.40.1590764338028;
 Fri, 29 May 2020 07:58:58 -0700 (PDT)
MIME-Version: 1.0
References: <20200529065903.1758-1-laijs@linux.alibaba.com>
 <20200529065903.1758-3-laijs@linux.alibaba.com> <20200529141425.GB3530656@mtj.duckdns.org>
In-Reply-To: <20200529141425.GB3530656@mtj.duckdns.org>
From:   Lai Jiangshan <jiangshanlai@gmail.com>
Date:   Fri, 29 May 2020 22:58:46 +0800
Message-ID: <CAJhGHyDXrUoOYNMPdqL1ObhCK45LWZj3z7RCjM2KQRKsq5inWg@mail.gmail.com>
Subject: Re: [PATCH 2/4] workqueue: don't check wq->rescuer in rescuer
To:     Tejun Heo <tj@kernel.org>
Cc:     Lai Jiangshan <laijs@linux.alibaba.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 10:14 PM Tejun Heo <tj@kernel.org> wrote:
>
> On Fri, May 29, 2020 at 06:59:00AM +0000, Lai Jiangshan wrote:
> > Now rescuer checks pwq->nr_active before requeues the pwq,
> > it is a more robust check and the rescuer must be still valid.
> >
> > Signed-off-by: Lai Jiangshan <laijs@linux.alibaba.com>
> > ---
> >  kernel/workqueue.c | 23 +++++++++--------------
> >  1 file changed, 9 insertions(+), 14 deletions(-)
> >
> > diff --git a/kernel/workqueue.c b/kernel/workqueue.c
> > index b2b15f1f0c8d..8d017727bfbc 100644
> > --- a/kernel/workqueue.c
> > +++ b/kernel/workqueue.c
> > @@ -248,7 +248,7 @@ struct workqueue_struct {
> >       struct list_head        flusher_overflow; /* WQ: flush overflow list */
> >
> >       struct list_head        maydays;        /* MD: pwqs requesting rescue */
> > -     struct worker           *rescuer;       /* MD: rescue worker */
> > +     struct worker           *rescuer;       /* I: rescue worker */
> >
> >       int                     nr_drainers;    /* WQ: drain in progress */
> >       int                     saved_max_active; /* WQ: saved pwq max_active */
> > @@ -2532,12 +2532,13 @@ static int rescuer_thread(void *__rescuer)
> >                       if (pwq->nr_active && need_to_create_worker(pool)) {
> >                               spin_lock(&wq_mayday_lock);
> >                               /*
> > -                              * Queue iff we aren't racing destruction
> > -                              * and somebody else hasn't queued it already.
> > +                              * Queue iff somebody else hasn't queued it
> > +                              * already.
> >                                */
> > -                             if (wq->rescuer && list_empty(&pwq->mayday_node)) {
> > +                             if (list_empty(&pwq->mayday_node)) {
> >                                       get_pwq(pwq);
> > -                                     list_add_tail(&pwq->mayday_node, &wq->maydays);
> > +                                     list_add_tail(&pwq->mayday_node,
> > +                                                   &wq->maydays);
>
> send_mayday() also checks for wq->rescuer, so when sanity check fails,
> scenarios which would have leaked a workqueue after destroying its rescuer
> can lead to use-after-free after the patch. I'm not quite sure why the patch
> is an improvement.
>

Hi

I'm not sure I understood your words. And I'm not
sure which function may use freed object in "use-after-free".
Is it "send_mayday() may use a freed rescuer"?

This patch relies on
def98c84b6 ("workqueue: Fix spurious sanity check failures in
destroy_workqueue()")
to move the kthread_stop() before the sanity check and the work
of drain_workqueue() which guarantees there is no work item
in the workqueue. If send_mayday() still goes wrong after
drain_workqueue(), the user must have queued work items and
invoked destroy_workqueue() concurrently. It is excellent
if the sanity check can find this case out, but it is not possible
that the sanity check can always live through it since it is
not worqueue's internal fault. We hope the sanity check can
find all the internal fault, but not to the extend that
it can always work when any user uses it in a very wrong way.

Thanks
Lai.
