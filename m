Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 7C052C35247
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:41:52 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 550A5214AF
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:41:52 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="EvstfC2C"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727872AbgBFSlv (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 13:41:51 -0500
Received: from mail-il1-f194.google.com ([209.85.166.194]:39004 "EHLO
        mail-il1-f194.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1726990AbgBFSlv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 13:41:51 -0500
Received: by mail-il1-f194.google.com with SMTP id f70so6049634ill.6
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 10:41:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rvfv9s/3mm0fiIdqT4gq2TIV6qswfw3gcSHxln5Qesg=;
        b=EvstfC2C+SB/UiURgygiLq5HrwrbptH4mgesLSEhapDxG97zndtPhgViZiqgl4Glmp
         sGqdACNG2iQfQgQz6LVZdzHl/uPm3O6aRtkKfZngKCMJKvttmKl3/csBAjlcy97CCS5U
         0W8n6coud4RguAe6BS9SOmXB2QRPd0cvK9qNM1uSouk7DX5yDlOK6HHuTs4Sk7rCCfmw
         Lr9vfKxVcDSLGXyGeyHF1oemrcenaY7RNXhhute37l/qxRI5mPORFGiUnUE/5//QI1A1
         dBcRyC/KgLgBtg7iPUKkY7Q7OAcBTtTKy05hxRB44vBxv5m5pUZzdVW/1n/upw3isDoc
         9vGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rvfv9s/3mm0fiIdqT4gq2TIV6qswfw3gcSHxln5Qesg=;
        b=c8vZtiMa278h8gAQPC5VzHRq5e6GeDiau6SEc1TvBvSE6xZ747Q0trcmBEU9j0Glor
         649bPr9AVsIEB1kwCqojP/i+fwy+nH1YPAm3vbFVAj7KiQWYnBPDAK8hqhkxlVfPubBI
         G1M23ERWjMW0jLjj4BbAl0xM9sW7SufjORwi/jx9WU/a55Ami1PxtTwDlrdtCmhk12iM
         4QJbz7wSVkLHOiFUw4mIXOcOm2lixBkXZilNihNwbWKumN/ThbIMnnaZyFZf3OS+MLQH
         JnFPn3Coq+2swXy2u/Zo6MHqKWE8liYa4POwGXGcI2vo4utiDAxNgQGELUzQGUfAda9C
         eGDg==
X-Gm-Message-State: APjAAAXePlHi1X52zz3ybcM02WVerxiUosFXG7/Nxg/I8pLz+nNyzBpq
        8D5nG8ayoiz1vWX9gBneoA9Y0YAEXdmj2QVIDXg=
X-Google-Smtp-Source: APXvYqw/HdiF1QLiDq8FBR9ivWT4hH47VQKvqmRG8CV2Fh4h6/Y5ruVY2lyZwJyJBSbPZCdA81XhI1OmVffIWLIcKNI=
X-Received: by 2002:a92:84ce:: with SMTP id y75mr5203539ilk.93.1581014510574;
 Thu, 06 Feb 2020 10:41:50 -0800 (PST)
MIME-Version: 1.0
References: <20200205105955.28143-1-kraxel@redhat.com> <20200205105955.28143-5-kraxel@redhat.com>
 <CAPaKu7RxijC_oS4GPukS9wEe9gn8DPQgaGZKwG6g8M8xwTnsig@mail.gmail.com> <20200206085540.pa6py4ieoi242gma@sirius.home.kraxel.org>
In-Reply-To: <20200206085540.pa6py4ieoi242gma@sirius.home.kraxel.org>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Thu, 6 Feb 2020 10:41:39 -0800
Message-ID: <CAPaKu7RDZYnpjFB-Vou0RwiDGCxrD4ak2vLEf89UupdYm59ZYw@mail.gmail.com>
Subject: Re: [PATCH 4/4] drm/virtio: move virtio_gpu_mem_entry initialization
 to new function
To:     Gerd Hoffmann <kraxel@redhat.com>
Cc:     ML dri-devel <dri-devel@lists.freedesktop.org>,
        Gurchetan Singh <gurchetansingh@chromium.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        "open list:VIRTIO GPU DRIVER" 
        <virtualization@lists.linux-foundation.org>,
        open list <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Sender: linux-kernel-owner@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 6, 2020 at 12:55 AM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
>   Hi,
>
> > >         virtio_gpu_cmd_resource_attach_backing(vgdev, obj->hw_res_handle,
> > > -                                              ents, nents,
> > > +                                              obj->ents, obj->nents,
> > >                                                fence);
> > > +       obj->ents = NULL;
> > > +       obj->nents = 0;
> > Hm, if the entries are temporary, can we allocate and initialize them
> > in this function?
>
> Well, the plan for CREATE_RESOURCE_BLOB is to use obj->ents too ...
Is obj->ents needed after CREATE_RESOURCE_BLOB?  If not, having yet
another helper

  ents = virtio_gpu_object_alloc_mem_entries(..., &count);

seems cleaner.  We would also be able to get rid of virtio_gpu_object_attach.

>
> cheers,
>   Gerd
>
