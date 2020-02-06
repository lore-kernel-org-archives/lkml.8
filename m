Return-Path: <SRS0=za8s=32=vger.kernel.org=linux-kernel-owner@kernel.org>
X-Spam-Checker-Version: SpamAssassin 3.4.0 (2014-02-07) on
	aws-us-west-2-korg-lkml-1.web.codeaurora.org
X-Spam-Level: 
X-Spam-Status: No, score=-0.6 required=3.0 tests=DKIM_SIGNED,DKIM_VALID,
	DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
	HEADER_FROM_DIFFERENT_DOMAINS,MAILING_LIST_MULTI,SPF_HELO_NONE,SPF_PASS
	autolearn=no autolearn_force=no version=3.4.0
Received: from mail.kernel.org (mail.kernel.org [198.145.29.99])
	by smtp.lore.kernel.org (Postfix) with ESMTP id 76992C33CAC
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:32:51 +0000 (UTC)
Received: from vger.kernel.org (vger.kernel.org [209.132.180.67])
	by mail.kernel.org (Postfix) with ESMTP id 4E2A520659
	for <linux-kernel@archiver.kernel.org>; Thu,  6 Feb 2020 18:32:51 +0000 (UTC)
Authentication-Results: mail.kernel.org;
	dkim=pass (2048-bit key) header.d=gmail.com header.i=@gmail.com header.b="C78D79JR"
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1727897AbgBFScu (ORCPT
        <rfc822;linux-kernel@archiver.kernel.org>);
        Thu, 6 Feb 2020 13:32:50 -0500
Received: from mail-il1-f196.google.com ([209.85.166.196]:45067 "EHLO
        mail-il1-f196.google.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1727358AbgBFScu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 6 Feb 2020 13:32:50 -0500
Received: by mail-il1-f196.google.com with SMTP id p8so5969763iln.12
        for <linux-kernel@vger.kernel.org>; Thu, 06 Feb 2020 10:32:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20161025;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=eo58tkWzFG+QPveuoUYzk/xbxuvYMBHe+JEnvPAZ8SM=;
        b=C78D79JR83iHMAAwItqMeFqfF5QI77M9CbRJ/PUHuwKelJmXyB2Uq+2AL/wLJk3HW7
         zHtgI1OKexik0fFwZH7tQUXNcV9p78bpIFM7vzfxR1Ci9JUjSc3BqjVX89L3M7a6a/bU
         S9Wc8qrkJITb4TgIARKEOeHpPj/L3fol7twHTJiSNKs53NssrvzxxEpygWOavTHxU6/V
         lLl+QqnUQdsWlB8uRUDwz3EY6Qiz4tQtRIAp3sGBr2cUkSv7P2umSXqawyizmhhoolrd
         u/ZgBSoJLfeIY/9yzrTHXYAaUNRddrgtP2fxDoOhYosRi0W7rd5Px9eFfZTE9blQM47r
         T9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20161025;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=eo58tkWzFG+QPveuoUYzk/xbxuvYMBHe+JEnvPAZ8SM=;
        b=m53SHvHvuD4thE/wP/wHcv1Hw7s/0+L9AFXNCcHmH7A9PKCJHlsNDBKedrewGEU4/c
         oc1ddISvyYcjLvQo85BNZY5vias2kLC2njfup5fCRq7QMXdw4jax7skP4uG/YLN9ucO0
         t2cGBRpuYytMPowpndjjpk/4UVnjKle2yWUQKAnjypEW/AuQ+Bw97mI47fSc/NknBMWY
         4Vsfqiym+EUjG3MtpCWrMUvReqfp4epHora+3FUW4nURZBFEr5Utl043mxzoKmgRemTM
         UIQB1xkPKz7LGTVUwO9Xo9a5lCf6c7C3F4vnts+b55FieeWlOIckazErDoGxFhkfYC/o
         sHgA==
X-Gm-Message-State: APjAAAVV+C1ooulQGi1Z8AV+DdeC8heHFEQKobH46nul0AG3xxA6Ldu1
        SizYiFmliyqe8XDLgqwL9+zJ58YEv6MubCA0yZijahE+
X-Google-Smtp-Source: APXvYqwCwRuEwlR45CzsvgbiELUaIE5822wDHqy5FFXZa8qhVDAli6WE/pbnGUoZZnSZCnYk433yOCAV900RWp3C6rA=
X-Received: by 2002:a92:4a0a:: with SMTP id m10mr5427074ilf.84.1581013969410;
 Thu, 06 Feb 2020 10:32:49 -0800 (PST)
MIME-Version: 1.0
References: <20200205105955.28143-1-kraxel@redhat.com> <20200205105955.28143-3-kraxel@redhat.com>
 <CAPaKu7SCk_3yeTtzFTTU_y-tyo8EDS7vR8i+mk829=0D-UjLQA@mail.gmail.com> <20200206064338.badm6ijgyo2p5mmc@sirius.home.kraxel.org>
In-Reply-To: <20200206064338.badm6ijgyo2p5mmc@sirius.home.kraxel.org>
From:   Chia-I Wu <olvaffe@gmail.com>
Date:   Thu, 6 Feb 2020 10:32:38 -0800
Message-ID: <CAPaKu7S0E7Dm66UMkxb+3cwXuX3EXggFD0w66fv8exH4cQH==Q@mail.gmail.com>
Subject: Re: [PATCH 2/4] drm/virtio: resource teardown tweaks
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

On Wed, Feb 5, 2020 at 10:43 PM Gerd Hoffmann <kraxel@redhat.com> wrote:
>
> > > -
> > > -       drm_gem_shmem_free_object(obj);
> > > +       if (bo->created) {
> > > +               virtio_gpu_cmd_unref_resource(vgdev, bo);
> > > +               /* completion handler calls virtio_gpu_cleanup_object() */
> > nitpick: we don't need this comment when virtio_gpu_cmd_unref_cb is
> > defined by this file and passed to virtio_gpu_cmd_unref_resource.
>
> I want virtio_gpu_cmd_unref_cb + virtio_gpu_cmd_unref_resource being
> placed next to each other so it is easier to see how they work hand in
> hand.
>
> > I happen to be looking at our error handling paths.  I think we want
> > virtio_gpu_queue_fenced_ctrl_buffer to call vbuf->resp_cb on errors.
>
> /me was thinking about that too.  Yes, we will need either that,
> or a separate vbuf->error_cb callback.  That'll be another patch
> though.
Or the new virtio_gpu_queue_ctrl_sgs can return errors rather than
eating errors.

Yeah, that should be another patch.
>
> > > +       /*
> > > +        * We are in the release callback and do NOT want refcount
> > > +        * bo, so do NOT use virtio_gpu_array_add_obj().
> > > +        */
> > > +       vbuf->objs = virtio_gpu_array_alloc(1);
> > > +       vbuf->objs->objs[0] = &bo->base.base
> > This is an abuse of obj array.  Add "void *private_data;" to
> > virtio_gpu_vbuffer and use that maybe?
>
> I'd name that *cb_data, but yes, that makes sense.
Sounds great.
>
> cheers,
>   Gerd
>
