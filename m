Return-Path: <SRS0=Cjtw=7V=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS,
	URIBL_BLOCKED autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 524AFC433DF
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:39:03 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.kernel.org (Postfix) with ESMTP id 242B6206D5
	for <linux-kernel@archiver.kernel.org>; Mon,  8 Jun 2020 19:39:03 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="Uw7ae4K+"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1726568AbgFHTjC (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Mon, 8 Jun 2020 15:39:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726406AbgFHTjB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Jun 2020 15:39:01 -0400
Received: from mail-lj1-x242.google.com (mail-lj1-x242.google.com [IPv6:2a00:1450:4864:20::242])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8ECD8C08C5C2
        for <linux-kernel@vger.kernel.org>; Mon,  8 Jun 2020 12:39:01 -0700 (PDT)
Received: by mail-lj1-x242.google.com with SMTP id s1so22048525ljo.0
        for <linux-kernel@vger.kernel.org>; Mon, 08 Jun 2020 12:39:01 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TVOtxpmeYOWD7rcQA6p6PVJsdwW/9XtVAfJ00067Jwk=;
        b=Uw7ae4K+D9tmeKHdEU38WOe4FsdhXp1ZnKr7YKUGixiQ9oWe2zUkZdxYWRFL5TGsGn
         +V9y94pvG0g5IXdQ2s4+PKu/NvK9GfJ5zCE2bQeGG95W+5y0fJ2+gTsk4k83rf03ItCJ
         kLC6qXpWbigmmVckNhVl6m270lucklRJQLrGoqZmdnWFsJKpGVxCkW4TqmwNSvOiG1BH
         d7soMSphupowplBAdx0AqVYwm0rmW0kE6W5xrmEBYPj5QQ0rsZtXxPEdj4xYSsQtECzW
         Nrs4lqroRuljEnV+wdWyUPdWz7xp5vspC1+LTQ3C15/rCfKQ54OQWj3k6b8s7vujTbBm
         A2bQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TVOtxpmeYOWD7rcQA6p6PVJsdwW/9XtVAfJ00067Jwk=;
        b=M26xQn0F0QSW0mcaBOjor13zpzdOIYwq7ceAR/fMnyLMIyJb2LjSq5sVrodd3DfMtU
         i60jUTwQjU/jEH0NXa0FeNAQ+DvjLaUuidSMwVRerq1MehE3RoDUAXcbGYxgcHDRKnwE
         QRU0yYF7xiEU1g12/fDd+M4vVx44h4fZdfaP0aPtV0sOPCve41AQ980PmASKSw8zhuS9
         Duat6cyPa0Hmdil0w2bvVWVuwuCP+F3FlvFEefJLbP4Ja/YSmXW/ceQTIkUBE6VvZ2TJ
         58njeb+vuxCqVFirpnNJ/fkca8l6OEaoPo3x27qsSHQ0AL5f3imTDVi+qpMNxSkG9lrs
         dXWw==
X-Gm-Message-State: AOAM531BeXxG+kF60UGhxuqsFvoQxisS6qW42zEM4CSaE/XcqwO2hDD2
        er4/kh6GELreOQqUcUelgCp2zn0uEtNbDbqREJU=
X-Google-Smtp-Source: ABdhPJzj7F/aaSi7HE9SPJMq1V4yr6hfoXBgPhFqPh91CbbkatR/Ryqmnw/QWzidGESYaRxTEW2Cmw1bqOyx6OoorZ0=
X-Received: by 2002:a2e:9147:: with SMTP id q7mr12642562ljg.430.1591645140048;
 Mon, 08 Jun 2020 12:39:00 -0700 (PDT)
MIME-Version: 1.0
References: <1590526802-3008-1-git-send-email-jrdr.linux@gmail.com>
 <69a033cf-63b2-7da6-6a5e-a5bbc94b8afb@nvidia.com> <20200527084852.GN206103@phenom.ffwll.local>
 <20200527085117.GO206103@phenom.ffwll.local> <aaf62285-981e-3753-5501-07bbba98fc36@nvidia.com>
 <CAFqt6zZVAQ3LKwud85LgHe9300xVjyGYXjvdWKTdezZA1uRewg@mail.gmail.com> <011353ca-39d5-a41d-477a-f67a47ebb47b@nvidia.com>
In-Reply-To: <011353ca-39d5-a41d-477a-f67a47ebb47b@nvidia.com>
From:   Souptick Joarder <jrdr.linux@gmail.com>
Date:   Tue, 9 Jun 2020 01:08:48 +0530
Message-ID: <CAFqt6zZPh6RazWcwmfz1oXMbHaxMOtQtVU=Cgs79M9JG+PDrSg@mail.gmail.com>
Subject: Re: [PATCH] drm/radeon: Convert get_user_pages() --> pin_user_pages()
To:     John Hubbard <jhubbard@nvidia.com>
Cc:     "Deucher, Alexander" <alexander.deucher@amd.com>,
        =?UTF-8?Q?Christian_K=C3=B6nig?= <christian.koenig@amd.com>,
        "Zhou, David(ChunMing)" <David1.Zhou@amd.com>,
        amd-gfx@lists.freedesktop.org,
        dri-devel <dri-devel@lists.freedesktop.org>,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, May 29, 2020 at 12:58 PM John Hubbard <jhubbard@nvidia.com> wrote:
>
> On 2020-05-28 23:49, Souptick Joarder wrote:
> ...
> >> This is what case 3 was *intended* to cover, but it looks like case 3 needs to
> >> be written a little better. I'll attempt that, and Cc you on the actual patch
> >> to -mm. (I think we also need a case 5 for an unrelated scenario, too, so
> >> it's time.)
> >
> > There were no *case 5* in the other patch posted in -mm. Do we need to add it ?
> >
>
> Working on figuring that out [1], but it's not directly relevant to this thread.
> Maybe I shouldn't have brought it up here. :)
>
>
> [1] https://lore.kernel.org/r/20200529070343.GL14550@quack2.suse.cz
>
> thanks,
> John Hubbard
> NVIDIA
>
>
>

As this conversion is not relevant ( mentioned above), I have dropped
this patch.
