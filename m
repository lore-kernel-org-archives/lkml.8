Return-Path: <SRS0=gGKB=AY=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-15.1 required=3.0 tests=BAYES_00,DKIM_SIGNED,
	DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,INCLUDES_PATCH,MAILING_LIST_MULTI,
	MENTIONS_GIT_HOSTING,SIGNED_OFF_BY,SPF_HELO_NONE,SPF_PASS,URIBL_BLOCKED
	autolearn=unavailable autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id D166FC433E0
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:32:37 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id A1FE82067D
	for <linux-kernel@archiver.kernel.org>; Mon, 13 Jul 2020 06:32:37 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Tc6qMqUS"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1729013AbgGMGcg (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 13 Jul 2020 02:32:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38912 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1725804AbgGMGcf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jul 2020 02:32:35 -0400
Received: from mail-wm1-x344.google.com (mail-wm1-x344.google.com [IPv6:2a00:1450:4864:20::344])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD0ABC061794
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:32:35 -0700 (PDT)
Received: by mail-wm1-x344.google.com with SMTP id 17so11977753wmo.1
        for <linux-kernel@vger.kernel.org>; Sun, 12 Jul 2020 23:32:35 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=QPb+Ou4Nfbq4PIi1UZykCwKUnQ4n6w1QsHNkKepASo0=;
        b=Tc6qMqUSO9yd+No46p+3VZaiCkQz7TQoaa22nRESfECs3FcRYRYWx5jNliEHlP+zNF
         IMvTogJaSYmij/+yfydYGi+rNp9UTz64flg38oVBRgVFRKC1kSUNqQ0Ko4WjTwTimMsI
         dtgjceO895GYTE8QT3BEKwUj8jY/e996chWgQ46DVMsdXU7oJNAATnKyp4E7Bap2V8h9
         J18/cGH/b7LhMkB2rFeYqMEkDdgBX59fzkMltQLmVaiGrUTEy67lOban27BiG7iSwHT3
         vk8xP9TK4z+jdbr7OVW/awV8Xcxuq7bNnO2oh51ql4howEUmOPsNi/w6NrFkyZ5ZvmS8
         2JDA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=QPb+Ou4Nfbq4PIi1UZykCwKUnQ4n6w1QsHNkKepASo0=;
        b=TLcmxV5ArrfUxJNgkwHdlfaVwmoStRv9iq0KR57IZi4KF3ARqVkJCEoZWQNcZ3Kulg
         b899GeSa9KkOFwLliRugI2mqSy+/PPh2RudsTNpikpcGfE5tmZIOR10O+lwrxeyZ1lBo
         GrkalSzl7wFJToLsrqg9hz0Db+GD3yBpzfXY+XGiHxjq/eYlSbrAIoQhhwGcLZMRFydU
         fm/h/V53LUeC4M7u5IHMRlIpTxQewVZ1JRbzUKSIAmcL+3yxEFvRbX1KP54Oif8M7+Bs
         M/1srcWU0K07Op5XwX96vCQpXZrlhLKesdRqlzqzpqqxPsWZRQZFo8LHCJdDKo+T+Rmu
         nKDQ==
X-Gm-Message-State: AOAM531I1cU/YEasmZeVk+NO4L+wDnsLIzn14CuB5TigFheFY+LD4hQa
        nfoCmiuj55rkkGZRX95zf/d/QEx8y9VuCNWlYxM=
X-Google-Smtp-Source: ABdhPJwtmLkoBDFIQzDYJKb3x7imJR9/4fT8sbqz0NflsoC92ZNtel0WsaIODvDBCqb6eUTNh09dKdSGkvFcLp4fFb0=
X-Received: by 2002:a1c:2602:: with SMTP id m2mr18229896wmm.50.1594621954326;
 Sun, 12 Jul 2020 23:32:34 -0700 (PDT)
MIME-Version: 1.0
References: <CAKGbVbtYusvURFcUyQtgUycNJPAQyDGDaLXW8qw-x49DqfKmQA@mail.gmail.com>
 <20200619075900.3030696-1-andrey.lebedev@gmail.com> <bd4370f5-6fb4-d32f-5ca4-02e56526f47d@gmail.com>
In-Reply-To: <bd4370f5-6fb4-d32f-5ca4-02e56526f47d@gmail.com>
From:   Qiang Yu <yuq825@gmail.com>
Date:   Mon, 13 Jul 2020 14:32:23 +0800
Message-ID: <CAKGbVbt3ahDqYNC3jCYe19A2PmEk6iS9bT44XPfr0gfWoWjHjA@mail.gmail.com>
Subject: Re: [PATCH] drm/lima: Expose job_hang_limit module parameter
To:     Andrey Lebedev <andrey.lebedev@gmail.com>
Cc:     David Airlie <airlied@linux.ie>, Daniel Vetter <daniel@ffwll.ch>,
        dri-devel <dri-devel@lists.freedesktop.org>,
        lima@lists.freedesktop.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrey Lebedev <andrey@lebedev.lt>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Applied to drm-misc-next:
https://cgit.freedesktop.org/drm/drm-misc/

Sorry for the late response.

Regards,
Qiang

On Tue, Jul 7, 2020 at 12:17 AM Andrey Lebedev <andrey.lebedev@gmail.com> wrote:
>
> Hello guys,
>
> What is the status of this patch? Was this committed to any branch? Is
> it pending for merge to the mainline? Do I have to do anything in order
> to make it mergeable?
>
> On 6/19/20 10:58 AM, Andrey Lebedev wrote:
> > From: Andrey Lebedev <andrey@lebedev.lt>
> >
> > Some pp or gp jobs can be successfully repeated even after they time outs.
> > Introduce lima module parameter to specify number of times a job can hang
> > before being dropped.
> >
> > Signed-off-by: Andrey Lebedev <andrey@lebedev.lt>
> > ---
> >
> > Now all types are correct (uint).
> >
> >   drivers/gpu/drm/lima/lima_drv.c   | 4 ++++
> >   drivers/gpu/drm/lima/lima_drv.h   | 1 +
> >   drivers/gpu/drm/lima/lima_sched.c | 5 +++--
> >   3 files changed, 8 insertions(+), 2 deletions(-)
> >
> > diff --git a/drivers/gpu/drm/lima/lima_drv.c b/drivers/gpu/drm/lima/lima_drv.c
> > index a831565af813..ab460121fd52 100644
> > --- a/drivers/gpu/drm/lima/lima_drv.c
> > +++ b/drivers/gpu/drm/lima/lima_drv.c
> > @@ -19,6 +19,7 @@
> >   int lima_sched_timeout_ms;
> >   uint lima_heap_init_nr_pages = 8;
> >   uint lima_max_error_tasks;
> > +uint lima_job_hang_limit;
> >
> >   MODULE_PARM_DESC(sched_timeout_ms, "task run timeout in ms");
> >   module_param_named(sched_timeout_ms, lima_sched_timeout_ms, int, 0444);
> > @@ -29,6 +30,9 @@ module_param_named(heap_init_nr_pages, lima_heap_init_nr_pages, uint, 0444);
> >   MODULE_PARM_DESC(max_error_tasks, "max number of error tasks to save");
> >   module_param_named(max_error_tasks, lima_max_error_tasks, uint, 0644);
> >
> > +MODULE_PARM_DESC(job_hang_limit, "number of times to allow a job to hang before dropping it (default 0)");
> > +module_param_named(job_hang_limit, lima_job_hang_limit, uint, 0444);
> > +
> >   static int lima_ioctl_get_param(struct drm_device *dev, void *data, struct drm_file *file)
> >   {
> >       struct drm_lima_get_param *args = data;
> > diff --git a/drivers/gpu/drm/lima/lima_drv.h b/drivers/gpu/drm/lima/lima_drv.h
> > index fdbd4077c768..c738d288547b 100644
> > --- a/drivers/gpu/drm/lima/lima_drv.h
> > +++ b/drivers/gpu/drm/lima/lima_drv.h
> > @@ -11,6 +11,7 @@
> >   extern int lima_sched_timeout_ms;
> >   extern uint lima_heap_init_nr_pages;
> >   extern uint lima_max_error_tasks;
> > +extern uint lima_job_hang_limit;
> >
> >   struct lima_vm;
> >   struct lima_bo;
> > diff --git a/drivers/gpu/drm/lima/lima_sched.c b/drivers/gpu/drm/lima/lima_sched.c
> > index e6cefda00279..1602985dfa04 100644
> > --- a/drivers/gpu/drm/lima/lima_sched.c
> > +++ b/drivers/gpu/drm/lima/lima_sched.c
> > @@ -503,8 +503,9 @@ int lima_sched_pipe_init(struct lima_sched_pipe *pipe, const char *name)
> >
> >       INIT_WORK(&pipe->recover_work, lima_sched_recover_work);
> >
> > -     return drm_sched_init(&pipe->base, &lima_sched_ops, 1, 0,
> > -                           msecs_to_jiffies(timeout), name);
> > +     return drm_sched_init(&pipe->base, &lima_sched_ops, 1,
> > +                           lima_job_hang_limit, msecs_to_jiffies(timeout),
> > +                           name);
> >   }
> >
> >   void lima_sched_pipe_fini(struct lima_sched_pipe *pipe)
> >
>
> --
> Andrey Lebedev aka -.- . -.. -.. . .-.
> Software engineer
> Homepage: http://lebedev.lt/
